function pwt --wraps='PWDEBUG=1 HEADED=1 dotnet test --filter FullyQualifiedName~' --description 'alias pwt PWDEBUG=1 HEADED=1 dotnet test --filter FullyQualifiedName~'
  RECORD_TRACE_DIR=$(pwd)/../_traces \
      FORCE_TRACE=1 \
      dotnet test -s .runsettings --filter FullyQualifiedName~$argv; 
end
