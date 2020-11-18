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

  #are you there?
  if event.message.content.downcase.start_with?(PREFIX + ', are you there?')
    yes(event)
    $last_responded = event.message.id
  elsif event.message.content.downcase.start_with?(PREFIX + ', you there?')
    yes(event)
    $last_responded = event.message.id
  end

  #say
  if event.message.content.downcase.start_with?(PREFIX + ', say')
    say(event)
    $last_responded = event.message.id
  end

  #unknown
  if event.message.content.downcase.start_with?(PREFIX)
    sleep 0.5
    if event.message.id != $last_responded
      unknown(event)
      $last_responded = event.message.id
    end
  end
end


##            ##
##  Commands  ##
##            ##

#say (repeat)
def say (event)
  commandl = PREFIXL + 4
  event.respond event.content.slice!(commandl-1, (event.content.length - 1))
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