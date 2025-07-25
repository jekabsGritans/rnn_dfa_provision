#!/bin/bash
LOG=/workspace/provision.log

# Start a fresh log
echo "=== Provision script started: $(date -u) ===" > "$LOG"

# Launch all the heavy lifting inside tmux, with output redirected to our log
tmux new-session -d -s aim bash -lc "\
  {
    echo '---- Inside tmux: $(date -u) ----'
    git config --global credential.helper store
    echo \"https://jekabsgritans:\${REPO_PAT}@github.com\" > ~/.git-credentials
    chmod 600 ~/.git-credentials
    sudo apt update && sudo apt install -y neovim
    cd /workspace
    git clone https://github.com/jekabsGritans/rnn_dfa.git
    cd rnn_dfa
    source /venv/main/bin/activate
    pip install --upgrade setuptools
    ./setup.sh
    aim init
    aim up --host 0.0.0.0
    echo '---- tmux session finished (or crashed) at: ' \$(date -u)
  } >> \"$LOG\" 2>&1
"

echo "=== Provision script dispatched tmux at: $(date -u) ===" >> "$LOG"
echo "You can attach with: tmux attach -t aim" >> "$LOG"


