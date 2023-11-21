function vehAnimation()
    if lib.progressCircle({
        duration = math.random(15000,25000),
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
            clip = 'machinic_loop_mechandplayer',
            flag = 16
        },
    }) then return true else return false end
end

function hackingCamAnimation()
    local finish = false
    local res = false
    local player = PlayerPedId()
    FreezeEntityPosition(player,true)
    TaskStartScenarioInPlace(player, 'WORLD_HUMAN_STAND_MOBILE', -1, true)
	Citizen.Wait(3000)
    exports['ps-ui']:Scrambler(function(success)
        res = success
        finish = true
    end, "runes", 30, 0) -- Type (alphabet, numeric, alphanumeric, greek, braille, runes), Time (Seconds), Mirrored (0: Normal, 1: Normal + Mirrored 2: Mirrored only )
    while not finish do Wait(250) end
    FreezeEntityPosition(player,false)
    ClearPedTasks(player)
    return res
end

function enableCamAnimation()
    if lib.progressCircle({
        duration = math.random(15000,25000),
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = 'random@train_tracks',
            clip = 'idle_e',
        },
    }) then return true else return false end
end

function hackingMinigame()
    local finish = false
    local res = false
    exports['ps-ui']:Scrambler(function(success)
        res = success
        finish = true
    end, "runes", 30, 0) -- Type (alphabet, numeric, alphanumeric, greek, braille, runes), Time (Seconds), Mirrored (0: Normal, 1: Normal + Mirrored 2: Mirrored only )
    while not finish do Wait(250) end
    return res
end