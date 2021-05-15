----------------------------------------
--- Variables
----------------------------------------
ArenaList = {}
PlayerInfo = {}
CooldownPlayers = {}
WorldCount = 0
----------------------------------------
--- Functions
----------------------------------------
-- Arena creator helper, will set all default variables.
--- @param identifier string
--- @param identifier bool
function ArenaCreatorHelper(identifier, ignore)
    if ArenaList[identifier] ~= nil then return ArenaList[identifier] end
    if not ignore then
        ArenaList[identifier] = {
            MaximumCapacity = 0,
            MinimumCapacity = 0,
            CurrentCapacity = 0,
            -----
            MaximumRoundSaved = nil,
            CurrentRound = nil,
            -----
            DeleteWorldAfterWin = true,
            OwnWorld = false,
            OwnWorldID = 0,
            -----
            ArenaLabel = "",
            ArenaIdentifier = identifier,
            -----
            MaximumArenaTime = nil,
            MaximumArenaTimeSaved = nil,
            MaximumLobbyTimeSaved = 30,
            MaximumLobbyTime = 30,
            -----
            ArenaIsPublic = true,
            -----
            PlayerList = {},
            PlayerScoreList = {},
            PlayerNameList = {},
            -----
            ArenaState = "ArenaInactive",
            -----
        }
        TriggerClientEvent("ArenaAPI:sendStatus", -1, "updateData", ArenaList)
    end
    return ArenaList[identifier]
end

-- Will return data from "ArenaCreatorHelper" if arena does not exists
-- it will return nil value
--- @param identifier string
function GetDefaultDataFromArena(identifier)
    return ArenaCreatorHelper(identifier, true)
end

-- Well this will just send chat message to... player :D
--- @param source int
--- @param string string
function SendMessage(source, string)
    TriggerClientEvent('chat:addMessage', source, {
        color = { 255, 255, 255 },
        multiline = true,
        args = { "[ArenaAPI]", string }
    })
end

-- This is command to handle logic for joining/leaving + blocking joining arena lobby
RegisterCommand("minigame", function(source, args, rawCommand)
    if args[1] == "join" then
        local arenaName = args[2]
        if not IsPlayerInAnyArena(source) then
            if DoesArenaExists(arenaName) then
                local arenaInfo = GetDefaultDataFromArena(arenaName)
                local arena = GetArenaInstance(arenaName)
                if arena.IsArenaPublic() then
                    if not IsArenaBusy(arenaName) then
                        if arenaInfo.MaximumCapacity > arenaInfo.CurrentCapacity then
                            if not IsPlayerInCooldown(source, arenaName) then
                                arena.MaximumLobbyTime = arena.MaximumLobbyTimeSaved
                                GetArenaInstance(args[2]).AddPlayer(source)
                                SendMessage(source, Config.MessageList["arena_joined"])
                            else
                                SendMessage(source, string.format(Config.MessageList["cooldown_to_join"], TimestampToString(GetcooldownForPlayer(source, arenaName))))
                            end
                        else
                            SendMessage(source, Config.MessageList["maximum_people"])
                        end
                    else
                        SendMessage(source, Config.MessageList["arena_busy"])
                    end
                else
                    SendMessage(source, Config.MessageList["cant_acces_this_arena"])
                end
            else
                SendMessage(source, Config.MessageList["arena_doesnt_exists"])
            end
        else
            SendMessage(source, Config.MessageList["player_in_arena"])
        end
    end
    if args[1] == "leave" then
        if IsPlayerInAnyArena(source) then
            local arenaName = GetPlayerArena(source)
            if DoesArenaExists(arenaName) then
                local arena = GetArenaInstance(arenaName)
                CooldownPlayer(source, arenaName, Config.TimeCooldown)
                arena.MaximumLobbyTime = arena.MaximumLobbyTimeSaved

                GetArenaInstance(arenaName).RemovePlayer(source)
                SendMessage(source, Config.MessageList["arena_left"])
            end
        else
            SendMessage(source, Config.MessageList["player_isnt_in_arena"])
        end
    end
end, false)