-- Will set a cooldown to player so he cannot join the lobby defined in args
--- @param source int
--- @param arena string
--- @param time int
function CooldownPlayer(source, arena, time)
    CooldownPlayers[source][arena] = os.time(os.date("!*t")) + time
end

-- Will return true/false if player has cooldown to join the defined lobby
--- @param source int
--- @param arena string
function IsPlayerInCooldown(source, arena)
    if CooldownPlayers[source][arena] == nil then return false end
    return CooldownPlayers[source][arena] > os.time(os.date("!*t"))
end

-- Will convert time into hh:mm:ss
--- @param time int
function TimestampToString(time)
    return os.date( "%H:%M:%S", time + Config.TimeZone * 60 * 60 )
end

-- Will return timestamp
--- @param source int
--- @param arena string
function GetcooldownForPlayer(source, arena)
    if CooldownPlayers[source][arena] == nil then return os.time(os.date("!*t")) end
    return CooldownPlayers[source][arena]
end