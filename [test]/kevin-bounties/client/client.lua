local QBCore = exports['lrp-core']:GetCoreObject()

local data = {}
local HasJob = false
local alerted = false
local InRange = false
local InTargetZone = false
local CanCollect = false
local CheckPed = false
local TargetZone

CreateThread(function()
    QBCore.Functions.LoadModel(Config.DeskPed)
    DeskPed = CreatePed(0,Config.DeskPed, Config.DeskPedLocation.x, Config.DeskPedLocation.y, Config.DeskPedLocation.z -1, Config.DeskPedLocation.w, false, false)
    FreezeEntityPosition(DeskPed, true)
    SetEntityInvincible(DeskPed, true)
    SetBlockingOfNonTemporaryEvents(DeskPed, true)

    exports['lrp-target']:AddTargetEntity(DeskPed, {
        options = {
            {
                icon = 'fas fa-circle',
                label = 'Get Contract',
                canInteract = function()
                    if not HasJob then return true end
                    return false
                end,
                action = function()
                    TalkToAgent()
                end,
            },
            {
                icon = 'fas fa-circle',
                label = 'Collect Reward',
                canInteract = function()
                    if CanCollect then return true end
                    return false
                end,
                action = function()
                    TriggerServerEvent('kevin-bounties:server:CollectPay', data)
                end,
            },
        },
        distance = 2.0
    })
end)

function TalkToAgent()
    QBCore.Functions.TriggerCallback("kevin-bounties:server:coolc",function(isCooldown)
        if not isCooldown then
            TriggerEvent('animations:client:EmoteCommandStart', {"argue"})
            QBCore.Functions.Progressbar("start_job", "Talking", 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
            }, {}, {}, function() -- Done
                Wait(500)
                QBCore.Functions.Notify("You will be contacted shortly..", 'primary')
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                TriggerServerEvent("kevin-bounties:server:coolout")
                HasJob = true
                CheckInMsg()
            end, function() -- Cancel
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                QBCore.Functions.Notify("Cancelled?", 'error')
            end, "fas fa-pen-to-square")
        else
            QBCore.Functions.Notify("No contracts right now, check back later..", 'error', 4000)
        end
    end)
end

function CheckInMsg()
    Wait(6000)
    local plyData = QBCore.Functions.GetPlayerData()
    local name = plyData.charinfo.firstname:sub(1,1):upper()..plyData.charinfo.firstname:sub(2).. " ".. plyData.charinfo.lastname:sub(1,1):upper()..plyData.charinfo.lastname:sub(2)
	TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = "Unknown Number",
        subject = 'Bounty Contract: Wanted Dead.',
        message = 'Hello '..name..' so I got a target for you, he is wanted by the state and is considered armed and extremly dangerous. You should have recieved an envelope with all of the details you need.Good luck',
	})
    Wait(10000)
    AcceptContract()
end

