local usersRadios = {}

local QBCore = exports['lrp-core']:GetCoreObject()

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

RegisterCommand("mdt", function(source)
    local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
    local rank = xPlayer.PlayerData.job.grade.name
    --print(xPlayer.PlayerData.charinfo.firstname)
    if (xPlayer.PlayerData.job.name == "police" or xPlayer.PlayerData.job.name == "ambulance") and (xPlayer.PlayerData.job.onduty) then
        TriggerClientEvent('np-mdt:open', src, rank, xPlayer.PlayerData.charinfo.lastname, xPlayer.PlayerData.charinfo.firstname)
    end
end)

local CallSigns = {}
function GetCallsign(identifier)
    local Player = QBCore.Functions.GetPlayerByCitizenId(identifier)
    return Player.PlayerData.metadata['callsign']
end

--[[
RegisterServerEvent('np-mdt:setRadio')
AddEventHandler("np-mdt:setRadio", function(radio)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    if not user then
        return
    end
    usersRadios[tonumber(char.id)] = radio
end)]]

RegisterServerEvent('mdtopen:radial')
AddEventHandler("mdtopen:radial", function()
    local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
    local rank = xPlayer.PlayerData.job.grade.name
    --print(xPlayer.PlayerData.charinfo.firstname)
    if (xPlayer.PlayerData.job.name == "police" or xPlayer.PlayerData.job.name == "ambulance") and (xPlayer.PlayerData.job.onduty) then
        TriggerClientEvent('np-mdt:open', src, rank, xPlayer.PlayerData.charinfo.lastname, xPlayer.PlayerData.charinfo.firstname)
    end
end)

RegisterServerEvent('police:setCallSign')
AddEventHandler("police:setCallSign", function(callsign)
      local src = source
      local Player = QBCore.Functions.GetPlayer(src)
      Player.Functions.SetMetaData("callsign", callsign)
end)

RegisterServerEvent("np-mdt:opendashboard")
AddEventHandler("np-mdt:opendashboard", function()
    local src = source
    UpdateWarrants(src)
    Updatebulletin(src)
    UpdateDispatch(src)
    UpdateUnits(src)
    getVehicles(src)
    getProfiles(src)
    UpdateReports(src)
end)

function UpdateWarrants(src)
    local firsttime = true
    local result = MysqlConverter(Config.Mysql,'fetchAll', 'SELECT * FROM ___mdw_incidents', {})
    local warrnts = {}

    for k, v in pairs(result) do
        for k2, v2 in ipairs(json.decode(v.associated)) do
            if v2.warrant == true then
                TriggerClientEvent("np-mdt:dashboardWarrants", src, {
                    firsttime = firsttime,
                    time = v.time,
                    linkedincident = v.id,
                    reporttitle = v.title,
                    name = v2.name,
                    cid = v2.cid
                })
                firsttime = false
            end
        end
    end
end

function UpdateReports(src)
    local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM ____mdw_reports', {})
    TriggerClientEvent("np-mdt:dashboardReports", src, result)
end

function Updatebulletin(src)
    local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM ___mdw_bulletin', {})
    TriggerClientEvent("np-mdt:dashboardbulletin", src, result)
end

function UpdateUnits(src)
    local lspd, bcso, sahp, sasp, doc, sapr, pa, ems = {},{},{},{},{},{},{},{}
    local players = QBCore.Functions.GetQBPlayers()
    for k,v in pairs(players) do
            local userjob = v.PlayerData.job.name
            if userjob == "police" or userjob == "ambulance" then
                local char = v.PlayerData.charinfo
                  local rank = v.PlayerData.job.grade.level or 0
              local name = char.firstname .. " " .. char.lastname
                  local callSign = v.PlayerData.metadata.callsign
            local charid = v.PlayerData.citizenid
                if userjob == "police" then
                    lspds = #lspd + 1
                    lspd[lspds] = {}
                    lspd[lspds].duty = 1
                    lspd[lspds].cid = charid
                    lspd[lspds].radio = usersRadios[charid] or nil
                    lspd[lspds].callsign = callSign
                    lspd[lspds].name = name
                elseif userjob == "ambulance" then
                    emss = #ems + 1
                    ems[emss] = {}
                    ems[emss].duty = 1
                    ems[emss].cid = charid
                    ems[emss].radio = usersRadios[charid] or nil
                    ems[emss].callsign = callSign
                    ems[emss].name = name
                end
            end
    end
    TriggerClientEvent("np-mdt:getActiveUnits", src, lspd, bcso, sahp, sasp, doc, sapr, pa, ems)
end

function getVehicles(src)
    local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM player_vehicles aa LEFT JOIN vehicle_mdt a ON a.license_plate = aa.plate LEFT JOIN ____mdw_bolos at ON at.license_plate = aa.plate ORDER BY time ASC', {})
    for k, v in pairs(result) do
        if v.image and v.image ~= nil and v.image ~= "" then
            result[k].image = v.image
        else
            result[k].image =
                "https://cdn.discordapp.com/attachments/832371566859124821/881624386317201498/Screenshot_1607.png"
        end

        local owner = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT citizenid FROM player_vehicles WHERE plate = @plate', {['@plate'] = v.plate })
        --print(v.citizenid)
        core = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT charinfo FROM players WHERE citizenid = @citizenid', {['@citizenid'] = v.citizenid })
       
        --print("queryData:", dump(core))
        
        metadata = json.decode(core[1].charinfo)

        result[k].owner = metadata.firstname .. ' ' .. metadata.lastname 

        if v.stolen and v.stolen ~= nil then
            result[k].stolen = v.stolen
        else
            result[k].stolen = false
        end

        if v.code and v.code ~= nil then
            result[k].code = v.code
        else
            result[k].code = false
        end

        if v.author and v.author ~= nil and v.title ~= nil then
            result[k].bolo = true
        else
            result[k].bolo = false
        end
    end
    TriggerClientEvent("np-mdt:searchVehicles", src, result, true)
end

RegisterServerEvent("np-mdt:getProfileData")
AddEventHandler("np-mdt:getProfileData", function(identifier)
    local src = source
    local data = getProfile(identifier)
    TriggerClientEvent("np-mdt:getProfileData", src, data, false)
end)

