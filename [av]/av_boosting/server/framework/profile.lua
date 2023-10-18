RegisterServerEvent('av_boosting:updateName', function(name)
    local src = source
    local identifier = exports['av_laptop']:getIdentifier(src)
    if string.len(name) > Config.MaxUsernameCharacters then
        TriggerClientEvent('av_laptop:notificationUI',src,Lang['too_long'],'error',Lang['app_title'])
        return
    end
    local exists = MySQL.query.await('SELECT * FROM av_boosting WHERE name = ?', {
        name
    })
    if exists and exists[1] then
        TriggerClientEvent('av_laptop:notificationUI',src,Lang['already_registered'],'error',Lang['app_title'])
        return
    end
    MySQL.update.await('UPDATE av_boosting SET name = ? WHERE identifier = ?', {
        name, identifier
    })
    TriggerClientEvent('av_laptop:notificationUI',src,Lang['profile_updated'],'success',Lang['app_title'])
    TriggerClientEvent('av_laptop:updateName',src,name)
end)

RegisterServerEvent('av_boosting:updateAvatar', function(avatar)
    local src = source
    local identifier = exports['av_laptop']:getIdentifier(src)
    MySQL.update.await('UPDATE av_boosting SET photo = ? WHERE identifier = ?', {
        avatar, identifier
    })
end)