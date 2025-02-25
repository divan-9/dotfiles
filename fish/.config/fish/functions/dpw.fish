function dpw --wraps='PWDEBUG=1 dotnet test' --description 'alias pw HEADED=1 dotnet test'
    if test (count $argv) -lt 1
      echo HEADED=1 dotnet test --no-restore -p:CollectCoverage=false -v=q --nologo --logger="console;verbosity=detailed" -- NUnit.DisplayName=FullName 
      PWDEBUG=1 dotnet test --no-restore -p:CollectCoverage=false -v=q --nologo --logger="console;verbosity=detailed" -- NUnit.DisplayName=FullName 
    else
      echo HEADED=1 dotnet test --filter FullyQualifiedName~$argv[1] --no-restore -p:CollectCoverage=false -v=q --nologo --logger="console;verbosity=detailed" -- NUnit.DisplayName=FullName
      PWDEBUG=1 dotnet test --filter FullyQualifiedName~$argv[1] --no-restore -p:CollectCoverage=false -v=q --nologo --logger="console;verbosity=detailed" -- NUnit.DisplayName=FullName
    end
end
