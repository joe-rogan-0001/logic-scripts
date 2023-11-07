RegisterNetEvent('av_cameras:useJammer', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
    if vehicle ~= 0 then
        if Entity(vehicle).state.camera then
            local hacked = hackingMinigame()
            if hacked then
                local plate = GetVehicleNumberPlateText(vehicle)
                TriggerServerEvent('av_cameras:disableVehicle',NetworkGetNetworkIdFromEntity(vehicle), plate)
                TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['camera_removed'],'success')
            end
        else
            TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['no_cameras_nearby'])
        end
    else
        local found = false
        local myCoords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(allCams) do
            local group = Cameras[v['name']]
            local dist = #(myCoords - vector3(group['powerCoords'][1], group['powerCoords'][2], group['powerCoords'][3]))
            if dist <= 100 then
                dist = Round(dist,2)
                TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['signal_found'].." ("..dist.." "..Lang['distance']..")","inform")
                found = true
                break
            end
        end
        if not found then
            TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['no_signal'],"error")
        end
    end
end)

function Round(value, numDecimalPlaces)
    if not numDecimalPlaces then return math.floor(value + 0.5) end
    local power = 10 ^ numDecimalPlaces
    return math.floor((value * power) + 0.5) / (power)
end