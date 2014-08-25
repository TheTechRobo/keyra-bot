#!/usr/bin/env ruby
require 'cinch'

# Plugins
require "cinch/plugins/yamlscore"
require "cinch/plugins/yamlmemo"
require "cinch/plugins/yamlkeywords"
#require "cinch/plugins/urlscraper"
require "cinch/plugins/deploy"


# playing with getting a siri-style 'remind me about xyz in 5 hours / at 1 o clock / etc'
#$remind_pattern = /^(!|NB: )remind (us|me|#[^ ]*) (?:about|to) (.*) (?:(in) ([0-9]+) (min(?:ute(s|)|s)?|hour(?:s)?)|(at) (.*))$/i
$remind_pattern = /(.*)remind (us|me|#[^ ]*) (?:about|to) (.*) (?:(in) ([0-9]+) (min(?:ute(s|)|s)?|hour(?:s)?))/i


class Remind
    include Cinch::Plugin
    match $remind_pattern, :method => :remind, :use_prefix => false
    match /remind (us|me) (?:about|to) (.*)$/i, :method => :check_parsable, :use_prefix => false
    match /poll/, :method => :poll_reminders
    timer 15, method: :poll_reminders

    def initialize(*args)
	super
	@reminders = {}
    end

    def remind(m, *args)
	# [addressed, who-to-remind, about-what, in/nil, count/nil, unit/nil, human-timestamp]
	recipient = args[1]
	ack_recipient = recipient
	about = args[2]
	dowhen = {
	    :in => {:set => !args[3].nil?, :count => args[4], :unit => args[5]},
	    :at => {:set => !args[6].nil?, :human => args[7]}
	}
	prefix = ''

	if recipient == "us" && m.channel?
	    recipient = m.channel
	    ack_recipient = "this channel"
	elsif recipient == "us" && !m.channel?
	    dont_follow(m)
	    return
	elsif recipient == "me"
	    ack_recipient = "you"
	    if m.channel?
		recipient = m.channel
		prefix = m.user.to_s + ': ' if m.channel?
		about.gsub!(/\bmy\b/, 'your')
	    else
		recipient = m.user
	    end
	elsif @bot.channels.include?(recipient)
	    recipient = Channel(recipient)
	else
	    m.reply("Sorry, but I'm not in that channel.", :prefix => true)
	    return
	end

	dowhen = normalise_timestamp(dowhen)
	@reminders[dowhen] = {:recipient => recipient, :about => about, :prefix => prefix}

	#m.reply("I will remind #{ack_recipient} about \"#{about}\" at #{dowhen} (my time)", :prefix => true)
	m.reply("don't worry! I will remind #{ack_recipient} about \"#{about}\" in #{args[4]} #{args[5]}", :prefix => true)
    end

    def poll_reminders(*args)
	timenow = Time.now
	@reminders.keys.each do |ts|
	    if ts <= timenow
		@reminders[ts][:recipient].send(@reminders[ts][:prefix]+@reminders[ts][:about])
		@reminders.delete(ts)
	    end
	end
    end

    def check_parsable(m, *args)
	unless m.params[1].match($remind_pattern)
	    dont_follow(m)
	end
    end

    private

    def normalise_timestamp(abstract)
	puts abstract.inspect
	now = Time.now
	if abstract[:in][:set]
	    count = abstract[:in][:count].to_i
	    count *= 60
	    count *= 60 if abstract[:in][:unit] =~ /^hours?$/i
	    return Time.now + count
	elsif abstract[:at][:set]
	    case abstract[:at][:human]
	    when /^([1-9]|1[012])$/
		nh = now.hour 
		des_hour = abstract[:at][:human].to_i % 12
		if (nh % 12) >= des_hour
		    set_day = now.day + 1
		    set_hour = des_hour
		else
		    set_day = now.day
		    if nh >= 12
			set_hour = des_hour + 12
		    else
			set_hour = des_hour
		    end
		end
		return Time.local(now.year, now.month, set_day, set_hour, 0, 0)
	    end
	end
	false
    end

    def dont_follow(m)
	m.reply("Sorry, I don't quite understand the phrasing", :prefix => true)
    end
end

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
	c.channels = ["#elive-dev", "#elive"]
	#c.channels = ["#elive-bots"]
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
	
	# deploy
	c.plugins.options[Cinch::Plugins::Deploy] = {
	    users: "Thanatermesis",
	    channels: "#elive-dev",
	    trigger: "cmdtest",
	    command: "whoami",
	}

	#c.plugins.plugins = [Autotranslate]
	#c.plugins.plugins = [Cinch::Plugins::Autotranslate]
	c.plugins.plugins = [Remind]
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
