#!/usr/bin/env ruby
require 'cinch'
require 'yaml'

# Plugins
#require_relative "plugins/identify.rb"
require_relative "plugins/yamlscore.rb"
require_relative "plugins/yamlmemo.rb"
require_relative "plugins/yamlkeywords.rb"
#require_relative "plugins/remind.rb"
#require "cinch/plugins/urlscraper"

require_relative "plugins/plugin_management.rb"


bot = Cinch::Bot.new do
    configure do |c|
        c.ping_interval = 340
        #c.plugins.prefix = "!"

        # You can set these details here or in an external file too, which will be not tracked by git
        account = YAML.load_file '../database/account.yaml'

        c.server = "irc.freenode.org"
        c.channels = ["#elive-bots"]

        #c.user = "superkeyra2"
        c.user = account['user']
        c.realname = account['user']
        c.nick = account['user']

        # if you need to identify with pass your user-bot, see https://github.com/cinchrb/cinch-identify
        # Note: atm it doesnt seems to call nickserv for identify itself, so lets disable it for now
        #c.plugins.plugins = [Cinch::Plugins::Identify]
        #c.plugins.options[Cinch::Plugins::Identify] = {
            #:username => account['user'],
            #:password => account['pass'],
            #:type     => :nickserv,
        #}


        #
        # Plugins:
        #
        # user, +1
        c.plugins.plugins = [Cinch::Plugins::YamlScore]
        # The following line is optional, if committed there will be no message.
        #c.plugins.options[Cinch::Plugins::YamlScore] = { warn_no_user_message: "User %s is not in the channel, who do you want to score?" }

        # !memo user message
        c.plugins.plugins = [Cinch::Plugins::YamlMemo]

        #!keywords                         # list all definitions
        #!keyword? <keyword>               # show single definition
        #!keyword  <keyword>  <definition> # define without spaces
        #!keyword '<keyword>' <definition> # define with spaces
        #!keyword "<keyword>" <definition> # define with spaces
        #!forget   <keyword>               # remove definition
        #<keyword>                         # display definition
        c.plugins.plugins = [Cinch::Plugins::YamlKeywords]

        # just paste an url in the channel
        # note: it uses some amount of RAM, instead of 1.8 % it goes to 4.5 %
        #c.plugins.plugins = [Cinch::Plugins::UrlScraper]

        # Remind plugin: Warning: it bugs, see the source code comments of the plugin
        #c.plugins.plugins = [Cinch::Plugins::Remind]

        # plugin management plugin, useful for reload the plugin without reconnect the bot
        # !plugin reload YamlKeywords
        c.plugins.plugins = [Cinch::Plugins::PluginManagement]
    end

end

bot.start
