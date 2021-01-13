function CreateArena(identifier)
    local arena = ArenaCreatorHelper(identifier)
    --------------------------------------------
    local self = {}
    --------------------------------------------
    --     Basic information about arena      --
    --------------------------------------------
    self.SetMaximumCapacity = function(number)
        arena.MaximumCapacity = number
    end

    self.GetMaximumCapacity = function()
        return arena.MaximumCapacity
    end
    --------
    self.SetMinimumCapacity = function(number)
        arena.MinimumCapacity = number
    end

    self.GetMinimumCapacity = function()
        return arena.MinimumCapacity
    end
    --------
    self.GetArenaIdentifier = function()
        return arena.ArenaIdentifier
    end
    --------
    self.SetArenaLabel = function(name)
        arena.ArenaLabel = name
    end

    self.GetArenaLabel = function()
        return arena.ArenaLabel
    end
    --------
    self.SetMaximumArenaTime = function(second)
        arena.MaximumArenaTime = second
        arena.MaximumArenaTimeSaved = second
    end

    self.GetMaximumArenaTime = function()
        return arena.MaximumArenaTimeSaved
    end
    --------
    self.SetMaximumLobbyTime = function(second)
        arena.MaximumLobbyTime = second
        arena.MaximumLobbyTimeSaved = second
    end

    self.GetMaximumLobbyTime = function()
        return arena.MaximumLobbyTimeSaved
    end
    --------
    self.SetArenaPublic = function(value)
        arena.ArenaIsPublic = value
    end

    self.IsArenaPublic = function()
        return arena.ArenaIsPublic
    end
    --------------------------------------------
    --     Adding player into arena logic     --
    --------------------------------------------
    self.AddPlayer = function(source)
        if arena.PlayerList[source] == nil then
            local data = GetDefaultDataFromArena(arena.ArenaIdentifier)

            PlayerInfo[source] = data.ArenaIdentifier
            arena.PlayerList[source] = true
            arena.PlayerScoreList[source] = {}
            arena.PlayerNameList[source] = GetPlayerName(source):gsub("<[^>]+>", " ")

            arena.CurrentCapacity = arena.CurrentCapacity + 1

            if arena.EventList.OnPlayerJoinArena ~= nil then
                data.source = source
                data.CurrentCapacity = arena.CurrentCapacity
                arena.EventList.OnPlayerJoinArena(data)
            end

            arena.MaximumLobbyTime = arena.MaximumLobbyTimeSaved

            arena.ArenaState = "ArenaActive"

            TriggerClientEvent("ArenaAPI:sendStatus", -1, "updateData",  ArenaList)
            TriggerClientEvent("ArenaAPI:sendStatus", source, "join", data)
        end
    end
    --------
    self.RemovePlayer = function(source, skipEvent)
        if arena.PlayerList[source] ~= nil then
            local data = GetDefaultDataFromArena(arena.ArenaIdentifier)

            PlayerInfo[source] = "none"
            arena.PlayerList[source] = nil
            arena.PlayerScoreList[source] = nil
            arena.PlayerNameList[source] = nil

            arena.CurrentCapacity = arena.CurrentCapacity - 1
            if arena.CurrentCapacity == 0 then
                arena.ArenaState = "ArenaInactive"
            end

            if arena.EventList.OnPlayerExitArenad ~= nil then
                data.source = source
                data.CurrentCapacity = arena.CurrentCapacity
                arena.EventList.OnPlayerExitArenad(data)
            end

            arena.MaximumLobbyTime = arena.MaximumLobbyTimeSaved

            TriggerClientEvent("ArenaAPI:sendStatus", -1, "updateData",  ArenaList)
            if skipEvent == nil then TriggerClientEvent("ArenaAPI:sendStatus", source, "leave", data) end
        end
    end
    --------
    self.GetPlayerList = function()
        return arena.PlayerList
    end
    --------
    self.IsPlayerInArena = function(source)
        return arena.PlayerList[source] ~= nil
    end
    --------------------------------------------
    --       Setting player score logic       --
    --------------------------------------------
    self.SetPlayerScore = function(source, key, value)
        arena.PlayerScoreList[source][key] = value
    end
    --------
    self.GetPlayerScore = function(source, key)
        return arena.PlayerScoreList[source][key]
    end
    --------
    self.GivePlayerScore = function(source, key, value)
        arena.PlayerScoreList[source][key] = arena.PlayerScoreList[source][key] + value
    end
    --------
    self.RemovePlayerScore = function(source, key, value)
        arena.PlayerScoreList[source][key] = arena.PlayerScoreList[source][key] - value
    end
    --------
    self.PlayerScoreExists = function(source, key)
        return arena.PlayerScoreList[source][key] ~= nil
    end
    --------
    self.DeleteScore = function(source, key)
        arena.PlayerScoreList[source][key] = nil
    end
    --------------------------------------------
    --        Basic manipulation arena        --
    --------------------------------------------
    self.Destroy = function()
        if arena.EventList.OnArenaEnded then
            local data = GetDefaultDataFromArena(arena.ArenaIdentifier)
            arena.EventList.OnArenaEnded(data)
        end

        for k,v in pairs(arena.PlayerList) do
            self.RemovePlayer(k)
        end

        TriggerClientEvent("ArenaAPI:sendStatus", -1, "end", GetDefaultDataFromArena(arena.ArenaIdentifier))
        ArenaList[identifier] = nil
    end
    --------
    self.Reset = function()
        if arena.EventList.OnArenaEnded then
            local data = GetDefaultDataFromArena(arena.ArenaIdentifier)
            arena.EventList.OnArenaEnded(data)
        end

        for k,v in pairs(arena.PlayerList) do
            self.RemovePlayer(k, true)
        end

        arena.PlayerList = {}
        arena.PlayerScoreList = {}
        arena.ArenaState = "ArenaInactive"

        arena.MaximumArenaTime = arena.MaximumArenaTimeSaved
    end
    --------------------------------------------
    --         Basic events for arena         --
    --------------------------------------------
    self.OnPlayerJoinArena = function(cb)
        arena.EventList.OnPlayerJoinArena = cb
    end

    self.OnPlayerExitArena = function(cb)
        arena.EventList.OnPlayerExitArena = cb
    end

    self.OnArenaStarted = function(cb)
        arena.EventList.OnArenaStarted = cb
    end

    self.OnArenaEnded = function(cb)
        arena.EventList.OnArenaEnded = cb
    end
    --------------------------------------------
    return self
end

exports("CreateArena", CreateArena)

function GetArena(identifier)
    return CreateArena(identifier)
end

exports("GetArena", GetArena)