RegisterServerEvent("np-mdt:getVehicleData")
AddEventHandler("np-mdt:getVehicleData", function(plate)
    local src = source
	local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM player_vehicles aa LEFT JOIN vehicle_mdt a ON a.license_plate = aa.plate LEFT JOIN ____mdw_bolos at ON at.license_plate = aa.plate WHERE aa.plate = @plate LIMIT 1', {['@plate'] = plate })
    for k, v in pairs(result) do
        if v.image and v.image ~= nil and v.image ~= "" then
            result[k].image = v.image
        else
            result[k].image =
                "https://cdn.discordapp.com/attachments/832371566859124821/881624386317201498/Screenshot_1607.png"
        end

        local owner = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT citizenid FROM player_vehicles WHERE plate = @plate', {['@plate'] = v.plate })
        core = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT charinfo FROM players WHERE citizenid = @citizenid', {['@citizenid'] = v.citizenid })

        metadata = json.decode(core[1].charinfo)

        result[k].owner = metadata.firstname .. ' ' .. metadata.lastname
        --print(v.stolen)
        result[k].stolen = v.stolen
        result[k].code = v.code5
 
        if v.notes and v.notes ~= nil then
            result[k].information = v.notes
        else
            result[k].information = ""
        end

        if v.author and v.author ~= nil and v.title ~= nil then
            result[k].bolo = true
        else
            result[k].bolo = false
        end
    end
    TriggerClientEvent("np-mdt:updateVehicleDbId", src, result[1].id)
    TriggerClientEvent("np-mdt:getVehicleData", src, result)
end)

RegisterServerEvent("np-mdt:knownInformation")
AddEventHandler("np-mdt:knownInformation", function(dbid, type, status, plate)
  --print(plate)
	local saveData = {type = type, status = status}
  local result = 	MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM `vehicle_mdt` WHERE `license_plate` = @license_plate', {['@license_plate'] = plate})
  if result[1] then
    --print(result)
			if type == "stolen" then
        --print('help')
				MysqlConverter(Config.Mysql, 'execute', 'UPDATE `vehicle_mdt` SET `stolen` = @stolen WHERE `license_plate` = @plate AND `dbid` = @dbid', {
				    ['@stolen'] = status,
					['@dbid'] = dbid,
					['@plate'] = plate,
				})
			elseif type == "code5" then
          --print('me 2')
			    MysqlConverter(Config.Mysql, 'execute', 'UPDATE `vehicle_mdt` SET `code5` = @code WHERE `license_plate` = @plate AND `dbid` = @dbid', {
				    ['@code'] = status,
					['@dbid'] = dbid,
					['@plate'] = plate,
				})
			end
		else
			if type == "stolen" then
        --print('me')
			    MysqlConverter(Config.Mysql, 'execute', 'INSERT INTO `vehicle_mdt` (`license_plate`, `stolen`, `dbid`) VALUES (@plate, @stolen, @dbid)', {
			        ['@dbid'] = dbid,
			    	['@plate'] = plate,
			        ['@stolen'] = status
			    })
			elseif type == "code5" then

			    MysqlConverter(Config.Mysql, 'execute', 'INSERT INTO `vehicle_mdt` (`license_plate`, `code5`, `dbid`) VALUES (@plate, @code, @dbid)', {
			        ['@dbid'] = dbid,
				    ['@plate'] = plate,
			        ['@code'] = status
			    })
			end
		end
end)

RegisterServerEvent("np-mdt:searchVehicles")
AddEventHandler("np-mdt:searchVehicles", function(plate)
    local src = source
    local lowerplate = string.lower('%'..plate..'%')
	local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM player_vehicles aa LEFT JOIN vehicle_mdt a ON a.license_plate = aa.plate LEFT JOIN ____mdw_bolos at ON at.license_plate = aa.plate WHERE LOWER(plate) LIKE @plate ORDER BY plate ASC', { ['@plate'] = lowerplate })
    for k, v in pairs(result) do
        if v.image and v.image ~= nil and v.image ~= "" then
            result[k].image = v.image
        else
            result[k].image = "https://cdn.discordapp.com/attachments/832371566859124821/881624386317201498/Screenshot_1607.png"
        end

        local owner = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM players WHERE citizenid = @citizenid', {['@citizenid'] = result[k].citizenid})
        core = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT charinfo FROM players WHERE citizenid = @citizenid', {['@citizenid'] = v.citizenid })

        metadata = json.decode(core[1].charinfo)

        result[k].owner = metadata.firstname .. ' ' .. metadata.lastname

        if v.author and v.author ~= nil and v.title ~= nil then
            result[k].bolo = true
        else
            result[k].bolo = false
        end
    end
    TriggerClientEvent("np-mdt:searchVehicles", src, result)
end)

RegisterServerEvent("np-mdt:saveVehicleInfo")
AddEventHandler("np-mdt:saveVehicleInfo", function(dbid,stolen, plate,imageurl, notes)
	if imageurl == "" or not imageurl then imageurl = "" end
	if notes == "" or not notes then notes = "" end
	if dbid == 0 then return end
	if plate == "" then return end
    if stolen == "NULL" then
        stolen = 0
    end

	local usource = source
    local result = 	MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM `vehicle_mdt` WHERE `license_plate` = @license_plate', {['@license_plate'] = plate})
		if result[1] then
			MysqlConverter(Config.Mysql, 'execute', 'UPDATE `vehicle_mdt` SET `image` = @image, `notes` = @notes WHERE `license_plate` = @license_plate AND `dbid` = @dbid', {
			    ['@image'] = imageurl,
				['@dbid'] = dbid,
				['@license_plate'] = plate,
				['@notes'] = notes
			})
		else
			MysqlConverter(Config.Mysql, 'execute', 'INSERT INTO `vehicle_mdt` (`license_plate`, `stolen`, `notes`, `image`, `dbid`) VALUES (@license_plate, @stolen, @notes, @image, @dbid)', {
			    ['@dbid'] = dbid,
				['@license_plate'] = plate,
				['@stolen'] = stolen,
				['@image'] = imageurl,
				['@notes'] = notes
			})
		end
end)



RegisterServerEvent("np-mdt:saveProfile")
AddEventHandler("np-mdt:saveProfile", function(profilepic, information, identifier, fName, sName)
	if imageurl == "" or not imageurl then imageurl = "" end
	if notes == "" or not notes then notes = "" end
	if dbid == 0 then return end
	if plate == "" then return end

	local usource = source
	local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM `___mdw_profiles` WHERE `cid` = @cid', {['@cid'] = identifier})
		if result[1] then
			MysqlConverter(Config.Mysql, 'execute', 'UPDATE `___mdw_profiles` SET `image` = @image, `description` = @description, `name` = @name WHERE `cid` = @cid', {['@image'] = profilepic,	['@description'] = information,	['@name'] = fName .. " " .. sName, ['@cid'] = identifier})
		else
			MysqlConverter(Config.Mysql, 'execute', 'INSERT INTO `___mdw_profiles` (`cid`, `image`, `description`, `name`) VALUES (@cid, @image, @description, @name)', {['@cid'] = identifier,	['@image'] = profilepic, ['@description'] = information, ['@name'] = fName .. " " .. sName})
		end
end)

