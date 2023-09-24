QBCore = exports['lrp-core']:GetCoreObject() -- Used Globally
inJail = false
jailTime = 0
currentJob = nil --"electrician" old code
CellsBlip = nil
TimeBlip = nil
ShopBlip = nil
WorkBlip = nil
PlayerJob = {}

local inRange = false

-- Functions

function DrawText3D(x, y, z, text) -- Used Globally
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function CreateCellsBlip()
	if CellsBlip ~= nil then
		RemoveBlip(CellsBlip)
	end
	CellsBlip = AddBlipForCoord(Config.Locations["yard"].coords.x, Config.Locations["yard"].coords.y, Config.Locations["yard"].coords.z)

	SetBlipSprite (CellsBlip, 238)
	SetBlipDisplay(CellsBlip, 4)
	SetBlipScale  (CellsBlip, 0.8)
	SetBlipAsShortRange(CellsBlip, true)
	SetBlipColour(CellsBlip, 4)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Cells")
	EndTextCommandSetBlipName(CellsBlip)

	if TimeBlip ~= nil then
		RemoveBlip(TimeBlip)
	end
	TimeBlip = AddBlipForCoord(Config.Locations["freedom"].coords.x, Config.Locations["freedom"].coords.y, Config.Locations["freedom"].coords.z)

	SetBlipSprite (TimeBlip, 466)
	SetBlipDisplay(TimeBlip, 4)
	SetBlipScale  (TimeBlip, 0.8)
	SetBlipAsShortRange(TimeBlip, true)
	SetBlipColour(TimeBlip, 4)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Time check")
	EndTextCommandSetBlipName(TimeBlip)

	if ShopBlip ~= nil then
		RemoveBlip(ShopBlip)
	end
	ShopBlip = AddBlipForCoord(Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z)

	SetBlipSprite (ShopBlip, 52)
	SetBlipDisplay(ShopBlip, 4)
	SetBlipScale  (ShopBlip, 0.5)
	SetBlipAsShortRange(ShopBlip, true)
	SetBlipColour(ShopBlip, 0)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Canteen")
	EndTextCommandSetBlipName(ShopBlip)

	if WorkBlip ~= nil then
		RemoveBlip(WorkBlip)
	end
	WorkBlip = AddBlipForCoord(Config.Locations["work"].coords.x, Config.Locations["work"].coords.y, Config.Locations["work"].coords.z)

	SetBlipSprite (WorkBlip, 440)
	SetBlipDisplay(WorkBlip, 4)
	SetBlipScale  (WorkBlip, 0.5)
	SetBlipAsShortRange(WorkBlip, true)
	SetBlipColour(WorkBlip, 0)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Prison Work")
	EndTextCommandSetBlipName(WorkBlip)
end

-- Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	QBCore.Functions.GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] > 0 then
			TriggerEvent("prison:client:Enter", PlayerData.metadata["injail"])
		end
	end)

	QBCore.Functions.TriggerCallback('prison:server:IsAlarmActive', function(active)
		if active then
			TriggerEvent('prison:client:JailAlarm', true)
		end
	end)

	PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
	inJail = false
	currentJob = nil
	RemoveBlip(currentBlip)
end)

