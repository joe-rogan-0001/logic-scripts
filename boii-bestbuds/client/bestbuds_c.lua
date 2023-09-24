----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local TargetName = Config.CoreSettings.TargetName
local MenuName = Config.CoreSettings.MenuName
local InputName = Config.CoreSettings.InputName
local DutyEvent = Config.CoreSettings.DutyEvent
local ClothingEvent = Config.CoreSettings.ClothingEvent
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- NOTIFICATIONS START --<!>--
RegisterNetEvent('boii-bestbuds:notifications')
AddEventHandler('boii-bestbuds:notifications', function(msg, type)
    Core.Functions.Notify(msg,type)
end)
--<!>-- NOTIFICATIONS END --<!>--

--<!>-- BLIPS START --<!>--
CreateThread(function()
    for _, info in pairs(Config.Blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.6)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)
--<!>-- BLIPS END --<!>--

--<!>-- ON DUTY START --<!>--
PlayerJob = {}
local onDuty = false
RegisterNetEvent('Core:Client:OnPlayerLoaded')
AddEventHandler('Core:Client:OnPlayerLoaded', function()
    Core.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == Config.JobSettings.JobName then
                TriggerServerEvent(DutyEvent)
            end
        end
    end)
end)
RegisterNetEvent('Core:Client:OnJobUpdate')
AddEventHandler('Core:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)
RegisterNetEvent('Core:Client:SetDuty')
AddEventHandler('Core:Client:SetDuty', function(duty)
    onDuty = duty
end)
RegisterNetEvent('boii-bestbuds:client:ToggleDuty', function()
	onDuty = not onDuty
	TriggerServerEvent(DutyEvent)
end)
for k, v in pairs(Config.JobSettings.Locations.Duty) do
    exports[TargetName]:AddBoxZone(v.name, v.coords, v.length, v.width, {
        name=v.name,
        heading= v.heading,
        debugPoly= v.debugPoly,
        minZ = v.minZ,
        maxZ = v.maxZ,
        },{
        options = {
            {
            event = 'boii-bestbuds:client:BestBudsDutyMenu',
            icon = Config.Lang.Targeting['dutyicon'],
            label = Config.Lang.Targeting['dutylabel'],
            job = Config.JobSettings.JobName
            },
        },
        distance = v.distance,
    })
end
-- White widow duty menu
RegisterNetEvent('boii-bestbuds:client:BestBudsDutyMenu', function()
    exports[MenuName]:openMenu({
        { 
            header = Config.Lang.Locations.Duty['dutymenuheader'],
            txt = Config.Lang.Locations.Duty['dutymenuheadertext'],
            icon = Config.Lang.Locations.Duty['dutymenuheadericon'],
            isMenuHeader = true
        },
        { 
            header = Config.Lang.Locations.Duty['dutytoggle'],
            icon = Config.Lang.Locations.Duty['dutytoggleicon'],
            params = {
                event = 'boii-bestbuds:client:ToggleDuty',
            }
        },
        {
            header = Config.Lang.Shared['exitmenu'],
            icon = Config.Lang.Shared['exitmenuicon'],
            params = { 
                event = 'boii-bestbuds:client:StopMenu'
            }
        },
    })
end)
--<!>-- ON DUTY END --<!>--

--<!>-- BOSS MENU START --<!>--
-- Boss
for k, v in pairs(Config.JobSettings.Locations.Boss) do
    exports[TargetName]:AddBoxZone(v.name, v.coords, v.length, v.width, {
        name=v.name,
        heading= v.heading,
        debugPoly= v.debugPoly,
        minZ = v.minZ,
        maxZ = v.maxZ,
        },{
        options = {
            {
            event = Config.CoreSettings.BossMenuEvent,
            icon = Config.Lang.Targeting['bossicon'],
            label = Config.Lang.Targeting['bosslabel'],
            job = {[Config.JobSettings.JobName] = 5}
            },
        },
        distance = v.distance,
    })
end
--<!>-- BOSS MENU END --<!>--

--<!>-- STORAGES START --<!>--
-- Boss storage
for k, v in pairs(Config.JobSettings.Locations.BossStorage) do
    exports[TargetName]:AddBoxZone(v.name, v.coords, v.length, v.width, {
        name=v.name,
        heading= v.heading,
        debugPoly= v.debugPoly,
        minZ = v.minZ,
        maxZ = v.maxZ,
        },{
        options = {
            {
                event = 'boii-bestbuds:client:OpenStash',
                icon = Config.Lang.Targeting['bossstorageicon'],
                label = Config.Lang.Targeting['bossstoragelabel'],
                job = Config.JobSettings.JobName,
                stash = 'bb_boss_storage'
            },
            {
                event = 'boii-bestbuds:client:OpenStash',
                icon = Config.Lang.Targeting['forceentryicon'],
                label = Config.Lang.Targeting['forceentrylabel'],
                job = Config.JobSettings.Raid.JobName,
                stash = 'bb_boss_storage',
                forceentry = true
            }
        },
        distance = v.distance,
    })
end
-- Job storage
for k, v in pairs(Config.JobSettings.Locations.JobStorage) do
    exports[TargetName]:AddBoxZone(v.name, v.coords, v.length, v.width, {
        name=v.name,
        heading= v.heading,
        debugPoly= v.debugPoly,
        minZ = v.minZ,
        maxZ = v.maxZ,
        },{
        options = {
            {
                event = 'boii-bestbuds:client:OpenStash',
                icon = Config.Lang.Targeting['jobstorageicon'],
                label = Config.Lang.Targeting['jobstoragelabel'],
                job = Config.JobSettings.JobName,
                stash = 'bb_job_storage'
            },
            {
                event = 'boii-bestbuds:client:OpenStash',
                icon = Config.Lang.Targeting['forceentryicon'],
                label = Config.Lang.Targeting['forceentrylabel'],
                job = Config.JobSettings.Raid.JobName,
                stash = 'bb_job_storage',
                forceentry = true
            }
        },
        distance = v.distance,
    })
end
AddEventHandler('boii-bestbuds:client:OpenStash', function(data)
    local player = PlayerPedId()
    if not data.forceentry then
        TriggerEvent('inventory:client:SetCurrentStash', data.stash)
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', data.stash, {
            maxweight = 1000000, -- Adjust storage weight here
            slots = 41, -- Adjust storage slots here
        })
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "StashOpen", 0.4)  
    else
        Core.Functions.Progressbar(data.stash, Config.Lang.Shared['forceentry'], Config.JobSettings.Raid.ForceEntryTime*1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
        }, {
            animDict = Config.JobSettings.Raid.ForceEntryAnimationDict,
            anim = Config.JobSettings.Raid.ForceEntryAnimation,
            flags = Config.JobSettings.Raid.ForceEntryFlags,
        }, {}, {}, function()
            TriggerEvent('inventory:client:SetCurrentStash', data.stash)
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', data.stash, {
            maxweight = 1000000, -- Adjust storage weight here
            slots = 41, -- Adjust storage slots here
        })
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "StashOpen", 0.4) 
            ClearPedTasks(player)
        end, function()
            TriggerEvent('inventory:client:busy:status', false)
            TriggerEvent('boii-bestbuds:notifications', Config.Lang.Shared['cancel'], 'error')
        end)
    end
