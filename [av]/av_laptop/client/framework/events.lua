-- Notification
RegisterNetEvent('av_laptop:notification', function(title, description, type)
    lib.defaultNotify({
        title = title,
        description = description,
        status = type
    })
end)

-- Alert Owner Blip n Coords
RegisterNetEvent('av_laptop:alert', function(message,coords)
    TriggerEvent('av_laptop:notification',Lang['alert_title'], message, 'error')
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 161)
    SetBlipScale(blip, 2.0)
    SetBlipColour(blip, 3)
    PulseBlip(blip)
    Wait(60000)
    RemoveBlip(blip)
end)

-- USED TO RETRIEVE THE LOCATION OF THE index.html
-- CreateThread(function()
--     SetNuiFocus(true,true)
--     local resourceName = GetCurrentResourceName()
--     local res = GetResourceMetadata(resourceName, 'ui_page', 0)
-- end)