function AcceptContract()
    data = Config.Locations[math.random(#Config.Locations)]
    local model = Config.TargetPeds[math.random(#Config.TargetPeds)]
    local targetpos = data.TargetLocations

    FirstName = Config.TargetNames[math.random(#Config.TargetNames)]
    LastName = Config.TargetLastNames[math.random(#Config.TargetLastNames)]
    WantedFor = Config.WantedFor[math.random(#Config.WantedFor)]
    BountyPrice = data.BountyPay
    street = GetStreetNameAtCoord(targetpos.x, targetpos.y, targetpos.z)
    LastSeen = GetStreetNameFromHashKey(street)
    TargetArea = AddBlipForRadius(targetpos.x, targetpos.y, targetpos.z, 150.0)
    SetBlipColour(TargetArea, 80)

    TriggerServerEvent('kevin-bounties:server:Contract', FirstName,LastName,LastSeen,BountyPrice,WantedFor)
    GotContract = true
    TriggerEvent('qb-phone:client:CustomNotification', 'CURRENT TASK', 'Go to the area and search and kill the target', 'fas fa-location-arrow', '#FF0000', 5500)

    QBCore.Functions.LoadModel(model)
    
    TargetZone = BoxZone:Create(vector3(targetpos.x, targetpos.y, targetpos.z), 500.0, 500.0, {
        heading = targetpos.w,
        name = 'targetped',
        debugPoly = false,
        -- minZ = 53.64,
        -- maxZ = 56.24
    })
    TargetZone:onPlayerInOut(function(isPointInside)
        if isPointInside and not InTargetZone then
            InRange = true
            InTargetZone = true
            targetped = CreatePed(0,model, targetpos.x, targetpos.y, targetpos.z -1, 0.0, true, true)
            SetPedArmour(targetped, 300)
            SetPedMaxHealth(targetped, 500)
            SetPedSuffersCriticalHits(targetped, false)
            SetPedRelationshipGroupHash(targetped, `HATES_PLAYER`)
            TaskWanderStandard(targetped, 10.0, 10)
            
            if data.SpawnGoons == 'true' then
                for k, v in pairs(data.GoonLocations) do
                    local goonhash = Config.GoonPeds[math.random(#Config.GoonPeds)]
                    QBCore.Functions.LoadModel(goonhash)
                    GoonPeds = CreatePed(0,goonhash, v.x, v.y, v.z -1, 0.0, true, true)
                    TaskFollowToOffsetOfEntity(GoonPeds, targetped, 0.5, -1.0, 0.0, 5.0, -1, 1.0, true)
                    SetPedRelationshipGroupHash(GoonPeds, `HATES_PLAYER`)
                    SetRelationshipBetweenGroups(0, GoonPeds, targetped)
                    SetPedFleeAttributes(GoonPeds, 0, false)
                    SetPedAccuracy(GoonPeds, 80)
                    SetPedArmour(GoonPeds, 200)
                    SetPedMaxHealth(GoonPeds, 500)
                    GiveWeaponToPed(GoonPeds, `WEAPON_PISTOL`, 250, false, true)
                    SetPedDropsWeaponsWhenDead(GoonPeds, false)
                    SetPedSuffersCriticalHits(GoonPeds, false)
                    SetPedSeeingRange(GoonPeds, 5.0)
                end
            end

            CreateThread( function ()
                exports['qb-target']:AddTargetEntity(targetped, {
                    options = {
                        {
                            icon = 'fas fa-circle',
                            label = 'Search Body',
                            canInteract = function()
                                if not CheckPed then return true end
                                return false
                            end,
                            action = function()
                                Search()
                            end,
                        },
                    },
                    distance = 2.0
                })
            end)
        end
    end)

    CreateThread( function ()
        while InRange do
            local ped = PlayerPedId()
            local PedPos = GetEntityCoords(ped)
            local targetloc = GetEntityCoords(targetped)
            local dist = #(PedPos - targetloc)
            if dist <= 35.5 then
                if not alerted then
                    alerted = true
                    TaskTurnPedToFaceEntity(targetped, ped, 5500)
                    Wait(1500)
                    TaskSmartFleePed(targetped, ped, 1000.0, -1, true, true)
                    ClearPedTasks(GoonPeds)
                end
            end
            if dist >= 200.0 and alerted then
                alerted = false
                Pedescaped = true
                FailedMsg()
            end
            Wait(1000)
        end
    end)
end

function Search()
    SearchAnim()
    QBCore.Functions.Progressbar("start_job", "Searching", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
    }, {}, {}, function() -- Done
        RemoveBlip(TargetArea)
        ClearPedTasks(PlayerPedId())
        CheckPed = true
        TriggerEvent('qb-phone:client:CustomNotification', 'CITIZEN DETAILS',"First Name: "..FirstName.." Last Name: "..LastName.." Status: Deceased", 'fas fa-location-arrow', '#FF0000', 5000)
        Wait(3500)
        TriggerEvent('qb-phone:client:CustomNotification', 'TASK COMPLETED', 'Go to the area and search and kill the target', 'fas fa-location-arrow', '#FF0000', 5500)
        Wait(1000)
        QBCore.Functions.Notify("Return to the start location to claim your reward..", 'primary', 4000)
        CanCollect = true
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Cancelled?", 'error')
    end, "fas fa-magnifying-glass")
end

function FailedMsg()
    Wait(6000)
	TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = "Unknown",
        subject = 'Contract',
        message = 'So you failed the contract, dammit.. He will go into hiding now, got to wait for the right moment again. Check back in for more work',
	})
    Wait(6000)
    TriggerClientEvent('kevin-bounties:client:Clean')
end


RegisterNetEvent('kevin-bounties:client:Clean', function ()
    TriggerEvent('qb-phone:client:CustomNotification', 'TASK COMPLETED', 'Search his body to verify his identity and return back to the start location', 'fas fa-layer-group', '#FF0000', 5500)
    Wait(2000)
    TriggerEvent('qb-phone:client:CustomNotification', 'ALERT', 'Well done out there, I look forward to working with you again', 'fas fa-envelope', '#FF0000', 5500)
    HasJob = false
    alerted = false
    InRange = false
    InTargetZone = false
    CanCollect = false
    CheckPed = false
    TargetZone:destroy()
end)

function SearchAnim()
    local ped = PlayerPedId()
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    Wait(2500)
    LoadAnimDict('amb@medic@standing@kneel@base')
    LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
    TaskPlayAnim(ped, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
    TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 49, 0, false, false, false )
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end