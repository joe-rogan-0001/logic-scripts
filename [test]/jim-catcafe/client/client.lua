local QBCore = exports['lrp-core']:GetCoreObject()

PlayerJob = {}
local Targets = {}
local onDuty = false
local alcoholCount = 0

local function jobCheck()
	canDo = true
	if not onDuty then TriggerEvent('QBCore:Notify', "Not clocked in!", 'error') canDo = false end
	return canDo
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then if PlayerData.job.name == "noodleexchange" then TriggerServerEvent("QBCore:ToggleDuty") end end
    end)
end)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo) PlayerJob = JobInfo onDuty = PlayerJob.onduty end) 
RegisterNetEvent('QBCore:Client:SetDuty', function(duty) onDuty = duty end)

AddEventHandler('onResourceStart', function(resource) if GetCurrentResourceName() ~= resource then return end
	QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job if PlayerData.job.name == "noodleexchange" then onDuty = PlayerJob.onduty end end)
end)

CreateThread(function()
	local bossroles = {}
	for k, v in pairs(QBCore.Shared.Jobs["noodleexchange"].grades) do
		if QBCore.Shared.Jobs["noodleexchange"].grades[k].isboss == true then
			if bossroles["noodleexchange"] then
				if bossroles["noodleexchange"] > tonumber(k) then bossroles["noodleexchange"] = tonumber(k) end
			else bossroles["noodleexchange"] = tonumber(k)	end
		end
	end
	for k, v in pairs(Config.Locations) do
		if Config.Locations[k].zoneEnable then
			JobLocation = PolyZone:Create(Config.Locations[k].zones, { name = Config.Locations[k].label, debugPoly = Config.Debug })
			JobLocation:onPlayerInOut(function(isPointInside) if not isPointInside and onDuty and PlayerJob.name == "noodleexchange" then TriggerServerEvent("QBCore:ToggleDuty") end end)	
		end
	end
	for k, v in pairs(Config.Locations) do
		if Config.Locations[k].zoneEnable then
			blip = AddBlipForCoord(Config.Locations[k].blip)	
			SetBlipAsShortRange(blip, true)
			SetBlipSprite(blip, 89)
			SetBlipColour(blip, Config.Locations[k].blipcolor)
			SetBlipScale(blip, 0.7)
			SetBlipDisplay(blip, 6)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString("Noodle Exchange")
			EndTextCommandSetBlipName(blip)
		end
	end
	--Stashes
	Targets["CatPrepared"] =
	exports['lrp-target']:AddBoxZone("CatPrepared", vector3(-587.4, -1059.6, 23.45), 2.0, 2.5, { name="CatPrepared", heading = 270.0, debugPoly=Config.Debug, minZ=21.45, maxZ=23.45 }, 
		{ options = { {  event = "jim-noodleexchange:Stash", icon = "fas fa-box-open", label = "Prepared Food", job = "noodleexchange", stash = "Shelf" }, },  distance = 2.0 })
	--FRIDGE/STORE
	Targets["CatFridge"] =
	exports['lrp-target']:AddBoxZone("CatFridge", vector3(-1241.37, -267.81, 38.92), 1.65, 0.5, { name="CatFridge", heading = 300, debugPoly=Config.Debug, minZ=37.60, maxZ=38.04 }, 
		{ options = { {  event = "jim-noodleexchange:Stash", icon = "fas fa-temperature-low", label = "Open Fridge", stash = "Fridge", job = "noodleexchange" }, {  event = "jim-noodleexchange:Shop", icon = "fas fa-box-open", label = "Open Store", job = "noodleexchange" },}, distance = 1.0 })
	Targets["CatFridge2"] =
	exports['lrp-target']:AddBoxZone("CatFridge2", vector3(-590.67, -1068.1, 22.34), 2.0, 0.6, { name="CatFridge2", heading = 0, debugPoly=Config.Debug, minZ=19.84, maxZ=23.84 }, 
		{ options = { {  event = "jim-noodleexchange:Stash", icon = "fas fa-temperature-low", label = "Open Fridge", stash = "Fridge2", job = "noodleexchange"  }, }, distance = 1.0 })
	--WARESTORAGE
	--[[
	Targets["CatStorage"] =
	exports['lrp-target']:AddBoxZone("CatStorage", vector3(-598.0, -1068.47, 22.34), 4.0, 1.5, { name="CatStorage", heading = 90, debugPoly=Config.Debug, minZ=20.94, maxZ=24.94 }, 
		{ options = {  {  event = "jim-noodleexchange:Shop", icon = "fas fa-box-open", label = "Open Store", job = "noodleexchange" }, }, distance = 2.0 })
	]]--
	--Sinks
	Targets["CatWash1"] =
	exports['lrp-target']:AddBoxZone("CatWash1", vector3(-587.89, -1062.58, 22.36), 0.7, 0.7, { name="CatWash1", heading = 0, debugPoly=Config.Debug, minZ=19.11, maxZ=23.11 }, 
		{ options = { { event = "jim-noodleexchange:washHands", icon = "fas fa-hand-holding-water", label = "Wash Your Hands" }, }, distance = 1.5	})
	--Oven
	--[[
	Targets["CatOven"] =
	exports['lrp-target']:AddBoxZone("CatOven", vector3(-590.66, -1059.13, 22.34), 2.5, 0.6, { name="CatOven", heading = 0, debugPoly=Config.Debug, minZ = 19.84, maxZ = 23.84, }, 
		{ options = { { event = "jim-noodleexchange:Crafting", icon = "fas fa-temperature-high", label = "Use Oven", job = "noodleexchange", craftable = Crafting.Oven, header = "Oven Menu" }, }, distance = 2.0 })
	]]--
	--Hob & Oven
	Targets["CatHob"] =
	exports['lrp-target']:AddBoxZone("CatHob",vector3(-1239.64, -266.6, 38.71), 2.5, 0.6, { name="CatHob", heading = 300, debugPoly=Config.Debug, minZ=37.60, maxZ=38.04, }, 
		{ options = { { event = "jim-noodleexchange:Crafting", icon = "fas fa-temperature-high", label = "Use Hob", job = "noodleexchange", craftable = Crafting.Hob, header = "Hob Menu" },{ event = "jim-noodleexchange:Crafting", icon = "fas fa-temperature-high", label = "Use Oven", job = "noodleexchange", craftable = Crafting.Oven, header = "Oven Menu" },  }, distance = 2.0 })
	--Trays
	Targets["CatCounter"] =
	exports['lrp-target']:AddBoxZone("CatCounter", vector3(-1237.98, -269.73, 38.39), 0.75, 3.5, { name="CatCounter", heading = 28.9, debugPoly=Config.Debug, minZ=37.60, maxZ=38.04 }, 
		{ options = { { event = "jim-noodleexchange:Stash", icon = "fas fa-hamburger", label = "Open Counter", stash = "Counter" }, }, distance = 1.0	})	

	-- Trays for people
	Targets["CatCounter2"] =
	exports['lrp-target']:AddBoxZone("CatCounter2", vector3(-1236.34, -270.61, 38.65), 0.5, 0.75, { name="CatCounter2", heading = 210, debugPoly=Config.Debug, minZ=37.60, maxZ=38.04 }, 
		{ options = { { event = "jim-noodleexchange:Stash", icon = "fas fa-hamburger", label = "Open Counter", stash = "Counter" }, }, distance = 1.0	})	

	Targets["CatCounter3"] =
	exports['lrp-target']:AddBoxZone("CatCounter3", vector3(-1237.78, -271.67, 38.79), 0.5, 0.75, { name="CatCounter3", heading = 210, debugPoly=Config.Debug, minZ=37.60, maxZ=38.04 }, 
		{ options = { { event = "jim-noodleexchange:Stash", icon = "fas fa-hamburger", label = "Open Counter", stash = "Counter" }, }, distance = 1.0	})	
	
	
	--Payments
	Targets["CatReceipt1"] =
	exports['lrp-target']:AddBoxZone("CatReceipt1", vector3(-1235.54, -270.29, 38.75), 0.5, 0.75, { name="CatReceipt1", heading = 210, debugPoly=Config.Debug, minZ=37.60, maxZ=38.04, }, 
		{ options = { { event = "lrp-noodleexchange:bill", icon = "fas fa-credit-card", label = "Charge Customer", job = "noodleexchange",
						img = "<center><p><img src=https://i.imgur.com/03eA7N0.png width=100px></p>"
					}, }, distance = 2.0 })
	Targets["CatReceipt2"] =
	exports['lrp-target']:AddBoxZone("CatReceipt2",vector3(-1237.2, -271.17, 38.75), 0.5, 0.75, { name="CatReceipt2", heading = 210, debugPoly=Config.Debug, minZ=37.60, maxZ=38.04, }, 
		{ options = { { event = "lrp-noodleexchange:bill", icon = "fas fa-credit-card", label = "Charge Customer", job = "noodleexchange",
						img = "<center><p><img src=https://i.imgur.com/03eA7N0.png width=100px></p>"
					}, }, distance = 2.0 })	
	Targets["CatReceipt3"] =
	exports['lrp-target']:AddBoxZone("CatReceipt3", vector3(-1238.81, -272.03, 38.74), 0.5, 0.75, { name="CatReceipt3", heading = 210, debugPoly=Config.Debug, minZ=37.60, maxZ=38.04, }, 
		{ options = { { event = "lrp-noodleexchange:bill", icon = "fas fa-credit-card", label = "Charge Customer", job = "noodleexchange",
						img = "<center><p><img src=https://i.imgur.com/03eA7N0.png width=100px></p>"
					}, }, distance = 2.0 })						
	--Coffee/Drinks
	Targets["CatCoffee"] =
	exports['lrp-target']:AddBoxZone("CatCoffee", vector3(-586.8, -1061.89, 22.34), 0.7, 0.5, { name="CatCoffee", heading = 0, debugPoly=Config.Debug, minZ=21.99, maxZ=23.19 }, 
		{ options = { { event = "jim-noodleexchange:Crafting", icon = "fas fa-mug-hot", label = "Pour Coffee", job = "noodleexchange", craftable = Crafting.Coffee, header = "Coffee Menu" }, }, distance = 2.0 })
	--Chopping Board
	Targets["CatBoard"] =
	exports['lrp-target']:AddBoxZone("CatBoard", vector3(-1238.78, -269.38, 38.74), 3.5, 0.6, { name="CatBoard", heading = 300, debugPoly=Config.Debug, minZ=37.60, maxZ=38.04, }, 
		{ options = { { event = "jim-noodleexchange:Crafting", icon = "fas fa-utensils", label = "Prepare Food", job = "noodleexchange", craftable = Crafting.ChoppingBoard, header = "Chopping Board" }, { event = "jim-noodleexchange:Crafting", icon = "fas fa-mug-hot", label = "Pour Drink", job = "noodleexchange", craftable = Crafting.Coffee, header = "Coffee Menu" },}, distance = 2.0 })	
	--Tables
	--[[
	Targets["CatTable"] =
	exports['lrp-target']:AddBoxZone("CatTable", vector3(-573.43, -1059.76, 22.49), 1.9, 1.0, { name="CatTable", heading = 91.0, debugPoly=Config.Debug, minZ=21.49, maxZ=22.89 }, 
		{ options = { {  event = "jim-noodleexchange:Stash", icon = "fas fa-box-open", label = "Search Table", stash = "Table_1" }, }, distance = 2.0 })
	Targets["CatTable2"] =
	exports['lrp-target']:AddBoxZone("CatTable2", vector3(-573.44, -1063.45, 22.34), 1.9, 1.0, { name="CatTable2", heading = 91.0, debugPoly=Config.Debug, minZ=21.49, maxZ=22.89 }, 
		{ options = { {  event = "jim-noodleexchange:Stash", icon = "fas fa-box-open", label = "Search Table", stash = "Table_2" }, }, distance = 2.0 })
	Targets["CatTable3"] =
	exports['lrp-target']:AddBoxZone("CatTable3", vector3(-573.41, -1067.09, 22.49), 1.9, 1.0, { name="CatTable3", heading = 91.0, debugPoly=Config.Debug, minZ=21.49, maxZ=22.89 }, 
		{ options = { {  event = "jim-noodleexchange:Stash", icon = "fas fa-box-open", label = "Search Table", stash = "Table_3" }, }, distance = 2.0 })
	Targets["CatTable4"] =
	exports['lrp-target']:AddBoxZone("CatTable4", vector3(-578.68, -1051.09, 22.35), 1.2, 0.9, { name="CatTable4", heading = 91.0, debugPoly=Config.Debug, minZ=21.49, maxZ=22.89 }, 
		{ options = { {  event = "jim-noodleexchange:Stash", icon = "fas fa-box-open", label = "Search Table", stash = "Table_4" }, }, distance = 2.0 })	
	]]--
	--Clockin
	Targets["CatClockin"] =
	exports['lrp-target']:AddBoxZone("CatClockin", vector3(-1242.09, -269.91, 37.77), 1.5, 0.75, { name="CatClockin", heading = 300, debugPoly=Config.Debug, minZ=37.75, maxZ=38.50 }, 
		{ options = { { type = "server", event = "QBCore:ToggleDuty", icon = "fas fa-user-check", label = "Toggle Duty", job = "noodleexchange" },
					  { event = "qb-bossmenu:client:OpenMenu", icon = "fas fa-list", label = "Open Bossmenu", job = bossroles, }, 
					}, distance = 2.0 })

	--[[
	Targets["CatBoss1"] =
	exports['lrp-target']:AddBoxZone("CatBoss1", vector3(-596.17, -1052.6, 22.34), 0.6, 0.6, { name="CatBoss1", heading = 0, debugPoly=Config.Debug, minZ=22.19, maxZ=23.79 }, 
		{ options = { { event = "qb-bossmenu:client:OpenMenu", icon = "fas fa-list", label = "Open Bossmenu", job = bossroles, }, 
					}, distance = 2.0 })
	]]--
end)

