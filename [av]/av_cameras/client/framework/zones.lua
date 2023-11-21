local points = {}
allCams = {}
myHackedGroups = {}

RegisterNetEvent('av_cameras:syncZones', function(data)
    allCams = data
    syncZones()
end)

function syncZones()
    for k, v in pairs(points) do
        v:remove()
        points[k] = nil
    end
    Wait(100)
    for k, v in pairs(allCams) do
        local group = Cameras[v['name']]
        points[#points+1] = lib.points.new({
            name = v['name'],
            label = group['label'],
            coords = group['powerCoords'],
            distance = 2,
            canEnable = group['canEnable'],
            canDisable = group['canDisable'],
        })
    end
    for k, v in pairs(points) do
        function v:onExit()
            if lib.isTextUIOpen() then
                lib.hideTextUI()
            end
            if currentTrolley then
                currentTrolley = false
            end
        end
        
        function v:nearby()
            local enable = false
            local disable = false
            if self.currentDistance <= self.distance then
                if not lib.isTextUIOpen() then
                    lib.showTextUI(Lang['interact'])
                end
                if IsControlJustPressed(0,38) then
                    if self.canEnable() then
                        enable = true
                        local res = enableCamAnimation()
                        if res then
                            TriggerServerEvent('av_cameras:hacked',self.name, self.coords, false)
                        end
                        return
                    end
                    if self.canDisable() then
                        disable = true
                        local res = hackingCamAnimation()
                        if res then
                            myHackedGroups[self.name] = true
                            TriggerServerEvent('av_cameras:hacked',self.name, self.coords, true)
                        end
                        return
                    end
                    if not enable and not disable then
                        TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['no_permission'],'error')
                    end
                end
            end
        end
    end
end