#Arena library for Fivem


### ArenaAPI functions

------------

#####Once a new arena is created, it can be acces with command: /minigame join [identifier]

------------

###**Functions (server side)**

------------

### About creating arena and others

------------

- CreateArena(string identifier)  returns module of the arena
  
- GetArenaInstance(string identifier) will return an instance of arena
  
- GetArenaList() will return an array of arenas

- DoesArenaExists(string identifier) true/false

------------

- IsArenaBusy(string identifier) return true / false

- IsArenaActive(string identifier) return true / false

- IsArenaInactive(string identifier) return true / false

- GetArenaState(string identifier) return state of arena<br>
 ```
 ArenaInactive -- no one is in a lobby or arena
 ArenaActive -- people are in lobby
 ArenaBusy -- people playing already
 ```

------------

- IsPlayerInArena(int source, string name)

- IsPlayerInAnyArena(int source)
 
- GetPlayerArena(int source) returns name of the arena, if he isnt anywhere it will return "none" 

------------

### Events

------------

- OnPlayerJoinLobby(cb)<br>
Will be called whenever someone join arena

- OnPlayerExitLobby(cb)<br>
Will be called whenever player leave arena
The array data returns

- OnArenaStart(cb)

- OnArenaEnd(cb)

- OnArenaRoundEnd(cb)

- On(cb)<br>
if the event is join/leave there is first argument source, second is arena instance<br>
for others such a like end,start etc, there is only one argument, and thats the arena instance.
```
{
    MaximumRoundSaved,
    CurrentRound,
    ArenaIdentifier,
    ArenaLabel,
    MaximumCapacity,
    MinimumCapacity,
    CurrentCapacity,
}
```
  
Usage of these events
```LUA
local arenaBuilder = exports.ArenaAPI

local arena = arenaBuilder:GetArenaInstance("MyArena")

arena.PlayerJoinArena(function(data)
    TriggerClientEvent("showNotification", data.source, "Welcome to the arena: " .. data.ArenaLabel)
end)
```

Second example of events
```LUA
local arenaBuilder = exports.ArenaAPI

local arena = arenaBuilder:GetArenaInstance("MyArena")

arena.On("join",function(source, data)
    TriggerClientEvent("showNotification", source, "Welcome to the arena: " .. data.ArenaLabel)
end)
```
  
------------

#All functions bellow are from module, so use it like this

```LUA
local arenaBuilder = exports.ArenaAPI
local arena = arenaBuilder:CreateArena("gungame_1")

arena.SetMaximumCapacity(10) -- maximum player
arena.SetMinimumCapacity(2) -- minimum to start
arena.SetArenaLabel("Gungame arena #1")
```
------------ 

### Setting info about arena

------------
- SetMaximumCapacity(int number)<br>Will set how many people can join to the arena

- SetMinimumCapacity(int number)<br>Will set how many players need to join to start game

- SetArenaMaxRounds(int number)<br>How many rounds this arena will have ?

- SetArenaLabel(string name)

- SetOwnWorld(boolean result) when players join to the arena it will create their own world with other players

- SetMaximumArenaTime(int second) <br>This will set for how long the arena can go, 
if the value isnt set the arena will be there forever

- SetMaximumLobbyTime(int second) <br>
  How long player have to wait in lobby before letting him into the game,
  if player leave the lobby the timer will reset to this value.
  
- SetArenaPublic(boolean value) <br>
if true player will be able to acces arena from command /arena join [name]  
if false that means you will have to use somewhere else this function "AddPlayer(int source)"

- RemoveWorldAfterWin(boolean result) if you have something like winner cutscene, set this on false, but you have to send player into world 0 by your code.

------------

### Getting info about arena

------------

- GetMaximumCapacity()

- GetMinimumCapacity()

- GetMaximumRounds()

- GetCurrentRound()

- GetPlayerCount()

- GetArenaIdentifier()

- GetArenaLabel()

- GetPlayerList()

- GetOwnWorld() return boolean, id of world

- IsArenaPublic() <br>true/false (means if you can acces the arena with command /minigame)

------------

**Player manipulation**

------------

- AddPlayer(int source)

- RemovePlayer(int source)

------------

- Reset()

- Destroy() <br>will destroy arena and new one has to be created

------------

- SetPlayerScore(int source, string key, object value)

- GetPlayerScore(int source, string key)

- GivePlayerScore(int source, string key, object value)

- RemovePlayerScore(int source, string key, object value)

- PlayerScoreExists(int source, string key)

- DeleteScore(int source, string key)

------------

###**Functions (client side)**

------------

- IsPlayerInAnyArena() true/false

- IsPlayerInArena(string arena)

- GetArenaIdentifier()

- GetArenaLabel()

- GetArenaMaximumSize()

- GetArenaMinimumSize()

- GetArenaCurrentSize()

- GetCurrentArenaData() returns array
- GetCurrentArenaData() returns array
```
{
    MaximumRoundSaved,
    CurrentRound,
    ArenaIdentifier,
    ArenaLabel,
    MaximumCapacity,
    MinimumCapacity,
    CurrentCapacity,
}
```
------------

### Events

------------

- OnPlayerJoinLobby(string arena, cb)<br>
Will be called whenever someone join arena

- OnPlayerExitLobby(string arena, cb)<br>
Will be called whenever player leave arena

- OnArenaStart(string arena, cb)<br>
Will be called whenever arena started game

- OnArenaEnd(string arena, cb)<br>
Will be called after arena runs out of time or player achieve enough points

- OnArenaRoundEnd(string arena, cb)

- On(string arena, string eventName, cb)

The array data returns
```
{
    MaximumRoundSaved,
    CurrentRound,
    ArenaIdentifier,
    ArenaLabel,
    MaximumCapacity,
    MinimumCapacity,
    CurrentCapacity,
}
```
  
------------