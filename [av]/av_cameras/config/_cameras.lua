-- Default cameras around the city, can be accessed by having a specific job, gang or hacking a hotspot

exampleJobs = {
    ['police'] = true,
    ['sheriff'] = true,
    ['ambulance'] = true,
}

Cameras = {
    ["pacific_bank"] = { -- This index key must be unique
        label = "Pacific Bank", -- This is the original Pacific Bank and is just an example, add your own locations and cameras
        powerCoords = {258.3330, 275.1182, 105.6303}, -- Area where players can disable/enable this group of cameras
        disabled = false, -- If true, no one can access it
        canAccess = function() -- Permission to access the cameras in APP
            local myJob = exports['av_laptop']:getJob().name
            local connected = exports['av_laptop']:WiFi() == "pacific_bank"
            local haveJob = exampleJobs[myJob]
            return (connected or haveJob) -- It will return true if I'm connected to the pacific_bank Wifi or if my current job is in the exampleJobs table
        end,
        canEnable = function() -- Permission to enable the cameras if are hacked
            local myJob = exports['av_laptop']:getJob().name
            return (myJob == "police")
        end,
        canDisable = function() -- Permission to hack the group
            return exports['av_laptop']:hasItem(Config.CameraJammerItem)
        end,
        cameras = {
            {name = 'Main Entrance', x = 231.788, y = 215.184, z = 107.104, h = 119.491, rotX = -8.5, rotY = -0.0, rotZ = 119.491, location = "Alta Street", thumbnail = 'https://cdn.discordapp.com/attachments/1065015399026020372/1135341447101558855/screenshot.jpg'},
            {name = 'ATM Lobby', x = 237.663, y = 211.698, z = 107.903, h = 32.354, rotX = -12.4, rotY = -0.0, rotZ = 32.354, location = "Alta Street", thumbnail = 'https://cdn.discordapp.com/attachments/1065015399026020372/1135341735543853076/screenshot.jpg'},
            {name = 'Main Hall', x = 259.464, y = 214.072, z = 107.491, h = 73.824, rotX = -1.6, rotY = -0.0, rotZ = 73.824, location = "Alta Street", thumbnail = 'https://cdn.discordapp.com/attachments/1065015399026020372/1135341959528075294/screenshot.jpg'},
            {name = 'Back Entrance', x = 266.872, y = 216.346, z = 107.739, h = 125.785, rotX = -0.8, rotY = -0.0, rotZ = 125.785, location = "Alta Street", thumbnail = 'https://cdn.discordapp.com/attachments/1065015399026020372/1135342129393172510/screenshot.jpg'},
            {name = 'Vault Door', x = 253.529, y = 229.721, z = 103.678, h = -145.505, rotX = -34.9, rotY = 0.0, rotZ = -145.505, location = "Alta Street", thumbnail = 'https://cdn.discordapp.com/attachments/1065015399026020372/1135342438727299092/screenshot.jpg'},
        }
    },
    ["mission_row"] = { -- This index key must be unique
        label = "Mission Row", -- This is the original MRPD and is just an example, add your own locations and cameras
        powerCoords = {472.9962, -970.3123, 27.7123}, -- Area where players can disable/enable this group of cameras
        disabled = false, -- If true, no one can access it
        canAccess = function() -- Permission to access the cameras in APP
            local myJob = exports['av_laptop']:getJob()
            return (myJob.name == "police") -- If myJob == "police" it will return true, otherwise is false
        end,
        canEnable = function() -- Permission to enable the cameras if are hacked
            local myJob = exports['av_laptop']:getJob().name
            return (myJob == "police")
        end,
        canDisable = function() -- Permission to hack the group
            -- if u don't want anyone be able to hack this cameras simply return false
            return exports['av_laptop']:hasItem(Config.CameraJammerItem)
        end,
        cameras = {
            {name = 'Main Entrance', x = 434.09, y = -978.135, z = 32.736, h = 117.819, rotX = -24.3, rotY = -0.0, rotZ = 117.819, location = "Sinner Street", thumbnail = 'https://cdn.discordapp.com/attachments/1065015399026020372/1135343183400812634/screenshot.jpg'},
            {name = 'Front Desk Lobby', x = 445.076, y = -974.397, z = 32.782, h = 141.971, rotX = -16.9, rotY = -0.0, rotZ = 141.971, location = "Sinner Street", thumbnail = 'https://cdn.discordapp.com/attachments/1065015399026020372/1136046595356500168/screenshot.jpg'},
            {name = 'Cells Entrance', x = 459.104, y = -987.038, z = 27.435, h = -152.876, rotX = -31.6, rotY = 0.0, rotZ = -152.876, location = "Sinner Street", thumbnail = 'https://cdn.discordapp.com/attachments/1065015399026020372/1135343803948081193/screenshot.jpg'},
            {name = 'Back Entrance', x = 467.206, y = -1026.414, z = 30.157, h = -49.615, rotX = -16.9, rotY = -0.0, rotZ = -49.615, location = "Sinner Street", thumbnail = 'https://cdn.discordapp.com/attachments/1065015399026020372/1135344151878189066/screenshot.jpg'},
        }
    },

}