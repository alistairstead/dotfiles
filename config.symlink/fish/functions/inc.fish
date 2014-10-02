function inc --description 'Increase the value of variable' --no-scope-shadowing
  set $argv[1] (expr $$argv[1] + 1)
end
