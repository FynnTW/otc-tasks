---This is a simple example of a trail effect that follows the player's movement.
-- It just spawns a creature and slowly fades its color.
---@param oldPos Position
function makeTrail(oldPos)
    local player = g_game.getLocalPlayer()
    --Create a new creature at the old position.
    local newCreature = Creature.create()
    newCreature:setOutfit(player:getOutfit())
    newCreature:setDirection(player:getDirection())
    g_map.addThing(newCreature, oldPos)

    --Fade the color of the creature.
    fadeColor(newCreature, fade)
  end
  
  ---Slowly fades the color of the player trail that spawns using a shader.
  ---@param creature Creature
  ---@param fade integer Current fade value.
  function fadeColor(creature, fade)
    --Stop recursion if the fade value is greater than 200 (arbitrary value to create a trail like effect).
    if fade > 200 then g_map.removeThing(creature) return end
    fade = fade + 1
    --Set the outfit shader to the fading shader.
    creature:setOutfitShader("outfit_tracer")
    --Call the function again with a delay.
    local delay = 1
    context.schedule(delay, function() fadeColor(creature, fade) end)
  end