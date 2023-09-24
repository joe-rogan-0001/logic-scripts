Framework = nil
Config.GetSharedObject(function(obj)
    Framework = obj
end)

Framework.Functions.CreateCallback('ld-phone:check-phone', function(source, cb)
    local ply = Framework.Functions.GetPlayer(source)
    local phone = ply.Functions.GetItemByName('phone')

    if phone ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

Framework.Functions.CreateUseableItem(Config.VPNItem, function(source)
    TriggerClientEvent('ld-phone:client:UseVPN', source)
end)

function GetPlayerByNumber(number1, Framework)
    -- return
    print("loaded function")
    local success = false
    for src, player in pairs(Framework.Players) do --QBCore.Players
        number1 = tonumber(number1)
        local number2 = tonumber(player.PlayerData.charinfo.phone)
        if number2 == number1 then
            success = true
            print("returning player")
            return player
        end
    end
    if not success then
        return nil
    end
    -- You can just use the below if this not working and your cores function working
    -- return Framework.Functions.GetPlayerByNumber(number1)
end

Framework.Functions.CreateCallback('ld-phone:server:SendMoneyToNumber', function(source, cb, number, amount, comment)
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
    local identifier = GetHexId(src)
    local xTarget = GetPlayerByNumber(number, Framework)
    amount = tonumber(amount)
    if xTarget ~= nil then
        local targetidentifier = GetHexId(xTarget.PlayerData.source)
        if Config.Details.Bank.BankMoneyFunction(Framework, source) >= amount then
            Config.PlayerFunctions.addAccountMoney(xPlayer, 'bank', amount)
            Config.PlayerFunctions.addAccountMoney(xTarget, 'bank', amount)
            cb({status = true, text = "Sent " .. amount .. "$"})
            Config.DatabaseStrings["execute"]('INSERT INTO phone_bank_logs (`identifier`, `amount`, `comment`, `type`, `name`) VALUES (@identifier, @amount, @comment, @type, @name)',{
                ['@identifier'] = identifier,
                ['@amount'] = amount,
                ['@comment'] = comment,
                ['@type'] = "send",
                ['@name'] = Config.GetName(xTarget)
            }, function(rowsChanged)
                if rowsChanged.affectedRows > 0 then
                    Config.DatabaseStrings["execute"]('INSERT INTO phone_bank_logs (`identifier`, `amount`, `comment`, `type`, `name`) VALUES (@identifier, @amount, @comment, @type, @name)',{
                        ['@identifier'] = targetidentifier,
                        ['@amount'] = amount,
                        ['@comment'] = comment,
                        ['@type'] = "receive",
                        ['@name'] = Config.GetName(xPlayer)
                    }, function(rowsChanged)
                        if rowsChanged.affectedRows > 0 then
                            TriggerClientEvent('ld-phone:client:UpdateBankLogs', xTarget.PlayerData.source, Config.GetName(xPlayer), amount)
                        end
                    end)
                end
            end)
        else
            cb({status = false, text = "You don't have enough money"})
        end
    else
        print("[LD-PHONE] [ERROR] [SendMoneyToNumber] [Player not found or not online!]")
        cb({status = false, text = "Player not online, or not found!"})
    end
end)

Framework.Functions.CreateCallback('ld-phone:PayInvoice', function(source, cb, billId)
    local xPlayer = Framework.Functions.GetPlayer(source)
    local identifier = GetHexId(source)
    local bill = Config.DatabaseStrings["executeSync"]('SELECT * FROM '..Config.PlayerBillingSettings.DataTableName..' WHERE '..Config.PlayerBillingSettings.IDColumnName..' =  @id', {
        ['@id'] = billId
    })
    if bill[1].amount < Config.Details.Bank.BankMoneyFunction(Framework, source) then 
        Config.DatabaseStrings["execute"]('DELETE FROM '..Config.PlayerBillingSettings.DataTableName..' WHERE '..Config.PlayerBillingSettings.IDColumnName..' = @id',{
            ['@id'] = billId
        }, function(rowsChanged)
            if rowsChanged.affectedRows > 0 then
                --local tPlayer = GetPlayerFromIdentifier(bill[1].sender)
                local tPlayer = Framework.Functions.GetPlayerByCitizenId(bill[1].sendercitizenid)
                if tPlayer then
                    Config.PlayerFunctions.removeAccountMoney(xPlayer, 'bank', bill[1].amount)
                    Config.PlayerFunctions.addAccountMoney(tPlayer, 'bank', bill[1].amount)
                    cb({status = true, text = "Paid " .. bill[1].amount .. "$"})
                elseif bill[1].society then
                    Config.PlayerFunctions.removeAccountMoney(xPlayer, 'bank', bill[1].amount)
                    TriggerEvent('qb-banking:society:server:DepositMoney', source, bill[1].amount, bill[1].society)
                    cb({status = true, text = "Paid " .. bill[1].amount .. "$"})
                else
                    cb({status = false, text = "Player not found"})
                end
            else
                cb({status = false, text = "Something went wrong"})
            end
        end)
    else
        cb({status = false, text = "You don't have enough money"})
    end
end)


Framework.Functions.CreateCallback('ld-phone:GetVehicleFromPlate', function(source, cb, plate)
    local xPlayer = Framework.Functions.GetPlayer(source)
    local result = Config.DatabaseStrings["executeSync"]("SELECT * FROM player_vehicles WHERE plate = @plate", {
        ['@plate'] = plate
    })

    if result[1] ~= nil then
        if result[1].state then
            cb(result[1])
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

Framework.Functions.CreateCallback('ld-phone:GetPlayerVehicles', function(source, cb)
    local Vehicles = {}
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
    print("joe biden")
    local result = Config.DatabaseStrings["executeSync"]('SELECT * FROM '..Config.PlayerVehiclesSettings.DataTableName..' WHERE '..Config.PlayerVehiclesSettings.IdentifierColumnName..' = @identifier', {
        ['@identifier'] = xPlayer.PlayerData.citizenid
    })
    for i = 1, #result do 
        local vehicle = json.decode(result[i][Config.PlayerVehiclesSettings.VehicleModsColumnName])
        table.insert(Vehicles, {
            plate = result[i].plate,
            modelname = result[i].vehicle,
            state = result[i].state,
            fuel = "100",
            engine = "100",
        })
    end
    cb(Vehicles)
end)

function getNumberPhone(identifier)
    local player = Framework.Functions.GetPlayerByCitizenId(identifier)
    if player ~= nil then 
        return Config.GetPhoneNumber(player)
    end
    return nil
end

function GetPlayerFromIdentifier(ide)
    local xPlayers = Framework.Functions.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = Framework.Functions.GetPlayer(xPlayers[i])
        local iden = GetHexId(xPlayers[i])
        if iden == ide then
            return xPlayer
        end
    end
end

function GetHexId(src) --using citizenid rn
    local player = Framework.Functions.GetPlayer(src)

    if player.PlayerData.citizenid ~= nil then
        return player.PlayerData.citizenid
    end

    return nil
    
	-- for k,v in ipairs(GetPlayerIdentifiers(src)) do
	-- 	if string.sub(v, 1, 5) == "steam" then
	-- 		return v
	-- 	end
	-- end
	
	-- return false
end

function getPhoneRandomNumber()
    local numBase0 = 5
    local numBase1 = math.random(30, 59)
    local numBase2 = math.random(111, 999)
    local numBase3 = math.random(1111, 9999)
    local num = string.format(numBase0 .. "" .. numBase1 .. "" .. numBase2 .. "" .. numBase3)
    print(num, "[LD-PHONE] [INFORM] [A user created new number.")
    return num
end

RegisterNetEvent('qb-phone:server:sendNewMail', function(sender, subject, message)
    local src = source
    --TriggerClientEvent('qb-phone:client:recieveMail', src, sender, subject, message)
    exports['ld-phone']:SendMailToPlayer(src, subject, sender, message)
end)
