Config = Config or {}
Config.Webhook = "YOUR_WEBHOOK"
Config.NPC = {
    -- ['drug_name'] = {model hash, started (don't change it)}
    ["meth_batch"] = {model = `a_m_m_genfat_02`, started = false},
}

Config.Locations = { -- The script will pick one random location from this list for every drug npc
    {x = 742.5911, y = -1913.4276, z = 28.2920, heading = 81.5109, used = false},
    {x = 1124.1324, y = -1404.8662, z = 33.5313, heading = 271.9984, used = false},
    {x = 488.2307, y = -2209.4067, z = 4.9183, heading = 60.9337, used = false},
    {x = 975.5895, y = -2359.0349, z = 30.8238, heading = 198.5186, used = false},
    {x = -1805.9902, y = -401.9807, z = 43.6463, heading = 230.8595, used = false},
    {x = 1201.2574, y = 1849.9784, z = 77.8754, heading = 39.3675, used = false},
    {x = 306.4260, y = 2821.6150, z = 42.4470, heading = 4.1007, used = false},
    {x = 2445.7200, y = 3763.1165, z = 40.4569, heading = 342.1733, used = false},
    {x = 906.1819, y = 3657.0769, z = 31.5615, heading = 282.6414, used = false},
    {x = -1128.9150, y = 2692.1536, z = 17.8004, heading = 35.6643, used = false},
}