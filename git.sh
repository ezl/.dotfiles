#!/bin/sh

git config --global color.ui "auto"
git config --global color.diff "auto"
git config --global color.status "auto"
git config --global color.branch "auto"
git config --global user.name "ezl"
git config --global user.email "ericzliu@gmail.com"
git config --global core.excludesfile "$HOME/.gitexcludes"
git config --global push.default matching
