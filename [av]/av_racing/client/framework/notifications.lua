local notifyMe = false

RegisterNUICallback('notifications', function(data,cb)
    notifyMe = data
    if notifyMe then
        TriggerEvent('av_laptop:notificationUI',Lang['notifications_on'], "success", Lang['app_title'])
    else
        TriggerEvent('av_laptop:notificationUI',Lang['notifications_off'], "error", Lang['app_title'])
    end
    cb('ok')
end)

RegisterNetEvent('av_racing:newRace', function()
    if notifyMe then
        TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['new_event'])
    end
end)

RegisterCommand('racing:off', function() -- Forgot to remove notifications and player doesn't own a laptop item anymore?
    notifyMe = false
end)