QBCore = Config.CoreExport
PlayerList = {}
PlayerListCache = {}
ServerInformation = {
    StaffCount = nil,
    CharacterCount = nil,
    VehicleCount = nil,
    BansCount = nil,
}
SettingsLoaded = {}
DarkMode = {}
LoadedRole = {}
SeeThrough = {}

AdminPanel = {}
AdminPanel.AdminChat = {}
AdminPanel.Reports = {}
InterceptedLogs = {}
players = {}

Citizen.CreateThread(function()
    AdminPanel.GetAllPlayers()
    while true do
        Wait(5000)
        AdminPanel.GetAllPlayers()
    end
end)

if Config.SaveReportsToJSON then
    Citizen.CreateThread(function()
        AdminPanel.Reports = json.decode(LoadResourceFile(GetCurrentResourceName(), "./json/reports.json"))
    end)
    
    AddEventHandler('onResourceStop', function(name)
        if name == GetCurrentResourceName() then
            SaveResourceFile(GetCurrentResourceName(), "json/reports.json", json.encode(AdminPanel.Reports), -1)
        end
    end)
end

QBCore.Commands.Add("a", "Admin Menu", {}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if AdminPanel.HasPermission(src, "adminmenu") then
        OpenPanel(src)
    end
end)

RegisterNetEvent('919-admin:server:RequestPanel', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if AdminPanel.HasPermission(src, "adminmenu") then
        OpenPanel(src)
    end
end)

OpenPanel = function(source)
    local playerList = {}
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        local version = GetResourceMetadata(GetCurrentResourceName(), "version", 0)
        if version == nil then version = "Unknown Version" end
        TriggerClientEvent('919-admin:client:OpenMenu', source, json.encode(ServerInformation.PlayerList), DarkMode[source], SeeThrough[source], ServerInformation, GetConvarInt('sv_maxclients', 32), version)
    end
end

QBCore.Functions.CreateCallback('919-admin:server:Refresh', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if AdminPanel.HasPermission(src, "adminmenu") then
        local playerList = {}
        for k, v in ipairs(QBCore.Functions.GetPlayers()) do
            local thePlayer = QBCore.Functions.GetPlayer(v)
            
            local identifiers, steamIdentifier = GetPlayerIdentifiers(v)
            for _, v2 in pairs(identifiers) do
                if string.find(v2, "license:") then
                    steamIdentifier = v2
                end
                if not Config.ShowIPInIdentifiers then
                    if string.find(v2, "ip:") then
                        identifiers[_] = nil
                    end
                end
            end
            table.insert(playerList, 
                {
                    id = v, 
                    name = GetPlayerName(v), 
                    identifiers = json.encode(identifiers), 
                    role = QBCore.Functions.GetPermission(v),
                    bank = '$'..comma_value(thePlayer.PlayerData.money.bank),
                    cash = '$'..comma_value(thePlayer.PlayerData.money.cash),
                    steamid = steamIdentifier,
                    citizenid = thePlayer.PlayerData.citizenid,
                    job = thePlayer.PlayerData.job.label,
                    rank = thePlayer.PlayerData.job.grade.name,
                    health = GetEntityHealth(GetPlayerPed(thePlayer.PlayerData.source)) / 2,
                    armor = GetPedArmour(GetPlayerPed(thePlayer.PlayerData.source)),
                    jobboss = thePlayer.PlayerData.job.isboss and "<span class=\"badge badge-success\">Yes</span>" or "<span class=\"badge badge-danger\">No</span>",
                    duty = thePlayer.PlayerData.job.onduty and "<span class=\"badge badge-success\">Yes</span>" or "<span class=\"badge badge-danger\">No</span>",
                    gang = thePlayer.PlayerData.gang.label,
                    gangrank = thePlayer.PlayerData.gang.grade.name,
                    gangboss = thePlayer.PlayerData.gang.isboss and "<span class=\"badge badge-success\">Yes</span>" or "<span class=\"badge badge-danger\">No</span>",
                    charname = thePlayer.PlayerData.charinfo.firstname .. ' ' .. thePlayer.PlayerData.charinfo.lastname,
                }
            )
        end
        cb(playerList)
    end
end)

