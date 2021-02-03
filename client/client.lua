ArenaData = {}
EventData = {}
PlayerData = {
    CurrentArena = "none",
}

IsArenaBusy = false

function InitEventData(arena)
    if EventData[arena] == nil then
        EventData[arena] = {}
    end
end

function UpdatePlayerNameList()
    if IsPlayerInAnyArena() then
        local arena = GetPlayerArena()
        local data = GetArena(arena)
        local names = {}
        for k, v in pairs(data.PlayerNameList) do
            table.insert(names, v)
        end
        SendNUIMessage({ type = "playerNameList", Names = names, })
    end
end

RegisterNetEvent("ArenaAPI:sendStatus")
AddEventHandler("ArenaAPI:sendStatus", function(type, data)
    local arena = data.ArenaIdentifier
    local event = EventData[arena]
    if type == "updateData" then
        ArenaData = data
        UpdatePlayerNameList()
    end

    if type == "roundEnd" then
        if ArenaData[arena].MaximumArenaTime then
            ArenaData[arena].MaximumArenaTime = data.MaximumLobbyTime + 1
        end
        if event and event.OnArenaRoundEnd and PlayerData.CurrentArena == arena then
            event.OnArenaRoundEnd(data)
        end
    end

    if type == "start" then
        if event and event.OnArenaStart and PlayerData.CurrentArena == arena then
            event.OnArenaStart(data)
        end
        if PlayerData.CurrentArena == arena then
            IsArenaBusy = true
        end
    end

    if type == "end" then
        if event and event.OnArenaEnd and PlayerData.CurrentArena == arena then
            event.OnArenaEnd(data)
        end
        if ArenaData[arena].MaximumArenaTime then
            ArenaData[arena].MaximumArenaTime = data.MaximumLobbyTime + 1
        end
        if PlayerData.CurrentArena == arena then
            IsArenaBusy = false
        end
    end

    if type == "join" then
        PlayerData.CurrentArena = data.ArenaIdentifier
        if event and event.OnPlayerJoinLobby and PlayerData.CurrentArena == arena then
            event.OnPlayerJoinLobby(data)
        end

        SendNUIMessage({ type = "ui", status = true, })
        SendNUIMessage({ type = "arenaName", arenaName = data.ArenaLabel })
        UpdatePlayerNameList()
    end

    if type == "leave" then
        if event and event.OnPlayerExitLobby and PlayerData.CurrentArena == arena then
            event.OnPlayerExitLobby(data)
        end

        if PlayerData.CurrentArena == arena then
            IsArenaBusy = false
        end

        PlayerData.CurrentArena = "none"
        SendNUIMessage({ type = "ui", status = false, })
    end
end)

CreateThread(function()
    TriggerServerEvent("ArenaAPI:PlayerJoinedFivem")
end)

CreateThread(function()
    while true do
        Wait(1000)
        if IsArenaBusy then
            local arena = GetPlayerArena()
            local data = GetArena(arena)
            if data.MaximumArenaTime ~= nil and data.MaximumArenaTime > 1 then
                data.MaximumArenaTime = data.MaximumArenaTime - 1
                BeginTextCommandPrint('STRING')
                AddTextComponentSubstringPlayerName(data.MaximumArenaTime .. " seconds left")
                EndTextCommandPrint(1000, 1)
            end
        end

        if IsPlayerInAnyArena() then
            local arena = GetPlayerArena()
            local data = GetArena(arena)

            if data.MinimumCapacity - 1 < data.CurrentCapacity then
                if data.MaximumLobbyTime == 1 then
                    SendNUIMessage({ type = "ui", status = false, })
                else
                    data.MaximumLobbyTime = data.MaximumLobbyTime - 1

                    SendNUIMessage({
                        type = "updateTime",
                        time = data.MaximumLobbyTime,
                    })
                end
            end
        end
    end
end)