RegisterNetEvent("lrp-noodleexchange:bill", function()
    local bill = exports['lrp-input']:ShowInput({
        header = "Cash Register",
        submitText = "Charge Customer",
        inputs = {
            {
                type = 'number',
                name = 'id',
                text = 'Magic Number',
                isRequired = true

            },
            {
                type = 'number',
                name = 'amount',
                text = '$0.00',
                isRequired = true

            }
        }
    })
    if bill then
        if not bill.id or not bill.amount then return end
        TriggerServerEvent("lrp-noodleexchange:bill:player", bill.id, bill.amount)
    end
end)

RegisterNetEvent('jim-noodleexchange:washHands', function()
    QBCore.Functions.Progressbar('washing_hands', 'Washing hands', 5000, false, false, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
	{ animDict = "mp_arresting", anim = "a_uncuff", flags = 8, }, {}, {}, function()
		TriggerEvent('QBCore:Notify', "You've washed your hands!", 'success')
    end, function() -- Cancel
        TriggerEvent('inventory:client:busy:status', false)
		TriggerEvent('QBCore:Notify', "Cancelled", 'error')
    end, "fas fa-hand-holding-droplet")
end)

RegisterNetEvent('jim-noodleexchange:Stash', function(data) TriggerServerEvent("inventory:server:OpenInventory", "stash", "CatCafe_"..data.stash) TriggerEvent("inventory:client:SetCurrentStash", "CatCafe_"..data.stash) end)