end)
--<!>-- STORAGES END --<!>--

--<!>-- STORAGE TRAY START --<!>--
-- Tray storage
for k, v in pairs(Config.JobSettings.Locations.Tray) do
    exports[TargetName]:AddBoxZone(v.name, v.coords, v.length, v.width, {
        name=v.name,
        heading= v.heading,
        debugPoly= v.debugPoly,
        minZ = v.minZ,
        maxZ = v.maxZ,
        },{
        options = {
            {
            event = 'boii-bestbuds:client:OpenTrayStorage',
            icon = Config.Lang.Targeting['traystorageicon'],
            label = Config.Lang.Targeting['traystoragelabel'],
            },
        },
        distance = v.distance,
    })
end
-- Tray storage event
RegisterNetEvent('boii-bestbuds:client:OpenTrayStorage', function()
    TriggerEvent('inventory:client:SetCurrentStash', 'bb_tray')
    TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'bb_tray', {
        maxweight = 21000, -- Adjust storage weight here
        slots = 5, -- Adjust storage slots here
    })
end)
--<!>-- STORAGE TRAY END --<!>--

--<!>-- EPOS START --<!>--
-- EPOS
for k, v in pairs(Config.JobSettings.Locations.EPOS) do
    exports[TargetName]:AddBoxZone(v.name, v.coords, v.length, v.width, {
        name=v.name,
        heading= v.heading,
        debugPoly= v.debugPoly,
        minZ = v.minZ,
        maxZ = v.maxZ,
        },{
        options = {
            {
            event = 'boii-bestbuds:client:BestBudsPay',
            icon = Config.Lang.Targeting['eposicon'],
            label = Config.Lang.Targeting['eposlabel'],
            job = {[Config.JobSettings.JobName] = 2}
            },
        },
        distance = v.distance,
    })
