function isCop()
    return PlayerJob.name == "police"
end

exports('isCop', isCop)