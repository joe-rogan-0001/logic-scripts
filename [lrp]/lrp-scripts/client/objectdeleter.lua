local DeleteList = {
    [1] = { location = vector3(114.02, -1959.87, 20.94) , radius = 3.0, model = 1729911864},
}



Citizen.CreateThread(function()
    while true do 
        Wait(5000)
        for i=1, #DeleteList do
            local Del_Entity = GetClosestObjectOfType(DeleteList[i].location, DeleteList[i].radius, DeleteList[i].model, false, false, false)
            if DoesEntityExist(Del_Entity) then
                print("happened")
                print(Del_Entity)
                SetEntityAsMissionEntity(Del_Entity, false, false)
                DeleteEntity(Del_Entity)               
            end
        end		
    end
end)