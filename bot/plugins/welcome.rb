# This plugin simply says welcome to new connected users

module Cinch
  module Plugins
    class Welcome
      include Cinch::Plugin

      listen_to :connect,            :method => :listen
      listen_to :join,               :method => :listen


      def listen(m)
        # don't welcome keyra herself
        if m.user.nick != bot.nick && m.user.nick !~ /(ThanaRepo|EliveCode|Thanatermesis|PrinceAMD)/
          # give some humanity:
          sleep 5

          if m.user.nick != bot.nick && m.user.nick =~ /(EliveWeb)/
            if m.user.online
              m.reply "welcome #{m.user.nick}! If you have any problem with Elive just talk to Thanatermesi if is here or report it to http://bugs.elivecd.org to better assist and having you notified about it easier."
            end
          else

            if m.user.nick != bot.nick && m.user.nick =~ /(Elive_user)/
              if m.user.online
                m.reply "welcome to Elive, #{m.user.nick}! =)"
              end
              sleep 8
              if m.user.online
                m.reply "how is your experience with Elive so far? any suggestion or issue to report us so we can make it better? for a direct assistance just talk to Thanatermesi or use http://bugs.elivecd.org , your feedbacks is important for improve Elive and your reports are for the correct work for everybody!"
              end
            else

              if m.user.nick != bot.nick && m.user.nick =~ /(Elive_inst)/
                if m.user.online
                  m.reply "welcome to the Elive world, #{m.user.nick}! =) we hope you enjoy this system"
                end
                sleep 8
                if m.user.online
                  m.reply "if you have any suggestion or issue to report just tell us, so we can make even better this system for everybody! you can also use http://bugs.elivecd.org  Oh btw! press control-s to set your real nickname :)"
                end
              end
            end

          end
        end
      end

    end
  end
end
