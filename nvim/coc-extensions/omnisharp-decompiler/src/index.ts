import {
  services,
  commands,
  ExtensionContext,
  window,
  LanguageClient,
  TextDocument,
  ProvideDefinitionSignature,
  CancellationToken,
  Position,
  Location,
  TypeDefinitionMiddleware,
  workspace,
  LanguageClientOptions,
} from 'coc.nvim';

function createMiddleware(client: LanguageClient) {
  const existingMiddleware = client.clientOptions.middleware?.provideDefinition;

  return {
    provideDefinition: async (
      document: TextDocument,
      position: Position,
      token: CancellationToken,
      next: ProvideDefinitionSignature
    ) => {
      const result = existingMiddleware
        ? await existingMiddleware(document, position, token, next)
        : await next(document, position, token);

      if (Location.is(result)) {
        const metadataUri = parseMetaUri(result.uri);

        if (metadataUri) {
          printMessage(
            `Metadata file detected: Project=${metadataUri.project} Assembly=${metadataUri.assembly} Symbol=${metadataUri.symbol}`
          );

          const metadataRequest = {
            Timeout: 5000,
            AssemblyName: metadataUri.assembly,
            ProjectName: metadataUri.project,
            TypeName: metadataUri.symbol,
          };

          const metadataResponse = await client.sendRequest('o#/metadata', metadataRequest);

          const source = metadataResponse.Source;
          const buffer = await workspace.nvim.createNewBuffer(false, true);
          buffer.setName(`METADATA`);
          await workspace.nvim.command(`buffer ${buffer.id}`);
          await buffer.setLines(source.split('\n'), { start: 0, end: -1, strictIndexing: false });
        }
      } else {
        printMessage(`TODO: handle this case when result is not Location`);
      }

      return result;
    },
  };
}

type MetadataUri = {
  project: string;
  assembly: string;
  symbol: string;
};

function parseMetaUri(uri: string | undefined): MetadataUri | undefined {
  if (!uri) {
    return undefined;
  }

  // TODO: test and fix on windows
  const parts = decodeURIComponent(uri).split('/');

  if (parts.length < 4 || parts[3] !== '$metadata$') {
    return undefined;
  }

  let tokenType: 'project' | 'assembly' | 'symbol' | 'unknown' = 'unknown';

  let project = new Array<string>();
  let assembly = new Array<string>();
  let symbol = new Array<string>();

  for (let i = 0; i < parts.length; i++) {
    let cur = parts[i];

    switch (cur) {
      case 'Project':
        tokenType = 'project';
        continue;
      case 'Assembly':
        tokenType = 'assembly';
        continue;
      case 'Symbol':
        tokenType = 'symbol';
        continue;
      default:
        switch (tokenType) {
          case 'project':
            project.push(cur);
            continue;
          case 'assembly':
            assembly.push(cur);
            continue;
          case 'symbol':
            symbol.push(cur);
            continue;
          default:
            continue;
        }
    }
  }

  return {
    project: project.join('.'),
    assembly: assembly.join('.'),
    symbol: symbol.join('.').replace(/\.cs$/g, ''),
  };
}

export async function activate(context: ExtensionContext): Promise<void> {
  //TODO: find solution by current file
  const solutionPath = workspace.rootPath + '/backend/Platforms.sln';
  const omnisharpLogger = window.createOutputChannel('omnisharp');

  const serverOptions = {
    command: 'dotnet',
    // SEE: https://github.com/OmniSharp/omnisharp-roslyn/blob/master/src/OmniSharp.Host/CommandLineApplication.cs
    args: [
      '/Users/dmitryivanov/omnisharp-osx-arm64-net6/OmniSharp.dll',
      '-s',
      solutionPath,
      '--loglevel',
      'trace',
      '--languageserver',
    ],
    options: { cwd: workspace.rootPath },
  };

  const clientOptions: LanguageClientOptions = {
    documentSelector: [{ pattern: '*.cs' }],
    outputChannel: omnisharpLogger,
  };

  let client = new LanguageClient('omnisharp', 'OmniSharp Language Server', serverOptions, clientOptions);
  context.subscriptions.push(services.registLanguageClient(client));

  // override behavior of LSP definition
  client.clientOptions.middleware = createMiddleware(client);

  context.subscriptions.push(
    commands.registerCommand('omnisharp-decompiler.hit', async () => {
      printMessage(`Commands works!`);
      debugger;
    })
  );

  context.subscriptions.push(client.start());

  printMessage('extension is activated');
  client.onReady().then(() => {
    omnisharpLogger.appendLine('LSP client is ready...');
    printMessage('LSP client is ready');
  });
}

function printMessage(text: string) {
  window.showMessage(`omnisharp: ${text}`);
}
