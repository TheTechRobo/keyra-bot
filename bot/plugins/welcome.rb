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
            m.reply "welcome #{m.user.nick}! If you have any problem with Elive just talk to Thanatermesi if is here or report it to http://bugs.elivecd.org to better assist and having you notified about it easier."
          else

            if m.user.nick != bot.nick && m.user.nick =~ /(Elive_user)/
              m.reply "welcome to Elive, #{m.user.nick}! =)"
              sleep 8
              m.reply "how is your experience with Elive so far? any suggestion or issue to report us so we can make it better? for a direct assistance just talk to Thanatermesi or use http://bugs.elivecd.org , your feedbacks is important for improve Elive and your reports are for the correct work for everybody!"
            else

              if m.user.nick != bot.nick && m.user.nick =~ /(Elive_inst)/
                m.reply "welcome to the Elive world, #{m.user.nick}! =) we hope you enjoy this system"
                sleep 8
                m.reply "if you have any suggestion or issue to report just tell us, so we can make even better this system for everybody! you can also use http://bugs.elivecd.org  Oh btw! press control-s to set your real nickname :)"
                # Reply !
                m.reply "welcome #{m.user.nick} =)"
              end
            end

          end
        end
      end

    end
  end
end
