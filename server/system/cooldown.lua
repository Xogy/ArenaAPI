function CooldownPlayer(source, arena, time)
    CooldownPlayers[source][arena] = os.time(os.date("!*t")) + time
end

function IsPlayerInCooldown(source, arena)
    if CooldownPlayers[source][arena] == nil then return false end
    return CooldownPlayers[source][arena] > os.time(os.date("!*t"))
end

function TimestampToString(time)
    return os.date( "%H:%M:%S", time + Config.TimeZone * 60 * 60 )
end

function GetcooldownForPlayer(source, arena)
    if CooldownPlayers[source][arena] == nil then return os.time(os.date("!*t")) end
    return CooldownPlayers[source][arena]
end