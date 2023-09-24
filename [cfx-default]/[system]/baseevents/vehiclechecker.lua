local Player, PlayerPed, IsDead

local CurrentVehicle, PreviousVehicle, CurrentSeat, PreviousSeat, IsEnteringVehicle, IsInVehicle, IsEngineOn

local hotreload, res, evname = 'on', 'baseevents:', 'hotreload'

hotreload = hotreload .. 'Client'

Citizen.CreateThread(function()

    while true do
        Player = PlayerId()
        PlayerPed = PlayerPedId()
        IsDead = IsPlayerDead(Player)

        Citizen.Wait(1500)
    end
end)

hotreload = hotreload .. 'Resource'

Citizen.CreateThread(function()
    while true do
        if not IsInVehicle then
            local vehicle = GetVehiclePedIsIn(PlayerPed)
            local vehicleIsTryingToEnter = vehicle == 0 and GetVehiclePedIsTryingToEnter(PlayerPed) or 0

            if vehicleIsTryingToEnter ~= 0 and not IsEnteringVehicle then
				-- Trying to enter a vehicle
                IsEnteringVehicle = true

                local seat = GetSeatPedIsTryingToEnter(PlayerPed)
                local netId = NetworkGetNetworkIdFromEntity(vehicleIsTryingToEnter)
                local model = GetEntityModel(vehicleIsTryingToEnter)
				local class = GetVehicleClass(vehicleIsTryingToEnter)

                TriggerEvent('baseevents:enteringVehicle', vehicleIsTryingToEnter, seat, class, model)
                TriggerServerEvent('baseevents:enteringVehicle', netId, seat, class, model)
            elseif IsEnteringVehicle and vehicleIsTryingToEnter == 0 and vehicle == 0 then
                -- Vehicle entering aborted
                IsEnteringVehicle = false

                TriggerEvent('baseevents:enteringAborted')
				TriggerServerEvent('baseevents:enteringAborted')
            elseif vehicle ~= 0 then
                -- Entered a vehicle
                IsInVehicle = true
                IsEnteringVehicle = false

				local class = GetVehicleClass(vehicle)
                local netId = NetworkGetNetworkIdFromEntity(vehicle)
                local model = GetEntityModel(vehicle)
                local name = GetDisplayNameFromVehicleModel(model)

                CurrentBodyHealth, PreviousBodyHealth, CurrentSpeed, PreviousSpeed, CurrentVelocity, PreviousVelocity = nil

                CurrentVehicle = vehicle
                CurrentSeat = GetPedVehicleSeat(PlayerPed)

				TriggerEvent('baseevents:enteredVehicle', vehicle, CurrentSeat, name, class, model)
				TriggerServerEvent('baseevents:enteredVehicle', netId, CurrentSeat, name, class, model)
            end
        elseif IsInVehicle then
            PreviousVehicle = CurrentVehicle
            PreviousSeat = CurrentSeat

            CurrentVehicle = GetVehiclePedIsIn(PlayerPed)
            CurrentSeat = GetPedVehicleSeat(PlayerPed)

            if CurrentVehicle == 0 then
                -- Player left vehicle
                IsLeavingVehicle = false
                IsInVehicle = false
                IsEngineOn = false

                local class = GetVehicleClass(PreviousVehicle)
                local netId = NetworkGetNetworkIdFromEntity(PreviousVehicle)
                local model = GetEntityModel(PreviousVehicle)
                local name = GetDisplayNameFromVehicleModel(model)

				TriggerEvent('baseevents:leftVehicle', PreviousVehicle, PreviousSeat, name, class, model)
				TriggerServerEvent('baseevents:leftVehicle', netId, PreviousSeat, name, class, model)
            elseif PreviousVehicle and PreviousVehicle ~= 0 and PreviousVehicle ~= CurrentVehicle then
                -- Player changed vehicle
                IsEngineOn = false

                CurrentBodyHealth, PreviousBodyHealth, CurrentSpeed, PreviousSpeed, CurrentVelocity, PreviousVelocity = nil

                local previousClass = GetVehicleClass(PreviousVehicle)
                local previousNetId = NetworkGetNetworkIdFromEntity(PreviousVehicle)
                local previousModel = GetEntityModel(PreviousVehicle)
                local previousName = GetDisplayNameFromVehicleModel(previousModel)

                TriggerEvent('baseevents:leftVehicle', PreviousVehicle, PreviousSeat, previousName, previousClass, previousModel)
                TriggerServerEvent('baseevents:leftVehicle', previousNetId, PreviousSeat, previousName, previousClass, previousModel)

                local currentClass = GetVehicleClass(CurrentVehicle)
                local currentNetId = NetworkGetNetworkIdFromEntity(CurrentVehicle)
                local currentModel = GetEntityModel(CurrentVehicle)
                local currentName = GetDisplayNameFromVehicleModel(currentModel)

                TriggerEvent('baseevents:enteredVehicle', CurrentVehicle, CurrentSeat, currentName, currentClass, currentModel)
                TriggerServerEvent('baseevents:enteredVehicle', currentNetId, CurrentSeat, currentName, currentClass, currentModel)
            elseif PreviousSeat and PreviousSeat ~= -2 and CurrentSeat ~= PreviousSeat then
                local netId = NetworkGetNetworkIdFromEntity(CurrentVehicle)
                TriggerEvent('baseevents:vehicleChangedSeat', CurrentVehicle, CurrentSeat, PreviousSeat)
                TriggerServerEvent('baseevents:vehicleChangedSeat', netId, CurrentSeat, PreviousSeat)
            elseif not IsEngineOn and IsVehicleEngineOn(CurrentVehicle) then
                IsEngineOn = true
                TriggerEvent('baseevents:vehicleEngineOn', CurrentVehicle, CurrentSeat)
            elseif IsEngineOn and not IsVehicleEngineOn(CurrentVehicle) then
                IsEngineOn = false
                TriggerEvent('baseevents:vehicleEngineOff', CurrentVehicle, CurrentSeat)
            elseif not IsLeavingVehicle and GetIsTaskActive(PlayerPed, 2) then
                IsLeavingVehicle = true
                TriggerEvent('baseevents:leavingVehicle', CurrentVehicle, CurrentSeat)
            elseif IsLeavingVehicle and not GetIsTaskActive(PlayerPed, 2) then
                IsLeavingVehicle = false
                TriggerEvent('baseevents:leavingAborted', CurrentVehicle, CurrentSeat)
            end
        end

        Citizen.Wait(100)
    end
end)

hotreload = hotreload .. 'Stop'

function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
        if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
    end
    return -2
end

AddEventHandler("onResourceStart", function(resource)
    TriggerEvent('baseevents:vehicleHotreload', CurrentVehicle, CurrentSeat, IsEngineOn)
    TriggerServerEvent('baseevents:vehicleHotreload', CurrentVehicle, CurrentSeat, IsEngineOn)
end)

AddEventHandler(hotreload, function(resource)
    TriggerEvent(res .. evname, resource)
    TriggerServerEvent(res .. evname, resource)
end)