-- Will return array with arenas list
function GetArenaList()
    return ArenaList
end

exports("GetArenaList", GetArenaList)

-- Return true/false if the key exists in variable "ArenaList"
--- @param identifier string
function DoesArenaExists(identifier)
    return ArenaList[identifier] ~= nil
end

exports("DoesArenaExists", DoesArenaExists)

-- Return true/false if player is in any lobby/Arena
--- @param identifier string
function IsPlayerInAnyArena(source)
    return PlayerInfo[source] ~= "none"
end

exports("IsPlayerInAnyArena", IsPlayerInAnyArena)

-- will return true/false if player is in the arena defined in arguments
--- @param identifier string
function IsPlayerInArena(source, arena)
    return PlayerInfo[source] == arena
end

exports("IsPlayerInArena", IsPlayerInArena)

-- Will return player arena name
--- @param identifier string
function GetPlayerArena(source)
    return PlayerInfo[source]
end

exports("GetPlayerArena", GetPlayerArena)

-- Will return true/false if arena is busy
--- @param identifier string
function IsArenaBusy(identifier)
    return ArenaList[identifier].ArenaState == "ArenaBusy"
end

exports("IsArenaBusy", IsArenaBusy)

-- Will return player count in the arena/lobby
--- @param identifier string
function GetPlayerCount(identifier)
    return ArenaList[identifier].CurrentCapacity
end

exports("GetPlayerCount", GetPlayerCount)

-- Will return true/false if arena is active
--- @param identifier string
function IsArenaActive(identifier)
    return ArenaList[identifier].ArenaState == "ArenaActive"
end

exports("IsArenaActive", IsArenaActive)

-- Will return true/false if arena is inactive
--- @param identifier string
function IsArenaInactive (identifier)
    return ArenaList[identifier].ArenaState == "ArenaInactive"
end

exports("IsArenaInactive", IsArenaInactive)

-- Will return string in what state is the arena
--- @param identifier string
function GetArenaState (identifier)
    return ArenaList[identifier].ArenaState
end

exports("GetArenaState", GetArenaState)