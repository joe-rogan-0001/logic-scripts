if(GetResourceState("es_extended") ~= "missing") then
    function HudAddNotification(notification)
        TriggerEvent("esx:showNotification", notification)
    end
elseif(GetResourceState("lrp-core") ~= "missing") then
    function HudAddNotification(notification)
        TriggerEvent("QBCore:Notify", notification)
    end
else
	function HudAddNotification(notification)
        ShowNotification("House Robbery", notification, "")
    end
end

RegisterNetEvent("sf-houserobbery:showNotification", function(text)
    HudAddNotification(text)
end)

function ShowNotification(title, subtitle, message, backgroundColor, notifImage, iconType, durationMult)
	AddTextEntry('houserobberyNotification', message)
    BeginTextCommandThefeedPost("houserobberyNotification")
    if(backgroundColor) then
        ThefeedSetNextPostBackgroundColor(backgroundColor)
    end
    EndTextCommandThefeedPostMessagetext(notifImage or "CHAR_CALL911", notifImage or "CHAR_CALL911", true, iconType or 4, title, subtitle, durationMult)
    return EndTextCommandThefeedPostMpticker(false, true)
end

function ShowHelpNotification(message, thisFrame, beep, duration)
	AddTextEntry("houserobberyHelpNotification", message)
	if(thisFrame) then
		DisplayHelpTextThisFrame("houserobberyHelpNotification", false)
	else
		BeginTextCommandDisplayHelp("houserobberyHelpNotification")
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

function Verbose(message, level)
    if(level == "error" and Config.Verbose ~= "none") then
        print(("^1Error: %s^0"):format(message))
    end
    if(level == "warning" and Config.Verbose ~= "error") then
        print(("^3Warning: %s^0"):format(message))
    end
    if(level == "info" and Config.Verbose == "all") then
        print(("Info: %s"):format(message))
    end
end

-- if it returns true, the ped stops the anim and deletes object - can be used for clearing anim/prop after death ! If you use it remember to call OnInventoryUpdate on revive
function ShouldCancelObjectThread()
    return false
end

local lockpicking = false
RegisterClientCallback("lockpickHouse", function()
    LoadAnimDict("veh@break_in@0h@p_m_one@")
    lockpicking = true
    Citizen.CreateThread(function()
        while lockpicking do
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
            Citizen.Wait(2500)
        end
    end)
    -- here you can add quick time event or something
    Citizen.Wait(5000)
    lockpicking = false
    return true
end)

RegisterClientCallback("searchStash", function()
    LoadAnimDict("missexile3")
    TaskPlayAnim(PlayerPedId(), "missexile3", "ex03_dingy_search_case_base_michael", 1.0, -1.0, -1, 1, 0.0, false, false, false)
    -- here you can add your progress bar
    Citizen.Wait(Config.SearchTime)
    StopAnimTask(PlayerPedId(), "missexile3", "ex03_dingy_search_case_base_michael", 1.0)
    return true
end)

RegisterClientCallback("takeProp", function()
    -- here you can add your progress bar
    return true
end)

RegisterClientCallback("lockHouse", function()
    LoadAnimDict("veh@break_in@0h@p_m_one@")
    lockpicking = true
    Citizen.CreateThread(function()
        while lockpicking do
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
            Citizen.Wait(2500)
        end
    end)
    -- here you can add quick time event or something
    Citizen.Wait(5000)
    lockpicking = false
    return true
end)


