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

function __session_exists -a session_name
  tmux list-sessions | sed -E 's/:.*$//' | grep -q "^$session_name\$"
end

function __create_detached_session -a session_name
  env TMUX='' tmux new-session -Ad -s $session_name
end

function __create_if_needed_and_attach -a session_name
  if __not_in_tmux
    tmux new-session -As $session_name
  else
    if ! __session_exists $session_name 
      __create_detached_session $session_name
    end
    tmux switch-client -t $session_name
  end
end

function tss -d "Search and attach to a tmux session"
  tmux list-sessions | sed -E 's/:.*$//' | fzf --reverse | xargs tmux switch-client -t
end

