require 'discordrb'
require 'json'

require_relative 'reactions'

cred = File.read('../luna-cred.json')
cred_hash = JSON.parse(cred)

bot = Discordrb::Bot.new token: cred_hash['token']



##            ##
##  Aliases   ##
##            ##

PREFIX = 'luna'
PREFIXL = PREFIX.length
react_message = 778504216829493280

$last_responded = 0
$last_question = 0

YES_ARY = ["Yep!", "You Bet!", "For Sure!", "Always!"]
NO_ARY = ["No, Sorry", "Nope", "Sadly no", "Unfortunately not"]
YN_ARY = ["As I see it, yes", "Most likely", "Without a doubt", "Yes – definitely", "Signs point to yes", "Yes", "Not sure...", "I'll have to get back to you on that...", "Better to not tell you now", "Don't count on it", "My sources say no", "Very Doubtful", "No"]
UNK_ARY = ["Didn't get that, sorry?", "Could you repeat that please?", "Could you say that again?", "Run that by me again?"]


##  messages  ##
bot.message do |event|
  content = event.message.content.downcase

    # general #
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

    # memes #
  #dad
  if content.start_with?('i\'m ')
    dad(event, 4)
    $last_responded = event.message.id
  elsif content.start_with?('i am ')
    dad(event, 5)
    $last_responded = event.message.id
  elsif content.start_with?('im ')
    dad(event, 3)
    $last_responded = event.message.id
  end

    # misc #
  #question
  sleep 0.1 #time to update $last_responded
  if content.start_with?(PREFIX) and event.message.id != $last_responded and content.end_with?('?')
    ynanswer(event)
    $last_responded = event.message.id
    $last_question = Time.now.to_i
  elsif content.end_with?('?') and (Time.now.to_i - $last_question) < 30
    ynanswer(event)
    $last_responded = event.message.id
    $last_question = Time.now.to_i
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

  ## General ##
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

#yes no answer
def ynanswer (event)
  event.respond YN_ARY[rand(YN_ARY.count)]
end

#doesn't understand
def unknown (event)
  event.respond UNK_ARY[rand(UNK_ARY.count)]
end


  ##  memes  ##
#I'm dad
def dad (event, commandl)
  event.respond 'Hi, ' + event.content.slice!(commandl, (event.content.length - 1)) + ' I\'m dad'
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