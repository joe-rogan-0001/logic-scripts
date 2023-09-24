local QBCore = exports['lrp-core']:GetCoreObject() 

local VehicleCoords = nil
local CurrentCops = 0
local onRun = false
local hasPackage = false
local hasKey = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)


CreateThread(function()
  RequestModel(`g_m_m_mexboss_01`)
    while not HasModelLoaded(`g_m_m_mexboss_01`) do
    Wait(1)
  end
    methboss = CreatePed(2, `g_m_m_mexboss_01`, 967.26, -1858.49, 30.2, 79.51, false, false) -- change here the cords for the ped 
    SetPedFleeAttributes(methboss, 0, 0)
    SetPedDiesWhenInjured(methboss, false)
    TaskStartScenarioInPlace(methboss, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    SetPedKeepTask(methboss, true)
    SetBlockingOfNonTemporaryEvents(methboss, true)
    SetEntityInvincible(methboss, true)
    FreezeEntityPosition(methboss, true)
end)

--- Target Stuff
CreateThread(function()
    exports['lrp-target']:AddTargetModel('g_m_m_mexboss_01', {
        options = {
            { 
                type = "client",
                event = "lrp-methrun:client:start",
                icon = "fas fa-circle",
                label = "Get Job ($2500)",
            },
            { 
                type = "client",
                event = "lrp-methrun:client:reward",
                icon = "fas fa-circle",
                label = "Check Product",

                canInteract = function()
                    if onRun and hasPackage then return true else return false end 
                end
            },
        },
        distance = 3.0 
    })
    ---
    exports['lrp-target']:AddTargetModel('ba_prop_battle_case_sm_03', {
        options = {
            {
                type = 'client',
                event = "lrp-methrun:client:items",
                icon = "fas fa-circle",
                label = "Grab Goods",

                canInteract = function()
                    if onRun and hasKey then return true else return false end 
                end
            },
        },
        distance = 2.5
    })
end)
---Phone msgs
function RunStart()
	Citizen.Wait(2000)
	TriggerServerEvent('qb-phone:server:sendNewMail', {
	sender = Lang:t('mailstart.sender'),
	subject = Lang:t('mailstart.subject'),
	message = Lang:t('mailstart.message'),
	})
	Citizen.Wait(3000)
end

function Itemtimemsg()
    Citizen.Wait(2000)

	TriggerServerEvent('qb-phone:server:sendNewMail', {
    sender = Lang:t('mail.sender'),
	subject = Lang:t('mail.subject'),
	message = Lang:t('mail.message'),
	})
    QBCore.Functions.Notify(Lang:t("success.case_beep"), 'success')
    Citizen.Wait(Config.Itemtime)
    --RemoveBlip(playerCase)
    TriggerServerEvent('lrp-methrun:server:givecaseitems')
    QBCore.Functions.Notify(Lang:t("success.case_has_been_unlocked"), 'success')
end

function RemoveBlipCooldown(playerCase)
    Wait(5 * 60000)
    RemoveBlip(playerCase)
end

RegisterNetEvent('gangrobbery:client:blipadd', function (playerped)
    if playerped then
        playerCase = AddBlipForEntity(playerped)
        SetBlipSprite(playerCase, 161)
        SetBlipScale(playerCase, 1.4)
        PulseBlip(playerCase)
        SetBlipColour(playerCase, 2)
        --SetBlipAsShortRange(playerCase, true)
        RemoveBlipCooldown(playerCase)
    else
        -- add exploit logs
        print("ayo something sus happend")
    end
end)

---
RegisterNetEvent('lrp-methrun:client:start', function ()
    if CurrentCops >= Config.MinimumMethJobPolice then
        QBCore.Functions.TriggerCallback("lrp-methrun:server:coolc",function(isCooldown)
            if not isCooldown then
                TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_DRUG_DEALER_HARD", 0, true)
                QBCore.Functions.Progressbar("start_job", Lang:t('info.talking_to_boss'), 10000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                }, {}, {}, function() -- Done
                    TriggerEvent('animation:cancel')
                    TriggerServerEvent('lrp-methrun:server:startr')
                    onRun = true
                    hasKey = true
                end, function() -- Cancel
                    TriggerEvent('animation:cancel')
                    QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
                end)
            else
                QBCore.Functions.Notify(Lang:t("error.someone_recently_did_this"), 'error')
            end
        end)
    else
        QBCore.Functions.Notify(Lang:t("error.cannot_do_this_right_now"), 'error')
    end
end)

RegisterNetEvent('lrp-methrun:server:runactivate', function()
RunStart()
local DrawCoord = 1
    if DrawCoord == 1 then
    VehicleCoords = Config.Carspawn
end

RequestModel(`slamvan2`)

while not HasModelLoaded(`slamvan2`) do
    Citizen.Wait(0)
end


ClearAreaOfVehicles(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 15.0, false, false, false, false, false)
transport = CreateVehicle(`slamvan2`, VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 52.0, true, true)
SpawnGuards()
spawncase()
end)

