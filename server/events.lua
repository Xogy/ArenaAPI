local events = {}

local validEvents = {
    ["join"] = true,
    ["leave"] = true,
}

local function validateEvents(eventName)
    if type(eventName) ~= "string" then
        return false;
    end

    if validEvents[string.lower(eventName)] ~= nil then
        return true;
    end
    return false;
end

--Register event
--Return true if event is registered, false if is not
function on(eventName, cb)
    if not validateEvents(eventName) then
        return false;
    end

    if events[eventName] == nil then
        events[eventName] = {}
    end

    table.insert(events[eventName], cb)

    return true;
end

--Call event
--@internal
function callOn(eventName, ...)
    if type(events[eventName]) == "table" then
        for _,v in pairs(events[eventName]) do
            if type(v) == "function" then
                v(...)
            end
        end
    end
end

AddEventHandler("playerDropped", function()
    local arenaID = PlayerInfo[source]
    if arenaID and arenaID ~= "none" then
        CreateArena(arenaID).RemovePlayer(source)
    end
    CooldownPlayers[source] = nil
end)

RegisterNetEvent("ArenaAPI:PlayerJoinedFivem")
AddEventHandler("ArenaAPI:PlayerJoinedFivem", function()
    TriggerClientEvent("ArenaAPI:sendStatus", source, "updateData", ArenaList)
    PlayerInfo[source] = "none"
    CooldownPlayers[source] = { }
end)
