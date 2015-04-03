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
            m.reply "welcome #{m.user.nick}! If you have any problem running Elive please report it to http://bugs.elivecd.org so we can assist and having you notified about it easier. You can also talk to Prince-AMD or Thanaterme-sis users"
          else
            if m.user.nick != bot.nick && m.user.nick =~ /(Elive_user)/
              m.reply "welcome to Elive, #{m.user.nick}! =)"
            else
              # Reply !
              m.reply "welcome #{m.user.nick} =)"
            end
          end

        end
      end

    end
  end
end
