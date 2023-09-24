QBCore = exports['lrp-core']:GetCoreObject()
inside = false
closesthouse = nil
hasKey = false
contractOpen = false
local isOwned = false
local cam = nil
local FrontCam = false
local stashLocation = nil
local outfitLocation = nil
local logoutLocation = nil
local OwnedHouseBlips = {}
local UnownedHouseBlips = {}
local CurrentDoorBell = 0
local rangDoorbell = nil
local houseObj = {}
local POIOffsets = nil
local entering = false
local data = nil
local CurrentHouse = nil
local inHoldersMenu = false
local RamsDone = 0
local makepoly = true
local makeexitpoly = true
local viewingpoly = true
local notownedexitpoly = true
local bellpoly = true

-- Functions

local function DrawText3Ds(x, y, z, text)
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

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

local function openHouseAnim()
    loadAnimDict("anim@heists@keycard@")
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(400)
    ClearPedTasks(PlayerPedId())
end

local function openContract(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "toggle",
        status = bool,
    })
    contractOpen = bool
end

local function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())
    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end
	return closestPlayer, closestDistance
end

local function DoRamAnimation(bool)
    local ped = PlayerPedId()
    local dict = "missheistfbi3b_ig7"
    local anim = "lift_fibagent_loop"
    if bool then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(1)
        end
        TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 1, -1, false, false, false)
    else
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(1)
        end
        TaskPlayAnim(ped, dict, "exit", 8.0, 8.0, -1, 1, -1, false, false, false)
    end
end

