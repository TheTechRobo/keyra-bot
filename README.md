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

- **Scores**: Just a small plugin for give scores to the users


Run it!
=======

First you should install the required gems as user (recommended):

    gem install --user-install cinch

You may optionally install other dependencies too like ruby-yaml

Then just run the scripts/ for each purpose


How to use:
===========

Reminders
---------
This is an example:

    [21:30:01] <Thanatermesis> remind me about pizza! in 1 min
    [21:30:02]        <keyra2> Thanatermesis: don't worry! I will remind you about "pizza!" in 1 min
    [21:31:01]        <keyra2> Thanatermesis: pizza!

The bot will take care of that for you and will tell you want you need to remember when the time has passed
You can use a very english language that it should understand it, for example:

    hey john, can you remind me about my pizza is going to burn in 1 hour ?

The 'regex' syntax that you can use is something like:

    /(.*)remind (us|me|#[^ ]*) (?:about|to|that) (.*) (?:(in) ([0-9]+) (min(?:ute(s|)|s)?|hour(?:s)?))/i

Note: the reminders are not saved in any database, if the bot restarts, they will be forgotten
**WARNING:** This plugin is by default disabled due to a bug, see Issues



Automatic Reply's
-----------------
This feature is very simple and doesn't require to call the bot at all, if somebody says a word that is listed on his database, which you can add/modify entries manually editing the file (requires restart) or interactively from the bot channel, the bot will answer what you need to know about.

Example:

    <Elive_user2> Where i can get the experimental beta installer???
    <keyra> this beta installer is already finished, you should download a newer version of Elive which you can directly install

Interactive commands:

    !keywords                         # list all definitions
    !keyword? <keyword>               # show single definition
    !keyword  <keyword>  <definition> # define without spaces
    !keyword '<keyword>' <definition> # define with spaces
    !keyword "<keyword>" <definition> # define with spaces
    !forget   <keyword>               # remove definition
    <keyword>                         # display definition

Note: the database is stored in a plain-text yaml file, which is saved among restarts and ages



Collaborate
-----------
You are more than welcome to fork the bot and improve it, if this doesn't change his behaviour or the resources needed I should not have any problem to pull the requests :)

Credits
-------
This plugin is made mostly from other's code, cinch and cinch plugins, specially from mpapis user, thanks to all of them
I have put all the plugins inside a single git tree without tracking the original sources since they are meant to be complete or simply useful, for simplicity, time, and ability to modify things more easly
