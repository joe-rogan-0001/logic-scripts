function triggerBuff(ingredients)
    if not Config.UsingBuffs then return end
    for k, v in pairs(ingredients) do
        if Config.Buffs and Config.Buffs[v] then
            CreateThread(function()
                Config.Buffs[v]()
            end)
        end
    end
end