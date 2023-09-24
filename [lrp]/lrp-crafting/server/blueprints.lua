local QBCore = exports['lrp-core']:GetCoreObject()


--############################--
 ---- Shared blueprints -----
--############################--


-- pistols

QBCore.Functions.CreateUseableItem("glockbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the glock 17 blueprint", "info")   

    pData.Functions.RemoveItem('glockbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['glockbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"glock")
    
    local weaponsjson = json.encode(weapons)
    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })
    
end)




























--############################--
 ---- Gambinos blueprints -----
--############################--


-- pistols

QBCore.Functions.CreateUseableItem("weapon_appistolbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the glock 18c blueprint", "info")   

    pData.Functions.RemoveItem('weapon_appistolbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_appistolbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"appistol")
    
    local weaponsjson = json.encode(weapons)
    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })
    
end)


QBCore.Functions.CreateUseableItem("weapon_doubleactionbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the doubleaction blueprint", "info")   

    pData.Functions.RemoveItem('weapon_doubleactionbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_doubleactionbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"doubleaction")
    
    local weaponsjson = json.encode(weapons)
    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })
    
end)


QBCore.Functions.CreateUseableItem("weapon_pistol50bp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the pistol50 blueprint", "info")   

    pData.Functions.RemoveItem('weapon_pistol50bp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_pistol50bp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"pistol50")
    
    local weaponsjson = json.encode(weapons)
    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })
    
end)


QBCore.Functions.CreateUseableItem("weapon_pistol_mk2bp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the pistol mk2 blueprint", "info")   

    pData.Functions.RemoveItem('weapon_pistol_mk2bp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_pistol_mk2bp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"pistol_mk2")
    
    local weaponsjson = json.encode(weapons)
    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })
    
end)











-- smgs

QBCore.Functions.CreateUseableItem("weapon_gusenbergbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the gusenberg blueprint", "info")   

    pData.Functions.RemoveItem('weapon_gusenbergbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_gusenbergbp'], "remove")


    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"gusenberg")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)



QBCore.Functions.CreateUseableItem("weapon_machinepistolbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the machinepistol blueprint", "info")   

    pData.Functions.RemoveItem('weapon_machinepistolbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_machinepistolbp'], "remove")


    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"machinepistol")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("weapon_microsmg3bp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Micro SMG blueprint", "info")   

    pData.Functions.RemoveItem('weapon_microsmg3bp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_microsmg3bp'], "remove")


    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"microsmg3")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)



QBCore.Functions.CreateUseableItem("weapon_smg_mk2bp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the smg mk2 blueprint", "info")   

    pData.Functions.RemoveItem('weapon_smg_mk2bp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_smg_mk2bp'], "remove")


    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"smg_mk2")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("microsmgbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the smg mk2 blueprint", "info")   

    pData.Functions.RemoveItem('microsmgbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['microsmgbp'], "remove")


    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"microsmg")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)










-- AR's