function spawncase()
    local case = CreateObject(`ba_prop_battle_case_sm_03`, 308.73, 2873.87, 42.51, true,  true, true)
    SetNewWaypoint(308.73, 2873.87)
    SetEntityHeading(case, 55.45)
    CreateObject(case)
    FreezeEntityPosition(case, true)
    SetEntityAsMissionEntity(case)
    case = AddBlipForEntity(case)
    SetBlipSprite(case, 568)
    SetBlipColour(case, 1)
    SetBlipFlashes(case, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Case')
    EndTextCommandSetBlipName(case)
end

methguards = {
    ['npcguards'] = {}
}

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

function SpawnGuards()
    local ped = PlayerPedId()

    SetPedRelationshipGroupHash(ped, `PLAYER`)
    AddRelationshipGroup('npcguards')

    for k, v in pairs(Config['methguards']['npcguards']) do
        loadModel(v['model'])
        methguards['npcguards'][k] = CreatePed(26, GetHashKey(v['model']), v['coords'], v['heading'], true, true)
        NetworkRegisterEntityAsNetworked(methguards['npcguards'][k])
        networkID = NetworkGetNetworkIdFromEntity(methguards['npcguards'][k])
        SetNetworkIdCanMigrate(networkID, true)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetPedRandomComponentVariation(methguards['npcguards'][k], 0)
        SetPedRandomProps(methguards['npcguards'][k])
        SetEntityAsMissionEntity(methguards['npcguards'][k])
        SetEntityVisible(methguards['npcguards'][k], true)
        SetPedRelationshipGroupHash(methguards['npcguards'][k], `npcguards`)
        SetPedAccuracy(methguards['npcguards'][k], 75)
        SetPedArmour(methguards['npcguards'][k], 100)
        SetPedCanSwitchWeapon(methguards['npcguards'][k], true)
        SetPedDropsWeaponsWhenDead(methguards['npcguards'][k], false)
        SetPedFleeAttributes(methguards['npcguards'][k], 0, false)
        GiveWeaponToPed(methguards['npcguards'][k], `WEAPON_COMPACTRIFLE`, 255, false, false)
        local random = math.random(1, 2)
        if random == 2 then
            TaskGuardCurrentPosition(methguards['npcguards'][k], 10.0, 10.0, 1)
        end
    end

    SetRelationshipBetweenGroups(0, `npcguards`, `npcguards`)
    SetRelationshipBetweenGroups(5, `npcguards`, `PLAYER`)
    SetRelationshipBetweenGroups(5, `PLAYER`, `npcguards`)
end



RegisterNetEvent('lrp-methrun:client:items', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            TriggerEvent("un-dispatch:houserobbery")
            exports["lrp-memorygame"]:thermiteminigame(8, 3, 2, 20,
            function() -- Success
                TriggerEvent('animations:client:EmoteCommandStart', {"type3"})
                QBCore.Functions.Progressbar("grab_case", Lang:t('info.unlocking_case'), 10000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                }, {}, {}, function() -- Done
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    RemoveBlip(case)
                    TriggerServerEvent('lrp-methrun:server:unlock', PlayerPedId())

                    local playerPedPos = GetEntityCoords(PlayerPedId(), true)
                    local case = GetClosestObjectOfType(playerPedPos, 10.0, `ba_prop_battle_case_sm_03`, false, false, false)
                    if (IsPedActiveInScenario(PlayerPedId()) == false) then
                    SetEntityAsMissionEntity(case, 1, 1)
                    DeleteEntity(case)
                    QBCore.Functions.Notify(Lang:t("success.you_removed_first_security_case"), 'success')
                    Itemtimemsg()
                    hasPackage = true
                end
                end, function()
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
                end)
            end,
            function() -- Fail thermite game
                QBCore.Functions.Notify(Lang:t("error.you_failed"), 'error')
            end)
        else
            QBCore.Functions.Notify(Lang:t("error.you_cannot_do_this"), 'error')
        end

    end, "cratekey")
end)

RegisterNetEvent('lrp-methrun:client:reward', function()
    TriggerServerEvent('gangrobbery:server:removeblip', PlayerPedId())
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            --TriggerEvent('animations:client:EmoteCommandStart', {"suitcase2"})
            QBCore.Functions.Progressbar("product_check", Lang:t('info.checking_quality'), 7000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
            }, {}, {}, function() -- Done
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent('lrp-methrun:server:rewardpayout')

                QBCore.Functions.Notify(Lang:t("success.you_got_paid"), 'success')
                onRun = false
            end, function()
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
            end)
        else
            QBCore.Functions.Notify(Lang:t("error.you_cannot_do_this"), 'error')
        end
    end, "meth_cured",1)
end)

--[[
RegisterCommand('meth', function ()
    TriggerEvent('lrp-methrun:client:start')
end)
]]--