RegisterNetEvent('jim-noodleexchange:Shop', function()
	if not jobCheck() then return end
	local event = "inventory:server:OpenInventory"
	if Config.JimShop then event = "jim-shops:ShopOpen" end
	TriggerServerEvent(event, "shop", "noodleexchange", Config.Items)
end)
RegisterNetEvent('jim-noodleexchange:Crafting:MakeItem', function(data)
	QBCore.Functions.TriggerCallback('jim-noodleexchange:Crafting:get', function(amount) 
		if not amount then TriggerEvent('QBCore:Notify', "You don't have the correct ingredients", 'error') else TriggerEvent('jim-noodleexchange:Crafting:ItemProgress', data) end		
	end, data.item, data.craft)
end)

RegisterNetEvent('jim-noodleexchange:Crafting:ItemProgress', function(data)
	if data.header == "Coffee Menu" then
		animDictNow = "mp_ped_interaction"
		animNow = "handshake_guy_a"
	elseif data.header == "Hob Menu" then
		animDictNow = "amb@prop_human_bbq@male@base"
		animNow = "base"
	elseif data.header == "Oven Menu" then
		animDictNow = "amb@prop_human_bbq@male@base"
		animNow = "base"
	elseif data.header == "Chopping Board" then
		animDictNow = "anim@heists@prison_heiststation@cop_reactions"
		animNow = "cop_b_idle"
	else
		animDictNow = "amb@prop_human_parking_meter@male@idle_a"
		animNow = "idle_a"
	end
	QBCore.Functions.Progressbar('making_food', "Making "..QBCore.Shared.Items[data.item].label, 5000, false, true,
	{ disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false, }, 
	{ animDict = animDictNow, anim = animNow, flags = 8, },
	{}, {}, function()  
		TriggerServerEvent('jim-noodleexchange:Crafting:GetItem', data.item, data.craft)
		TriggerEvent("jim-noodleexchange:Crafting", data)
	end, function() -- Cancel
		ClearPedTasks(PlayerPedId())
		TriggerEvent('inventory:client:busy:status', false)
	end, data.item)
end)

