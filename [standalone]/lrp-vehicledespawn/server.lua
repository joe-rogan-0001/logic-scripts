local vehicles = {}

function dprint(msg)
	if debugMode then
		print(msg)
	end
end

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

 function table.empty (self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end

RegisterNetEvent('vehicledespawn:save')
AddEventHandler('vehicledespawn:save', function(id, model, x, y, z, heading, mods)
	dprint("Saving vehicles")
	local foundvehicle = false
	local indexval = -1

	if not table.empty(vehicles) then
		for i = 1, #vehicles do
			if vehicles[i].id == id then
				indexval = i
				foundvehicle = true
			end
		end
	end
	
	if foundvehicle then
		dprint("Replacing Value")
		vehicles[indexval] = {
			id = id,
			model = model,
			x = x,
			y = y,
			z = z,
			heading = heading,
			mods = mods
		}
	else
		dprint("Updating Existing Value")
		vehicles[#vehicles + 1] = {
			id = id,
			model = model,
			x = x,
			y = y,
			z = z,
			heading = heading,
			mods = mods
		}
	end
end)

RegisterNetEvent('vehicledespawn:retrieveTable')
AddEventHandler('vehicledespawn:retrieveTable', function()
	dprint("Retriving Table")
	TriggerClientEvent('vehicledespawn:checkVehs', -1, vehicles)
end)

RegisterNetEvent('vehicledespawn:updateId')
AddEventHandler('vehicledespawn:updateId', function(oldId, newId)
	dprint("Checking for id to replace")
	for i = 1, #vehicles do
		if vehicles[i].id == oldId then
			dprint("Replacing id")
			vehicles[i].id = newId
		end
	end
end)