local crouched = false
local walkSet = "default"

exports["lrp-keymapping"]:registerKeyMapping("Crouch", "Player", "Toggle Crouch", "+Crouch", "-Crouch", "LCONTROL", true)

RegisterCommand("+Crouch", function()
    local ped = PlayerPedId()

    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
        DisableControlAction(0, 36, true) -- INPUT_DUCK  

        if (not IsPauseMenuActive()) then 
            RequestAnimSet("move_ped_crouched")

            while (not HasAnimSetLoaded("move_ped_crouched")) do 
                Citizen.Wait(100)
            end 

            if crouched then 
                local ped = PlayerPedId()
                ResetPedMovementClipset(ped)

                --Wait(100)

                --SetPedMovementClipset(ped, walkSet, 1)
                --ClearPedTasksImmediately(ped)
                crouched = false 
            else
                SetPedMovementClipset(ped, "move_ped_crouched", 0.25)
                crouched = true 
            end 
        end 
    end 
end, false)
