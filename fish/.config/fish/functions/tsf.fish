function tsf -d "Search and attach to a tmux session"
  tmux list-sessions | sed -E 's/:.*$//' | grep -v '^'(tmux display-message -p "#S")'$' | fzf --reverse | xargs tmux switch-client -t
end

