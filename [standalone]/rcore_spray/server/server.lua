SPRAYS = {}

FastBlacklist = {}

Citizen.CreateThread(function()
    if Config.Blacklist then
        for _, word in pairs(Config.Blacklist) do
            FastBlacklist[word] = word
        end
    end
end)

function GetSprayAtCoords(pos)
    for _, spray in pairs(SPRAYS) do
        if spray.location == pos then
            return spray
        end
    end
end

function AddSpray(Source, spray)
    local i = 1
    while true do
        if not SPRAYS[i] then
            SPRAYS[i] = spray
            break
        else
            i = i + 1
        end
    end

    PersistSpray(spray)

    if spray.text then
        TriggerEvent('rcore_sprays:addSpray', Source, spray.text, spray.location)
    else
        local cfgImg = FastImageMap[spray.imageDict .. spray.image]

        if cfgImg and cfgImg.gangTags then
            if type(cfgImg.gangTags) == 'string' then
                TriggerEvent('rcore_sprays:addSpray', Source, cfgImg.gangTags, spray.location)
            else
                for _, t in pairs(cfgImg.gangTags) do
                    TriggerEvent('rcore_sprays:addSpray', Source, t, spray.location)
                end
            end
        end
    end

    TriggerClientEvent('rcore_spray:addSpray', -1, spray)
end

function StartSpraying(source)
    TriggerClientEvent('rcore_spray:spray', source)

end

function RemoveSprayAtPosition(Source, pos)
    local sprayAtCoords = GetSprayAtCoords(pos)

    if sprayAtCoords.text then
        MySQL.Async.execute([[
                DELETE FROM sprays WHERE origX >= @x1 AND origY >= @y1 AND origZ >= @z1 and origX <= @x2 AND origY <= @y2 AND origZ <= @z2 and text=@text AND font=@font AND color=@color  LIMIT 1
            ]], {
            ['@x1'] = pos.x - 0.1,
            ['@y1'] = pos.y - 0.1,
            ['@z1'] = pos.z - 0.1,
            ['@x2'] = pos.x + 0.1,
            ['@y2'] = pos.y + 0.1,
            ['@z2'] = pos.z + 0.1,
            ['@text'] = sprayAtCoords.text,
            ['@font'] = sprayAtCoords.font,
            ['@color'] = sprayAtCoords.color,
        })
    elseif sprayAtCoords.image then
        MySQL.Async.execute([[
                DELETE FROM sprays WHERE origX >= @x1 AND origY >= @y1 AND origZ >= @z1 and origX <= @x2 AND origY <= @y2 AND origZ <= @z2 AND image=@image AND imageDict=@imageDict LIMIT 1
            ]], {
            ['@x1'] = pos.x - 0.1,
            ['@y1'] = pos.y - 0.1,
            ['@z1'] = pos.z - 0.1,
            ['@x2'] = pos.x + 0.1,
            ['@y2'] = pos.y + 0.1,
            ['@z2'] = pos.z + 0.1,
            ['@image'] = sprayAtCoords.image,
            ['@imageDict'] = sprayAtCoords.imageDict,
            ['@font'] = sprayAtCoords.font,
            ['@color'] = sprayAtCoords.color,
        })
    end

    for idx, s in pairs(SPRAYS) do
        if s.location.x == pos.x and s.location.y == pos.y and s.location.z == pos.z then
            SPRAYS[idx] = nil
        end
    end
    TriggerClientEvent('rcore_spray:removeSpray', -1, pos)

    local sprayAtCoordsAfterRemoval = GetSprayAtCoords(pos)

    -- ensure someone doesnt bug it so its trying to remove other tags
    -- while deducting loyalty from not-deleted-but-at-coords tag
    if sprayAtCoords and not sprayAtCoordsAfterRemoval then
        TriggerEvent('rcore_sprays:removeSpray', Source, sprayAtCoords.text, sprayAtCoords.location)
    end
end