end
-- Event to charge customers
RegisterNetEvent('boii-bestbuds:client:BestBudsPay', function()
    local input = exports[InputName]:ShowInput({
        header = Config.Lang.Locations.Billing['paymenuheader'],
        submitText = Config.Lang.Locations.Billing['paymenuheadertext'],
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'id',
                text = Config.Lang.Locations.Billing['paytext']
            },
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = Config.Lang.Locations.Billing['payamount'],
            }
        }
    })
    if input then
        if not input.id or not input.amount then 
            return 
        end
        TriggerServerEvent('boii-bestbuds:server:BestBudsPay', input.id, input.amount)
    end
end)
--<!>-- EPOS START --<!>--

--<!>-- TRIMMING START --<!>--
for k, v in pairs(Config.JobSettings.Locations.Trimming) do
    exports[TargetName]:AddBoxZone(v.name, v.coords, v.length, v.width, {
        name=v.name,
        heading= v.heading,
        debugPoly= v.debugPoly,
        minZ = v.minZ,
        maxZ = v.maxZ,
        },{
        options = {
            {
            event = 'boii-bestbuds:client:TrimmingMenu',
            icon = Config.Lang.Targeting['trimicon'],
            label = Config.Lang.Targeting['trimlabel'],
            job = Config.JobSettings.JobName
            },
        },
        distance = v.distance,
    })
end
-- Trimming menu
RegisterNetEvent('boii-bestbuds:client:TrimmingMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang.Locations.Trimming['trimmenuheader'],
            txt = Config.Lang.Locations.Trimming['trimmenuheadertext'],
            icon = Config.Lang.Locations.Trimming['trimmenuheadericon'],
            isMenuHeader = true
        },
        {
            header = Config.Lang.Locations.Trimming['strain1menuheader'],
            txt = Config.Lang.Locations.Trimming['strain1menuheadertext'],
            icon = Config.Lang.Locations.Trimming['strain1menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:TrimWeed',
                isServer = true,
                args = 1
            }
        },
        {
            header = Config.Lang.Locations.Trimming['strain2menuheader'],
            txt = Config.Lang.Locations.Trimming['strain2menuheadertext'],
            icon = Config.Lang.Locations.Trimming['strain2menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:TrimWeed',
                isServer = true,
                args = 2
            }
        },
        { 
            header = Config.Lang.Locations.Trimming['strain3menuheader'],
            txt = Config.Lang.Locations.Trimming['strain3menuheadertext'],
            icon = Config.Lang.Locations.Trimming['strain3menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:TrimWeed',
                isServer = true,
                args = 3
            }
        },
        { 
            header = Config.Lang.Locations.Trimming['strain4menuheader'],
            txt = Config.Lang.Locations.Trimming['strain4menuheadertext'],
            icon = Config.Lang.Locations.Trimming['strain4menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:TrimWeed',
                isServer = true,
                args = 4
            }
        },
        { 
            header = Config.Lang.Locations.Trimming['strain5menuheader'],
            txt = Config.Lang.Locations.Trimming['strain5menuheadertext'],
            icon = Config.Lang.Locations.Trimming['strain5menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:TrimWeed',
                isServer = true,
                args = 5
            }
        },
        {
            header = Config.Lang.Shared['exitmenu'],
            icon = Config.Lang.Shared['exitmenuicon'],
            params = {
                event = 'boii-bestbuds:client:StopMenu'
            }
        },
    })