RegisterNetEvent("919-admin:AddPlayer", function()
    local src = source
    TriggerClientEvent("919-admin:AddPlayer", -1, src, os.time() )
end)

RegisterNetEvent("919-admin:server:RequestJobPageInfo", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if AdminPanel.HasPermission(src, "jobpage") then
            local JobInfo = {}
            for k,v in pairs(QBCore.Shared.Jobs) do
                local JobEmployees = {}
                local results = MySQL.query.await("SELECT * FROM `"..Config.DB.CharactersTable.."` WHERE `job` LIKE ?", {"%"..k.."%"})
                for k1,v1 in ipairs(results) do
                    local CharInfo = json.decode(v1.charinfo)
                    local CharName = "Unknown?"
                    if CharInfo then
                        CharName = CharInfo.firstname .. ' ' .. CharInfo.lastname
                    end
                    local JobInfo = json.decode(v1.job)
                    local GradeInfo = JobInfo.grade
                    local Online = QBCore.Functions.GetPlayerByCitizenId(v1.citizenid)
                    table.insert(JobEmployees, {
                        Name = v1.name,
                        CitizenId = v1.citizenid,
                        CharName = CharName,
                        IsBoss = JobInfo.isboss,
                        IsOnline = Online and "<span class=\"badge bg-success text-light\">ONLINE</span>" or "<span class=\"badge bg-danger text-light\">OFFLINE</span>",
                        Grade = {name = GradeInfo.name, level = GradeInfo.level},
                    })
                end
                JobInfo[k] = JobEmployees
            end
            TriggerClientEvent("919-admin:client:ReceiveJobPageInfo", src, JobInfo)
        end
    end
end)

RegisterNetEvent("919-admin:server:RequestGangPageInfo", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if AdminPanel.HasPermission(src, "gangpage") then
            local GangInfo = {}
            for k,v in pairs(QBCore.Shared.Gangs) do
                local GangMembers = {}
                local results = MySQL.query.await("SELECT * FROM `"..Config.DB.CharactersTable.."` WHERE `gang` LIKE ?", {"%"..k.."%"})
                for k1,v1 in ipairs(results) do
                    local CharInfo = json.decode(v1.charinfo)
                    local CharName = "Unknown?"
                    if CharInfo then
                        CharName = CharInfo.firstname .. ' ' .. CharInfo.lastname
                    end
                    local GangInfo = json.decode(v1.gang)
                    local GradeInfo = GangInfo.grade
                    local Online = QBCore.Functions.GetPlayerByCitizenId(v1.citizenid)
                    table.insert(GangMembers, {
                        Name = v1.name,
                        CitizenId = v1.citizenid,
                        CharName = CharName,
                        IsBoss = GangInfo.isboss,
                        IsOnline = Online and "<span class=\"badge bg-success text-light\">ONLINE</span>" or "<span class=\"badge bg-danger text-light\">OFFLINE</span>",
                        Grade = {name = GradeInfo.name, level = GradeInfo.level},
                    })
                end
                GangInfo[k] = GangMembers
            end
            TriggerClientEvent("919-admin:client:ReceiveGangPageInfo", src, GangInfo)
        end
    end
end)

RegisterNetEvent("919-admin:server:RequestBansInfo", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if AdminPanel.HasPermission(src, "banspage") then
            local results = MySQL.query.await("SELECT * FROM `"..Config.DB.BansTable.."`")
            local BansInfo = {}
            for k1,v1 in ipairs(results) do
                table.insert(BansInfo, {
                    ID = v1.id,
                    Name = v1.name,
                    License = v1.license,
                    Discord = v1.discord,
                    IP = v1.ip,
                    Reason = v1.reason,
                    Expire = v1.expire,
                    BannedBy = v1.bannedby
                })
            end
            TriggerClientEvent("919-admin:client:ReceiveBansInfo", src, BansInfo)
        end
    end
end)

