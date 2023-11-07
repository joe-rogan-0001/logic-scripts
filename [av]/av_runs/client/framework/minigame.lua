function hackingMinigame()
    local finished = false
    local res = false
    exports['ps-ui']:Scrambler(function(result)
        finished = true
        res = result
    end, "numeric", 15, 0)
    while not finished do Wait(100) end
    return res
end