local currentStation = nil
local points = {}
local events = {
    ['charge'] = 'av_laptop:chargeStation',
    ['reset'] = 'av_laptop:resetStation',
}
local resetMenu = lib.registerContext({
  id = 'reset_menu',
  title = Lang['reset_station'],
  options = {
    {
      title = Lang['open_stash'],
      icon = 'box',
      event = "av_laptop:openResetStash",
    },
    {
      title = Lang['reset_laptop'],
      icon = 'laptop',
      event = "av_laptop:resetLaptop",
    },
  }
})

if useZones and Config.Inventory == "ox_inventory" then
    for k, v in pairs(Stations) do
        points[#points+1] = lib.points.new({
            label = Lang['interact'],
            distance = 1.5,
            coords = v['coords'],
            job = v['job'],
            args = k,
            type = v['type']
        })
    end
    for k, v in pairs(points) do
        function v:onExit()
            if lib.isTextUIOpen() then
                lib.hideTextUI()
            end
        end     
        function v:nearby()
            if self.currentDistance <= 1.5 and (self.job == PlayerJob.name) then
                if not lib.isTextUIOpen() then
                    lib.showTextUI(self.label)
                end
                if IsControlJustPressed(0,38) then
                    TriggerEvent(events[self.type], self.args)
                end
            end
        end
    end
end

RegisterNetEvent('av_laptop:chargeStation', function(station)
    if not station then print('av_laptop:chargeStation received a null argument') return end
    if not Stations[station] then print('av_laptop:chargeStation received a non existing station name') return end
    if Config.Inventory == "ox_inventory" then
        exports['ox_inventory']:openInventory('stash', station)
        return
    end
    if Config.Inventory == "qs-inventory" then
        local other = {}
        other.maxweight = Stations[station]['maxWeight']
        other.slots = Stations[station]['slots']
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "Stash_"..station, other)
        TriggerEvent("inventory:client:SetCurrentStash", "Stash_"..station)
        return
    end
    if Config.Inventory == "qb-inventory" or Config.Inventory == "lj-inventory" then
        local other = {}
        other.maxweight = Stations[station]['maxWeight']
        other.slots = Stations[station]['slots']
        TriggerServerEvent('inventory:server:OpenInventory','stash',station,other)
        return
    end
end)

RegisterNetEvent('av_laptop:resetStation', function(station)
    currentStation = station
    lib.showContext("reset_menu")
end)

RegisterNetEvent('av_laptop:resetLaptop', function()
    if not currentStation then print('av_laptop:resetLaptop received a null argument') return end
    if not Stations[currentStation] then print('av_laptop:resetLaptop received a non existing station name') return end
    if lib.progressCircle({
        duration = math.random(5000,10000),
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped'
        },
    }) then TriggerServerEvent('av_laptop:resetLaptop',currentStation) end
end)

RegisterNetEvent('av_laptop:openResetStash', function()
    if not currentStation then print('av_laptop:openResetStash received a null argument') return end
    if not Stations[currentStation] then print('av_laptop:openResetStash received a non existing station name') return end
    if Config.Inventory == "ox_inventory" then
        exports['ox_inventory']:openInventory('stash', currentStation)
        return
    end
    if Config.Inventory == "qs-inventory" then
        local other = {}
        other.maxweight = Stations[currentStation]['maxWeight']
        other.slots = Stations[currentStation]['slots']
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "Stash_"..currentStation, other)
        TriggerEvent("inventory:client:SetCurrentStash", "Stash_"..currentStation)
        return
    end
    if Config.Inventory == "qb-inventory" or Config.Inventory == "lj-inventory" then
        local other = {}
        other.maxweight = Stations[currentStation]['maxWeight']
        other.slots = Stations[currentStation]['slots']
        TriggerServerEvent('inventory:server:OpenInventory','stash',currentStation,other)
        return
    end
end)