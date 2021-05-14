IsArenaBusy = false

ArenaData = {}
PlayerData = {
    CurrentArena = "none",
}

-- stolen from https://scriptinghelpers.org/questions/43622/how-do-i-turn-seconds-to-minutes-and-seconds
function DecimalsToMinutes(dec)
    local ms = tonumber(dec)
    return math.floor(ms / 60) .. ":" .. (ms % 60)
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
                AddTextComponentSubstringPlayerName(DecimalsToMinutes(data.MaximumArenaTime) .. " time left")
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