local function InstructionButton(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

local function InstructionButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function CreateInstuctionScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    InstructionButton(GetControlInstructionalButton(1, 194, true))
    InstructionButtonMessage("Exit Camera")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

local function FrontDoorCam(coords)
    DoScreenFadeOut(150)
    Citizen.Wait(500)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z + 0.5, 0.0, 0.00, coords.h - 180, 80.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
    FrontCam = true
    FreezeEntityPosition(PlayerPedId(), true)
    Citizen.Wait(500)
    DoScreenFadeIn(150)
    SendNUIMessage({
        type = "frontcam",
        toggle = true,
        label = Config.Houses[closesthouse].adress
    })
    Citizen.CreateThread(function()
        while FrontCam do
            local instructions = CreateInstuctionScaleform("instructional_buttons")
            DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
            SetTimecycleModifier("scanline_cam_cheap")
            SetTimecycleModifierStrength(1.0)
            if IsControlJustPressed(1, 194) then -- Backspace
                DoScreenFadeOut(150)
                SendNUIMessage({
                    type = "frontcam",
                    toggle = false,
                })
                Citizen.Wait(500)
                RenderScriptCams(false, true, 500, true, true)
                FreezeEntityPosition(PlayerPedId(), false)
                SetCamActive(cam, false)
                DestroyCam(cam, true)
                ClearTimecycleModifier("scanline_cam_cheap")
                cam = nil
                FrontCam = false
                Citizen.Wait(500)
                DoScreenFadeIn(150)
            end

            local getCameraRot = GetCamRot(cam, 2)

            -- ROTATE UP
            if IsControlPressed(0, 32) then -- W
                if getCameraRot.x <= 0.0 then
                    SetCamRot(cam, getCameraRot.x + 0.7, 0.0, getCameraRot.z, 2)
                end
            end

            -- ROTATE DOWN
            if IsControlPressed(0, 33) then -- S
                if getCameraRot.x >= -50.0 then
                    SetCamRot(cam, getCameraRot.x - 0.7, 0.0, getCameraRot.z, 2)
                end
            end

            -- ROTATE LEFT
            if IsControlPressed(0, 34) then -- A
                SetCamRot(cam, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
            end

            -- ROTATE RIGHT
            if IsControlPressed(0, 35) then -- D
                SetCamRot(cam, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
            end

            Citizen.Wait(1)
        end
    end)
end

local function SetClosestHouse()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    if not inside then
        for id, house in pairs(Config.Houses) do
            local distcheck = #(pos - vector3(Config.Houses[id].coords.enter.x, Config.Houses[id].coords.enter.y, Config.Houses[id].coords.enter.z))
            if current ~= nil then
                if distcheck < dist then
                    current = id
                    dist = distcheck
                end
            else
                dist = distcheck
                current = id
            end
        end
        closesthouse = current
        if closesthouse ~= nil and tonumber(dist) < 30 then
            QBCore.Functions.TriggerCallback('qb-houses:server:ProximityKO', function(key, owned)
                hasKey = key
                isOwned = owned
            end, closesthouse)
        end
    end
    TriggerEvent('qb-garages:client:setHouseGarage', closesthouse, hasKey)
end

local function setHouseLocations()
    if closesthouse ~= nil then
        QBCore.Functions.TriggerCallback('qb-houses:server:getHouseLocations', function(result)
            if result ~= nil then
                if result.stash ~= nil then
                    stashLocation = json.decode(result.stash)
                end

                if result.outfit ~= nil then
                    outfitLocation = json.decode(result.outfit)
                end

                if result.logout ~= nil then
                    logoutLocation = json.decode(result.logout)
                end
            end
        end, closesthouse)
    end
end

local function UnloadDecorations()
	if ObjectList ~= nil then
		for k, v in pairs(ObjectList) do
			if DoesEntityExist(v.object) then
				DeleteObject(v.object)
			end
		end
	end
end

local function LoadDecorations(house)
	if Config.Houses[house].decorations == nil or next(Config.Houses[house].decorations) == nil then
		QBCore.Functions.TriggerCallback('qb-houses:server:getHouseDecorations', function(result)
			Config.Houses[house].decorations = result
			if Config.Houses[house].decorations ~= nil then
				ObjectList = {}
				for k, v in pairs(Config.Houses[house].decorations) do
					if Config.Houses[house].decorations[k] ~= nil then
						if Config.Houses[house].decorations[k].object ~= nil then
							if DoesEntityExist(Config.Houses[house].decorations[k].object) then
								DeleteObject(Config.Houses[house].decorations[k].object)
							end
						end
						local modelHash = GetHashKey(Config.Houses[house].decorations[k].hashname)
						RequestModel(modelHash)
						while not HasModelLoaded(modelHash) do
							Citizen.Wait(10)
						end
						local decorateObject = CreateObject(modelHash, Config.Houses[house].decorations[k].x, Config.Houses[house].decorations[k].y, Config.Houses[house].decorations[k].z, false, false, false)
						SetEntityRotation(decorateObject, Config.Houses[house].decorations[k].rotx, Config.Houses[house].decorations[k].roty, Config.Houses[house].decorations[k].rotz)
						ObjectList[Config.Houses[house].decorations[k].objectId] = {hashname = Config.Houses[house].decorations[k].hashname, x = Config.Houses[house].decorations[k].x, y = Config.Houses[house].decorations[k].y, z = Config.Houses[house].decorations[k].z, rotx = Config.Houses[house].decorations[k].rotx, roty = Config.Houses[house].decorations[k].roty, rotz = Config.Houses[house].decorations[k].rotz, object = decorateObject, objectId = Config.Houses[house].decorations[k].objectId}
						FreezeEntityPosition(decorateObject, true)
					end
				end
			end
		end, house)
	elseif Config.Houses[house].decorations ~= nil then
		ObjectList = {}
		for k, v in pairs(Config.Houses[house].decorations) do
			if Config.Houses[house].decorations[k] ~= nil then
				if Config.Houses[house].decorations[k].object ~= nil then
					if DoesEntityExist(Config.Houses[house].decorations[k].object) then
						DeleteObject(Config.Houses[house].decorations[k].object)
					end
				end
				local modelHash = GetHashKey(Config.Houses[house].decorations[k].hashname)
				RequestModel(modelHash)
				while not HasModelLoaded(modelHash) do
					Citizen.Wait(10)
				end
				local decorateObject = CreateObject(modelHash, Config.Houses[house].decorations[k].x, Config.Houses[house].decorations[k].y, Config.Houses[house].decorations[k].z, false, false, false)
				Config.Houses[house].decorations[k].object = decorateObject
				SetEntityRotation(decorateObject, Config.Houses[house].decorations[k].rotx, Config.Houses[house].decorations[k].roty, Config.Houses[house].decorations[k].rotz)
				ObjectList[Config.Houses[house].decorations[k].objectId] = {hashname = Config.Houses[house].decorations[k].hashname, x = Config.Houses[house].decorations[k].x, y = Config.Houses[house].decorations[k].y, z = Config.Houses[house].decorations[k].z, rotx = Config.Houses[house].decorations[k].rotx, roty = Config.Houses[house].decorations[k].roty, rotz = Config.Houses[house].decorations[k].rotz, object = decorateObject, objectId = Config.Houses[house].decorations[k].objectId}
				FreezeEntityPosition(decorateObject, true)
			end
		end
	end
end

-- GUI Functions

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    inHoldersMenu = false
    ClearMenu()
end

function ClearMenu()
	Menu.GUI = {}
	Menu.buttonCount = 0
	Menu.selection = 0
end

function removeHouseKey(citizenData)
    TriggerServerEvent('qb-houses:server:removeHouseKey', closesthouse, citizenData)
    closeMenuFull()
end

function HouseKeysMenu()
    ped = PlayerPedId();
    MenuTitle = "Sleutels"
    ClearMenu()
    QBCore.Functions.TriggerCallback('qb-houses:server:getHouseKeyHolders', function(holders)
        ped = PlayerPedId();
        MenuTitle = "Sleutelhouders:"
        ClearMenu()
        if holders == nil or next(holders) == nil then
            QBCore.Functions.Notify("No key holders found..", "error", 3500)
            closeMenuFull()
        else
            for k, v in pairs(holders) do
                Menu.addButton(holders[k].firstname .. " " .. holders[k].lastname, "optionMenu", holders[k])
            end
        end
        Menu.addButton("Exit Menu", "closeMenuFull", nil)
    end, closesthouse)
end

function optionMenu(citizenData)
    ped = PlayerPedId();
    MenuTitle = "What now?"
    ClearMenu()
    Menu.addButton("Remove key", "removeHouseKey", citizenData)
    Menu.addButton("Back", "HouseKeysMenu",nil)
end

-- Shell Configuration

local function getDataForHouseTier(house, coords)
    if Config.Houses[house].tier == 1 then
        return exports['lrp-interior']:CreateApartmentShell(coords)
    elseif Config.Houses[house].tier == 2 then
        return exports['lrp-interior']:CreateTier1House(coords)
    elseif Config.Houses[house].tier == 3 then
        return exports['lrp-interior']:CreateTrevorsShell(coords)
    elseif Config.Houses[house].tier == 4 then
        return exports['lrp-interior']:CreateCaravanShell(coords)
    elseif Config.Houses[house].tier == 5 then
        return exports['lrp-interior']:CreateLesterShell(coords)
    elseif Config.Houses[house].tier == 6 then
        return exports['lrp-interior']:CreateRanchShell(coords)
    -- Warehouse Shells (addon) https://k4mb1.tebex.io/package/4673185
    --[[
    elseif Config.Houses[house].tier == 7 then
        return exports['lrp-interior']:CreateWarehouse1(coords)
    elseif Config.Houses[house].tier == 8 then
        return exports['lrp-interior']:CreateWarehouse2(coords)
    elseif Config.Houses[house].tier == 9 then
        return exports['lrp-interior']:CreateWarehouse3(coords)
    ]]--
    -- Highend Shells (addon) https://k4mb1.tebex.io/package/4673131
    elseif Config.Houses[house].tier == 7 then
        return exports['lrp-interior']:CreateHighend1(coords)
    elseif Config.Houses[house].tier == 8 then
        return exports['lrp-interior']:CreateHighend2(coords)
    elseif Config.Houses[house].tier == 9 then
        return exports['lrp-interior']:CreateHighend3(coords)
    -- Deluxe Shells (addon) https://k4mb1.tebex.io/package/4673159
    elseif Config.Houses[house].tier == 10 then
        return exports['lrp-interior']:CreateHighend(coords)
    elseif Config.Houses[house].tier == 11 then
        return exports['lrp-interior']:CreateHighendV2(coords)
    elseif Config.Houses[house].tier == 12 then
        return exports['lrp-interior']:CreateMichael(coords)
    -- Office Shells (addon) https://k4mb1.tebex.io/package/4673258
    elseif Config.Houses[house].tier == 16 then
        return exports['lrp-interior']:CreateOffice2(coords)
    elseif Config.Houses[house].tier == 17 then
        return exports['lrp-interior']:CreateOfficeBig(coords)
    -- Store Shells (addon) https://k4mb1.tebex.io/package/4673264
    --[[
    elseif Config.Houses[house].tier == 18 then
        return exports['lrp-interior']:CreateBarber(coords)
    elseif Config.Houses[house].tier == 19 then
        return exports['lrp-interior']:CreateGunstore(coords)
    elseif Config.Houses[house].tier == 20 then
        return exports['lrp-interior']:CreateStore1(coords)
    elseif Config.Houses[house].tier == 21 then
        return exports['lrp-interior']:CreateStore2(coords)
    elseif Config.Houses[house].tier == 22 then
        return exports['lrp-interior']:CreateStore3(coords)
    ]]--
    -- Medium Housing Shells (addon) https://k4mb1.tebex.io/package/4672307
    elseif Config.Houses[house].tier == 13 then
        return exports['lrp-interior']:CreateFranklinAunt(coords)
    elseif Config.Houses[house].tier == 14 then
        return exports['lrp-interior']:CreateMedium2(coords)
    elseif Config.Houses[house].tier == 15 then
        return exports['lrp-interior']:CreateMedium3(coords)
    -- Drug Lab Shells (addon) https://k4mb1.tebex.io/package/4672285
    --[[
    elseif Config.Houses[house].tier == 26 then
        return exports['lrp-interior']:CreateCoke(coords)
    elseif Config.Houses[house].tier == 27 then
        return exports['lrp-interior']:CreateCoke2(coords)
    elseif Config.Houses[house].tier == 28 then
        return exports['lrp-interior']:CreateMeth(coords)
    elseif Config.Houses[house].tier == 29 then
        return exports['lrp-interior']:CreateWeed2(coords)
    ]]--
    -- Garage Shells (addon) https://k4mb1.tebex.io/package/4673177
    --[[
    elseif Config.Houses[house].tier == 30 then
        return exports['lrp-interior']:CreateGarageLow(coords)
    elseif Config.Houses[house].tier == 31 then
        return exports['lrp-interior']:CreateGarageMed(coords)
    elseif Config.Houses[house].tier == 32 then
        return exports['lrp-interior']:CreateGarageHigh(coords)
    ]]--
    else
        QBCore.Functions.Notify('Invalid house tier', 'error')
    end
end

-- If you are using paid shells the comment function above and uncomment this or grab the ones you need

-- local function getDataForHouseTier(house, coords)
--     if Config.Houses[house].tier == 1 then
--         return exports['lrp-interior']:CreateApartmentShell(coords)
--     elseif Config.Houses[house].tier == 2 then
--         return exports['lrp-interior']:CreateTier1House(coords)
--     elseif Config.Houses[house].tier == 3 then
--         return exports['lrp-interior']:CreateTrevorsShell(coords)
--     elseif Config.Houses[house].tier == 4 then
--         return exports['lrp-interior']:CreateCaravanShell(coords)
--     elseif Config.Houses[house].tier == 5 then
--         return exports['lrp-interior']:CreateLesterShell(coords)
--     elseif Config.Houses[house].tier == 6 then
--         return exports['lrp-interior']:CreateRanchShell(coords)
--     elseif Config.Houses[house].tier == 7 then
--         return exports['lrp-interior']:CreateFranklinAunt(coords)
--     elseif Config.Houses[house].tier == 8 then
--         return exports['lrp-interior']:CreateMedium2(coords)
--     elseif Config.Houses[house].tier == 9 then
--         return exports['lrp-interior']:CreateMedium3(coords)
--     elseif Config.Houses[house].tier == 10 then
--         return exports['lrp-interior']:CreateBanham(coords)
--     elseif Config.Houses[house].tier == 11 then
--         return exports['lrp-interior']:CreateWestons(coords)
--     elseif Config.Houses[house].tier == 12 then
--         return exports['lrp-interior']:CreateWestons2(coords)
--     elseif Config.Houses[house].tier == 13 then
--         return exports['lrp-interior']:CreateClassicHouse(coords)
--     elseif Config.Houses[house].tier == 14 then
--         return exports['lrp-interior']:CreateClassicHouse2(coords)
--     elseif Config.Houses[house].tier == 15 then
--         return exports['lrp-interior']:CreateClassicHouse3(coords)
--     elseif Config.Houses[house].tier == 16 then
--         return exports['lrp-interior']:CreateHighend1(coords)
--     elseif Config.Houses[house].tier == 17 then
--         return exports['lrp-interior']:CreateHighend2(coords)
--     elseif Config.Houses[house].tier == 18 then
--         return exports['lrp-interior']:CreateHighend3(coords)
--     elseif Config.Houses[house].tier == 19 then
--         return exports['lrp-interior']:CreateHighend(coords)
--     elseif Config.Houses[house].tier == 20 then
--         return exports['lrp-interior']:CreateHighendV2(coords)
--     elseif Config.Houses[house].tier == 21 then
--         return exports['lrp-interior']:CreateMichael(coords)
--     elseif Config.Houses[house].tier == 22 then
--         return exports['lrp-interior']:CreateStashHouse(coords)
--     elseif Config.Houses[house].tier == 23 then
--         return exports['lrp-interior']:CreateStashHouse2(coords)
--     elseif Config.Houses[house].tier == 24 then
--         return exports['lrp-interior']:CreateContainer(coords)
--     elseif Config.Houses[house].tier == 25 then
--         return exports['lrp-interior']:CreateGarageLow(coords)
--     elseif Config.Houses[house].tier == 26 then
--         return exports['lrp-interior']:CreateGarageMed(coords)
--     elseif Config.Houses[house].tier == 27 then
--         return exports['lrp-interior']:CreateGarageHigh(coords)
--     elseif Config.Houses[house].tier == 28 then
--         return exports['lrp-interior']:CreateOffice1(coords)
--     elseif Config.Houses[house].tier == 29 then
--         return exports['lrp-interior']:CreateOffice2(coords)
--     elseif Config.Houses[house].tier == 30 then
--         return exports['lrp-interior']:CreateOfficeBig(coords)
--     elseif Config.Houses[house].tier == 31 then
--         return exports['lrp-interior']:CreateBarber(coords)
--     elseif Config.Houses[house].tier == 32 then
--         return exports['lrp-interior']:CreateGunstore(coords)
--     elseif Config.Houses[house].tier == 33 then
--         return exports['lrp-interior']:CreateStore1(coords)
--     elseif Config.Houses[house].tier == 34 then
--         return exports['lrp-interior']:CreateStore2(coords)
--     elseif Config.Houses[house].tier == 35 then
--         return exports['lrp-interior']:CreateStore3(coords)
--     elseif Config.Houses[house].tier == 36 then
--         return exports['lrp-interior']:CreateWarehouse1(coords)
--     elseif Config.Houses[house].tier == 37 then
--         return exports['lrp-interior']:CreateWarehouse2(coords)
--     elseif Config.Houses[house].tier == 38 then
--         return exports['lrp-interior']:CreateWarehouse3(coords)
--     elseif Config.Houses[house].tier == 39 then
--         return exports['lrp-interior']:CreateK4Coke(coords)
--     elseif Config.Houses[house].tier == 40 then
--         return exports['lrp-interior']:CreateK4Meth(coords)
--     elseif Config.Houses[house].tier == 41 then
--         return exports['lrp-interior']:CreateK4Weed(coords)
--     elseif Config.Houses[house].tier == 42 then
--         return exports['lrp-interior']:CreateContainer2(coords)
--     elseif Config.Houses[house].tier == 43 then
--         return exports['lrp-interior']:CreateFurniStash1(coords)
--     elseif Config.Houses[house].tier == 44 then
--         return exports['lrp-interior']:CreateFurniStash3(coords)
--     elseif Config.Houses[house].tier == 45 then
--         return exports['lrp-interior']:CreateFurniLow(coords)
--     elseif Config.Houses[house].tier == 46 then
--         return exports['lrp-interior']:CreateFurniMid(coords)
--     elseif Config.Houses[house].tier == 47 then
--         return exports['lrp-interior']:CreateFurniMotel(coords)
--     elseif Config.Houses[house].tier == 48 then
--         return exports['lrp-interior']:CreateFurniMotelClassic(coords)
--     elseif Config.Houses[house].tier == 49 then
--         return exports['lrp-interior']:CreateFurniMotelStandard(coords)
--     elseif Config.Houses[house].tier == 50 then
--         return exports['lrp-interior']:CreateFurniMotelHigh(coords)
--     elseif Config.Houses[house].tier == 51 then
--         return exports['lrp-interior']:CreateFurniMotelModern(coords)
--     elseif Config.Houses[house].tier == 52 then
--         return exports['lrp-interior']:CreateFurniMotelModern2(coords)
--     elseif Config.Houses[house].tier == 53 then
--         return exports['lrp-interior']:CreateFurniMotelModern3(coords)
--     elseif Config.Houses[house].tier == 54 then
--         return exports['lrp-interior']:CreateCoke(coords)
--     elseif Config.Houses[house].tier == 55 then
--         return exports['lrp-interior']:CreateCoke2(coords)
--     elseif Config.Houses[house].tier == 56 then
--         return exports['lrp-interior']:CreateMeth(coords)
--     elseif Config.Houses[house].tier == 57 then
--         return exports['lrp-interior']:CreateWeed(coords)
--     elseif Config.Houses[house].tier == 58 then
--         return exports['lrp-interior']:CreateWeed2(coords)
--     else
--         QBCore.Functions.Notify('Invalid House Tier', 'error')
--     end
-- end

local function enterOwnedHouse(house)
    CurrentHouse = house
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    openHouseAnim()
    inside = true
    Citizen.Wait(250)
    local coords = { x = Config.Houses[house].coords.enter.x, y = Config.Houses[house].coords.enter.y, z= Config.Houses[house].coords.enter.z - Config.MinZOffset}
    LoadDecorations(house)
    data = getDataForHouseTier(house, coords)
    Citizen.Wait(100)
    houseObj = data[1]
    POIOffsets = data[2]
    entering = true
    Citizen.Wait(500)
    TriggerServerEvent('qb-houses:server:SetInsideMeta', house, true)
    TriggerEvent('qb-weathersync:client:DisableSync')
    TriggerEvent('qb-weed:client:getHousePlants', house)
    entering = false
    setHouseLocations()
end

local function leaveOwnedHouse(house)
    if not FrontCam then
        inside = false
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
        openHouseAnim()
        Citizen.Wait(250)
        DoScreenFadeOut(250)
        Citizen.Wait(500)
        exports['lrp-interior']:DespawnInterior(houseObj, function()
            UnloadDecorations()
            TriggerEvent('qb-weathersync:client:EnableSync')
            Citizen.Wait(250)
            DoScreenFadeIn(250)
            SetEntityCoords(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.x, Config.Houses[CurrentHouse].coords.enter.y, Config.Houses[CurrentHouse].coords.enter.z + 0.2)
            SetEntityHeading(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.h)
            TriggerEvent('qb-weed:client:leaveHouse')
            TriggerServerEvent('qb-houses:server:SetInsideMeta', house, false)
            CurrentHouse = nil
        end)
    end
end

local function enterNonOwnedHouse(house)
    CurrentHouse = house
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    openHouseAnim()
    inside = true
    Citizen.Wait(250)
    local coords = { x = Config.Houses[closesthouse].coords.enter.x, y = Config.Houses[closesthouse].coords.enter.y, z= Config.Houses[closesthouse].coords.enter.z - Config.MinZOffset}
    LoadDecorations(house)
    data = getDataForHouseTier(house, coords)
    houseObj = data[1]
    POIOffsets = data[2]
    entering = true
    Citizen.Wait(500)
    TriggerServerEvent('qb-houses:server:SetInsideMeta', house, true)
    TriggerEvent('qb-weathersync:client:DisableSync')
    TriggerEvent('qb-weed:client:getHousePlants', house)
    entering = false
    inOwned = true
    setHouseLocations()
end

local function leaveNonOwnedHouse(house)
    if not FrontCam then
        viewingpoly = true
        inside = false
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
        openHouseAnim()
        Citizen.Wait(250)
        DoScreenFadeOut(250)
        Citizen.Wait(500)
        exports['lrp-interior']:DespawnInterior(houseObj, function()
            UnloadDecorations()
            TriggerEvent('qb-weathersync:client:EnableSync')
            Citizen.Wait(250)
            DoScreenFadeIn(250)
            SetEntityCoords(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.x, Config.Houses[CurrentHouse].coords.enter.y, Config.Houses[CurrentHouse].coords.enter.z + 0.2)
            SetEntityHeading(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.h)
            inOwned = false
            TriggerEvent('qb-weed:client:leaveHouse')
            TriggerServerEvent('qb-houses:server:SetInsideMeta', house, false)
            CurrentHouse = nil
        end)
    end
end

-- Events

RegisterNetEvent('qb-houses:server:sethousedecorations', function(house, decorations)
	Config.Houses[house].decorations = decorations
	if inside and closesthouse == house then
		LoadDecorations(house)
	end
end)

RegisterNetEvent('qb-houses:client:sellHouse', function()
    if closesthouse and hasKey then
        TriggerServerEvent('qb-houses:server:viewHouse', closesthouse)
    end
end)

RegisterNetEvent('qb-houses:client:EnterHouse', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    viewingpoly = false
    exports['lrp-target']:RemoveZone("Viewing")
    if closesthouse ~= nil then
        local dist = #(pos - vector3(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z))
        if dist < 1.5 then
            if hasKey then
                enterOwnedHouse(closesthouse)
            else
                enterNonOwnedHouse(closesthouse)
            end
        end
    end
end)

RegisterNetEvent('qb-houses:client:RequestRing', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    if closesthouse ~= nil then
        TriggerServerEvent('qb-houses:server:RingDoor', closesthouse)
    end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('qb-houses:client:setHouses')
    SetClosestHouse()
    TriggerEvent('qb-houses:client:setupHouseBlips')
    if Config.UnownedBlips then TriggerEvent('qb-houses:client:setupHouseBlips2') end
    Citizen.Wait(100)
    TriggerEvent('qb-garages:client:setHouseGarage', closesthouse, hasKey)
    TriggerServerEvent("qb-houses:server:setHouses")
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    inside = false
    closesthouse = nil
    hasKey = false
    isOwned = false
    for k, v in pairs(OwnedHouseBlips) do
        RemoveBlip(v)
    end
    if Config.UnownedBlips then
        for k,v in pairs(UnownedHouseBlips) do
            RemoveBlip(v)
        end
    end
end)

RegisterNetEvent('qb-houses:client:setHouseConfig', function(houseConfig)
    Config.Houses = houseConfig
end)

RegisterNetEvent('qb-houses:client:lockHouse', function(bool, house)
    Config.Houses[house].locked = bool
end)

RegisterNetEvent('qb-houses:client:createHouses', function(price, tier)
    local pos = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())
    local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    local street = GetStreetNameFromHashKey(s1)
    local coords = {
        enter 	= { x = pos.x, y = pos.y, z = pos.z, h = heading},
        cam 	= { x = pos.x, y = pos.y, z = pos.z, h = heading, yaw = -10.00},
    }
    street = street:gsub("%-", " ")
    TriggerServerEvent('qb-houses:server:addNewHouse', street, coords, price, tier)
    if Config.UnownedBlips then TriggerServerEvent('qb-houses:server:createBlip') end
end)

RegisterNetEvent('qb-houses:client:addGarage', function()
    if closesthouse ~= nil then
        local pos = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        local coords = {
            x = pos.x,
            y = pos.y,
            z = pos.z,
            h = heading,
        }
        TriggerServerEvent('qb-houses:server:addGarage', closesthouse, coords)
    else
        QBCore.Functions.Notify("No house around..", "error")
    end
end)

RegisterNetEvent('qb-houses:client:toggleDoorlock', function()
    local pos = GetEntityCoords(PlayerPedId())
    local dist = #(pos - vector3(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z))
    if dist < 1.5 then
        if hasKey then
            if Config.Houses[closesthouse].locked then
                TriggerServerEvent('qb-houses:server:lockHouse', false, closesthouse)
                QBCore.Functions.Notify("House is unlocked!", "success", 2500)
            else
                TriggerServerEvent('qb-houses:server:lockHouse', true, closesthouse)
                QBCore.Functions.Notify("House is locked!", "error", 2500)
            end
        else
            QBCore.Functions.Notify("You don't have the keys of the house...", "error", 3500)
        end
    else
        QBCore.Functions.Notify("There is no door nearby", "error", 3500)
    end
end)

RegisterNetEvent('qb-houses:client:RingDoor', function(player, house)
    if closesthouse == house and inside then
        CurrentDoorBell = player
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "doorbell", 0.1)
        QBCore.Functions.Notify("Someone is ringing the door!")
    end
end)

RegisterNetEvent('qb-houses:client:giveHouseKey', function(data)
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 and closesthouse ~= nil then
        local playerId = GetPlayerServerId(player)
        local pedpos = GetEntityCoords(PlayerPedId())
        local housedist = #(pedpos - vector3(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z))
        if housedist < 10 then
            TriggerServerEvent('qb-houses:server:giveHouseKey', playerId, closesthouse)
        else
            QBCore.Functions.Notify("You're not close enough to the door..", "error")
        end
    elseif closesthouse == nil then
        QBCore.Functions.Notify("There is no house near you", "error")
    else
        QBCore.Functions.Notify("No one around!", "error")
    end
end)

RegisterNetEvent('qb-houses:client:removeHouseKey', function(data)
    if closesthouse ~= nil then
        local pedpos = GetEntityCoords(PlayerPedId())
        local housedist = #(pedpos - vector3(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z))
        if housedist < 5 then
            QBCore.Functions.TriggerCallback('qb-houses:server:getHouseOwner', function(result)
                if QBCore.Functions.GetPlayerData().citizenid == result then
                    inHoldersMenu = true
                    HouseKeysMenu()
                    Menu.hidden = not Menu.hidden
                else
                    QBCore.Functions.Notify("You're not a house owner..", "error")
                end
            end, closesthouse)
        else
            QBCore.Functions.Notify("You're not close enough to the door..", "error")
        end
    else
        QBCore.Functions.Notify("You're not close enough to the door..", "error")
    end
end)

RegisterNetEvent('qb-houses:client:refreshHouse', function(data)
    Citizen.Wait(100)
    SetClosestHouse()
end)

RegisterNetEvent('qb-houses:client:SpawnInApartment', function(house)
    local pos = GetEntityCoords(PlayerPedId())
    if rangDoorbell ~= nil then
        if #(pos - vector3(Config.Houses[house].coords.enter.x, Config.Houses[house].coords.enter.y, Config.Houses[house].coords.enter.z)) > 100000 then
            return
        end
    end
    closesthouse = house
    enterNonOwnedHouse(house)
end)

RegisterNetEvent('qb-houses:client:enterOwnedHouse', function(house)
    QBCore.Functions.GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] == 0 then
			enterOwnedHouse(house)
		end
	end)
