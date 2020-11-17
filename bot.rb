require 'discordrb'
require 'json'

require_relative 'reactions'

credF = File.read('../luna-cred.json')
cred_hash = JSON.parse(credF)

bot = Discordrb::Bot.new token: cred_hash['token']


##            ##
##  Aliases   ##
##            ##
PREFIX = 'Luna, '
PREFIXL = PREFIX.length
react_message = 778392481950728234

YES_ARY = ["Yep!", "You Bet!", "For Sure!", "Always!"]
NO_ARY = ["No, Sorry", "Nope", "Sadly no", "Unfortunately not"]

#are you there?
bot.message(start_with: (PREFIX + 'are you there?')) do |event|
  yes(event)
end

#say
bot.message(start_with: (PREFIX + 'say')) do |event|
  say(event)
end


##            ##
##  Commands  ##
##            ##

#say
def say (event)
  commandL = PREFIXL + 4
  event.respond event.content.slice!(commandL-1, (event.content.length - 1))
end

#yes
def yes (event)
  event.respond YES_ARY[rand(YES_ARY.count)]
end

#no
def no (event)
  event.respond NO_ARY[rand(NO_ARY.count)]
end


##            ##
##   Events   ##
##            ##
bot.reaction_add do |event|
  if event.message.id == react_message
    reaction_add(bot, event)
  end
end

bot.reaction_remove do |event|
  if event.message.id == react_message
    reaction_remove(bot, event)
  end
end


bot.run()