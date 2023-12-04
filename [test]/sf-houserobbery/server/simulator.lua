if(not Config.DevMode) then return end

-- Perfoms a simulation of full house robbery
RegisterCommand("__housesimfull", function(source, args)
	if(source == 0) then
        if(not args[1] or not Config.StashItems[args[1]]) then
            print("You need to enter a valid interior name [low, medium, high]")
            return
        end
		if(not args[2] or not tonumber(args[2])) then
			print("You need to enter number of tries")
			return
		end
		local testTimes = math.floor(tonumber(args[2]))
        local totalAmount = 0
        local totalTime = 0
        local interiorName = args[1]
        local function GetRandomHouseDrop()
            local amount, time = 0, 0
            -- stashes
            for i=1, #Config.Interiors[interiorName].stashes do
                for j=1, math.random(Config.StashItemCount[interiorName][1], Config.StashItemCount[interiorName][2]) do
                    local stashItem = GetStashItem(interiorName)
                    local count = type(stashItem.count) == "number" and stashItem.count or math.random(stashItem.count[1], stashItem.count[2])
                    time += Config.SearchTime/1000
                    if(stashItem.name == "money") then
                        amount += count
                    else
                        if(not Config.ItemPrices[stashItem.name]) then
                            print(stashItem.name .. " is not in the Config.ItemPrices!")
                        else
                            amount += (Config.ItemPrices[stashItem.name] * count)
                        end
                    end
                end
            end
            local interiorProps = Config.Interiors[interiorName].props
            local props = {}
            local tries = 0
            local function getRandomProp()
                local prop = interiorProps[math.random(1, #interiorProps)]
                if(props[prop.itemName] or prop.itemName == "alarm" or prop.itemName == "safe") then
                    tries += 1
                    if(tries > 50) then
                        Citizen.Wait(0)
                        tries = 0
                    end
                    return getRandomProp()
                end
                props[prop.itemName] = true
                return prop
            end
            for i=1, #interiorProps-2 do
                getRandomProp()
            end
            for k, v in pairs(props) do
                if(not Config.ItemPrices[k]) then
                    print(k .. " is not in the Config.ItemPrices!")
                else
                    amount += Config.ItemPrices[k]
                end
                time += 10 -- it takes aroudn 10 seconds to take the prop outside
            end
            if(math.random(1, 100) <= Config.SafeChance) then
                time += 60
                for i=1, math.random(Config.SafeItemCount[interiorName][1], Config.SafeItemCount[interiorName][2]) do
                    local safeItem = GetSafeItem(interiorName)
                    local count = type(safeItem.count) == "number" and safeItem.count or math.random(safeItem.count[1], safeItem.count[2])
                    if(safeItem.name == "money") then
                        amount += count
                    else
                        if(not Config.ItemPrices[safeItem.name]) then
                            print(safeItem.name .. " is not in the Config.ItemPrices!")
                        else
                            amount += (Config.ItemPrices[safeItem.name] * count)
                        end
                    end
                end
            end
            return amount, time
        end
        for i=1, testTimes do
            local amount, time = GetRandomHouseDrop()
            totalAmount += amount
            totalTime += time
			if(i % 2500 == 0) then
				Citizen.Wait(0)
			end
		end
		print(("Average money: %d; Average time: %s; Total money: %d; Total time: %s"):format(math.floor(totalAmount/testTimes), GetTime(math.floor(totalTime/testTimes)), math.floor(totalAmount), GetTime(math.floor(totalTime))))
	end
end, true)

-- Perfoms a simulation of house robbery
RegisterCommand("__housesim", function(source, args)
	if(source == 0) then
        if(not args[1] or not Config.StashItems[args[1]]) then
            print("You need to enter a valid interior name [low, medium, high]")
            return
        end
		if(not args[2] or not tonumber(args[2])) then
			print("You need to enter number of tries")
			return
		end
		local testTimes = math.floor(tonumber(args[2]))
        local totalAmount = 0
        local totalTime = 0
        local interiorName = args[1]
        local function GetRandomHouseDrop()
            local amount, time = 0, 0
            -- stashes
            for i=1, math.random(1, #Config.Interiors[interiorName].stashes) do
                for j=1, math.random(Config.StashItemCount[interiorName][1], Config.StashItemCount[interiorName][2]) do
                    local stashItem = GetStashItem(interiorName)
                    local count = type(stashItem.count) == "number" and stashItem.count or math.random(stashItem.count[1], stashItem.count[2])
                    time += Config.SearchTime/1000
                    if(stashItem.name == "money") then
                        amount += count
                    else
                        if(not Config.ItemPrices[stashItem.name]) then
                            print(stashItem.name .. " is not in the Config.ItemPrices!")
                        else
                            amount += (Config.ItemPrices[stashItem.name] * count)
                        end
                    end
                end
            end
            local interiorProps = Config.Interiors[interiorName].props
            local props = {}
            local tries = 0
            local function getRandomProp()
                local prop = interiorProps[math.random(1, #interiorProps)]
                if(props[prop.itemName] or prop.itemName == "alarm" or prop.itemName == "safe") then
                    tries += 1
                    if(tries > 50) then
                        Citizen.Wait(0)
                        tries = 0
                    end
                    return getRandomProp()
                end
                props[prop.itemName] = true
                return prop
            end
            for i=1, math.random(1, #interiorProps-2) do
                getRandomProp()
            end
            for k, v in pairs(props) do
                if(not Config.ItemPrices[k]) then
                    print(k .. " is not in the Config.ItemPrices!")
                else
                    amount += Config.ItemPrices[k]
                end
                time += 10 -- it takes aroudn 10 seconds to take the prop outside
            end
            if(math.random(1, 100) <= Config.SafeChance) then
                time += 60
                for i=1, math.random(Config.SafeItemCount[interiorName][1], Config.SafeItemCount[interiorName][2]) do
                    local safeItem = GetSafeItem(interiorName)
                    local count = type(safeItem.count) == "number" and safeItem.count or math.random(safeItem.count[1], safeItem.count[2])
                    if(safeItem.name == "money") then
                        amount += count
                    else
                        if(not Config.ItemPrices[safeItem.name]) then
                            print(safeItem.name .. " is not in the Config.ItemPrices!")
                        else
                            amount += (Config.ItemPrices[safeItem.name] * count)
                        end
                    end
                end
            end
            return amount, time
        end
        for i=1, testTimes do
            local amount, time = GetRandomHouseDrop()
            totalAmount += amount
            totalTime += time
			if(i % 2500 == 0) then
				Citizen.Wait(0)
			end
		end
		print(("Average money: %d; Average time: %s; Total money: %d; Total time: %s"):format(math.floor(totalAmount/testTimes), GetTime(math.floor(totalTime/testTimes)), math.floor(totalAmount), GetTime(math.floor(totalTime))))
	end
end, true)

function GetTime(value)
	local minutes = math.floor(value/60)
	local seconds = value - minutes*60
	return string.format("%02d:%02d", minutes, seconds)
end