end)

RegisterNetEvent('qb-houses:client:LastLocationHouse', function(houseId)
    QBCore.Functions.GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] == 0 then
			enterOwnedHouse(houseId)
		end
	end)
end)

RegisterNetEvent('qb-houses:client:setupHouseBlips', function() -- Setup owned on load
    Citizen.CreateThread(function()
        Citizen.Wait(2000)
        if LocalPlayer.state['isLoggedIn'] then
            QBCore.Functions.TriggerCallback('qb-houses:server:getOwnedHouses', function(ownedHouses)
                if ownedHouses then
                    for k, v in pairs(ownedHouses) do
                        local house = Config.Houses[ownedHouses[k]]
                        HouseBlip = AddBlipForCoord(house.coords.enter.x, house.coords.enter.y, house.coords.enter.z)
                        SetBlipSprite (HouseBlip, 40)
                        SetBlipDisplay(HouseBlip, 4)
                        SetBlipScale  (HouseBlip, 0.65)
                        SetBlipAsShortRange(HouseBlip, true)
                        SetBlipColour(HouseBlip, 3)
                        AddTextEntry('OwnedHouse', house.adress)
                        BeginTextCommandSetBlipName('OwnedHouse')
                        EndTextCommandSetBlipName(HouseBlip)
                        OwnedHouseBlips[#OwnedHouseBlips+1] = HouseBlip
                    end
                end
            end)
        end
    end)
end)

RegisterNetEvent('qb-houses:client:setupHouseBlips2', function() -- Setup unowned on load
    for k,v in pairs(Config.Houses) do
        if not v.owned then
            HouseBlip2 = AddBlipForCoord(v.coords.enter.x, v.coords.enter.y, v.coords.enter.z)
            SetBlipSprite (HouseBlip2, 40)
            SetBlipDisplay(HouseBlip2, 4)
            SetBlipScale  (HouseBlip2, 0.65)
            SetBlipAsShortRange(HouseBlip2, true)
            SetBlipColour(HouseBlip2, 3)
            AddTextEntry('UnownedHouse', 'House For Sale')
            BeginTextCommandSetBlipName('UnownedHouse')
            EndTextCommandSetBlipName(HouseBlip2)
            UnownedHouseBlips[#UnownedHouseBlips+1] = HouseBlip2
        end
    end
end)

RegisterNetEvent('qb-houses:client:createBlip', function(coords) -- Create unowned on command
    NewHouseBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite (NewHouseBlip, 40)
    SetBlipDisplay(NewHouseBlip, 4)
    SetBlipScale  (NewHouseBlip, 0.65)
    SetBlipAsShortRange(NewHouseBlip, true)
    SetBlipColour(NewHouseBlip, 3)
    AddTextEntry('NewHouseBlip', 'House For Sale')
    BeginTextCommandSetBlipName('NewHouseBlip')
    EndTextCommandSetBlipName(NewHouseBlip)
    UnownedHouseBlips[#UnownedHouseBlips+1] = NewHouseBlip
end)

RegisterNetEvent('qb-houses:client:refreshBlips', function() -- Refresh unowned on buy
    for k,v in pairs(UnownedHouseBlips) do RemoveBlip(v) end
    Wait(250)
    TriggerEvent('qb-houses:client:setupHouseBlips2')
end)

RegisterNetEvent('qb-houses:client:SetClosestHouse', function()
    SetClosestHouse()
end)

RegisterNetEvent('qb-houses:client:viewHouse', function(houseprice, brokerfee, bankfee, taxes, firstname, lastname)
    Citizen.Wait(500)
    openContract(true)
    SendNUIMessage({
        type = "setupContract",
        firstname = firstname,
        lastname = lastname,
        street = Config.Houses[closesthouse].adress,
        houseprice = houseprice,
        brokerfee = brokerfee,
        bankfee = bankfee,
        taxes = taxes,
        totalprice = (houseprice + brokerfee + bankfee + taxes)
    })
end)

RegisterNetEvent('qb-houses:client:setLocation', function(data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local coords = {x = pos.x, y = pos.y, z = pos.z}
    if inside then
        if hasKey then
            if data.id == 'setstash' then
                TriggerServerEvent('qb-houses:server:setLocation', coords, closesthouse, 1)
            elseif data.id == 'setoutift' then
                TriggerServerEvent('qb-houses:server:setLocation', coords, closesthouse, 2)
            elseif data.id == 'setlogout' then
                TriggerServerEvent('qb-houses:server:setLocation', coords, closesthouse, 3)
            end
        else
            QBCore.Functions.Notify('You do not own this house', 'error')
        end
    else
        QBCore.Functions.Notify('You are not in a house', 'error')
    end
end)

RegisterNetEvent('qb-houses:client:refreshLocations', function(house, location, type)
    if closesthouse == house then
        if inside then
            if type == 1 then
                stashLocation = json.decode(location)
            elseif type == 2 then
                outfitLocation = json.decode(location)
            elseif type == 3 then
                logoutLocation = json.decode(location)
            end
        end
    end
end)

RegisterNetEvent('qb-houses:client:HomeInvasion', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local Skillbar = exports['lrp-skillbar']:GetSkillbarObject()
    if closesthouse ~= nil then
        QBCore.Functions.TriggerCallback('police:server:IsPoliceForcePresent', function(IsPresent)
            if IsPresent then
                local dist = #(pos - vector3(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z))
                if Config.Houses[closesthouse].IsRaming == nil then
                    Config.Houses[closesthouse].IsRaming = false
                end
                if dist < 1 then
                    if Config.Houses[closesthouse].locked then
                        if not Config.Houses[closesthouse].IsRaming then
                            DoRamAnimation(true)
                            Skillbar.Start({
                                duration = math.random(5000, 10000),
                                pos = math.random(10, 30),
                                width = math.random(10, 20),
                            }, function()
                                if RamsDone + 1 >= Config.RamsNeeded then
                                    TriggerServerEvent('qb-houses:server:lockHouse', false, closesthouse)
                                    QBCore.Functions.Notify('It worked the door is now out.', 'success')
                                    TriggerServerEvent('qb-houses:server:SetHouseRammed', true, closesthouse)
                                    DoRamAnimation(false)
                                else
                                    DoRamAnimation(true)
                                    Skillbar.Repeat({
                                        duration = math.random(500, 1000),
                                        pos = math.random(10, 30),
                                        width = math.random(5, 12),
                                    })
                                    RamsDone = RamsDone + 1
                                end
                            end, function()
                                RamsDone = 0
                                TriggerServerEvent('qb-houses:server:SetRamState', false, closesthouse)
                                QBCore.Functions.Notify('It failed try again.', 'error')
                                DoRamAnimation(false)
                            end)
                            TriggerServerEvent('qb-houses:server:SetRamState', true, closesthouse)
                        else
                            QBCore.Functions.Notify('Someone is already working on the door..', 'error')
                        end
                    else
                        QBCore.Functions.Notify('19/5000 This house is already open..', 'error')
                    end
                else
                    QBCore.Functions.Notify('You\'re not near a house..', 'error')
                end
            else
                QBCore.Functions.Notify('There is no police force present..', 'error')
            end
        end)
    else
        QBCore.Functions.Notify('You\'re not near a house..', 'error')
    end
end)

RegisterNetEvent('qb-houses:client:SetRamState', function(bool, house)
    Config.Houses[house].IsRaming = bool
end)

RegisterNetEvent('qb-houses:client:SetHouseRammed', function(bool, house)
    Config.Houses[house].IsRammed = bool
end)

RegisterNetEvent('qb-houses:client:ResetHouse', function()
    if closesthouse ~= nil then
        if Config.Houses[closesthouse].IsRammed == nil then
            Config.Houses[closesthouse].IsRammed = false
            TriggerServerEvent('qb-houses:server:SetHouseRammed', false, closesthouse)
            TriggerServerEvent('qb-houses:server:SetRamState', false, closesthouse)
        end
        if Config.Houses[closesthouse].IsRammed then
            openHouseAnim()
            TriggerServerEvent('qb-houses:server:SetHouseRammed', false, closesthouse)
            TriggerServerEvent('qb-houses:server:SetRamState', false, closesthouse)
            TriggerServerEvent('qb-houses:server:lockHouse', true, closesthouse)
            RamsDone = 0
            QBCore.Functions.Notify('You locked the house again..', 'success')
        else
            QBCore.Functions.Notify('This door is not broken open ..', 'error')
        end
    end
end)

-- NUI Callbacks

RegisterNUICallback('HasEnoughMoney', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-houses:server:HasEnoughMoney', function(hasEnough)
    end, data.objectData)
end)

RegisterNUICallback('buy', function()
    openContract(false)
    exports['lrp-target']:RemoveZone("Viewing")
    Config.Houses[closesthouse].owned = true
    if Config.UnownedBlips then TriggerEvent('qb-houses:client:refreshBlips') end
    TriggerServerEvent('qb-houses:server:buyHouse', closesthouse)
end)

RegisterNUICallback('exit', function()
    openContract(false)
end)

-- Threads

Citizen.CreateThread(function()
    Wait(1000)
    TriggerServerEvent('qb-houses:client:setHouses')
    SetClosestHouse()
    TriggerEvent('qb-houses:client:setupHouseBlips')
    if Config.UnownedBlips then TriggerEvent('qb-houses:client:setupHouseBlips2') end
    Citizen.Wait(100)
    TriggerEvent('qb-garages:client:setHouseGarage', closesthouse, hasKey)
    TriggerServerEvent("qb-houses:server:setHouses")
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if LocalPlayer.state['isLoggedIn'] then
            if not inside then
                SetClosestHouse()
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if inHoldersMenu then
            Menu.renderGUI()
        end
    end
end)

--local mathname

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
        local inRange = false
        if closesthouse ~= nil then
            local dist2 = vector3(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z)
            if #(pos.xy - dist2.xy) < 30 then
                inRange = true
                if hasKey then
                    -- ENTER HOUSE
                    if not inside then
                        if closesthouse ~= nil then
                            if #(pos - dist2) < 3 and makepoly then                                                              
                                makepoly = false 
                                --mathname = math.random(1,1000)
                                exports['lrp-target']:RemoveZone("ExitHousing")
                                exports['lrp-target']:AddBoxZone("Housing", vector3(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z), 2, 2, {
                                    name="Enter Home",
                                    heading= Config.Houses[closesthouse].coords.enter.h,
                                    debugPoly=false,
                                    maxZ= Config.Houses[closesthouse].coords.enter.z + 2,
                                    }, {
                                        options = {
                                            {
                                                type = "client",
                                                event = "qb-houses:client:EnterHouse",
                                                icon = "fas fa-sign-in-alt",
                                                label = "Enter Home",
                                                --job = "all",
                                            },
                                        },
                                        distance = 2
                                })
                            elseif #(pos - dist2) > 3.1 then
                                makepoly = true
                                exports['lrp-target']:RemoveZone("Housing")
                            end
                        end
                    else
                        exports['lrp-target']:RemoveZone("Housing")
                    end
                    -- EXIT HOUSE
                    if inside then
                        if not entering then
                            if POIOffsets ~= nil then
                                if POIOffsets.exit ~= nil then
                                    if #(pos - vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z)) < 1.5 and makeexitpoly then
                                        makeexitpoly = false
                                        exports['lrp-target']:AddBoxZone("ExitHousing", vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z), 2, 2, {
                                            name="Home Options",
                                            heading= Config.Houses[CurrentHouse].coords.enter.h + POIOffsets.exit.h,
                                            debugPoly=false,
                                            maxZ= Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z + 2,
                                            }, {
                                                options = {
                                                    {
                                                        type = "client",   
                                                        event = "ExitHomeFunc",                                                     
                                                        icon = "fas fa-sign-in-alt",
                                                        label = "Exit Home",
                                                        --job = {"all"},
                                                        house = CurrentHouse
                                                    },
                                                    {
                                                        type = "client",   
                                                        event = "PeepCam",                                                     
                                                        icon = "fas fa-sign-in-alt",
                                                        label = "Peep through door",
                                                        --job = {"all"},
                                                        Config.Houses[CurrentHouse].coords.enter == Config.Houses[CurrentHouse].coords.enter
                                                    },
                                                    {
                                                        type = "client",   
                                                        event = "houseletin",                                                     
                                                        icon = "fas fa-sign-in-alt",
                                                        label = "Let In",
                                                        --job = {"all"},
                                                    },
                                                },
                                                distance = 2
                                            })
                                    elseif #(pos - vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z)) > 5 then
                                        makeexitpoly = true
                                        exports['lrp-target']:RemoveZone("ExitHousing")
                                        CurrentDoorBell = 0
                                    end
                                end
                            end
                        end
                    end
                else
                if not hasKey and isOwned then
                    if closesthouse ~= nil then
                        if #(pos - vector3(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z)) < 1.5 and bellpoly then
                            bellpoly = false
                            exports['lrp-target']:AddBoxZone("Housing", vector3(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z), 2, 2, {
                                name="Enter Home",
                                heading= Config.Houses[closesthouse].coords.enter.h,
                                debugPoly=false,
                                maxZ= Config.Houses[closesthouse].coords.enter.z + 2,
                                }, {
                                    options = {
                                        {
                                            type = "client",
                                            event = "qb-houses:client:RequestRing",
                                            icon = "fas fa-sign-in-alt",
                                            label = "Ring Doorbell",
                                            --job = {"all"},
                                        }
                                    },
                                    distance = 2
                            })
                        elseif #(pos - vector3(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z)) > 1.5 then
                            bellpoly = true
                            exports['lrp-target']:RemoveZone("Housing")
                        end
                    end
                end
                    if not isOwned then
                        if closesthouse ~= nil then
                            if #(pos - vector3(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z)) < 1.5 then
                                if viewingpoly then
                                    viewingpoly = false
                                    exports['lrp-target']:AddBoxZone("Viewing", vector3(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z), 2, 2, {
                                        name="View Home",
                                        heading= Config.Houses[closesthouse].coords.enter.h,
                                        debugPoly=false,
                                        maxZ= Config.Houses[closesthouse].coords.enter.z + 2,
                                        }, {
                                            options = {
                                                {
                                                    type = "server",
                                                    event = "qb-houses:server:viewHouse",
                                                    icon = "fas fa-sign-in-alt",
                                                    label = "Purchase Home",
                                                    --job = {"all"},
                                                    closesthouse = closesthouse,
                                                },
                                                {
                                                    type = "client",   
                                                    event = "qb-houses:client:EnterHouse",                                                     
                                                    icon = "fas fa-sign-in-alt",
                                                    label = "View Inside",
                                                    --job = {"all"},
                                                },
                                            },
                                            distance = 2
                                        })
                                    else
                                        viewingpoly = false
                                end
                            end
                        end
                    elseif isOwned then
                        viewingpoly = false
                        exports['lrp-target']:RemoveZone("Viewing")
                        if closesthouse ~= nil then
                            if not inOwned then
                                exports['lrp-target']:RemoveZone("Viewing")
                            elseif inOwned then
                                if POIOffsets ~= nil then
                                    if POIOffsets.exit ~= nil then
                                        if #(pos - vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z)) < 1.5 then
                                            exports['lrp-target']:AddBoxZone("ExitHousing", vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z), 2, 2, {
                                                name="Home Options",
                                                heading= Config.Houses[closesthouse].coords.enter.h + POIOffsets.exit.h,
                                                debugPoly=false,
                                                maxZ= Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z + 2,
                                                }, {
                                                    options = {
                                                        {
                                                            type = "client",   
                                                            event = "NotOwnExitHomeFunc",                                                     
                                                            icon = "fas fa-sign-in-alt",
                                                            label = "Exit Home",
                                                            --job = {"all"},
                                                            house = CurrentHouse
                                                        },
                                                    },
                                                    distance = 2
                                                })
                                                viewingpoly = true
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if inside and not isOwned then
                        if not entering then
                            if POIOffsets ~= nil then
                                if POIOffsets.exit ~= nil then
                                    if #(pos - vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z)) < 1.5 then
                                        exports['lrp-target']:AddBoxZone("ExitHousing", vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z), 2, 2, {
                                            name="Home Options",
                                            heading= Config.Houses[closesthouse].coords.enter.h + POIOffsets.exit.h,
                                            debugPoly=false,
                                            maxZ= Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z + 2,
                                            }, {
                                                options = {
                                                    {
                                                        type = "client",   
                                                        event = "NotOwnExitHomeFunc",                                                     
                                                        icon = "fas fa-sign-in-alt",
                                                        label = "Exit Home",
                                                        --job = {"all"},
                                                        house = CurrentHouse
                                                    },
                                                },
                                                distance = 2
                                            })
                                            viewingpoly = true
                                    end
                                end
                            end
                        end
                    end
                end
                -- STASH
                if inside then
                    if CurrentHouse ~= nil then
                        if stashLocation ~= nil then
                            if #(pos - vector3(stashLocation.x, stashLocation.y, stashLocation.z)) < 1.5 then
                                DrawText3Ds(stashLocation.x, stashLocation.y, stashLocation.z, '~g~E~w~ - Stash')
                                if IsControlJustPressed(0, 38) then -- E
                                    TriggerServerEvent("inventory:server:OpenInventory", "stash", CurrentHouse)
				                    TriggerServerEvent("InteractSound_SV:PlayOnSource", "StashOpen", 0.4)
                                    TriggerEvent("inventory:client:SetCurrentStash", CurrentHouse)
                                end
                            elseif #(pos - vector3(stashLocation.x, stashLocation.y, stashLocation.z)) < 3 then
                                DrawText3Ds(stashLocation.x, stashLocation.y, stashLocation.z, 'Stash')
                            end
                        end
                    end
                end
                if inside then
                    if CurrentHouse ~= nil then
                        if outfitLocation ~= nil then
                            if #(pos - vector3(outfitLocation.x, outfitLocation.y, outfitLocation.z)) < 1.5 then
                                DrawText3Ds(outfitLocation.x, outfitLocation.y, outfitLocation.z, '~g~E~w~ - Outfits')
                                if IsControlJustPressed(0, 38) then -- E
				                TriggerServerEvent("InteractSound_SV:PlayOnSource", "Clothes1", 0.4)
                                TriggerEvent("iconic-clothingmenu:openClothing")
                                end
                            elseif #(pos - vector3(outfitLocation.x, outfitLocation.y, outfitLocation.z)) < 3 then
                                DrawText3Ds(outfitLocation.x, outfitLocation.y, outfitLocation.z, 'Outfits')
                            end
                        end
                    end
                end
                if inside then
                    if CurrentHouse ~= nil then
                        if logoutLocation ~= nil then
                            if #(pos - vector3(logoutLocation.x, logoutLocation.y, logoutLocation.z)) < 1.5 then
                                DrawText3Ds(logoutLocation.x, logoutLocation.y, logoutLocation.z, '~g~E~w~ - Change Characters')
                                if IsControlJustPressed(0, 38) then -- E
                                    DoScreenFadeOut(250)
                                    while not IsScreenFadedOut() do
                                        Citizen.Wait(10)
                                    end
                                    exports['lrp-interior']:DespawnInterior(houseObj, function()
                                        TriggerEvent('qb-weathersync:client:EnableSync')
                                        SetEntityCoords(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.x, Config.Houses[CurrentHouse].coords.enter.y, Config.Houses[CurrentHouse].coords.enter.z + 0.5)
                                        SetEntityHeading(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.h)
                                        inOwned = false
                                        inside = false
                                        TriggerServerEvent('qb-houses:server:LogoutLocation')
                                    end)
                                end
                            elseif #(pos - vector3(logoutLocation.x, logoutLocation.y, logoutLocation.z)) < 3 then
                                DrawText3Ds(logoutLocation.x, logoutLocation.y, logoutLocation.z, 'Change Characters')
                            end
                        end
                    end
                end
            end
        end
        if not inRange then
            Citizen.Wait(1500)
        end
    end
