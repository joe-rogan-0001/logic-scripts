RegisterNetEvent("av_runs:notification", function(title, description, type)
    lib.notify({
        title = title,
        description = description,
        type = type
    })
end)