RegisterServerEvent("np-mdt:addGalleryImg")
AddEventHandler("np-mdt:addGalleryImg", function(identifier, url)
    local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM `___mdw_profiles` WHERE cid = @identifier', {["@identifier"] = identifier})
    if result and result[1] then
        result[1].gallery = json.decode(result[1].gallery)
        table.insert(result[1].gallery, url)
        MysqlConverter(Config.Mysql, 'execute', 'UPDATE `___mdw_profiles` SET `gallery` = @gallery WHERE `cid` = @identifier', {['@identifier'] = identifier, ['@gallery'] = json.encode(result[1].gallery)})
        end
end)

RegisterServerEvent("np-mdt:removeGalleryImg")
AddEventHandler("np-mdt:removeGalleryImg", function(identifier, url)
    local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM `___mdw_profiles` WHERE cid = @identifier', {["@identifier"] = identifier})
    if result and result[1] then
        result[1].gallery = json.decode(result[1].gallery)
        for k, v in ipairs(result[1].gallery) do
            if v == url then
                table.remove(result[1].gallery, k)
            end
        end
        MysqlConverter(Config.Mysql, 'execute', 'UPDATE `___mdw_profiles` SET `gallery` = @gallery WHERE `cid` = @identifier', {['@identifier'] = identifier, ['@gallery'] = json.encode(result[1].gallery)})
       end
end)

RegisterServerEvent("np-mdt:searchProfile")
AddEventHandler("np-mdt:searchProfile", function(query)
local src = source
local queryData = string.lower(query)
local mdw_profiles = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM ___mdw_profiles', {}) 	
--print("queryData:", dump(queryData))

MySQL.Async.fetchAll("SELECT * FROM `players` WHERE `charinfo` LIKE ? OR `metadata` LIKE ?", {string.lower('%'..query..'%'),string.lower('%'..query..'%')}, function(result) -- % wildcard, needed to search for all alike results
    for k, v in pairs(result) do
        if v.charinfo then
                local player = json.decode(v.charinfo)
                --print("queryData:", dump(player))

                result[k].firstname = player.firstname
                result[k].lastname  = player.lastname

                --print(result[k].firstname, " ", result[k].lastname) 
                metadata = json.decode(v.metadata)

                if metadata.licences.permit == true then
                    result[k].Permit = true
                end
                if metadata.licences.driver == true then
                    result[k].Drivers = true
                end
                if metadata.licences.weapon == true then
                    result[k].Weapon = true
                end
                if metadata.licences.business == true then
                    result[k].Business = true
                end
                if metadata.licences.hunting == true then
                    result[k].Hunting = true
                end
                if metadata.licences.fishing == true then
                    result[k].Fishing = true
                end
                if metadata.licences.pilot == true then
                    result[k].Pilot = true
                end
                if metadata.licences.boating == true then
                    result[k].Boating = true
                end

                result[k].policemdtinfo = ""
		        result[k].pp = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"

		        for i=1, #mdw_profiles do
			        if mdw_profiles[i].cid == v.citizenid then
				        if mdw_profiles[i].image and mdw_profiles[i].image ~= nil then
					        result[k].pp = mdw_profiles[i].image
				        end
				    if mdw_profiles[i].description and mdw_profiles[i].description ~= nil then
					    result[k].policemdtinfo = mdw_profiles[i].description
				    end
				    result[k].policemdtinfo = mdw_profiles[i].description

                    result[k].warrant = false
                    result[k].convictions = 0
                    result[k].cid = v.citizenid
			    end
		    end
        end
    end
    TriggerClientEvent("np-mdt:searchProfile", src, result, true)
end)
end)


--[[
local mdw_profiles = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM ___mdw_profiles', {})

	for k, v in pairs(result) do

        result[k].firstname = 'Joe'
        result[k].lastname  = 'Rogan'
        jobdata = json.decode(v.job)
        result[k].job  = jobdata.label

        metadata = json.decode(v.metadata)

        if metadata.licences.driver == true then
            result[k].Drivers = true
        end
        if metadata.licences.weapon == true then
            result[k].Weapon = true
        end
        if metadata.licences.business == true then
            result[k].Business = true
        end

		result[k].policemdtinfo = ""
		result[k].pp = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"

		for i=1, #mdw_profiles do
			if mdw_profiles[i].cid == v.citizenid then
				if mdw_profiles[i].image and mdw_profiles[i].image ~= nil then
					result[k].pp = mdw_profiles[i].image
				end
				if mdw_profiles[i].description and mdw_profiles[i].description ~= nil then
					result[k].policemdtinfo = mdw_profiles[i].description
				end
				result[k].policemdtinfo = mdw_profiles[i].description
			end
		end
        result[k].warrant = false
        result[k].convictions = 0
        result[k].cid = v.citizenid

	end

	TriggerClientEvent("np-mdt:searchProfile", src, result, true)
    
end)]]--

