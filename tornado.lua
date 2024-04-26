
---Creates a tornado effect around the player.
---@param position Position The position of the player.
---@param n integer The number of tornado effects to create.
---@param startX integer The starting X position of the player. Used to limit the movement of the tornado.
---@param startY integer The starting Y position of the player. Used to limit the movement of the tornado.
---@param radius integer The maximum radius of the tornado effect.
function doTornadoEffect(position, n, startX, startY, radius)
    pinfo(string.format("Position: %d, %d, %d", position.x, position.y, position.z))
    --Base case. If n is 0, return.
    if n == 0 then return end
    --Create the tornado effect.
    local effect = Effect.create()
    -- Id 43 is the tornado effect. Does not seem to be a fitting enum in the client so have to be a bit magic number-y.
    effect:setId(43)
    --Create a new random position for the tornado effect. Clamped by starting position passed initially.
    position.x = math.min(startX + radius, math.max(startX - radius, position.x + getRandomNumber(-1, 1)))
    position.y = math.min(startY + radius, math.max(startY - radius, position.y + getRandomNumber(-1, 1)))
    --Do not allow the tornado to be on the player.
    if position.x == startX and position.y == startY then position.x = startX + 1 end
    --Add the effect to the map.
    g_map.addThing(effect, position)
    --Schedule the next tornado effect to be created.
    local delay = 25
    context.schedule(delay, function()
      doTornadoEffect(position, n - 1, startX, startY, radius)
    end)
  end