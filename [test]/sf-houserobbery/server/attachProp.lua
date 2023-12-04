if(GetResourceState("sf-attachobject") ~= "missing") then
    Attach = exports['sf-attachobject']
    for k, v in pairs(Config.ItemOffsets) do
        Attach:RegisterObject(k, v.model, vec3(v.offset[1], v.offset[2], v.offset[3]), vec3(v.offset[4], v.offset[5], v.offset[6]), v.bone, true, true)
    end
    
    RegisterServerCallback("sf-houserobbery:createAttach", function(source, itemName)
        if(not Config.ItemOffsets[itemName]) then return end
        return Attach:CreateAttachObject(source, itemName)
    end)

    RegisterNetEvent("sf-houserobbery:removeAttach", function(objId, removeItem)
        local _source = source
        local success = Attach:RemoveAttachObject(_source, tostring(objId))
        if(removeItem and Config.BreakOnJump and Config.ItemOffsets[removeItem] and success) then
            Bridge.RemoveItem(_source, removeItem, 1)
        end
    end)
else
    Verbose("SF-ATTACHOBJECT is not installed please download it in order for props to work: https://github.com/scriptforge-gg/sf-attachobject", "error")
end