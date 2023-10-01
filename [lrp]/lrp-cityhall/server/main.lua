local QBCore = exports['lrp-core']:GetCoreObject()

local DrivingSchools = {

}

RegisterNetEvent('qb-cityhall:server:requestId', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {}
    local identityData = {}
    --print(data.wantlicense)
    identityData.item = data.wantlicense
    if identityData.item == "id_card" then
        info.citizenid = Player.PlayerData.citizenid
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.gender = Player.PlayerData.charinfo.gender
        exports.ox_inventory:AddItem(src, 'id_card', 1, {description = 'Citizen Id:  ' ..info.citizenid..' \n\n First Name:  ' ..info.firstname..'\n\n Last Name:  '..info.lastname..'\n\n Birth Date:  '..info.birthdate..'\n\n Gender:  ' ..info.gender .. ' '})

        --info.nationality = Player.PlayerData.charinfo.nationality
    elseif identityData.item == "driver_license" then
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "Class C Driver License"
        exports.ox_inventory:AddItem(src, 'driver_license', 1, {description = 'First Name:  ' ..info.firstname..'\n\n Last Name:  '..info.lastname..'\n\n Birth Date:  '..info.birthdate..'\n\n License Type:  ' ..info.type .. ' '})

    elseif identityData.item == "cdl_license" then
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "Class A Driver License"
        exports.ox_inventory:AddItem(src, 'cdl_license', 1, {description = 'First Name:  ' ..info.firstname..'\n\n Last Name:  '..info.lastname..'\n\n Birth Date:  '..info.birthdate..'\n\n License Type:  ' ..info.type .. ' '})

    elseif identityData.item == "weaponlicense" then
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        exports.ox_inventory:AddItem(src, 'weaponlicense', 1, {description = 'First Name:  ' ..info.firstname..'\n\n Last Name:  '..info.lastname..'\n\n Birth Date:  '..info.birthdate..' '})

    elseif identityData.item == "permit" then
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "Drivers Permit"
        exports.ox_inventory:AddItem(src, 'permit', 1, {description = 'First Name:  ' ..info.firstname..'\n\n Last Name:  '..info.lastname..'\n\n Birth Date:  '..info.birthdate..'\n\n License Type:  ' ..info.type .. ' '})

    elseif identityData.item == "huntinglicense" then
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "Hunting License"
        exports.ox_inventory:AddItem(src, 'huntinglicense', 1, {description = 'First Name:  ' ..info.firstname..'\n\n Last Name:  '..info.lastname..'\n\n Birth Date:  '..info.birthdate..' '})

    elseif identityData.item == "fishinglicense" then
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "Fishing License"
        exports.ox_inventory:AddItem(src, 'fishinglicense', 1, {description = 'First Name:  ' ..info.firstname..'\n\n Last Name:  '..info.lastname..'\n\n Birth Date:  '..info.birthdate..' '})

    elseif identityData.item == "pilot_license" then
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "Pilot License"
        exports.ox_inventory:AddItem(src, 'pilot_license', 1, {description = 'First Name:  ' ..info.firstname..'\n\n Last Name:  '..info.lastname..'\n\n Birth Date:  '..info.birthdate..' '})

    elseif identityData.item == "boating_license" then
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "Boating License"
        exports.ox_inventory:AddItem(src, 'boating_license', 1, {description = 'First Name:  ' ..info.firstname..'\n\n Last Name:  '..info.lastname..'\n\n Birth Date:  '..info.birthdate..' '})

    end

    --Player.Functions.AddItem(identityData.item, 1, nil, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[identityData.item], 'add')
    Player.Functions.RemoveMoney("cash", 50)
end)


RegisterServerEvent('qb-cityhall:server:getIDs')
AddEventHandler('qb-cityhall:server:getIDs', function()
    local src = source
    GiveStarterItems(src)
end)


