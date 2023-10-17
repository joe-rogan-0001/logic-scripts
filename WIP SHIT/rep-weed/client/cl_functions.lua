Core = exports[Config.Framework]:GetCoreObject()

function Notification(msg, type , time)
    Core.Functions.Notify(msg, type, time)
end

function policeAlert(type)
    if type == 'cornering' then
    else
    end
	-- exports['qb-dispatch']:Oxy() -- Project-SLoth qb-dispatch
	-- TriggerServerEvent('police:server:policeAlert', 'Suspicious Hand-off') -- Regular qbcore
	-- These are just examples, you will have to implement your own system!
end

local armor = false

function Effect()
    local time = Config.Corner.Effect.Time
    armor = true
    CreateThread(function()
        while armor do
            time = time - 1
            if time >= 0 then
				SetPedArmour(PlayerPedId(), GetPedArmour(PlayerPedId()) + Config.Corner.Effect.Amount)
                TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
            else
                armor = false
            end
            Wait(1000)
        end
    end)
end

-- Police
RegisterNetEvent('police:SetCopCount', function(amount) -- Update your police count
    CurrentCops = amount
end)

CreateThread(function ()
    if Config.OxInventory then
        exports.ox_inventory:displayMetadata({
            strain = 'Strain',
            dry = 'Dry',
            water = 'Water',
            remainweight = 'Weights Left'
        })
    end
end)