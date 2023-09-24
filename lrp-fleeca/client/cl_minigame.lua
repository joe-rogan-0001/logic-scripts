local v = nil

RegisterNUICallback("ResultGames", function(data, cb)
    local ped = PlayerPedId()
    SetNuiFocus(false, false)
    ClearPedSecondaryTask(ped)
    StopAnimTask(PlayerPedId(), "anim@heists@ornate_bank@hack", "hack_loop", 7.0)    
    v:resolve(data.result)
    v = nil
    cb("ok")
end)

function HackingFleeca(duration,round) 
    if not duration then return end
    if not round then return end
    if v then return end
    
    v = promise.new()

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_FLEECA",
        duration = duration,
        rounds = round
    })

    return Citizen.Await(v)
end

exports("HackingFleeca", HackingFleeca)