RegisterNetEvent("919-admin:server:RequestReportsInfo", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if AdminPanel.HasPermission(src, "viewreports") then
            TriggerClientEvent("919-admin:client:ReceiveReportsInfo", src, AdminPanel.Reports)
        end
    end
end)

RegisterNetEvent("919-admin:server:RequestAdminChat", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if AdminPanel.HasPermission(src, "adminchat") then
            TriggerClientEvent("919-admin:client:ReceiveAdminChat", src, AdminPanel.AdminChat)
        end
    end
end)

RegisterNetEvent("919-admin:server:RequestVehiclesInfo", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if AdminPanel.HasPermission(src, "vehiclesinfo") then
            TriggerClientEvent("919-admin:client:ReceiveVehiclesInfo", src, QBCore.Shared.Vehicles)
        end
    end
end)

RegisterNetEvent("919-admin:server:RequestItemsInfo", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if AdminPanel.HasPermission(src, "itemsinfo") then
            TriggerClientEvent("919-admin:client:ReceiveItemsInfo", src, QBCore.Shared.Items)
        end
    end
end)

RegisterNetEvent("919-admin:server:RequestCharacters", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if AdminPanel.HasPermission(src, "characterspage") then
            local results = MySQL.query.await("SELECT * FROM `"..Config.DB.CharactersTable.."`")
            TriggerClientEvent("919-admin:client:ReceiveCharacters", src, results)
        end
    end
end)

RegisterNetEvent("919-admin:server:RequestNoClip", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src, "noclip")
    if Player then
        if AdminPanel.HasPermission(src, "noclip") then
            TriggerClientEvent("919-admin:client:ToggleNoClip", src)
        end
    end
end)

RegisterNetEvent("919-admin:server:AdminChatSend", function(message)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if AdminPanel.HasPermission(src, "adminchat") then
            local SenderName = GetPlayerName(src)
            local SentTime = os.time()
            table.insert(AdminPanel.AdminChat, {Sender = SenderName, TimeStamp = SentTime, Message = message})
            for k, v in pairs(QBCore.Functions.GetPlayers()) do
                if AdminPanel.HasPermissionEx(v, "adminchat") then
                    TriggerClientEvent("919-admin:client:ReceiveAdminChat", v, AdminPanel.AdminChat)
                end
            end
        end
    end
end)