QBCore.Functions.CreateUseableItem("weapon_bullpupriflebp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the bullpuprifle blueprint", "info")   

    pData.Functions.RemoveItem('weapon_bullpupriflebp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_bullpupriflebp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"bullpuprifle")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("weapon_carbinerifle_mk2bp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the carbinerifle mk2 blueprint", "info")   

    pData.Functions.RemoveItem('weapon_carbinerifle_mk2bp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_carbinerifle_mk2bp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"carbinerifle_mk2")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("weapon_carbineriflebp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the carbinerifle blueprint", "info")   

    pData.Functions.RemoveItem('weapon_carbineriflebp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_carbineriflebp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"carbinerifle")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)



QBCore.Functions.CreateUseableItem("weapon_specialcarbinebp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the specialcarbine blueprint", "info")   

    pData.Functions.RemoveItem('weapon_specialcarbinebp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_specialcarbinebp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"specialcarbine")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("m4bp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the m4 blueprint", "info")   

    pData.Functions.RemoveItem('m4bp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['m4bp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"m4")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)







-- shotguns



QBCore.Functions.CreateUseableItem("weapon_autoshotgunbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the autoshotgun blueprint", "info")   

    pData.Functions.RemoveItem('weapon_autoshotgunbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_autoshotgunbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"autoshotgun")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("weapon_bullpupshotgunbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the bullpupshotgun blueprint", "info")   

    pData.Functions.RemoveItem('weapon_bullpupshotgunbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_bullpupshotgunbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"bullpupshotgun")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)



QBCore.Functions.CreateUseableItem("weapon_heavyshotgunbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the heavyshotgun blueprint", "info")   

    pData.Functions.RemoveItem('weapon_heavyshotgunbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_heavyshotgunbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"heavyshotgun")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)



QBCore.Functions.CreateUseableItem("weapon_pumpshotgunbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Pump Shotgun blueprint", "info")   

    pData.Functions.RemoveItem('weapon_pumpshotgunbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_pumpshotgunbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"pumpshotgun")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("weapon_sawnoffshotgunbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the sawnoffshotgun blueprint", "info")   

    pData.Functions.RemoveItem('weapon_sawnoffshotgunbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_sawnoffshotgunbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"sawnoffshotgun")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)










-- DMR's


QBCore.Functions.CreateUseableItem("weapon_musketbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the musket blueprint", "info")   

    pData.Functions.RemoveItem('weapon_musketbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_musketbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"musket")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson
    })

end)

QBCore.Functions.CreateUseableItem("weapon_enfieldbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the enfield blueprint", "info")   

    pData.Functions.RemoveItem('weapon_enfieldbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_enfieldbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"enfield")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson
    })

end)




-- MG's



QBCore.Functions.CreateUseableItem("weapon_combatmgbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the combatmg blueprint", "info")   

    pData.Functions.RemoveItem('weapon_combatmgbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_combatmgbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"combatmg")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson
    })

end)






























































--############################--
   ---- IRA blueprints -----
--############################--




-- smgs

QBCore.Functions.CreateUseableItem("weapon_assaultsmgbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Assault SMG blueprint", "info")   

    pData.Functions.RemoveItem('weapon_assaultsmgbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_assaultsmgbp'], "remove")


    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"assaultsmg")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)



QBCore.Functions.CreateUseableItem("weapon_compactriflebp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Compact Rifle blueprint", "info")   

    pData.Functions.RemoveItem('weapon_compactriflebp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_compactriflebp'], "remove")


    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"compactrifle")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("weapon_microsmg2bp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Micro SMG blueprint", "info")   

    pData.Functions.RemoveItem('weapon_microsmg2bp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_microsmg2bp'], "remove")


    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"microsmg2")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)



QBCore.Functions.CreateUseableItem("weapon_minismg", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Mini SMG blueprint", "info")   

    pData.Functions.RemoveItem('weapon_minismg', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_minismg'], "remove")


    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"minismg")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("weapon_smgbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the SMG blueprint", "info")   

    pData.Functions.RemoveItem('weapon_smgbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_smgbp'], "remove")


    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"smg")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)



-- AR's