RegisterNetEvent('rcore_spray:addSpray')
AddEventHandler('rcore_spray:addSpray', function(spray)
    local Source = source
    if Framework.STANDALONE then
        AddSpray(Source, spray)
        return
    end

    local xPlayer = ESX.GetPlayerFromId(Source)
    local item = SafeGetItem(xPlayer, "spray")

    if item.count > 0 then
        xPlayer.removeInventoryItem("spray", 1)
        spray.identifier = xPlayer.identifier
        AddSpray(Source, spray)
    else
        ShowNotification(Source, Config.Text.NEED_SPRAY)
    end
end)

function PersistSpray(spray)
    MySQL.Async.execute([[
        INSERT sprays
        (`x`, `y`, `z`, `origX`, `origY`, `origZ`, `rx`, `ry`, `rz`, `scale`, `text`, `imageDict`, `image`, `font`, `color`, `interior`, `identifier`)
        VALUES
        (@x, @y, @z, @origX, @origY, @origZ, @rx, @ry, @rz, @scale, @text, @imageDict, @image, @font, @color, @interior, @identifier)
    ]], {
        ['@x'] = spray.realLocation.x,
        ['@y'] = spray.realLocation.y,
        ['@z'] = spray.realLocation.z,
        ['@origX'] = spray.location.x,
        ['@origY'] = spray.location.y,
        ['@origZ'] = spray.location.z,
        ['@rx'] = spray.realRotation.x,
        ['@ry'] = spray.realRotation.y,
        ['@rz'] = spray.realRotation.z,
        ['@scale'] = spray.scale,
        ['@text'] = spray.text,
        ['@imageDict'] = spray.imageDict,
        ['@image'] = spray.image,
        ['@font'] = spray.font,
        ['@color'] = spray.color,
        ['@interior'] = spray.interior,
        ['@identifier'] = spray.identifier,
    })
end

Citizen.CreateThread(function()
    MySQL.Sync.execute([[
        DELETE FROM sprays 
        WHERE DATEDIFF(NOW(), created_at) >= @days
    ]], { ['days'] = Config.SPRAY_PERSIST_DAYS })

    local results = MySQL.Sync.fetchAll([[
        SELECT x, y, z, origX, origY, origZ, rx, ry, rz, scale, text, imageDict, image, font, color, created_at, interior
        FROM sprays
    ]])

    for _, s in pairs(results) do
        table.insert(SPRAYS, {
            location = vector3(s.origX + 0.0, s.origY + 0.0, s.origZ + 0.0),
            realLocation = vector3(s.x + 0.0, s.y + 0.0, s.z + 0.0),
            realRotation = vector3(s.rx + 0.0, s.ry + 0.0, s.rz + 0.0),
            scale = tonumber(s.scale) + 0.0,
            text = s.text,
            imageDict = s.imageDict,
            image = s.image,
            font = s.font,
            color = s.color,
            interior = (s.interior == 1) and true or false,
        })
    end

    TriggerLatentClientEvent('rcore_spray:setSprays', -1, 1000000, SPRAYS)
end)

RegisterNetEvent('rcore_spray:playerSpawned')
AddEventHandler('rcore_spray:playerSpawned', function()
    local Source = source
    TriggerLatentClientEvent('rcore_spray:setSprays', Source, 1000000, SPRAYS)
end)

if not Framework.STANDALONE then
    Citizen.CreateThread(function()
        while not ESX do Wait(100) end
        ESX.RegisterUsableItem("spray", function(playerId)
            StartSpraying(playerId)
        end)
    end)
end

RegisterCommand('spray', function(source, args)
    if Framework.STANDALONE then
        StartSpraying(source)
        return
    end

    local xPlayer = ESX.GetPlayerFromId(source)
    local item = SafeGetItem(xPlayer, "spray")

    if item.count > 0 then
        StartSpraying(source)
    else
        ShowNotification(source, Config.Text.NEED_SPRAY)
    end
end, false)

function HasSpray(serverId, cb)
    local xPlayer = ESX.GetPlayerFromId(serverId)
    local item = SafeGetItem(xPlayer, "spray")

    cb(item.count > 0)
end

function SafeGetItem(xPlayer, name)
    local item = xPlayer.getInventoryItem(name)

    if item and item[1] and item[1].count then
        return item[1]
    end

    return item
end