function checkOverwrites(char)
    local rev = nil
    if char.jail then
        rev = "jail"
    end

    return rev
end

RegisterServerEvent("character:loadspawns")
AddEventHandler("character:loadspawns", function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local citizenid =  Player.PlayerData.citizenid
    local overwrite = nil

    local result = MySQL.Sync.fetchAll('SELECT * FROM apartments WHERE citizenid = ?', {citizenid})
            if result[1] then
                local JailTime = Player.PlayerData.metadata['injail']

                if JailTime > 0 then
                    overwrite = "jail"
                end

               local spawnData = {
                   ["overwrites"] = overwrite,
                   ["hospital"] = {
                       ["illness"] = "none",
                       ["level"] = 0,
                       ["time"] = 0,
                   },
                   ["motelRoom"] = {
                    ["roomType"] = 1,
                    ["roomnumber"] = result[1].name,
                   },
                   ["houses"] = {},
                   ["keys"] = {},
               }
               --print("ez motel")
               --print(dump(spawnData["motelRoom"]["cid"]))
                --if housingMotels[1] ~= nil then
                --    for i = 1, #housingMotels do
                --        local lol = json.decode(housingMotels[i].data)
                --        spawnData["houses"][lol["house_id"]] = true
                --    end
                --end

                --[[for k,v in pairs(housingMotels) do
                    if v.housing_id ~= nil then
                        spawnData["houses"][v.housing_id] = true
                    end
                end]]--

                --if housing_keys[1] ~= nil then
                --    for i = 1, #housing_keys do
                --        local lol = json.decode(housing_keys[i].data)
                --        spawnData["keys"][lol["house_id"]] = true
                --    end
                --end
                --for k,v in pairs(housing_keys) do
                --    if v.housing_id ~= nil then
                --        spawnData["keys"][v.housing_id] = true
                --    end
                --end
                
                TriggerClientEvent("spawn:clientSpawnData",src,spawnData)
            else
                --This assumes a New Character
                --[[
                exports.ghmattimysql:execute("INSERT INTO character_motel (cid) VALUES (@cid)",{
                    ["cid"] = cid
                })
                exports.ghmattimysql:execute("INSERT INTO hospital_patients (cid,level,illness,time) VALUES (@cid,@level,@illness,@time)",{
                    ["cid"] = cid,
                    ["level"] = 0,
                    ["illness"] = "none",
                    ["time"] = 0
                })
                ]]--
                --print("bored ape")
            
                Wait(1000)

                local spawnData = {
                    ["overwrites"] = "new",
                    ["hospital"] = {
                        ["illness"] = "none",
                        ["level"] = 0,
                        ["time"] = 0,
                    },
                    ["motelRoom"] = {
                        ["roomType"] = 1,
                        ["cid"] = cid,
                    },
                    ["houses"] = {},
                    ["keys"] = {},
                }
                TriggerClientEvent("spawn:clientSpawnData",src,spawnData)
            end
        --end)
    --end)
end)