RegisterNetEvent('prison:client:Enter', function(time)
	QBCore.Functions.Notify( Lang:t("error.injail", {Time = time}), "error")

	TriggerEvent("chatMessage", "SYSTEM", "warning", "Your property has been seized, you'll get everything back when your time is up..")
	DoScreenFadeOut(500)
	while not IsScreenFadedOut() do
		Wait(10)
	end
	local RandomStartPosition = Config.Locations.spawns[math.random(1, #Config.Locations.spawns)]
	SetEntityCoords(PlayerPedId(), RandomStartPosition.coords.x, RandomStartPosition.coords.y, RandomStartPosition.coords.z - 0.9, 0, 0, 0, false)
	SetEntityHeading(PlayerPedId(), RandomStartPosition.coords.w)
	Wait(500)
	TriggerEvent('animations:client:EmoteCommandStart', {RandomStartPosition.animation})

	inJail = true
	jailTime = time
	local randomJobIndex = math.random(1, #Config.PrisonJobs)
   	local RandomJobSelection = Config.PrisonJobs[randomJobIndex].name
	currentJob = RandomJobSelection --"electrician" old code
	TriggerServerEvent("prison:server:SetJailStatus", jailTime)
	TriggerServerEvent("prison:server:SaveJailItems", jailTime)
	TriggerServerEvent("InteractSound_SV:PlayOnSource", "jail", 0.5)
	CreateCellsBlip()
	Wait(2000)
	DoScreenFadeIn(1000)
	QBCore.Functions.Notify( Lang:t("error.do_some_work", {currentjob = Config.PrisonJobs[randomJobIndex].label}), "error")
end)

RegisterNetEvent('prison:client:Leave', function()
	if jailTime > 0 then
		QBCore.Functions.Notify( Lang:t("info.timeleft", {JAILTIME = jailTime}))
	else
		jailTime = 0
		TriggerServerEvent("prison:server:SetJailStatus", 0)
		TriggerServerEvent("prison:server:GiveJailItems")
		TriggerEvent("chatMessage", "SYSTEM", "warning", "you've received your property back..")
		inJail = false
		RemoveBlip(currentBlip)
		RemoveBlip(CellsBlip)
		CellsBlip = nil
		RemoveBlip(TimeBlip)
		TimeBlip = nil
		RemoveBlip(ShopBlip)
		ShopBlip = nil
		RemoveBlip(WorkBlip)
		WorkBlip = nil
		currentJob = nil --"electrician" old code
		QBCore.Functions.Notify(Lang:t("success.free_"))
		DoScreenFadeOut(500)
		while not IsScreenFadedOut() do
			Wait(10)
		end
		SetEntityCoords(PlayerPedId(), Config.Locations["outside"].coords.x, Config.Locations["outside"].coords.y, Config.Locations["outside"].coords.z, 0, 0, 0, false)
		SetEntityHeading(PlayerPedId(), Config.Locations["outside"].coords.w)

		Wait(500)

		DoScreenFadeIn(1000)
	end
end)

RegisterNetEvent('prison:client:UnjailPerson', function()
	if jailTime > 0 then
		TriggerServerEvent("prison:server:SetJailStatus", 0)
		TriggerServerEvent("prison:server:GiveJailItems")
		TriggerEvent("chatMessage", "SYSTEM", "warning", "You got your property back..")
		inJail = false
		RemoveBlip(currentBlip)
		RemoveBlip(CellsBlip)
		CellsBlip = nil
		RemoveBlip(TimeBlip)
		TimeBlip = nil
		RemoveBlip(ShopBlip)
		ShopBlip = nil
		RemoveBlip(WorkBlip)
		WorkBlip = nil
		QBCore.Functions.Notify(Lang:t("success.free_"))
		DoScreenFadeOut(500)
		while not IsScreenFadedOut() do
			Wait(10)
		end
		SetEntityCoords(PlayerPedId(), Config.Locations["outside"].coords.x, Config.Locations["outside"].coords.y, Config.Locations["outside"].coords.z, 0, 0, 0, false)
		SetEntityHeading(PlayerPedId(), Config.Locations["outside"].coords.w)
		Wait(500)
		DoScreenFadeIn(1000)
	end
end)

--- Lifers Job Applying Menu future update once i build rep system/crafting and luck with loot table as well.

--[[ ----- Prison Job Menu Trigger ---------------------

RegisterNetEvent('qb-prison:client:jobMenu')
AddEventHandler('qb-prison:client:jobMenu', function()
    if inJail then
        --print("In Jail Dummy")
        createPrisonJobMenu()
        exports['qb-menu']:openMenu(pjobMenu)
    else
        QBCore.Functions.Notify("You are not an Inmate", "error", 3500)
    end
end)

------ Menu Structures ------

function createPrisonJobMenu()
    pjobMenu = {
        {
            isHeader = true,
            header = 'Prison Work'
        },
        {
            header = "Electrician",
			txt = "Fix Electrical Boxes For A Time Reduction",
			params = {
                isServer = false,
                event = "qb-prison:jobapplyElectrician",
            }
        },
        {
            header = "Cook",
			txt = "Cook Food For A Time Reduction",
			params = {
                isServer = false,
                event = "qb-prison:jobapplyCook",
            }
        },
        {
            header = "Janitor",
			txt = "Clean Common Area For A Time Reduction",
			params = {
                isServer = false,
                event = "qb-prison:jobapplyJanitor",
            }
        },
        {
            header = "Close Menu",
			txt = "Close Menu",
			params = {
                isServer = false,
                event = exports['qb-menu']:closeMenu(),
            }
        },
    }
    exports['qb-menu']:openMenu(pjobMenu)
end

RegisterNetEvent('qb-prison:jobapplyElectrician', function(args)
	local pos = GetEntityCoords(PlayerPedId())
	inRange = false

	local dist = #(pos - vector3(Config.Locations["work"].coords.x, Config.Locations["work"].coords.y, Config.Locations["work"].coords.z))

    if dist < 2 then
		inRange = true
        if inJail then
			currentJob = "electrician" --"electrician" old code
			print("job is electrician bishface")
		else
			QBCore.Functions.Notify('Job Not Available')
			TriggerEvent('qb-prison:client:jobMenu')
		end
	else
		QBCore.Functions.Notify('Not Close Enough To Pay Phone')
	end

	if not inRange then
		Wait(1000)
	end
end)

RegisterNetEvent('qb-prison:jobapplyCook', function(args)
	local pos = GetEntityCoords(PlayerPedId())
	inRange = false

	local dist = #(pos - vector3(Config.Locations["work"].coords.x, Config.Locations["work"].coords.y, Config.Locations["work"].coords.z))

    if dist < 2 then
		inRange = true
        if inJail then
			currentJob = "cook" --"electrician" old code
			print("job is cook bishface")
		else
			QBCore.Functions.Notify('Job Not Available')
			TriggerEvent('qb-prison:client:jobMenu')
		end
	else
		QBCore.Functions.Notify('Not Close Enough To Pay Phone')
	end

	if not inRange then
		Wait(1000)
	end
end)

RegisterNetEvent('qb-prison:jobapplyJanitor', function(args)
	local pos = GetEntityCoords(PlayerPedId())
	inRange = false

	local dist = #(pos - vector3(Config.Locations["work"].coords.x, Config.Locations["work"].coords.y, Config.Locations["work"].coords.z))

    if dist < 2 then
		inRange = true
        if inJail then
			currentJob = "janitor" --"electrician" old code
			print("job is janitor bishface")
		else
			QBCore.Functions.Notify('Job Not Available')
			TriggerEvent('qb-prison:client:jobMenu')
		end
	else
		QBCore.Functions.Notify('Not Close Enough To Pay Phone')
	end

	if not inRange then
		Wait(1000)
	end
end) ]]--

RegisterNetEvent('qb-prison:client:checkTime', function()
	if LocalPlayer.state.isLoggedIn then
		if inJail then
			local pos = GetEntityCoords(PlayerPedId())
			if #(pos - vector3(Config.Locations["freedom"].coords.x, Config.Locations["freedom"].coords.y, Config.Locations["freedom"].coords.z)) < 1.5 then
				TriggerEvent("prison:client:Leave")
			end
		end
	end
end)


RegisterNetEvent('qb-prison:client:useCanteen', function()
	if LocalPlayer.state.isLoggedIn then
		if inJail then
			local ShopItems = {}
			ShopItems.label = "Prison Canteen"
			ShopItems.items = Config.CanteenItems
			ShopItems.slots = #Config.CanteenItems
			TriggerServerEvent("inventory:server:OpenInventory", "shop", "Canteenshop_"..math.random(1, 99), ShopItems)
		else
			QBCore.Functions.Notify("You are not in Jail..", "error")
		end
	else
		Wait(5000)
	end
end)

RegisterNetEvent('qb-prison:client:slushy', function()
	if LocalPlayer.state.isLoggedIn then
		if inJail then
			Citizen.Wait(1000)
			local ped = PlayerPedId()
			local seconds = math.random(12,20)
			local circles = math.random(4,8)
			local success = exports['lrp-skill']:StartLockPickCircle(circles, seconds, success)
			if success then
				TriggerServerEvent("InteractSound_SV:PlayOnSource", "pour-drink", 0.1)
				TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
				QBCore.Functions.Progressbar("hospital_waiting", "Making a Good Slushy...", 10000, false, true, {
					disableMovement = false,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					SlushyTime(success)
					ClearPedTasks(PlayerPedId())
				end, function() -- Cancel
					QBCore.Functions.Notify("Failed...", "error")
					ClearPedTasks(PlayerPedId())
				end)
			else
				QBCore.Functions.Notify("You Failed making a Slushy..", "error")
				ClearPedTasks(PlayerPedId())
			end
		else
			QBCore.Functions.Notify("You are not in Jail..", "error")
		end
	else
		Wait(5000)
	end
end)

function SlushyTime(success)
	if success then
		local SlushyItems = {}
			SlushyItems.label = "Prison Slushy"
			SlushyItems.items = Config.SlushyItems
			SlushyItems.slots = #Config.SlushyItems
			TriggerServerEvent("inventory:server:OpenInventory", "shop", "Slushyshop_"..math.random(1, 99), SlushyItems)
	else
		QBCore.Functions.Notify("Slushy Machine is Broken", "error")
	end

end

exports['lrp-target']:AddBoxZone("makeslushy", vector3(1777.66, 2560.07, 45.67), 0.6, 0.6, {
    name="makeslushy",
    heading=0,
    debugPoly=true,
    minZ=45.67,
    maxZ=46.67,
    }, {
        options = {
            {
                type = "client",
                event = "qb-prison:client:slushy",
                icon = "fas fa-wine-bottle",
                label = "Make Slushy",
            },
        },
        distance = 2.5
})

exports['lrp-target']:AddBoxZone("PrisonMenu", vector3(1832.0, 2580.14, 46.01), 0.50, 0.35, {
    name = "PrisonMenu",
    heading = 269.53,
    debugPoly = false,
    minZ = 46.20,
    maxZ = 47.00,
    }, {
        options = {
            {
                type = "client",
                event = "lrp-prison:PrisonMenu",
                icon = "fas fa-sign-in-alt",
                label = "Prison Actions",
            },
        },
        distance = 2.5
})

RegisterNetEvent('lrp-prison:PrisonMenu', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Check Time",
            txt = "Check Remaining Sentence",
            params = {
                event = "prison:client:checktime"
            }
        },
        {
            header = "Leave Prison",
            txt = "FREEDOM!",
            params = {
                event = "prison:client:Leave"
            }
        },
        {
            header = "Make a Call",
            txt = "(Currently Unavailable)",
            params = {
                event = "lrp-prison:PrisonMenu"
            }
        },
    })
end)
---------------------------------------------------

-- Threads

CreateThread(function()
    TriggerEvent('prison:client:JailAlarm', false)
	while true do
		Wait(7)
		if jailTime > 0 and inJail then
			Wait(1000 * 60)
			if jailTime > 0 and inJail then
				jailTime = jailTime - 1
				if jailTime <= 0 then
					jailTime = 0
					QBCore.Functions.Notify(Lang:t("success.timesup"), "success", 10000)
				end
				TriggerServerEvent("prison:server:SetJailStatus", jailTime)
			end
		else
			Wait(5000)
		end
	end
end)

