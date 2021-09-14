#!/bin/sh

# Change mitmproxy wifi settings.
# Usage : zsh setup_mitmproxy.sh <switch> <port:Number>
if [ "$#" -eq 2 -a "$1" = "on" ]; then
  input=$2
  expr "$input" + 1 >&/dev/null
  ret=$?
  if [ $ret -lt 2 ];then
    networksetup -setwebproxy Wi-Fi "" $input
    networksetup -setsecurewebproxy Wi-Fi "" $input
    echo "U can use port :$input"
    exit 0
  else
    echo "ポートの指定が不正です。"
    echo "Usage : zsh setup_mitmproxy.sh on <Number>"
    exit 1
  fi
fi

if [ "$#" -eq 1 -a "$1" = "on" ]; then
  networksetup -setwebproxy Wi-Fi "" 8080
  networksetup -setsecurewebproxy Wi-Fi "" 8080
  echo "Using default port :8080"
elif [ "$#" -eq 1 -a "$1" = "off" ]; then
  networksetup -setwebproxystate Wi-fi off
  networksetup -setsecurewebproxystate Wi-fi off
  echo "ポートの設定を解除しました。"
else
  echo "Usage : zsh setup_mitmproxy.sh <on|off> (port:Number)"
  exit 1
fi
