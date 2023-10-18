-- Type (alphabet, numeric, alphanumeric, greek, braille, runes), Time (Seconds), Mirrored (0: Normal, 1: Normal + Mirrored 2: Mirrored only )
local ConfigHacks = {
    ["D"] = {type = "numeric", time = 15, mirrored = 0},
    ["B"] = {type = "numeric", time = 15, mirrored = 0},
    ["C"] = {type = "alphanumeric", time = 15, mirrored = 0},
    ["A"] = {type = "alphanumeric", time = 15, mirrored = 1},
    ["A+"] = {type = "greek", time = 15, mirrored = 0},
    ["S"] = {type = "greek", time = 15, mirrored = 1},
    ["S+"] = {type = "runes", time = 15, mirrored = 1},
}

RegisterNetEvent('av_boosting:trackerMinigame', function()
    local veh = GetVehiclePedIsIn(PlayerPedId(),false)
    if veh ~= 0 then
        if (GetPedVehicleSeat(PlayerPedId()) == 0) then
            local speed = GetEntitySpeed(veh)
            if (speed * 2.236936) < Config.MinSpeedHack then print('not enough speed') return end
            local state = Entity(veh).state
            if state and state.hacks then
                if state.cooldown then
                    TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['hacking_cooldown'],"error")
                    return 
                end
                local class = state.class
                if Config.Debug then
                    print('class '..class..' trigger ps-ui')
                end
                exports['ps-ui']:Scrambler(function(success)
                    if success then
                        local plates = GetVehicleNumberPlateText(veh)
                        local netId = NetworkGetNetworkIdFromEntity(veh)
                        TriggerServerEvent('av_boosting:removeHack',netId,true,true,plates)
                    end
                end, ConfigHacks[class]['type'], ConfigHacks[class]['time'], ConfigHacks[class]['mirrored'])
            else
                if Config.Debug then
                    print('veh doesnt have hacks state')
                end
            end
        else
            if Config.Debug then
                print("Not driver seat, current seat index: "..GetPedVehicleSeat(PlayerPedId()))
            end
        end
    else
        if Config.Debug then
            print('not in vehicle')
        end
    end
end)