end)

RegisterNetEvent('houseletin')
AddEventHandler('houseletin', function()
    TriggerServerEvent("qb-houses:server:OpenDoor", CurrentDoorBell, closesthouse)
    Citizen.Wait(5000)
    CurrentDoorBell = 0
end)

RegisterNetEvent('NotOwnExitHomeFunc')
AddEventHandler('NotOwnExitHomeFunc', function(data)
    local house = data.house
    leaveNonOwnedHouse(house)
end)


RegisterNetEvent('ExitHomeFunc')
AddEventHandler('ExitHomeFunc', function(data)
    local house = data.house
    leaveOwnedHouse(house)
end)

RegisterNetEvent('PeepCam')
AddEventHandler('PeepCam', function(data)
    local coords = Config.Houses[CurrentHouse].coords.enter
    FrontDoorCam(coords)
end)

RegisterCommand('getoffset', function()
    local coords = GetEntityCoords(PlayerPedId())
    local houseCoords = vector3(
        Config.Houses[CurrentHouse].coords.enter.x,
        Config.Houses[CurrentHouse].coords.enter.y,
        Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset
    )
    if inside then
        local xdist = coords.x - houseCoords.x
        local ydist = coords.y - houseCoords.y
        local zdist = coords.z - houseCoords.z
        print('X: '..xdist)
        print('Y: '..ydist)
        print('Z: '..zdist)
    end
end)

