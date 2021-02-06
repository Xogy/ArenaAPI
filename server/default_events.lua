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

AddEventHandler('onResourceStop', function(resourceName)
    RemoveEventsWithNameResource(resourceName)
end)