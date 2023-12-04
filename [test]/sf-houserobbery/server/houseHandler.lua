Houses = {}
PlayerHouses = {}

function CreateHouse(houseId, ownerSource)
    local self = {}

    self.id = houseId
    self.players = {}
    self.owner = ownerSource
    self.interior = Config.Houses[houseId].type
    self.alarmTime = Config.AlarmTime
    self.alarmActive = false
    self.safeOpened = false
    self.alarmStart = os.time()
    self.takenProps = {}
    self.searchedStashes = {}
    self.hasSafe = math.random(1, 100) <= math.floor(Config.SafeChance)
    self.lastPlayerExit = os.time()
    self.lastPlayerEnter = os.time()

    if(not self.hasSafe) then
        for k, v in pairs(Config.Interiors[self.interior].props) do
            if(v.itemName == "safe") then
                self.takenProps[k] = true
                break
            end
        end
    end

    self.addPlayer = function(source)
        PlayerHouses[source] = self.id
        SetPlayerRoutingBucket(source, self.id)
        TriggerClientEvent("sf-houserobbery:houseEntered", source, self.id, self.takenProps, self.searchedStashes, self.safeOpened, self.alarmDisabled)
        if(self.alarmActive) then
            TriggerClientEvent("sf-houserobbery:alarmState", source, self.id, true)
        end
        self.lastPlayerEnter = os.time()
        self.players[source] = true
    end

    self.removePlayer = function(source)
        PlayerHouses[source] = self.id
        local playerPing = GetPlayerPing(source)
        if(self.players[source] and playerPing > 0 and playerPing < 500) then
            SetPlayerRoutingBucket(source, 0)
            TriggerClientEvent("sf-houserobbery:houseExit", source, self.id)
            OnPlayerRemove(source, houseId)
        end
        self.players[source]  = nil
        self.lastPlayerExit = os.time()
        if(not next(self.players)) then
            self.lastLeave = os.time()
            self.ensureDestroyThread()
        end
    end

    self.destroy = function()
        if(not self) then return end
        for source, _ in pairs(self.players) do
            self.removePlayer(source)
        end
        TriggerClientEvent("sf-houserobbery:houseState", -1, self.id, false)
        UsedLocations[self.id] = nil
        Houses[self.id] = nil
        self = nil
    end

    self.destroyThread = false
    self.ensureDestroyThread = function()
        if(self.destroyThread) then return end
        self.destroyThread = true
        Citizen.CreateThread(function()
            local hId = self.id
            while Houses[hId] do
                if(os.time() - Houses[hId].lastLeave >= Config.LastLeaveDestroy and next(Houses[hId].players) == nil) then
                    Houses[hId].destroy()
                    break
                end
                Citizen.Wait(1000)
            end
        end)
    end

    self.sendEventToPlayers = function(eventName, ...)
        local payload = msgpack.pack_args(...)
        for src, _ in pairs(self.players) do
            TriggerClientEventInternal(eventName, src, payload, payload:len())
        end
    end

    self.update = function()
        self.sendEventToPlayers("sf-houserobbery:updateHouse", self.id, self.takenProps, self.searchedStashes, self.safeOpened, self.alarmDisabled)
    end

    Citizen.CreateThread(function()
        local hId = self.id
        while Houses[hId] and (os.time() - self.alarmStart < Config.AlarmTime or self.alarmHacking) do
            Citizen.Wait(1000)
        end
        if(not Houses[hId]) then return end
        self.alarmActive = true
        self.sendEventToPlayers("sf-houserobbery:alarmState", self.id, true)
        DispatchHouse(self.owner, houseId)
    end)

    Citizen.CreateThread(function()
        local createTime = os.time()
        local hId = self.id
        local owner = self.owner
        while Houses[hId] do
            if(Houses[hId]?.owner ~= owner) then break end
            if(os.time() - createTime >= Config.AutoDestroy) then
                Houses[hId].destroy()
                break
            end
            Citizen.Wait(1000)
        end
    end)

    Houses[self.id] = self
    return self
end

