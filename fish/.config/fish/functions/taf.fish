function taf -d "Attach or create tmux session named as the current directory"
  set path_name (basename "$PWD" | tr . -)
  if count $argv > /dev/null
    set session_name $argv[1]
  else
    set session_name $path_name
  end

  __create_if_needed_and_attach $session_name
end

function __not_in_tmux
  [ -z "$TMUX" ]
end

function __session_exists
  tmux list-sessions | sed -E 's/:.*$//' | grep -q "^$argv[1]\$"
end

function __create_detached_session
  env TMUX='' tmux new-session -Ad -s $argv[1]
end

function __create_if_needed_and_attach
  if __not_in_tmux
    tmux new-session -As $argv[1]
  else
    if ! __session_exists $argv[1] 
      __create_detached_session $argv[1]
    end
    tmux switch-client -t $argv[1]
  end
end

