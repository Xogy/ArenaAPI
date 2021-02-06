exports("On", On)

function OnArenaRoundEnd(arena, cb)
    On(arena, "roundend", cb)
end

exports("OnArenaRoundEnd", OnArenaRoundEnd)

function OnPlayerJoinLobby(arena, cb)
    On(arena, "join", cb)
end

exports("OnPlayerJoinLobby", OnPlayerJoinLobby)

function OnPlayerExitLobby(arena, cb)
    On(arena, "leave", cb)
end

exports("OnPlayerExitLobby", OnPlayerExitLobby)

function OnArenaStart(arena, cb)
    On(arena, "start", cb)
end

exports("OnArenaStart", OnArenaStart)

function OnArenaEnd(arena, cb)
    On(arena, "end", cb)
end

exports("OnArenaEnd", OnArenaEnd)