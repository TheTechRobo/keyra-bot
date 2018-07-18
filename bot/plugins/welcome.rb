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

          if m.user.nick != bot.nick && m.user.nick =~ /(EliveWeb)/
            if m.user.online
              #sleep 2
              m.reply "welcome #{m.user.nick}! Ask your question! Have you see the new amazing forums too? http://forum.elivelinux.org , the are gorgeous! =)"
            end
          else

            if m.user.nick != bot.nick && m.user.nick =~ /(Elive_user)/
              sleep 2
              if m.user.online
                m.reply "welcome to Elive, #{m.user.nick}! =)"
              end

              sleep 6
              if m.user.online
                m.reply "how is your experience with Elive so far? any suggestion or issue to report us? your feedbacks are important for improve Elive for everybody! try also the new amazing forums! https://forum.elivelinux.org"
              end

            else

              if m.user.nick != bot.nick && m.user.nick =~ /(Elive_inst)/
                sleep 2
                if m.user.online
                  m.reply "welcome to the Elive world, #{m.user.nick}! =) I hope you are enjoying the system!"
                end
                sleep 6
                if m.user.online
                  m.reply "You can find the amazing Elive community on this new BETA Forum website! https://forum.elivelinux.org , BTW press control-s to set your nickname here :)"
                end
              end
            end

          end
        end
      end

    end
  end
end
