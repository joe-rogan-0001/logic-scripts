Config = {}


Config.MinimumMethJobPolice = 0
Config.Cooldown = 600 --- Cooldown until next allowed meth run
Config.RunCost = 10000 --- Self explanatory 

--Config.Item = "meth" -- The item you receive from the job
--Config.MethChance = 350 -- Percentage chance to get meth
--Config.MethAmount = math.random(20, 30) -- Amount of meth you recieve

--Config.SpecialRewardChance = 300 -- Percentage of getting rare item on job. Multiplied by 100. 0.1% = 1, 1% = 10, 20% = 200, 50% = 500, etc. Default 0.1%.
--Config.SpecialItem = "usb_green" -- Put a rare item here which will have 0.1% chance of being given on the run.

Config.BossLocation = vector4(967.26, -1858.49, 30.2, 79.51)
Config.Itemtime = 300 * 1000 -- 5 minutes (time for the case to open after you collect it)
Config.Carspawn = vector4(306.25, 2875.81, 42.14, 84.6) -- Spawn location for vehicle (it serves not purpose just there...)

Config['methguards'] = {
    ['npcguards'] = {
        { coords = vector3(313.96, 2887.06, 48.57), heading = 147.37, model = 'g_m_y_lost_01'},
        { coords = vector3(316.81, 2882.1, 48.57), heading = 121.91, model = 'g_m_y_lost_01'},
        { coords = vector3(319.95, 2876.97, 48.57), heading = 105.91, model = 'g_m_y_lost_01'},
        { coords = vector3(319.44, 2882.95, 45.38), heading = 208.9, model = 'g_m_y_lost_01'},
        { coords = vector3(298.27, 2868.31, 42.66), heading = 102.57, model = 'g_m_y_lost_01'},
        { coords = vector3(300.62, 2885.75, 42.55), heading = 65.68, model = 'g_m_y_lost_01'},
        { coords = vector3(307.68, 2874.32, 42.51), heading = 108.55, model = 'g_m_y_lost_01'},
        { coords = vector3(317.45, 2867.57, 42.5), heading = 236.19, model = 'g_m_y_lost_01'},
        { coords = vector3(333.25, 2877.19, 42.51), heading = 129.84, model = 'g_m_y_lost_01'},
        { coords = vector3(285.41, 2869.55, 60.41), heading = 186.73, model = 'g_m_y_lost_01'},
    },
}
