"use strict";
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __export = (target, all) => {
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);

// src/index.ts
var src_exports = {};
__export(src_exports, {
  activate: () => activate
});
module.exports = __toCommonJS(src_exports);
var import_coc = require("coc.nvim");
function createMiddleware(client) {
  var _a;
  const existingMiddleware = (_a = client.clientOptions.middleware) == null ? void 0 : _a.provideDefinition;
  return {
    provideDefinition: async (document, position, token, next) => {
      const result = existingMiddleware ? await existingMiddleware(document, position, token, next) : await next(document, position, token);
      if (import_coc.Location.is(result)) {
        const metadataUri = parseMetaUri(result.uri);
        if (metadataUri) {
          const metadataRequest = {
            Timeout: 5e3,
            AssemblyName: metadataUri.assembly,
            ProjectName: metadataUri.project,
            TypeName: metadataUri.symbol
          };
          const metadataResponse = await client.sendRequest("o#/metadata", metadataRequest);
          const source = metadataResponse.Source;
          const buffer = await import_coc.workspace.nvim.createNewBuffer(false, true);
          buffer.name(metadataUri.fileName);
          await buffer.setLines(source.split("\n"), { start: 0, end: -1 });
          await buffer.setOption("filetype", "csharp");
          await buffer.setOption("buftype", "nofile");
          await buffer.setOption("modifiable", false);
          await buffer.setOption("readonly", true);
          import_coc.workspace.nvim.setBuffer(buffer);
          import_coc.workspace.nvim.command(`write! ${metadataUri.fileName}`);
          result.uri = metadataUri.fileName;
        }
      } else {
        printMessage(`TODO: handle this case when result is not Location`);
      }
      return result;
    }
  };
}
function parseMetaUri(uri) {
  if (!uri) {
    return void 0;
  }
  const normalizedUri = decodeURIComponent(uri);
  const parts = normalizedUri.split("/");
  if (parts.length < 4 || parts[3] !== "$metadata$") {
    return void 0;
  }
  let tokenType = "unknown";
  let project = new Array();
  let assembly = new Array();
  let symbol = new Array();
  for (let i = 0; i < parts.length; i++) {
    let cur = parts[i];
    switch (cur) {
      case "Project":
        tokenType = "project";
        continue;
      case "Assembly":
        tokenType = "assembly";
        continue;
      case "Symbol":
        tokenType = "symbol";
        continue;
      default:
        switch (tokenType) {
          case "project":
            project.push(cur);
            continue;
          case "assembly":
            assembly.push(cur);
            continue;
          case "symbol":
            symbol.push(cur);
            continue;
          default:
            continue;
        }
    }
  }
  const fileName = `/tmp/coc-omnisharp-metadata/${process.pid}/${normalizedUri.replace("file:///$metadata$/", "")}`;
  return {
    project: project.join("."),
    assembly: assembly.join("."),
    symbol: symbol.join(".").replace(/\.cs$/g, ""),
    fileName
  };
}
async function activate(context) {
  const solutionPath = import_coc.workspace.rootPath + "/backend/Platforms.sln";
  const omnisharpLogger = import_coc.window.createOutputChannel("omnisharp");
  const serverOptions = {
    command: "dotnet",
    // SEE: https://github.com/OmniSharp/omnisharp-roslyn/blob/master/src/OmniSharp.Host/CommandLineApplication.cs
    args: [
      "/Users/dmitryivanov/omnisharp-osx-arm64-net6/OmniSharp.dll",
      "-s",
      solutionPath,
      "--loglevel",
      "trace",
      "--languageserver"
    ],
    options: { cwd: import_coc.workspace.rootPath }
  };
  const clientOptions = {
    documentSelector: [{ pattern: "*.cs" }],
    outputChannel: omnisharpLogger
  };
  let client = new import_coc.LanguageClient("omnisharp", "OmniSharp Language Server", serverOptions, clientOptions);
  context.subscriptions.push(import_coc.services.registLanguageClient(client));
  client.clientOptions.middleware = createMiddleware(client);
  context.subscriptions.push(
    import_coc.commands.registerCommand("omnisharp-decompiler.hit", async () => {
      printMessage(`Commands works!`);
      debugger;
    })
  );
  context.subscriptions.push(client.start());
  printMessage("extension is activated");
  client.onReady().then(() => {
    omnisharpLogger.appendLine("LSP client is ready...");
    printMessage("LSP client is ready");
  });
}
function printMessage(text) {
  import_coc.window.showMessage(`omnisharp: ${text}`);
}
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {
  activate
});
