QBCore = exports['lrp-core']:GetCoreObject()

--Event to Remove Money from player upon failed attempt at theoritical test
RegisterServerEvent('qb-dmv:theorypaymentfailed')
AddEventHandler('qb-dmv:theorypaymentfailed', function()
    local amount = Config.Amount['theoretical']/2
	local _source = source
	local Player = QBCore.Functions.GetPlayer(_source)
    Player.Functions.RemoveMoney(Config.PaymentType, amount)
    TriggerClientEvent('QBCore:Notify', "You paid $"..amount.."","success")
    TriggerClientEvent('QBCore:Notify', "You failed the test. Please try again!", "error")
end)

--Event to Remove Money and Add Item upon successful attempt at theoritical test
RegisterServerEvent('qb-dmv:theorypaymentpassed')
AddEventHandler('qb-dmv:theorypaymentpassed', function()
    if Config.DriversTest then
        local info = {}
        local _source = source
        local Player = QBCore.Functions.GetPlayer(_source)
        local licenseTable = Player.PlayerData.metadata['licences']
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "Drivers Permit"
        licenseTable['permit'] = true
        Player.Functions.SetMetaData('licences', licenseTable)
        Player.Functions.RemoveMoney(Config.PaymentType, Config.Amount['theoretical'])
        if Config.GiveItem then

            exports.ox_inventory:AddItem(src, 'permit', 1, {description = 'First Name:  ' ..info.firstname..'\n\n Last Name:  '..info.lastname..'\n\n Birth Date:  '..info.birthdate..'\n\n License Type:  ' ..info.type .. ' '})
            TriggerClientEvent('QBCore:Notify', "You passed and got your Permit", "success")
            TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['driver_license'], 'add')
        else
            TriggerClientEvent('QBCore:Notify', "You passed the test. Go to City to get your Permit")
        end
        TriggerClientEvent('QBCore:Notify', "You paid $"..Config.Amount['theoretical'], "success")
    elseif Config.DriversTest == false then
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "Class C Driver License"
        local licenseTable = Player.PlayerData.metadata['licences']
        licenseTable['driver'] = true
        Player.Functions.SetMetaData('licences', licenseTable)
        Player.Functions.RemoveMoney(Config.PaymentType, Config.Amount['driving'])
        if Config.GiveItem then
            exports.ox_inventory:AddItem(src, 'driver_license', 1, {description = 'First Name:  ' ..info.firstname..'\n\n Last Name:  '..info.lastname..'\n\n Birth Date:  '..info.birthdate..'\n\n License Type:  ' ..info.type .. ' '})
            TriggerClientEvent('QBCore:Notify', "You passed and got your Drivers License", "success")
            TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['driver_license'], 'add')
        else
            TriggerClientEvent('QBCore:Notify', "You passed! Go to City Hall and get your Drivers License")
        end
        TriggerClientEvent('QBCore:Notify', "You paid $"..Config.Amount['driving'],"success")
        
    end
end)

RegisterServerEvent('qb-dmv:driverpaymentpassed')
AddEventHandler('qb-dmv:driverpaymentpassed', function ()
    if Config.DriversTest then
        local info = {}
        local _source = source
        local Player = QBCore.Functions.GetPlayer(_source)
        local licenseTable = Player.PlayerData.metadata['licences']
        info.citizenid = Player.PlayerData.citizenid
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.gender = Player.PlayerData.charinfo.gender
        info.nationality = Player.PlayerData.charinfo.nationality
        licenseTable['driver'] = true
        Player.Functions.SetMetaData('licences', licenseTable)
        Player.Functions.RemoveMoney(Config.PaymentType, Config.Amount['driving'])
        if Config.GiveItem == true then
            exports.ox_inventory:AddItem(src, 'driver_license', 1, {description = 'First Name:  ' ..info.firstname..'\n\n Last Name:  '..info.lastname..'\n\n Birth Date:  '..info.birthdate..'\n\n License Type:  ' ..info.type .. ' '})
            TriggerClientEvent('QBCore:Notify', "You passed the Drivers Test and got your Drivers License", "success")
            TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['driver_license'], 'add')
        else
            TriggerClientEvent('QBCore:Notify', "You passed the Drivers Test. Go to City Hall to get your License")
        end
        TriggerClientEvent('QBCore:Notify', "You paid $"..Config.Amount['driving'],"success")
    end
end)



RegisterServerEvent('qb-dmv:cdlpaymentpassed')
AddEventHandler('qb-dmv:cdlpaymentpassed', function ()
    if Config.DriversTest then
        local info = {}
        local _source = source
        local Player = QBCore.Functions.GetPlayer(_source)
        local licenseTable = Player.PlayerData.metadata['licences']
        info.citizenid = Player.PlayerData.citizenid
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.gender = Player.PlayerData.charinfo.gender
        info.nationality = Player.PlayerData.charinfo.nationality
        licenseTable['cdl'] = true
        Player.Functions.SetMetaData('licences', licenseTable)
        Player.Functions.RemoveMoney(Config.PaymentType, Config.Amount['cdl'])
        if Config.GiveItem == true then
            exports.ox_inventory:AddItem(src, 'cdl_license', 1, {description = 'First Name:  ' ..info.firstname..'\n\n Last Name:  '..info.lastname..'\n\n Birth Date:  '..info.birthdate..'\n\n License Type:  ' ..info.type .. ' '})
            TriggerClientEvent('QBCore:Notify', "You passed the Drivers Test and got your CDL License", "success")
            TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['cdl_license'], 'add')
        else
            TriggerClientEvent('QBCore:Notify', "You passed the CDL Test. Go to City Hall to get your License")
        end
        TriggerClientEvent('QBCore:Notify', "You paid $"..Config.Amount['cdl'],"success")
    end
end)




RegisterServerEvent('qb-dmv:driverpaymentfailed')
AddEventHandler('qb-dmv:driverpaymentfailed', function ()
    local amount = Config.Amount['driving']/2
    local _source = source
    local Player = QBCore.Functions.GetPlayer(_source)
    Player.Functions.RemoveMoney(Config.PaymentType, amount)
    QBCore.Functions.Notify("You paid $"..amount.."","success")
end)



QBCore.Functions.CreateCallback('qb-dmv:server:menu', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local licenseTable = Player.PlayerData.metadata["licences"]
    if licenseTable['permit'] == true then
        cb(false)
    else
        cb(true)
    end
end)





QBCore.Functions.CreateCallback('qb-dmv:server:menu2', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local licenseTable = Player.PlayerData.metadata["licences"]

    if licenseTable['driver']  and licenseTable['cdl'] then
        cb(0)
    elseif licenseTable['permit'] and licenseTable['driver'] == false  and licenseTable['cdl'] == false then
        cb(1)
    elseif licenseTable['permit'] and licenseTable['driver'] and licenseTable['cdl'] == false then
        cb(2)
    elseif licenseTable['permit'] and licenseTable['cdl'] and licenseTable['driver'] == false   then
        cb(3)
    end
end)