RegisterServerEvent('qb-cityhall:server:sendDriverTest')
AddEventHandler('qb-cityhall:server:sendDriverTest', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for k, v in pairs(DrivingSchools) do
        local SchoolPlayer = QBCore.Functions.GetPlayerByCitizenId(v)
        if SchoolPlayer ~= nil then
            TriggerClientEvent("qb-cityhall:client:sendDriverEmail", SchoolPlayer.PlayerData.source, Player.PlayerData.charinfo)
        else
            local mailData = {
                sender = "Township",
                subject = "Driving lessons request",
                message = "Hello,<br /><br />We have just received a message that someone wants to take driving lessons.<br />If you are willing to teach, please contact us:<br />Naam: <strong>".. Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. "<br />Telephone number: <strong>"..Player.PlayerData.charinfo.phone.."</strong><br/><br/>Kind regards,<br />City of Los Santos",
                button = {}
            }
            TriggerEvent("qb-phone:server:sendNewEventMail", v, mailData)
        end
    end
    TriggerClientEvent('QBCore:Notify', src, 'An email has been sent to driving schools, and you will be contacted automatically', "success", 5000)
end)

local AvailableJobs = {
    "trucker",
    "taxi",
    "tow",
    "reporter",
    "garbage",
}

function IsAvailableJob(job)
    local retval = false
    for k, v in pairs(AvailableJobs) do
        if v == job then
            retval = true
        end
    end
    return retval
end

RegisterServerEvent('qb-cityhall:server:ApplyJob')
AddEventHandler('qb-cityhall:server:ApplyJob', function(job)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Ped = GetPlayerPed(src)
    local PedCoords = GetEntityCoords(Ped)
    local JobInfo = QBCore.Shared.Jobs[job]

    if (#(PedCoords - Config.Cityhall.coords) >= 20.0) or (not IsAvailableJob(job)) then
        return DropPlayer(source, "Attempted exploit abuse")
    end

    Player.Functions.SetJob(job, 0)
    TriggerClientEvent('QBCore:Notify', src, 'Congratulations with your new job! ('..JobInfo.label..')')
end)


-- QBCore.Commands.Add("drivinglicense", "Give a driver's license to someone", {{"id", "ID of a person"}}, true, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(source)

--         local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
--         if SearchedPlayer ~= nil then
--             local driverLicense = SearchedPlayer.PlayerData.metadata["licences"]["driver"]
--             if not driverLicense then
--                 local licenses = {
--                     ["driver"] = true,
--                     ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"]
--                 }
--                 SearchedPlayer.Functions.SetMetaData("licences", licenses)
--                 TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You have passed! Pick up your driver's license at the town hall", "success", 5000)
--             else
--                 TriggerClientEvent('QBCore:Notify', src, "Can't give driver's license ..", "error")
--             end
--         end

-- end)

function GiveStarterItems(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    for k, v in pairs(QBCore.Shared.StarterItems) do
        local info = {}
        if v.item == "id_card" then
            info.citizenid = Player.PlayerData.citizenid
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.gender = Player.PlayerData.charinfo.gender
            info.nationality = Player.PlayerData.charinfo.nationality
        elseif v.item == "driver_license" then
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.type = "Class C Driver License"
        end
        Player.Functions.AddItem(v.item, 1, false, info)
    end
end

function IsWhitelistedSchool(citizenid)
    local retval = false
    for k, v in pairs(DrivingSchools) do
        if v == citizenid then
            retval = true
        end
    end
    return retval
end

RegisterServerEvent('qb-cityhall:server:banPlayer')
AddEventHandler('qb-cityhall:server:banPlayer', function()
    local src = source
    --TriggerClientEvent('chatMessage', -1, "QB Anti-Cheat", "error", GetPlayerName(src).." has been banned for sending POST Request's ")
    MySQL.Async.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(src),
        QBCore.Functions.GetIdentifier(src, 'license'),
        QBCore.Functions.GetIdentifier(src, 'discord'),
        QBCore.Functions.GetIdentifier(src, 'ip'),
        'Abuse localhost:13172 For POST Requests',
        2145913200,
        GetPlayerName(src)
    })
    DropPlayer(src, 'Attempting To Exploit')
end)