RegisterNetEvent('jim-noodleexchange:client:Menu:Close', function() exports['lrp-menu']:closeMenu() end)

RegisterNetEvent('jim-noodleexchange:Crafting', function(data)
	local Menu = {}
	Menu[#Menu + 1] = { header = data.header, txt = "", isMenuHeader = true }
	Menu[#Menu + 1] = { icon = "fas fa-circle-xmark", header = "", txt = "Close", params = { event = "jim-noodleexchange:client:Menu:Close" } }
	for i = 1, #data.craftable do
		for k, v in pairs(data.craftable[i]) do
			if k ~= "amount" then
				local text = ""
				setheader = "<img src=nui://"..Config.img..QBCore.Shared.Items[k].image.." width=35px onerror='this.onerror=null; this.remove();'>"..QBCore.Shared.Items[tostring(k)].label
				if data.craftable[i]["amount"] ~= nil then setheader = setheader.." x"..data.craftable[i]["amount"] end
				if Config.CheckMarks then
					local p = promise.new()
					QBCore.Functions.TriggerCallback('jim-noodleexchange:Crafting:get', function(cb) p:resolve(cb) end, k, data.craftable[i])
					if Citizen.Await(p) then setheader = setheader.." ✅" end
				end
				for l, b in pairs(data.craftable[i][tostring(k)]) do
					if b == 1 then number = "" else number = " x"..b end
					text = text.."- "..QBCore.Shared.Items[l].label..number.."<br>"
					settext = text
				end
				Menu[#Menu + 1] = { icon = k, header = setheader, txt = settext, params = { event = "jim-noodleexchange:Crafting:MakeItem", args = { item = k, craft = data.craftable[i], craftable = data.craftable, header = data.header } } }
				settext, setheader = nil
			end
		end Wait(0)
	end
	exports['lrp-menu']:openMenu(Menu)
end)

RegisterNetEvent('jim-noodleexchange:client:DrinkAlcohol', function(itemName)
	if itemName == "sake" then
		TriggerEvent('animations:client:EmoteCommandStart', {"uwu7"})
	else
		TriggerEvent('animations:client:EmoteCommandStart', {"flute"})
	end
    QBCore.Functions.Progressbar("snort_coke", "Drinking "..QBCore.Shared.Items[itemName].label.."..", math.random(3000, 6000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove", 1)
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
		if QBCore.Shared.Items[itemName].thirst then TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
		if QBCore.Shared.Items[itemName].hunger then TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end
        alcoholCount = alcoholCount + 1
        if alcoholCount > 1 and alcoholCount < 4 then
            TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
        elseif alcoholCount >= 4 then
            TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
			AlienEffect()
        end
        if Config.RewardItem == itemName then 
			local prize = Config.RewardPool[math.random(1, #Config.RewardPool)]
			TriggerServerEvent("QBCore:Server:AddItem", prize, 1)
			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[prize], "add", 1)
		end
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Cancelled..", "error")
	end, function() -- Cancel
	    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, itemName)
end)

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    local ped = PlayerPedId()
    RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK") 
    while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do Citizen.Wait(0) end
    SetPedCanRagdoll( ped, true )
    ShakeGameplayCam('DRUNK_SHAKE', 2.80)
    SetTimecycleModifier("Drunk")
    SetPedMovementClipset(ped, "MOVE_M@DRUNK@VERYDRUNK", true)
    SetPedMotionBlur(ped, true)
    SetPedIsDrunk(ped, true)
    Wait(1500)
    SetPedToRagdoll(ped, 5000, 1000, 1, false, false, false )
    Wait(13500)
    SetPedToRagdoll(ped, 5000, 1000, 1, false, false, false )
    Wait(120500)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(ped, 0)
    SetPedIsDrunk(ped, false)
    SetPedMotionBlur(ped, false)
    AnimpostfxStopAll()
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(45000, 60000))    
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end

RegisterNetEvent('jim-noodleexchange:client:Drink', function(itemName)
	if itemName == "bobatea" or itemName == "bbobatea" or itemName == "gbobatea" or itemName == "obobatea" or itemName == "pbobatea" then
		TriggerEvent('animations:client:EmoteCommandStart', {"uwu6"})
	elseif itemName == "nekolatte" then
		TriggerEvent('animations:client:EmoteCommandStart', {"uwu11"})
	elseif itemName == "mocha" then
		TriggerEvent('animations:client:EmoteCommandStart', {"uwu10"})
	elseif itemName == "catcoffee" then
		TriggerEvent('animations:client:EmoteCommandStart', {"uwu1"})
	else
		TriggerEvent('animations:client:EmoteCommandStart', {"coffee"})
	end
	QBCore.Functions.Progressbar("drink_something", "Drinking "..QBCore.Shared.Items[itemName].label.."..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove", 1)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
		if QBCore.Shared.Items[itemName].thirst then TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
		if QBCore.Shared.Items[itemName].hunger then TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end
		if not QBCore.Shared.Items[itemName].thirst and not QBCore.Shared.Items[itemName].hunger then
			TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + math.random(10,20))
		end
		if Config.RewardItem == itemName then 
			local prize = Config.RewardPool[math.random(1, #Config.RewardPool)]
			TriggerServerEvent("QBCore:Server:AddItem", prize, 1)
			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[prize], "add", 1)
		end
	end, function() -- Cancel
	    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, itemName)
end)

RegisterNetEvent('jim-noodleexchange:client:Eat', function(itemName)
	ExecuteCommand("e eat")
	QBCore.Functions.Progressbar("eat_something", "Eating "..QBCore.Shared.Items[itemName].label.."..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove", 1)
		TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        ExecuteCommand("e c")
		if QBCore.Shared.Items[itemName].thirst then TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
		if QBCore.Shared.Items[itemName].hunger then TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end
		if not QBCore.Shared.Items[itemName].thirst and not QBCore.Shared.Items[itemName].hunger then
			TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + math.random(10,20))
		end
        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
		if Config.RewardItem == itemName then 
			local prize = Config.RewardPool[math.random(1, #Config.RewardPool)]
			TriggerServerEvent("QBCore:Server:AddItem", prize, 1)
			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[prize], "add", 1)
		end
	end, function() -- Cancel
	    ExecuteCommand("e c")
    end, itemName)
end)

AddEventHandler('onResourceStop', function(resource) if resource ~= GetCurrentResourceName() then return end
	for k, v in pairs(Targets) do exports['lrp-target']:RemoveZone(k) end
end)