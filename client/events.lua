-- When some resource will stop it will delete all related events to the resource so it doesnt get
-- duplicated if the resource was only reseted due to testing
AddEventHandler('onResourceStop', function(resourceName)
    RemoveEventsWithNameResource(resourceName)
end)

-- will fetch info from server and save it into client variable
RegisterNetEvent("ArenaAPI:sendStatus")
AddEventHandler("ArenaAPI:sendStatus", function(type, data)
    local arena = data.ArenaIdentifier
    if type == "updateData" then
        ArenaData = data
        UpdatePlayerNameList()
    end

    if type == "roundEnd" then
        if ArenaData[arena].MaximumArenaTime then
            ArenaData[arena].MaximumArenaTime = data.MaximumLobbyTime + 1
        end
        CallOn(arena, "roundend", data)
    end

    if type == "start" then
        CallOn(arena, "start", data)
        if PlayerData.CurrentArena == arena then
            IsArenaBusy = true
        end
    end

    if type == "end" then
        CallOn(arena, "end", data)
        if ArenaData[arena].MaximumArenaTime then
            ArenaData[arena].MaximumArenaTime = data.MaximumLobbyTime + 1
        end
        if PlayerData.CurrentArena == arena then
            IsArenaBusy = false
        end
        PlayerData.CurrentArena = "none"
    end

    if type == "join" then
        PlayerData.CurrentArena = data.ArenaIdentifier
        CallOn(arena, "join", data)

        SendNUIMessage({ type = "ui", status = true, })
        SendNUIMessage({ type = "arenaName", arenaName = data.ArenaLabel })
        UpdatePlayerNameList()
    end

    if type == "leave" then
        CallOn(arena, "leave", data)

        if PlayerData.CurrentArena == arena then
            IsArenaBusy = false
        end

        PlayerData.CurrentArena = "none"
        SendNUIMessage({ type = "ui", status = false, })
    end
end)