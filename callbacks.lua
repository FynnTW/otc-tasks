math.randomseed(os.time())
---Returns a random number between min and max.
---@param min integer
---@param max integer
---@return integer randomNumber
function getRandomNumber(min, max)
  --math.random() is not a good random number generator in lua. In my experience calling it multiple times in a row helps making it more random.
  math.random() math.random() math.random()
  return math.random(min, max)
end

---Custom callback for the onTalk event, to fire functions for the trial.
---@param name any
---@param level any
---@param mode any
---@param text string The text that was said. Used to identify the command.
---@param channelId any
---@param pos any
context.callback("onTalk", function(name, level, mode, text, channelId, pos)
  ---First question of the trial. Tornado effect around the player.
  if text == "tornado" then
    local player = g_game.getLocalPlayer()
    if not player then pwarning("Somehow there is no player.") return end
    local position = player:getPosition()
    if not position then pwarning("Player position is not valid.") return end
    --Named variables to make it clear what the parameters are.
    local numberOfTornados = 1000
    local radius = 2
    doTornadoEffect(position, numberOfTornados, position.x, position.y, radius)
  end
  ---Third question of the trial. Jumpy button.
  if text == "jumpy" then
    jumpyButtonWindow()
  end
  
end)

---Custom callback for the onWalk event, for the tracer effect question.
---@param creature Creature
---@param oldPos Position The old position of the creature. Useful in this case to create the trail.
---@param newPos Position
context.callback("onWalk", function(creature, oldPos, newPos)
  if creature == g_game.getLocalPlayer() then
    makeTrail(oldPos)
  end
end)