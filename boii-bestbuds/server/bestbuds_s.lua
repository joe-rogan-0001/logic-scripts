----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local PhoneEvent = Config.CoreSettings.PhoneEvent
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- BILLING EVENT CODE START --<!>--
-- Bestbuds billing
RegisterServerEvent('boii-bestbuds:server:BestBudsPay')
AddEventHandler('boii-bestbuds:server:BestBudsPay', function(playerId, amount)
    local payee = Core.Functions.GetPlayer(source)
    local payer = Core.Functions.GetPlayer(tonumber(playerId))
    local amount = tonumber(amount)
    if payee.PlayerData.job.name == Config.JobSettings.JobName then
        if payer ~= nil then
            if payee.PlayerData.citizenid ~= payer.PlayerData.citizenid then
                if amount and amount > 0 then
                    exports.oxmysql:insert('INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (@citizenid, @amount, @society, @sender, @sendercitizenid)', {
                        ['@citizenid'] = payer.PlayerData.citizenid,
                        ['@amount'] = amount,
                        ['@society'] = payee.PlayerData.job.name,
                        ['@sender'] = payee.PlayerData.charinfo.firstname,
                        ['@sendercitizenid'] = payee.PlayerData.citizenid
                    })
                    TriggerClientEvent(PhoneEvent, payer.PlayerData.source)
                    TriggerClientEvent('boii-bestbuds:notifications', source, Config.Lang.Locations.Billing['invoicesent'], 'success')
                    TriggerClientEvent('boii-bestbuds:notifications', payer.PlayerData.source, Config.Lang['invoicereceived'])
                else
                    TriggerClientEvent('boii-bestbuds:notifications', source, Config.Lang.Locations.Billing['minamount'], 'error')
                end
            else
                TriggerClientEvent('boii-bestbuds:notifications', source, Config.Lang.Locations.Billing['billself'], 'error')
            end
        else
            TriggerClientEvent('boii-bestbuds:notifications', source, Config.Lang.Locations.Billing['billoffline'], 'error')
        end
    else
        TriggerClientEvent('boii-bestbuds:notifications', source, Config.Lang.Locations.Billing['noaccess'], 'error')
    end
end)
--<!>-- BILLING EVENT CODE START --<!>--

--<!>-- JOINTS START --<!>--
-- Strain 1 joint
Joint1 = Config.JobSettings.Rolling.Strain1.ReturnItem['1'].name
Core.Functions.CreateUseableItem(Joint1, function(source, item)
    TriggerClientEvent('boii-bestbuds:client:SmokeJoint', source, 1)
end)
-- Strain 2 joint
Joint2 = Config.JobSettings.Rolling.Strain2.ReturnItem['1'].name
Core.Functions.CreateUseableItem(Joint2, function(source, item)
    TriggerClientEvent('boii-bestbuds:client:SmokeJoint', source, 2)
end)
-- Strain 3 joint
Joint3 = Config.JobSettings.Rolling.Strain3.ReturnItem['1'].name
Core.Functions.CreateUseableItem(Joint3, function(source, item)
    TriggerClientEvent('boii-bestbuds:client:SmokeJoint', source, 3)
end)
-- Strain 4 joint
Joint4 = Config.JobSettings.Rolling.Strain4.ReturnItem['1'].name
Core.Functions.CreateUseableItem(Joint4, function(source, item)
    TriggerClientEvent('boii-bestbuds:client:SmokeJoint', source, 4)
end)
-- Strain 5 joint
Joint5 = Config.JobSettings.Rolling.Strain5.ReturnItem['1'].name
Core.Functions.CreateUseableItem(Joint5, function(source, item)
    TriggerClientEvent('boii-bestbuds:client:SmokeJoint', source, 5)
end)
--<!>-- JOINTS END --<!>--

--<!>-- EDIBLES START --<!>--
-- Strain 1
Gummy1 = Config.JobSettings.Edibles.Strain1.ReturnItem['1'].name
Core.Functions.CreateUseableItem(Gummy1, function(source, item)
    TriggerClientEvent('boii-bestbuds:client:EatEdibles', source, 1)
end)
-- Strain 2
Gummy2 = Config.JobSettings.Edibles.Strain2.ReturnItem['1'].name
Core.Functions.CreateUseableItem(Gummy2, function(source, item)
    TriggerClientEvent('boii-bestbuds:client:EatEdibles', source, 2)
end)
-- Strain 3
Gummy3 = Config.JobSettings.Edibles.Strain3.ReturnItem['1'].name
Core.Functions.CreateUseableItem(Gummy3, function(source, item)
    TriggerClientEvent('boii-bestbuds:client:EatEdibles', source, 3)
end)
-- Strain 4
Gummy4 = Config.JobSettings.Edibles.Strain4.ReturnItem['1'].name
Core.Functions.CreateUseableItem(Gummy4, function(source, item)
    TriggerClientEvent('boii-bestbuds:client:EatEdibles', source, 4)
end)
-- Strain 5
Gummy5 = Config.JobSettings.Edibles.Strain5.ReturnItem['1'].name
Core.Functions.CreateUseableItem(Gummy5, function(source, item)
    TriggerClientEvent('boii-bestbuds:client:EatEdibles', source, 5)
end)
--<!>-- JOINTS END --<!>--

--<!>-- MENU START --<!>--
-- Tools
MenuItem = Config.JobSettings.MenuItem
Core.Functions.CreateUseableItem(MenuItem, function(source, item)
    local Player = Core.Functions.GetPlayer(source)
    TriggerClientEvent('boii-bestbuds:client:DisplayMenu', source)
end)
--<!>-- MENU END --<!>--