--Q1 - Fix or improve the implementation of the below methods
--This question really depends on the exact purpose of the methods and the context in which they are used.
--I assumed this system was necessary and just tried to improve it and make it more general and readable.

--Add enum for better readability
---@enum storageStatus
StorageStatus = {
    offline = -1,
    initializing = 0,
    online = 1
}

---Release the player storage at a specific index.
---@param storageIndex integer
function Player:releaseStorage(storageIndex)
    if self:getStorageValue(storageIndex) == StorageStatus.online then
        self:setStorageValue(storageIndex, StorageStatus.offline)
    end
end

---Event called when a player logs out. Presumably fired from the C++ backend.
---@param player Player
---@return boolean success
function onLogout(player)
    if not player or not player:getStorageValue(1000) then return false end
    player:releaseStorage(1000)
    return true
end

--Q2 - Fix or improve the implementation of the below method

---Print names of all guilds that have less than memberCount max members.
---@param memberCount integer
function printSmallGuildNames(memberCount)

--Basic input validation.
if type(memberCount) ~= "number" or memberCount % 1 ~= 0 then
    print("Invalid input, provide a valid member count") --Or whatever method is fitting for displaying the error to the user.
    return
end

--Prepare the query to avoid SQL injection.
local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < ?;"
local dbStmt = db.prepare(selectGuildQuery) --I assume the library being used here is capable of prepared statements.
if not dbStmt then print("Failed to prepare the database statement") return end

local success = dbStmt:bind(1, memberCount)
if not success then print("Failed to bind parameters") return end

--Execute the query and fetch the results.
local resultId = dbStmt:execute()
if not resultId then print("Failed to execute the query or no results found") return end

--Print the names of the guilds with less than memberCount members.
repeat
    local guildName = resultId:getString("name")
    print(guildName)
until not resultId:next()

resultId:free()
dbStmt:free()
end

--Q3 - Fix or improve the name and the implementation of the below method

---Remove a member from a player's party.
---@param playerId integer The id of the player who is the party leader.
---@param memberName string The name of the member to be removed from the party.
---@return boolean success Returns true if the member was successfully removed from the party, false otherwise.
function removeMemberFromParty(playerId, memberName)
    -- Retrieve the player
    local player = Player(playerId)
    if not player then print("Player not found") return false end

    -- Retrieve the party associated with the player
    local party = player:getParty()
    if not party then print("Player is not in a party") return false end

    --I assume the getMembers() method returns a table of Player objects
    --Original problem was calling the player constructor multiple times just to compare the names.
    for k, member in pairs(party:getMembers()) do
        if member:getName() == memberName then
            party:removeMember(member)
            print("Member removed from party: " .. memberName)
            return true
        end
    end

    print("No member found with the name: " .. memberName)
    return false
end


