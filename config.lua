Config = {}

-- Message list
Config.MessageList = {
    ["arena_doesnt_exists"] = "The arena doesnt exists",
    ["player_isnt_in_arena"] = "You cant leave any arena because you are not in any arena",
    ["player_in_arena"] = "You cant join any arena, first you need to leave the current arena",
    ["arena_joined"] = "You joined arena, wait till the game will be ready",
    ["arena_left"] = "You left arena, you dont need to wait anymore for anything.",
    ["maximum_people"] = "This arena is at it maximum capacity!",
    ["cant_acces_this_arena"] = "You cant acces this arena, this arena is privte.",
    ["arena_busy"] = "This arena is busy, you have to wait until the arena is finished playing.",
    ["cooldown_to_join"] = "You need to wait before joining to this arena! Wait till %s to join!",
}

-- your current time zone
Config.TimeZone = 1

-- How many seconds player will have to wait before trying to join same lobby after leaving ?
-- This will prevent trollers from trying to stop the lobby start.
Config.TimeCooldown = 25