--local defaultDuiUrl = 'https://i.imgur.com/5Ust2GQ.jpg'
local currentBoardUrl = 'https://i.imgur.com/5Ust2GQ.jpg'
local inClassRoom = false
local dui = nil

Citizen.CreateThread(function()
	exports["polyzonehelper"]:AddPolyZone("mrpd_classroom", {
		vector2(448.41372680664, -990.47613525391),
		vector2(439.50704956055, -990.55731201172),
		vector2(439.43478393555, -981.08758544922),
		vector2(448.419921875, -981.26306152344),
		vector2(450.23190307617, -983.00885009766),
		vector2(450.25042724609, -988.77667236328)
	  }, {
		gridDivisions = 25,
		minZ = 34.04,
		maxZ = 37.69,
		debugPoly=false
	  })
end)

  exports['lrp-target']:AddBoxZone("mrdp_change_picture", vector3(439.44, -985.89, 34.97), 1.0, 0.4, {
    name="mrdp_change_picture",
    heading = 0,
    debugPoly=false,
    minZ=35.37,
    maxZ=36.17
    }, 
    {
    options = {
        {
            type = "client",
            event = "lrp-police:changewhiteboardurl",
            icon = "fas fa-tv",
            label = "Change URL",
        },
    },
    distance = 4.5
})

AddEventHandler("polyzonehelper:enter", function(zone)
	local currentZone = zone
	if currentZone == "mrpd_classroom" then
	  if not dui then
		dui = exports["lrp-scripts"]:getDui(currentBoardUrl)
		AddReplaceTexture('prop_planning_b1', 'prop_base_white_01b', dui.dictionary, dui.texture)
	  else
		exports["lrp-scripts"]:changeDuiUrl(dui.id, currentBoardUrl)
	  end
	  inClassRoom = true
	end
  end)
  
  AddEventHandler("polyzonehelper:exit", function(zone)
	local currentZone = zone
	if currentZone == "mrpd_classroom" then
	  RemoveReplaceTexture('prop_planning_b1', 'prop_base_white_01b')
	  if dui ~= nil then
		exports["lrp-scripts"]:releaseDui(dui.id)
		dui = nil
	  end
	  inClassRoom = false
	end
  end)
  
  RegisterNetEvent("police:changewhiteboardcli")
  AddEventHandler("police:changewhiteboardcli", function(pUrl)
	if inClassRoom and dui then
	  currentBoardUrl = pUrl.mrpdlink
	  exports["lrp-scripts"]:changeDuiUrl(dui.id, currentBoardUrl)
	end
  end)
  
  RegisterNetEvent("lrp:policechangeurl", function(dialog)
	TriggerServerEvent("police:changewhiteboard", dialog)
  end)
  
  RegisterNetEvent("lrp-police:changewhiteboardurl", function()
	local dialog = exports['lrp-input']:ShowInput({
        header = "Change URL",
        submitText = "Submit",
        inputs = {
            {
                text = "Link", -- text you want to be displayed as a place holder
                name = "mrpdlink", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
			}
		}})
		TriggerEvent('lrp:policechangeurl', dialog)
  end)

  