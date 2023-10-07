QBCore = exports['lrp-core']:GetCoreObject()

function Login.decode(tableString)
    if tableString == nil or tableString =="" then
        return {}
    else
        return json.decode(tableString)
    end
end

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

 function table.empty (self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end

RegisterServerEvent("login:getCharModels")
AddEventHandler("login:getCharModels", function(charlist,isReset)
    local src = source
    local char

    local list = ""
    for i=1,#charlist do
        if i == #charlist then
            list = list.."'"..charlist[i].."'"
        else
            list = list.."'"..charlist[i].."'"..","
        end
    end

    --print(list)

    if charlist == nil or json.encode(charlist) == "[]" then
        TriggerClientEvent("login:CreatePlayerCharacterPeds", src, nil, isReset)
        return
    end

    MySQL.Async.fetchAll("SELECT cc.*, cf.*, ct.* FROM character_face cf LEFT JOIN character_current cc on cc.cid = cf.cid LEFT JOIN playerstattoos ct on ct.identifier = cf.cid WHERE cf.cid IN ("..list..")", {}, function(result)
        if result then
            local temp_data = {}

            --print("temp data")
            --print(dump(temp_data))

            for k,v in pairs(result) do
                temp_data[v.cid] = {
                    model = v.model,
                    drawables = Login.decode(v.drawables),
                    props = Login.decode(v.props),
                    drawtextures = Login.decode(v.drawtextures),
                    proptextures = Login.decode(v.proptextures),
                    hairColor = Login.decode(v.hairColor),
                    headBlend = Login.decode(v.headBlend),
                    headOverlay = Login.decode(v.headOverlay),
                    headStructure = Login.decode(v.headStructure),
                    tattoos = Login.decode(v.tattoos),
                }
                --print(v.cid)
                --print(dump(temp_data[v.cid]))
            end

            for i=1,#charlist do
                if temp_data[charlist[i]] == nil then
                    temp_data[charlist[i]] = nil
                end
            end

            TriggerClientEvent("login:CreatePlayerCharacterPeds",src,temp_data,isReset)
        end
    end)
end)

RegisterServerEvent("SpawnCustomPeds")
AddEventHandler("SpawnCustomPeds", function(modelHash, coords1, coords2, coords3, pedheading)
    newPed = CreatePed(0, modelHash, coords1, coords2, coords3, 0.72, false, false)
    SetEntityHeading(newPed, pedheading)
    TaskPlayAnim(newPed, "timetable@ron@ig_3_couch", "base", 1.0,-2.0, -1, 1, 1, true, true, true)
end)

LoadHouseData = function()
    local HouseGarages = {}
    local Houses = {}
    local result = MySQL.Sync.fetchAll('SELECT * FROM houselocations', {})
    if result[1] ~= nil then
        for k, v in pairs(result) do
            local owned = false
            if tonumber(v.owned) == 1 then
                owned = true
            end
            local garage = v.garage ~= nil and json.decode(v.garage) or {}
            Houses[v.name] = {
                coords = json.decode(v.coords),
                owned = v.owned,
                price = v.price,
                locked = true,
                adress = v.label, 
                tier = v.tier,
                garage = garage,
                decorations = {},
            }
            HouseGarages[v.name] = {
                label = v.label,
                takeVehicle = garage,
            }
        end
    end
    TriggerClientEvent("qb-garages:client:houseGarageConfig", -1, HouseGarages)
    TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Houses)
end

local function GiveStarterItems(source)
    local Player = QBCore.Functions.GetPlayer(source)

    for _, v in pairs(QBCore.Shared.StarterItems) do
        if v.item == 'id_card' then
            local metadata = {
                type = string.format('%s %s', Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname),
                description = string.format('CID: %s  \nBirth date: %s  \nSex: %s  \nNationality: %s',
                Player.PlayerData.citizenid, Player.PlayerData.charinfo.birthdate, Player.PlayerData.charinfo.gender == 0 and 'Male' or 'Female', Player.PlayerData.charinfo.nationality)
            }
            exports.ox_inventory:AddItem(source, v.item, v.amount, metadata)
        elseif v.item == 'driver_license' then
            local metadata = {
                type = 'Class C Driver License',
                description = string.format('First name: %s  \nLast name: %s  \nBirth date: %s',
                Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname, Player.PlayerData.charinfo.birthdate)
            }
            exports.ox_inventory:AddItem(source, v.item, v.amount, metadata)
        else
            exports.ox_inventory:AddItem(source, v.item, v.amount)
        end
    end
end

RegisterNetEvent('mr-characters:server:createCharacter', function(data)
    local src = source
    local newData = {}
    newData.cid = 1
    newData.charinfo = data
    --print(dump(data))
    if QBCore.Player.Login(src, false, newData) then
        print('^2[lrp-characters]^7 '..GetPlayerName(src)..' succesfully made a character!')
        QBCore.Commands.Refresh(src)
        LoadHouseData()
        TriggerClientEvent('apartments:client:setupSpawnUI', src, newData)
        --GiveStarterItems(src)
        --TriggerEvent('QBCore:Server:OnPlayerLoaded')
        --TriggerEvent('iconic-clothingmenu:insert_character_current', src)
	end
end)

RegisterNetEvent('lrp-login:server:starteritem', function()
    local src = source
    GiveStarterItems(src)
end)

RegisterNetEvent('mr-characters:server:loadplayer', function(citizenid)
    local src = source
    --print("loading")
    --print(citizenid)
    QBCore.Player.Login(src, citizenid)
end)

QBCore.Functions.CreateCallback('lrp-spawn:server:getcharacterstuff', function(source, cb)
    Wait(1000)
    local src = source
    local license  = false
    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end
    local result = MySQL.Sync.fetchAll('SELECT * FROM players WHERE license = ?', {license})
    --print(dump(#result))
    cb(result)
end)

QBCore.Functions.CreateCallback('lrp-spawn:server:getcharacterstuffall', function(source, cb)
    local src = source
    local license  = false
    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end
    local result = MySQL.Sync.fetchAll('SELECT * FROM players WHERE license = ?', {license})
    cb(result)
end)

QBCore.Functions.CreateCallback('lrp-spawn:server:myguygotclothing', function(source, cb, cid)
    --print("yo this the data?")
    --print(dump(cid))
    local result = MySQL.Sync.fetchAll('SELECT * FROM character_current WHERE cid = ?', {cid})
    --print(dump(result), " - This is the clothing stuff yo")
    if not table.empty(result) then 
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('lrp-spawn:server:deletecharacter', function(source, cb, citizenid)
    local src = source
    QBCore.Player.DeleteCharacter(src, citizenid)
    cb(true)
end)