function ExtractIdentifiers(src)
    
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

local logs = "https://discord.com/api/webhooks/909276763497046048/ETv0SP7YQzYGl-SYbGcu_YbkWwsW1Jzrt7-ULC9rEX1TLtNFXZlFoyIqE7hrVCskZwjO"

local kick_msg = "Nice try, wont be happening here"
local discord_msg = '`Server Player Tried Opening Dev Tools and got kicked`\n`NUI Blocker`'
local color_msg = 16767235

function sendToDiscord (_source)
    
    local src = _source

    local name = GetPlayerName(src)

    local steamid  = "Unidentified"
    local license  = "Unidentified"
    local discord  = "Unidentified"
    local ip       = "Unidentified"
    local fivem    = "Unidentified"
    
    for k,v in pairs(GetPlayerIdentifiers(src))do            
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
            fivem = v
        end
    end

    TriggerEvent('qb-log:server:CreateLog', 'nuiblock', 'NUI Devtools Blocked', 'red', "Player: **"..GetPlayerName(src).."** (**"..src.."**)".."**\nSteam: **"..steamid.."**".."\nFiveM: **"..fivem.."**\nLicense: **"..license.."**\nDiscord: **"..discord.."**\nIP: **||"..ip.."||")
end


RegisterServerEvent(GetCurrentResourceName())
AddEventHandler(GetCurrentResourceName(), function()
    local _source = source
    local identifier = ExtractIdentifiers(_source)
    local identifierDb
    if extendedVersionV1Final then
        identifierDb = identifier.license
    else
        identifierDb = identifier.steam
    end
    if checkmethod == 'steam' then
	if json.encode(allowlist) == "[]" then
	   sendToDiscord (_source)
           DropPlayer(_source, kick_msg)		
	end
	for _, v in pairs(allowlist) do
           if v ~= identifierDb then
	      sendToDiscord (_source)
              DropPlayer(_source, kick_msg)
           end
        end
     elseif checkmethod == 'SQL' then
        MySQL.Async.fetchAll("SELECT group FROM users WHERE identifier = @identifier",{['@identifier'] = identifierDb }, function(results) 
            if results[1].group ~= 'admin' or 'superadmin' then
               sendToDiscord (source, discord_msg, color_msg,identifier)
               DropPlayer(source, kick_msg)
            end
        end)
     end
end)
