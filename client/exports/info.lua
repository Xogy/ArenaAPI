-- Will return array of the arena name
--- @param identifier string
function GetArena(identifier)
    return ArenaData[identifier]
end

exports("GetArena", GetArena)

-- Will return true/false if player is in any arena
function IsPlayerInAnyArena()
    return PlayerData.CurrentArena ~= "none"
end

exports("IsPlayerInAnyArena", IsPlayerInAnyArena)

-- will return player arena name
function GetPlayerArena()
    return PlayerData.CurrentArena
end

exports("GetPlayerArena", GetPlayerArena)

-- Will return true/false if the player is in specific arena
--- @param arena string
function IsPlayerInArena(arena)
    return PlayerData.CurrentArena == arena
end

exports("IsPlayerInArena", IsPlayerInArena)

-- will return label of the arena
--- @param identifier string
function GetArenaLabel(identifier)
    return GetCurrentArenaData(identifier).ArenaLabel
end

exports("GetArenaLabel", GetArenaLabel)

-- Will return how many players can be in the specific arena
--- @param identifier string
function GetArenaMaximumSize(identifier)
    return GetCurrentArenaData(identifier).MaximumCapacity
end

exports("GetArenaMaximumSize", GetArenaMaximumSize)

-- Will return minimum required people to start arena
--- @param identifier string
function GetArenaMinimumSize(identifier)
    return GetCurrentArenaData(identifier).MinimumCapacity
end

exports("GetArenaMinimumSize", GetArenaMinimumSize)

-- Will return how many people is in this specific arena
--- @param identifier string
function GetArenaCurrentSize(identifier)
    return GetCurrentArenaData(identifier).CurrentCapacity
end

exports("GetArenaCurrentSize", GetArenaCurrentSize)

-- will return data for the arena
--- @param identifier string
function GetCurrentArenaData(identifier)
    return {
        ArenaIdentifier = ArenaData[identifier].ArenaIdentifier,
        ArenaLabel = ArenaData[identifier].ArenaLabel,
        MaximumCapacity = ArenaData[identifier].MaximumCapacity,
        MinimumCapacity = ArenaData[identifier].MinimumCapacity,
        CurrentCapacity = ArenaData[identifier].CurrentCapacity,
    }
end

exports("GetCurrentArenaData", GetCurrentArenaData)