function getProfile(identifier)

    local identifier = identifier
    local result = MysqlConverter(Config.Mysql,'fetchAll','SELECT * FROM players WHERE citizenid = @identifier', {['@identifier'] = identifier})
    local resultI = MysqlConverter(Config.Mysql,'fetchAll','SELECT * FROM ___mdw_incidents', {})
    local Convictions = {}

    for k, v in pairs(resultI) do
        for k2, v2 in ipairs(json.decode(v.associated)) do
            if v2.cid == result[1].citizenid then
                for k3, v3 in pairs (v2.charges) do
                    table.insert(Convictions, v3)
                end
            end
        end
    end

    result[1].convictions = Convictions


    local vehresult = MysqlConverter(Config.Mysql,'fetchAll','SELECT * FROM player_vehicles WHERE citizenid = @owner', {['@owner'] = identifier})
    local metadata =  json.decode(result[1].charinfo)
    

    result[1].vehicles = vehresult
    result[1].firstname = metadata.firstname
    result[1].lastname = metadata.lastname

    local metadata1 = MysqlConverter(Config.Mysql,'fetchAll','SELECT metadata FROM players WHERE citizenid = @identifier', {['@identifier'] = identifier})
    local job1 = MysqlConverter(Config.Mysql,'fetchAll','SELECT job FROM players WHERE citizenid = @identifier', {['@identifier'] = identifier})
    local charinfo1 = MysqlConverter(Config.Mysql,'fetchAll','SELECT charinfo FROM players WHERE citizenid = @identifier', {['@identifier'] = identifier})
      for k, v in pairs(metadata1) do
        metadata = json.decode(v.metadata)

        if metadata.licences.permit == true then
            result[k].Permit = true
        end
        if metadata.licences.driver == true then
            result[k].Drivers = true
        end
        if metadata.licences.weapon == true then
            result[k].Weapon = true
        end
        if metadata.licences.business == true then
            result[k].Business = true
        end
        if metadata.licences.hunting == true then
            result[k].Hunting = true
        end
        if metadata.licences.fishing == true then
            result[k].Fishing = true
        end
        if metadata.licences.pilot == true then
            result[k].Pilot = true
        end
        if metadata.licences.boating == true then
            result[k].Boating = true
        end

    end
      for k, v in pairs(job1) do
        local joblabel = json.decode(v.job)

        if joblabel.label == 'Civilian' then
            result[1].job = joblabel.label
        else
            result[1].job = joblabel.label .. ', ' .. joblabel.grade.name
        end

      end
      for k, v in pairs(charinfo1) do
        charinfo = json.decode(v.charinfo)
        result[1].dateofbirth = charinfo.birthdate

      end
    result[1].warrant = false
    result[1].identifier = result[1].citizenid


	local proresult = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM ___mdw_profiles WHERE cid = @identifier LIMIT 1', {['@identifier'] = identifier})
    if proresult and proresult[1] ~= nil then
        result[1].profilepic = proresult[1].image
        result[1].tags = json.decode(proresult[1].tags)
        result[1].gallery = json.decode(proresult[1].gallery)
        result[1].policemdtinfo = proresult[1].description
    else
        result[1].tags = {}
        result[1].gallery = {}
        result[1].pp =
            "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"
    end
    return result[1]
end

function getProfiles(src)

    local result =  MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM players aa LEFT JOIN ___mdw_profiles at ON at.cid = aa.citizenid ORDER BY aa.name DESC', {})
	for k, v in pairs(result) do
        local metadata = json.decode(v.charinfo)
        
        result[k].firstname = metadata.firstname
        result[k].lastname  = metadata.lastname

        result[k].warrant = false
        result[k].convictions = 0
        result[k].cid = v.citizenid

		if v.image and v.image ~= nil and v.image ~= "" then
		    result[k].pp = v.image
		else
		    result[k].pp = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"
		end
	   	local proresult = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM `___mdw_profiles` WHERE `cid` = @identifier', { ['@identifier'] = v.citizenid})
            if proresult and proresult[1] ~= nil then

        	result[k].pp = proresult[1].image
       	    result[k].policemdtinfo = proresult[1].description
			end
    end
	TriggerClientEvent("np-mdt:searchProfile", src, result, true)
end

RegisterServerEvent("np-mdt:updateLicense")
AddEventHandler("np-mdt:updateLicense", function(identifier, type, status)
    local src = source
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
    local time = os.date('%d %b %Y %H:%M:%S GMT')
    if status == "revoke" then
        action = "Revoked"
    else
        action = "Given"
    end

    TriggerEvent("np-mdt:newLog",
        name .. " " .. action .. " licenses type: " .. firstToUpper(type) .. " Edited Citizen Id: " .. identifier, time)

    if status == "revoke" then
       local citizen = QBCore.Functions.GetPlayerByCitizenId(identifier)

       if type == 'Permit' then type = 'permit' end
       if type == 'Drivers' then type = 'driver' end
       if type == 'CDL' then type = 'cdl' end
       if type == 'Weapon' then type = 'weapon' end
       if type == 'Hunting' then type = 'hunting' end
       if type == 'Fishing' then type = 'fishing' end
       if type == 'Pilot' then type = 'pilot' end
       if type == 'Business' then type = 'business' end


       local licenseTable = citizen.PlayerData.metadata["licences"]
                licenseTable[type] = false
                citizen.Functions.SetMetaData("licences", licenseTable)
                TriggerClientEvent('QBCore:Notify', citizen.PlayerData.source, "You've had your " .. type .. " license revoked", "error", 5000)
      --  MysqlConverter(Config.Mysql, 'execute', 'DELETE FROM user_licenses WHERE owner = @identifier AND type = @type', {['@identifier'] = identifier, ['@type'] = type})
    else

      if type == 'Drivers' then
        type = 'driver'
      end

      if type == 'Weapon' then
        type = 'weapon'
      end

      if type == 'CDL' then
        type = 'cdl'
      end

      local citizen = QBCore.Functions.GetPlayerByCitizenId(identifier)
      local licenseTable = citizen.PlayerData.metadata["licences"]
               licenseTable[type] = false
               citizen.Functions.SetMetaData("licences", licenseTable)
               TriggerClientEvent('QBCore:Notify', citizen.PlayerData.source, "You were granted a ".. type .." license", "success", 5000)
      --  MysqlConverter(Config.Mysql, 'execute', 'INSERT INTO user_licenses (type, owner, status) VALUES(@type, @owner, @status)', {['@type'] = type, ['@owner'] = identifier, ['@status'] = 1})
    end
end)


RegisterServerEvent("np-mdt:newBulletin")
AddEventHandler("np-mdt:newBulletin", function(title, info, time, id)
    local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
    local name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
    local Bulletin = {
        title = title,
        id = id,
        info = info,
        time = time,
        src = src,
        author = name
    }
	MysqlConverter(Config.Mysql, 'execute', 'INSERT INTO ___mdw_bulletin (title, info, time, src, author, id) VALUES(@title, @info, @time, @src, @author, @id)', {

		["@title"] = title,
		["@info"] = info,
		["@time"] = time,
		["@src"] = src,
		["@author"] = name,
		["@id"] = id
	})
    TriggerEvent("np-mdt:newLog", name .. " Opened a new Bulletin: Title " .. title .. ", Info " .. info, time)
    TriggerClientEvent("np-mdt:newBulletin", -1, src, Bulletin, "police")
end)

RegisterServerEvent("np-mdt:deleteBulletin")
AddEventHandler("np-mdt:deleteBulletin", function(id)
    local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
    local name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
	MysqlConverter(Config.Mysql, 'execute', 'DELETE FROM ___mdw_bulletin WHERE id = @id', {

        ["@id"] = id
	})
    TriggerClientEvent("np-mdt:deleteBulletin", -1, src, id, "police")
end)

