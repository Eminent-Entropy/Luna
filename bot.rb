require 'discordrb'
require 'json'

require_relative 'reactions'

cred = File.read('../luna-cred.json')
cred_hash = JSON.parse(cred)

bot = Discordrb::Bot.new token: cred_hash['token']
$last_responded = 0


##            ##
##  Aliases   ##
##            ##

PREFIX = 'luna'
PREFIXL = PREFIX.length
react_message = 778392481950728234

YES_ARY = ["Yep!", "You Bet!", "For Sure!", "Always!"]
NO_ARY = ["No, Sorry", "Nope", "Sadly no", "Unfortunately not"]
UNK_ARY = ["Didn't get that, sorry?", "Could you repeat that please?", "Could you say that again?", "Run that by me again?"]

##  messages  ##
bot.message do |event|
  content = event.message.content.downcase

  #are you there?
  if content.start_with?(PREFIX + ', are you there?') or content.start_with?(PREFIX + ' are you there?')
    yes(event)
    $last_responded = event.message.id
  elsif content.start_with?(PREFIX + ', you there?') or content.start_with?(PREFIX + ' you there?')
    yes(event)
    $last_responded = event.message.id
  end

  #say
  if content.start_with?(PREFIX + ', say')
    say(event, 6)
    $last_responded = event.message.id
  elsif content.start_with?(PREFIX + ' say')
    say(event, 5)
    $last_responded = event.message.id
  end

  #unknown
  sleep 0.1 #time to update $last_responded
  if content.start_with?(PREFIX) and event.message.id != $last_responded
    unknown(event)
    $last_responded = event.message.id
  end
end


##            ##
##  Commands  ##
##            ##

#say (repeat)
def say (event, commandl)
  event.respond event.content.slice!(PREFIXL + commandl, (event.content.length - 1))
end

#yes
def yes (event)
  event.respond YES_ARY[rand(YES_ARY.count)]
end

#no
def no (event)
  event.respond NO_ARY[rand(NO_ARY.count)]
end

#doesn't understand
def unknown (event)
  event.respond UNK_ARY[rand(UNK_ARY.count)]
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