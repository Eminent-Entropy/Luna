require 'discordrb'

#ID
TestingServer = 346043227364655127
Thing1 = 417687051735924736

def reaction_add(bot, event)
  user = event.user
  thing1 = bot.server(TestingServer).role(Thing1)

  if event.emoji.name == 'oops'
    user.add_role(thing1)
  end
end

def reaction_remove(bot, event)
  user = event.user
  thing1 = bot.server(TestingServer).role(Thing1)

  if event.emoji.name == 'oops'
    user.remove_role(thing1)
  end
end