RegisterServerEvent("np-mdt:newLog")
AddEventHandler("np-mdt:newLog", function(text, time)

	MysqlConverter(Config.Mysql,'execute', 'INSERT INTO ___mdw_logs (text, time) VALUES(@text, @time)', {

	    ["@text"] = text,
		["@time"] = time
	})
end)

RegisterServerEvent("np-mdt:getAllLogs")
AddEventHandler("np-mdt:getAllLogs", function()
    local src = source
	local result = MysqlConverter(Config.Mysql,'fetchAll','SELECT * FROM ___mdw_logs LIMIT 120', {})
    TriggerClientEvent("np-mdt:getAllLogs", src, result)
end)

RegisterServerEvent("np-mdt:getAllIncidents")
AddEventHandler("np-mdt:getAllIncidents", function()
    local src = source
    local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM ___mdw_incidents', {})
    TriggerClientEvent("np-mdt:getAllIncidents", src, result)
end)

RegisterServerEvent("np-mdt:getIncidentData")
AddEventHandler("np-mdt:getIncidentData", function(id)
    local src = source
    local result = MysqlConverter(Config.Mysql,'fetchAll', 'SELECT * FROM ___mdw_incidents WHERE id = @id', { ["@id"] = id })
    result[1].tags = json.decode(result[1].tags)
    result[1].officersinvolved = json.decode(result[1].officers)
    result[1].civsinvolved = json.decode(result[1].civilians)
    result[1].evidence = json.decode(result[1].evidence)
    result[1].convictions = json.decode(result[1].associated)
    result[1].charges = json.decode(result[1].associated.charges)
    TriggerClientEvent("np-mdt:updateIncidentDbId", src, result[1].id)
    TriggerClientEvent("np-mdt:getIncidentData", src, result[1], json.decode(result[1].associated))
end)

RegisterServerEvent("np-mdt:incidentSearchPerson")
AddEventHandler("np-mdt:incidentSearchPerson", function(query1)
    local src = source
    local queryData = string.lower('%' .. query1 .. '%')
	local result = MysqlConverter(Config.Mysql, 'fetchAll', "SELECT * FROM `players` WHERE `charinfo` LIKE @var1 OR `metadata` LIKE @var2 OR citizenid LIKE @var3", {
		["@var1"] = queryData,
		["@var2"] = queryData,
        ["@var3"] = query1,
	})
    
    local mdw_profiles = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM ___mdw_profiles', {})
    for k, v in pairs(result) do
        --print("coords:", dump(v.charinfo))
        local metadata = json.decode(v.charinfo)
        result[k].firstname = metadata.firstname
        result[k].lastname = metadata.lastname
        result[k].profilepic = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"
        for i = 1, #mdw_profiles do
            if mdw_profiles[i].cid == v.citizenid then
                if mdw_profiles[i].image and mdw_profiles[i].image ~= nil then
                    result[k].profilepic = mdw_profiles[i].image
                end
            end
        end
    end
    TriggerClientEvent('np-mdt:incidentSearchPerson', src, result)
end)

RegisterServerEvent("np-mdt:removeIncidentCriminal")
AddEventHandler("np-mdt:removeIncidentCriminal", function(cid, icId)

    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
    local time = os.time()
    local action = "Removed a criminal from an incident, incident ID: " .. icId
    local Cname = ""
    local result = MysqlConverter(Config.Mysql, 'fetchAll', "SELECT * FROM ___mdw_incidents WHERE id = @id", {["@id"] = icId})
    for k, v in pairs(result) do
        for k2, v2 in ipairs(json.decode(v.associated)) do
            if v2.cid == cid then
                table.remove(v2, k)
                Cname = v2.name
            end
        end
    end
    TriggerEvent("np-mdt:newLog",
        name .. ", " .. action .. ", Criminal Citizen Id: " .. cid .. ", Name: " .. Cname .. "", time)
    MysqlConverter(Config.Mysql, 'execute', 'UPDATE ___mdw_incidents SET tags = @tags WHERE id = @id', {["@tags"] = json.encode(result[1].associated), ["@id"] = icId})
end)

RegisterServerEvent("np-mdt:searchIncidents")
AddEventHandler("np-mdt:searchIncidents", function(query)
    local src = source
    local result = MysqlConverter(Config.Mysql, 'fetchAll', "SELECT * FROM `___mdw_incidents` WHERE id = @query", {['@query'] = tonumber(query)})

    TriggerClientEvent('np-mdt:getIncidents', src, result)
end)

RegisterServerEvent("np-mdt:saveIncident")
AddEventHandler("np-mdt:saveIncident", function(data)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
    for i = 1, #data.associated do
        local result2 = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM players WHERE citizenid = @identifier', { ["@identifier"] = data.associated[i].cid})
        if result2 and result2[1] then
        local metadata = json.decode(result2[1].charinfo)
        data.associated[i].name = metadata.firstname .. " " .. metadata.lastname
       end
    end
    if data.ID ~= 0 then
        MysqlConverter(Config.Mysql, 'execute', 'UPDATE `___mdw_incidents` SET `title` = @title, `author` = @author, `time` = @time, `details` = @details, `tags` = @tags, `officers` = @officers, `civilians` = @civilians, `evidence` = @evidence, `associated` = @associated WHERE `id` = @id',
            {
                ['@id'] = data.ID,
                ['@title'] = data.title,
                ['@author'] = name,
                ['@time'] = data.time,
                ['@details'] = data.information,
                ['@tags'] = json.encode(data.tags),
                ['@officers'] = json.encode(data.officers),
                ['@civilians'] = json.encode(data.civilians),
                ['@evidence'] = json.encode(data.evidence),
                ['@associated'] = json.encode(data.associated)
            })
    else
        MysqlConverter(Config.Mysql, 'execute', 'INSERT INTO `___mdw_incidents` (`title`, `author`, `time`, `details`, `tags`, `officers`, `civilians`, `evidence`, `associated`) VALUES (@title, @author, @time, @details, @tags, @officers, @civilians, @evidence, @associated)',
            {
                ['@title'] = data.title,
                ['@author'] = name,
                ['@time'] = data.time,
                ['@details'] = data.information,
                ['@tags'] = json.encode(data.tags),
                ['@officers'] = json.encode(data.officers),
                ['@civilians'] = json.encode(data.civilians),
                ['@evidence'] = json.encode(data.evidence),
                ['@associated'] = json.encode(data.associated)
            })
    end
end)

