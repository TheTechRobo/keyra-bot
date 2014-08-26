#!/bin/bash
main(){
    # pre {{{
    local sources_dir="$HOME/keyra-bot"

    mkdir -p "$sources_dir/database"

    # }}}

    while true
    do
        # we need to run it from his directory itself, in order to save files in its databases
        cd "$sources_dir/database"

        # run the bot
        "../bot/keyrabot.rb"

        # bot died by any unknown reason ? wait a bit and run it again
        sleep 20
    done
}

#
#  MAIN
#
main "$@"

# vim: set foldmethod=marker :
