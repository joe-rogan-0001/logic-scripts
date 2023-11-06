-- Variables

--local Plates = {}
local PlayerStatus = {}
local Casings = {}
local BloodDrops = {}
local FingerDrops = {}
local Objects = {}
local QBCore = exports['lrp-core']:GetCoreObject()

-- Functions

local function UpdateBlips()
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if (v.PlayerData.job.name == "police" or v.PlayerData.job.name == "ambulance") and v.PlayerData.job.onduty then
            TriggerEvent('iconic-eblips:server:registerPlayerBlipGroup', v.PlayerData.source, v.PlayerData.job.name)
        end
    end
end

local function CreateBloodId()
    if BloodDrops then
        local bloodId = math.random(10000, 99999)
        while BloodDrops[bloodId] do
            bloodId = math.random(10000, 99999)
        end
        return bloodId
    else
        local bloodId = math.random(10000, 99999)
        return bloodId
    end
end

local function CreateFingerId()
    if FingerDrops then
        local fingerId = math.random(10000, 99999)
        while FingerDrops[fingerId] do
            fingerId = math.random(10000, 99999)
        end
        return fingerId
    else
        local fingerId = math.random(10000, 99999)
        return fingerId
    end
end

local function CreateCasingId()
    if Casings then
        local caseId = math.random(10000, 99999)
        while Casings[caseId] do
            caseId = math.random(10000, 99999)
        end
        return caseId
    else
        local caseId = math.random(10000, 99999)
        return caseId
    end
end

local function CreateObjectId()
    if Objects then
        local objectId = math.random(10000, 99999)
        while Objects[objectId] do
            objectId = math.random(10000, 99999)
        end
        return objectId
    else
        local objectId = math.random(10000, 99999)
        return objectId
    end
end