RegisterServerEvent("np-mdt:newTag")
AddEventHandler("np-mdt:newTag", function(cid, tag)
    local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM ___mdw_profiles WHERE cid = @identifier', {['@identifier'] = cid})
    local newTags = {}
    if result and result[1] then

        result[1].tags = json.decode(result[1].tags)
        table.insert(result[1].tags, tag)
        MysqlConverter(Config.Mysql, 'execute', 'UPDATE `___mdw_profiles` SET `tags` = @tags WHERE `cid` = @cid', {
            ['@cid'] = cid,
            ['@tags'] = json.encode(result[1].tags)
        })
    else
        newTags[1] = tag
        MysqlConverter(Config.Mysql, 'execute','INSERT INTO `___mdw_profiles` (`cid`, `image`, `description`, `name`) VALUES (@cid, @image, @description, @name)',
            {
                ['@cid'] = cid,
                ['@image'] = "",
                ['@description'] = "",
                ['@tags'] = json.encode(newTags),
                ['@name'] = ""
            })
    end
end)

RegisterServerEvent("np-mdt:removeProfileTag")
AddEventHandler("np-mdt:removeProfileTag", function(cid, tag)
    local query = "SELECT * FROM ___mdw_profiles WHERE cid = ?"
    local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM ___mdw_profiles WHERE cid = @identifier', {['@identifier'] = cid})
    if result and result[1] then
        result[1].tags = json.decode(result[1].tags)
        for k, v in ipairs(result[1].tags) do
            if v == tag then
                table.remove(result[1].tags, k)
            end
        end
        MysqlConverter(Config.Mysql, 'execute', 'UPDATE ___mdw_profiles SET tags = @tags WHERE cid = @identifier', {['@tags'] = json.encode(result[1].tags), ['@identifier'] = cid })
    end
end)

--[[
RegisterServerEvent("np-mdt:getPenalCode")
AddEventHandler("np-mdt:getPenalCode", function()
    local src = source
    local titles = {}
    local penalcode = {}
    local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM fine_types ORDER BY id ASC', {})
    for i = 1, #result do
        local id = result[i].id
        local res = result[i]
        titles[id] = result[i].titles
        penalcode[id] = {}
        
        local color = "green"
        class = "Infraction"
        if res.category == 1 then
            color = "orange"
            class = "Misdemeanor"
        elseif res.category == 2 or res.category == 3 then
            color = "red"
            class = "Felony"
        end
        penalcode[id].color = color

        penalcode[id].title = res.label
        penalcode[id].id = res.id
        penalcode[id].class = class
        penalcode[id].months = res.months
        penalcode[id].fine = res.fine
        print(dump(titles))
    end
    TriggerClientEvent('np-mdt:getPenalCode', src, titles, penalcode)
end)
]]--

RegisterServerEvent("np-mdt:getAllBolos")   
AddEventHandler("np-mdt:getAllBolos", function()
    local src = source
	local result =  MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM ____mdw_bolos', {})
    TriggerClientEvent("np-mdt:getBolos", src, result)
end)

RegisterServerEvent("np-mdt:getBoloData")
AddEventHandler("np-mdt:getBoloData", function(id)
    local src = source
	local result = MysqlConverter(Config.Mysql, 'fetchAll', "SELECT * FROM ____mdw_bolos WHERE dbid = @id", {["@id"] = id})
    result[1].tags = json.decode(result[1].tags)
    result[1].gallery = json.decode(result[1].gallery)
    result[1].officersinvolved = json.decode(result[1].officers)
    result[1].officers = json.decode(result[1].officers)
    TriggerClientEvent("np-mdt:getBoloData", src, result[1])
end)

RegisterServerEvent("np-mdt:searchBolos")
AddEventHandler("np-mdt:searchBolos", function(query)
    local src = source
    local result = MysqlConverter(Config.Mysql, 'fetchAll', "SELECT * FROM `____mdw_bolos` WHERE LOWER(`license_plate`) LIKE @query OR LOWER(`title`) LIKE @query OR CONCAT(LOWER(`license_plate`), ' ', LOWER(`title`)) LIKE @query",
        {
            ['@query'] = string.lower('%' .. query .. '%') -- % wildcard, needed to search for all alike results
        })
        TriggerClientEvent("np-mdt:getBolos", src, result)
end)

RegisterServerEvent("np-mdt:newBolo")
AddEventHandler("np-mdt:newBolo", function(data)
    if data.title == "" then return end
    local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
    local char = xPlayer.Functions.GetIdentifier
    local name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
    local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM `____mdw_bolos` WHERE `dbid` = @id', {['@id'] = data.id})
        if data.id ~= nil and data.id ~= 0 then
            MysqlConverter(Config.Mysql, 'execute', 'UPDATE `____mdw_bolos` SET `title` = @title, `license_plate` = @plate, `owner` = @owner, `individual` = @individual, `detail` = @detail, `tags` = @tags, `gallery` = @gallery, `officers` = @officers, `time` = @time, `author` = @author WHERE `dbid` = @id',
                {
                    ['@title'] = data.title,
                    ['@plate'] = data.plate,
                    ['@owner'] = data.owner,
                    ['@individual'] = data.individual,
                    ['@detail'] = data.detail,
                    ['@tags'] = json.encode(data.tags),
                    ['@gallery'] = json.encode(data.gallery),
                    ['@officers'] = json.encode(data.officers),
                    ['@time'] = data.time,
                    ['@author'] = name,
                    ['@id'] = data.id
                })
        else
            MysqlConverter(Config.Mysql, 'execute', 'INSERT INTO `____mdw_bolos` (`title`, `license_plate`, `owner`, `individual`, `detail`, `tags`, `gallery`, `officers`, `time`, `author`) VALUES (@title, @plate, @owner, @individual, @detail, @tags, @gallery, @officers, @time, @author)',
                {
                    ['@title'] = data.title,
                    ['@plate'] = data.plate,
                    ['@owner'] = data.owner,
                    ['@individual'] = data.individual,
                    ['@detail'] = data.detail,
                    ['@tags'] = json.encode(data.tags),
                    ['@gallery'] = json.encode(data.gallery),
                    ['@officers'] = json.encode(data.officers),
                    ['@time'] = data.time,
                    ['@author'] = name

                })
			local result2 = MysqlConverter(Config.Mysql, 'fetchAll', "SELECT * FROM ____mdw_bolos ORDER BY dbid DESC LIMIT 1", {})
            TriggerClientEvent("np-mdt:boloComplete", src, result2[1].dbid)
        end
end)

RegisterServerEvent("np-mdt:deleteBolo")
AddEventHandler("np-mdt:deleteBolo", function(id)
    local src = source
	MysqlConverter(Config.Mysql, 'execute', "DELETE FROM ____mdw_bolos WHERE dbid = @id", {
	    ["@id"] = id
	})
end)

