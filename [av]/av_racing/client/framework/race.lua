startTime = 0
lapStartTime = 0

RegisterNetEvent("av_racing:start", function(raceInfo)
    if Config.Debug then
        print("av_racing:start event")
    end
    local checkpoints = raceInfo['checkpoints']
    local class = raceInfo['class']
    local laps = raceInfo['laps']
    checkpoints = json.decode(checkpoints)
    if isClose(checkpoints[1]['coords']) then
        if Config.Debug then
            print("ready to race :D")
        end
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 then
            if Config.Debug then
                print("we are in a vehicle (line 19)")
            end
            local myClass = getClass(vehicle)
            if Config.Debug then
                print("My Class: "..string.lower(myClass), "Event Class: "..string.lower(class))
            end
            if string.lower(class) == "all" or string.lower(class) == string.lower(myClass) then
                if Config.Debug then
                    print("we have the needed class yey")
                end
                local model = GetEntityModel(vehicle)
                model = GetLabelText(GetDisplayNameFromVehicleModel(model))
                local netId = NetworkGetNetworkIdFromEntity(vehicle)
                if GetPedVehicleSeat(PlayerPedId()) == -1 then
                    TriggerServerEvent('av_racing:registerVehicle',netId,true)
                end
                TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['countdown'],'success')
                FreezeEntityPosition(vehicle,true)
                if raceInfo['phasing'] then
                    if Config.Debug then
                        print("enable phasing :D")
                    end
                    CreateThread(function()
                        GhostLoop()
                    end)
                end
                if Config.Debug then
                    print("starting countdown (line 43)")
                end
                Wait(10000)
                SendNUIMessage({
                    action = "showCounter",
                    data = true
                })
                Wait(3000)
                if Config.Debug then
                    print("ruuuuunnnn (line 51)")
                end
                lapStartTime = GetGameTimer()
                startTime = GetGameTimer()
                handleFlare(1)
                FreezeEntityPosition(vehicle,false)
                CurrentRaceData.Started = true
                CurrentRaceData.TotalRacers = raceInfo['numRacers']
                CurrentRaceData.VehicleModel = model
                if Config.Debug then
                    print("race should be started now, good luck!")
                end
            else
                if Config.Debug then
                    print("wrong veh class :(")
                end
                TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['wrong_vehicle_class'],'error')
            end
        else
            TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['not_in_vehicle'],"error")
            TriggerEvent('av_racing:wipe')
        end
    else
        if Config.Debug then
            print("too far from the starting line :(")
        end
        lib.callback('av_racing:quitRace', false, function()
            if Config.Debug then
                print("removed from race")
            end
            TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['out_of_range'],"error")
            TriggerEvent('av_racing:wipe')
        end, raceInfo['trackid'])
    end
end)