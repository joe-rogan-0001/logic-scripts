local enabled = false
local player = false
local veh = 0

-- Main thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if veh ~= 0 then
            -- IsControlPressed(0, 21) and
            if enabled then
                refreshUI()
            end
        else
            Wait(500)
        end
    end
end)


RegisterNetEvent('veh:options')
AddEventHandler('veh:options', function()
    EnableGUI(true)
end)


Citizen.CreateThread(function()
    while true do
        player = PlayerPedId()
        veh = GetVehiclePedIsIn(player, false)

        Wait(2000)
    end
end)

function EnableGUI(enable)
    enabled = enable

    SetCustomNuiFocus(enable, enable)

    SendNUIMessage({
        type = "enablecarmenu",
        enable = enable
    })
end

function checkSeat(player, veh, seatIndex)
    local ped = GetPedInVehicleSeat(veh, seatIndex);
    if ped == player then
        return seatIndex;
    elseif ped ~= 0 then
        return false;
    else
        return true;
    end
end

-- Check vehicles doors etc and send to UI
function refreshUI()
    local settings = {}
    player = GetPlayerPed(-1)
    veh = GetVehiclePedIsIn(player, false)
    if veh ~= 0 then
        settings.seat1 = checkSeat(player, veh, -1)
        settings.seat2 = checkSeat(player, veh,  0)
        settings.seat3 = checkSeat(player, veh,  1)
        settings.seat4 = checkSeat(player, veh,  2)

        settings.doorAccess = settings.seat1 == -1 and true or false
        if GetVehicleDoorAngleRatio(veh, 0) ~= 0 then
            settings.door0 = true
        end
        if GetVehicleDoorAngleRatio(veh, 1) ~= 0 then
            settings.door1 = true
        end
        if GetVehicleDoorAngleRatio(veh, 2) ~= 0 then
            settings.door2 = true
        end
        if GetVehicleDoorAngleRatio(veh, 3) ~= 0 then
            settings.door3 = true
        end
        if GetVehicleDoorAngleRatio(veh, 4) ~= 0 then
            settings.hood = true
        end
        if GetVehicleDoorAngleRatio(veh, 5) ~= 0 then
            settings.trunk = true
        end

        if not IsVehicleWindowIntact(veh, 0) then
            settings.windowr1 = true
        end
        if not IsVehicleWindowIntact(veh, 1) then
            settings.windowl1 = true
        end
        if not IsVehicleWindowIntact(veh, 2) then
            settings.windowr2 = true
        end
        if not IsVehicleWindowIntact(veh, 3) then
            settings.windowl2 = true
        end

        local engine = GetIsVehicleEngineRunning(veh);
        -- local lockStatus = GetVehicleDoorLockStatus(veh)
        -- if (lockStatus == 1 or lockStatus == 0) and settings.seat1 == -1 then
        --     settings.engineAccess = true
        -- end
        if engine then
            settings.engine = true
        else
            settings.engine = false
        end

        SendNUIMessage({
            type = "refreshcarmenu",
            settings = settings
        })
    else
        SendNUIMessage({
            type = "resetcarmenu"
        })
    end
end

RegisterNUICallback('openDoor', function(data, cb)
    doorIndex = tonumber(data['doorIndex'])
    player = GetPlayerPed(-1)
    veh = GetVehiclePedIsIn(player, false)

    if veh ~= 0 then
        -- if doors are unlocked?
        -- if not GetVehicleDoorsLockedForPlayer(veh, player) then
        local lockStatus = GetVehicleDoorLockStatus(veh)
        if lockStatus == 1 or lockStatus == 0 then
            if (GetVehicleDoorAngleRatio(veh, doorIndex) == 0) then
                SetVehicleDoorOpen(veh, doorIndex, false, false)
            else
                SetVehicleDoorShut(veh, doorIndex, false)
            end
        end
    end
    cb('ok')
end)

RegisterNUICallback('switchSeat', function(data, cb)
    SeatControl(tonumber(data['seatIndex']))
    cb('ok')
end)

function SeatControl(seat)
	local playerPed = PlayerPedId()
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if IsVehicleSeatFree(vehicle, seat) then
			SetPedIntoVehicle(PlayerPedId(), vehicle, seat)
		end
	end
end

TriggerEvent('chat:addSuggestion', '/seat', 'Move to a seat', {
    { name="ID", help="1) Driver, 2) Passenger, 3) Driver Side Rear, 4) Passenger Side Rear" }
})

RegisterCommand("seat", function(source, args, rawCommand)
    local seatID = tonumber(args[1])
    if seatID ~= nil then
        if seatID == 1 then
            SeatControl(-1)
        elseif seatID == 2 then
            SeatControl(0)
        elseif seatID == 3 then
            SeatControl(1)
        elseif seatID == 4 then
            SeatControl(2)
        end
    else
        TriggerEvent("chatMessage", "Usage: ", {255, 0, 0}, "/seat [seat id]")
    end
end, false)

RegisterNUICallback('togglewindow', function(data, cb)
    windowIndex = tonumber(data['windowIndex'])
    player = GetPlayerPed(-1)
    veh = GetVehiclePedIsIn(player, false)
    if veh ~= 0 then
        if not IsVehicleWindowIntact(veh, windowIndex) then
            RollUpWindow(veh, windowIndex)
            if not IsVehicleWindowIntact(veh, windowIndex) then
                RollDownWindow(veh, windowIndex)
            end
        else
            RollDownWindow(veh, windowIndex)
        end
    end
    cb('ok')
end)

RegisterNUICallback('toggleengine', function(data, cb)
    local enginerunning = GetIsVehicleEngineRunning(GetVehiclePedIsIn(PlayerPedId(), false))
    enginerunning = not enginerunning
    SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), false), enginerunning, false, true)
    cb('ok')
end)

 RegisterNUICallback('escape', function(data, cb)
    EnableGUI(false)
    cb('ok')
end)


function SetCustomNuiFocus(hasKeyboard, hasMouse)
--   HasNuiFocus = hasKeyboard or hasMouse

  SetNuiFocus(hasKeyboard, hasMouse)
--   SetNuiFocusKeepInput(HasNuiFocus)

--   TriggerEvent("np-voice:focus:set", HasNuiFocus, hasKeyboard, hasMouse)
end