local attachedUnits = {}
RegisterServerEvent("np-mdt:attachedUnits")
AddEventHandler("np-mdt:attachedUnits", function(callid)
    local src = source
    if not attachedUnits[callid] then
        local id = #attachedUnits + 1
        attachedUnits[callid] = {}
    end
    TriggerClientEvent("np-mdt:attachedUnits", src, attachedUnits[callid], callid)
end)

RegisterServerEvent("np-mdt:callDragAttach")
AddEventHandler("np-mdt:callDragAttach", function(callid, cid)
    local src = source

    local targetPlayer = QBCore.Functions.GetPlayerByCitizenId(cid)
    if targetPlayer == false then
        return
    end
    local name = targetPlayer.PlayerData.charinfo.firstname .. " " .. targetPlayer.PlayerData.charinfo.lastname
    local userjob = targetPlayer.PlayerData.job.name

    local id = callid

    attachedUnits[id] = {}
    attachedUnits[id][cid] = {}

    local units = 0
    for k, v in ipairs(attachedUnits[id]) do
        units = units + 1
    end

    attachedUnits[id][cid].job = userjob
    attachedUnits[id][cid].callsign = GetCallsign(cid)
    attachedUnits[id][cid].fullname = name
    attachedUnits[id][cid].cid = cid
    attachedUnits[id][cid].callid = callid
    attachedUnits[id][cid].radio = units
    TriggerClientEvent("np-mdt:callAttach", -1, callid, units)
end)

RegisterServerEvent("np-mdt:callAttach")
AddEventHandler("np-mdt:callAttach", function(callid)
    local src = source

    --local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
    local userjob = xPlayer.PlayerData.job.name
    local id = callid
    local cid = xPlayer.PlayerData.citizenid
    attachedUnits[id] = {}
    attachedUnits[id][cid] = {}

    local units = 0
    for k, v in pairs(attachedUnits[id]) do
        units = units + 1
    end
    attachedUnits[id][cid].job = userjob
    attachedUnits[id][cid].callsign = GetCallsign(cid)
    attachedUnits[id][cid].fullname = name
    attachedUnits[id][cid].cid = cid
    attachedUnits[id][cid].callid = callid
    attachedUnits[id][cid].radio = units

    TriggerClientEvent("np-mdt:callAttach", -1, callid, units)
end)

RegisterServerEvent("np-mdt:callDetach")
AddEventHandler("np-mdt:callDetach", function(callid)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local charid = xPlayer.Functions.GetIdentifier
    local id = callid
    attachedUnits[id][charid] = nil
    local units = 0
    for k, v in ipairs(attachedUnits[id]) do
        units = units + 1
    end
    TriggerClientEvent("np-mdt:callDetach", -1, callid, units)
end)

RegisterServerEvent("np-mdt:callDispatchDetach")
AddEventHandler("np-mdt:callDispatchDetach", function(callid, cid)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local id = callid

    attachedUnits[id][cid] = nil

    local units = 0
    for k, v in ipairs(attachedUnits[id]) do
        units = units + 1
    end
    TriggerClientEvent("np-mdt:callDetach", -1, callid, units)
end)

RegisterServerEvent("np-mdt:setWaypoint:unit")
AddEventHandler("np-mdt:setWaypoint:unit", function(cid)
    local src = source

    local targetPlayer = QBCore.Functions.GetPlayerByCitizenId(cid)
    if targetPlayer == false then
        return
    end

    local coords = GetEntityCoords(GetPlayerPed(src))
    TriggerClientEvent("np-mdt:setWaypoint:unit", src, coords)
end)

RegisterServerEvent("np-mdt:setDispatchWaypoint")
AddEventHandler("np-mdt:setDispatchWaypoint", function(callid, cid)
    local src = source
    local targetPlayer = QBCore.Functions.GetPlayerByCitizenId(cid)
    if targetPlayer == false then
        return
    end
    local coords = GetEntityCoords(GetPlayerPed(src))
    TriggerClientEvent("np-mdt:setWaypoint:unit", src, coords)
end)

local CallResponses = {}

RegisterServerEvent("np-mdt:getCallResponses")
AddEventHandler("np-mdt:getCallResponses", function(callid)
    local src = source
    if not CallResponses[callid] then
        CallResponses[callid] = {}
    end
    TriggerClientEvent("np-mdt:getCallResponses", src, CallResponses[callid], callid)
end)

RegisterServerEvent("np-mdt:sendCallResponse")
AddEventHandler("np-mdt:sendCallResponse", function(message, time, callid, name)
    local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
    local char = xPlayer.Functions.GetIdentifier
    local name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
    if not CallResponses[callid] then
        CallResponses[callid] = {}
    end
    local id = #CallResponses[callid] + 1
    CallResponses[callid][id] = {}

    CallResponses[callid][id].name = name
    CallResponses[callid][id].message = message
    CallResponses[callid][id].time = time

    TriggerClientEvent("np-mdt:sendCallResponse", src, message, time, callid, name)
end)

RegisterServerEvent("np-mdt:getAllReports")
AddEventHandler("np-mdt:getAllReports", function()
    local src = source
	local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM ____mdw_reports', {})
    TriggerClientEvent("np-mdt:getAllReports", src, result)
end)

RegisterServerEvent("np-mdt:getReportData")
AddEventHandler("np-mdt:getReportData", function(id)
    local src = source
	local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM ____mdw_reports WHERE dbid = @id', {
	["@id"] = id
	})
    result[1].tags = json.decode(result[1].tags)
    result[1].gallery = json.decode(result[1].gallery)
    result[1].officersinvolved = json.decode(result[1].officers)
    result[1].officers = json.decode(result[1].officers)
    result[1].civsinvolved = json.decode(result[1].civsinvolved)
    TriggerClientEvent("np-mdt:getReportData", src, result[1])
end)

RegisterServerEvent("np-mdt:searchReports")
AddEventHandler("np-mdt:searchReports", function(querydata)
    local src = source
    local string = string.lower('%' .. querydata .. '%')
	local result = MysqlConverter(Config.Mysql, 'fetchAll', "SELECT * FROM ____mdw_reports aa WHERE LOWER(`type`) LIKE @var1 OR LOWER(`title`) LIKE @var2 OR LOWER(`dbid`) LIKE @var3 OR CONCAT(LOWER(`type`), ' ', LOWER(`title`), ' ', LOWER(`dbid`)) LIKE @var4", {
	     ["@var1"] = string,
		 ["@var2"] = string,
		 ["@var3"] = string,
		 ["@var4"] = string
	})
    TriggerClientEvent("np-mdt:getAllReports", src, result)
end)