RegisterClientCallback("getClockHour", function()
    return GetClockHours()
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.Houses) do
        CreateInteraction("house_entry_"..k, {
            coords = v.coords.xyz,
            notify = _L("press_key_to_enter"),
            range = Config.StandaloneRange or 4.0,
            controls = {
                {
                    disabled = Config.Controls["use"].disabled,
                    key = Config.Controls["use"].key,
                    action = function()
                        TriggerServerEvent("sf-houserobbery:enterHouse", k)
                    end,
                    canInteract = function()
                        return OpenedHouses[k]
                    end
                },
                {
                    disabled = Config.Controls["lock"].disabled,
                    key = Config.Controls["lock"].key,
                    addNotify = _L("press_key_to_lock"),
                    action = function()
                        TriggerServerEvent("sf-houserobbery:lockHouse", k)
                    end,
                    canInteract = function()
                        return OpenedHouses[k] and JobName == Config.PoliceJob
                    end,
                    distance = 2.0
                },
            }
        }, {
            zone = {
                coords = v.coords,
                length = 2.0,
                width = 2.0,
                minZ = v.coords.z,
                maxZ = v.coords.z + 2.0
            },
            options = {
                {
                    icon = "fas fa-hands",
                    label = _L("enter_house"),
                    action = function()
                        TriggerServerEvent("sf-houserobbery:enterHouse", k)
                    end,
                    canInteract = function()
                        return OpenedHouses[k]
                    end,
                    distance = 2.0
                },
                {
                    icon = "fas fa-hands",
                    label = _L("lock_house"),
                    action = function()
                        TriggerServerEvent("sf-houserobbery:lockHouse", k)
                    end,
                    canInteract = function()
                        return OpenedHouses[k] and JobName == Config.PoliceJob
                    end,
                    distance = 2.0
                },
            }
        })
    end

    for k, v in ipairs(Config.Peds) do
        LoadModel(v.model)
        v.handle = CreatePed(26, v.model, v.coords.xyz, 0.0, 0, 0)
        FreezeEntityPosition(v.handle, true)
        TaskSetBlockingOfNonTemporaryEvents(v.handle, true)
        SetBlockingOfNonTemporaryEvents(v.handle, true)
        SetEntityAsMissionEntity(v.handle, true, true)
        SetEntityInvincible(v.handle, true)
        SetEntityHeading(v.handle, v.coords.w)
        SetPedDefaultComponentVariation(v.handle)
        if(v.scenario) then
            TaskStartScenarioInPlace(v.handle, v.scenario, -1)
        end
        CreateInteraction("houserobbery_ped_"..k, {
            coords = v.coords.xyz,
            notify = _L("standalone_get_key") .. _L(v.locale),
            range = Config.StandaloneRange or 4.0,
            controls = {
                {
                    disabled = Config.Controls["use"].disabled,
                    key = Config.Controls["use"].key,
                    action = function()
                        TriggerServerEvent(v.event)
                    end,
                },
            }
        }, {
            fromModel = v.model,
            zone = {
                coords = v.coords.xyzw + vector4(0.0, 0.0, 1.0, 0.0),
            },
            options = {
                {
                    icon = "fas fa-hands",
                    label = _L(v.locale),
                    action = function()
                        TriggerServerEvent(v.event)
                    end,
                    distance = 2.0
                },
            }
        })
    end
    Citizen.Wait(2000)
    TriggerServerEvent("sf-houserobbery:playerLoaded")
end)

function RemoveInteriorInteractions(interiorId)
    local interior = Config.Interiors[interiorId]
    RemoveInteraction("interior_exit_"..interiorId)
    for propId, prop in pairs(interior.props) do
        RemoveInteraction("interior_"..interiorId.."_prop_"..propId)
    end
    for stashId, stash in pairs(interior.stashes) do
        RemoveInteraction("interior_"..interiorId.."_stash_"..stashId)
    end
end

