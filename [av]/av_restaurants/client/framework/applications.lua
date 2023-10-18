RegisterNetEvent('av_restaurant:applications', function(data)
    local open = lib.callback.await('av_restaurant:applicationStatus', false, data['name'])
    if open then
        local input = lib.inputDialog(Lang['application_title'], {
            {type = 'textarea', label = Lang['application_question'], required = true, max = 5, autosize = true},
            {type = 'input', label = Lang['application_phone'], required = true},
            {type = 'input', label = Lang['application_email'], required = true},
        })
        if input then
            TriggerServerEvent('av_restaurants:newApplication',input,data['name'])
        end
    else
        TriggerEvent('av_laptop:notification',Lang['app_title'], Lang['applications_closed'],"error")
    end
end)