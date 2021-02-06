function GetArenaList()
    return ArenaList
end

exports("GetArenaList", GetArenaList)

function DoesArenaExists(identifier)
    return ArenaList[identifier] ~= nil
end

exports("DoesArenaExists", DoesArenaExists)

function IsPlayerInAnyArena(source)
    return PlayerInfo[source] ~= "none"
end

exports("IsPlayerInAnyArena", IsPlayerInAnyArena)

function IsPlayerInArena(source, arena)
    return PlayerInfo[source] == arena
end

exports("IsPlayerInArena", IsPlayerInArena)

function GetPlayerArena(source)
    return PlayerInfo[source]
end

exports("GetPlayerArena", GetPlayerArena)

function IsArenaBusy(identifier)
    return ArenaList[identifier].ArenaState == "ArenaBusy"
end

exports("IsArenaBusy", IsArenaBusy)

function GetPlayerCount(identifier)
    return ArenaList[identifier].CurrentCapacity
end

exports("GetPlayerCount", GetPlayerCount)

function IsArenaActive(identifier)
    return ArenaList[identifier].ArenaState == "ArenaActive"
end

exports("IsArenaActive", IsArenaActive)

function IsArenaInactive (identifier)
    return ArenaList[identifier].ArenaState == "ArenaInactive"
end

exports("IsArenaInactive", IsArenaInactive)

function GetArenaState (identifier)
    return ArenaList[identifier].ArenaState
end

exports("GetArenaState", GetArenaState)