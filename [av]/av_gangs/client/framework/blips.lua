local graffitiBlips = {}
local showBlips = true

RegisterCommand(Config.ShowBlips, function()
    showBlips = not showBlips
    SetBlips()
end)

function SetBlips()
    if not Authorized() then return end
    if showBlips then
        if #graffitiBlips > 0 then
            for i=1, #graffitiBlips do
                RemoveBlip(graffitiBlips[i])
            end
        end
        if allGraffitis and allGraffitis[1] then
            for i=1, #allGraffitis do
                local v = allGraffitis[i]
                local blip = AddBlipForRadius(v['coords'].x, v['coords'].y, v['coords'].z, Config.ZoneRadius)
                SetBlipColour(blip, Config.Sprays[v['gang']].blipColor)
                SetBlipAlpha(blip, 128)
                graffitiBlips[#graffitiBlips+1] = blip
            end
        end
    else
        if allGraffitis and allGraffitis[1] then
            for i=1, #graffitiBlips do
                RemoveBlip(graffitiBlips[i])
            end
        end
    end
end

RegisterNetEvent('av_gangs:adminBlips', function()
    showBlips = not showBlips
    if showBlips then
        if #graffitiBlips > 0 then
            for i=1, #graffitiBlips do
                RemoveBlip(graffitiBlips[i])
            end
        end
        if allGraffitis and allGraffitis[1] then
            for i=1, #allGraffitis do
                local v = allGraffitis[i]
                local blip = AddBlipForRadius(v['coords'].x, v['coords'].y, v['coords'].z, Config.ZoneRadius)
                SetBlipColour(blip, Config.Sprays[v['gang']].blipColor)
                SetBlipAlpha(blip, 128)
                graffitiBlips[#graffitiBlips+1] = blip
            end
        end
    else
        if allGraffitis and allGraffitis[1] then
            for i=1, #graffitiBlips do
                RemoveBlip(graffitiBlips[i])
            end
        end
    end
end)