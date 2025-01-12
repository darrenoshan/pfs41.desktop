#!/usr/bin/env bash

cmd="gsettings set org.gnome.desktop.background picture-uri"
mkdir -p ~/Pictures/my.wallpapers
pics=`ls -l ~/Pictures/my.wallpapers/* 2> /dev/null | wc -l`
if [ "$pics" -lt "1" ] ; then
echo -e "--- Error ---\nNo Pictures found in:"
echo "$HOME/Pictures/my.wallpapers/"
echo "--- Exiting ---"
exit
fi
for pic in $HOME/Pictures/my.wallpapers/* ; do
echo $pic
done | shuf -n1 | xargs gsettings set org.gnome.desktop.background picture-uri
for pic in $HOME/Pictures/my.wallpapers/* ; do
echo $pic
done | shuf -n1 | xargs gsettings set org.gnome.desktop.background picture-uri-dark

