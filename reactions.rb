require 'discordrb'

#ID
SERVER = 566092415690211349
RAINBOWSIX = 778465651052249099
MINECRAFT = 778466125859258409
TERRAIRA = 778466282767908907
DCS = 778465831721369630
ELITE = 778465709788626966
NMS = 778466394643365929
STELLARIS = 778466465543094293

def reaction_add(bot, event)
  user = event.user
  rainbowsix = bot.server(SERVER).role(RAINBOWSIX)
  mincraft = bot.server(SERVER).role(MINECRAFT)
  terraira = bot.server(SERVER).role(TERRAIRA)
  dcs = bot.server(SERVER).role(DCS)
  elite = bot.server(SERVER).role(ELITE)
  nms = bot.server(SERVER).role(NMS)
  stellaris = bot.server(SERVER).role(STELLARIS)

  if event.emoji.name == 'rainbow6'
    user.add_role(rainbowsix)
  elsif event.emoji.name == 'minecraft'
    puts 'yes'
    user.add_role(mincraft)
  elsif event.emoji.name == 'terraria'
    user.add_role(terraira)
  elsif event.emoji.name == 'dcs'
    user.add_role(dcs)
  elsif event.emoji.name == 'elite'
    user.add_role(elite)
  elsif event.emoji.name == 'nms'
    user.add_role(nms)
  elsif event.emoji.name == 'stellaris'
    user.add_role(stellaris)
  end
end

def reaction_remove(bot, event)
  user = event.user
  rainbowsix = bot.server(SERVER).role(RAINBOWSIX)
  mincraft = bot.server(SERVER).role(MINECRAFT)
  terraira = bot.server(SERVER).role(TERRAIRA)
  dcs = bot.server(SERVER).role(DCS)
  elite = bot.server(SERVER).role(ELITE)
  nms = bot.server(SERVER).role(NMS)
  stellaris = bot.server(SERVER).role(STELLARIS)

  if event.emoji.name == 'rainbow6'
    user.remove_role(rainbowsix)
  elsif event.emoji.name == 'minecraft'
    user.remove_role(mincraft)
  elsif event.emoji.name == 'terraria'
    user.remove_role(terraira)
  elsif event.emoji.name == 'dcs'
    user.remove_role(dcs)
  elsif event.emoji.name == 'elite'
    user.remove_role(elite)
  elsif event.emoji.name == 'nms'
    user.remove_role(nms)
  elsif event.emoji.name == 'stellaris'
    user.remove_role(stellaris)
  end
end