RegisterNetEvent("919-admin:server:SendReport", function(subject, info, type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local CitizenId = Player.PlayerData.citizenid
        local reportCount = 0
        for k,v in pairs(AdminPanel.Reports) do
            if v.SenderCitizenID == CitizenId then
                reportCount = reportCount + 1
            end
        end
        if reportCount >= Config.MaxReportsPerPlayer then
            return TriggerClientEvent("919-admin:client:ShowReportAlert", src, "CAN'T SEND REPORT", "You have reached the limit of reports, please wait for assistance!")
        end
        TriggerClientEvent("919-admin:client:ShowReportAlert", src, "REPORT SENT", "Your report was sent to server staff!")
        local sendername = GetPlayerName(src).." ("..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname..")"
        table.insert(AdminPanel.Reports, {ReportID = #AdminPanel.Reports + 1, Claimed = nil, ReportTime = os.time(), SenderCitizenID = Player.PlayerData.citizenid, SenderID = src, SenderName = sendername, Subject = subject, Info = info, Type = type})
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            if AdminPanel.HasPermissionEx(v, "viewreports") then
                TriggerClientEvent("919-admin:client:ShowReportAlert", v, "NEW REPORT", sendername..": "..subject)
            end
        end
    end
end)

RegisterServerEvent("919-admin:server:ClaimReport", function(id)
    local src = source
    if AdminPanel.HasPermission(src, "claimreport") then
        if AdminPanel.Reports[tonumber(id)] then
            AdminPanel.Reports[tonumber(id)].Claimed = GetPlayerName(src)
            TriggerEvent("qb-log:server:CreateLog", "adminactions", "Report Claimed", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** claimed report ID "..id, false)
            for k, v in pairs(QBCore.Functions.GetPlayers()) do
                if AdminPanel.HasPermission(v, "viewreports") then
                    TriggerClientEvent("919-admin:client:ShowReportAlert", v, "REPORT CLAIMED", GetPlayerName(src).." claimed Report ID ".. id.." from "..AdminPanel.Reports[tonumber(id)].SenderName..".")
                end
            end
            TriggerClientEvent("919-admin:client:ShowPanelAlert", AdminPanel.Reports[tonumber(id)].SenderID, "success", "<strong>REPORT:</strong> Your report was claimed by Staff Member <strong>"..GetPlayerName(src).."</strong>.")
            TriggerClientEvent("919-admin:client:ReceiveReportsInfo", src, AdminPanel.Reports)
        end
    end
end)


RegisterServerEvent("919-admin:server:DeleteReport", function(id)
    local src = source
    if AdminPanel.HasPermission(src, "deletereport") then
        if AdminPanel.Reports[tonumber(id)] then
            AdminPanel.Reports[tonumber(id)] = nil
            TriggerEvent("qb-log:server:CreateLog", "adminactions", "Report Deleted", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** deleted report ID "..id, false)
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Deleted Report ID " .. id..".")
            TriggerClientEvent("919-admin:client:ReceiveReportsInfo", src, AdminPanel.Reports)
        end
    end
end)


RegisterNetEvent("919-admin:server:ResourceAction", function(resourceName, action)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if AdminPanel.HasPermission(src, "adminmenu") then
            if action == "start" then
                if GetResourceState(resourceName) == "stopped" then
                    StartResource(resourceName)
                    Wait(500)
                    TriggerClientEvent('919-admin:client:ShowPanelAlert', src, 'success', '<strong>STARTED RESOURCE:</strong> '..resourceName)
                else
                    TriggerClientEvent('919-admin:client:ShowPanelAlert', src, 'success', '<strong>ERROR:</strong> Resource is already running, can\'t start.')
                end
            elseif action == "stop" then
                if GetResourceState(resourceName) == "started" then
                    StopResource(resourceName)
                    Wait(500)
                    TriggerClientEvent('919-admin:client:ShowPanelAlert', src, 'danger', '<strong>STOPPED RESOURCE:</strong> '..resourceName)
                else
                    TriggerClientEvent('919-admin:client:ShowPanelAlert', src, 'success', '<strong>ERROR:</strong> Resource is not running, can\'t stop.')
                end
            elseif action == "restart" then
                if GetResourceState(resourceName) == "started" then
                    StopResource(resourceName)
                    Wait(500)
                    StartResource(resourceName)
                    TriggerClientEvent('919-admin:client:ShowPanelAlert', src, 'success', '<strong>RESTARTED RESOURCE:</strong> '..resourceName)
                else
                    TriggerClientEvent('919-admin:client:ShowPanelAlert', src, 'success', '<strong>ERROR:</strong> Resource is not running, can\'t restart.')
                end
            end
            TriggerClientEvent('919-admin:client:ForceReloadResources', src)
        end
    end
end)

RegisterNetEvent("919-admin:server:MonetaryAction", function(targetId, action, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(targetId)
    if AdminPanel.HasPermission(src, "givetakemoney") then
        if Player then
            if action == "givecash" then
                Player.Functions.AddMoney("cash", amount, "Admin Action")
                TriggerClientEvent('919-admin:client:ShowPanelAlert', source, 'success', '<strong>SUCCESS:</strong> You gave $'..amount..' cash to '..GetPlayerName(targetId))
            elseif action == "removecash" then
                Player.Functions.RemoveMoney("cash", amount, "Admin Action")
                TriggerClientEvent('919-admin:client:ShowPanelAlert', source, 'success', '<strong>SUCCESS:</strong> You removed $'..amount..' cash from '..GetPlayerName(targetId))
            elseif action == "givebank" then
                Player.Functions.AddMoney("bank", amount, "Admin Action")
                TriggerClientEvent('919-admin:client:ShowPanelAlert', source, 'success', '<strong>SUCCESS:</strong> You gave $'..amount..' bank money to '..GetPlayerName(targetId))
            elseif action == "removebank" then
                Player.Functions.RemoveMoney("bank", amount, "Admin Action")
                TriggerClientEvent('919-admin:client:ShowPanelAlert', source, 'success', '<strong>SUCCESS:</strong> You removed $'..amount..' bank money from '..GetPlayerName(targetId))
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have permission to do this.", "error")
    end
end)

RegisterNetEvent("919-admin:server:RequestViewPlayer", function(CitizenId)
    DebugTrace(CitizenId)
    local src = source
    local Player = QBCore.Functions.GetPlayerByCitizenId(CitizenId)
    if Player then
        TriggerClientEvent("919-admin:client:ViewPlayer", src, true, Player.PlayerData.source)
    else
        local results = MySQL.query.await("SELECT * FROM `"..Config.DB.CharactersTable.."` WHERE `citizenid` = ? LIMIT 1", {CitizenId})
        local PlayerData = nil
        for k1,v1 in ipairs(results) do
            v1.charinfo = json.decode(v1.charinfo)
            v1.job = json.decode(v1.job)
            v1.money = json.decode(v1.money)
            v1.metadata = json.decode(v1.metadata)
            v1.gang = json.decode(v1.gang)
            PlayerData = v1
            break
        end
        while not PlayerData do Wait(0) end
        local FixedPlayerData = {
            id = "OFFLINE", 
            name = PlayerData.name, 
            identifiers = PlayerData.license, 
            role = PlayerData.role,
            bank = '$'..comma_value(PlayerData.money.bank),
            cash = '$'..comma_value(PlayerData.money.cash),
            steamid = PlayerData.license,
            citizenid = PlayerData.citizenid,
            gender = PlayerData.charinfo.gender,
            nationality = PlayerData.charinfo.nationality,
            phone = PlayerData.charinfo.phone,
            accountid = PlayerData.charinfo.account,
            hunger = PlayerData.metadata['hunger'],
            thirst = PlayerData.metadata['thirst'],
            injail = PlayerData.metadata['injail'],
            job = PlayerData.job.label,
            rank = PlayerData.job.grade.name,
            health = 0,
            armor = 0,
            jobboss = PlayerData.job.isboss and "<span class=\"badge badge-success\">Yes</span>" or "<span class=\"badge badge-danger\">No</span>",
            duty = PlayerData.job.onduty and "<span class=\"badge badge-success\">Yes</span>" or "<span class=\"badge badge-danger\">No</span>",
            gang = PlayerData.gang.label,
            gangrank = PlayerData.gang.grade.name,
            gangboss = PlayerData.gang.isboss and "<span class=\"badge badge-success\">Yes</span>" or "<span class=\"badge badge-danger\">No</span>",
            charname = PlayerData.charinfo.firstname .. ' ' .. PlayerData.charinfo.lastname,
        }
        TriggerClientEvent("919-admin:client:ViewPlayer", src, false, FixedPlayerData)
    end
end)

AddEventHandler("playerDropped", function()
	local src = source
    TriggerClientEvent("919-admin:RemovePlayer", -1, src)
end)

RegisterNetEvent("919-admin:server:RefreshMenu", function(silent)
    local src = source
    local playerList = {}
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            local thePlayer = QBCore.Functions.GetPlayer(v)
            local identifiers, steamIdentifier = GetPlayerIdentifiers(v)
            for _, v2 in pairs(identifiers) do
                if string.find(v2, "license:") then
                    steamIdentifier = v2
                end
                if not Config.ShowIPInIdentifiers then
                    if string.find(v2, "ip:") then
                        identifiers[_] = nil
                    end
                end
            end
            local playerRole = "user"
            if QBCore.Functions.HasPermission(v, "god") then 
                playerRole = "god"
            elseif QBCore.Functions.HasPermission(v, "admin") then 
                playerRole = "admin"
            end
            table.insert(playerList, 
                {
                    id = v, 
                    name = GetPlayerName(v), 
                    identifiers = json.encode(identifiers), 
                    role = playerRole,
                    bank = '$'..comma_value(thePlayer.PlayerData.money.bank),
                    cash = '$'..comma_value(thePlayer.PlayerData.money.cash),
                    steamid = steamIdentifier,
                    citizenid = thePlayer.PlayerData.citizenid,
                    gender = thePlayer.PlayerData.charinfo.gender,
                    nationality = thePlayer.PlayerData.charinfo.nationality,
                    phone = thePlayer.PlayerData.charinfo.phone,
                    accountid = thePlayer.PlayerData.charinfo.account,
                    hunger = thePlayer.PlayerData.metadata['hunger'],
                    thirst = thePlayer.PlayerData.metadata['thirst'],
                    injail = thePlayer.PlayerData.metadata['injail'],
                    job = thePlayer.PlayerData.job.label,
                    rank = thePlayer.PlayerData.job.grade.name,
                    health = GetEntityHealth(GetPlayerPed(thePlayer.PlayerData.source)) / 2,
                    armor = GetPedArmour(GetPlayerPed(thePlayer.PlayerData.source)),
                    jobboss = thePlayer.PlayerData.job.isboss and "<span class=\"badge badge-success\">Yes</span>" or "<span class=\"badge badge-danger\">No</span>",
                    duty = thePlayer.PlayerData.job.onduty and "<span class=\"badge badge-success\">Yes</span>" or "<span class=\"badge badge-danger\">No</span>",
                    gang = thePlayer.PlayerData.gang.label,
                    gangrank = thePlayer.PlayerData.gang.grade.name,
                    gangboss = thePlayer.PlayerData.gang.isboss and "<span class=\"badge badge-success\">Yes</span>" or "<span class=\"badge badge-danger\">No</span>",
                    charname = thePlayer.PlayerData.charinfo.firstname .. ' ' .. thePlayer.PlayerData.charinfo.lastname,
                }
            )
        end
        TriggerClientEvent('919-admin:client:RefreshMenu', source, json.encode(playerList), json.encode({}), silent)
    end
end)

RegisterServerEvent('qb-log:server:CreateLog',  function(name, title, color, message, tagEveryone)
    table.insert(InterceptedLogs, {time=os.time(), from=name, title=title, message=message})
end)

QBCore.Functions.CreateCallback("919-admin:server:HasPermission", function(source, cb, permission)
    if AdminPanel.HasPermission(source, permission) then
        return cb(true)
    end
end)

AdminPanel.HasPermission = function(targetId, permName)
    local Player = QBCore.Functions.GetPlayer(targetId)
    local Permission = nil
    if Player then
        hasPerms = false
        for k,v in pairs(Config.Permissions) do
            if QBCore.Functions.HasPermission(targetId, k) then
                hasPerms = true
                for _,action in pairs(v.AllowedActions) do
                    if action == permName then
                        return true
                    end
                end
            end
        end
    end

    if hasPerms then
        TriggerClientEvent('919-admin:client:ShowPanelAlert', targetId, 'danger', '<strong>ERROR:</strong> You don\'t have permission for that.')
        TriggerClientEvent("919-admin:client:ResetMenu", targetId)
    end
    return false
end

AdminPanel.HasPermissionEx = function(targetId, permName)
    local Player = QBCore.Functions.GetPlayer(targetId)
    local Permission = nil
    if Player then
        for k,v in pairs(Config.Permissions) do
            if QBCore.Functions.HasPermission(targetId, k) then
                for _,action in pairs(v.AllowedActions) do
                    if action == permName then
                        return true
                    end
                end
            end
        end
    end
    TriggerClientEvent("919-admin:client:ResetMenu", targetId)
    return false
end

AdminPanel.CharacterName = function(Player)
    if Player.PlayerData then
        return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    end
end

RegisterNetEvent("919-admin:server:RequestResourcePageInfo", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if AdminPanel.HasPermission(src, "resourcepage") then
            local resourceList = {}
            for i = 0, GetNumResources(), 1 do
                local resource_name = GetResourceByFindIndex(i)
                if resource_name then
                    if resource_name ~= "_cfx_internal" and resource_name ~= "fivem" then -- Ignore these two base resources. Others are ok.
                        table.insert(resourceList, { resource_name, GetResourceState(resource_name) })
                    end
                end
            end
            TriggerClientEvent("919-admin:client:ReceiveResourcePageInfo", src, resourceList)
        end
    end
end)

RegisterNetEvent("919-admin:server:RequestCurrentLogs", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if AdminPanel.HasPermission(src, "serverlogs") then
            TriggerClientEvent("919-admin:client:ReceiveCurrentLogs", src, InterceptedLogs)
        end
    end
end)

RegisterNetEvent("919-admin:server:RequestServerMetrics", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if AdminPanel.HasPermission(src, "servermetrics") then
            local ServerMetrics = {}
            ServerMetrics.StaffCount = 0
            results = MySQL.query.await("SELECT * FROM `"..Config.DB.CharactersTable.."`", {})
            ServerMetrics.CharacterCount = #results
            ServerMetrics.TotalCash = 0
            for k,v in pairs(results) do
                if v.money then
                    local money = json.decode(v.money)
                    if money then
                        ServerMetrics.TotalCash = ServerMetrics.TotalCash + money.cash
                    end
                end
            end
            ServerMetrics.TotalBank = 0
            for k,v in pairs(results) do
                if v.money then
                    local money = json.decode(v.money)
                    if money then
                        ServerMetrics.TotalBank = ServerMetrics.TotalBank + money.bank
                    end
                end
            end
            ServerMetrics.TotalItems = 0
            for k,v in pairs(results) do
                if v.inventory then
                    local inv = json.decode(v.inventory)
                    if inv then
                        local count = 0
                        for k,v in pairs(inv) do
                            count = count + 1
                        end
                        ServerMetrics.TotalItems = ServerMetrics.TotalItems + count
                    end
                end
            end
            results = MySQL.query.await("SELECT * FROM `"..Config.DB.VehiclesTable.."`", {})
            ServerMetrics.VehicleCount = #results
            results = MySQL.query.await("SELECT * FROM `"..Config.DB.BansTable.."`", {})
            ServerMetrics.BansCount = #results
            results = MySQL.query.await("SELECT DISTINCT `license` FROM `"..Config.DB.CharactersTable.."`", {})
            ServerMetrics.UniquePlayers = #results
            TriggerClientEvent("919-admin:client:ReceiveServerMetrics", src, ServerMetrics)
        end
    end
end)

function comma_value(amount)
    local formatted = math.floor(amount)
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end

AdminPanel.GetAllPlayers = function()
    ServerInformation.PlayerList = {}
    ServerInformation.StaffCount = 0
    for k,v in ipairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(tonumber(v))
        if Player then
            if not SettingsLoaded[tonumber(v)] then
                if Player.PlayerData.metadata['adminpanel_darkmode'] == nil then
                    Player.Functions.SetMetaData('adminpanel_darkmode', Config.DefaultDarkMode)
                    DarkMode[tonumber(v)] = Config.DefaultDarkMode
                else
                    DarkMode[tonumber(v)] = Player.PlayerData.metadata['adminpanel_darkmode']
                end
                if Player.PlayerData.metadata['adminpanel_seethrough'] == nil then
                    Player.Functions.SetMetaData('adminpanel_seethrough', 0)
                    SeeThrough[tonumber(v)] = 0
                else
                    SeeThrough[tonumber(v)] = Player.PlayerData.metadata['adminpanel_seethrough']
                end
                DebugTrace("Loaded panel settings for "..GetPlayerName(tonumber(v)))
                SettingsLoaded[v] = true
            end
            local identifiers, steamIdentifier = GetPlayerIdentifiers(tonumber(v))
            for _, v2 in pairs(identifiers) do
                if string.find(v2, "license:") then
                    steamIdentifier = v2
                end
                if not Config.ShowIPInIdentifiers then
                    if string.find(v2, "ip:") then
                        identifiers[_] = nil
                    end
                end
            end
            local playerRole = "user"
            if QBCore.Functions.HasPermission(tonumber(v), "god") then 
                ServerInformation.StaffCount = ServerInformation.StaffCount + 1
                playerRole = "god"
            elseif QBCore.Functions.HasPermission(tonumber(v), "admin") then 
                ServerInformation.StaffCount = ServerInformation.StaffCount + 1
                playerRole = "admin"
            end
            LoadedRole[tonumber(v)] = playerRole
            table.insert(ServerInformation.PlayerList, 
                {
                    id = v, 
                    name = GetPlayerName(v), 
                    identifiers = json.encode(identifiers), 
                    role = LoadedRole[v],
                    bank = '$'..comma_value(Player.PlayerData.money.bank),
                    cash = '$'..comma_value(Player.PlayerData.money.cash),
                    steamid = steamIdentifier,
                    citizenid = Player.PlayerData.citizenid,
                    gender = Player.PlayerData.charinfo.gender,
                    nationality = Player.PlayerData.charinfo.nationality,
                    phone = Player.PlayerData.charinfo.phone,
                    accountid = Player.PlayerData.charinfo.account,
                    hunger = Player.PlayerData.metadata['hunger'],
                    thirst = Player.PlayerData.metadata['thirst'],
                    injail = Player.PlayerData.metadata['injail'],
                    job = Player.PlayerData.job.label,
                    rank = Player.PlayerData.job.grade.name,
                    health = GetEntityHealth(GetPlayerPed(Player.PlayerData.source)) / 2,
                    armor = GetPedArmour(GetPlayerPed(Player.PlayerData.source)),
                    jobboss = Player.PlayerData.job.isboss and "<span class=\"badge badge-success\">Yes</span>" or "<span class=\"badge badge-danger\">No</span>",
                    duty = Player.PlayerData.job.onduty and "<span class=\"badge badge-success\">Yes</span>" or "<span class=\"badge badge-danger\">No</span>",
                    gang = Player.PlayerData.gang.label,
                    gangrank = Player.PlayerData.gang.grade.name,
                    gangboss = Player.PlayerData.gang.isboss and "<span class=\"badge badge-success\">Yes</span>" or "<span class=\"badge badge-danger\">No</span>",
                    charname = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
                }
            )
        end
    end
end

RegisterNetEvent('qb-admin:server:GetPlayersForBlips', function()
    local src = source
    TriggerClientEvent('qb-admin:client:Show', src, players)
end)

CreateThread(function()
    while true do
        local tempPlayers = {}
        for _, v in pairs(QBCore.Functions.GetPlayers()) do
            local targetped = GetPlayerPed(v)
            local ped = QBCore.Functions.GetPlayer(v)
            tempPlayers[#tempPlayers + 1] = {
                name = (ped.PlayerData.charinfo.firstname or '') .. ' ' .. (ped.PlayerData.charinfo.lastname or '') .. ' | (' .. (GetPlayerName(v) or '') .. ')',
                id = v,
                coords = GetEntityCoords(targetped),
                cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
                citizenid = ped.PlayerData.citizenid,
                sources = GetPlayerPed(ped.PlayerData.source),
                sourceplayer = ped.PlayerData.source

            }
        end
        -- Sort players list by source ID (1,2,3,4,5, etc) --
        table.sort(tempPlayers, function(a, b)
            return a.id < b.id
        end)
        players = tempPlayers
        Wait(3000)
    end
end)
