Events = {}
ValidEvents = {
    ["join"] = true,
    ["leave"] = true,
    ["end"] = true,
    ["start"] = true,
    ["roundend"] = true,
}

-- Will check and return true/false if the event with identifier exists
--- @param eventName string
function ValidateEvents(eventName)
    return type(eventName) == "string" and ValidEvents[string.lower(eventName)] ~= nil
end

-- Will check and return true/false if the event with identifier exists
--- @param identifier string
--- @param eventName string
function ValidateInvokingEvent(identifier, eventName)
    return Events[identifier] ~= nil and Events[identifier][eventName]
end

-- Will find and remove all events with the
-- name of the resource
--- @param nameResource string
function RemoveEventsWithNameResource(nameResource)
    for identifier, v in pairs(Events) do
        for event, value in pairs(v) do
            for resource, val in pairs(value) do
                if resource == nameResource then
                    Events[identifier][event][resource] = nil
                    break
                end
            end
        end
    end
end

--Register event
--Return true if event is registered, false if is not
function On(identifier, eventName, cb)
    local invokingName = GetInvokingResource()
    eventName = string.lower(eventName)
    if not ValidateEvents(eventName) then
        return false
    end

    if Events[identifier] == nil then
        Events[identifier] = {}
    end

    if Events[identifier][eventName] == nil then
        Events[identifier][eventName] = {}
    end

    if Events[identifier][eventName][invokingName] == nil then
        Events[identifier][eventName][invokingName] = {}
    end
    table.insert(Events[identifier][eventName][invokingName], cb)
    return true
end

--Call event
--- @param identifier string
--- @param eventName string
--- @param ... object
function CallOn(identifier, eventName, ...)
    if ValidateInvokingEvent(identifier, eventName) then
        for key, value in pairs(Events[identifier][eventName]) do
            for k, cb in pairs(value) do
                if type(cb) == "table" or type(cb) == "function" then
                    cb(...)
                end
            end
        end
    end
end
