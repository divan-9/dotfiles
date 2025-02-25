function ]dt --wraps='dotnet test --filter FullyQualifiedName~' --description 'dotnet test --filter FullyQualifiedName~'
    if test (count $argv) -lt 1
      echo dotnet test -s .runsettings -- NUnit.NumberOfTestWorkers=1
      dotnet test -s .runsettings -p:DefineConstants="TRACE"
    else 
      echo HEADED=0 dotnet test --filter FullyQualifiedName~$argv[1]
      dotnet test -s .runsettings --filter FullyQualifiedName~$argv[1] -p:DefineConstants="TRACE"
    end
end
