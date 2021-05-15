exports("On", On)

-- will register callback for this event
function OnArenaRoundEnd(arena, cb)
    On(arena, "roundend", cb)
end

exports("OnArenaRoundEnd", OnArenaRoundEnd)

-- will register callback for this event
function OnPlayerJoinLobby(arena, cb)
    On(arena, "join", cb)
end

exports("OnPlayerJoinLobby", OnPlayerJoinLobby)

-- will register callback for this event
function OnPlayerExitLobby(arena, cb)
    On(arena, "leave", cb)
end

exports("OnPlayerExitLobby", OnPlayerExitLobby)

-- will register callback for this event
function OnArenaStart(arena, cb)
    On(arena, "start", cb)
end

exports("OnArenaStart", OnArenaStart)

-- will register callback for this event
function OnArenaEnd(arena, cb)
    On(arena, "end", cb)
end

exports("OnArenaEnd", OnArenaEnd)