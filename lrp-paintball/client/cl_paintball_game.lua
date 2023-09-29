QBCore = exports['lrp-core']:GetCoreObject()

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(500)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(playerData)
	QBCore.Functions.GetPlayerData = playerData
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
	QBCore.Functions.GetPlayerData.job = job
end)

local teamPlayersEast = 0
local teamPlayersWest = 0
local gameInProgress = false
local inStadium = false
local flagProp = "prop_golfflag"
local flagPropHash = GetHashKey(flagProp)
local flagObjNetId = 0
local isCarryingFlag = false

local function drawStatusHud()
    if not inStadium then return end
    SendNUIMessage({
        app = "status-hud",
        show = false,
        data = {
            show = true,
            title = "Paintball - Match " .. (gameInProgress and "In Progress" or "Pending"),
            values = {
            "East Team: " .. teamPlayersEast .. " player(s)",
            "West Team: " .. teamPlayersWest .. " player(s)",
            },
        },
    })
end

local paintballVendors = {
    ['joinWest'] = {
        name = 'Join West Team',
        txt = "Paintball Teammates",
        event = "np-paintball:joinWest"
    },
    ['joinEast'] = {
        name = 'Join East Team',
        txt = "Paintball Teammates",
        event = "np-paintball:joinEast"
    },
    ['leaveTeam'] = {
        name = 'Leave Team',
        txt = "Paintball Teammates",
        event = "np-paintball:leaveTeam"
    },
    ['startGame'] = {
        name = 'Start Game',
        txt = "Paintball Game",
        event = "np-paintball:startGame"
    },
    ['endGame'] = {
        name = 'End Game',
        txt = "Paintball Game",
        event = "np-paintball:endGame"
    },
}

RegisterNetEvent('np-paintball:getVendor', function()
    local dataMenu = {}
    for _, pData in pairs(paintballVendors) do
        table.insert(dataMenu, {
            id = #dataMenu + 1,
            header = pData.name,
            txt = pData.txt,
            params = {
                event = pData.event
            }
        })
    end
    TriggerEvent('nh-context:sendMenu', dataMenu)
end)

RegisterNetEvent("np-paintball:joinWest")
AddEventHandler("np-paintball:joinWest", function()
    QBCore.Functions.TriggerCallback('np-paintball:game:action', function() end, 'join', 'west')
end)

RegisterNetEvent("np-paintball:joinEast")
AddEventHandler("np-paintball:joinEast", function()
    QBCore.Functions.TriggerCallback('np-paintball:game:action', function() end, 'join', 'east')
end)

RegisterNetEvent("np-paintball:leaveTeam")
AddEventHandler("np-paintball:leaveTeam", function()
    QBCore.Functions.TriggerCallback('np-paintball:game:action', function() end, 'leave')
end)

RegisterNetEvent("np-paintball:startGame")
AddEventHandler("np-paintball:startGame", function()
    QBCore.Functions.TriggerCallback('np-paintball:game:action', function() end, 'start')
end)

RegisterNetEvent("np-paintball:endGame")
AddEventHandler("np-paintball:endGame", function()
    QBCore.Functions.TriggerCallback('np-paintball:game:action', function() end, 'end')
end)

RegisterNetEvent("np-paintball:game:update")
AddEventHandler("np-paintball:game:update", function(pCtx)
    if gameInProgress ~= pCtx.gameInProgress then
        removeAttachedProp()
    end
    teamPlayersEast = pCtx.teamPlayersEast
    teamPlayersWest = pCtx.teamPlayersWest
    gameInProgress = pCtx.gameInProgress
    drawStatusHud()
end)

RegisterCommand("enter", function(source, args)
    TriggerEvent("np-paintball:enterStadium")
    TriggerEvent("np-paintball:joinEast")
    TriggerEvent("np-paintball:startGame")
end)

RegisterCommand("end", function(source, args)
    TriggerEvent("np-paintball:endGame")
end)

AddEventHandler("np-paintball:enterStadium", function()
    inStadium = true
    drawStatusHud()
end)
  
AddEventHandler("np-paintball:leaveStadium", function()
    inStadium = false
    SendNUIMessage({
        app = "status-hud",
        show = false,
        data = { show = false },
    })
end)

RegisterNetEvent("np-paintball:game:spawnFlag", function(pCoords)
    local flagObj = CreateObject(flagPropHash, pCoords, 1, 1, 0)
    Wait(0)
    TriggerServerEvent("np-paintball:game:spawnedFlag", NetworkGetNetworkIdFromEntity(flagObj))
end)

AddEventHandler("np-paintball:game:pickupFlag", function()
    loadAnimDict('anim@narcotics@trash')
    TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',0.9, -8, 1700, 49, 1.0, 0, 0, 0)
    local finished = exports["np-taskbar"]:taskBar(3000, "Picking up Flag")
    if finished ~= 100 then return end
    isCarryingFlag = true
    TriggerEvent("np-props:attachProp", flagProp, 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
    TriggerServerEvent("np-paintball:game:pickedUpFlag")
    -- Wait(5000)
    -- removeAttachedProp()
end)

local isDead = false
AddEventHandler("pd:deathcheck", function()
  isDead = not isDead
  if not isDead then return end
  if gameInProgress and inStadium then
    QBCore.Functions.TriggerCallback("np-paintball:game:action", function() end, "leave")
  end
  if not isCarryingFlag then return end
  TriggerEvent("np-props:removeProp")
  local coordsC = GetEntityCoords(PlayerPedId())
  local coords = vector3(coordsC.x - 0.25, coordsC.y + 0.25, coordsC.z - 1.0)
  TriggerServerEvent("np-paintball:game:diedWithFlag", coords)
end)
