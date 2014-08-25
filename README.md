keyra-bot
=========

IRC bot meant to be a useful tool to give FAQs to the users

It is very light (10-15 MB of RAM), in ruby using the CINCH bot framework

Features
========

- **Automatic reply's** based on keywords (regex featured) that the people will say in the channel
  - these messages are saved in a (yaml) plain file, which is very easy and fast to add new ones but specially modify existing messages, which is extremely more efficient than dealing with the bot online, by other side anybody can add and modify its messages interactively too, which makes it useful to learn new things.

- **Reminders**: simple feature that reminds you about something after a given time, it also detects when somebody wants to have a reminder

- **Memo's**: It gives messages to users when they connects back into the channel
