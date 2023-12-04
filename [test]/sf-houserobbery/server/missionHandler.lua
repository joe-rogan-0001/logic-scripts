local Players = {}
Missions = {}
UsedLocations = {}
local PlayerMissions = {}
local PlayersWaiting = {}
local MissionId = 0

Citizen.CreateThread(function()
    while true do
        if(#Players < 1) then goto continue end
        Citizen.Wait(Config.WaitTime * 1000)
        GetFirstPlayer()
        ::continue::
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent('sf-houserobbery:getMission', function()
    local _source = source
    if(PlayerMissions[_source]) then
        ShowNotification(_source, _L("on_mission"))
        return
    end
    if(PlayersWaiting[_source]) then
        ShowNotification(_source, _L("already_waiting"))
        return
    end
    if(Config.NightOnly) then
        local hour = TriggerClientCallback("getClockHour", _source)
        if(not hour) then return end
        if(not ((hour >= 20 and hour <= 24) or (hour <= 6 and hour >= 0))) then
            ShowNotification(_source, _L("job_night_only"))
            return
        end
    end

    if Bridge.GetJobCount("police") < Config.CopsRequired then
        ShowNotification(_source, _L("no_cops"))
        return
    end
    if(Bridge.GetItemCount(_source, Config.MissionPrice.item) < Config.MissionPrice.count) then
        ShowNotification(_source, _L("not_enough_money"))
        return
    end
    Bridge.RemoveItem(_source, Config.MissionPrice.item, Config.MissionPrice.count)
    AddPlayerToQueue(_source)
    ShowNotification(_source, _L("info_soon"))
end)

function GetMissionId()
    MissionId += 1
    return tostring(MissionId)
end

function GetFirstPlayer()
    table.sort(Players, function(a, b)  return a.time < b.time end)
    local minTime, maxTime = Players[1]?.time, Players[#Players]?.time
    if(not minTime or not maxTime) then
        return
    end
    local playerIndex = -1
    if(minTime == maxTime) then
        playerIndex = 1
    end
    if(playerIndex == -1) then
        if(maxTime > minTime*1.1) then
            maxTime = maxTime-(maxTime-minTime)/2
        end
        local requiredTime = math.random(math.floor(minTime), math.floor(maxTime))
        local acceptedPlayers = {}
        for i=1, #Players do
            if(Players[i] and Players[i].time <= requiredTime) then
                table.insert(acceptedPlayers, i)
            end
        end
        if(#acceptedPlayers < 1) then return end
        playerIndex = acceptedPlayers[math.random(1, #acceptedPlayers)]
    end
    if(playerIndex == -1) then
        return
    end
    local playerId = Players[playerIndex]?.source
    if(not playerId) then 
        return
    end
    if(not CanStartNewMission()) then
        return
    end
    if(not IsAnyLocationFree()) then
        return
    end
    if(GetPlayerPing(playerId) < 500 and GetPlayerPing(playerId) > 0) then
        if Bridge.GetJobCount(Config.PoliceJob) < Config.CopsRequired then
            SendMessageToPlayer(playerId, "no_cops")
            PlayersWaiting[playerId] = nil
            table.remove(Players, playerIndex)
            return
        end
        PlayersWaiting[playerId] = nil
        table.remove(Players, playerIndex)
        CreateMissionForPlayer(playerId)
    else
        PlayersWaiting[playerId] = nil
        table.remove(Players, playerIndex)
        GetFirstPlayer()
    end
end

function CanStartNewMission()
    if(Config.MaxMissions == -1) then return true end
    local count = 0
    for _, _ in pairs(Missions) do
        count += 1
    end
    return count < Config.MaxMissions
end

function IsAnyLocationFree()
    local time = os.time()
    for locationId, _ in ipairs(Config.Houses) do
        if(not UsedLocations[locationId] or time - UsedLocations[locationId] > Config.LocationCooldown) then
            return true
        end
    end
end

function AddPlayerToQueue(source)
    PlayersWaiting[source] = true
    table.insert(Players, {
        source = source,
        time = os.time(),
    })
end

function CreateMissionForPlayer(source)
    local houseId = GetFreeLocation()
    local success = SendMessageToPlayer(source, "sent_you_houseinfo")
    if(not success) then return end
    local missionId = GetMissionId()
    Missions[missionId] = {
        owner = source,
        houseId = houseId,
        time = os.time()
    }
    local randomCoords = Config.Houses[houseId].coords.xy
    local halfRadius = math.floor(Config.BlipSettings.radius/2.2)
    randomCoords = vector2(randomCoords.x + math.random(-halfRadius, halfRadius), randomCoords.y + math.random(-halfRadius, halfRadius))
    TriggerClientEvent('sf-houserobbery:houseBlip', source, randomCoords)
    PlayerMissions[source] = missionId

end

function GetFreeLocation()
    local freeHouses = {}
    local time = os.time()
    for k, v in pairs(Config.Houses) do
        if(not UsedLocations[k] or time - UsedLocations[k] > Config.LocationCooldown) then
            table.insert(freeHouses, k)
        end
    end
    local locationId = freeHouses[math.random(1, #freeHouses)]
    UsedLocations[locationId] = os.time()
    return locationId
end

function OnLockpickUse(source)
    if(PlayerMissions[source]) then
        local mission = Missions[PlayerMissions[source]]
        if(not mission) then return end
        local playerPed = GetPlayerPed(source)
        if(#(GetEntityCoords(playerPed) - Config.Houses[mission.houseId].coords.xyz) < 2.0 and not Houses[mission.houseId]) then
            if(Config.NightOnly) then
                local hour = TriggerClientCallback("getClockHour", source)
                if(not hour) then return end
                if(not ((hour >= 20 and hour <= 24) or (hour <= 6 and hour >= 0))) then
                    ShowNotification(source, _L("lockpick_night_only"))
                    return
                end
            end
            Citizen.CreateThread(function()
                local success = TriggerClientCallback("lockpickHouse", source)
                if(not success) then return end
                local house = CreateHouse(mission.houseId, source)
                house.addPlayer(source)
                TriggerClientEvent("sf-houserobbery:houseBlip", source, nil)
                TriggerClientEvent("sf-houserobbery:houseState", -1, house.id, true)
                Missions[PlayerMissions[source]] = nil
                PlayerMissions[source] = nil
            end)
            return true
        end
    end
    return false
end

exports("UseLockpick", OnLockpickUse)

AddEventHandler("playerDropped", function()
    local _source = source
    if(PlayerMissions[_source]) then
        Missions[PlayerMissions[_source]] = nil
        PlayerMissions[_source] = nil
    end
end)

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(Missions) do
            if(os.time() - v.time > Config.AfkTime) then
                SendMessageToPlayer(v.owner, "afk_end")
                PlayerMissions[v.owner] = nil
                Missions[k] = nil
            end
        end
        Citizen.Wait(1000)
    end
end)

-- if(Config.DevMode) then
    -- RegisterCommand("teleporttohouse", function(source)
    --     if(PlayerMissions[source]) then
    --         local playerPed = GetPlayerPed(source)
    --         local mission = Missions[PlayerMissions[source]]
    --         if(not mission) then return end
    --         SetEntityCoords(playerPed, Config.Houses[mission.houseId].coords.xyz)
    --     end
    -- end, false)
-- end