Config = {}

Config.ShowUnlockedText = true

Config.LockedColor = 'rgb(219 58 58)'
Config.UnlockedColor = 'rgb(27 195 63)' -- Old Color if you want it 'rgb(19, 28, 74)'

Config.AdminAccess = {
	enabled = false,
	permission = 'admin' -- Needs to be admin or god
}
Config.CommandPermission = 'god' -- Needs to be admin or god, if you want no permission on it you'd have to remove some code

Config.Debug = false -- Prints the closest door data

Config.DoorList = {}

-- MRPD DOORS POLICE OFFPOLICE
-- FRONT DOOR
table.insert(Config.DoorList, {
	doors = {
		{objHash = -1547307588, objHeading = 269.98272705078, objCoords = vector3(434.7444, -980.7556, 30.8153)},
		{objHash = -1547307588, objHeading = 90.017288208008, objCoords = vector3(434.7444, -983.0781, 30.8153)}
    },
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	lockpick = false,
	audioRemote = false,
	doorID = 1,
	maxDistance = 2.5,
	slides = false,
	locked = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- LOBBY DOOR RIGHT
table.insert(Config.DoorList, {
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	lockpick = false,
	doorID = 2,
	slides = false,
	objCoords = vector3(440.5201, -986.2335, 30.82319),
	locked = true,
	objHash = -96679321,
	audioRemote = false,
	objHeading = 180.00001525879,
	maxDistance = 2.0,
	fixText = false,
	garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- LOBBY DOOR LEFT
table.insert(Config.DoorList, {
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	lockpick = false,
	doorID = 3,
	slides = false,
	objCoords = vector3(440.5201, -977.6011, 30.82319),
	locked = true,
	objHash = -1406685646,
	audioRemote = false,
	objHeading = 0.0,
	maxDistance = 2.0,
	fixText = false,
	garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- CLOTHING STORE SIDE EXIT
table.insert(Config.DoorList, {
	doors = {
		{objHash = -1547307588, objHeading = 180.00001525879, objCoords = vector3(458.2087, -972.2543, 30.81531)},
		{objHash = -1547307588, objHeading = 0.0, objCoords = vector3(455.8862, -972.2543, 30.81531)}
    },
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	lockpick = false,
	audioRemote = false,
	doorID = 4,
	maxDistance = 2.5,
	slides = false,
	locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- RECEPTION DOOR
table.insert(Config.DoorList, {
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	lockpick = false,
	doorID = 5,
	slides = false,
	objCoords = vector3(445.4067, -984.2014, 30.82319),
	locked = true,
	objHash = -1406685646,
	audioRemote = false,
	objHeading = 89.999977111816,
	maxDistance = 2.0,
	fixText = false,
	garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- GARAGE SIDE DOUBLE DOOR
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doors = {
		{objHash = -1547307588, objHeading = 0.0, objCoords = vector3(440.7392, -998.7462, 30.8153)},
		{objHash = -1547307588, objHeading = 180.00001525879, objCoords = vector3(443.0618, -998.7462, 30.8153)}
    },
	maxDistance = 2.5,
	audioRemote = false,
	locked = true,
	slides = false,
	doorID = 6,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- PRESS ROOM DOOR
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doors = {
		{objHash = -288803980, objHeading = 270.00003051758, objCoords = vector3(438.1971, -993.9113, 30.82319)},
		{objHash = -288803980, objHeading = 89.999977111816, objCoords = vector3(438.1971, -996.3167, 30.82319)}
    },
	maxDistance = 2.5,
	audioRemote = false,
	locked = true,
	slides = false,
	doorID = 7,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- ARCHIVES
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -96679321,
	maxDistance = 2.0,
	fixText = false,
	doorID = 8,
	audioRemote = false,
	objCoords = vector3(452.2663, -995.5254, 30.82319),
	objHeading = 134.97177124023,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- CAPTAINS OFFICE
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -96679321,
	maxDistance = 2.0,
	fixText = false,
	doorID = 9,
	audioRemote = false,
	objCoords = vector3(458.6543, -990.6498, 30.82319),
	objHeading = 270.00003051758,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- MAIN DOUBLEDOORS TO BACK AREA
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doors = {
		{objHash = -288803980, objHeading = 270.00003051758, objCoords = vector3(469.4406, -985.0313, 30.82319)},
		{objHash = -288803980, objHeading = 89.999977111816, objCoords = vector3(469.4406, -987.4377, 30.82319)}
    },
	maxDistance = 2.5,
	audioRemote = false,
	locked = true,
	slides = false,
	doorID = 10,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- FORENSIC LAB
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doors = {
		{objHash = -1406685646, objHeading = 270.00003051758, objCoords = vector3(479.7534, -986.2151, 30.82319)},
		{objHash = -1406685646, objHeading = 89.999977111816, objCoords = vector3(479.7534, -988.6204, 30.82319)}
    },
	maxDistance = 2.5,
	audioRemote = false,
	locked = true,
	slides = false,
	doorID = 11,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- ARMORY DOOR FRONT
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -692649124,
	maxDistance = 2.0,
	fixText = false,
	doorID = 12,
	audioRemote = false,
	objCoords = vector3(479.7507, -999.629, 30.78917),
	objHeading = 89.999977111816,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- ARMORY DOOR REAR
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -692649124,
	maxDistance = 2.0,
	fixText = false,
	doorID = 13,
	audioRemote = false,
	objCoords = vector3(487.4378, -1000.189, 30.78697),
	objHeading = 181.28001403809,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- SHOOTING RANGE DOUBLE DOORS
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doors = {
		{objHash = -692649124, objHeading = 180.00001525879, objCoords = vector3(488.0184, -1002.902, 30.78697)},
		{objHash = -692649124, objHeading = 0.0, objCoords = vector3(485.6133, -1002.902, 30.78697)}
    },
	maxDistance = 2.5,
	audioRemote = false,
	locked = true,
	slides = false,
	doorID = 14,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- BRIEFING ROOM FRONT DOUBLE DOORS
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doors = {
		{objHash = -1406685646, objHeading = 180.00001525879, objCoords = vector3(475.3837, -989.8247, 30.82319)},
		{objHash = -96679321, objHeading = 180.00001525879, objCoords = vector3(472.9777, -989.8247, 30.82319)}
    },
	maxDistance = 2.5,
	audioRemote = false,
	locked = true,
	slides = false,
	doorID = 15,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- BRIEFING ROOM BACKDOOR
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -1406685646,
	maxDistance = 2.0,
	fixText = false,
	doorID = 16,
	audioRemote = false,
	objCoords = vector3(476.7512, -999.6307, 30.82319),
	objHeading = 89.999977111816,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- DISPATCH CENTER DOOR
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -96679321,
	maxDistance = 2.0,
	fixText = false,
	doorID = 17,
	audioRemote = false,
	objCoords = vector3(448.9846, -995.5264, 35.10376),
	objHeading = 134.97177124023,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- TRAINING ROOM 1
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -1406685646,
	maxDistance = 2.0,
	fixText = false,
	doorID = 18,
	audioRemote = false,
	objCoords = vector3(448.9868, -990.2007, 35.10376),
	objHeading = 45.028198242188,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- TRAINING ROOM 2
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -96679321,
	maxDistance = 2.0,
	fixText = false,
	doorID = 19,
	audioRemote = false,
	objCoords = vector3(448.9868, -981.5785, 35.10376),
	objHeading = 134.97177124023,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- MEETING ROOM 2
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -1406685646,
	maxDistance = 2.0,
	fixText = false,
	doorID = 20,
	audioRemote = false,
	objCoords = vector3(459.9454, -981.0742, 35.10398),
	objHeading = 180.00001525879,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- MEETING ROOM 1
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -96679321,
	maxDistance = 2.0,
	fixText = false,
	doorID = 21,
	audioRemote = false,
	objCoords = vector3(459.9454, -990.7053, 35.10398),
	objHeading = 0.0,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- ROOFTOP DOOR
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -692649124,
	maxDistance = 2.0,
	fixText = false,
	doorID = 22,
	audioRemote = false,
	objCoords = vector3(464.3086, -984.5284, 43.77124),
	objHeading = 89.999977111816,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- INSIDE GARAGE DOOR 1
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = 1830360419,
	maxDistance = 2.0,
	fixText = false,
	doorID = 23,
	audioRemote = false,
	objCoords = vector3(464.1566, -997.5093, 26.3707),
	objHeading = 89.870010375977,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- INSIDE GARAGE DOOR 2
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = 1830360419,
	maxDistance = 2.0,
	fixText = false,
	doorID = 24,
	audioRemote = false,
	objCoords = vector3(464.1591, -974.6656, 26.3707),
	objHeading = 269.79000854492,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- MAIN DOUBLE DOOR DOWNSTAIRS
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doors = {
		{objHash = -1406685646, objHeading = 270.00003051758, objCoords = vector3(471.3753, -985.0319, 26.40548)},
		{objHash = -96679321, objHeading = 270.00003051758, objCoords = vector3(471.3753, -987.4374, 26.40548)}
    },
	maxDistance = 2.5,
	audioRemote = false,
	locked = true,
	slides = false,
	doorID = 25,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- INTERROGATION MAIN DOUBLEDOOR
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doors = {
		{objHash = 149284793, objHeading = 89.999977111816, objCoords = vector3(479.0624, -987.4376, 26.40548)},
		{objHash = 149284793, objHeading = 270.00003051758, objCoords = vector3(479.0624, -985.0323, 26.40548)}
    },
	maxDistance = 2.5,
	audioRemote = false,
	locked = true,
	slides = false,
	doorID = 26,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- EVIDENCE ROOM MAIN DOOR
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -692649124,
	maxDistance = 2.0,
	fixText = false,
	doorID = 27,
	audioRemote = false,
	objCoords = vector3(475.8323, -990.4839, 26.40548),
	objHeading = 134.97177124023,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- OBSERVATION 1
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -1406685646,
	maxDistance = 2.0,
	fixText = false,
	doorID = 29,
	audioRemote = false,
	objCoords = vector3(482.6694, -983.9868, 26.40548),
	objHeading = 270.00003051758,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- INTERROGATION 1
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -1406685646,
	maxDistance = 2.0,
	fixText = false,
	doorID = 30,
	audioRemote = false,
	objCoords = vector3(482.6701, -987.5792, 26.40548),
	objHeading = 270.00003051758,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- OBSERVATION 2
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -1406685646,
	maxDistance = 2.0,
	fixText = false,
	doorID = 31,
	audioRemote = false,
	objCoords = vector3(482.6699, -992.2991, 26.40548),
	objHeading = 270.00003051758,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- INTERROGATION 2
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -1406685646,
	maxDistance = 2.0,
	fixText = false,
	doorID = 32,
	audioRemote = false,
	objCoords = vector3(482.6703, -995.7285, 26.40548),
	objHeading = 270.00003051758,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- BACKGARAGE DOUBLE DOOR [OTHER DOOR FUCKED]
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doors = {
		{objHash = -692649124, objHeading = 0.0, objCoords = vector3(467.3686, -1014.406, 26.48382)},
		{objHash = -692649124, objHeading = 180.00001525879, objCoords = vector3(469.7743, -1014.406, 26.48382)}
    },
	maxDistance = 2.5,
	audioRemote = false,
	locked = true,
	slides = false,
	doorID = 33,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- BACK GARAGE GATE
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -1603817716,
	maxDistance = 6.0,
	fixText = false,
	doorID = 34,
	audioRemote = false,
	objCoords = vector3(488.8948, -1017.212, 27.14935),
	objHeading = 90.0,
	garage = false,
	locked = true,
	slides = true,
    --oldMethod = true,
    audioLock = {['file'] = 'GarageClose.ogg', ['volume'] = 0.7},
    audioUnlock = {['file'] = 'GarageOpen.ogg', ['volume'] = 0.8},
    --autoLock = 1000
})

-- DOUBLE DOOR TO CELL AREA
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doors = {
		{objHash = -288803980, objHeading = 180.00001525879, objCoords = vector3(469.9274, -1000.544, 26.40548)},
		{objHash = -288803980, objHeading = 0.0, objCoords = vector3(467.5222, -1000.544, 26.40548)}
    },
	maxDistance = 2.5,
	audioRemote = false,
	locked = true,
	slides = false,
	doorID = 35,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- DOUBLE DOOR TO PROCESSING AND CELLS
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doors = {
		{objHash = 149284793, objHeading = 89.999977111816, objCoords = vector3(471.3758, -1010.198, 26.40548)},
		{objHash = 149284793, objHeading = 270.19003295898, objCoords = vector3(471.3679, -1007.793, 26.40548)}
    },
	maxDistance = 2.5,
	audioRemote = false,
	locked = true,
	slides = false,
	doorID = 36,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- PROCESSING
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -288803980,
	maxDistance = 2.0,
	fixText = false,
	doorID = 37,
	audioRemote = false,
	objCoords = vector3(475.9539, -1006.938, 26.40639),
	objHeading = 180.00001525879,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- MUGSHOT
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -1406685646,
	maxDistance = 2.0,
	fixText = false,
	doorID = 38,
	audioRemote = false,
	objCoords = vector3(475.9539, -1010.819, 26.40639),
	objHeading = 180.00001525879,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- MAIN CELL DOOR TO CELL AREA
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -53345114,
	maxDistance = 2.0,
	fixText = false,
	doorID = 39,
	audioRemote = false,
	objCoords = vector3(476.6157, -1008.875, 26.48005),
	objHeading = 270.13998413086,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- MAIN CELL DOOR TO CELL AREA 2
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -53345114,
	maxDistance = 2.0,
	fixText = false,
	doorID = 40,
	audioRemote = false,
	objCoords = vector3(481.0084, -1004.118, 26.48005),
	objHeading = 180.00001525879,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- CELL 1
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -53345114,
	maxDistance = 2.0,
	fixText = false,
	doorID = 41,
	audioRemote = false,
	objCoords = vector3(477.9126, -1012.189, 26.48005),
	objHeading = 0.0,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- CELL 2
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -53345114,
	maxDistance = 2.0,
	fixText = false,
	doorID = 42,
	audioRemote = false,
	objCoords = vector3(480.9128, -1012.189, 26.48005),
	objHeading = 0.0,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- CELL 3
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -53345114,
	maxDistance = 2.0,
	fixText = false,
	doorID = 43,
	audioRemote = false,
	objCoords = vector3(483.9127, -1012.189, 26.48005),
	objHeading = 0.0,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- CELL 4
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -53345114,
	maxDistance = 2.0,
	fixText = false,
	doorID = 44,
	audioRemote = false,
	objCoords = vector3(486.9131, -1012.189, 26.48005),
	objHeading = 0.0,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- CELL 5 BIG CELL
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = -53345114,
	maxDistance = 2.0,
	fixText = false,
	doorID = 45,
	audioRemote = false,
	objCoords = vector3(484.1764, -1007.734, 26.48005),
	objHeading = 180.00001525879,
	garage = false,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- GARAGE ENTRANCE
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = 2130672747,
	maxDistance = 8.0,
	fixText = false,
	doorID = 46,
	audioRemote = false,
	objCoords = vector3(452.3005, -1000.772, 26.69661),
	objHeading = 0.0,
	garage = true,
	locked = true,
	slides = true,
    --oldMethod = true,
    audioLock = {['file'] = 'GarageClose.ogg', ['volume'] = 0.7},
    audioUnlock = {['file'] = 'GarageOpen.ogg', ['volume'] = 0.8},
    --autoLock = 1000
})

-- GARAGE EXIT
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	objHash = 2130672747,
	maxDistance = 8.0,
	fixText = false,
	doorID = 47,
	audioRemote = false,
	objCoords = vector3(431.4119, -1000.772, 26.69661),
	objHeading = 0.0,
	garage = true,
	locked = true,
	slides = true,
    --oldMethod = true,
    audioLock = {['file'] = 'GarageClose.ogg', ['volume'] = 0.7},
    audioUnlock = {['file'] = 'GarageOpen.ogg', ['volume'] = 0.8},
    --autoLock = 1000
})

-- PILLBOX DOORS AMBULANCE OFFAMBULANCE
-- GARAGE DOOR 1
table.insert(Config.DoorList, {
	locked = true,
	objHash = -820650556,
	maxDistance = 8.0,
	audioRemote = false,
	slides = true,
	fixText = false,
	garage = true,
	lockpick = false,
	objCoords = vector3(337.2777, -564.432, 29.77529),
	doorID = 50,
	objHeading = 160.00607299805,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
    --oldMethod = true,
    audioLock = {['file'] = 'GarageClose.ogg', ['volume'] = 0.7},
    audioUnlock = {['file'] = 'GarageOpen.ogg', ['volume'] = 0.8},
    --autoLock = 1000
})

-- GARAGE DOOR 2
table.insert(Config.DoorList, {
	locked = true,
	objHash = -820650556,
	maxDistance = 8.0,
	audioRemote = false,
	slides = true,
	fixText = false,
	garage = true,
	lockpick = false,
	objCoords = vector3(330.1349, -561.8331, 29.77529),
	doorID = 51,
	objHeading = 160.00605773926,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
    --oldMethod = true,
    audioLock = {['file'] = 'GarageClose.ogg', ['volume'] = 0.7},
    audioUnlock = {['file'] = 'GarageOpen.ogg', ['volume'] = 0.8},
    --autoLock = 1000
})

-- GARAGE DOUBLE DOOR
table.insert(Config.DoorList, {
	slides = false,
	doors = {
		{objHash = -1421582160, objHeading = 25.005989074707, objCoords = vector3(321.0148, -559.9127, 28.94724)},
		{objHash = 1248599813, objHeading = 205.0061340332, objCoords = vector3(318.6656, -561.0086, 28.94724)}
    },
	audioRemote = false,
	doorID = 52,
	lockpick = false,
	maxDistance = 2.5,
	locked = true,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- INSIDE GARAGE DOUBLE DOOR
table.insert(Config.DoorList, {
	slides = false,
	doors = {
		{objHash = -1700911976, objHeading = 70.006050109863, objCoords = vector3(339.3266, -587.6345, 28.94709)},
		{objHash = -434783486, objHeading = 70.006050109863, objCoords = vector3(338.4467, -590.053, 28.94709)}
    },
	audioRemote = false,
	doorID = 53,
	lockpick = false,
	maxDistance = 2.5,
	locked = true,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- LOWER RECEPTION
table.insert(Config.DoorList, {
	locked = true,
	objHash = 854291622,
	maxDistance = 2.0,
	audioRemote = false,
	slides = false,
	fixText = false,
	garage = false,
	lockpick = false,
	objCoords = vector3(348.5467, -585.1584, 28.94709),
	doorID = 54,
	objHeading = 250.00610351562,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- UPPER RECEPTION
table.insert(Config.DoorList, {
	fixText = false,
	slides = false,
	lockpick = false,
	maxDistance = 2.0,
	objHash = 854291622,
	doorID = 55,
	locked = true,
	objHeading = 249.98275756836,
	objCoords = vector3(313.4801, -595.4583, 43.43391),
	garage = false,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- BEHIND RECEPTION DOOR
table.insert(Config.DoorList, {
	fixText = false,
	slides = false,
	lockpick = false,
	maxDistance = 2.0,
	objHash = 854291622,
	doorID = 56,
	locked = true,
	objHeading = 160.00003051758,
	objCoords = vector3(309.1337, -597.7515, 43.43391),
	garage = false,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- CLOSET
table.insert(Config.DoorList, {
	fixText = false,
	slides = false,
	lockpick = false,
	maxDistance = 2.0,
	objHash = 854291622,
	doorID = 57,
	locked = true,
	objHeading = 70.01732635498,
	objCoords = vector3(303.9596, -572.5579, 43.43391),
	garage = false,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- LABORATORY
table.insert(Config.DoorList, {
	objHash = 854291622,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	objHeading = 340.00003051758,
	audioRemote = false,
	locked = true,
	doorID = 58,
	fixText = false,
	objCoords = vector3(307.1182, -569.569, 43.43391),
	slides = false,
	garage = false,
	lockpick = false,
	maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- SURGERY
table.insert(Config.DoorList, {
	slides = false,
	doorID = 59,
	doors = {
		{objHash = -434783486, objHeading = 340.00003051758, objCoords = vector3(312.0051, -571.3412, 43.43391)},
		{objHash = -1700911976, objHeading = 340.00003051758, objCoords = vector3(314.4241, -572.2216, 43.43391)}
    },
	audioRemote = false,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	locked = true,
	lockpick = false,
	maxDistance = 2.5,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- SURGERY 2
table.insert(Config.DoorList, {
	slides = false,
	doorID = 60,
	doors = {
		{objHash = -434783486, objHeading = 340.00003051758, objCoords = vector3(317.8426, -573.4659, 43.43391)},
		{objHash = -1700911976, objHeading = 340.00003051758, objCoords = vector3(320.2615, -574.3463, 43.43391)}
    },
	audioRemote = false,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	locked = true,
	lockpick = false,
	maxDistance = 2.5,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- SURGERY 3
table.insert(Config.DoorList, {
	slides = false,
	doorID = 61,
	doors = {
		{objHash = -1700911976, objHeading = 340.00003051758, objCoords = vector3(325.6565, -576.3099, 43.43391)},
		{objHash = -434783486, objHeading = 340.00003051758, objCoords = vector3(323.2375, -575.4294, 43.43391)}
    },
	audioRemote = false,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	locked = true,
	lockpick = false,
	maxDistance = 2.5,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- MRI
table.insert(Config.DoorList, {
	objHash = 854291622,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	objHeading = 340.00003051758,
	audioRemote = false,
	locked = true,
	doorID = 62,
	fixText = false,
	objCoords = vector3(336.1628, -580.1403, 43.43391),
	slides = false,
	garage = false,
	lockpick = false,
	maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- DIAGNOSTICS
table.insert(Config.DoorList, {
	objHash = 854291622,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	objHeading = 340.00003051758,
	audioRemote = false,
	locked = true,
	doorID = 63,
	fixText = false,
	objCoords = vector3(340.7818, -581.8215, 43.43391),
	slides = false,
	garage = false,
	lockpick = false,
	maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- ADMINISTRATION
table.insert(Config.DoorList, {
	objHash = 854291622,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	objHeading = 340.00003051758,
	audioRemote = false,
	locked = true,
	doorID = 64,
	fixText = false,
	objCoords = vector3(339.005, -586.7034, 43.43391),
	slides = false,
	garage = false,
	lockpick = false,
	maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- X-RAY
table.insert(Config.DoorList, {
	objHash = 854291622,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	objHeading = 340.00003051758,
	audioRemote = false,
	locked = true,
	doorID = 65,
	fixText = false,
	objCoords = vector3(346.7739, -584.0024, 43.43391),
	slides = false,
	garage = false,
	lockpick = false,
	maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- DOCTOR OFFICE 372
table.insert(Config.DoorList, {
	objHash = 854291622,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	objHeading = 340.00003051758,
	audioRemote = false,
	locked = true,
	doorID = 66,
	fixText = false,
	objCoords = vector3(358.7265, -593.8814, 43.43391),
	slides = false,
	garage = false,
	lockpick = false,
	maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- PATIENT ROOM 371
table.insert(Config.DoorList, {
	objHash = 854291622,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	objHeading = 340.00003051758,
	audioRemote = false,
	locked = true,
	doorID = 67,
	fixText = false,
	objCoords = vector3(360.5034, -588.9995, 43.43391),
	slides = false,
	garage = false,
	lockpick = false,
	maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- PATIENT ROOM 370
table.insert(Config.DoorList, {
	objHash = 854291622,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	objHeading = 249.98275756836,
	audioRemote = false,
	locked = true,
	doorID = 68,
	fixText = false,
	objCoords = vector3(356.1252, -583.3625, 43.43391),
	slides = false,
	garage = false,
	lockpick = false,
	maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- PATIENT ROOM 369
table.insert(Config.DoorList, {
	objHash = 854291622,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	objHeading = 249.98275756836,
	audioRemote = false,
	locked = true,
	doorID = 69,
	fixText = false,
	objCoords = vector3(357.4908, -579.6105, 43.43391),
	slides = false,
	garage = false,
	lockpick = false,
	maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- TREATMENT
table.insert(Config.DoorList, {
	objHash = 854291622,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	objHeading = 70.01732635498,
	audioRemote = false,
	locked = true,
	doorID = 70,
	fixText = false,
	objCoords = vector3(346.8855, -593.6, 43.43391),
	slides = false,
	garage = false,
	lockpick = false,
	maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- DOCTOR OFFICE 373
table.insert(Config.DoorList, {
	objHash = 854291622,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	objHeading = 249.98275756836,
	audioRemote = false,
	locked = true,
	doorID = 71,
	fixText = false,
	objCoords = vector3(352.1997, -594.1478, 43.43391),
	slides = false,
	garage = false,
	lockpick = false,
	maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- PATIENT ROOM 374
table.insert(Config.DoorList, {
	objHash = 854291622,
	authorizedJobs = { ['offambulance']=0, ['ambulance']=0 },
	objHeading = 249.98275756836,
	audioRemote = false,
	locked = true,
	doorID = 72,
	fixText = false,
	objCoords = vector3(350.8341, -597.8997, 43.43391),
	slides = false,
	garage = false,
	lockpick = false,
	maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- REAL ESTATE FRONT DOUBLE DOOR
table.insert(Config.DoorList, {
	slides = false,
	locked = false,
	maxDistance = 2.5,
	doorID = 72,
	doors = {
		{objHash = -1922281023, objHeading = 295.49960327148, objCoords = vector3(-698.7479, 269.976, 83.41463)},
		{objHash = -1922281023, objHeading = 115.49955749512, objCoords = vector3(-699.6559, 271.8886, 83.41496)}
    },
	lockpick = false,
	audioRemote = false,
	authorizedJobs = { ['realestate']=0, ['offrealestate']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- REAL ESTATE INSIDE DOOR
table.insert(Config.DoorList, {
	slides = false,
	maxDistance = 2.0,
	garage = false,
	doorID = 73,
	objHash = 1901183774,
	audioRemote = false,
	locked = true,
	fixText = false,
	lockpick = false,
	objHeading = 295.29959106445,
	objCoords = vector3(-713.9232, 264.463, 84.19496),
	authorizedJobs = { ['realestate']=0, ['offrealestate']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- REAL ESTATE BACK DOOR
table.insert(Config.DoorList, {
	slides = false,
	maxDistance = 2.0,
	garage = false,
	doorID = 74,
	objHash = 1901183774,
	audioRemote = false,
	locked = true,
	fixText = false,
	lockpick = false,
	objHeading = 295.099609375,
	objCoords = vector3(-716.373, 270.6035, 84.81592),
	authorizedJobs = { ['realestate']=0, ['offrealestate']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})


-- jewellery heist door
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	doors = {
		{objHash = 1425919976, objHeading = 306.00003051758, objCoords = vector3(-631.9554, -236.3333, 38.20653)},
		{objHash = 9467943, objHeading = 306.00003051758, objCoords = vector3(-630.4265, -238.4375, 38.20653)}
    },
	slides = false,
	lockpick = false,
	locked = true,
	audioRemote = false,
	maxDistance = 2.5,
	doorID = 75,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- BURGERSHOT
table.insert(Config.DoorList, {
	doorID = 76,
	fixText = false,
	authorizedJobs = { ['offburgershot']=0, ['burgershot']=0 },
	audioRemote = false,
	objCoords = vector3(-1199.357, -903.8741, 14.07984),
	objHeading = 304.0,
	garage = false,
	objHash = -1300743830,
	lockpick = false,
	maxDistance = 2.0,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- BURGERSHOT
table.insert(Config.DoorList, {
	doorID = 77,
	fixText = false,
	authorizedJobs = { ['offburgershot']=0, ['burgershot']=0 },
	audioRemote = false,
	objCoords = vector3(-1201.111, -892.9651, 14.24448),
	objHeading = 34.000019073486,
	garage = false,
	objHash = -1448591934,
	lockpick = false,
	maxDistance = 2.0,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- BURGERSHOT
table.insert(Config.DoorList, {
	doorID = 78,
	fixText = false,
	authorizedJobs = { ['offburgershot']=0, ['burgershot']=0 },
	audioRemote = false,
	objCoords = vector3(-1193.976, -900.4276, 14.24272),
	objHeading = 124.0,
	garage = false,
	objHash = -1448591934,
	lockpick = false,
	maxDistance = 2.0,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- BURGERSHOT
table.insert(Config.DoorList, {
	doorID = 79,
	fixText = false,
	authorizedJobs = { ['offburgershot']=0, ['burgershot']=0 },
	audioRemote = false,
	objCoords = vector3(-1179.221, -891.5005, 14.094),
	objHeading = 124.0,
	garage = false,
	objHash = -1300743830,
	lockpick = false,
	maxDistance = 2.0,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- BURGERSHOT
table.insert(Config.DoorList, {
	doorID = 80,
	fixText = false,
	authorizedJobs = { ['offburgershot']=0, ['burgershot']=0 },
	audioRemote = false,
	objCoords = vector3(-1182.097, -895.4975, 14.1383),
	objHeading = 213.99998474121,
	garage = false,
	objHash = 1042741067,
	lockpick = false,
	maxDistance = 2.0,
	locked = true,
	slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- BURGERSHOT
table.insert(Config.DoorList, {
	doorID = 81,
	fixText = false,
	authorizedJobs = { ['offburgershot']=0, ['burgershot']=0 },
	audioRemote = false,
	objCoords = vector3(-1193.198, -906.8282, 12.98282),
	objHeading = 170.99998474121,
	garage = false,
	objHash = -1518705307,
	lockpick = false,
	maxDistance = 6.0,
	locked = true,
	slides = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- [PRISON DOORS]

-- PRISON GATE 1
table.insert(Config.DoorList, {
	fixText = false,
	objHash = 741314661,
	objCoords = vector3(1844.998, 2604.812, 44.63978),
	maxDistance = 8.0,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 82,
	locked = true,
	lockpick = false,
	objHeading = 90.0,
	garage = false,
	audioRemote = false,
	slides = true,
    --oldMethod = true,
	audioLock = {['file'] = 'GarageClose.ogg', ['volume'] = 0.7},
    audioUnlock = {['file'] = 'GarageOpen.ogg', ['volume'] = 0.8},
    --autoLock = 1000
})

-- PRISON GATE 2
table.insert(Config.DoorList, {
	fixText = false,
	objHash = 741314661,
	objCoords = vector3(1818.543, 2604.812, 44.611),
	maxDistance = 8.0,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 83,
	locked = true,
	lockpick = false,
	objHeading = 90.0,
	garage = false,
	audioRemote = false,
	slides = true,
    --oldMethod = true,
	audioLock = {['file'] = 'GarageClose.ogg', ['volume'] = 0.7},
    audioUnlock = {['file'] = 'GarageOpen.ogg', ['volume'] = 0.8},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1799.608, 2616.975, 44.60325),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 84,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 179.99998474121,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1813.749, 2488.907, 44.46368),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 85,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 251.97775268555,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1808.992, 2474.545, 44.48077),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 86,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 70.905723571777,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1762.542, 2426.507, 44.43787),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 87,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 206.12844848633,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1749.142, 2419.812, 44.42517),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 88,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 26.757732391357,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1667.669, 2407.648, 44.42879),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 89,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 173.00039672852,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1652.984, 2409.571, 44.44308),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 90,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 353.00042724609,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1558.221, 2469.349, 44.39529),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 91,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 118.04624938965,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1550.93, 2482.743, 44.39529),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 92,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 298.04623413086,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1546.983, 2576.13, 44.39033),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 93,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 87.0146484375,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1547.706, 2591.282, 44.50947),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 94,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 267.01473999023,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1575.719, 2667.152, 44.50947),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 95,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 54.548603057861,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1584.653, 2679.75, 44.50947),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 96,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 233.70986938477,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1648.411, 2741.668, 44.44669),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 97,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 27.17546081543,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1662.011, 2748.703, 44.44669),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 98,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 207.17547607422,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1762.196, 2752.489, 44.44669),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 99,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 339.62002563477,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1776.701, 2747.148, 44.44669),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 100,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 160.00001525879,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1830.134, 2703.499, 44.4467),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 101,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 289.16897583008,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1835.285, 2689.104, 44.4467),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 102,
	slides = true,
	maxDistance = 6.0,
	lockpick = false,
	objHash = 741314661,
	objHeading = 110.00004577637,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})
-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1797.761, 2596.565, 46.38731),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 104,
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = -1156020871,
	objHeading = 179.99987792969,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1781.066, 2510.157, 45.97366),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 106,
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = 1373390714,
	objHeading = 119.93480682373,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1782.758, 2498.295, 50.57922),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 107,
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = -1033001619,
	objHeading = 299.93487548828,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	doors = {
		{objHash = -2109504629, objHeading = 119.93480682373, objCoords = vector3(1772.949, 2492.125, 50.58296)},
		{objHash = -2109504629, objHeading = 299.93487548828, objCoords = vector3(1771.651, 2494.379, 50.58325)}
    },
	slides = false,
	maxDistance = 2.5,
	locked = true,
	doorID = 108,
	lockpick = false,
	audioRemote = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1770.73, 2506.435, 45.97371),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 109,
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = -1033001619,
	objHeading = 29.93483543396,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1775.796, 2512.685, 45.97814),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 110,
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = -1033001619,
	objHeading = 29.93483543396,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1826.304, 2586.452, 46.0849),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 111,
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = 1373390714,
	objHeading = 269.95559692383,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1844.353, 2579.587, 46.16001),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 112,
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = -1320876379,
	objHeading = 0.0,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1844.352, 2592.896, 46.16232),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 113,
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = -1033001619,
	objHeading = 180.00001525879,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1841.047, 2595.018, 46.16415),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 114,
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = -1437850419,
	objHeading = 89.999977111816,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1833.67, 2595.02, 46.16415),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 115,
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = -1437850419,
	objHeading = 89.999977111816,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(1827.3, 2592.863, 46.16094),
	fixText = false,
	authorizedJobs = { ['offpolice']=0, ['police']=0 },
	doorID = 116,
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = -1033001619,
	objHeading = 0.0,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- VAULT DOORS (WIP)

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(256.3116, 220.6579, 106.4295),
	fixText = false,
	authorizedJobs = { ['WIP']=0 },
	doorID = 117,
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = -222270721,
	objHeading = 340.00003051758,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(262.1981, 222.5188, 106.4295),
	fixText = false,
	authorizedJobs = { ['WIP']=0 },
	doorID = 118,
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = 746855201,
	objHeading = 250.00004577637,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by abc
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	objCoords = vector3(266.3624, 217.5698, 110.4328),
	fixText = false,
	authorizedJobs = { ['WIP']=0 },
	doorID = 119,
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = 1956494919,
	objHeading = 340.00003051758,
	audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by hahaha
table.insert(Config.DoorList, {
	objCoords = vector3(154.8095, -3034.051, 8.503336),
	locked = true,
	authorizedJobs = { ['WIP']=0 },
	objHash = -456733639,
	doorID = 120,
	slides = true,
	audioRemote = false,
	fixText = false,
	garage = true,
	maxDistance = 6.0,
	objHeading = 89.999961853027,
	lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by hahaha
table.insert(Config.DoorList, {
	objCoords = vector3(154.8095, -3023.889, 8.503336),
	locked = true,
	authorizedJobs = { ['WIP']=0 },
	objHash = -456733639,
	doorID = 121,
	slides = true,
	audioRemote = false,
	fixText = false,
	garage = true,
	maxDistance = 6.0,
	objHeading = 89.999961853027,
	lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- Unnamed door created by hahaha
table.insert(Config.DoorList, {
	objCoords = vector3(158.0886, -3039.13, 6.038793),
	locked = true,
	authorizedJobs = { ['WIP']=0 },
	objHash = -994492850,
	doorID = 122,
	slides = true,
	audioRemote = false,
	fixText = false,
	garage = true,
	maxDistance = 6.0,
	objHeading = 0.0,
	lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
})

-- mrpd bollards created by hahaha
Config.DoorList['mrpd bollards'] = {
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    slides = true,
    audioRemote = false,
    locked = true,
    doors = {
        {objHash = -1635161509, objHeading = 270.15216064453, objCoords = vec3(410.025787, -1024.219971, 29.220200)},
        {objHash = -1868050792, objHeading = 270.0, objCoords = vec3(410.025787, -1024.225952, 29.220221)}
    },
    maxDistance = 9.0,
    --oldMethod = true,
    audioLock = {['file'] = 'GarageClose.ogg', ['volume'] = 0.8},
    audioUnlock = {['file'] = 'GarageOpen.ogg', ['volume'] = 0.8},
    autoLock = 15000,
    --doorRate = 1.0,
    --showNUI = true
}

-- koreatown front door created by hahaha
Config.DoorList['koreatown front door'] = {
    garage = false,
    objHeading = 270.00588989258,
    slides = false,
    locked = true,
    maxDistance = 2.0,
    audioRemote = false,
    objHash = -710818483,
    lockpick = false,
    fixText = false,
    authorizedGangs = { ['koreatown']=0 },
    objCoords = vec3(-716.802002, -865.318176, 23.354815),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- koreatown door 2 created by hahaha
Config.DoorList['koreatown door 2'] = {
    garage = false,
    objHeading = 180.19499206543,
    slides = false,
    locked = true,
    maxDistance = 2.0,
    audioRemote = false,
    objHash = -1083130717,
    lockpick = false,
    fixText = false,
    authorizedGangs = { ['koreatown']=0 },
    objCoords = vec3(-723.856995, -863.004395, 23.356379),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- koreatown door 3 created by hahaha
Config.DoorList['koreatown door 3'] = {
    garage = false,
    objHeading = 180.19499206543,
    slides = false,
    locked = true,
    maxDistance = 2.0,
    audioRemote = false,
    objHash = -1083130717,
    lockpick = false,
    fixText = false,
    authorizedGangs = { ['koreatown']=0 },
    objCoords = vec3(-726.887817, -865.857361, 23.358059),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- koreatown door 4 created by hahaha
Config.DoorList['koreatown door 4'] = {
    garage = false,
    objHeading = 270.00588989258,
    slides = false,
    locked = true,
    maxDistance = 2.0,
    audioRemote = false,
    objHash = -1083130717,
    lockpick = false,
    fixText = false,
    authorizedGangs = { ['koreatown']=0 },
    objCoords = vec3(-722.311340, -862.317200, 26.926243),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- grove garage door created by hahaha
Config.DoorList['grove garage door'] = {
    garage = true,
    objHeading = 175.02038574219,
    slides = true,
    locked = true,
    maxDistance = 6.0,
    audioRemote = false,
    objHash = -1118363016,
    lockpick = false,
    fixText = false,
    authorizedGangs = { ['grove']=0 },
    objCoords = vec3(102.738373, -1960.265381, 20.982342),
    --oldMethod = true,
    audioLock = {['file'] = 'GarageClose.ogg', ['volume'] = 0.7},
    audioUnlock = {['file'] = 'GarageOpen.ogg', ['volume'] = 0.8},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- grove front door created by hahaha
Config.DoorList['grove front door'] = {
    garage = false,
    objHeading = 20.870018005371,
    slides = false,
    locked = true,
    maxDistance = 2.0,
    audioRemote = false,
    objHash = 23523831,
    lockpick = false,
    fixText = false,
    authorizedGangs = { ['grove']=0 },
    objCoords = vec3(115.039848, -1961.363037, 21.422701),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- grove garage side door created by hahaha
Config.DoorList['grove garage side door'] = {
    garage = false,
    objHeading = 85.410041809082,
    slides = false,
    locked = true,
    maxDistance = 2.0,
    audioRemote = false,
    objHash = 1122314606,
    lockpick = false,
    fixText = false,
    authorizedGangs = { ['grove']=0 },
    objCoords = vec3(105.958366, -1963.830322, 20.940590),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- grove shed 1 double door created by hahaha
Config.DoorList['grove shed 1 double door'] = {
    doors = {
        {objHash = 1184805384, objHeading = 21.599960327148, objCoords = vec3(109.136192, -1975.460327, 21.167805)},
        {objHash = 1947176169, objHeading = 201.84492492676, objCoords = vec3(106.519203, -1976.445679, 21.169155)}
    },
    lockpick = false,
    audioRemote = false,
    slides = false,
    locked = true,
    maxDistance = 2.5,
    authorizedGangs = { ['grove']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- grove shed 1 door 2 created by hahaha
Config.DoorList['grove shed 1 door 2'] = {
    doors = {
        {objHash = 1122314606, objHeading = 201.55291748047, objCoords = vec3(104.625389, -1977.140869, 21.061428)},
        {objHash = -1730259609, objHeading = 291.87442016602, objCoords = vec3(111.439117, -1979.291382, 21.059942)}
    },
    lockpick = false,
    audioRemote = false,
    slides = false,
    locked = true,
    maxDistance = 2.5,
    authorizedGangs = { ['grove']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- grove shed 2 double door 1 created by hahaha
Config.DoorList['grove shed 2 double door 1'] = {
    doors = {
        {objHash = 1805008497, objHeading = 313.61856079102, objCoords = vec3(95.830788, -1986.404297, 20.620440)},
        {objHash = -167783606, objHeading = 133.62692260742, objCoords = vec3(93.708824, -1984.100220, 20.620440)}
    },
    lockpick = false,
    audioRemote = false,
    slides = false,
    locked = true,
    maxDistance = 2.5,
    authorizedGangs = { ['grove']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- grove shed 2 double door 2 created by hahaha
Config.DoorList['grove shed 2 double door 2'] = {
    doors = {
        {objHash = 1805008497, objHeading = 313.61856079102, objCoords = vec3(93.162827, -1983.576172, 20.620440)},
        {objHash = -167783606, objHeading = 133.62692260742, objCoords = vec3(91.036858, -1981.275024, 20.620440)}
    },
    lockpick = false,
    audioRemote = false,
    slides = false,
    locked = true,
    maxDistance = 2.5,
    authorizedGangs = { ['grove']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- grove house back doubledoor created by hahaha
Config.DoorList['grove house back doubledoor'] = {
    doors = {
        {objHash = -204046185, objHeading = 20.801488876343, objCoords = vec3(119.167419, -1973.637939, 21.419256)},
        {objHash = 989957872, objHeading = 200.80838012695, objCoords = vec3(117.099403, -1974.348022, 21.419256)}
    },
    lockpick = false,
    audioRemote = false,
    slides = false,
    locked = true,
    maxDistance = 2.5,
    authorizedGangs = { ['grove']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- grove house back door created by hahaha
Config.DoorList['grove house back door'] = {
    garage = false,
    objHeading = 20.870018005371,
    slides = false,
    locked = true,
    maxDistance = 2.0,
    audioRemote = false,
    objHash = -1912632538,
    lockpick = false,
    fixText = false,
    authorizedGangs = { ['grove']=0 },
    objCoords = vec3(113.932739, -1973.500610, 21.423777),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- casino doubledoor created by yeatt
Config.DoorList['casino doubledoor'] = {
    lockpick = false,
    doors = {
        {objHash = 21324050, objHeading = 148.15661621094, objCoords = vec3(960.274231, 32.653469, 72.404907)},
        {objHash = 21324050, objHeading = 328.15661621094, objCoords = vec3(958.141296, 33.978157, 72.404907)}
    },
    locked = false,
    slides = false,
    audioRemote = false,
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.5,
    authorizedJobs = { ['casino']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- casino door created by yeatt
Config.DoorList['casino door'] = {
    objCoords = vec3(991.747925, 25.033257, 71.614433),
    locked = true,
    objHash = 401003935,
    lockpick = false,
    garage = false,
    audioRemote = false,
    authorizedJobs = { ['casino']=0 },
    fixText = false,
    slides = false,
    maxDistance = 2.0,
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    objHeading = 238.03240966797,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- casino tablegames created by yeatt
Config.DoorList['casino tablegames'] = {
    authorizedJobs = { ['casino']=0 },
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    audioRemote = false,
    doors = {
        {objHash = -389557955, objHeading = 103.22945404053, objCoords = vec3(1000.850708, 43.757137, 70.666504)},
        {objHash = -389557955, objHeading = 283.15664672852, objCoords = vec3(1000.425537, 45.565617, 70.666504)}
    },
    slides = false,
    maxDistance = 2.5,
    locked = false,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- room 524 created by yeatt
Config.DoorList['room 524'] = {
    audioRemote = false,
    garage = false,
    locked = true,
    slides = false,
    objCoords = vec3(911.304932, -73.026634, 21.153236),
    authorizedCIDs = { ['OMH59578']=true },
    lockpick = false,
    fixText = false,
    maxDistance = 2.0,
    objHash = 272844368,
    objHeading = 58.156646728516,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- staff only created by yeatt
Config.DoorList['staff only'] = {
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    locked = true,
    maxDistance = 2.5,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['casino']=0 },
    doors = {
        {objHash = -192278810, objHeading = 238.15664672852, objCoords = vec3(901.546753, -63.770603, 21.150007)},
        {objHash = -192278810, objHeading = 58.156597137451, objCoords = vec3(900.544678, -65.384079, 21.150007)}
    },
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- staff only created by yeatt
Config.DoorList['staff only'] = {
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    locked = true,
    maxDistance = 2.5,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['casino']=0 },
    doors = {
        {objHash = 1938754783, objHeading = 58.156597137451, objCoords = vec3(892.445557, -61.613697, 21.146942)},
        {objHash = 1938754783, objHeading = 238.15664672852, objCoords = vec3(893.498291, -59.913002, 21.146942)}
    },
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- staff only created by yeatt
Config.DoorList['staff only'] = {
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    locked = true,
    maxDistance = 2.5,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['casino']=0 },
    doors = {
        {objHash = 1090039464, objHeading = 58.156597137451, objCoords = vec3(882.774597, -52.137421, 21.149433)},
        {objHash = -170420121, objHeading = 238.15664672852, objCoords = vec3(883.776733, -50.523945, 21.149433)}
    },
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- staff only 1 created by yeatt
Config.DoorList['staff only 1'] = {
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    slides = false,
    lockpick = false,
    authorizedJobs = { ['casino']=0 },
    audioRemote = false,
    doors = {
        {objHash = -192278810, objHeading = 58.156597137451, objCoords = vec3(900.544678, -65.384079, 21.150007)},
        {objHash = -192278810, objHeading = 238.15664672852, objCoords = vec3(901.546753, -63.770603, 21.150007)}
    },
    maxDistance = 2.5,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- staff only 2 created by yeatt
Config.DoorList['staff only 2'] = {
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    slides = false,
    lockpick = false,
    authorizedJobs = { ['casino']=0 },
    audioRemote = false,
    doors = {
        {objHash = 1938754783, objHeading = 238.15664672852, objCoords = vec3(893.498291, -59.913002, 21.146942)},
        {objHash = 1938754783, objHeading = 58.156597137451, objCoords = vec3(892.445557, -61.613697, 21.146942)}
    },
    maxDistance = 2.5,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- staff 12312 created by yeatt
Config.DoorList['staff 12312'] = {
    authorizedJobs = { ['casino']=0 },
    locked = true,
    slides = false,
    lockpick = false,
    audioRemote = false,
    garage = false,
    fixText = false,
    objCoords = vec3(994.513306, 25.085358, 71.611694),
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.0,
    objHeading = 328.15661621094,
    objHash = 1278063852,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- staff behind counter created by yeatt
Config.DoorList['staff behind counter'] = {
    authorizedJobs = { ['casino']=0 },
    locked = true,
    slides = false,
    lockpick = false,
    audioRemote = false,
    garage = false,
    fixText = false,
    objCoords = vec3(995.433228, 31.163610, 71.608078),
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.0,
    objHeading = 238.3182220459,
    objHash = 401003935,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- staff broken elevator created by yeatt
Config.DoorList['staff broken elevator'] = {
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['casino']=0 },
    doors = {
        {objHash = -1240156945, objHeading = 148.15661621094, objCoords = vec3(1013.533813, 27.289812, 70.460556)},
        {objHash = -1240156945, objHeading = 328.15661621094, objCoords = vec3(1012.259888, 28.081015, 70.460556)}
    },
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 6.0,
    slides = true,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- staff bj couble door created by yeatt
Config.DoorList['staff bj couble door'] = {
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['casino']=0 },
    doors = {
        {objHash = 680601509, objHeading = 148.1089630127, objCoords = vec3(1026.787109, 32.432533, 70.012947)},
        {objHash = 680601509, objHeading = 328.15661621094, objCoords = vec3(1025.090332, 33.490280, 70.012947)}
    },
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.5,
    slides = false,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- staff behind bj double created by yeatt
Config.DoorList['staff behind bj double'] = {
    authorizedJobs = { ['casino']=0 },
    locked = true,
    slides = false,
    lockpick = false,
    audioRemote = false,
    garage = false,
    fixText = false,
    objCoords = vec3(1021.192261, 20.666773, 71.611694),
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.0,
    objHeading = 148.15661621094,
    objHash = 1226684428,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- wash locker created by yeatt
Config.DoorList['wash locker'] = {
    authorizedJobs = { ['casino']=0 },
    locked = true,
    slides = false,
    lockpick = false,
    audioRemote = false,
    garage = false,
    fixText = false,
    objCoords = vec3(996.611572, 4.338697, 71.611694),
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.0,
    objHeading = 328.15661621094,
    objHash = -35610440,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- wash locker 2 created by yeatt
Config.DoorList['wash locker 2'] = {
    authorizedJobs = { ['casino']=0 },
    locked = true,
    slides = false,
    lockpick = false,
    audioRemote = false,
    garage = false,
    fixText = false,
    objCoords = vec3(1005.197266, -0.993656, 71.611694),
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.0,
    objHeading = 328.15661621094,
    objHash = -35610440,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- wash locker dbl 2 created by yeatt
Config.DoorList['wash locker dbl 2'] = {
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['casino']=0 },
    doors = {
        {objHash = -267451115, objHeading = 328.15661621094, objCoords = vec3(1011.449890, 0.008102, 71.611694)},
        {objHash = -267451115, objHeading = 148.15661621094, objCoords = vec3(1013.148865, -1.047096, 71.611694)}
    },
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.5,
    slides = false,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- wash locker dbl 3 created by yeatt
Config.DoorList['wash locker dbl 3'] = {
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['casino']=0 },
    doors = {
        {objHash = -267451115, objHeading = 148.15661621094, objCoords = vec3(1021.517395, -6.244555, 71.611694)},
        {objHash = -267451115, objHeading = 328.15661621094, objCoords = vec3(1019.818542, -5.189483, 71.611694)}
    },
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.5,
    slides = false,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- wash locker dbl 3 created by yeatt
Config.DoorList['wash locker dbl 3'] = {
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['casino']=0 },
    doors = {
        {objHash = -267451115, objHeading = 148.15661621094, objCoords = vec3(1018.428650, -9.211340, 71.611694)},
        {objHash = -267451115, objHeading = 328.15661621094, objCoords = vec3(1016.729675, -8.156136, 71.611694)}
    },
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.5,
    slides = false,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- wash locker dbl 4 created by yeatt
Config.DoorList['wash locker dbl 4'] = {
    authorizedJobs = { ['casino']=0 },
    locked = true,
    slides = false,
    lockpick = false,
    audioRemote = false,
    garage = false,
    fixText = false,
    objCoords = vec3(1013.620300, -6.225018, 71.611694),
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.0,
    objHeading = 148.15661621094,
    objHash = -35610440,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- wash locker dbl 5 created by yeatt
Config.DoorList['wash locker dbl 5'] = {
    authorizedJobs = { ['casino']=0 },
    locked = true,
    slides = false,
    lockpick = false,
    audioRemote = false,
    garage = false,
    fixText = false,
    objCoords = vec3(1009.470825, -3.647877, 71.611694),
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.0,
    objHeading = 148.15661621094,
    objHash = -35610440,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- wash locker dbl 6 created by yeatt
Config.DoorList['wash locker dbl 6'] = {
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['casino']=0 },
    doors = {
        {objHash = -267451115, objHeading = 328.15661621094, objCoords = vec3(1016.729675, -8.156136, 71.611694)},
        {objHash = -267451115, objHeading = 148.15661621094, objCoords = vec3(1018.428650, -9.211340, 71.611694)}
    },
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.5,
    slides = false,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- da2dadawd created by yeatt
Config.DoorList['da2dadawd'] = {
    doors = {
        {objHash = -267451115, objHeading = 328.15661621094, objCoords = vec3(1019.818542, -5.189483, 71.611694)},
        {objHash = -267451115, objHeading = 148.15661621094, objCoords = vec3(1021.517395, -6.244555, 71.611694)}
    },
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.5,
    locked = true,
    authorizedJobs = { ['casino']=0 },
    slides = false,
    audioRemote = false,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- office double created by yeatt
Config.DoorList['office double'] = {
    doors = {
        {objHash = -643593781, objHeading = 148.15661621094, objCoords = vec3(1002.307251, 60.316097, 75.210083)},
        {objHash = -643593781, objHeading = 328.15661621094, objCoords = vec3(1000.608459, 61.371151, 75.210083)}
    },
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.5,
    locked = true,
    authorizedJobs = { ['casino']=0 },
    slides = false,
    audioRemote = false,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- offices created by yeatt
Config.DoorList['offices'] = {
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    objCoords = vec3(1013.781372, 60.430008, 75.215614),
    slides = false,
    fixText = false,
    objHeading = 237.84509277344,
    locked = true,
    maxDistance = 2.0,
    audioRemote = false,
    authorizedJobs = { ['casino']=0 },
    garage = false,
    objHash = 401003935,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- offices dpuble created by yeatt
Config.DoorList['offices dpuble'] = {
    doors = {
        {objHash = -1747430008, objHeading = 148.15661621094, objCoords = vec3(1010.978821, 39.265533, 75.211693)},
        {objHash = -1747430008, objHeading = 328.15661621094, objCoords = vec3(1009.279846, 40.320744, 75.211693)}
    },
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.5,
    locked = true,
    authorizedJobs = { ['casino']=0 },
    slides = false,
    audioRemote = false,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bj management created by yeatt
Config.DoorList['bj management'] = {
    doors = {
        {objHash = 680601509, objHeading = 238.15664672852, objCoords = vec3(1018.692322, 67.176483, 70.010086)},
        {objHash = 680601509, objHeading = 58.156597137451, objCoords = vec3(1017.637268, 65.477730, 70.010086)}
    },
    authorizedGangs = { ['cerberus']=0, ['koreatown']=0 },
    maxDistance = 2.5,
    locked = true,
    authorizedJobs = { ['casino']=0 },
    slides = false,
    audioRemote = false,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bobdoor1 created by yeatt
Config.DoorList['bobdoor1'] = {
    locked = true,
    lockpick = false,
    slides = false,
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    maxDistance = 2.5,
    doors = {
        {objHash = -1563799200, objHeading = 175.0022277832, objCoords = vec3(880.895142, -2258.308350, 32.534859)},
        {objHash = -1259801187, objHeading = 355.0022277832, objCoords = vec3(883.480347, -2258.529785, 32.534859)}
    },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bobdoor2 created by yeatt
Config.DoorList['bobdoor2'] = {
    slides = false,
    objHeading = 175.0022277832,
    audioRemote = false,
    objCoords = vec3(881.617065, -2264.669434, 32.591564),
    locked = true,
    lockpick = false,
    fixText = false,
    authorizedJobs = { ['police']=0 },
    maxDistance = 2.0,
    objHash = -551608542,
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bobdoor3 created by yeatt
Config.DoorList['bobdoor3'] = {
    locked = true,
    lockpick = false,
    slides = false,
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    maxDistance = 2.5,
    doors = {
        {objHash = 933053701, objHeading = 175.00221252441, objCoords = vec3(880.029785, -2268.181641, 32.591602)},
        {objHash = 933053701, objHeading = 355.0022277832, objCoords = vec3(882.619873, -2268.408203, 32.591602)}
    },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bob staffroom created by yeatt
Config.DoorList['bob staffroom'] = {
    slides = false,
    objHeading = 355.0022277832,
    audioRemote = false,
    objCoords = vec3(882.336792, -2295.273438, 32.591564),
    locked = true,
    lockpick = false,
    fixText = false,
    authorizedJobs = { ['police']=0 },
    maxDistance = 2.0,
    objHash = -311575617,
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Gambino Front Double Door created by PADDYDOX
Config.DoorList['Gambino Front Double Door'] = {
    audioRemote = false,
    authorizedGangs = { ['gambino']=0 },
    lockpick = false,
    maxDistance = 2.5,
    doors = {
        {objHash = -1627599682, objHeading = 270.0, objCoords = vec3(-325.324188, -1285.519287, 31.803431)},
        {objHash = 1099436502, objHeading = 270.0, objCoords = vec3(-325.324188, -1282.923096, 31.803431)}
    },
    slides = false,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Gambino Front single Door 1 created by PADDYDOX
Config.DoorList['Gambino Front single Door 1'] = {
    garage = false,
    objHeading = 1.5481607988477e-05,
    fixText = false,
    locked = true,
    lockpick = false,
    authorizedGangs = { ['gambino']=0 },
    objCoords = vec3(-315.011841, -1278.629761, 31.801443),
    audioRemote = false,
    objHash = -2127395996,
    slides = false,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Gambino Front single Door 2 created by PADDYDOX
Config.DoorList['Gambino Front single Door 2'] = {
    garage = false,
    objHeading = 180.00001525879,
    fixText = false,
    locked = true,
    lockpick = false,
    authorizedGangs = { ['gambino']=0 },
    objCoords = vec3(-315.014374, -1290.348145, 31.803028),
    audioRemote = false,
    objHash = 507264345,
    slides = false,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Gambino double Door 1 created by PADDYDOX
Config.DoorList['Gambino double Door 1'] = {
    audioRemote = false,
    authorizedGangs = { ['gambino']=0 },
    lockpick = false,
    maxDistance = 2.5,
    doors = {
        {objHash = -2127395996, objHeading = 180.00001525879, objCoords = vec3(-308.143921, -1294.272339, 31.803028)},
        {objHash = 507264345, objHeading = 180.00001525879, objCoords = vec3(-310.742065, -1294.272339, 31.803028)}
    },
    slides = false,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Gambino double locker 1 created by PADDYDOX
Config.DoorList['Gambino double locker 1'] = {
    audioRemote = false,
    authorizedGangs = { ['gambino']=0 },
    lockpick = false,
    maxDistance = 2.5,
    doors = {
        {objHash = -2049942520, objHeading = 180.00001525879, objCoords = vec3(-307.866302, -1312.516235, 30.718958)},
        {objHash = -1988209294, objHeading = 180.00001525879, objCoords = vec3(-309.188873, -1312.516235, 30.718958)}
    },
    slides = false,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Gambino sliding locker 1 created by PADDYDOX
Config.DoorList['Gambino sliding locker 1'] = {
    garage = false,
    objHeading = 180.00001525879,
    fixText = false,
    locked = true,
    lockpick = false,
    authorizedGangs = { ['gambino']=0 },
    objCoords = vec3(-313.857880, -1311.655518, 31.732601),
    audioRemote = false,
    objHash = -1065092946,
    slides = true,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Gambino sliding hatch 1 created by PADDYDOX
Config.DoorList['Gambino sliding hatch 1'] = {
    garage = false,
    objHeading = 12.117479324341,
    fixText = false,
    locked = true,
    lockpick = false,
    authorizedGangs = { ['gambino']=0 },
    objCoords = vec3(-305.182068, -1314.666382, 30.586472),
    audioRemote = false,
    objHash = 1417255277,
    slides = true,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- Gambino sliding hatch 2 created by PADDYDOX
Config.DoorList['Gambino sliding hatch 2'] = {
    garage = false,
    objHeading = 46.054706573486,
    fixText = false,
    locked = true,
    lockpick = false,
    authorizedGangs = { ['gambino']=0 },
    objCoords = vec3(-233.592056, -1294.882690, 30.480459),
    audioRemote = false,
    objHash = 1616832291,
    slides = true,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- Gambino single outside door 1 created by PADDYDOX
Config.DoorList['Gambino single outside door 1'] = {
    garage = false,
    objHeading = 89.999977111816,
    fixText = false,
    locked = true,
    lockpick = false,
    authorizedGangs = { ['gambino']=0 },
    objCoords = vec3(-230.577820, -1294.614624, 31.670729),
    audioRemote = false,
    objHash = -1627599682,
    slides = false,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- Gambino cell door created by PADDYDOX
Config.DoorList['Gambino cell door'] = {
    objHeading = 90.000022888184,
    lockpick = false,
    objCoords = vec3(-310.000427, -1314.272827, 31.805017),
    objHash = -1193804876,
    garage = false,
    slides = false,
    audioRemote = false,
    maxDistance = 2.0,
    fixText = false,
    locked = true,
    authorizedGangs = { ['gambino']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}




-- IRA garage door created by PADDYDOX
Config.DoorList['IRA garage door'] = {
    locked = true,
    maxDistance = 6.0,
    objCoords = vec3(829.218445, -2333.972900, 31.811111),
    authorizedGangs = { ['ira']=0 },
    slides = true,
    audioRemote = false,
    objHeading = 85.443710327148,
    fixText = false,
    garage = true,
    objHash = -1007367639,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- IRA door 1 created by PADDYDOX
Config.DoorList['IRA door 1'] = {
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(822.165100, -2338.251953, 30.770161),
    authorizedGangs = { ['ira']=0 },
    slides = false,
    audioRemote = false,
    objHeading = 354.99990844727,
    fixText = false,
    garage = false,
    objHash = -1046695423,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- IRA door 2 created by PADDYDOX
Config.DoorList['IRA door 2'] = {
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(818.793457, -2349.521484, 30.533590),
    authorizedGangs = { ['ira']=0 },
    slides = false,
    audioRemote = false,
    objHeading = 85.008583068848,
    fixText = false,
    garage = false,
    objHash = -733653166,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- IRA door 3 created by PADDYDOX
Config.DoorList['IRA door 3'] = {
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(815.925476, -2344.731689, 30.414391),
    authorizedGangs = { ['ira']=0 },
    slides = false,
    audioRemote = false,
    objHeading = 264.73211669922,
    fixText = false,
    garage = false,
    objHash = -5479653,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- IRA door 4 created by PADDYDOX
Config.DoorList['IRA door 4'] = {
    slides = false,
    locked = true,
    audioRemote = false,
    maxDistance = 2.5,
    doors = {
        {objHash = -1259801187, objHeading = 174.50323486328, objCoords = vec3(814.945129, -2321.452881, 30.556480)},
        {objHash = -1563799200, objHeading = 354.8952331543, objCoords = vec3(817.532776, -2321.693115, 30.556419)}
    },
    lockpick = false,
    authorizedGangs = { ['ira']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- IRA door 5 created by PADDYDOX
Config.DoorList['IRA door 5'] = {
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(810.046021, -2319.183350, 30.614740),
    authorizedGangs = { ['ira']=0 },
    slides = false,
    audioRemote = false,
    objHeading = 264.21411132812,
    fixText = false,
    garage = false,
    objHash = -995467546,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- IRA door 6 created by PADDYDOX
Config.DoorList['IRA door 6'] = {
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(820.300415, -2317.154297, 30.617540),
    authorizedGangs = { ['ira']=0 },
    slides = false,
    audioRemote = false,
    objHeading = 354.47503662109,
    fixText = false,
    garage = false,
    objHash = -1128607325,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- IRA door 7 created by PADDYDOX
Config.DoorList['IRA door 7'] = {
    slides = false,
    locked = true,
    audioRemote = false,
    maxDistance = 2.5,
    doors = {
        {objHash = -274493186, objHeading = 265.0, objCoords = vec3(830.412537, -2319.170166, 30.613331)},
        {objHash = 47003473, objHeading = 264.99990844727, objCoords = vec3(830.185791, -2321.760254, 30.613331)}
    },
    lockpick = false,
    authorizedGangs = { ['ira']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- IRA door 8 created by PADDYDOX
Config.DoorList['IRA door 8'] = {
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(830.532104, -2317.436768, 30.617741),
    authorizedGangs = { ['ira']=0 },
    slides = false,
    audioRemote = false,
    objHeading = 84.999603271484,
    fixText = false,
    garage = false,
    objHash = -274493186,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- koreatown garage  created by widepeepoHappy
Config.DoorList['koreatown garage '] = {
    locked = true,
    maxDistance = 6.0,
    objCoords = vec3(-675.330994, -878.722168, 25.238443),
    authorizedGangs = { ['koreatown']=0 },
    slides = true,
    audioRemote = false,
    objHeading = 270.00003051758,
    fixText = false,
    garage = true,
    objHash = 245838764,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- koreatown secret door created by widepeepoHappy
Config.DoorList['koreatown secret door'] = {
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(-684.085266, -875.748169, 24.764751),
    authorizedGangs = { ['koreatown']=0 },
    slides = false,
    audioRemote = false,
    objHeading = 0.12990370392799,
    fixText = false,
    garage = false,
    objHash = 1413187371,
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso1 created by vesku
Config.DoorList['bcso1'] = {
    slides = false,
    lockpick = false,
    audioRemote = false,
    doors = {
        {objHash = 733214349, objHeading = 134.99996948242, objCoords = vec3(-437.171692, 6012.947266, 32.288513)},
        {objHash = 965382714, objHeading = 314.99981689453, objCoords = vec3(-438.586548, 6014.361816, 32.288513)}
    },
    locked = true,
    maxDistance = 2.5,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso2 created by vesku
Config.DoorList['bcso2'] = {
    slides = false,
    lockpick = false,
    audioRemote = false,
    doors = {
        {objHash = 1857649811, objHeading = 314.99981689453, objCoords = vec3(-448.071289, 6004.868164, 32.288513)},
        {objHash = 1362051455, objHeading = 134.99996948242, objCoords = vec3(-446.656403, 6003.453125, 32.288513)}
    },
    locked = true,
    maxDistance = 2.5,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso3 created by vesku
Config.DoorList['bcso3'] = {
    slides = false,
    lockpick = false,
    audioRemote = false,
    doors = {
        {objHash = 1362051455, objHeading = 44.999935150146, objCoords = vec3(-451.424713, 6003.420410, 32.288513)},
        {objHash = 1857649811, objHeading = 224.99992370605, objCoords = vec3(-450.009827, 6004.835449, 32.288513)}
    },
    locked = true,
    maxDistance = 2.5,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso4 created by vesku
Config.DoorList['bcso4'] = {
    slides = false,
    lockpick = false,
    audioRemote = false,
    doors = {
        {objHash = 733214349, objHeading = 314.99981689453, objCoords = vec3(-454.901672, 5998.051758, 32.288513)},
        {objHash = 965382714, objHeading = 134.99992370605, objCoords = vec3(-453.486755, 5996.637207, 32.288513)}
    },
    locked = true,
    maxDistance = 2.5,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso5 created by vesku
Config.DoorList['bcso5'] = {
    slides = false,
    lockpick = false,
    audioRemote = false,
    doors = {
        {objHash = 1857649811, objHeading = 224.99992370605, objCoords = vec3(-450.009827, 6004.835449, 27.581215)},
        {objHash = 1362051455, objHeading = 44.999923706055, objCoords = vec3(-451.424713, 6003.420410, 27.581215)}
    },
    locked = true,
    maxDistance = 2.5,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso6 created by vesku
Config.DoorList['bcso6'] = {
    slides = false,
    lockpick = false,
    audioRemote = false,
    doors = {
        {objHash = 1362051455, objHeading = 224.99992370605, objCoords = vec3(-446.583923, 6001.399902, 27.581215)},
        {objHash = 1857649811, objHeading = 44.99987411499, objCoords = vec3(-447.998840, 5999.984863, 27.581215)}
    },
    locked = true,
    maxDistance = 2.5,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso7 created by vesku
Config.DoorList['bcso7'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = 1362051455,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 134.99992370605,
    locked = true,
    maxDistance = 1.0,
    objCoords = vec3(-443.061218, 5999.874023, 27.581215),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso8 created by vesku
Config.DoorList['bcso8'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = 1362051455,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 314.99984741211,
    locked = true,
    maxDistance = 1.0,
    objCoords = vec3(-441.941559, 5998.754395, 27.581215),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso9 created by vesku
Config.DoorList['bcso9'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = 1362051455,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 314.99984741211,
    locked = true,
    maxDistance = 1.0,
    objCoords = vec3(-445.353577, 5995.342285, 27.581215),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso10 created by vesku
Config.DoorList['bcso10'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = 1362051455,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 134.99992370605,
    locked = true,
    maxDistance = 1.0,
    objCoords = vec3(-446.479950, 5996.468750, 27.581215),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso11 created by vesku
Config.DoorList['bcso11'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = -594854737,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 314.99984741211,
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(-443.640503, 6006.972656, 27.731001),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso12 created by vesku
Config.DoorList['bcso12'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = -594854737,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 134.99992370605,
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(-448.916046, 6015.851074, 27.731001),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso13 created by vesku
Config.DoorList['bcso13'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = -594854737,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 134.99992370605,
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(-445.945679, 6012.880371, 27.731001),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso14 created by vesku
Config.DoorList['bcso14'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = -594854737,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 134.99992370605,
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(-443.390076, 6015.436035, 27.731001),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso15 created by vesku
Config.DoorList['bcso15'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = -594854737,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 134.99992370605,
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(-446.360443, 6018.406738, 27.731001),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso16 created by vesku
Config.DoorList['bcso16'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = -594854737,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 44.999942779541,
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(-442.243347, 6012.619629, 27.731001),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso17 created by vesku
Config.DoorList['bcso17'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = 1362051455,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 134.99996948242,
    locked = true,
    maxDistance = 1.0,
    objCoords = vec3(-449.508789, 5999.468262, 27.581215),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso18 created by vesku
Config.DoorList['bcso18'] = {
    slides = false,
    lockpick = false,
    audioRemote = false,
    doors = {
        {objHash = 1362051455, objHeading = 44.999923706055, objCoords = vec3(-451.424713, 6003.420410, 36.995815)},
        {objHash = 1857649811, objHeading = 224.99992370605, objCoords = vec3(-450.009827, 6004.835449, 36.995815)}
    },
    locked = true,
    maxDistance = 2.5,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso19 created by vesku
Config.DoorList['bcso19'] = {
    slides = false,
    lockpick = false,
    audioRemote = false,
    doors = {
        {objHash = 899779172, objHeading = 224.99990844727, objCoords = vec3(-446.922455, 6001.234375, 37.296593)},
        {objHash = 1127654798, objHeading = 224.99992370605, objCoords = vec3(-448.615845, 5999.541016, 37.340187)}
    },
    locked = true,
    maxDistance = 2.5,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso20 created by vesku
Config.DoorList['bcso20'] = {
    slides = false,
    lockpick = false,
    audioRemote = false,
    doors = {
        {objHash = 1127654798, objHeading = 224.99990844727, objCoords = vec3(-445.645660, 6002.511230, 37.340187)},
        {objHash = 899779172, objHeading = 224.99990844727, objCoords = vec3(-443.952301, 6004.204590, 37.296593)}
    },
    locked = true,
    maxDistance = 2.5,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso21 created by vesku
Config.DoorList['bcso21'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = 1362051455,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 134.99993896484,
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(-449.678375, 5999.344727, 36.995815),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso22 created by vesku
Config.DoorList['bcso22'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = 1362051455,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 314.99984741211,
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(-441.672607, 6009.143555, 36.995815),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso23 created by vesku
Config.DoorList['bcso23'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = 1362051455,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 44.999935150146,
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(-447.444489, 6011.512207, 36.995815),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso24 created by vesku
Config.DoorList['bcso24'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = 1362051455,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 224.99992370605,
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(-443.959991, 6017.162109, 32.288513),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso24 created by vesku
Config.DoorList['bcso24'] = {
    slides = true,
    fixText = false,
    garage = false,
    objHash = -470936668,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 44.84627532959,
    locked = true,
    maxDistance = 7.0,
    objCoords = vec3(-456.473358, 6031.135742, 31.135477),
    --oldMethod = true,
    audioLock = {['file'] = 'GarageClose.ogg', ['volume'] = 0.8},
    audioUnlock = {['file'] = 'GarageOpen.ogg', ['volume'] = 0.8},
    autoLock = 2000,
    --doorRate = 1.0,
    --showNUI = true
}

-- bcso25 created by vesku
Config.DoorList['bcso25'] = {
    slides = false,
    fixText = false,
    garage = false,
    objHash = -1156020871,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0, ['offpolice']=0 },
    objHeading = 135.0,
    locked = true,
    maxDistance = 2.0,
    objCoords = vec3(-449.691406, 6024.354980, 32.157413),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- noodle_exchange created by vesku
Config.DoorList['noodle_exchange'] = {
    lockpick = false,
    maxDistance = 2.5,
    slides = false,
    audioRemote = false,
    doors = {
        {objHash = -564814338, objHeading = 30.000001907349, objCoords = vec3(-1231.075317, -285.682312, 37.941742)},
        {objHash = -564814338, objHeading = 210.00001525879, objCoords = vec3(-1229.304932, -284.786285, 37.941742)}
    },
    locked = true,
    authorizedJobs = { ['noodleexchange']=0, ['offnoodleexchange']=0 },
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- TROLL created by vesku
Config.DoorList['TROLL'] = {
    garage = false,
    lockpick = false,
    objCoords = vec3(-590.183472, -925.563538, 27.143097),
    slides = true,
    objHash = -1264687887,
    fixText = false,
    maxDistance = 6.0,
    locked = true,
    objHeading = 179.99998474121,
    authorizedJobs = { ['casino']=0 },
    audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph created by vesku
Config.DoorList['lph'] = {
    authorizedGangs = { ['lph']=0 },
    lockpick = false,
    slides = false,
    doors = {
        {objHash = -52575179, objHeading = 270.00003051758, objCoords = vec3(1390.477905, 1161.237915, 114.483200)},
        {objHash = -1032171637, objHeading = 270.00003051758, objCoords = vec3(1390.477905, 1163.437866, 114.483200)}
    },
    maxDistance = 2.0,
    audioRemote = false,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lphstash created by vesku
Config.DoorList['lphstash'] = {
    slides = true,
    maxDistance = 2.0,
    objCoords = vec3(1396.954346, 1161.551270, 114.486259),
    authorizedGangs = { ['lph']=0 },
    garage = false,
    lockpick = false,
    locked = true,
    fixText = false,
    objHeading = 269.99691772461,
    audioRemote = false,
    objHash = 1961165613,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- lph2 created by vesku
Config.DoorList['lph2'] = {
    slides = false,
    maxDistance = 2.0,
    objCoords = vec3(1397.062378, 1164.739746, 114.483452),
    authorizedGangs = { ['lph']=0 },
    garage = false,
    lockpick = false,
    locked = true,
    fixText = false,
    objHeading = 270.00003051758,
    audioRemote = false,
    objHash = 736699661,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph3 created by vesku
Config.DoorList['lph3'] = {
    slides = false,
    maxDistance = 2.0,
    objCoords = vec3(1400.996216, 1158.950562, 114.483452),
    authorizedGangs = { ['lph']=0 },
    garage = false,
    lockpick = false,
    locked = true,
    fixText = false,
    objHeading = 89.999961853027,
    audioRemote = false,
    objHash = 736699661,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph4 created by vesku
Config.DoorList['lph4'] = {
    objHeading = 89.999961853027,
    audioRemote = false,
    maxDistance = 2.0,
    authorizedGangs = { ['lph']=0 },
    garage = false,
    locked = true,
    slides = false,
    objCoords = vec3(1397.957031, 1156.271484, 114.483452),
    fixText = false,
    lockpick = false,
    objHash = 736699661,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph5 created by vesku
Config.DoorList['lph5'] = {
    objHeading = 270.00030517578,
    audioRemote = false,
    maxDistance = 2.0,
    authorizedGangs = { ['lph']=0 },
    garage = false,
    locked = true,
    slides = false,
    objCoords = vec3(1395.828491, 1151.658813, 114.483353),
    fixText = false,
    lockpick = false,
    objHash = -52575179,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- lph6 created by vesku
Config.DoorList['lph6'] = {
    locked = true,
    authorizedGangs = { ['lph']=0 },
    doors = {
        {objHash = -1032171637, objHeading = 89.999961853027, objCoords = vec3(1409.292114, 1146.254150, 114.486916)},
        {objHash = -52575179, objHeading = 89.999961853027, objCoords = vec3(1409.292236, 1148.454346, 114.486916)}
    },
    audioRemote = false,
    lockpick = false,
    maxDistance = 2.5,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph7 created by vesku
Config.DoorList['lph7'] = {
    locked = true,
    authorizedGangs = { ['lph']=0 },
    doors = {
        {objHash = -52575179, objHeading = 89.999961853027, objCoords = vec3(1409.292236, 1150.654297, 114.486916)},
        {objHash = -1032171637, objHeading = 89.999961853027, objCoords = vec3(1409.292114, 1148.454102, 114.486916)}
    },
    audioRemote = false,
    lockpick = false,
    maxDistance = 2.5,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph8 created by vesku
Config.DoorList['lph8'] = {
    locked = true,
    authorizedGangs = { ['lph']=0 },
    doors = {
        {objHash = -1032171637, objHeading = 89.999961853027, objCoords = vec3(1409.292114, 1144.054199, 114.486916)},
        {objHash = -52575179, objHeading = 89.999961853027, objCoords = vec3(1409.292236, 1146.254272, 114.486916)}
    },
    audioRemote = false,
    lockpick = false,
    maxDistance = 2.5,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph9 created by vesku
Config.DoorList['lph9'] = {
    locked = true,
    authorizedGangs = { ['lph']=0 },
    doors = {
        {objHash = -1032171637, objHeading = 269.98272705078, objCoords = vec3(1408.581177, 1161.164795, 114.483299)},
        {objHash = -52575179, objHeading = 269.98272705078, objCoords = vec3(1408.581177, 1158.965088, 114.483299)}
    },
    audioRemote = false,
    lockpick = false,
    maxDistance = 2.5,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph10 created by vesku
Config.DoorList['lph10'] = {
    locked = true,
    authorizedGangs = { ['lph']=0 },
    doors = {
        {objHash = -1032171637, objHeading = 269.98272705078, objCoords = vec3(1408.581177, 1165.833862, 114.483299)},
        {objHash = -52575179, objHeading = 269.98272705078, objCoords = vec3(1408.581177, 1163.634155, 114.483299)}
    },
    audioRemote = false,
    lockpick = false,
    maxDistance = 2.5,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph11 created by vesku
Config.DoorList['lph11'] = {
    locked = true,
    garage = false,
    audioRemote = false,
    objCoords = vec3(1404.603760, 1137.465698, 114.589188),
    maxDistance = 2.0,
    fixText = false,
    objHeading = 90.000022888184,
    authorizedGangs = { ['lph']=0 },
    lockpick = false,
    objHash = -1170718279,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- lph12 created by vesku
Config.DoorList['lph12'] = {
    locked = true,
    authorizedGangs = { ['lph']=0 },
    doors = {
        {objHash = -52575179, objHeading = 179.99998474121, objCoords = vec3(1398.288696, 1128.314209, 114.483597)},
        {objHash = -1032171637, objHeading = 179.99998474121, objCoords = vec3(1400.488892, 1128.314209, 114.483597)}
    },
    audioRemote = false,
    lockpick = false,
    maxDistance = 2.5,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph12 created by vesku
Config.DoorList['lph12'] = {
    locked = true,
    authorizedGangs = { ['lph']=0 },
    doors = {
        {objHash = -52575179, objHeading = 179.99998474121, objCoords = vec3(1400.488159, 1128.314209, 114.483597)},
        {objHash = -1032171637, objHeading = 179.99998474121, objCoords = vec3(1402.688232, 1128.314209, 114.483597)}
    },
    audioRemote = false,
    lockpick = false,
    maxDistance = 2.5,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph13 created by vesku
Config.DoorList['lph13'] = {
    locked = true,
    authorizedGangs = { ['lph']=0 },
    doors = {
        {objHash = -1032171637, objHeading = 89.999961853027, objCoords = vec3(1390.665771, 1131.117065, 114.480843)},
        {objHash = -52575179, objHeading = 89.999961853027, objCoords = vec3(1390.665771, 1133.317261, 114.480843)}
    },
    audioRemote = false,
    lockpick = false,
    maxDistance = 2.5,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph14 created by vesku
Config.DoorList['lph14'] = {
    locked = true,
    authorizedGangs = { ['lph']=0 },
    doors = {
        {objHash = -52575179, objHeading = 179.99998474121, objCoords = vec3(1400.488159, 1128.314209, 114.483597)},
        {objHash = -1032171637, objHeading = 179.99998474121, objCoords = vec3(1402.688232, 1128.314209, 114.483597)}
    },
    audioRemote = false,
    lockpick = false,
    maxDistance = 2.5,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph15 created by vesku
Config.DoorList['lph15'] = {
    locked = true,
    garage = false,
    audioRemote = false,
    objCoords = vec3(1395.944580, 1137.435547, 114.480247),
    maxDistance = 2.0,
    fixText = false,
    objHeading = 89.999961853027,
    authorizedGangs = { ['lph']=0 },
    lockpick = false,
    objHash = 736699661,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph16 created by vesku
Config.DoorList['lph16'] = {
    locked = true,
    authorizedGangs = { ['lph']=0 },
    doors = {
        {objHash = 262671971, objHeading = 89.999961853027, objCoords = vec3(1395.919922, 1140.704590, 114.790207)},
        {objHash = 1504256620, objHeading = 270.00003051758, objCoords = vec3(1395.920288, 1142.904053, 114.790207)}
    },
    audioRemote = false,
    lockpick = false,
    maxDistance = 2.5,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lph16 created by vesku
Config.DoorList['lph16'] = {
    doors = {
        {objHash = -1032171637, objHeading = 179.99998474121, objCoords = vec3(1400.488892, 1128.314209, 114.483597)},
        {objHash = -52575179, objHeading = 179.99998474121, objCoords = vec3(1398.288696, 1128.314209, 114.483597)}
    },
    lockpick = false,
    authorizedGangs = { ['lph']=0 },
    slides = false,
    maxDistance = 2.5,
    locked = true,
    audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lphfront created by vesku
Config.DoorList['lphfront'] = {
    slides = false,
    maxDistance = 2.5,
    audioRemote = false,
    authorizedGangs = { ['lph']=0 },
    locked = true,
    doors = {
        {objHash = 262671971, objHeading = 89.999961853027, objCoords = vec3(1395.919922, 1140.704590, 114.790207)},
        {objHash = 1504256620, objHeading = 270.00003051758, objCoords = vec3(1395.920288, 1142.904053, 114.790207)}
    },
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- hiddenstash1 created by vesku
Config.DoorList['hiddenstash1'] = {
    locked = true,
    audioRemote = false,
    lockpick = false,
    garage = false,
    slides = false,
    objHash = -1626044509,
    authorizedGangs = { ['lph']=0 },
    fixText = false,
    objCoords = vec3(1390.727051, 1141.911255, 110.870026),
    objHeading = 270.00003051758,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- lphstash2 created by vesku
Config.DoorList['lphstash2'] = {
    locked = true,
    audioRemote = false,
    authorizedGangs = { ['lph']=0 },
    lockpick = false,
    garage = false,
    slides = true,
    objHash = -1497650016,
    fixText = false,
    objCoords = vec3(1404.489624, 1146.074829, 109.721840),
    objHeading = 269.99719238281,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- lphdoor232 created by vesku
Config.DoorList['lphdoor232'] = {
    locked = true,
    audioRemote = false,
    authorizedGangs = { ['lph']=0 },
    lockpick = false,
    garage = false,
    slides = false,
    objHash = 736699661,
    fixText = false,
    objCoords = vec3(1403.788086, 1158.537476, 114.484932),
    objHeading = 180.00001525879,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}

-- lphinsidestash created by vesku
Config.DoorList['lphinsidestash'] = {
    slides = false,
    authorizedGangs = { ['lph']=0 },
    objHeading = 180.00001525879,
    lockpick = false,
    locked = true,
    audioRemote = false,
    garage = false,
    objCoords = vec3(1408.206421, 1143.397583, 110.880508),
    maxDistance = 2.0,
    fixText = false,
    objHash = -122922994,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    showNUI = false
}