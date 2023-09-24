if Framework.QBCORE then
    TriggerEvent('rcore:GetMainObject', 'qbcore', 'qb-core', function(QBCore)
        ESX = {}

        ESX.RegisterUsableItem = function(itemName, callBack)
            QBCore.Functions.CreateUseableItem(itemName, callBack)
        end
    
        ESX.GetPlayerFromId = function(source)
            local xPlayer = {}
            local qbPlayer = QBCore.Functions.GetPlayer(source)

            xPlayer.identifier = qbPlayer.PlayerData.citizenid
    
            ---------
            xPlayer.removeInventoryItem = function(itemName, count)
                qbPlayer.Functions.RemoveItem(itemName, count)
            end
            ---------
            xPlayer.getInventoryItem = function(itemName)
                local item = qbPlayer.Functions.GetItemByName(itemName) or {}
    
                local ItemInfo =  {
                    name = itemName,
                    count = item.amount or 0,
                    label = item.label or "none",
                    weight = item.weight or 0,
                    usable = item.useable or false,
                    rare = false,
                    canRemove = false,
                }
                return ItemInfo
            end
            ---------
    
            return xPlayer
        end
    
        ShowNotification = function(source, text)
            TriggerClientEvent('QBCore:Notify', source, text)
        end
    end)
end

function tprint (tbl, indent)
    if not indent then indent = 0 end
    if type(tbl) == 'table' then
       for k, v in pairs(tbl) do
          formatting = string.rep("  ", indent) .. k .. ": "
          if type(v) == "table" then
             print(formatting)
             tprint(v, indent+1)
          elseif type(v) == 'boolean' then
             print(formatting .. tostring(v))      
          else
             print(formatting .. v)
          end
       end
    else
       print(tbl)
    end
 end