end)
--<!>-- TRIMMING END --<!>--

--<!>-- BONGS START --<!>--
for k, v in pairs(Config.JobSettings.Locations.BongTable) do
    exports[TargetName]:AddBoxZone(v.name, v.coords, v.length, v.width, {
        name=v.name,
        heading= v.heading,
        debugPoly= v.debugPoly,
        minZ = v.minZ,
        maxZ = v.maxZ,
        },{
        options = {
            {
            event = 'boii-bestbuds:client:BongMenu',
            icon = Config.Lang.Targeting['bongicon'],
            label = Config.Lang.Targeting['bonglabel'],
            },
        },
        distance = v.distance,
    })
end
-- Menu
RegisterNetEvent('boii-bestbuds:client:BongMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang.Locations.BongTable['bongmenuheader'],
            txt = Config.Lang.Locations.BongTable['bongmenuheadertext'],
            icon = Config.Lang.Locations.BongTable['bongmenuheadericon'],
            isMenuHeader = true
        },
        {
            header = Config.Lang.Locations.BongTable['strain1menuheader'],
            txt = Config.Lang.Locations.BongTable['strain1menuheadertext'],
            icon = Config.Lang.Locations.BongTable['strain1menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:UseBong',
                isServer = true,
                args = 1
            }
        },
        {
            header = Config.Lang.Locations.BongTable['strain2menuheader'],
            txt = Config.Lang.Locations.BongTable['strain2menuheadertext'],
            icon = Config.Lang.Locations.BongTable['strain2menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:UseBong',
                isServer = true,
                args = 2
            }
        },
        {
            header = Config.Lang.Locations.BongTable['strain3menuheader'],
            txt = Config.Lang.Locations.BongTable['strain3menuheadertext'],
            icon = Config.Lang.Locations.BongTable['strain3menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:UseBong',
                isServer = true,
                args = 3
            }
        },
        {
            header = Config.Lang.Locations.BongTable['strain4menuheader'],
            txt = Config.Lang.Locations.BongTable['strain4menuheadertext'],
            icon = Config.Lang.Locations.BongTable['strain4menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:UseBong',
                isServer = true,
                args = 4
            }
        },
        {
            header = Config.Lang.Locations.BongTable['strain5menuheader'],
            txt = Config.Lang.Locations.BongTable['strain5menuheadertext'],
            icon = Config.Lang.Locations.BongTable['strain5menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:UseBong',
                isServer = true,
                args = 5
            }
        },
        {
            header = Config.Lang.Shared['exitmenu'],
            icon = Config.Lang.Shared['exitmenuicon'],
            params = {
                event = 'boii-bestbuds:client:StopMenu'
            }
        }
    })
end)
--<!>-- BONGS END --<!>--

--<!>-- EDIBLES START --<!>--
-- Targeting
for k, v in pairs(Config.JobSettings.Locations.Edibles) do
    exports[TargetName]:AddBoxZone(v.name, v.coords, v.length, v.width, {
        name=v.name,
        heading= v.heading,
        debugPoly= v.debugPoly,
        minZ = v.minZ,
        maxZ = v.maxZ,
        },{
        options = {
            {
            event = 'boii-bestbuds:client:EdiblesMenu',
            icon = Config.Lang.Targeting['ediblesicon'],
            label = Config.Lang.Targeting['edibleslabel'],
            job = Config.JobSettings.JobName
            },
        },
        distance = v.distance,
    })
