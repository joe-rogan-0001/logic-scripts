RegisterServerEvent("av_racing:createCircuit", function(data)
    local src = source
    if not CanCreateTracks(src) then return end -- Just an extra check
    local createdby = exports['av_laptop']:getIdentifier(src)
    local identifier = string.lower(data.RaceName)
    identifier = string.gsub(identifier, "%s+", "")
    local checkpoints = json.encode(data['Checkpoints'])
    MySQL.insert('INSERT INTO av_racing (name, identifier, checkpoints, createdby, distance, description, type) VALUES (?, ?, ?, ?, ?, ?, ?)', 
    {data.RaceName, identifier, checkpoints, createdby, data["RaceDistance"], data["RaceDescription"], data['RaceType']}, function(saved)
        if saved then
            TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['saved'])
        end
    end)
end)

RegisterServerEvent('av_racing:updateProfile', function(data)
    local src = source
    local identifier = exports['av_laptop']:getIdentifier(src)
    if Config.Debug then
        print('updateProfile: ', json.encode(data))
    end
    MySQL.update.await('UPDATE av_racing_profiles SET name = ?, photo = ?, settings = ? WHERE identifier = ?', {data['name'], data['photo'], json.encode(data['settings']), identifier})
    TriggerClientEvent('av_laptop:notificationUI',src,Lang['profile_updated'],'success',Lang['app_title'])
end)