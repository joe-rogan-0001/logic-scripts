SendPlayerBack = {}
SendBack = {}
SpectatingPlayer = {}
Frozen = {}

RegisterServerEvent("919-admin:server:SetPosition", function(playerId, x, y, z)
    local src = source
    if AdminPanel.HasPermission(src, "teleport") then
        SetEntityCoords(GetPlayerPed(playerId), x, y, z)
    end
end)

RegisterServerEvent("919-admin:server:KillPlayer", function(playerId)
    local src = source
    if AdminPanel.HasPermission(src, "kill") then
        TriggerClientEvent("hospital:client:KillPlayer", playerId)
        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Killed " .. GetPlayerName(playerId) .. ".")
        TriggerEvent("qb-log:server:CreateLog", "adminactions", "KICK", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** killed **" .. GetPlayerName(playerId) .. "** [" .. playerId .. "]", false)
    end
end)

RegisterServerEvent("919-admin:server:SavePlayer", function(playerId)
    local src = source
    if AdminPanel.HasPermission(src, "savedata") then
        local TargetPlayer = QBCore.Functions.GetPlayer(playerId)
        if TargetPlayer then
            TargetPlayer.Functions.Save()
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Saved " .. GetPlayerName(playerId) .. "'s info to database.")
            TriggerEvent("qb-log:server:CreateLog", "adminactions", "KICK", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** saved to database **" .. GetPlayerName(playerId) .. "** [" .. playerId .. "]", false)
        end
    end
end)

RegisterServerEvent("919-admin:server:KickPlayer", function(playerId, reason)
    local src = source
    if AdminPanel.HasPermission(src, "kick") then
        TriggerEvent("qb-log:server:CreateLog", "adminactions", "KICK", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** kicked **" .. GetPlayerName(playerId) .. "** [" .. playerId .. "] for: " .. reason, false)
        DropPlayer(playerId, "You have been kicked from the server:\n" .. reason .. "\n\n🔸 Join our Discord for further information: " .. Config.ServerDiscord)
    end
end)

RegisterServerEvent("919-admin:server:Freeze", function(playerId)
    local src = source
    if AdminPanel.HasPermission(src, "freeze") then
        if not Frozen[playerId] then
            Frozen[playerId] = true
            FreezeEntityPosition(GetPlayerPed(playerId), true)
            --TriggerClientEvent("QBCore:Notify", src, "Froze "..GetPlayerName(playerId)..".", "success")
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Froze " .. GetPlayerName(playerId) .. ".")
            TriggerEvent("qb-log:server:CreateLog", "adminactions", "Frozen", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** froze **" .. GetPlayerName(playerId) .. "** [" .. playerId .. "]", false)
        else
            Frozen[playerId] = false
            FreezeEntityPosition(GetPlayerPed(playerId), false)
            --TriggerClientEvent("QBCore:Notify", src, "Unfroze "..GetPlayerName(playerId)..".", "success")
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Unfroze " .. GetPlayerName(playerId) .. ".")
            TriggerEvent("qb-log:server:CreateLog", "adminactions", "Frozen", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** unfroze **" .. GetPlayerName(playerId) .. "** [" .. playerId .. "]", false)
        end
    end
end)

RegisterServerEvent("919-admin:server:KickAllPlayers", function(reason)
    local src = source
    if AdminPanel.HasPermission(src, "kickall") then
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            if v ~= src then
                DropPlayer(v, "You were kicked from " .. Config.ServerName .. ". Reason: \n" .. reason .. "\n\n🔸 Join our Discord for further information: " .. Config.ServerDiscord)
            end
        end
    end
end)

RegisterNetEvent("919-admin:server:BanPlayer", function(player, time, reason, citizenid)
    local src = source
    if AdminPanel.HasPermission(src, "ban") then
        local time = tonumber(time)
        local banTime = tonumber(os.time() + time)
        if banTime > 2147483647 then
            banTime = 2147483647
        end
        local timeTable = os.date("*t", banTime)
        if player ~= "OFFLINE" then
            AdminPanel.OnlineBanPlayer(src, player, time, timeTable, reason)
        else
            if citizenid ~= nil then
                local result = MySQL.query.await("SELECT * FROM `" .. Config.DB.CharactersTable .. "` WHERE `citizenid` = ?", {citizenid})
                if result[1] then
                    local online = false
                    for k, v in pairs(QBCore.Functions.GetPlayers()) do
                        if QBCore.Functions.GetIdentifier(v, "license") == result[1].license then --Player is online but not on this character. so we'll ban them online
                            AdminPanel.OnlineBanPlayer(src, v, time, timeTable, reason)
                            online = true
                            break
                        end
                    end
                    if not online then
                        MySQL.insert("INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)", {
                            result[1].name,
                            result[1].license,
                            "",
                            "",
                            reason,
                            banTime,
                            GetPlayerName(src)
                        })
                        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "Banned " .. result[1].name .. " (OFFLINE) for " .. (time / 60 / 60) .. " hours.")
                        if Config.AnnounceBan then
                            TriggerClientEvent("chat:addMessage", -1, {
                                template = '<div class=chat-message server"><strong>{0}</strong> has been offline banned by <strong>{1}</strong> for {2} hours. Reason: {3}</div>',
                                args = {result[1].name, GetPlayerName(src), time / 60 / 60, reason}
                            })
                        end
                        TriggerEvent("qb-log:server:CreateLog", "bans", "Player Banned", "red", string.format("%s was banned by %s for %s (%s hours)", result[1].name, GetPlayerName(src), reason, time / 60 / 60), Config.TagEveryone)
                    end
                else
                    DebugTrace("Offline ban citizenid had no results. CitizenID: " .. citizenid)
                end
            else
                DebugTrace("Tried to ban offline but citizenid was invalid. Scripting error.")
            end
        end
    end
end)

AdminPanel.OnlineBanPlayer = function(source, player, time, timeTable, reason)
    local src = source
    local time = tonumber(time)
    local banTime = tonumber(os.time() + time)
    if banTime > 2147483647 then
        banTime = 2147483647
    end
    MySQL.insert("INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)", {
        GetPlayerName(player),
        QBCore.Functions.GetIdentifier(player, "license"),
        QBCore.Functions.GetIdentifier(player, "discord"),
        QBCore.Functions.GetIdentifier(player, "ip"),
        reason,
        banTime,
        GetPlayerName(src)
    })
    TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "Banned " .. GetPlayerName(player) .. " for " .. (time / 60 / 60) .. " hours.")
    if Config.AnnounceBan then
        TriggerClientEvent("chat:addMessage", -1, {
            template = '<div class=chat-message server"><strong>{0}</strong> has been banned by <strong>{1}</strong> for {2} hours. Reason: {3}</div>',
            args = {GetPlayerName(player), GetPlayerName(src), time / 60 / 60, reason}
        })
    end
    TriggerEvent("qb-log:server:CreateLog", "bans", "Player Banned", "red", string.format("%s was banned by %s for %s (%s hours)", GetPlayerName(player), GetPlayerName(src), reason, time / 60 / 60), Config.TagEveryone)
    if banTime >= 2147483647 then
        DropPlayer(player, "You have been banned:\n" .. reason .. "\n\nYour ban is permanent.\n🔸 Check our Discord for more information: " .. Config.ServerDiscord)
    else
        DropPlayer(player, "You have been banned:\n" .. reason .. "\n\nBan expires: " .. timeTable["day"] .. "/" .. timeTable["month"] .. "/" .. timeTable["year"] .. " " .. timeTable["hour"] .. ":" .. timeTable["min"] .. "\n🔸 Check our Discord for more information: " .. Config.ServerDiscord)
    end
end

RegisterNetEvent("919-admin:server:WarnPlayer", function(player, reason, citizenid)
    local src = source
    if AdminPanel.HasPermission(src, "warn") then
        if player ~= "OFFLINE" then
            AdminPanel.OnlineWarnPlayer(src, player, reason)
        else
            if citizenid ~= nil then
                local result = MySQL.query.await("SELECT * FROM `" .. Config.DB.CharactersTable .. "` WHERE `citizenid` = ?", {citizenid})
                if result[1] then
                    local online = false
                    for k, v in pairs(QBCore.Functions.GetPlayers()) do
                        if QBCore.Functions.GetIdentifier(v, "license") == result[1].license then --Player is online but not on this character. so we'll ban them online
                            AdminPanel.OnlineWarnPlayer(src, v, reason)
                            online = true
                            break
                        end
                    end
                    if not online then
                        MySQL.insert("INSERT INTO warns (name, license, reason, warnedby) VALUES (?, ?, ?, ?)", {
                            result[1].name,
                            result[1].license,
                            reason,
                            GetPlayerName(src)
                        })
                        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Warned " .. result[1].name .. " (OFFLINE).")
                        TriggerEvent("qb-log:server:CreateLog", "warns", "Player Warned", "red", string.format("%s was warned by %s for %s", result[1].name, GetPlayerName(src), reason), false)
                    end
                else
                    DebugTrace("Offline warning citizenid had no results. CitizenID: " .. citizenid)
                end
            else
                DebugTrace("Tried to warn offline but citizenid was invalid. Scripting error.")
            end
        end
    end
end)

AdminPanel.OnlineWarnPlayer = function(source, player, reason)
    local src = source
    MySQL.insert("INSERT INTO warns (name, license, reason, warnedby) VALUES (?, ?, ?, ?)", {
        GetPlayerName(player),
        QBCore.Functions.GetIdentifier(player, "license"),
        reason,
        GetPlayerName(src)
    })
    TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Warned " .. GetPlayerName(player) .. ".")
    TriggerEvent("qb-log:server:CreateLog", "warns", "Player Warned", "red", string.format("%s was warned by %s for %s", GetPlayerName(player), GetPlayerName(src), reason), false)
    TriggerClientEvent("919-admin:client:WarnPlayer", player, GetPlayerName(src), reason)
end

RegisterNetEvent("919-admin:server:ViewWarnings", function(player, citizenid)
    local src = source
    local license = nil
    if AdminPanel.HasPermission(src, "checkwarns") then
        if player ~= "OFFLINE" then
            license = QBCore.Functions.GetIdentifier(player, "license")
            DebugTrace("[919-admin:server:ViewWarnings] Got license (online): " .. license)
        else
            if citizenid ~= nil then
                local result = MySQL.query.await("SELECT * FROM `" .. Config.DB.CharactersTable .. "` WHERE `citizenid` = ?", {citizenid})
                if result[1] then
                    license = result[1].license
                    DebugTrace("[919-admin:server:ViewWarnings] Got license (offline): " .. license)
                else
                    DebugTrace("Offline view warnings citizenid had no results. CitizenID: " .. citizenid)
                end
            else
                DebugTrace("Citizenid nil")
            end
        end
        if license ~= nil then
            local result = MySQL.query.await("SELECT * FROM `warns` WHERE `license` = ?", {license})
            if #result > 0 then
                TriggerClientEvent("919-admin:client:ViewWarnings", src, result)
                DebugTrace("[919-admin:server:ViewWarnings] Sending warnings")
            else
                if player ~= "OFFLINE" then
                    TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>NO WARNINGS:</strong> " .. GetPlayerName(player) .. " has no warnings.")
                else
                    TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>NO WARNINGS:</strong> Player (offline) has no warnings.")
                end
            end
        else
            DebugTrace("Citizenid nil")
        end
    end
end)

RegisterServerEvent("919-admin:server:RevivePlayer", function(target)
    local src = source
    if AdminPanel.HasPermission(src, "revive") then
        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Revived " .. GetPlayerName(target) .. ".")
        TriggerEvent("qb-log:server:CreateLog", "adminactions", "Revive", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** revived **" .. GetPlayerName(target) .. "** [" .. target .. "]", false)
        TriggerClientEvent("hospital:client:Revive", target)
    end
end)

RegisterServerEvent("919-admin:server:ReviveAll", function()
    local src = source
    if AdminPanel.HasPermission(src, "reviveall") then
        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Revived all players.")
        TriggerEvent("qb-log:server:CreateLog", "adminactions", "Revive", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** revived all players.", false)
        TriggerClientEvent("hospital:client:Revive", -1)
    end
end)

RegisterServerEvent("919-admin:server:MessageAll", function(message)
    local src = source
    if AdminPanel.HasPermission(src, "messageall") then
        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Sent message to all players.")
        TriggerClientEvent('chat:addMessage', -1, {
            color = {255, 50, 50},
            multiline = true,
            args = {'SYSTEM', message}
        })
    end
end)

RegisterServerEvent("919-admin:server:DeleteAllEntities", function(entityType)
    local src = source
    local entityTypeString = "VEHICLES"
    if AdminPanel.HasPermission(src, "massdeleteentities") then
        if entityType == 2 then entityTypeString = "PEDS" elseif entityType == 3 then entityTypeString = "OBJECTS" end
        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Deleted all entities of type "..entityTypeString..".")
        TriggerClientEvent('919-admin:client:DeleteAllEntities', -1, entityType)
    end
end)

RegisterServerEvent("919-admin:server:SetWeather", function(weatherType)
    local src = source
    if AdminPanel.HasPermission(src, "weather") then
        exports['qb-weathersync']:setWeather(weatherType)
        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Set weather to "..weatherType..".")
    end
end)

RegisterServerEvent("919-admin:server:SetTime", function(hour, minute)
    local src = source
    if AdminPanel.HasPermission(src, "time") then
        exports['qb-weathersync']:setTime(hour, 0)
        TriggerClientEvent('919-admin:client:ShowPanelAlert', 'success', "<strong>SUCCESS:</strong> Set time to "..hour..":00.")
    end
end)

RegisterServerEvent("919-admin:server:FeedPlayer", function(target)
    local src = source
    if AdminPanel.HasPermission(src, "foodandwater") then
        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Set " .. GetPlayerName(target) .. "'s food and water to max.")
        TriggerEvent("919-admin:server:SetMetaDataForPlayer", target, "thirst", 100)
        TriggerEvent("919-admin:server:SetMetaDataForPlayer", target, "hunger", 100)
        TriggerClientEvent('hud:client:UpdateNeeds', target, 100, 100)
        TriggerEvent("qb-log:server:CreateLog", "adminactions", "Food & Water Max", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** fed and watered **" .. GetPlayerName(target) .. "** [" .. target .. "]", false)
    end
end)

RegisterServerEvent("919-admin:server:RelieveStress", function(target)
    local src = source
    if AdminPanel.HasPermission(src, "relievestress") then
        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Relieved stress of " .. GetPlayerName(target) .. ".")
        TriggerEvent("919-admin:server:SetMetaDataForPlayer", target, "stress", 0)
        TriggerClientEvent('hud:client:UpdateStress', target, 0)
        TriggerEvent("qb-log:server:CreateLog", "adminactions", "Relieve Stress", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** relieved stress of **" .. GetPlayerName(target) .. "** [" .. target .. "]", false)
    end
end)

RegisterServerEvent("919-admin:server:SetMetaDataForPlayer", function(PlayerId, Meta, Data)
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if Meta == "hunger" or Meta == "thirst" then
        if Data >= 100 then
            Data = 100
        end
    end
    if Player ~= nil then
        Player.Functions.SetMetaData(Meta, Data)
    end
    TriggerClientEvent("qb-hud:client:update:needs", PlayerId, Player.PlayerData.metadata["hunger"], Player.PlayerData.metadata["thirst"])
end)

RegisterNetEvent('919-admin:server:SetPedModel', function(player, model)
    local src = source
    if AdminPanel.HasPermission(src, "setpedmodel") then
        local Player = QBCore.Functions.GetPlayer(player)
        if Player ~= nil then
            TriggerClientEvent("919-admin:client:SetPedModel", player, model)
        end
    end
end)

RegisterNetEvent("919-admin:server:RequestSpectate", function(player)
    local src = source
    if AdminPanel.HasPermission(src, "spectate") then
        local Player = QBCore.Functions.GetPlayer(player)
        if Player ~= nil then
            local coords = GetEntityCoords(GetPlayerPed(player))
            SpectatingPlayer[src] = player
            TriggerClientEvent("919-admin:client:RequestSpectate", src, player, coords, GetPlayerName(player))
            TriggerEvent("qb-log:server:CreateLog", "adminactions", "Spectate", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** started spectating **" .. GetPlayerName(player) .. "** [" .. player .. "]", false)
        end
    end
end)
local restarted = false
RegisterNetEvent("919-admin:server:requestNextSpectate", function()
    local src = source
    if AdminPanel.HasPermission(src, "spectate") and SpectatingPlayer[src] then
        local foundPlayer = false
        local i = SpectatingPlayer[src] + 1
        local crashCounter = 0
        repeat
            if QBCore.Functions.GetPlayer(i) ~= nil then
                if i == src then
                else
                    local coords = GetEntityCoords(GetPlayerPed(i))
                    TriggerClientEvent("919-admin:client:RequestSpectate", src, i, coords, GetPlayerName(i))
                    TriggerEvent("qb-log:server:CreateLog", "adminactions", "Spectate", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** started spectating **" .. GetPlayerName(i) .. "** [" .. i .. "]", false)
                    SpectatingPlayer[src] = i
                    foundPlayer = true
                    crashCounter = 0
                    break
                end
            end
            i = i + 1
            if i == 200 then
                i = 1
                local crashCounter = crashCounter + 1
                if crashCounter == 3 then
                    break
                end
            end
        until i == 200
        if not foundPlayer then
            TriggerClientEvent("QBCore:Notify", src, "No players found!", "error")
        end
    end
end)

RegisterNetEvent("919-admin:server:requestPrevSpectate", function()
    local src = source
    if AdminPanel.HasPermission(src, "spectate") and SpectatingPlayer[src] then
        local foundPlayer = false
        local i = SpectatingPlayer[src] - 1
        local crashCounter = 0
        repeat
            if QBCore.Functions.GetPlayer(i) ~= nil and i ~= src then
                local coords = GetEntityCoords(GetPlayerPed(i))
                TriggerClientEvent("919-admin:client:RequestSpectate", src, i, coords, GetPlayerName(i))
                TriggerEvent("qb-log:server:CreateLog", "adminactions", "Spectate", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** started spectating **" .. GetPlayerName(i) .. "** [" .. i .. "]", false)
                SpectatingPlayer[src] = i
                foundPlayer = true
                crashCounter = 0
                break
            end
            i = i - 1
            if i == 0 then
                i = 200
                local crashCounter = crashCounter + 1
                if crashCounter == 3 then
                    break
                end
            end
        until i == 0
        if not foundPlayer then
            TriggerClientEvent("QBCore:Notify", src, "No players found!", "error")
        end
    end
end)

RegisterNetEvent("919-admin:server:ScreenshotSubmit", function(playerId)
    local src = source
    if AdminPanel.HasPermission(src, "screenshot") then
        local targetPlayer = QBCore.Functions.GetPlayer(playerId)
        if targetPlayer ~= nil then
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Screenshotting " .. AdminPanel.CharacterName(targetPlayer) .. " (" .. GetPlayerName(playerId) .. ")")
            local screenshotOptions = {
                encoding = "png",
                quality = 1
            }
            local ids = ExtractIdentifiers(playerId);
            local playerIP = ids.ip;
            local playerSteam = ids.steam;
            local playerLicense = ids.license;
            local playerXbl = ids.xbl;
            local playerLive = ids.live;
            local playerDisc = ids.discord;
            exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(playerId, Config.ScreenshotWebhook, screenshotOptions, {
                username = Config.ServerName .. " SS Bot", avatar_url = "", content = "",
                embeds = {
                    {
                        color = 16711680,
                        author = {
                            name = "[" .. Config.ServerName .. " SS Bot]",
                            icon_url = ""
                        },
                        title = "Requested Screenshot",
                        description = "**__Player Identifiers:__** \n\n"
                        .. "**Server ID:** `" .. playerId .. "`\n\n"
                        .. "**Username:** `" .. GetPlayerName(playerId) .. "`\n\n"
                        .. "**IP:** `" .. playerIP .. "`\n\n"
                        .. "**Steam:** `" .. playerSteam .. "`\n\n"
                        .. "**License:** `" .. playerLicense .. "`\n\n"
                        .. "**Xbl:** `" .. playerXbl .. "`\n\n"
                        .. "**Live:** `" .. playerLive .. "`\n\n"
                        .. "**Discord:** `" .. playerDisc .. "`\n\n",
                        footer = {
                            text = "[" .. playerId .. "]" .. GetPlayerName(playerId),
                        }
                    }
                }
            });
        end
    end
end)

RegisterNetEvent("919-admin:server:SaveCar", function(mods, vehicle, hash, plate, senderId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src, "savecar")
    local result = MySQL.query.await("SELECT plate FROM `"..Config.DB.VehiclesTable.."` WHERE plate = ?", {plate})
    if result[1] == nil then
        MySQL.insert("INSERT INTO `"..Config.DB.VehiclesTable.."` (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)", {
            Player.PlayerData.license,
            Player.PlayerData.citizenid,
            vehicle.model,
            vehicle.hash,
            json.encode(mods),
            plate,
            0
        })
        TriggerClientEvent("QBCore:Notify", src, "The vehicle is now yours!", "success", 5000)
        if senderId then
            TriggerEvent("qb-log:server:CreateLog", "adminactions", "Admin Car", "red", "**STAFF MEMBER " .. GetPlayerName(senderId) .. "** has added a " .. vehicle.model .. " (" .. plate .. ") to the garage of " .. GetPlayerName(src), false)
            TriggerClientEvent("919-admin:client:ShowPanelAlert", senderId, "success", "<strong>SUCCESS:</strong> Added a " .. vehicle.model .. " (" .. plate .. ") to the garage of " .. GetPlayerName(src) .. ".")
        end
    else
        if senderId then
            TriggerClientEvent("919-admin:client:ShowPanelAlert", senderId, "danger", "<strong>ERROR:</strong> " .. GetPlayerName(src) .. " already owns this " .. vehicle.model .. " (" .. plate .. ")")
        end
        TriggerClientEvent("QBCore:Notify", src, "This vehicle is already yours.", "error", 3000)
    end
end)

RegisterServerEvent('919-admin:server:RequestVehicleSpawn', function(modelName)
    local src = source
    if AdminPanel.HasPermission(src, "spawncar") then
        TriggerClientEvent('QBCore:Command:SpawnVehicle', src, modelName)
    end
end)

RegisterServerEvent("919-admin:server:DeleteCharacter", function(citizenId)
    local src = source
    if AdminPanel.HasPermission(src, "deletecharacter") then
        MySQL.query('SELECT * FROM  `' .. Config.DB.CharactersTable .. '` WHERE citizenid = ? LIMIT 1', {citizenId}, function(result)
            if result[1] then
                MySQL.query('DELETE FROM `' .. Config.DB.CharactersTable .. '` WHERE citizenid = ? LIMIT 1', {citizenId}, function(rowsAffected)
                    if rowsAffected then
                        local charInfo = json.decode(result[1].charinfo)
                        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> ".. result[1].name.."'s character " .. charInfo.firstname .. " " .. charInfo.lastname .." was deleted successfully.")
                        TriggerEvent("qb-log:server:CreateLog", "bans", "Player Unbanned", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** deleted " .. result[1].name .."'s character ".. charInfo.firstname .. " " .. charInfo.lastname, false)
                    else
                        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> No rows deleted.")
                    end
                    local results = MySQL.query.await("SELECT * FROM `"..Config.DB.CharactersTable.."`")
                    TriggerClientEvent("919-admin:client:ReceiveCharacters", src, results)
                end)
            else
                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Couldn't find ban record with license.")
            end
        end)
    end
end)


RegisterServerEvent("919-admin:server:UnbanPlayer", function(license)
    local src = source
    if AdminPanel.HasPermission(src, "unban") then
        MySQL.query('SELECT * FROM `'..Config.DB.BansTable..'` WHERE license = ? LIMIT 1', {license}, function(result)
            if result[1] then
                MySQL.query('DELETE FROM `'..Config.DB.BansTable..'` WHERE license = ? LIMIT 1', {license}, function(rowsAffected)
                    if rowsAffected then
                        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> " .. result[1].name .. " was unbanned successfully.")
                        TriggerEvent("qb-log:server:CreateLog", "bans", "Player Unbanned", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** unbanned " .. result[1].name, false)
                    else
                        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> No rows deleted.")
                    end
                    local results = MySQL.query.await("SELECT * FROM `"..Config.DB.BansTable.."`")
                    local BansInfo = {}
                    for k1, v1 in ipairs(results) do
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
                end)
            else
                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Couldn't find ban record with license.")
            end
        end)
    end
end)


RegisterServerEvent("919-admin:server:ClearInventory", function(targetId)
    local src = source
    if AdminPanel.HasPermission(src, "clearinventory") then
        local targetPlayer = QBCore.Functions.GetPlayer(targetId)
        if targetPlayer then
            targetPlayer.Functions.ClearInventory()
            TriggerEvent("qb-log:server:CreateLog", "adminactions", "Inventory Cleared", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** has cleared the inventory of " .. GetPlayerName(targetId), false)
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Cleared " .. AdminPanel.CharacterName(targetPlayer) .. "'s (" .. GetPlayerName(targetId) .. ") inventory.")
        end
    end
end)

RegisterServerEvent("919-admin:server:SetJob", function(targetId, job, grade)
    local src = source
    if AdminPanel.HasPermission(src, "setjob") then
        if QBCore.Shared.Jobs[job] ~= nil then
            if QBCore.Shared.Jobs[job].grades[tostring(grade)] ~= nil then
                local targetPlayer = QBCore.Functions.GetPlayer(targetId)
                if targetPlayer then
                    targetPlayer.Functions.SetJob(job, grade)
                    targetPlayer.Functions.Save()
                    TriggerEvent("qb-log:server:CreateLog", "adminactions", "Set Job", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** set the job of " .. GetPlayerName(targetId) .. " to " .. job .. " (" .. grade .. ")", false)
                    TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Set " .. AdminPanel.CharacterName(targetPlayer) .. "'s (" .. GetPlayerName(targetId) .. ") job to " .. job .. " (" .. grade .. ")")
                end
            else
                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Invalid job grade.")
            end
        else
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Invalid job.")
        end
    end
end)

RegisterServerEvent("919-admin:server:SetGang", function(targetId, gang, grade)
    local src = source
    if AdminPanel.HasPermission(src, "setgang") then
        if QBCore.Shared.Gangs[gang] ~= nil then
            if QBCore.Shared.Gangs[gang].grades[tostring(grade)] ~= nil then
                local targetPlayer = QBCore.Functions.GetPlayer(targetId)
                if targetPlayer then
                    targetPlayer.Functions.SetGang(gang, grade)
                    targetPlayer.Functions.Save()
                    TriggerEvent("qb-log:server:CreateLog", "adminactions", "Set Gang", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** set the gang of " .. GetPlayerName(targetId) .. " to " .. gang .. " (" .. grade .. ")", false)
                    TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Set " .. AdminPanel.CharacterName(targetPlayer) .. "'s (" .. GetPlayerName(targetId) .. ") gang to " .. gang .. " (" .. grade .. ")")
                end
            else
                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Invalid gang grade.")
            end
        else
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Invalid gang.")
        end
    end
end)

RegisterServerEvent("919-admin:server:GiveItem", function(targetId, item, amount)
    local src = source
    if AdminPanel.HasPermission(src, "giveitem") then
        if QBCore.Shared.Items[item] ~= nil then
            local targetPlayer = QBCore.Functions.GetPlayer(targetId)
            if targetPlayer then
                targetPlayer.Functions.AddItem(item, amount)
                TriggerEvent("qb-log:server:CreateLog", "adminactions", "Set Gang", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** gave " .. item .. " (x" .. amount .. ") to " .. GetPlayerName(targetId), false)
                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Gave " .. item .. " (x" .. amount .. ") to " .. AdminPanel.CharacterName(targetPlayer) .. " (" .. GetPlayerName(targetId) .. ")")
                TriggerClientEvent("QBCore:Notify", targetId, "You were given " .. item .. " (x" .. amount .. ") by staff.", "success")
            end
        else
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Invalid item.")
        end
    end
end)

RegisterServerEvent("919-admin:server:FireJob", function(targetId)
    local src = source
    if AdminPanel.HasPermission(src, "firejob") then
        local targetPlayer = QBCore.Functions.GetPlayer(targetId)
        if targetPlayer then
            targetPlayer.Functions.SetJob("unemployed", 0)
            targetPlayer.Functions.Save()
            TriggerEvent("qb-log:server:CreateLog", "adminactions", "Set Job", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** fired " .. GetPlayerName(targetId) .. " from their job.", false)
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Fired " .. AdminPanel.CharacterName(targetPlayer) .. " (" .. GetPlayerName(targetId) .. ") from their job")
        end
    end
end)

RegisterServerEvent("919-admin:server:FireGang", function(targetId)
    local src = source
    if AdminPanel.HasPermission(src, "firegang") then
        local targetPlayer = QBCore.Functions.GetPlayer(targetId)
        if targetPlayer then
            targetPlayer.Functions.SetGang("none", 0)
            targetPlayer.Functions.Save()
            TriggerEvent("qb-log:server:CreateLog", "adminactions", "Set Gang", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** removed " .. GetPlayerName(targetId) .. " from their gang.", false)
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Removed " .. AdminPanel.CharacterName(targetPlayer) .. " (" .. GetPlayerName(targetId) .. ") from their gang")
        end
    end
end)

RegisterServerEvent("919-admin:server:FireJobByCitizenId", function(citizenId)
    local src = source
    if AdminPanel.HasPermission(src, "firejob") then
        local targetPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenId)
        if targetPlayer then
            targetPlayer.Functions.SetJob("unemployed", 0)
            targetPlayer.Functions.Save()
            TriggerEvent("qb-log:server:CreateLog", "adminactions", "Set Job", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** removed " .. GetPlayerName(targetPlayer.PlayerData.source) .. " from their job.", false)
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Removed " .. AdminPanel.CharacterName(targetPlayer) .. " (" .. GetPlayerName(targetId) .. ") from their job")
        else -- Player is offline, so we"re going to formulate the default JSON for unemployed and set it to the offline character
            PlayerData = {}
            PlayerData.job = {}
            PlayerData.job.name = "unemployed"
            PlayerData.job.label = "Civilian"
            PlayerData.job.payment = 10
            if QBCore.Shared.ForceJobDefaultDutyAtLogin or PlayerData.job.onduty == nil then
                PlayerData.job.onduty = QBCore.Shared.Jobs[PlayerData.job.name].defaultDuty
            end
            PlayerData.job.isboss = false
            PlayerData.job.grade = {}
            PlayerData.job.grade.name = "Freelancer"
            PlayerData.job.grade.level = 0
            MySQL.update("UPDATE `" .. Config.DB.CharactersTable .. "` SET `job` = ? WHERE `citizenid` = ?", {json.encode(PlayerData.job), citizenId}, function(rowsAffected)
                if rowsAffected ~= 0 and rowsAffected ~= nil then
                    TriggerEvent("qb-log:server:CreateLog", "adminactions", "Set Job", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** removed (OFFLINE) Citizen ID " .. citizenId .. " from their job.", false)
                    TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Removed Citizen ID " .. citizenId .. " (OFFLINE) from their job")
                end
            end)
        end
    end
end)

RegisterServerEvent("919-admin:server:FireGangByCitizenId", function(citizenId)
    local src = source
    if AdminPanel.HasPermission(src, "firegang") then
        local targetPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenId)
        if targetPlayer then
            targetPlayer.Functions.SetGang("none", 0)
            targetPlayer.Functions.Save()
            TriggerEvent("qb-log:server:CreateLog", "adminactions", "Set Job Grade", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** removed " .. GetPlayerName(targetPlayer.PlayerData.source) .. " from their gang.", false)
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Removed " .. AdminPanel.CharacterName(targetPlayer) .. " (" .. GetPlayerName(targetId) .. ") from their gang")
        else -- Player is offline, so we"re going to formulate the default JSON for unemployed and set it to the offline character
            PlayerData = {}
            PlayerData.gang = {}
            PlayerData.gang.name = 'none'
            PlayerData.gang.label = 'No Gang Affiliaton'
            PlayerData.gang.isboss = false
            PlayerData.gang.grade = {}
            PlayerData.gang.grade.name = 'none'
            PlayerData.gang.grade.level = 0
            MySQL.update("UPDATE `" .. Config.DB.CharactersTable .. "` SET `gang` = ? WHERE `citizenid` = ?", {json.encode(PlayerData.gang), citizenId}, function(rowsAffected)
                if rowsAffected ~= 0 and rowsAffected ~= nil then
                    TriggerEvent("qb-log:server:CreateLog", "adminactions", "Set Gang", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** removed (OFFLINE) Citizen ID " .. citizenId .. " from their gang.", false)
                    TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Removed Citizen ID " .. citizenId .. " (OFFLINE) from their gang")
                end
            end)
        end
    end
end)

RegisterServerEvent("919-admin:server:SetGangGradeByCitizenId", function(citizenId, grade)
    local src = source
    if AdminPanel.HasPermission(src, "setgang") then
        local targetPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenId)
        if targetPlayer then
            if QBCore.Shared.Gangs[targetPlayer.PlayerData.gang.name].grades[grade] ~= nil then
                targetPlayer.Functions.SetGang(targetPlayer.PlayerData.gang.name, grade)
                targetPlayer.Functions.Save()
                TriggerEvent("qb-log:server:CreateLog", "adminactions", "Set Gang Grade", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** set gang grade of " .. GetPlayerName(targetPlayer.PlayerData.source) .. " to " .. grade .. ".", false)
                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Set gang grade of " .. AdminPanel.CharacterName(targetPlayer) .. " (" .. GetPlayerName(targetId) .. ") to " .. grade)
            else
                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Invalid gang grade.")
            end
        else
            local result = MySQL.query.await('SELECT `gang` FROM '..Config.DB.CharactersTable..' WHERE citizenid = ?', {citizenId})
            if result ~= nil then
                local gangInfo = json.decode(result[1].gang)
                if gangInfo.grade ~= nil then
                    if QBCore.Shared.Gangs[gangInfo.name].grades[grade] ~= nil then
                        gangInfo.isboss = (QBCore.Shared.Gangs[gangInfo.name].grades[grade].isboss and true or false)-- We dont need a 'payment' here because gangs dont have a salary.
                        gangInfo.grade.name = QBCore.Shared.Gangs[gangInfo.name].grades[grade].name -- We only need isboss, grade.name information from framework
                        gangInfo.grade.level = tonumber(grade)
                        MySQL.update("UPDATE `" .. Config.DB.CharactersTable .. "` SET `gang` = ? WHERE `citizenid` = ?", {json.encode(gangInfo), citizenId}, function(rowsAffected)
                            if rowsAffected ~= 0 and rowsAffected ~= nil then
                                TriggerEvent("qb-log:server:CreateLog", "adminactions", "Set Gang", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** set citizen id " .. citizenId .. " to gang grade " .. grade .. " (OFFLINE)", false)
                                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Set Citizen ID " .. citizenId .. " to gang grade " .. grade)
                            else
                                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Database error: 0 rows affected.")
                            end
                        end)
                    else
                        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Invalid gang grade.")
                    end
                else
                    TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Database error: couldn't decode database gang JSON.")
                end
            else
                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Database error: couldn't get offline player's gang info.")
            end
        end
    end
end)

RegisterServerEvent("919-admin:server:SetJobGradeByCitizenId", function(citizenId, grade)
    local src = source
    if AdminPanel.HasPermission(src, "setjob") then
        local targetPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenId)
        if targetPlayer then
            if QBCore.Shared.Jobs[targetPlayer.PlayerData.job.name].grades[grade] ~= nil then
                targetPlayer.Functions.SetJob(targetPlayer.PlayerData.job.name, grade)
                targetPlayer.Functions.Save()
                TriggerEvent("qb-log:server:CreateLog", "adminactions", "Set Job", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** set job grade of " .. GetPlayerName(targetPlayer.PlayerData.source) .. " to " .. grade .. ".", false)
                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Set job grade of " .. AdminPanel.CharacterName(targetPlayer) .. " (" .. GetPlayerName(targetId) .. ") to " .. grade)
            else
                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Invalid job grade.")
            end
        else
            local result = MySQL.query.await('SELECT `job` FROM `'..Config.DB.CharactersTable..'` WHERE citizenid = ?', {citizenId})
            if result ~= nil then
                local jobInfo = json.decode(result[1].job)
                if jobInfo.grade ~= nil then
                    if QBCore.Shared.Jobs[jobInfo.name].grades[grade] ~= nil then
                        jobInfo.payment = QBCore.Shared.Jobs[jobInfo.name].grades[grade].payment -- ;))) I actually thought of this before I had to test it. Gotta give me cred for that
                        jobInfo.isboss = (QBCore.Shared.Jobs[jobInfo.name].grades[grade].isboss and true or false)-- This is because QBCore only sets isboss if grade is boss.
                        jobInfo.grade.name = QBCore.Shared.Jobs[jobInfo.name].grades[grade].name
                        jobInfo.grade.level = tonumber(grade)
                        MySQL.update("UPDATE `" .. Config.DB.CharactersTable .. "` SET `job` = ? WHERE `citizenid` = ?", {json.encode(jobInfo), citizenId}, function(rowsAffected)
                            if rowsAffected ~= 0 and rowsAffected ~= nil then
                                TriggerEvent("qb-log:server:CreateLog", "adminactions", "Set Gang", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** set citizen id " .. citizenId .. " to job grade " .. grade .. " (OFFLINE)", false)
                                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> Set Citizen ID " .. citizenId .. " to job grade " .. grade)
                            else
                                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Database error: 0 rows affected.")
                            end
                        end)
                    else
                        TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Invalid job grade.")
                    end
                else
                    TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Database error: couldn't decode database job JSON.")
                end
            else
                TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> Database error: couldn't get offline player's job info.")
            end
        end
    end
end)

RegisterServerEvent("919-admin:server:SaveAdminMenuSetting", function(setting, value)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    value = tonumber(value)
    if Player then
        print('Found ya')
        if AdminPanel.HasPermission(src, "adminmenu") then
            print('u have perms')
            if setting == "darkmode" then
                if value == 1 or value == 0 then
                    print('Its value')
                    Player.Functions.SetMetaData("adminpanel_darkmode", value)
                    DebugTrace("[919-admin:server:SaveAdminMenuSetting] Set metadata adminpanel_darkmode to " .. value)
                    DarkMode[src] = value
                    print(value)
                else
                    DebugTrace("[919-admin:server:SaveAdminMenuSetting] Invalid setting value")
                end
            elseif setting == "seethrough" then
                if value == 1 or value == 0 then
                    Player.Functions.SetMetaData("adminpanel_seethrough", value)
                    DebugTrace("[919-admin:server:SaveAdminMenuSetting] Set metadata adminpanel_seethrough to " .. value)
                    SeeThrough[src] = value
                else
                    DebugTrace("[919-admin:server:SaveAdminMenuSetting] Invalid setting value")
                end
            else
                DebugTrace("[919-admin:server:SaveAdminMenuSetting] Invalid setting name")
            end
        else
            DebugTrace("[919-admin:server:SaveAdminMenuSetting] Invalid permissions??")
        end
    end
end)

RegisterServerEvent("919-admin:server:AddVehicleToGarage", function(targetId)
    local src = source
    if AdminPanel.HasPermission(src, "savecar") then
        TriggerClientEvent('919-admin:client:SaveCar', targetId, src)
    end
end)

RegisterServerEvent("919-admin:server:BringPlayer", function(targetId)
    local src = source
    if AdminPanel.HasPermission(src, "teleport") then
        local targetPlayer = QBCore.Functions.GetPlayer(targetId)
        if targetPlayer then
            SendPlayerBack[targetId] = GetEntityCoords(GetPlayerPed(targetId))
            local coords = GetEntityCoords(GetPlayerPed(src))
            SetEntityCoords(GetPlayerPed(targetId), coords)
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> You teleported " .. AdminPanel.CharacterName(targetPlayer) .. " (" .. GetPlayerName(targetId) .. ") to you. You can send them back with SEND BACK.")
            TriggerEvent("qb-log:server:CreateLog", "adminactions", "Teleport", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** brought **" .. GetPlayerName(targetId) .. "** [" .. targetId .. "] to them", false)
        end
    end
end)

RegisterServerEvent("919-admin:server:SendPlayerBack", function(targetId)
    local src = source
    if AdminPanel.HasPermission(src, "teleport") then
        local targetPlayer = QBCore.Functions.GetPlayer(targetId)
        if SendPlayerBack[targetId] and targetPlayer then
            SetEntityCoords(GetPlayerPed(targetId), SendPlayerBack[targetId])
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> You teleported " .. AdminPanel.CharacterName(targetPlayer) .. " (" .. GetPlayerName(targetId) .. ") to their original location.")
            SendPlayerBack[targetId] = nil
        else
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> That player doesn't have any position to send them back to.")
        end
    end
end)

RegisterServerEvent("919-admin:server:SendBackSelf", function()
    local src = source
    if AdminPanel.HasPermission(src, "teleport") then
        if SendBack[src] then
            SetEntityCoords(GetPlayerPed(src), SendBack[src])
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> You sent yourself back.")
            SendBack[src] = nil
        else
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "danger", "<strong>ERROR:</strong> You don't have any position to send yourself back to.")
        end
    end
end)


RegisterServerEvent("919-admin:server:GotoPlayer", function(targetId)
    local Player = QBCore.Functions.GetPlayer(targetId)
    local src = source
    if AdminPanel.HasPermission(src, "teleport") then
        local targetPlayer = QBCore.Functions.GetPlayer(targetId)
        if Player ~= nil and targetPlayer ~= nil then
            SendBack[src] = GetEntityCoords(GetPlayerPed(src))
            local coords = GetEntityCoords(GetPlayerPed(targetId))
            TriggerClientEvent("QBCore:Command:TeleportToCoords", src, coords.x, coords.y, coords.z)
            TriggerClientEvent("919-admin:client:ShowPanelAlert", src, "success", "<strong>SUCCESS:</strong> You teleported to " .. AdminPanel.CharacterName(targetPlayer) .. " (" .. GetPlayerName(targetId) .. ")")
            TriggerEvent("qb-log:server:CreateLog", "adminactions", "Teleport", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** teleported to **" .. GetPlayerName(targetId) .. "** [" .. targetId .. "]", false)
        end
    end
end)

QBCore.Functions.CreateCallback("919-admin:server:HasPermissions", function(source, cb, group)
    local src = source
    local retval = false
    
    if QBCore.Functions.HasPermission(src, group) then
        retval = true
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback("919-admin:server:GetPlayerPositions", function(source, cb)
    local PlayerPositions = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player then
            table.insert(PlayerPositions, {pos = GetEntityCoords(GetPlayerPed(Player.PlayerData.source)), name = GetPlayerName(Player.PlayerData.source), id = Player.PlayerData.source})
        --print("{ pos = "..GetEntityCoords(GetPlayerPed(Player.PlayerData.source))..", name = "..GetPlayerName(Player.PlayerData.source)..", id = "..Player.PlayerData.source.." }")
        end
    end
    cb(PlayerPositions)
end)

RegisterServerEvent("919-admin:server:SetPermissions", function(targetId, group)
    QBCore.Functions.AddPermission(targetId, group.rank)
    TriggerClientEvent("QBCore:Notify", targetId, "Your permission levels have been set to " .. group.label)
end)

RegisterServerEvent("919-admin:server:OpenSkinMenu", function(targetId)
    local src = source
    local targetPlayer = QBCore.Functions.GetPlayer(targetId)
    if AdminPanel.HasPermission(src, "skinmenu") and targetPlayer then
        TriggerClientEvent("919-admin:client:ShowPanelAlert", source, "success", "<strong>SUCCESS:</strong> You opened skin menu for " .. AdminPanel.CharacterName(targetPlayer) .. " (" .. GetPlayerName(targetId) .. ")")
        
        TriggerClientEvent("qb-clothing:client:openMenu", targetId)
        TriggerEvent("qb-log:server:CreateLog", "adminactions", "Skin Menu", "red", "**STAFF MEMBER " .. GetPlayerName(src) .. "** opened skin menu for " .. GetPlayerName(targetId), false)
    end
end)