RegisterNetEvent("sf-houserobbery:enterHouse", function(houseId)
    local _source = source
    if(Houses[houseId] and not Houses[houseId].players[_source]) then
        local playerPed = GetPlayerPed(_source)
        if(#(GetEntityCoords(playerPed) - Config.Houses[houseId].coords.xyz) > 50.0) then return end
        if(os.time() - Houses[houseId].lastPlayerExit > Config.DoorCooldown) then
            Houses[houseId].addPlayer(_source)
        else
            ShowNotification(_source, _L("door_in_use"))
        end
    end
end)

RegisterNetEvent("sf-houserobbery:exitHouse", function(houseId)
    local _source = source
    if(Houses[houseId] and Houses[houseId].players[_source]) then
        if(os.time() - Houses[houseId].lastPlayerEnter > Config.DoorCooldown) then
            Houses[houseId].removePlayer(_source)
        else
            ShowNotification(_source, _L("door_in_use"))
        end
    end
end)

RegisterNetEvent("sf-houserobbery:searchStash", function(houseId, spotId)
    local _source = source
    if(not PlayerHouses[_source] or PlayerHouses[_source] ~= houseId) then return end
    local house = Houses[PlayerHouses[_source]]
    if(not house) then return end
    if(house.searchedStashes[spotId] or spotId < 0 or spotId > #Config.Interiors[house.interior].stashes) then return end
    if(Player(_source).state.HasHRObject) then
        ShowNotification(_source, _L("holding_prop"))
        return
    end
    house.searchedStashes[spotId] = true
    local success = TriggerClientCallback("searchStash", _source)
    if(not success) then
        house.searchedStashes[spotId] = nil
        return
    end
    house.update()
    for i=1, math.random(Config.StashItemCount[house.interior][1], Config.StashItemCount[house.interior][2]) do
        local stashItem = GetStashItem(house.interior)
        Bridge.AddItem(_source, stashItem.name, type(stashItem.count) == "number" and stashItem.count or math.random(stashItem.count[1], stashItem.count[2]))
    end
end)

function DisableAlarm(source, house, prop)
    if(house.alarmDisabled) then
        ShowNotification(source, _L("alarm_already_disabled"))
        return
    end
    if(house.alarmDisabledHld) then
        ShowNotification(source, _L("alarm_already_rebooted"))
        return
    end
    if(house.alarmHacking) then
        ShowNotification(source, _L("alarm_being_hacked"))
        return
    end
    if(os.time() - house.alarmStart > Config.AlarmTime) then
        ShowNotification(source, _L("alarm_already_triggered"))
        return
    end
    for k, v in pairs(Config.DisableAlarm.requiredItems) do
        if(Bridge.GetItemCount(source, k) < v) then
            ShowNotification(source, _L("no_required_items"))
            return
        end
    end
    house.alarmHacking = true
    for k, v in pairs(Config.DisableAlarm.requiredItems) do
        Bridge.RemoveItem(source, k, v)
    end
    local success = TriggerClientCallback("hackAlarm", source, house.id, house.interior)
    house.alarmHacking = false
    if(not success) then return end
    house.alarmDisabled = true
    house.alarmDisabledHld = true
    house.alarmStart = os.time() + Config.DisableAlarm.addTime
    house.update()
    Citizen.CreateThread(function()
        local hId = house.id
        Citizen.Wait(Config.DisableAlarm.addTime * 1000)
        if(Houses[hId]) then
            Houses[hId].alarmDisabled = false
            Houses[hId].update()
        end
    end)
end

function OpenSafe(source, house, prop)
    if(not house.hasSafe or house.safeOpened) then
        ShowNotification(source, _L("safe_already_opened"))
        return
    end
    if(house.crackingSafe) then
        ShowNotification(source, _L("someone_cracking_safe"))
        return
    end
    house.crackingSafe = true
    local success = TriggerClientCallback("crackSafe", source, house.id, house.interior)
    if(not success) then
        house.crackingSafe = false
        return
    end
    house.safeOpened = true
    house.update()
    for i=1, math.random(Config.SafeItemCount[house.interior][1], Config.SafeItemCount[house.interior][2]) do
        local safeItem = GetSafeItem(house.interior)
        Bridge.AddItem(source, safeItem.name, type(safeItem.count) == "number" and safeItem.count or math.random(safeItem.count[1], safeItem.count[2]))
    end
end

CustomProps = {
    ["safe"] = OpenSafe,
    ["alarm"] = DisableAlarm
}

RegisterNetEvent("sf-houserobbery:takeProp", function(houseId, propId)
    local _source = source
    if(not PlayerHouses[_source] or PlayerHouses[_source] ~= houseId) then return end
    local house = Houses[PlayerHouses[_source]]
    if(not house) then return end
    if(house.takenProps[propId] or propId < 0 or propId > #Config.Interiors[house.interior].props) then return end
    if(Player(_source).state.HasHRObject) then
        ShowNotification(_source, _L("holding_prop"))
        return
    end
    local prop = Config.Interiors[house.interior].props[propId]
    if(CustomProps[prop.itemName]) then
        CustomProps[prop.itemName](_source, house, prop)
        return
    end
    house.takenProps[propId] = true
    local success = TriggerClientCallback("takeProp", _source)
    if(not success) then
        house.takenProps[propId] = nil
        return
    end
    house.update()
    Bridge.AddItem(_source, prop.itemName, 1)
end)

RegisterNetEvent("sf-houserobbery:lockHouse", function(houseId)
    local _source = source
    local house = Houses[houseId]
    if(not house) then return end
    local playerPed = GetPlayerPed(_source)
    if(#(GetEntityCoords(playerPed) - Config.Houses[houseId].coords.xyz) > 2.0) then return end
    if(not Bridge.CheckJob(_source, Config.PoliceJob, 0)) then return end
    if(next(house.players)) then
        ShowNotification(_source, _L("someone_in_house"))
        return
    end
    if(house.locking) then return end
    house.locking = true
    local success = TriggerClientCallback("lockHouse", _source)
    house.locking = false
    if(not success) then
        return
    end
    ShowNotification(_source, _L("locked_house"))
    house.destroy()
end)

function OnPlayerRemove(source, houseId)
    -- here you can integrate your holding/handcuffs scripts
end

function GetSafeItem(interior)
	local weights = {}
	for k, v in ipairs(Config.SafeItems[interior]) do
		weights[k] = v.chance
	end
	local index = WeightedRandom(weights)
	return Config.SafeItems[interior][index]
end

function GetStashItem(interior)
	local weights = {}
	for k, v in ipairs(Config.StashItems[interior]) do
		weights[k] = v.chance
	end
	local index = WeightedRandom(weights)
	return Config.StashItems[interior][index]
end

function WeightedRandom(weights)
    local summ = 0
    for i, weight in pairs (weights) do
        summ = summ + weight
    end
    if summ == 0 then return end
    local value = math.random() * summ
    summ = 0
    for i, weight in pairs (weights) do
        summ = summ + weight
        if value <= summ then
            return i, weight
        end
    end
end