end
-- Menu
RegisterNetEvent('boii-bestbuds:client:EdiblesMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang.Locations.Edibles['ediblesmenuheader'],
            txt = Config.Lang.Locations.Edibles['ediblesmenuheadertext'],
            icon = Config.Lang.Locations.Edibles['ediblesmenuheadericon'],
            isMenuHeader = true
        },
        {
            header = Config.Lang.Locations.Edibles['strain1menuheader'],
            txt = Config.Lang.Locations.Edibles['strain1menuheadertext'],
            icon = Config.Lang.Locations.Edibles['strain1menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:PrepareEdibles',
                isServer = true,
                args = 1
            }
        },
        {
            header = Config.Lang.Locations.Edibles['strain2menuheader'],
            txt = Config.Lang.Locations.Edibles['strain2menuheadertext'],
            icon = Config.Lang.Locations.Edibles['strain2menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:PrepareEdibles',
                isServer = true,
                args = 2
            }
        },
        {
            header = Config.Lang.Locations.Edibles['strain3menuheader'],
            txt = Config.Lang.Locations.Edibles['strain3menuheadertext'],
            icon = Config.Lang.Locations.Edibles['strain3menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:PrepareEdibles',
                isServer = true,
                args = 3
            }
        },
        {
            header = Config.Lang.Locations.Edibles['strain4menuheader'],
            txt = Config.Lang.Locations.Edibles['strain4menuheadertext'],
            icon = Config.Lang.Locations.Edibles['strain4menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:PrepareEdibles',
                isServer = true,
                args = 4
            }
        },
        {
            header = Config.Lang.Locations.Edibles['strain5menuheader'],
            txt = Config.Lang.Locations.Edibles['strain5menuheadertext'],
            icon = Config.Lang.Locations.Edibles['strain5menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:PrepareEdibles',
                isServer = true,
                args = 5
            }
        },
        {
            header = Config.Lang.Shared['exitmenu'],
            icon = Config.Lang.Shared['exitmenuicon'],
            params = {
                event = 'boii-bestbuds:client:StopMenu'
            }
        }
    })
end)
--<!>-- EDIBLES END --<!>--

--<!>-- ROLLING JOINTS START --<!>--
for k, v in pairs(Config.JobSettings.Locations.Rolling) do
    exports[TargetName]:AddBoxZone(v.name, v.coords, v.length, v.width, {
        name=v.name,
        heading= v.heading,
        debugPoly= v.debugPoly,
        minZ = v.minZ,
        maxZ = v.maxZ,
        },{
        options = {
            {
            event = 'boii-bestbuds:client:RollJointsMenu',
            icon = Config.Lang.Targeting['rollingicon'],
            label = Config.Lang.Targeting['rollinglabel'],
            job = Config.JobSettings.JobName
            },
        },
        distance = v.distance,
    })
end
-- Joint rolling menu
RegisterNetEvent('boii-bestbuds:client:RollJointsMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang.Locations.Rolling['jointsmenuheader'],
            txt = Config.Lang.Locations.Rolling['jointsmenuheadertext'],
            icon = Config.Lang.Locations.Rolling['jointsmenuheadericon'],
            isMenuHeader = true
        },
        {
            header = Config.Lang.Locations.Rolling['strain1menuheader'],
            txt = Config.Lang.Locations.Rolling['strain1menuheadertext'],
            icon = Config.Lang.Locations.Rolling['strain1menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:RollJoints',
                isServer = true,
                args = 1
            }
        },
        {
            header = Config.Lang.Locations.Rolling['strain2menuheader'],
            txt = Config.Lang.Locations.Rolling['strain2menuheadertext'],
            icon = Config.Lang.Locations.Rolling['strain2menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:RollJoints',
                isServer = true,
                args = 2
            }
        },
        { 
            header = Config.Lang.Locations.Rolling['strain3menuheader'],
            txt = Config.Lang.Locations.Rolling['strain3menuheadertext'],
            icon = Config.Lang.Locations.Rolling['strain3menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:RollJoints',
                isServer = true,
                args = 3
            }
        },
        { 
            header = Config.Lang.Locations.Rolling['strain4menuheader'],
            txt = Config.Lang.Locations.Rolling['strain4menuheadertext'],
            icon = Config.Lang.Locations.Rolling['strain4menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:RollJoints',
                isServer = true,
                args = 4
            }
        },
        { 
            header = Config.Lang.Locations.Rolling['strain5menuheader'],
            txt = Config.Lang.Locations.Rolling['strain5menuheadertext'],
            icon = Config.Lang.Locations.Rolling['strain5menuheadericon'],
            params = {
                event = 'boii-bestbuds:server:RollJoints',
                isServer = true,
                args = 5
            }
        },
        {
            header = Config.Lang.Shared['exitmenu'],
            icon = Config.Lang.Shared['exitmenuicon'],
            params = {
                event = 'boii-bestbuds:client:StopMenu'
            }
        }
    })