function CreateInteriorInteractions(interiorId)
    local interior = Config.Interiors[interiorId]
    CreateInteraction("interior_exit_"..interiorId, {
        coords = interior.entrance.pedCoords.xyz,
        notify = _L("press_key_to_exit"),
        range = Config.StandaloneRange or 4.0,
        controls = {
            {
                disabled = Config.Controls["use"].disabled,
                key = Config.Controls["use"].key,
                action = function()
                    TriggerServerEvent("sf-houserobbery:exitHouse", CurrentHouse.id)
                end,
                canInteract = function()
                    return CurrentHouse ~= nil
                end
            },
        }
    }, {
        zone = {
            coords = interior.entrance.coords,
            length = interior.entrance.length,
            width = interior.entrance.width,
            minZ = interior.entrance.minZ,
            maxZ = interior.entrance.maxZ
        },
        options = {
            {
                icon = "fas fa-hands",
                label = _L("exit_house"),
                action = function()
                    TriggerServerEvent("sf-houserobbery:exitHouse", CurrentHouse.id)
                end,
                canInteract = function()
                    return CurrentHouse ~= nil
                end,
                distance = 2.0
            },
        }
    })

    for propId, prop in pairs(interior.props) do
        if(not prop.itemName) then
            goto nextProp
        end
        local propZone = {
            coords = prop.coords.xyzw
        }
        -- somehow safe model dimensions are smaller than actual dimensions
        if(prop.itemName == "safe") then
            propZone.length = 1.0
            propZone.width = 1.0
            propZone.minZ = prop.coords.z - 1.0
            propZone.maxZ = prop.coords.z + 1.0
        end
        CreateInteraction("interior_"..interiorId.."_prop_"..propId, {
            coords = prop.coords.xyz,
            notify = _L("standalone_get_key") .. _L("get_"..prop.itemName),
            range = Config.StandaloneRange or 4.0,
            controls = {
                {
                    disabled = Config.Controls["use"].disabled,
                    key = Config.Controls["use"].key,
                    action = function()
                        TriggerServerEvent("sf-houserobbery:takeProp", CurrentHouse.id, propId)
                    end,
                    canInteract = function()
                        return CurrentHouse ~= nil and not CurrentHouse.takenProps[propId]
                    end
                },
            }
        }, {
            fromModel = prop.itemName ~= "safe" and prop.model,
            zone = propZone,
            options = {
                {
                    icon = "fas fa-hands",
                    label = _L("get_"..prop.itemName),
                    action = function()
                        TriggerServerEvent("sf-houserobbery:takeProp", CurrentHouse.id, propId)
                    end,
                    canInteract = function()
                        return CurrentHouse ~= nil and not CurrentHouse.takenProps[propId]
                    end,
                    distance = Config.InteractionRange
                },
            }
        })
        ::nextProp::
    end

    for stashId, stash in pairs(interior.stashes) do
        CreateInteraction("interior_"..interiorId.."_stash_"..stashId, {
            coords = stash.coords.xyz,
            notify = _L("search_stash_standalone"),
            range = Config.StandaloneRange or 4.0,
            controls = {
                {
                    disabled = Config.Controls["use"].disabled,
                    key = Config.Controls["use"].key,
                    action = function()
                        TriggerServerEvent("sf-houserobbery:searchStash", CurrentHouse.id, stashId)
                    end,
                    canInteract = function()
                        return CurrentHouse ~= nil and not CurrentHouse.searchedStashes[stashId]
                    end
                },
            }
        }, {
            zone = {
                coords = stash.coords,
                length = stash.length,
                width = stash.width,
                minZ = stash.minZ,
                maxZ = stash.maxZ
            },
            options = {
                {
                    icon = "fas fa-hands",
                    label = _L("search_stash"),
                    action = function()
                        TriggerServerEvent("sf-houserobbery:searchStash", CurrentHouse.id, stashId)
                    end,
                    canInteract = function()
                        return CurrentHouse ~= nil and not CurrentHouse.searchedStashes[stashId]
                    end,
                    distance = 2.0
                },
            }
        })
    end
end

AddEventHandler("onResourceStop", function(resourceName)
    if(resourceName == GetCurrentResourceName()) then
        for k, v in pairs(Config.Peds) do
            SetEntityAsMissionEntity(v.handle, true, true)
            DeleteEntity(v.handle)
        end
    end
end)

RegisterNetEvent("sf-houserobbery:dispatch", function(coords)
    TriggerEvent('ps-dispatch:client:HouseRobbery')
end)

-- here you can disable your own sync of the blackout when the power in house is disabled

