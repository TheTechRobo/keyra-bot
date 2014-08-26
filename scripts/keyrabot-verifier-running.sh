#!/bin/bash

# This script is meant to be used in a cronjob each hour, to verify that the bot is running
main(){
    if ! ps aux | grep -v grep | grep -qs "ruby ../bot/keyrabot.rb" ; then
        "$HOME/keyra-bot/scripts/keyrabot-daemon.sh"
    fi
}

#
#  MAIN
#
main "$@"

# vim: set foldmethod=marker :
