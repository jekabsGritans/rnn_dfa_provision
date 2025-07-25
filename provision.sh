#!/bin/bash
echo "Script running" > /workspace/test.log

# Determine setup.sh arguments based on environment variables
SETUP_ARGS=""
if [ "${SKIP_CUGRAPH}" = "true" ] || [ "${SKIP_CUGRAPH}" = "1" ]; then
    SETUP_ARGS="--skip-cugraph"
fi

tmux new-session -d -s aim "bash -lc \"
  git config --global credential.helper store &&
  echo \\\"https://jekabsgritans:\${REPO_PAT}@github.com\\\" > ~/.git-credentials &&
  chmod 600 ~/.git-credentials &&
  sudo apt update && sudo apt install -y neovim &&
  cd /workspace &&
  git clone https://github.com/jekabsGritans/rnn_dfa.git &&
  cd rnn_dfa &&
  source /venv/main/bin/activate &&
  pip install --upgrade setuptools &&
  ./setup.sh ${SETUP_ARGS} &&
  aim init &&
  aim up --host 0.0.0.0
\""