RegisterServerEvent("np-mdt:newReport")
AddEventHandler("np-mdt:newReport", function(data)
    if data.title == "" then
        return
    end
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
    local time = os.date()

    local result = MysqlConverter(Config.Mysql, 'fetchAll' ,'SELECT * FROM `____mdw_reports` WHERE `dbid` = @id', {
        ['@id'] = data.id
    })
        if data.id ~= nil and data.id ~= 0 then

            local action = "Edit A Report, Profile ID: " .. data.id
            TriggerEvent("np-mdt:newLog", name .. ", " .. action .. ", Changes: " .. json.encode(data), time)

            MysqlConverter(Config.Mysql, 'execute', 'UPDATE `____mdw_reports` SET `title` = @title, `type` = @type, `detail` = @detail, `tags` = @tags, `gallery` = @gallery, `officers` = @officers, `civsinvolved` = @civsinvolved, `time` = @time, `author` = @author WHERE `dbid` = @id',
                {
                    ['@title'] = data.title,
                    ['@type'] = data.type,
                    ['@detail'] = data.detail,
                    ['@tags'] = json.encode(data.tags),
                    ['@gallery'] = json.encode(data.gallery),
                    ['@officers'] = json.encode(data.officers),
                    ['@civsinvolved'] = json.encode(data.civilians),
                    ['@time'] = data.time,
                    ['@author'] = name,
                    ['@id'] = data.id
                })
        else
            MysqlConverter(Config.Mysql, 'execute', 'INSERT INTO `____mdw_reports` (`title`, `type`, `detail`, `tags`, `gallery`, `officers`, `civsinvolved`, `time`, `author`) VALUES (@title, @type, @detail, @tags, @gallery, @officers, @civsinvolved, @time, @author)',
                {
                    ['@title'] = data.title,
                    ['@type'] = data.type,
                    ['@detail'] = data.detail,
                    ['@tags'] = json.encode(data.tags),
                    ['@gallery'] = json.encode(data.gallery),
                    ['@officers'] = json.encode(data.officers),
                    ['@civsinvolved'] = json.encode(data.civilians),
                    ['@time'] = data.time,
                    ['@author'] = name
                })
            Wait(500)
			local result2 = MysqlConverter(Config.Mysql, 'fetchAll', "SELECT * FROM ____mdw_reports ORDER BY dbid DESC LIMIT 1", {})
            TriggerClientEvent("np-mdt:reportComplete", src, result2[1].dbid)
        end
end)

function UpdateDispatch(src)
	local result = MysqlConverter(Config.Mysql, 'fetchAll', "SELECT * FROM ___mdw_messages LIMIT 200", {})
    TriggerClientEvent("np-mdt:dashboardMessages", src, result)
end

RegisterServerEvent("np-mdt:sendMessage")
AddEventHandler("np-mdt:sendMessage", function(message, time)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local char = xPlayer.Functions.GetIdentifier
    local name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
    local pic = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"

	local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM ___mdw_profiles WHERE cid = @identifier', { ["@identifier"] = char })
    if result and result[1] ~= nil then
        if result[1].image and result[1].image ~= nil and result[1].image ~= "" then
            pic = result[1].image
        end
    end
	MysqlConverter(Config.Mysql, 'execute', 'INSERT INTO ___mdw_messages (name, message, time, profilepic, job) VALUES(@name, @message, @time, @pic, @job)', {
	   ["@name"] = name,
	   ["@message"] = message,
	   ["@time"] = time,
	   ["@pic"] = pic,
	   ["@job"] = 'police'
	})
    local lastMsg = {
        name = name,
        message = message,
        time = time,
        profilepic = pic,
        job = "police"
    }
    TriggerClientEvent("np-mdt:dashboardMessage", -1, lastMsg)
end)

RegisterServerEvent("np-mdt:refreshDispatchMsgs")
AddEventHandler("np-mdt:refreshDispatchMsgs", function()
    local src = source
	local result = MysqlConverter(Config.Mysql, 'fetchAll', 'SELECT * FROM ___mdw_messages LIMIT 200', {})
    TriggerClientEvent("np-mdt:dashboardMessages", src, result)
end)

-- RegisterNetEvent('np-mdt:dashboardMessage')
-- AddEventHandler('np-mdt:dashboardMessage', function(sentData)
--     local job = exports["isPed"]:isChar("myjob")
--     if job == "police" or job.name == 'ambulance' then
--         SendNUIMessage({ type = "dispatchmessage", data = sentData })
--     end
-- end)

RegisterServerEvent("np-mdt:setCallsign")
AddEventHandler("np-mdt:setCallsign", function(identifier, callsign)
  local Player = QBCore.Functions.GetPlayerByCitizenId(identifier)
  Player.Functions.SetMetaData("callsign", callsign)
end)

function tprint(t, s)
    for k, v in pairs(t) do
        local kfmt = '["' .. tostring(k) .. '"]'
        if type(k) ~= 'string' then
            kfmt = '[' .. k .. ']'
        end
        local vfmt = '"' .. tostring(v) .. '"'
        if type(v) == 'table' then
            tprint(v, (s or '') .. kfmt)
        else
            if type(v) ~= 'string' then
                vfmt = tostring(v)
            end
            print(type(t) .. (s or '') .. kfmt .. ' = ' .. vfmt)
        end
    end
end

function getUserFromCid(cid)
    local users = exports["np-base"]:getModule("Player"):GetUsers()
    for k, v in pairs(users) do
        local user = exports["np-base"]:getModule("Player"):GetUser(v)
        if user then
            local char = user:getCurrentCharacter()
            if char.id == cid then
                return user
            end
        end
    end
    return false
end

function MysqlConverter(plugin,type,query,var)
	local wait = promise.new()
    if type == 'fetchAll' and plugin == 'mysql-async' then
		MySQL.Async.fetchAll(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'execute' and plugin == 'mysql-async' then
        MySQL.Async.execute(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'execute' and plugin == 'ghmattisql' then
        exports['ghmattimysql']:execute(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'fetchAll' and plugin == 'ghmattisql' then
        exports.ghmattimysql:execute(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'execute' and plugin == 'oxmysql' then
        MySQL.Async.fetchAll(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'fetchAll' and plugin == 'oxmysql' then
		MySQL.Async.fetchAll(query, var, function(result)
			wait:resolve(result)
		end)
    end
	return Citizen.Await(wait)
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