end)
--<!>-- JOINTS END --<!>--

--<!>-- STORES START --<!>--
for k, v in pairs(Config.JobSettings.Locations.JobStore) do
    exports[TargetName]:AddBoxZone(v.name, v.coords, v.length, v.width, {
        name=v.name,
        heading= v.heading,
        debugPoly= v.debugPoly,
        minZ = v.minZ,
        maxZ = v.maxZ,
        },{
        options = {
            {
            event = 'boii-bestbuds:client:OpenJobStore',
            icon = Config.Lang.Targeting['jobstoreicon'],
            label = Config.Lang.Targeting['jobstorelabel'],
            job = Config.JobSettings.JobName
            },
        },
        distance = v.distance,
    })
end
for k, v in pairs(Config.JobSettings.Locations.SnackTable) do
    exports[TargetName]:AddBoxZone(v.name, v.coords, v.length, v.width, {
        name=v.name,
        heading= v.heading,
        debugPoly= v.debugPoly,
        minZ = v.minZ,
        maxZ = v.maxZ,
        },{
        options = {
            {
            event = 'boii-bestbuds:client:OpenSnackTable',
            icon = Config.Lang.Targeting['snacktableicon'],
            label = Config.Lang.Targeting['snacktablelabel'],
            },
        },
        distance = v.distance,
    })
end
-- Open job store
RegisterNetEvent('boii-bestbuds:client:OpenJobStore', function()
    local ShopItems = {}
    ShopItems.label = 'bb_job_store'
    ShopItems.items = Config.JobSettings.Stores.JobStore
    ShopItems.slots = #Config.JobSettings.Stores.JobStore
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'bb_job_store', ShopItems)
end)
-- Open snacks
RegisterNetEvent('boii-bestbuds:client:OpenSnackTable', function()
    local ShopItems = {}
    ShopItems.label = 'bb_snacks'
    ShopItems.items = Config.JobSettings.Stores.SnackTable
    ShopItems.slots = #Config.JobSettings.Stores.SnackTable
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'bb_snacks', ShopItems)
end)
--<!>-- STORES END --<!>--

--<!>-- OUTFITS START --<!>--
for k, v in pairs(Config.JobSettings.Locations.Clothing) do
    exports[TargetName]:AddBoxZone(v.name, v.coords, v.length, v.width, {
        name=v.name,
        heading= v.heading,
        debugPoly= v.debugPoly,
        minZ = v.minZ,
        maxZ = v.maxZ,
        },{
        options = {
            {
            event = 'boii-bestbuds:client:ChangeOutfit',
            icon = Config.Lang.Targeting['outfiticon'],
            label = Config.Lang.Targeting['outfitlabel'],
            job = Config.JobSettings.JobName
            },
        },
        distance = v.distance,
    })
end
RegisterNetEvent('boii-bestbuds:client:ChangeOutfit', function()
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'Clothes1', 0.4)
    TriggerEvent(ClothingEvent)
end)
--<!>-- OUTFITS END --<!>--


--<!>-- GARAGE START --<!>--
for k, v in pairs(Config.JobSettings.Locations.Garage) do
    exports[TargetName]:AddBoxZone(v.name, v.coords, v.length, v.width, {
        name=v.name,
        heading= v.heading,
        debugPoly= v.debugPoly,
        minZ = v.minZ,
        maxZ = v.maxZ,
        },{
        options = {
            {
            event = 'boii-bestbuds:client:AccessGarage',
            icon = Config.Lang.Targeting['garageicon'],
            label = Config.Lang.Targeting['garagelabel'],
            },
        },
        distance = v.distance,
    })