local function IsVehicleOwned(plate)
    local result = MySQL.Sync.fetchScalar('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    return result
end

local function GetCurrentCops()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    return amount
end

local function DnaHash(s)
    local h = string.gsub(s, ".", function(c)
        return string.format("%02x", string.byte(c))
    end)
    return h
end

-- Commands
QBCore.Commands.Add("grantlicense", "Grant a license to someone", {{name = "id", help = "ID of a person"}, {name = "license", help = "License Type"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.grade.level >= 1 then
        if args[2] == "permit" or args[2] == "driver" or args[2] == "weapon" or args[2] == "cdl" or args[2] == "business" or args[2] == "hunting" or args[2] == "fishing" or args[2] == "pilot" or args[2] == "boating" then
            local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if SearchedPlayer then
                local licenseTable = SearchedPlayer.PlayerData.metadata["licences"]
                licenseTable[args[2]] = true
                SearchedPlayer.Functions.SetMetaData("licences", licenseTable)
                TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You have been granted a license",
                    "success", 5000)
                TriggerClientEvent('QBCore:Notify', src, "You granted a license", "success", 5000)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Invalid license type", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must be a Officer or above to grant licenses!", "error")
    end
end)

QBCore.Commands.Add("revokelicense", "Revoke a license from someone", {{name = "id", help = "ID of a person"}, {name = "license", help = "License Type"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.grade.level >= 2 then
        if args[2] == "permit" or args[2] == "driver" or args[2] == "weapon" or args[2] == "cdl" or args[2] == "business" or args[2] == "hunting" or args[2] == "fishing" or args[2] == "pilot" or args[2] == "boating" then
            local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if SearchedPlayer then
                local licenseTable = SearchedPlayer.PlayerData.metadata["licences"]
                licenseTable[args[2]] = false
                SearchedPlayer.Functions.SetMetaData("licences", licenseTable)
                TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You've had a license revoked",
                    "error", 5000)
                TriggerClientEvent('QBCore:Notify', src, "You revoked a license", "success", 5000)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Invalid license type", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must be a Sergeant to revoke licenses!", "error")
    end
end)

QBCore.Commands.Add("pobject", "Place/Delete An Object (Police Only)", {{name = "type",help = "Type object you want or 'delete' to delete"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local type = args[1]:lower()
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        if type == "pion" then
            TriggerClientEvent("police:client:spawnCone", src)
        elseif type == "barier" then
            TriggerClientEvent("police:client:spawnBarier", src)
        elseif type == "schotten" then
            TriggerClientEvent("police:client:spawnSchotten", src)
        elseif type == "tent" then
            TriggerClientEvent("police:client:spawnTent", src)
        elseif type == "light" then
            TriggerClientEvent("police:client:spawnLight", src)
        elseif type == "delete" then
            TriggerClientEvent("police:client:deleteObject", src)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("cuff", "Cuff Player (Police Only)", {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:CuffPlayer", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("escort", "Escort Player", {}, false, function(source, args)
    local src = source
    TriggerClientEvent("police:client:EscortPlayer", src)
end)

QBCore.Commands.Add("callsign", "Give Yourself A Callsign", {{name = "name", help = "Name of your callsign"}}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.SetMetaData("callsign", table.concat(args, " "))
end)

--[[
QBCore.Commands.Add("clearcasings", "Clear Area of Casings (Police Only)", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("evidence:client:ClearCasingsInArea", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)
]]--

QBCore.Commands.Add("jail", "Jail Player (Police Only)", {{name = "id", help = "Player ID"}, {name = "time", help = "Time they have to be in jail"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        local time = tonumber(args[2])
        if time > 0 then
            TriggerClientEvent("police:client:JailCommand", src, playerId, time)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Cannot sentence for 0', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)


QBCore.Commands.Add("unjail", "Unjail Player (Police Only)", {{name = "id", help = "Player ID"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        exports['pb_prison']:unJailPlayer(playerId)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.on_duty_police_only"), 'error')
    end
end)



--[[
QBCore.Commands.Add("clearblood", "Clear The Area of Blood (Police Only)", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("evidence:client:ClearBlooddropsInArea", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)
]]--

QBCore.Commands.Add("seizecash", "Seize Cash (Police Only)", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:SeizeCash", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("sc", "Soft Cuff (Police Only)", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:CuffPlayerSoft", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("cam", "View Security Camera (Police Only)", {{name = "camid", help = "Camera ID"}}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:ActiveCamera", src, tonumber(args[1]))
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

--[[
QBCore.Commands.Add("flagplate", "Flag A Plate (Police Only)", {{name = "plate", help = "License"}, {name = "reason", help = "Reason of flagging the vehicle"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local reasonData = {}
        local plate = args[1]:upper()
        for i = 2, #args, 1 do reasonData[#reasonData + 1] = args[i] end
        local reason = table.concat(reasonData, " ")

        exports["oxmysql"]:execute("SELECT * FROM player_vehicles WHERE plate = ?", { plate }, function(result)
            if string.len(json.encode(result)) > 2 then
                exports["oxmysql"]:update("UPDATE player_vehicles SET flags = ? WHERE plate = ?", { reason, plate }, function(ar)
                    if ar then
                        TriggerClientEvent("QBCore:Notify", src, "Vehicle (" .. plate .. ") has been flagged for: " .. reason, "police")
                    end
                end)
            else
                TriggerClientEvent("QBCore:Notify", src, "Vehicle (" .. plate .. ") could not be found in the database!", "error")
            end
        end)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("unflagplate", "Unflag A Plate (Police Only)", {{name = "plate", help = "License plate"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local plate = args[1]:upper()

        exports["oxmysql"]:execute("SELECT * FROM player_vehicles WHERE plate = ?", { plate }, function(result)
            if string.len(json.encode(result)) > 2 then
                exports["oxmysql"]:update("UPDATE player_vehicles SET flags = '' WHERE plate = ?", { plate }, function(ar)
                    if ar then
                        TriggerClientEvent("QBCore:Notify", src, "Vehicle (" .. plate .. ") has been unflagged!", "police")
                    end
                end)
            else
                TriggerClientEvent("QBCore:Notify", src, "Vehicle (" .. plate .. ") could not be found in the database!", "error")
            end
        end)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)
]]--

--[[
QBCore.Commands.Add("plateinfo", "Run A Plate (Police Only)", {{name = "plate",help = "License plate"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local vehicleowner = 'Unknown'

    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        if Plates and Plates[args[1]:upper()] then
            print(args[1]:upper())

            vehicleowner = MySQL.Sync.fetchScalar('SELECT citizenid FROM player_vehicles WHERE plate = ?', {args[1]:upper()})

            local user = QBCore.Functions.GetPlayerByCitizenId(vehicleowner)

            if Plates[args[1]:upper()].isflagged then
                TriggerClientEvent('chat:addMessage', src, {
                    template = '<div class="chat-message server"><strong>{0}</strong><br>{1}<br>{2}<br>{3}<br>{4}</div>',
                    args = {"DISPATCH: 10-60 (Flagged)", "Name: " .. user.PlayerData.charinfo.firstname .. " " .. user.PlayerData.charinfo.lastname, "Phone: " .. user.PlayerData.charinfo.phone, "Plate: " .. args[1]:upper(), "Flags: " .. Plates[args[1]:upper()].reason}
                })
            else
                TriggerClientEvent('chat:addMessage', src, {
                    template = '<div class="chat-message server"><strong>{0}</strong><br>{1}<br>{2}<br>{3}}</div>',
                    args = {"DISPATCH: (No flags)", "Name: " .. user.PlayerData.charinfo.firstname .. " " .. user.PlayerData.charinfo.lastname, "Phone: " .. user.PlayerData.charinfo.phone, "Plate: " .. args[1]:upper()}
                })
            end
        else
            print("not in db contact developer")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end) ]]--

--[[
QBCore.Commands.Add("plateinfo", "Run A Plate (Police Only)", {{name = "plate",help = "License plate"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local vehicleowner = 'Unknown'
  
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
            exports["oxmysql"]:execute("SELECT detail FROM ____mdw_bolos WHERE license_plate = ?", { args[1]:upper() }, function(result)
                if string.len(json.encode(result)) > 2 then
                    print(json.encode(result))  
                    if result then
                        for _, v in pairs(result) do
                            vehicleowner = MySQL.Sync.fetchScalar('SELECT citizenid FROM player_vehicles WHERE plate = ?', {args[1]:upper()})
                            local user = QBCore.Functions.GetPlayerByCitizenId(vehicleowner)
                            local flags = v.flags
                            if string.len(flags) > 1 then
                                TriggerClientEvent('chat:addMessage', src, {
                                    template = '<div class="chat-message server" style="background-color: rgba(195, 24, 24, 0.9);"><strong>{0}</strong><br>{1}<br>{2}<br>{3}<br>{4}</div>',
                                    args = {"DISPATCH: 10-60 (Flagged)", "Name: " .. user.PlayerData.charinfo.firstname .. " " .. user.PlayerData.charinfo.lastname, "Phone: " .. user.PlayerData.charinfo.phone, "Plate: " .. args[1]:upper(), "Flags: " .. flags}
                                })
                            else
                                TriggerClientEvent('chat:addMessage', src, {
                                    template = '<div class="chat-message server" style="background-color: rgbA(91, 156, 17, 0.9);"><strong>{0}</strong><br>{1}<br>{2}<br>{3}</div>',
                                    args = {"DISPATCH: (No flags)", "Name: " .. user.PlayerData.charinfo.firstname .. " " .. user.PlayerData.charinfo.lastname, "Phone: " .. user.PlayerData.charinfo.phone, "Plate: " .. args[1]:upper()}
                                })
                            end
                        end
                    end
                else
                    TriggerClientEvent("QBCore:Notify", src, "Vehicle (" .. args[1]:upper() .. ") could not be found in the database!", "error")
                end
            end)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)
]]--

RegisterNetEvent('police:changewhiteboard')
AddEventHandler('police:changewhiteboard', function(dialog)
    TriggerClientEvent('police:changewhiteboardcli', -1, dialog)
end)


RegisterNetEvent('police:server:runplate')
AddEventHandler('police:server:runplate', function(plate)
    local src = source
    local plate = plate
    local Player = QBCore.Functions.GetPlayer(src)
    local vehicleowner = 'Unknown'
  
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        exports["oxmysql"]:execute("SELECT detail FROM ____mdw_bolos WHERE license_plate = ?", { plate }, function(result)
            if string.len(json.encode(result)) > 2 then
                print(json.encode(result))  
                if result then
                    for _, v in pairs(result) do
                        vehicleowner = MySQL.Sync.fetchScalar('SELECT citizenid FROM player_vehicles WHERE plate = ?', {plate})
                        local user = QBCore.Functions.GetPlayerByCitizenId(vehicleowner)
                        local flags = v.detail
                        if string.len(flags) > 1 then
                            TriggerClientEvent('chat:addMessage', src, {
                                template = '<div class="chat-message server" style="background-color: rgba(195, 24, 24, 0.9);"><strong>{0}</strong><br>{1}<br>{2}<br>{3}<br>{4}</div>',
                                args = {"DISPATCH: 10-60 (Flagged)", "Name: " .. user.PlayerData.charinfo.firstname .. " " .. user.PlayerData.charinfo.lastname, "Phone: " .. user.PlayerData.charinfo.phone, "Plate: " .. plate, "Flags: " .. flags}
                            })
                        end
                    end
                end
            else
                vehicleowner = MySQL.Sync.fetchScalar('SELECT citizenid FROM player_vehicles WHERE plate = ?', {plate})
                local user = QBCore.Functions.GetPlayerByCitizenId(vehicleowner)
            if user then
                TriggerClientEvent('chat:addMessage', src, {
                    template = '<div class="chat-message server" style="background-color: rgbA(91, 156, 17, 0.9);"><strong>{0}</strong><br>{1}<br>{2}<br>{3}</div>',
                    args = {"DISPATCH: (No flags)", "Name: " .. user.PlayerData.charinfo.firstname .. " " .. user.PlayerData.charinfo.lastname, "Phone: " .. user.PlayerData.charinfo.phone, "Plate: " .. plate}
                })
            else
                -- add notification with random info and name
                print("ded")
            end
            end
        end)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)



QBCore.Commands.Add("depot", "Impound With Price (Police Only)", {{name = "price", help = "Price for how much the person has to pay (may be empty)"}}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:ImpoundVehicle", src, false, tonumber(args[1]))
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("impound", "Impound A Vehicle (Police Only)", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:ImpoundVehicle", src, true)      
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("paytow", "Pay Tow Driver (Police Only)", {{name = "id",help = "ID of the player"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
        if OtherPlayer then
            if OtherPlayer.PlayerData.job.name == "tow" then
                TriggerEvent('qb-banking:server:sendPaycheck', 500, src)
                --TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
                -- OtherPlayer.Functions.AddMoney("bank", 500, "police-tow-paid")
                TriggerClientEvent('QBCore:Notify', OtherPlayer.PlayerData.source, 'You were paid $500', 'success')
                TriggerClientEvent('QBCore:Notify', src, 'You paid the tow truck driver')
            else
                TriggerClientEvent('QBCore:Notify', src, 'Not a tow truck driver', 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("paylawyer", "Pay Lawyer (Police, Judge Only)", {{name = "id",help = "ID of the player"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "judge" then
        local playerId = tonumber(args[1])
        local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
        if OtherPlayer then
            if OtherPlayer.PlayerData.job.name == "lawyer" then
                TriggerEvent('qb-banking:server:sendPaycheck', 500, src)
                --TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
                -- OtherPlayer.Functions.AddMoney("bank", 500, "police-lawyer-paid")
                TriggerClientEvent('QBCore:Notify', OtherPlayer.PlayerData.source, 'You were paid $500', 'success')
                TriggerClientEvent('QBCore:Notify', src, 'You paid a lawyer')
            else
                TriggerClientEvent('QBCore:Notify', src, 'Person is not a lawyer', "error")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("anklet", "Attach Tracking Anklet (Police Only)", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:CheckDistance", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("ankletlocation", "Get the location of a persons anklet", {{"cid", "Citizen ID of the person"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        if args[1] then
            local citizenid = args[1]
            local Target = QBCore.Functions.GetPlayerByCitizenId(citizenid)
            if Target then
                if Target.PlayerData.metadata["tracker"] then
                    TriggerClientEvent("police:client:SendTrackerLocation", Target.PlayerData.source, src)
                else
                    TriggerClientEvent('QBCore:Notify', src, 'This person doesn\'t have an anklet on.', 'error')
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("removeanklet", "Remove Tracking Anklet (Police Only)", {{"cid", "Citizen ID of person"}}, true,function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        if args[1] then
            local citizenid = args[1]
            local Target = QBCore.Functions.GetPlayerByCitizenId(citizenid)
            if Target then
                if Target.PlayerData.metadata["tracker"] then
                    TriggerClientEvent("police:client:SendTrackerLocation", Target.PlayerData.source, src)
                else
                    TriggerClientEvent('QBCore:Notify', src, 'This person does not have an anklet', 'error')
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("takedrivinglicense", "Seize Drivers License (Police Only)", {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:SeizeDriverLicense", source)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("takedna", "Take a DNA sanple from a person (empty evidence bag needed) (Police Only)", {{"id", "ID of the person"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if ((Player.PlayerData.job.name == "police") and Player.PlayerData.job.onduty) and OtherPlayer then
        if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
            local info = {
                label = "DNA Sample",
                type = "dna",
                dnalabel = DnaHash(OtherPlayer.PlayerData.citizenid)
            }
            if Player.Functions.AddItem("filled_evidence_bag", 1, false, info) then
                TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
        end
    end
end)

RegisterNetEvent('police:server:SendTrackerLocation', function(coords, requestId)
    local Target = QBCore.Functions.GetPlayer(source)
    local msg = "The location of " .. Target.PlayerData.charinfo.firstname .. " " .. Target.PlayerData.charinfo.lastname .. " is marked on your map."
    local alertData = {
        title = "Anklet location",
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        description = msg
    }
    TriggerClientEvent("police:client:TrackerMessage", requestId, msg, coords)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", requestId, alertData)
end)

-- Items

QBCore.Functions.CreateUseableItem("handcuffs", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("police:client:CuffPlayerSoft", src)
    end
end)

-- In a seperate script now
--[[
QBCore.Functions.CreateUseableItem("spikestrips", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
            TriggerClientEvent('police:client:SpawnSpikeStrip', src)
            Player.Functions.RemoveItem("spikestrips", 1, item.slot)
        end
    end
end)
]]--

QBCore.Functions.CreateUseableItem("moneybag", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        if item.info and item.info ~= "" then
            if Player.PlayerData.job.name ~= "police" then
                if Player.Functions.RemoveItem("moneybag", 1, item.slot) then
                    Player.Functions.AddMoney("cash", tonumber(item.info.cash), "used-moneybag")
                end
            end
        end
    end
end)

-- Callbacks

QBCore.Functions.CreateCallback('police:server:isPlayerDead', function(source, cb, playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    cb(Player.PlayerData.metadata["isdead"])
end)

QBCore.Functions.CreateCallback('police:GetPlayerStatus', function(source, cb, playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    local statList = {}
    if Player then
        if PlayerStatus[Player.PlayerData.source] and next(PlayerStatus[Player.PlayerData.source]) then
            for k, v in pairs(PlayerStatus[Player.PlayerData.source]) do
                statList[#statList+1] = PlayerStatus[Player.PlayerData.source][k].text
            end
        end
    end
    cb(statList)
end)

QBCore.Functions.CreateCallback('police:IsSilencedWeapon', function(source, cb, weapon)
    local Player = QBCore.Functions.GetPlayer(source)
    local itemInfo = Player.Functions.GetItemByName(QBCore.Shared.Weapons[weapon]["name"])
    local retval = false
    if itemInfo then
        if itemInfo.info and itemInfo.info.attachments then
            for k, v in pairs(itemInfo.info.attachments) do
                if itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP_02" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP_02" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP" then
                    retval = true
                end
            end
        end
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('police:GetDutyPlayers', function(source, cb)
    local dutyPlayers = {}
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            dutyPlayers[#dutyPlayers+1] = {
                source = Player.PlayerData.source,
                label = Player.PlayerData.metadata["callsign"],
                job = Player.PlayerData.job.name
            }
        end
    end
    cb(dutyPlayers)
end)

QBCore.Functions.CreateCallback('police:GetImpoundedVehicles', function(source, cb)
    local vehicles = {}
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE state = ?', {2}, function(result)
        if result[1] then
            vehicles = result
        end
        cb(vehicles)
    end)
end)

QBCore.Functions.CreateCallback('police:IsPlateFlagged', function(source, cb, plate)
    local retval = false
    exports["oxmysql"]:execute("SELECT flags FROM player_vehicles WHERE plate = ?", { plate }, function(result)
        if result then
            for _, v in pairs(result) do
                if not v.flags == "None" then
                    retval = true
                else
                    retval = false
                end
            end
        else
            retval = false
        end
    end)
    cb(retval)
end)

QBCore.Functions.CreateCallback('police:GetCops', function(source, cb)
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

QBCore.Functions.CreateCallback('police:server:IsPoliceForcePresent', function(source, cb)
    local retval = false
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.grade.level >= 2 then
            retval = true
            break
        end
    end
    cb(retval)
end)

-- Events

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CreateThread(function()
            MySQL.Async.fetchAll('DELETE FROM stashitems WHERE stash="policetrash"')
        end)
    end
end)

--[[
RegisterNetEvent('police:server:policeAlert', function(text)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local players = QBCore.Functions.GetQBPlayers()
    for k,v in pairs(players) do
        if v.PlayerData.job.name == 'police' and v.PlayerData.job.onduty then
            local alertData = {title = 'New Call', coords = {coords.x, coords.y, coords.z}, description = text}
            TriggerClientEvent("qb-phone:client:addPoliceAlert", v.PlayerData.source, alertData)
            TriggerClientEvent('police:client:policeAlert', v.PlayerData.source, coords, text)
        end
    end
end)
]]--

RegisterNetEvent('police:server:TakeOutImpound', function(plate)
    local src = source
    MySQL.Async.fetchAll('UPDATE player_vehicles SET state = ? WHERE plate  = ?', {0, plate})
    TriggerClientEvent('QBCore:Notify', src, "Vehicle unimpounded!", 'success')
end)

RegisterNetEvent('police:server:CuffPlayer', function(playerId, isSoftcuff)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CuffedPlayer = QBCore.Functions.GetPlayer(playerId)
    if CuffedPlayer then
        if Player.Functions.GetItemByName("handcuffs") or Player.PlayerData.job.name == "police" then
            TriggerClientEvent("police:client:GetCuffed", CuffedPlayer.PlayerData.source, isSoftcuff)
        end
    end
end)

RegisterNetEvent('police:server:EscortPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer then
        --if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance") or (EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"]) then
            TriggerClientEvent("police:client:GetEscorted", EscortPlayer.PlayerData.source, Player.PlayerData.source)
        --else
            --TriggerClientEvent('QBCore:Notify', src, "Civilian isn't cuffed or dead", 'error')
        --end
    end
end)

RegisterNetEvent('police:server:KidnapPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer then
        --if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"] then
            TriggerClientEvent("police:client:GetKidnappedTarget", EscortPlayer.PlayerData.source, Player.PlayerData.source)
            TriggerClientEvent("police:client:GetKidnappedDragger", Player.PlayerData.source, EscortPlayer.PlayerData.source)
        --else
            --TriggerClientEvent('QBCore:Notify', src, "Civilian isn't cuffed or dead", 'error')
        --end
    end
end)

RegisterNetEvent('police:server:SetPlayerOutVehicle', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer then
        --if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
            TriggerClientEvent("police:client:SetOutVehicle", EscortPlayer.PlayerData.source)
        --else
            --TriggerClientEvent('QBCore:Notify', src, "Civilian isn't cuffed or dead", 'error')
        --end
    end
end)

RegisterNetEvent('police:server:PutPlayerInVehicle', function(playerId)
    local src = source
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer then
        --if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
            TriggerClientEvent("police:client:PutInVehicle", EscortPlayer.PlayerData.source)
        --else
           --TriggerClientEvent('QBCore:Notify', src, "Civilian isn't cuffed or dead", 'error')
        ---end
    end
end)

RegisterNetEvent('police:server:BillPlayer', function(playerId, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance" then
        if OtherPlayer then
            OtherPlayer.Functions.RemoveMoney("bank", price, "paid-bills")
            TriggerEvent('qb-bossmenu:server:addAccountMoney', "police", price)
            --TriggerClientEvent('QBCore:Notify', OtherPlayer.PlayerData.source, "You received a fine of $" .. price)
            --[[
            TriggerClientEvent('chat:addMessage', OtherPlayer.PlayerData.source, {
                template = '<div class="chat-message server" style="background-color:  rgba(195, 24, 24, 0.9);">{0}</div>',
                args = {"You were fined $" .. price .. " by " .. Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname}
            })
            ]]--

            TriggerClientEvent("chatMessage", src, "Billing", 4, "You were fined $" .. price .. " by " .. Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname)


            local CitizenId = OtherPlayer.PlayerData.citizenid
            local iTransactionID = math.random(1000, 100000)

            MySQL.Async.insert("INSERT INTO `transaction_history` (`citizenid`, `trans_id`, `account`, `amount`, `trans_type`, `receiver`, `message`) VALUES(?, ?, ?, ?, ?, ?, ?)", {
                CitizenId,
                iTransactionID,
                'personal',
                price * -1,
                'withdraw',
                'N/A',
                'Fine of $'..price
            }, function()
                --RefreshTransactions(src)
            end)

        end
    end
end)

QBCore.Commands.Add("fine", "Fine Player", {{name = "id", help = "Player ID"}, {name = "amount", help = "Amount to bill player"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance" and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        local amount = tonumber(args[2])
        if amount > 0 and amount < 500000 then
            TriggerClientEvent("police:client:BillCommand", src, playerId, amount)
            TriggerClientEvent('police:client:sendBillingMail', src, amount)
            TriggerEvent('qb-banking:society:server:DepositMoney', src, math.floor(amount * 0.50), Player.PlayerData.job.name)
            Player.Functions.AddMoney("bank", math.floor(amount * 0.1), "Commision from bill")
        else
            TriggerClientEvent('QBCore:Notify', src, 'Bill must be more than $0', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty emergency personnel only', 'error')
    end
end)

QBCore.Commands.Add("911", "Contact 911 (Police will get your location)", {{name = "Message", help = "[Message]"}}, true, function(source, args)
    local src = source
    local desc = table.concat(args, " ")
    TriggerClientEvent('un-dispatch:ninecall', source, desc)

    
    local Player = QBCore.Functions.GetPlayer(src)

    
    TriggerClientEvent('chat:addMessage', src, {
        template = '<div class="chat-message server" style="background-color:  rgba(195, 24, 24, 0.9);"><strong>{0}</strong>{1}</div>',
        args = {"911 | ".. Player.PlayerData.charinfo.firstname .. " | " .. Player.PlayerData.charinfo.lastname .. " # " ..  Player.PlayerData.charinfo.phone .. ": ", desc}
    }) 
    

    --TriggerClientEvent("chatMessage", src, "911 | " .. Player.PlayerData.charinfo.firstname .. " | " .. Player.PlayerData.charinfo.lastname .. " # " .. Player.PlayerData.charinfo.phone, 4, tostring(desc))

end)

QBCore.Commands.Add("911a", "Contact 911 (Police not recieve your location)", {{name = "Message", help = "[Message]"}}, true, function(source, args)
    local src = source
    local desc = table.concat(args, " ")
    TriggerClientEvent('un-dispatch:ninecalla', source, desc)

    local Player = QBCore.Functions.GetPlayer(src)

    
    TriggerClientEvent('chat:addMessage', src, {
        template = '<div class="chat-message server" style="background-color: rgba(195, 24, 24, 0.9);"><strong>{0}</strong>{1}</div>',
        args = {"911 | ".. Player.PlayerData.charinfo.firstname .. " | " .. Player.PlayerData.charinfo.lastname .. " # " ..  Player.PlayerData.charinfo.phone .. ": ", desc}
    })
    

    --TriggerClientEvent("chatMessage", src, "911a | " .. 'Unknown' .. " | " .. 'Unknown' .. " # " .. 'Unknown', 4, tostring(desc))
end)

QBCore.Commands.Add("311", "Contact 311 (Police not recieve your location)", {{name = "Message", help = "[Message]"}}, true, function(source, args)
    local src = source
    local desc = table.concat(args, " ")

    local Player = QBCore.Functions.GetPlayer(src)

    TriggerClientEvent("chatMessage", src, "311 | " .. Player.PlayerData.charinfo.firstname .. " | " .. Player.PlayerData.charinfo.lastname .. " # " .. Player.PlayerData.charinfo.phone, 4, tostring(desc))
    
    --[[
    TriggerClientEvent('chat:addMessage', src, {
        template = '<div class="chat-message server" style="background-color: rgbA(186, 96, 10, 0.9);"><strong>{0}</strong>{1}</div>',
        args = {"311 | ".. Player.PlayerData.charinfo.firstname .. " | " .. Player.PlayerData.charinfo.lastname .. " # " ..  Player.PlayerData.charinfo.phone .. ": ", desc}
    })
    ]]--

    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            
            TriggerClientEvent('chat:addMessage', v.PlayerData.source, {
                template = '<div class="chat-message server" style="background-color: rgbA(186, 96, 10, 0.9);"><strong>{0}</strong>{1}</div>',
                args = {"311 | (" .. src ..") ".. Player.PlayerData.charinfo.firstname .. " | " .. Player.PlayerData.charinfo.lastname .. " # " ..  Player.PlayerData.charinfo.phone .. ": ", desc}
            })
            
            --TriggerClientEvent("chatMessage", src, "311 | " .. Player.PlayerData.charinfo.firstname .. " | " .. Player.PlayerData.charinfo.lastname .. " # " .. Player.PlayerData.charinfo.phone, 4, tostring(desc))
        end
    end
end)

QBCore.Commands.Add("emr", "Emergency Response",  {{name = "id", help = "Player ID"}, {name = "Message", help = "[Message]"}}, true, function(source, args)
    local src = source
    local targetsource = args[1]

    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance" and Player.PlayerData.job.onduty then

        table.remove(args, 1)

        local arguments = table.concat(args, ' ')

        local Player = QBCore.Functions.GetPlayer(src)
        local job = Player.PlayerData.job.name
        local jobname = 'INVALID'

        if job == "police" then
            jobname = "LSPD"
        elseif job == "ambulance" then
            jobname = "EMS"
        end

        
        TriggerClientEvent('chat:addMessage',targetsource, {
            template = '<div class="chat-message server" style="background-color: rgbA(186, 96, 10, 0.9);"><strong>{0}</strong></div>',
            args = {"Response from "..Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname..' ['..jobname..'] - '..arguments}
        })
        

        --TriggerClientEvent("chatMessage", src, "Response from "..Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname..' ['..jobname..']', 4, tostring(arguments))
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty emergency personnel only', 'error')
    end

end)

QBCore.Commands.Add("evidence", "Open an Evidence Case", {{name = "casenum", help = "Case Number"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local casenum = tonumber(args[1])
        if casenum > 0 then
            TriggerClientEvent('police:client:EvidenceStashDrawer', src, casenum)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Case Number must be > 0', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("funcuff", "Force", {{name = "src", help = "src"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local casenum = tonumber(args[1])
        if casenum > 0 then
            TriggerClientEvent('police:client:fcuff', tonumber(args[1]))
        else
            --TriggerClientEvent('QBCore:Notify', src, 'Case Number must be > 0', 'error')
        end
    else
        --TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

RegisterNetEvent('police:server:JailPlayer', function(playerId, time)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return DropPlayer(src, "Attempted exploit abuse") end

    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if not Player or not OtherPlayer or Player.PlayerData.job.name ~= "police" then return end

    local currentDate = os.date('%d-'..'%m-'..'%y')
    if currentDate.day == 31 then
        currentDate.day = 30
    end

    local name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    --TriggerEvent("pb_prison:server:JailPlayer",playerId, true, name, time, Player.PlayerData.citizenid, currentDate)

    exports['pb_prison']:jailPlayer(playerId, true, name, time, Player.PlayerData.citizenid, currentDate)
    OtherPlayer.Functions.SetMetaData("criminalrecord", {
        ["hasRecord"] = true,
        ["date"] = currentDate
    })
    TriggerClientEvent("police:client:SendToJail", OtherPlayer.PlayerData.source, time)
    TriggerClientEvent('QBCore:Notify', src, "You sent the person to prison for " .. time .. " months")
end)

RegisterNetEvent('police:server:SetHandcuffStatus', function(isHandcuffed)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.SetMetaData("ishandcuffed", isHandcuffed)
    end
end)

RegisterNetEvent('heli:spotlight', function(state)
    local serverID = source
    TriggerClientEvent('heli:spotlight', -1, serverID, state)
end)

-- RegisterNetEvent('police:server:FlaggedPlateTriggered', function(camId, plate, street1, street2, blipSettings)
--     local src = source
--     for k, v in pairs(QBCore.Functions.GetPlayers()) do
--         local Player = QBCore.Functions.GetPlayer(v)
--         if Player then
--             if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
--                 if street2 then
--                     TriggerClientEvent("112:client:SendPoliceAlert", v, "flagged", {
--                         camId = camId,
--                         plate = plate,
--                         streetLabel = street1 .. " " .. street2
--                     }, blipSettings)
--                 else
--                     TriggerClientEvent("112:client:SendPoliceAlert", v, "flagged", {
--                         camId = camId,
--                         plate = plate,
--                         streetLabel = street1
--                     }, blipSettings)
--                 end
--             end
--         end
--     end
-- end)

RegisterNetEvent('police:server:SearchPlayer', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        TriggerClientEvent('QBCore:Notify', src, 'Found $'..SearchedPlayer.PlayerData.money["cash"]..' on the civilian')
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You are being searched")
    end
end)

RegisterNetEvent('police:server:SeizeCash', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        local moneyAmount = SearchedPlayer.PlayerData.money["cash"]
        local info = { cash = moneyAmount }
        SearchedPlayer.Functions.RemoveMoney("cash", moneyAmount, "police-cash-seized")
        Player.Functions.AddItem("moneybag", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["moneybag"], "add")
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, 'Your cash was confiscated')
    end
end)

RegisterNetEvent('police:server:SeizeDriverLicense', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        local driverLicense = SearchedPlayer.PlayerData.metadata["licences"]["driver"]
        if driverLicense then
            local licenses = {["driver"] = false, ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"]}
            SearchedPlayer.Functions.SetMetaData("licences", licenses)
            TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, 'Your driving license has been confiscated')
        else
            TriggerClientEvent('QBCore:Notify', src, 'No drivers license', 'error')
        end
    end
end)

RegisterNetEvent('police:server:RobPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        local money = SearchedPlayer.PlayerData.money["cash"]
        Player.Functions.AddMoney("cash", money, "police-player-robbed")
        SearchedPlayer.Functions.RemoveMoney("cash", money, "police-player-robbed")
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You have been robbed of $" .. money)
        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, "You have stolen $" .. money)
    end
end)

RegisterNetEvent('police:server:UpdateBlips', function()
    -- KEEP FOR REF BUT NOT NEEDED ANYMORE.
end)

RegisterNetEvent('police:server:spawnObject', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("police:client:spawnObject", src, objectId, type, src)
end)

RegisterNetEvent('police:server:deleteObject', function(objectId)
    TriggerClientEvent('police:client:removeObject', -1, objectId)
end)

RegisterNetEvent('police:server:Impound', function(plate, fullImpound, price, body, engine, fuel)
    local src = source
    local price = price and price or 0
    if IsVehicleOwned(plate) then
        if not fullImpound then
            MySQL.Async.fetchAll(
                'UPDATE player_vehicles SET state = ?, depotprice = ?, body = ?, engine = ?, fuel = ? WHERE plate = ?',
                {0, price, body, engine, fuel, plate})
            TriggerClientEvent('QBCore:Notify', src, "Vehicle taken into depot for $" .. price .. "!")
        else
            MySQL.Async.fetchAll(
                'UPDATE player_vehicles SET state = ?, body = ?, engine = ?, fuel = ? WHERE plate = ?',
                {2, body, engine, fuel, plate})
            TriggerClientEvent('QBCore:Notify', src, "Vehicle seized")
        end
    end
end)

RegisterNetEvent('evidence:server:UpdateStatus', function(data)
    local src = source
    PlayerStatus[src] = data
end)

RegisterNetEvent('evidence:server:CreateBloodDrop', function(citizenid, bloodtype, coords)
    local bloodId = CreateBloodId()
    BloodDrops[bloodId] = {
        dna = citizenid,
        bloodtype = bloodtype
    }
    TriggerClientEvent("evidence:client:AddBlooddrop", -1, bloodId, citizenid, bloodtype, coords)
end)

RegisterNetEvent('evidence:server:CreateFingerDrop', function(coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fingerId = CreateFingerId()
    FingerDrops[fingerId] = Player.PlayerData.metadata["fingerprint"]
    TriggerClientEvent("evidence:client:AddFingerPrint", -1, fingerId, Player.PlayerData.metadata["fingerprint"], coords)
end)

RegisterNetEvent('evidence:server:ClearBlooddrops', function(blooddropList)
    if blooddropList and next(blooddropList) then
        for k, v in pairs(blooddropList) do
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, v)
            BloodDrops[v] = nil
        end
    end
end)

RegisterNetEvent('evidence:server:AddBlooddropToInventory', function(bloodId, bloodInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, bloodInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, bloodId)
            BloodDrops[bloodId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterNetEvent('evidence:server:AddFingerprintToInventory', function(fingerId, fingerInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, fingerInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveFingerprint", -1, fingerId)
            FingerDrops[fingerId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterNetEvent('evidence:server:CreateCasing', function(weapon, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local casingId = CreateCasingId()
    local weaponInfo = QBCore.Shared.Weapons[weapon]
    local serieNumber = nil
    if weaponInfo then
        local weaponItem = Player.Functions.GetItemByName(weaponInfo["name"])
        if weaponItem then
            if weaponItem.info and weaponItem.info ~= "" then
                serieNumber = weaponItem.info.serie
            end
        end
    end
    TriggerClientEvent("evidence:client:AddCasing", -1, casingId, weapon, coords, serieNumber)
end)

RegisterNetEvent('police:server:UpdateCurrentCops', function()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    TriggerClientEvent("police:SetCopCount", -1, amount)
end)

RegisterNetEvent('evidence:server:ClearCasings', function(casingList)
    if casingList and next(casingList) then
        for k, v in pairs(casingList) do
            TriggerClientEvent("evidence:client:RemoveCasing", -1, v)
            Casings[v] = nil
        end
    end
end)

RegisterNetEvent('evidence:server:AddCasingToInventory', function(casingId, casingInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, casingInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveCasing", -1, casingId)
            Casings[casingId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterNetEvent('police:server:showFingerprint', function(playerId)
    local src = source
    TriggerClientEvent('police:client:showFingerprint', playerId, src)
    TriggerClientEvent('police:client:showFingerprint', src, playerId)
end)

RegisterNetEvent('police:server:showFingerprintId', function(sessionId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fid = Player.PlayerData.metadata["fingerprint"]
    TriggerClientEvent('police:client:showFingerprintId', sessionId, fid)
    TriggerClientEvent('police:client:showFingerprintId', src, fid)
end)

RegisterNetEvent('police:server:SetTracker', function(targetId)
    local src = source
    local Target = QBCore.Functions.GetPlayer(targetId)
    local TrackerMeta = Target.PlayerData.metadata["tracker"]
    if TrackerMeta then
        Target.Functions.SetMetaData("tracker", false)
        TriggerClientEvent('QBCore:Notify', targetId, 'Your anklet is taken off.', 'error', 5000)
        TriggerClientEvent('QBCore:Notify', src, 'You took off an ankle bracelet from ' .. Target.PlayerData.charinfo.firstname .. " " .. Target.PlayerData.charinfo.lastname, 'error', 5000)
        TriggerClientEvent('police:client:SetTracker', targetId, false)
    else
        Target.Functions.SetMetaData("tracker", true)
        TriggerClientEvent('QBCore:Notify', targetId, 'You put on an ankle strap.', 'error', 5000)
        TriggerClientEvent('QBCore:Notify', src, 'You put on an ankle strap to ' .. Target.PlayerData.charinfo.firstname .. " " .. Target.PlayerData.charinfo.lastname, 'error', 5000)
        TriggerClientEvent('police:client:SetTracker', targetId, true)
    end
end)

RegisterNetEvent('police:server:SendTrackerLocation', function(coords, requestId)
    local Target = QBCore.Functions.GetPlayer(source)
    local msg = "The location of " .. Target.PlayerData.charinfo.firstname .. " " .. Target.PlayerData.charinfo.lastname .. " is marked on your map."
    local alertData = {
        title = "Anklet location",
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        description = msg
    }
    TriggerClientEvent("police:client:TrackerMessage", requestId, msg, coords)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", requestId, alertData)
end)

RegisterNetEvent('police:server:SyncSpikes', function(table)
    TriggerClientEvent('police:client:SyncSpikes', -1, table)
end)

-- Threads

CreateThread(function()
    while true do
        Wait(1000 * 60 * 10)
        local curCops = GetCurrentCops()
        TriggerClientEvent("police:SetCopCount", -1, curCops)
    end
end)

CreateThread(function()
    while true do
        Wait(5000)
        UpdateBlips()
    end
end)
