local lasthide = false
local hide = true

Citizen.CreateThread(function()
    while true do
        Wait(750)
        local isarmed = IsPedArmed(PlayerPedId(), 4)
        local camview = GetFollowPedCamViewMode()

        if (IsPlayerFreeAiming(PlayerId())) and camview ~= 4 and isarmed then
            SendNUIMessage("xhairShow")
        else
            SendNUIMessage("xhairHide")
        end
    end
end)

RegisterCommand('nui-r', function()
    SendNUIMessage("xhairHide")
end)
