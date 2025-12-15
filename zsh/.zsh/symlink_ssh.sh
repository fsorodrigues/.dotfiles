#!/usr/bin/env bash

WINDOWS_DIRECTORY="/mnt/c/Users/felippe.rodrigues/.ssh"
TARGET_DIRECTORY="$HOME/.ssh"
if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ] && ([ ! -L "$TARGET_DIRECTORY" ] || [ ! -e "$TARGET_DIRECTORY" ]);
then
  ln -s $WINDOWS_DIRECTORY $TARGET_DIRECTORY
  chmod 700 $HOME/.ssh
  chmod 600 $HOME/.ssh/*
fi
