local crew = false
local fetched = false

exports("getCrew", function()
    if not crew and not fetched then
        fetchCrew()
    end
    return crew
end)

function fetchCrew()
    fetched = true
    crew = lib.callback.await('av_racing:fetchCrew', false)
end

RegisterNetEvent("av_racing:updateCrew", function(data)
    crew = data
end)