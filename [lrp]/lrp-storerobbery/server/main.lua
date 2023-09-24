local QBCore = exports['lrp-core']:GetCoreObject()


RegisterNetEvent('qb-storerobbery:server:register', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	
    Player.Functions.AddMoney('cash', math.random(150, 200))
end)

local RobbedRegisters = {}

QBCore.Functions.CreateCallback('qb-storerobbery:server:canrobregister', function(source, cb, registerId)
    local canrob = true
    for i = 1, #RobbedRegisters do
        if registerId == RobbedRegisters[i] then
            canrob = false
        end
    end

    if canrob then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('qb-storerobbery:server:emptyregister', function(registerId)
    RobbedRegisters[#RobbedRegisters + 1] = registerId
end)

local onCoolDown = false

RegisterNetEvent('qb-storerobbery:server:startcooldown', function(registerId)
    Citizen.CreateThread(function()
        onCoolDown = true
        Citizen.Wait(1200000)
        onCoolDown = false
    end)
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:checkcooldown', function(source, cb)
    cb(onCoolDown)
end)

local RobbedSafes = {}

QBCore.Functions.CreateCallback('qb-storerobbery:server:canrobsafe', function(source, cb, SafeID)
    local canrob = true

    for i = 1, #RobbedSafes do
        print(RobbedSafes[i])
        if SafeID == RobbedSafes[i] then
            canrob = false
        end
    end

    if canrob then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('qb-storerobbery:server:emptysafe', function(SafeID)
    RobbedSafes[#RobbedSafes + 1] = SafeID
end)

RegisterNetEvent('qb-storerobbery:server:safe', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	
    Player.Functions.AddMoney('cash', math.random(9000, 15000))

    if math.random(1, 100) <= 10 then
        Player.Functions.AddItem("usb_green", 1)
    end
end)