QBCore.Functions.CreateUseableItem("weapon_advancedriflebp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Advanced Rifle blueprint", "info")   

    pData.Functions.RemoveItem('weapon_advancedriflebp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_advancedriflebp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"advancedrifle")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("weapon_assaultrifle_mk2bp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Assault Rifle blueprint", "info")   

    pData.Functions.RemoveItem('weapon_assaultrifle_mk2bp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_assaultrifle_mk2bp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"assaultrifle")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("weapon_assaultrifle2bp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Assault Rifle blueprint", "info")   

    pData.Functions.RemoveItem('weapon_assaultrifle2bp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_assaultrifle2bp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"assaultrifle2")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)



QBCore.Functions.CreateUseableItem("weapon_assaultriflebp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Assault Rifle blueprint", "info")   

    pData.Functions.RemoveItem('weapon_assaultriflebp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_assaultriflebp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"assaultrifle")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("weapon_bullpuprifle_mk2bp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Bullpuprifle blueprint", "info")   

    pData.Functions.RemoveItem('weapon_bullpuprifle_mk2bp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_bullpuprifle_mk2bp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"bullpuprifle_mk2")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("weapon_militaryriflebp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Military Rifle blueprint", "info")   

    pData.Functions.RemoveItem('weapon_militaryriflebp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_militaryriflebp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"militaryrifle")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("weapon_specialcarbine_mk2bp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Scar-h blueprint", "info")   

    pData.Functions.RemoveItem('weapon_specialcarbine_mk2bp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_specialcarbine_mk2bp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"specialcarbine_mk2")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)













-- shotguns



QBCore.Functions.CreateUseableItem("weapon_assaultshotgunbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Assault Shotgun blueprint", "info")   

    pData.Functions.RemoveItem('weapon_assaultshotgunbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_assaultshotgunbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"assaultshotgun")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)


QBCore.Functions.CreateUseableItem("weapon_combatshotgunbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Combat Shotgun blueprint", "info")   

    pData.Functions.RemoveItem('weapon_combatshotgunbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_combatshotgunbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"combatshotgun")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)



QBCore.Functions.CreateUseableItem("weapon_dbshotgunbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the DB Shotgun blueprint", "info")   

    pData.Functions.RemoveItem('weapon_dbshotgunbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_dbshotgunbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"dbshotgun")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)



QBCore.Functions.CreateUseableItem("weapon_pumpshotgun_mk2bp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Pump Shotgun blueprint", "info")   

    pData.Functions.RemoveItem('weapon_pumpshotgun_mk2bp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_pumpshotgun_mk2bp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"pumpshotgun_mk2")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson  
    })

end)



-- DMR's


QBCore.Functions.CreateUseableItem("weapon_dragunovbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Dragunov blueprint", "info")   

    pData.Functions.RemoveItem('weapon_dragunovbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_dragunovbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"dragunov")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson
    })

end)



-- MG's



QBCore.Functions.CreateUseableItem("weapon_mgbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the MG blueprint", "info")   

    pData.Functions.RemoveItem('weapon_mgbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_mgbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"mg")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson
    })

end)



-- explosives

QBCore.Functions.CreateUseableItem("weapon_grenadebp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Grenade blueprint", "info")   

    pData.Functions.RemoveItem('weapon_grenadebp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_grenadebp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"grenade")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson
    })

end)

QBCore.Functions.CreateUseableItem("weapon_molotovbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Molotov blueprint", "info")   

    pData.Functions.RemoveItem('weapon_molotovbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_molotovbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"molotov")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson
    })

end)


QBCore.Functions.CreateUseableItem("weapon_pipebombbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Pipebomb blueprint", "info")   

    pData.Functions.RemoveItem('weapon_pipebombbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_pipebombbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"pipebomb")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson
    })

end)


QBCore.Functions.CreateUseableItem("weapon_rpgbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the RPG blueprint", "info")   

    pData.Functions.RemoveItem('weapon_rpgbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_rpgbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"rpg")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson
    })

end)


QBCore.Functions.CreateUseableItem("weapon_stickybombbp", function(source)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, "You learned the Stickybomb blueprint", "info")   

    pData.Functions.RemoveItem('weapon_stickybombbp', 1) 
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weapon_stickybombbp'], "remove")

    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})
    local weapons = json.decode(result)
    table.insert(weapons,"stickybomb")

    local weaponsjson = json.encode(weapons)

    MySQL.Async.execute("UPDATE players SET weapons = '"..weaponsjson.."' WHERE citizenid = '"..pData.PlayerData.citizenid.."'", {
        weaponsjson
    })

end)