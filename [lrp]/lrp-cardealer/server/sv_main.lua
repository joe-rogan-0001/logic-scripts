local WSCore = exports['lrp-core']:GetCoreObject()

WSCore.Functions.CreateCallback("lrp-cardealer:purchaseVehicle", function(source, cb, model, price)
    local src = source
    local player = WSCore.Functions.GetPlayer(src)
    local bank = player.PlayerData.money['bank']
    local plate = GeneratePlate()
    local pData = WSCore.Functions.GetPlayer(src)

    if bank >= price then
        player.Functions.RemoveMoney('bank', price)
        sendlog(src, player, model, price, pData)
        PurchaseCar(src, model, plate)
        cb(true, model, plate)
        return
    end
end)

function PurchaseCar(src, model, plate)
    local model = model
    local plate = plate
    local job = "none"
    local pData = WSCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid

    MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, job, vehicle, hash, mods, plate, fuel, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', {
        pData.PlayerData.license,
        cid,
        job,
        model,  
        GetHashKey(model),
        '{}',
        plate,
        100,
        0
    })
end

function GeneratePlate()
    local plate = math.random(0, 99) .. "" .. GetRandomLetter(3) .. "" .. math.random(0, 999)
    local result = MySQL.Sync.fetchScalar('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
    end
    return plate:upper()
end

local NumberCharset = {}
local Charset = {}

for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end
for i = 65, 90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomLetter(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    else
        return ''
    end
end

function sendlog(src, player, model, price, pData)
    local cid = pData.PlayerData.citizenid
    local license = pData.PlayerData.license

    local send_information = {
        {
            ["color"] = 32264,
            ["title"] = "Logic Roleplay" .."\n**".. "Car Purchased" .."**",
            ["description"] = '**Model**: ' .. model .. '\n **Price**: ' .. price ..'\n\n**IP**: ||'.. GetPlayerEndpoint(src) .. '||\n **Steam**: '.. GetPlayerName(src) .. '\n **License**: ' .. license .. '\n **Citizen ID**: ' .. cid,
            ["footer"] = {
            ["text"] = "Logic Roleplay Logs",
            },
        }
    }
    PerformHttpRequest('https://discord.com/api/webhooks/907671229442437120/4qI3PfhxFnbbr9XO3Crm3ZCneymbhfaMAUlWiMEWTEY_pCOrTxyjki6ZhS_82TgwbOVp', function(err, text, headers) end, 'POST', json.encode({username = 'Car Dealer Logs', embeds = send_information, avatar_url = hook_image}), { ['Content-Type'] = 'application/json' })
end

