#!/bin/bash
main(){
    # pre {{{
    local var

    mkdir -p "$HOME/keyra/bot"
    mkdir -p "$HOME/keyra/database"

    # }}}

    while true
    do
        # we need to run it from his directory itself, in order to save files in its databases
        cd "$HOME/keyra-bot/database"

        # run the bo
        "$HOME/keyra-bot/bot/keyrabot.rb"

        # bot died by any unknown reason ? wait a bit and run it again
        sleep 30
    done
}

#
#  MAIN
#
main "$@"

# vim: set foldmethod=marker :