end
-- Event to open menu
RegisterNetEvent('boii-bestbuds:client:AccessGarage', function(data)
    local player = PlayerPedId()
    local inVehicle = IsPedInAnyVehicle(player)
    if inVehicle then
        ReturnVehicle()
    else
        VehicleRentMenu()
    end
end)
function VehicleRentMenu()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang.Locations.Garage['rentheader'],
            icon = Config.Lang.Locations.Garage['rentheadericon'],
            isMenuHeader = true
        },
        {
            header = Config.Lang.Locations.Garage['rentmenuheader'],
            txt = Config.Lang.Locations.Garage['rentmenutext'],
            icon = Config.Lang.Locations.Garage['rentmenuicon'],
            params = {
                event = "boii-bestbuds:client:RentVehicle",
				args = 1
            }
        },
        {
            header = Config.Lang.Shared['exitmenu'],
            icon = Config.Lang.Shared['exitmenuicon'],
            params = {
                event = "boii-bestbuds:client:StopMenu"
            }
        },
    })
end 
function ReturnVehicle()
    exports[MenuName]:openMenu({
		{
            header = Config.Lang.Locations.Garage['rentheader'],
            icon = Config.Lang.Locations.Garage['rentheadericon'],
            isMenuHeader = true
        },
		{
            header = Config.Lang.Locations.Garage['returnmenuheader'],
            txt = Config.Lang.Locations.Garage['returnmenutext'],
            icon = Config.Lang.Locations.Garage['returnmenuicon'],
            params = {
                event = "boii-bestbuds:client:ReturnVehicle",
				args = 1
            }
        },
        {
            header = Config.Lang.Shared['exitmenu'],
            icon = Config.Lang.Shared['exitmenuicon'],
            params = {
                event = "boii-bestbuds:client:StopMenu"
            }
        },
    })
end
--<!>-- VEHICLE RENTAL MENU END --<!>--

--<!>-- OBJECTS START --<!>--
CreateThread(function()
    RequestModel(`prop_bong_01`)
    while not HasModelLoaded(`prop_bong_01`) do 
        Wait(1)
    end
    RequestModel(`sf_prop_sf_bong_01a`)
    while not HasModelLoaded(`sf_prop_sf_bong_01a`) do 
        Wait(1)
    end
    RequestModel(`bkr_prop_weed_dry_02b`)
    while not HasModelLoaded(`bkr_prop_weed_dry_02b`) do 
        Wait(1)
    end
    RequestModel(`prop_laptop_lester`)
    while not HasModelLoaded(`prop_laptop_lester`) do 
        Wait(1)
    end
    RequestModel(`v_ret_fh_kitchtable`)
    while not HasModelLoaded(`v_ret_fh_kitchtable`) do 
        Wait(1)
    end
    RequestModel(`prop_cs_silver_tray`)
    while not HasModelLoaded(`prop_cs_silver_tray`) do 
        Wait(1)
    end
    Bong1 = CreateObject(`prop_bong_01`, 382.11, -830.52, 28.85, false, false, false)
    Bong2 = CreateObject(`sf_prop_sf_bong_01a`, 382.52, -831.65, 28.85, false, false, false)
    Weed = CreateObject(`bkr_prop_weed_dry_02b`, 382.29, -831.17, 28.85, false, false, false)
    Laptop = CreateObject(`prop_laptop_lester`, 373.48, -823.91, 29.28, false, false, false)
    EdiblesTable = CreateObject(`v_ret_fh_kitchtable`, 378.43, -819.14, 28.30, false, false, false)
    Tray = CreateObject(`prop_cs_silver_tray`, 378.88, -827.38, 29.29, false, false, false)
    SetEntityHeading(Bong1,90.0)
    SetEntityHeading(Bong2,85.0)
    SetEntityHeading(Weed,85.0)
    SetEntityHeading(Laptop,90.0)
    SetEntityHeading(EdiblesTable, 0.0)
    SetEntityHeading(Tray, 0.0)
    FreezeEntityPosition(Bong1, true)
    FreezeEntityPosition(Bong2, true)
    FreezeEntityPosition(Weed, true)
    FreezeEntityPosition(Laptop, true)
    FreezeEntityPosition(EdiblesTable, true)
    FreezeEntityPosition(Tray, true)
end)
--<!>-- OBJECTS END --<!>--
