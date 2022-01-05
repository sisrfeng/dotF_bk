# tmux新开pane时，保留原来的conda环境
# 还没在tmux.config里bindkey
# -p: print to stdout
current_session=$(tmux display-message -p '#S')
current_conda=$CONDA_DEFAULT_ENV

tmux split-window -v -p 75 -b
tmux select-pane -t 1
tmux split-window -h -p 50

# -t : target pane/windows/session
tmux send-keys  -t "$current_session.0" "conda activate $current_conda" 'Enter';
tmux send-keys  -t "$current_session.1" "conda activate $current_conda" 'Enter';
tmux send-keys  -t "$current_session.2" "conda activate $current_conda" 'Enter';

tmux send-keys  -t "$current_session.0" "clear && figlet Welcome" 'Enter';
tmux send-keys  -t "$current_session.1" "clear" 'Enter';
tmux send-keys  -t "$current_session.2" "clear" 'Enter';
tmux rename-window "dev";

