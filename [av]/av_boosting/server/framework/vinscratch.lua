lib.callback.register('av_boosting:checkVinscratch', function(source)
    local owned = 0
    local identifier = exports['av_laptop']:getIdentifier(source)
    local field = "citizenid"
    if Config.Framework == "ESX" then
        field = "owner"
    end
    local query = MySQL.query.await('SELECT * FROM '..Config.VehicleTable..' WHERE vinscratch = ? AND '..field..' = ?', {1, identifier})
    if query and query[1] then
        owned = #query
    end
    return owned
end)

lib.callback.register('av_boosting:getVinStatus', function(source, plate)
    local found = false
    local exists = MySQL.single.await('SELECT * FROM '..Config.VehicleTable..' WHERE plate = ?', {plate})
    if exists and tonumber(exists['vinscratch']) == 1 then
        found = true
    end
    return found
end)

lib.callback.register('av_boosting:saveVin', function(source, props, model)
    local src = source
    local Player = exports['av_laptop']:getPlayer(src)
    local oldPlate = props.plate
    local myProps = props
    local fuel = 100
    myProps.plate = NewPlate()
    if not ContractExpired(oldPlate) then
        if Config.Framework == "QBCore" then
            MySQL.insert.await('INSERT INTO '..Config.VehicleTable..' (license, citizenid, vehicle, hash, mods, plate, fuel, vinscratch) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                Player.PlayerData.license,
                Player.PlayerData.citizenid,
                model,
                GetHashKey(model),
                json.encode(myProps),
                myProps.plate,
                fuel,
                1
            })
        elseif Config.Framework == "ESX" then
            local identifier = Player.getIdentifier()
            MySQL.insert.await('INSERT INTO '..Config.VehicleTable..' (owner, plate, vehicle, vinscratch) VALUES (?, ?, ?, ?)', {
                identifier,
                myProps.plate,
                json.encode(myProps),
                1
            })
        end
        WipeContract(src,oldPlate)
        return myProps.plate
    end
    TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['vin_expired'],'error')
    WipeContract(src,oldPlate)
    return false
end)

function NewPlate()
    local plate = RandomStr(2)..''..RandomInt(2)..''..RandomStr(1)..''..RandomInt(3)
    local res = MySQL.query.await('SELECT * FROM '..Config.VehicleTable..' WHERE plate = ?', {plate})
    if res and res[1] then
        return NewPlate()
    else
        return string.upper(plate)
    end
end