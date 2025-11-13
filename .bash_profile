#!/bin/bash

if [ -f ~/.profile ]; then . ~/.profile; fi

# See https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html#Invoked-as-an-interactive-non_002dlogin-shell
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

. "$HOME/.cargo/env"
