if Framework.ESX then
    -- ESX = exports[GetCurrentResourceName()]:GetMainObject('esx', 'es_extended')
    ESX = nil
    TriggerEvent('rcore:GetMainObject', 'esx', 'es_extended', function(e)
        ESX = e
    end)

    ShowNotification = function(source, text)
        TriggerClientEvent('esx:showNotification', source, text)
    end
end