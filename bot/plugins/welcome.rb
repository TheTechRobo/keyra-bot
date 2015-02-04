# This plugin simply says welcome to new connected users

module Cinch
  module Plugins
    class Welcome
      include Cinch::Plugin

      listen_to :connect,            :method => :listen
      listen_to :join,               :method => :listen


      def listen(m)
        # don't welcome keyra herself
        if m.user.nick !=  bot.nick
          # give some humanity:
          sleep 5

          # Reply !
          m.reply "welcome #{m.user.nick} :)"

        end
      end

    end
  end
end