-- if you are using vSync you can use our fork of it (https://github.com/MateqB/vSync)
if(GetResourceState("vSync") ~= "missing" and GetResourceMetadata("vSync", "version", 0) == "1.0.0") then
    function LockBlackout(state)
        exports['vSync']:SetBlackoutLock(state)
    end
else
    function LockBlackout(state)

    end
end

-- inventory
Inventory = {}
if(GetResourceState("ox_inventory") ~= "missing") then
    Verbose("OX_INVENTORY detected", "info")
    AddEventHandler("ox_inventory:updateInventory", function(changes)
        local items = exports['ox_inventory']:GetPlayerItems()
        Inventory = {}
        for k, v in pairs(items) do
            Inventory[v.name] = (Inventory[v.name] or 0) + v.count
        end
        OnInventoryUpdate()
    end)
elseif(GetResourceState("es_extended") ~= "missing") then
    Verbose("ESX detected", "info")
    function ESXToInv(esxInventory)
        Inventory = {}
        for k, v in ipairs(esxInventory) do
            Inventory[v.name] = v.count or 0
        end
        OnInventoryUpdate()
    end
    ESX = nil
    Citizen.CreateThread(function()
        if(ESXEvent) then
            while not ESX do
                TriggerEvent(ESXEvent, function(obj) ESX = obj end)
                Citizen.Wait(100)
            end
        else
            ESX = exports["es_extended"]:getSharedObject()
        end
        if(ESX.PlayerData and ESX.PlayerData.inventory) then
            ESXToInv(ESX.PlayerData.inventory)
        end
    end)

    RegisterNetEvent('esx:addInventoryItem', function(item, count)
        if(Config.ItemOffsets[item]) then
            Citizen.Wait(50)
            ESXToInv(ESX.GetPlayerData().inventory)
        end
    end)

    RegisterNetEvent('esx:removeInventoryItem', function(item, count)
        if(Config.ItemOffsets[item]) then
            Citizen.Wait(50)
            ESXToInv(ESX.GetPlayerData().inventory)
        end
    end)
elseif(GetResourceState("lrp-core") ~= "missing") then
    Verbose("QB detected", "info")
    function QbToInv(qbInventory)
        Inventory = {}
        for k, v in pairs(qbInventory) do
            Inventory[v.name] = (Inventory[v.name] or 0) + v.amount
        end
        OnInventoryUpdate()
    end
    QBCore = exports['lrp-core']:GetCoreObject()
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        PlayerData = QBCore.Functions.GetPlayerData()
        if(PlayerData and PlayerData.items and PlayerData.items[1]) then
            QbToInv(PlayerData.items)
        end
    end)
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        Citizen.Wait(1000)
        PlayerData = QBCore.Functions.GetPlayerData()
        QbToInv(PlayerData.items)
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        Inventory = {}
        OnInventoryUpdate()
    end)

    RegisterNetEvent("QBCore:Player:SetPlayerData", function()
        local playerData = QBCore.Functions.GetPlayerData()
        if(not playerData or not playerData.items or not playerData.items[1]) then return end
        Citizen.Wait(100)
        QbToInv(QBCore.Functions.GetPlayerData().items)
        OnInventoryUpdate()
    end)
else
    Verbose("No inventory detected, props in hand will NOT work, hook up your own inventory in editable_client.lua", "warning")
end

JobName = nil

if(GetResourceState("es_extended") ~= "missing") then
    ESX = nil
    Citizen.CreateThread(function()
        if(ESXEvent) then
            while not ESX do
                TriggerEvent(ESXEvent, function(obj) ESX = obj end)
                Citizen.Wait(100)
            end
        else
            ESX = exports["es_extended"]:getSharedObject()
        end
        if(ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.name) then
            JobName = ESX.PlayerData.job.name
        end
    end)

    RegisterNetEvent('esx:setJob', function(job)
        JobName = job.name
    end)

    RegisterNetEvent('esx:playerLoaded', function(xPlayer, isNew, skin)
        JobName = xPlayer.job.name
    end)
elseif(GetResourceState("lrp-core") ~= "missing") then
    QBCore = exports['lrp-core']:GetCoreObject()
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        PlayerData = QBCore.Functions.GetPlayerData()
        if(PlayerData and PlayerData.job and PlayerData.job.name) then
            JobName = PlayerData.job.name
        end
    end)
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        PlayerData = QBCore.Functions.GetPlayerData()
        JobName = PlayerData.job.name
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
        JobName = job.name
    end)
end

AddEventHandler("sf-houserobbery:robberyNotification", function()
    HudAddNotification(_L("robbery_in_progress"))
end)

local crackingSafe = false
AddEventHandler("sf-houserobbery:crackingStatus", function(state)
    crackingSafe = state
    if(state) then
        EnsureSafeCrackingHelp()
    end
end)

local safe_cracking_help = false
function EnsureSafeCrackingHelp()
    if(safe_cracking_help) then return end
    safe_cracking_help = true
    Citizen.CreateThread(function()
        local resName = GetCurrentResourceName()
        AddTextEntry(resName.."safeHelp", _L("safe_cracking_help"))
        while crackingSafe do
            DisplayHelpTextThisFrame(resName.."safeHelp", false)
            Citizen.Wait(0)
        end
        safe_cracking_help = false
    end)
end