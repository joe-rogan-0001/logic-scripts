local debugEnabled = false
local debugMaxDistance = 300.0
local comboZone = nil
local insideZone = false
local createdZones = {}

local function addToComboZone(zone)
    if comboZone ~= nil then
        comboZone:AddZone(zone)
    else
        comboZone = ComboZone:Create({ zone }, { name = "np-polyzone" })
        comboZone:onPlayerInOutExhaustive(function(isPointInside, point, insideZones, enteredZones, leftZones)
            if leftZones ~= nil then
              for i = 1, #leftZones do
                TriggerEvent("np-polyzone:exit", leftZones[i].name, leftZones[i].data)
              end
            end
            if enteredZones ~= nil then
              for i = 1, #enteredZones do
                TriggerEvent("np-polyzone:enter", enteredZones[i].name, enteredZones[i].data, enteredZones[i].center)
              end
            end
        end, 500)
    end
end

local function doCreateZone(options)
  if options.data and options.data.id then
    local key = options.name .. "_" .. tostring(options.data.id)
    if not createdZones[key] then
      createdZones[key] = true
      return true
    else
      print('polyzone with name/id already added, skipping: ', key)
      return false
    end
  end
  return true
end

local function addZoneEvent(eventName, zoneName)
  if comboZone.events and comboZone.events[eventName] ~= nil then
    return
  end
  comboZone:addEvent(eventName, zoneName)
end

local function addZoneEvents(zone, zoneEvents)
  if zoneEvents == nil then return end

  for _, v in ipairs(zoneEvents) do
    addZoneEvent(v, zone.name)
  end
end

exports("AddBoxZone", function(name, vectors, length, width, options)
    if not options then options = {} end
    options.name = name
    if not doCreateZone(options) then return end
    local boxCenter = type(vectors) ~= 'vector3' and vector3(vectors.x, vectors.y, vectors.z) or vectors
    local zone = BoxZone:Create(boxCenter, length, width, options)
    addToComboZone(zone)
    addZoneEvents(zone, options.zoneEvents)
end)

local function addCircleZone(name, center, radius, options)
  if not options then options = {} end
  options.name = name
  if not doCreateZone(options) then return end
  local circleCenter = type(center) ~= 'vector3' and vector3(center.x, center.y, center.z) or center
  local zone = CircleZone:Create(circleCenter, radius, options)
  addToComboZone(zone)
  addZoneEvents(zone, options.zoneEvents)
end
exports("AddCircleZone", addCircleZone)

exports("AddPolyZone", function(name, vectors, options)
    if not options then options = {} end
    options.name = name
    if not doCreateZone(options) then return end
    local zone = PolyZone:Create(vectors, options)
    addToComboZone(zone)
    addZoneEvents(zone, options.zoneEvents)
end)

exports("AddZoneEvent", function(eventName, zoneName)
  addZoneEvent(eventName, zoneName)
end)

RegisterNetEvent("np-polyzone:createCircleZone")
AddEventHandler("np-polyzone:createCircleZone", function(name, ...)
  addCircleZone(name, ...)
end)

local function toggleDebug(state)
  if state == debugEnabled then return end
  debugEnabled = state
  if debugEnabled then
    while debugEnabled do
      local plyPos = GetEntityCoords(PlayerPedId()).xy
      for i, zone in ipairs(comboZone.zones) do
        if zone and not zone.destroyed and #(plyPos - zone.center.xy) < debugMaxDistance then
          zone:draw()
        end
      end
      Wait(0)
    end
  end
end

if GetConvar("sv_environment", "prod") == "debug" then
  RegisterCommand("np-polyzone:debug", function (src, args)
    toggleDebug(not debugEnabled)
  end)
end


local ve = {
  {pos = vector3(299.942, -330.033, 43.92), heading = 70.0, length = 6, width = 4, name = 'Q'},
  {pos = vector3(298.716, -333.248, 43.92), heading = 70.0, length = 6, width = 4, name = 'Q'},
  {pos = vector3(297.489, -336.463, 43.92), heading = 70.0, length = 6, width = 4, name = 'Q'},
  {pos = vector3(296.263, -339.679, 43.92), heading = 70.0, length = 6, width = 4, name = 'Q'},
  {pos = vector3(295.036, -342.894, 43.92), heading = 70.0, length = 6, width = 4, name = 'Q'},
  {pos = vector3(293.81,  -346.109, 43.92), heading = 70.0, length = 6, width = 4, name = 'Q'},
}

