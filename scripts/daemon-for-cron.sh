#!/bin/bash

bot_close(){
    # kill the script first
    killall keyrabot.sh

    #kill da bot
    kill "$( ps aux | grep -v grep | grep "ruby ../keyrabot.rb" | awk '{print $2}' | tail -1 )" 2>/dev/null
    kill "$( ps aux | grep -v grep | grep "ruby ../keyrabot.rb" | awk '{print $2}' | tail -1 )" 2>/dev/null
    kill -9 "$( ps aux | grep -v grep | grep "ruby ../keyrabot.rb" | awk '{print $2}' | tail -1 )" 2>/dev/null
}

bot_start(){
    "$HOME/keyra-bot/scripts/keyrabot.sh" 2>/dev/null 1>/dev/null &
}

main(){
    # always close it first
    bot_close

    bot_start

}

#
#  MAIN
#
main "$@"

# vim: set foldmethod=marker :
