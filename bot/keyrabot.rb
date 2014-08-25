#!/usr/bin/env ruby
require 'cinch'

# Plugins
require_relative "plugins/yamlscore.rb"
require_relative "plugins/yamlmemo.rb"
require_relative "plugins/yamlkeywords.rb"
require_relative "plugins/remind.rb"
#
#require "cinch/plugins/urlscraper"
#require "cinch/plugins/deploy"


#class Autotranslate
#include Cinch::Plugin

#match /(.+)/, use_prefix: false

#def execute(m, query)
#m.reply "msg is: #{query}"
#end
#end


bot = Cinch::Bot.new do
    configure do |c|
        c.server = "irc.freenode.org"
        #c.channels = ["#elive-dev", "#elive"]
        c.channels = ["#elive-bots"]
        c.ping_interval = 340
        #c.plugins.prefix = "!"

        c.user = "superkeyra2"
        c.realname = "superkeyra2"
        c.nick = "superkeyra2"

        #
        # Plugins:
        #
        # user, +1
        c.plugins.plugins = [Cinch::Plugins::YamlScore]
        # The following line is optional, if committed there will be no message.
        #c.plugins.options[Cinch::Plugins::YamlScore] = { warn_no_user_message: "User %s is not in the channel, who do you want to score?" }

        # !memo user message
        #c.plugins.plugins = [Cinch::Plugins::YamlMemo]

        #!keywords                         # list all definitions
        #!keyword? <keyword>               # show single definition
        #!keyword  <keyword>  <definition> # define without spaces
        #!keyword '<keyword>' <definition> # define with spaces
        #!keyword "<keyword>" <definition> # define with spaces
        #!forget   <keyword>               # remove definition
        #<keyword>                         # display definition
        #c.plugins.plugins = [Cinch::Plugins::YamlKeywords]

        # just paste an url in the channel
        # note: it uses some amount of RAM, instead of 1.8 % it goes to 4.5 %
        #c.plugins.plugins = [Cinch::Plugins::UrlScraper]

        # deploy
        #c.plugins.options[Cinch::Plugins::Deploy] = {
        #users: "Thanatermesis",
        #channels: "#elive-dev",
        #trigger: "cmdtest",
        #command: "whoami",
        #}

        #c.plugins.plugins = [Autotranslate]
        #c.plugins.plugins = [Cinch::Plugins::Autotranslate]
        c.plugins.plugins = [Cinch::Plugins::Remind]
    end

    #on :message, /hello/ do |m|
    #m.reply "Hello, #{m.user.nick}, Welcome to Elive, Im a ruby bot (cinch), do you know RUBY? I need a master!"
    #end

    #on :message, /^!msg (.+?) (.+)/ do |m, who, text|
    #User(who).send text
    #end
    on :ban do |m, ban|
        m.reply "#{ban.by} well done!"
    end

    on :unban do |m, ban|
        m.reply "be more polite now!"
    end

    on :op do |m|
        m.reply "are you going to abuse me now?"
    end

    on :unaway do |m|
        m.reply "welcome back #{m.user}!"
    end
end

bot.start
