#Arena library for Fivem


### ArenaAPI functions

###**Functions (server side)**

------------

### About creating arena and others

------------

- CreateArena(string identifier)  returns module of the arena
  
- GetArenaInstance(string identifier) will return an instance of arena
  
- GetArenaList() will return an array of arenas

- DoesArenaExists(string identifier) true/false

- IsPlayerInArena(int source, string name)

- IsPlayerInAnyArena(int source)
 
- GetPlayerArena(int source) returns name of the arena, if he isnt anywhere it will return "none" 
 
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

### Events

------------

- OnPlayerJoinArena( cb(data) )<br>
Will be called whenever someone join arena

- OnPlayerExitArena( cb(data) )<br>
Will be called whenever player leave arena
The array data returns

- OnArenaStarted( cb(data) )

- OnArenaEnded( cb(data) )
```
{
    ArenaIdentifier,
    ArenaLabel,
    MaximumCapacity,
    MinimumCapacity,
    CurrentCapacity,
    source, -- Started/Ended events doesnt have this argument
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
  
------------

All functions bellow are from module, so use it like this

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

- SetArenaLabel(string name)

- SetMaximumArenaTime(int second) <br>This will set for how long the arena can go, 
if the value isnt set the arena will be there forever

- SetMaximumLobbyTime(int second) <br>
  How long player have to wait in lobby before letting him into the game,
  if player leave the lobby the timer will reset to this value.
  
- SetArenaPublic(boolean value) if true player will be able to acces arena from command /arena join [name]  
if false that means you will have to use somewhere else this function "AddPlayer(int source)"
------------

### Getting info about arena

------------

- GetMaximumCapacity()

- GetMinimumCapacity()

- GetPlayerCount()

- GetArenaIdentifier()

- GetArenaLabel()

- GetPlayerList()

- IsArenaPublic() true/false (means if you can acces the arena with command /minigame)

------------
### Manipulation with arena

------------
**Arena class**

- AddPlayer(int source)

- RemovePlayer(int source)

------------

- Reset()

- Destroy() will destroy arena and new one has to be created

------------
**Player class**

- SetPlayerScore(int source, string key, object value)

- GetPlayerScore(int source, string key)

- GivePlayerScore(int source, string key, object value)

- RemovePlayerScore(int source, string key, object value)

- PlayerScoreExists(int source, string key)

- DeleteScore(int source, string key)

------------

###**Functions (client side)**

------------

### Arena Info

------------

- IsPlayerInAnyArena() true/false

- IsPlayerInArena(string arena)

- GetArenaIdentifier()

- GetArenaLabel()

- GetArenaMaximumSize()

- GetArenaMinimumSize()

- GetArenaCurrentSize()

- GetCurrentArenaData() returns array
```
{
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

- OnPlayerJoinArena(string arena, array data)<br>
Will be called whenever someone join arena

- OnPlayerExitArena(string arena, array data)<br>
Will be called whenever player leave arena

- OnArenaStarted(string arena, array data)<br>
Will be called whenever arena started game

- OnArenaEnded(string arena, array data)<br>
Will be called after arena runs out of time or player achieve enough points

The array data returns
```
{
    ArenaIdentifier,
    ArenaLabel,
    MaximumCapacity,
    MinimumCapacity,
    CurrentCapacity,
}
```
  
------------