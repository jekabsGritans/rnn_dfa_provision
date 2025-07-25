#!/bin/bash

tmux new-session -d -s aim 'bash -lc "
  git config --global credential.helper store &&
  echo \"https://jekabsgritans:${REPO_PAT}@github.com\" > ~/.git-credentials &&
  chmod 600 ~/.git-credentials &&
  sudo apt update && sudo apt install -y neovim &&
  cd /workspace &&
  git clone https://github.com/jekabsGritans/rnn_dfa.git &&
  cd rnn_dfa &&
  source /venv/main/bin/activate &&
  pip install --upgrade setuptools &&
  ./setup.sh &&
  aim init &&
  aim up --host 0.0.0.0
"'

