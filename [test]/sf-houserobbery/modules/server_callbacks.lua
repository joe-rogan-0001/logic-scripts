EventHandlers = {}
ServerCallbacks = {}

function RegisterServerCallback(callbackName, cb)
    ServerCallbacks[callbackName] = cb
    if(EventHandlers[callbackName]) then
        print("Overwriting callback: "..callbackName)
        RemoveEventHandler(EventHandlers[callbackName])
    end
    EventHandlers[callbackName] = RegisterNetEvent(("%s:callback_s:%s"):format(GetCurrentResourceName(), callbackName), function(callbackId, ...)
        TriggerClientEvent(("%s:callback_s:return"):format(GetCurrentResourceName()), source, callbackId, ServerCallbacks[callbackName](source, ...))
    end)
end

ActiveCallbacks = {}
PlayerCallbacks = {}
CallbackId = 0

AddEventHandler('playerDropped', function(reason)
    local _source = source
    if(PlayerCallbacks[tostring(_source)]) then
        for callbackId, _ in pairs(PlayerCallbacks[tostring(_source)]) do
            ActiveCallbacks[callbackId]:resolve({nil})
        end
        PlayerCallbacks[tostring(_source)] = nil
    end
end)

function TriggerClientCallback(callbackName, source, ...)
    CallbackId += 1
    local callbackId = CallbackId
    if(not PlayerCallbacks[tostring(source)]) then PlayerCallbacks[tostring(source)] = {} end
    PlayerCallbacks[tostring(source)][tostring(callbackId)] = true

    ActiveCallbacks[tostring(callbackId)] = promise.new()
    TriggerClientEvent(("%s:callback_c:%s"):format(GetCurrentResourceName(), callbackName), source, callbackId, ...)
    return table.unpack(Citizen.Await(ActiveCallbacks[tostring(callbackId)]))
end

RegisterNetEvent(("%s:callback_c:return"):format(GetCurrentResourceName()), function(callbackId, ...)
    if(not ActiveCallbacks[tostring(callbackId)]) then return end
    ActiveCallbacks[tostring(callbackId)]:resolve({...})
    ActiveCallbacks[tostring(callbackId)] = nil
    if(PlayerCallbacks[tostring(source)]) then
        PlayerCallbacks[tostring(source)][tostring(callbackId)] = nil
    end
end)