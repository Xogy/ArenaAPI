-- When player leave the game we will detele his instance/remove him from arena he is playing
AddEventHandler("playerDropped", function()
    local arenaID = PlayerInfo[source]
    if arenaID and arenaID ~= "none" then
        CreateArena(arenaID).RemovePlayer(source)
    end
    CooldownPlayers[source] = nil
end)

-- When player client side load we will write his ID + basic stuff into predefined variables in main
RegisterNetEvent("ArenaAPI:PlayerJoinedFivem")
AddEventHandler("ArenaAPI:PlayerJoinedFivem", function()
    TriggerClientEvent("ArenaAPI:sendStatus", source, "updateData", ArenaList)
    PlayerInfo[source] = "none"
    CooldownPlayers[source] = { }
end)

-- When some resource will stop it will delete all related events to the resource so it doesnt get
-- duplicated if the resource was only reseted due to testing
AddEventHandler('onResourceStop', function(resourceName)
    RemoveEventsWithNameResource(resourceName)
end)