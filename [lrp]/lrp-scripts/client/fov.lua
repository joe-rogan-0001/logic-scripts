local INPUT_AIM = 0
local INPUT_AIM = 0
local UseFPS = false
local justpressed = 0

-- this prevents certain camera modes
local disable = 0
Citizen.CreateThread( function()

  while true do    
    
    Citizen.Wait(0)


        if IsControlPressed(0, INPUT_AIM) then
          justpressed = justpressed + 1
        end

        if IsControlJustReleased(0, INPUT_AIM) then

        	if justpressed < 15 then
        		UseFPS = true
        	end
        	justpressed = 0
        end

        if GetFollowPedCamViewMode() == 1 or GetFollowVehicleCamViewMode() == 1 then
        	Citizen.Wait(1)
        	SetFollowPedCamViewMode(0)
        	SetFollowVehicleCamViewMode(0)
        end


        if UseFPS then
        	if GetFollowPedCamViewMode() == 0 or GetFollowVehicleCamViewMode() == 0 then
        		Citizen.Wait(0)
        		
        		SetFollowPedCamViewMode(4)
        		SetFollowVehicleCamViewMode(4)
        	else
        		Citizen.Wait(0)
        		
        		SetFollowPedCamViewMode(0)
        		SetFollowVehicleCamViewMode(0)
        	end
    		UseFPS = false
        end


        if IsPedArmed(ped,1) or not IsPedArmed(ped,7) then
            if IsControlJustPressed(0,24) or IsControlJustPressed(0,141) or IsControlJustPressed(0,142) or IsControlJustPressed(0,140)  then
               disable = 50
            end
        end

        if disable > 0 then
            disable = disable - 1
            DisableControlAction(0,24)
            DisableControlAction(0,140)
            DisableControlAction(0,141)
            DisableControlAction(0,142)
        end

        SetVehicleDensityMultiplierThisFrame(10.0)
	    SetPedDensityMultiplierThisFrame(10.0)
		SetRandomVehicleDensityMultiplierThisFrame(10.0)
	    SetParkedVehicleDensityMultiplierThisFrame(10.0)
		SetScenarioPedDensityMultiplierThisFrame(10.0, 10.0)

		-- hide parts of hud
        HideHudComponentThisFrame(1)
        HideHudComponentThisFrame(2)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        -- HideHudComponentThisFrame(5)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(10)
        HideHudComponentThisFrame(11)
        HideHudComponentThisFrame(12)
        HideHudComponentThisFrame(13)
        HideHudComponentThisFrame(14)
        HideHudComponentThisFrame(15)
        --HideHudComponentThisFrame(16)
        HideHudComponentThisFrame(17)
        HideHudComponentThisFrame(18)
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        -- HideHudComponentThisFrame(21)
        -- HideHudComponentThisFrame(22)

        HudWeaponWheelIgnoreSelection()  -- CAN'T SELECT WEAPON FROM SCROLL WHEEL
		DisableControlAction(1, 37)
		DisplayAmmoThisFrame(true)
  end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedArmed(PlayerPedId(), 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
    end
end)

AddEventHandler('baseevents:enteredVehicle', function(_, _, _, _, pModel)
    if IsThisModelABike(pModel) then
        return
    end
    VehicleAiming(true)
end)

AddEventHandler('baseevents:leftVehicle', function(_, _, _, _, pModel)
    VehicleAiming(false)
end)

local isInVehicle = false
function VehicleAiming(pIsInVehicle)
    isInVehicle = pIsInVehicle
    if not isInVehicle then
        return
    end
    Citizen.CreateThread( function()
        while isInVehicle do
            playerPed = PlayerPedId()
            if IsPedArmed(playerPed, 6) then
                if IsPedDoingDriveby(playerPed)  then
                    if GetFollowPedCamViewMode() == 0 or GetFollowVehicleCamViewMode() == 0 then
                        local curWeapon = GetSelectedPedWeapon(playerPed)
                        --SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
                        --SetCurrentPedVehicleWeapon(playerPed, `WEAPON_UNARMED`)
                        --SetPlayerCanDoDriveBy(PlayerId(),false)
                        SetFollowPedCamViewMode(4)
                        SetFollowVehicleCamViewMode(4)
                        --Wait(250)
                        --SetCurrentPedWeapon(playerPed, curWeapon, true)
                        --SetCurrentPedVehicleWeapon(playerPed, curWeapon)
                        --SetPlayerCanDoDriveBy(PlayerId(),true)
                    end
                else
                    DisableControlAction(0,36,true)
                    if GetPedStealthMovement(playerPed) == 1 then
                        SetPedStealthMovement(playerPed,0)
                    end
                end
            end
            Wait(1)
        end
    end)
end