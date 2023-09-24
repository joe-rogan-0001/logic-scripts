Config = {}

Config.Objects = {
    ["tent"] = {model = `prop_gazebo_03`, freeze = true},
	["table"] = {model = `bkr_prop_coke_table01a`, freeze = true},
	["ballel"] = {model = `prop_barrel_03a`, freeze = true},
}


Config.Delays = {
	WeedTrimming = 15000,
	WeedProcessing = 7000,
	WeedBrick = 30000,

	cokeProcessing = 40000,
	cokeBagging = 7000,
	cokeBrick = 30000,

	territory = 300000   -- how long it takes to update when the territory has been taken for gangs to access the drug.
}



Config.CircleZones = {
	WeedField = {coords = vector3(319.9, 4326.13, 48.6), name = 'blip_weedfield', color = 25, sprite = 496, radius = 100.0},
	cokeField = {coords = vector3(3912.29, 3619.41, 26.34), name = 'blip_cokefield', color = 25, sprite = 496, radius = 100.0},
}







