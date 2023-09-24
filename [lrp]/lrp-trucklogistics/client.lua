
local truck,truck_blip,trailer,trailer_blip,rentTruck,route_blip
menuactive = false
empresaAtual = nil
loading = false
cooldown = nil
local QBCore = exports['lrp-core']:GetCoreObject()

isLoggedIn = false
PlayerJob = {}

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    isLoggedIn = true
	addBlip()
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------	





RegisterNetEvent('lrp-trucklogistics:client:truckermenu')
AddEventHandler('lrp-trucklogistics:client:truckermenu', function()
	SetNuiFocus(false,false)
	QBCore.Functions.TriggerCallback('lrp-trucklogistics:server:licencecheck', function (license)

		if license then
			for k,mark in pairs(Config.empresas) do
				empresaAtual = k
				TriggerServerEvent("lrp-trucklogistics:getData")
			end
		else
			QBCore.Functions.Notify("You don\'t have a CDL license, Attend to the DMV to get you Class A license.")
		end
	end)
end)



RegisterNetEvent('lrp-trucklogistics:open')
AddEventHandler('lrp-trucklogistics:open', function(dados,update)
	-- Calcula a distancia e recompensa para cada contrato
	local x1,y1,z1 = table.unpack(GetEntityCoords(PlayerPedId()))
	for k,v in pairs(dados.trucker_available_contracts) do
		local x2,y2,z2 = table.unpack(Config.locais_entrega[v.coords_index])
		-- local distance = CalculateTravelDistanceBetweenPoints(x1,y1,z1, x2, y2, z2)
		-- if distance > 50 then
			distance = #(vector3(x1,y1,z1) - vector3(x2,y2,z2))
		-- end
		dados.trucker_available_contracts[k]['distance'] = tonumber(string.format("%.2f", (distance/1000)))
		dados.trucker_available_contracts[k]['reward'] = tonumber(string.format("%.f", (v.distance * v.price_per_km)))
	end
	
	-- Abre NUI
	SendNUIMessage({ 
		showmenu = true,
		update = update,
		dados = dados
	})
	if update == false then
		menuactive = true
		SetNuiFocus(true,true)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback('startJob', function(data, cb)
	if cooldown == nil then
		cooldown = true
		
		if not loading then
			TriggerServerEvent('lrp-trucklogistics:startContract',data)
		else
			QBCore.Functions.Notify(Lang[Config.lang]['loading_trailer'], "primary")
			closeUI()
		end
		
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('upgradeSkill', function(data, cb)
	TriggerServerEvent('lrp-trucklogistics:upgradeSkill',data)
end)

RegisterNUICallback('repairTruck', function(data, cb)
	if truck and not rentTruck then
		QBCore.Functions.Notify(Lang[Config.lang]['store_truck'], "error")
		return
	end
	TriggerServerEvent('lrp-trucklogistics:repairTruck',data.id)
end)

RegisterNUICallback('buyTruck', function(data, cb)
	TriggerServerEvent('lrp-trucklogistics:buyTruck',data)
end)

RegisterNUICallback('sellTruck', function(data, cb)
	if cooldown == nil then
		cooldown = true
		
		if truck and not rentTruck then
			QBCore.Functions.Notify(Lang[Config.lang]['store_truck_2'], "error")
			return
		end
		TriggerServerEvent('lrp-trucklogistics:sellTruck',data)
		
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('fireDriver', function(data, cb)
	TriggerServerEvent('lrp-trucklogistics:fireDriver',data.driver_id)
end)

RegisterNUICallback('spawnTruck', function(data, cb)
	if cooldown == nil then
		cooldown = true
		
		if not loading then
			TriggerServerEvent('lrp-trucklogistics:spawnTruck',data.truck_id)
		else
			QBCore.Functions.Notify(Lang[Config.lang]['loading_truck'], "primary")
			closeUI()
		end
		
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('hireDriver', function(data, cb)
	TriggerServerEvent('lrp-trucklogistics:hireDriver',data.driver_id)
end)

RegisterNUICallback('setDriver', function(data, cb)
	TriggerServerEvent('lrp-trucklogistics:setDriver',data)
end)

RegisterNUICallback('depositMoney', function(data, cb)
	TriggerServerEvent('lrp-trucklogistics:depositMoney',data)
end)

RegisterNUICallback('withdrawMoney', function(data, cb)
	if cooldown == nil then
		cooldown = true
		
		TriggerServerEvent('lrp-trucklogistics:withdrawMoney')
		
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('loan', function(data, cb)
	if cooldown == nil then
		cooldown = true
		
		TriggerServerEvent('lrp-trucklogistics:loan',data)
		
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('payLoan', function(data, cb)
	TriggerServerEvent('lrp-trucklogistics:payLoan',data)
end)


RegisterNUICallback('close', function(data, cb)
	closeUI()
end)

function closeUI()
	empresaAtual = nil
	menuactive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ hidemenu = true })
	TriggerServerEvent('lrp-trucklogistics:closeUI')
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PEGAR CAMINHÃO PRÓPRIO
-----------------------------------------------------------------------------------------------------------------------------------------
local updateTruckStatus = 0
RegisterNetEvent('lrp-trucklogistics:spawnTruck')
AddEventHandler('lrp-trucklogistics:spawnTruck', function(truck_data)



	if not IsEntityAVehicle(truck) then
		DeleteVehicle(truck)
		RemoveBlip(truck_blip)
		truck = nil
		truck_blip = nil
		rentTruck = false
	end
	if truck then
		QBCore.Functions.Notify(Lang[Config.lang]['already_has_truck'], "error")
		return
	end
	
	loading = true

	local garagem = Config.empresas[empresaAtual]['coordenada_garagem']

	local i = #garagem
	local x,y,z,h
	while i > 0 do
		Wait(0)
		x,y,z,h = table.unpack(garagem[i])
		local checkPos = IsSpawnPointClear({['x']=x,['y']=y,['z']=z},5.001)
		if checkPos == false then
			if i <= 1 then
				QBCore.Functions.Notify(Lang[Config.lang]['occupied_places'], "error")
				loading = false
				return
			end
		else
			break
		end
		i = i - 1
	end
	truck,truck_blip = spawnVehicle(truck_data.truck_name,x,y,z,h,truck_data.body,truck_data.engine,truck_data.transmission,truck_data.wheels,477,26,Lang[Config.lang]['truck_blip'])

	TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(truck))
	SetVehicleDoorsLocked(truck, 2)

	QBCore.Functions.Notify(Lang[Config.lang]['already_is_in_garage'], "success")
	loading = false

	local timer = 5
	local engineH = 1000
	
	while IsEntityAVehicle(truck) do
		Wait(timer)
		timer = 2000
		local ped = PlayerPedId()
		veh = GetVehiclePedIsIn(ped,false)
		if veh == truck then
			engineH = GetVehicleEngineHealth(truck)
			for k,v in pairs(Config.empresas) do
				for k,mark in pairs(v.coordenada_garagem) do
					local x,y,z = table.unpack(mark)
					local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
					if distance <= 20.0 then
						timer = 5
						DrawMarker(39,x,y,z,0,0,0,0.0,0,0,2.0,2.0,2.0,255,0,0,50,0,0,0,1)
						if distance <= 5.0 then
							drawTxt(Lang[Config.lang]['press_e_to_store_truck'], 8,0.5,0.90,0.50,255,255,255,180)
							if IsControlJustPressed(0,38) then
								TriggerServerEvent("lrp-trucklogistics:updateTruckStatus",truck_data,GetVehicleEngineHealth(truck),GetVehicleBodyHealth(truck))
								DeleteVehicle(truck)
								RemoveBlip(truck_blip)
								truck = nil
								truck_blip = nil
							end
						end
					else
						if updateTruckStatus == 0 and engineH ~= GetVehicleEngineHealth(truck) then
							updateTruckStatus = 3
							TriggerServerEvent("lrp-trucklogistics:updateTruckStatus",truck_data,GetVehicleEngineHealth(truck),GetVehicleBodyHealth(truck))
							engineH = GetVehicleEngineHealth(truck)
						end
					end
				end
			end
		end
	end
	DeleteEntity(truck)
	RemoveBlip(truck_blip)
	truck = nil
	truck_blip = nil
end)

--[[
Citizen.CreateThread(function()
	while true do
		Wait(2500)
		if updateTruckStatus > 0 then
			updateTruckStatus = updateTruckStatus - 1
		end	
	end
end)]]--
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIAR TRABALHO
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('lrp-trucklogistics:startContract')
AddEventHandler('lrp-trucklogistics:startContract', function(data,job_distance,reward,truck_data)
	local key = empresaAtual
	if not IsEntityAVehicle(trailer) then
		DeleteVehicle(trailer)
		RemoveBlip(trailer_blip)
		RemoveBlip(route_blip)
		trailer = nil
		trailer_blip = nil
		route_blip = nil
		rentTruck = false
	end
	if trailer or rentTruck then
		QBCore.Functions.Notify(Lang[Config.lang]['already_has_cargo'], "error")
		return
	end

	if not IsEntityAVehicle(truck) then
		DeleteVehicle(truck)
		RemoveBlip(truck_blip)
		RemoveBlip(route_blip)
		truck = nil
		truck_blip = nil
		route_blip = nil
		rentTruck = false
	end
	if truck and data.contract_type == 0 then
		QBCore.Functions.Notify(Lang[Config.lang]['must_store_truck'], "error")
		return
	end

	Citizen.CreateThreadNow(function()
		resetLoading()
	end)

	loading = true
	local x,y,z,h
	if data.contract_type == 0 then
		local garagem = Config.empresas[key]['coordenada_garagem']
		local i = #garagem
		while i > 0 do
			Wait(0)
			x,y,z,h = table.unpack(garagem[i])
			local checkPos = IsSpawnPointClear({['x']=x,['y']=y,['z']=z},5.001)
			if checkPos == false then
				if i <= 1 then
					TriggerEvent("Notify","negado",Lang[Config.lang]['occupied_places'])
					loading = false
					return
				end
			else
				break
			end
			i = i - 1
		end
		truck,truck_blip = spawnVehicle(data.truck,x,y,z,h,1000,1000,1000,1000,477,26,Lang[Config.lang]['rented_truck_blip'])
		rentTruck = true
	end
	
	local cargas = Config.empresas[key]['coordenada_cargas']
	i = #cargas
	while i > 0 do
		Wait(0)
		x,y,z,h = table.unpack(cargas[i])
		local checkPos = IsSpawnPointClear({['x']=x,['y']=y,['z']=z},5.001)
		if checkPos == false then
			if i <= 1 then
				if rentTruck then
					DeleteVehicle(truck)
					RemoveBlip(truck_blip)
					truck = nil
					truck_blip = nil
					rentTruck = false
				end
				QBCore.Functions.Notify(Lang[Config.lang]['occupied_places'], "error")
				loading = false
				return
			end
		else
			break
		end
		i = i - 1
	end
	trailer,trailer_blip = spawnVehicle(data.trailer,x,y,z,h,1000,1000,1000,1000,479,26,Lang[Config.lang]['cargo_blip'])
	QBCore.Functions.Notify(Lang[Config.lang]['started_job'], "success")
	loading = false


	TriggerServerEvent('lrp-trucklogistics:deleteContract',data.contract_id)
	local timer = 5
	x,y,z,h = table.unpack(Config.locais_entrega[data.coords_index])

	route_blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(route_blip,1)
	SetBlipColour(route_blip,5)
	SetBlipAsShortRange(route_blip,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Lang[Config.lang]['destination_blip'])
	EndTextCommandSetBlipName(route_blip)
	SetBlipRoute(route_blip,true)
	closeUI()


	while IsEntityAVehicle(trailer) do 
		timer = 2000
		local ped = PlayerPedId()
		veh = GetVehiclePedIsIn(ped,false)
		local distance = #(GetEntityCoords(ped) - vector3(x,y,z))
		

		if distance <= 20.0 then
			timer = 5
			
			if distance <= 7.0 and veh == truck and GetEntityHeading(truck) + 10 >= h and GetEntityHeading(truck) - 10 <= h and GetEntityHeading(trailer) + 10 >= h and GetEntityHeading(trailer) - 10 <= h and IsEntityAttachedToEntity(truck,trailer) then				
				DrawMarker(30,x,y,z-0.6,0,0,0,90.0,h,0.0,3.0,1.0,10.0,0,255,0,50,0,0,0,0)
				drawTxt(Lang[Config.lang]['press_e_to_park'], 8,0.5,0.90,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) then				
					DeleteVehicle(trailer)
					RemoveBlip(trailer_blip)
					RemoveBlip(route_blip)
					Citizen.CreateThreadNow(function()
						showScaleform(Lang[Config.lang]['success'], Lang[Config.lang]['finished_job'], 3)
					end)

					trailer = nil
					trailer_blip = nil
					route_blip = nil
					TriggerServerEvent("lrp-trucklogistics:finishJob",data,job_distance,reward,truck_data,GetVehicleEngineHealth(truck),GetVehicleBodyHealth(truck),GetVehicleBodyHealth(trailer))
					break
				end
			else
				drawTxt(Lang[Config.lang]['park_your_truck'], 8,0.5,0.90,0.50,255,255,255,180)
				DrawMarker(30,x,y,z-0.6,0,0,0,90.0,h,0.0,3.0,1.0,10.0,255,0,0,50,0,0,0,0)
			end	
		end	
		Wait(timer)
	end


	while IsEntityAVehicle(truck) and data.contract_type == 0 do 
		timer = 2000
		Wait(timer)
		local ped = PlayerPedId()
		veh = GetVehiclePedIsIn(ped,false)
		for k,v in pairs(Config.empresas) do
			for k,mark in pairs(v.coordenada_garagem) do
				local x,y,z = table.unpack(mark)
				local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
				timer = 5
				if veh == truck and distance <= 20.0 then
					DrawMarker(39,x,y,z,0,0,0,0.0,0,0,2.0,2.0,2.0,255,0,0,50,0,0,0,1)
					if distance <= 5.0 then
						drawTxt(Lang[Config.lang]['press_e_to_store_truck'], 8,0.5,0.90,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) then
							DeleteVehicle(truck)
							RemoveBlip(truck_blip)
							RemoveBlip(route_blip)
							truck = nil
							truck_blip = nil
							route_blip = nil
							rentTruck = false
						end
					end
				else
					drawTxt(Lang[Config.lang]['bring_back'], 8,0.5,0.90,0.50,255,255,255,180)
				end
			end
		end
	end

	DeleteVehicle(trailer)
	RemoveBlip(trailer_blip)
	RemoveBlip(route_blip)
	trailer = nil
	trailer_blip = nil
	route_blip = nil
	rentTruck = false
	if data.contract_type == 0 then
		DeleteVehicle(truck)
		RemoveBlip(truck_blip)
		truck = nil
		truck_blip = nil
	end
end)

function resetLoading()
	Citizen.Wait(50000)
	if loading == true then
		QBCore.Functions.Notify(Lang[Config.lang]['loading_fail'], "error")
		loading = false
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------

function showScaleform(title, desc, sec)
	function Initialize(scaleform)
		local scaleform = RequestScaleformMovie(scaleform)

		while not HasScaleformMovieLoaded(scaleform) do
			Wait(10)
		end
		PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
		PushScaleformMovieFunctionParameterString(title)
		PushScaleformMovieFunctionParameterString(desc)
		PopScaleformMovieFunctionVoid()
		return scaleform
	end
	scaleform = Initialize("mp_big_message_freemode")
	while sec > 0 do
		sec = sec - 0.02
		Wait(0)
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
	end
	SetScaleformMovieAsNoLongerNeeded(scaleform)
end

function addBlip()
	local truck = AddBlipForCoord(vector3(1208.57, -3115.11, 5.54))
	SetBlipSprite (truck, 477)
	SetBlipDisplay(truck, 4)
	SetBlipScale  (truck, 0.75)
	SetBlipAsShortRange(truck, true)
	SetBlipColour(truck, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Trucker Logistics Job")
	EndTextCommandSetBlipName(truck)
end



function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end

	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))

		if distance <= maxDistance then
			table.insert(nearbyEntities, isPlayerEntities and k or entity)
		end
	end

	return nearbyEntities
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		local next = true

		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

GetVehicles = function()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

GetVehiclesInArea = function(coords, maxDistance) return EnumerateEntitiesWithinDistance(GetVehicles(), false, coords, maxDistance) end
IsSpawnPointClear = function(coords, maxDistance) return #GetVehiclesInArea(coords, maxDistance) == 0 end



RegisterNetEvent('lrp-trucklogistics:vehicleClientLock')
AddEventHandler('lrp-trucklogistics:vehicleClientLock', function()
	local v = truck
	if DoesEntityExist(v) and IsEntityAVehicle(v) then
		local lock = GetVehicleDoorLockStatus(v)
		playAnim(true,{{"anim@mp_player_intmenu@key_fob@","fob_click"}},false)
		TriggerEvent("vrp_sound:source",'lock',0.5)
		if lock == 1 then
			SetVehicleDoorsLocked(v,2)
			QBCore.Functions.Notify(Lang[Config.lang]['locked'], "primary", 8000)
		else
			SetVehicleDoorsLocked(v,1)
			QBCore.Functions.Notify(Lang[Config.lang]['unlocked'], "primary", 8000)
		end
		SetVehicleLights(v,2)
		Wait(200)
		SetVehicleLights(v,0)
		Wait(200)
		SetVehicleLights(v,2)
		Wait(200)
		SetVehicleLights(v,0)
	end
end)

local anims = {}

function playAnim(upper, seq, looping)
    stopAnim(upper)

    local flags = 0
    if upper then flags = flags+48 end
    if looping then flags = flags+1 end

    Citizen.CreateThread(function()
      for k,v in pairs(seq) do
        local dict = v[1]
        local name = v[2]
        local loops = v[3] or 1

        for i=1,loops do
            local first = (k == 1 and i == 1)
            local last = (k == #seq and i == loops)

            -- request anim dict
            RequestAnimDict(dict)
            local i = 0
            while not HasAnimDictLoaded(dict) and i < 1000 do -- max time, 10 seconds
              Wait(10)
              RequestAnimDict(dict)
              i = i+1
            end

            -- play anim
            if HasAnimDictLoaded(dict)then
              local inspeed = 8.0001
              local outspeed = -8.0001
              if not first then inspeed = 2.0001 end
              if not last then outspeed = 2.0001 end

              TaskPlayAnim(GetPlayerPed(-1),dict,name,inspeed,outspeed,-1,flags,0,0,0,0)
            end

            Wait(0)
            while GetEntityAnimCurrentTime(GetPlayerPed(-1),dict,name) <= 0.95 and IsEntityPlayingAnim(GetPlayerPed(-1),dict,name,3) and anims[id] do
              Wait(0)
            end
          end
      end
    end)
end


function stopAnim(upper)
	anims = {} -- stop all sequences
	if upper then
	  	ClearPedSecondaryTask(GetPlayerPed(-1))
	else
	  	ClearPedTasks(GetPlayerPed(-1))
	end
end


--[[
function print_table(node)
    -- to make output beautiful
    local function tab(amt)
        local str = ""
        for i=1,amt do
            str = str .. "\t"
        end
        return str
    end
 
    local cache, stack, output = {},{},{}
    local depth = 1
    local output_str = "{\n"
 
    while true do
		Wait(1000)
        local size = 0
        for k,v in pairs(node) do
            size = size + 1
        end
 
        local cur_index = 1
        for k,v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then
               
                if (string.find(output_str,"}",output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str,"\n",output_str:len())) then
                    output_str = output_str .. "\n"
                end
 
                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output,output_str)
                output_str = ""
               
                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "["..tostring(k).."]"
                else
                    key = "['"..tostring(k).."']"
                end
 
                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. tab(depth) .. key .. " = "..tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. tab(depth) .. key .. " = {\n"
                    table.insert(stack,node)
                    table.insert(stack,v)
                    cache[node] = cur_index+1
                    break
                else
                    output_str = output_str .. tab(depth) .. key .. " = '"..tostring(v).."'"
                end
 
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. tab(depth-1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. tab(depth-1) .. "}"
                end
            end
 
            cur_index = cur_index + 1
        end
 
        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end
 
    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output,output_str)
    output_str = table.concat(output)
   
    print(output_str)
end]]--



exports['lrp-target']:AddBoxZone("Truckermenu", vector3(1208.7689208984,-3114.9829101562,5.5403342247009), 2.5, 2.5, {
    name="Trucker Menu",
    heading = 274.39,
    debugPoly = false,
    minZ = 2.5,
    maxZ = 8.5,
    }, 
    {
    options = {
        {
            type = "client",
            event = "lrp-trucklogistics:client:truckermenu",
            icon = "fas fa-bars",
            label = "Open Trucker Job Menu",
        },
    },
    distance = 2.5
})
