function GetArena(identifier)
    return ArenaData[identifier]
end

exports("GetArena", GetArena)

function IsPlayerInAnyArena()
    return PlayerData.CurrentArena ~= "none"
end

exports("IsPlayerInAnyArena", IsPlayerInAnyArena)

function GetPlayerArena()
    return PlayerData.CurrentArena
end

exports("GetPlayerArena", GetPlayerArena)

function IsPlayerInArena(arena)
    return PlayerData.CurrentArena == arena
end

exports("IsPlayerInArena", IsPlayerInArena)

function GetArenaLabel(identifier)
    return GetCurrentArenaData(identifier).ArenaLabel
end

exports("GetArenaLabel", GetArenaLabel)

function GetArenaMaximumSize(identifier)
    return GetCurrentArenaData(identifier).MaximumCapacity
end

exports("GetArenaMaximumSize", GetArenaMaximumSize)

function GetArenaMinimumSize(identifier)
    return GetCurrentArenaData(identifier).MinimumCapacity
end

exports("GetArenaMinimumSize", GetArenaMinimumSize)

function GetArenaCurrentSize(identifier)
    return GetCurrentArenaData(identifier).CurrentCapacity
end

exports("GetArenaCurrentSize", GetArenaCurrentSize)

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