local QBCore = exports['lrp-core']:GetCoreObject()
local enabled = false
local player = false
local firstChar = false
local currentFadeStyle = 255
local cam = false
local customCam = false
local oldPed = false
local startingMenu = false

local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}
local prop_names = {"hats", "glasses", "earrings", "mouth", "lhand", "rhand", "watches", "braclets"}
local head_overlays = {"Blemishes","FacialHair","Eyebrows","Ageing","Makeup","Blush","Complexion","SunDamage","Lipstick","MolesFreckles","ChestHair","BodyBlemishes","AddBodyBlemishes"}
local face_features = {"Nose_Width","Nose_Peak_Hight","Nose_Peak_Lenght","Nose_Bone_High","Nose_Peak_Lowering","Nose_Bone_Twist","EyeBrown_High","EyeBrown_Forward","Cheeks_Bone_High","Cheeks_Bone_Width","Cheeks_Width","Eyes_Openning","Lips_Thickness","Jaw_Bone_Width","Jaw_Bone_Back_Lenght","Chimp_Bone_Lowering","Chimp_Bone_Lenght","Chimp_Bone_Width","Chimp_Hole","Neck_Thikness"}
local tatCategory = GetTatCategs()
local tattooHashList = CreateHashList()

local isService = false
local passedClothing = true

local currentPrice = 250

local MenuData = {
    clothing_shop = {
        text = "To buy clothes",
        displayName = "Clothing Store",
        basePrice = 200
    },
    barber_shop = {
        text = "Change appearance",
        displayName = "Barber Shop",
        basePrice = 200
    },
    tattoo_shop = {
        text = "Get tattoos",
        displayName = "Tattoo Parlor",
        basePrice = 200
    }
}

local listening = false

function RefreshUI()
    hairColors = {}
    for i = 0, GetNumHairColors()-1 do
        local outR, outG, outB= GetPedHairRgbColor(i)
        hairColors[i] = {outR, outG, outB}
    end

    makeupColors = {}
    for i = 0, GetNumMakeupColors()-1 do
        local outR, outG, outB= GetPedMakeupRgbColor(i)
        makeupColors[i] = {outR, outG, outB}
    end

    SendNUIMessage({
        type="colors",
        hairColors=hairColors,
        makeupColors=makeupColors,
        hairColor=GetPedHair()
    })
    SendNUIMessage({
        type = "menutotals",
        drawTotal = GetDrawablesTotal(),
        propDrawTotal = GetPropDrawablesTotal(),
        textureTotal = GetTextureTotals(),
        headoverlayTotal = GetHeadOverlayTotals(),
        skinTotal = GetSkinTotal(),
        fadeTotal = GetFadeTotal()
    })
    SendNUIMessage({
        type = "barber_shop",
        headBlend = GetPedHeadBlendData(),
        headOverlay = GetHeadOverlayData(),
        headStructure = GetHeadStructureData()
    })
    SendNUIMessage({
        type = "clothing_shopdata",
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        proptextures = GetPropTextures(),
        skin = GetSkin(),
        currentFade = currentFadeStyle,
        oldPed = oldPed,
    })
    SendNUIMessage({
        type = "tattoo_shop",
        totals = tatCategory,
        values = GetTats()
    })
end

function GetSkin()
    for i = 1, #frm_skins do
        if (GetHashKey(frm_skins[i]) == GetEntityModel(PlayerPedId())) then
            return {name="skin_male", value=i}
        end
    end
    for i = 1, #fr_skins do
        if (GetHashKey(fr_skins[i]) == GetEntityModel(PlayerPedId())) then
            return {name="skin_female", value=i}
        end
    end
    return false
end

function GetDrawables()
    drawables = {}
    local model = GetEntityModel(PlayerPedId())
    local mpPed = false
    if (model == `mp_f_freemode_01` or model == `mp_m_freemode_01`) then
        mpPed = true
    end
    for i = 0, #drawable_names-1 do
        if mpPed and drawable_names[i+1] == "undershirts" and GetPedDrawableVariation(player, i) == -1 then
            SetPedComponentVariation(player, i, 15, 0, 2)
        end
        drawables[i] = {drawable_names[i+1], GetPedDrawableVariation(player, i)}
    end
    return drawables
end

function GetProps()
    props = {}
    for i = 0, #prop_names-1 do
        props[i] = {prop_names[i+1], GetPedPropIndex(player, i)}
    end
    return props
end

function GetDrawTextures()
    textures = {}
    for i = 0, #drawable_names-1 do
        table.insert(textures, {drawable_names[i+1], GetPedTextureVariation(player, i)})
    end
    return textures
end

function GetPropTextures()
    textures = {}
    for i = 0, #prop_names-1 do
        table.insert(textures, {prop_names[i+1], GetPedPropTextureIndex(player, i)})
    end
    return textures
end

function GetDrawablesTotal()
    drawables = {}
    for i = 0, #drawable_names - 1 do
        drawables[i] = {drawable_names[i+1], GetNumberOfPedDrawableVariations(player, i)}
    end
    return drawables
end

function GetPropDrawablesTotal()
    props = {}
    for i = 0, #prop_names - 1 do
        props[i] = {prop_names[i+1], GetNumberOfPedPropDrawableVariations(player, i)}
    end
    return props
end

function GetTextureTotals()
    local values = {}
    local draw = GetDrawables()
    local props = GetProps()

    for idx = 0, #draw-1 do
        local name = draw[idx][1]
        local value = draw[idx][2]
        values[name] = GetNumberOfPedTextureVariations(player, idx, value)
    end

    for idx = 0, #props-1 do
        local name = props[idx][1]
        local value = props[idx][2]
        values[name] = GetNumberOfPedPropTextureVariations(player, idx, value)
    end
    return values
end

function SetClothing(drawables, props, drawTextures, propTextures)
    for i = 1, #drawable_names do
        if drawables[0] == nil then
            if drawable_names[i] == "undershirts" and drawables[tostring(i-1)][2] == -1 then
                SetPedComponentVariation(player, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(player, i-1, drawables[tostring(i-1)][2], drawTextures[i][2], 2)
            end
        else
            if drawable_names[i] == "undershirts" and drawables[i-1][2] == -1 then
                SetPedComponentVariation(player, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(player, i-1, drawables[i-1][2], drawTextures[i][2], 2)
            end
        end
    end

    for i = 1, #prop_names do
        local propZ = (drawables[0] == nil and props[tostring(i-1)][2] or props[i-1][2])
        ClearPedProp(player, i-1)
        SetPedPropIndex(
            player,
            i-1,
            propZ,
            propTextures[i][2], true)
    end
end

function GetSkinTotal()
  return {
    #frm_skins,
    #fr_skins
  }
end

local toggleClothing = {}
function ToggleProps(data)
    local name = data["name"]

    selectedValue = has_value(drawable_names, name)
    if (selectedValue > -1) then
        if (toggleClothing[name] ~= nil) then
            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                tonumber(toggleClothing[name][1]),
                tonumber(toggleClothing[name][2]), 2)
            toggleClothing[name] = nil
        else
            toggleClothing[name] = {
                GetPedDrawableVariation(player, tonumber(selectedValue)),
                GetPedTextureVariation(player, tonumber(selectedValue))
            }

            local value = -1
            if name == "undershirts" or name == "torsos" then
                value = 15
                if name == "undershirts" and GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') then
                    value = -1
                end
            end
            if name == "legs" then
                value = 14
            end

            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                value, 0, 2)
        end
    else
        selectedValue = has_value(prop_names, name)
        if (selectedValue > -1) then
            if (toggleClothing[name] ~= nil) then
                SetPedPropIndex(
                    player,
                    tonumber(selectedValue),
                    tonumber(toggleClothing[name][1]),
                    tonumber(toggleClothing[name][2]), true)
                toggleClothing[name] = nil
            else
                toggleClothing[name] = {
                    GetPedPropIndex(player, tonumber(selectedValue)),
                    GetPedPropTextureIndex(player, tonumber(selectedValue))
                }
                ClearPedProp(player, tonumber(selectedValue))
            end
        end
    end
end

function SaveToggleProps()
    for k in pairs(toggleClothing) do
        local name  = k
        selectedValue = has_value(drawable_names, name)
        if (selectedValue > -1) then
            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                tonumber(toggleClothing[name][1]),
                tonumber(toggleClothing[name][2]), 2)
            toggleClothing[name] = nil
        else
            selectedValue = has_value(prop_names, name)
            if (selectedValue > -1) then
                SetPedPropIndex(
                    player,
                    tonumber(selectedValue),
                    tonumber(toggleClothing[name][1]),
                    tonumber(toggleClothing[name][2]), true)
                toggleClothing[name] = nil
            end
        end
    end
end

function LoadPed(data)
    SetSkin(data.model, true)
    SetClothing(data.drawables, data.props, data.drawtextures, data.proptextures)
    Citizen.Wait(500)
    SetPedHairColor(player, tonumber(data.hairColor[1]), tonumber(data.hairColor[2]))
    SetPedHeadBlend(data.headBlend)
    SetHeadStructure(data.headStructure)
    setTattoosAndFacial(nil, data.fadeStyle)
    SetHeadOverlayData(data.headOverlay)
    return
end

function GetCurrentPed()
    player = PlayerPedId()
    return {
        model = GetEntityModel(PlayerPedId()),
        hairColor = GetPedHair(),
        headBlend = GetPedHeadBlendData(),
        headOverlay = GetHeadOverlayData(),
        headStructure = GetHeadStructure(),
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        fadeStyle = currentFadeStyle,
        proptextures = GetPropTextures(),
    }
end

function PlayerModel(data)
    local skins = nil
    if (data['name'] == 'skin_male') then
        skins = frm_skins
    else
        skins = fr_skins
    end
    local skin = skins[tonumber(data['value'])]
    rotation(180.0)
    SetSkin(GetHashKey(skin), true)
    Citizen.Wait(1)
    rotation(180.0)
end

local function ToggleClothingToLoadPed()
    local ped = PlayerPedId()
    local drawables = GetDrawablesTotal()

    for num, _ in pairs(drawables) do
        if drawables[num][2] > 1 then
            component = tonumber(num)
            SetPedComponentVariation(ped, component, 1, 0, 0)
            Wait(250)
            SetPedComponentVariation(ped, component, 0, 0, 0)
            break
        end
    end
end

local inSpawn = false
AddEventHandler("iconic-clothingmenu:inSpawn", function(pInSpawn)
    inSpawn = pInSpawn
end)


function SetSkin(model, setDefault)
    -- TODO: If not isCop and model not in copModellist, do below.
    -- Model is a hash, GetHashKey(modelName)
    SetEntityInvincible(PlayerPedId(),true)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while (not HasModelLoaded(model)) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
        player = PlayerPedId()
        FreezePedCameraRotation(player, true)
        SetPedMaxHealth(player, 200)
        ToggleClothingToLoadPed()
        SetPedDefaultComponentVariation(player)
        if inSpawn then
            SetEntityHealth(player, GetEntityMaxHealth(player))
        end
        if setDefault and model and not isCustomSkin(model) and (model == `mp_f_freemode_01` or model == `mp_m_freemode_01`) then
            SetPedHeadBlendData(player, 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
            SetPedComponentVariation(player, 11, 0, 1, 0)
            SetPedComponentVariation(player, 8, 0, 1, 0)
            SetPedComponentVariation(player, 6, 1, 2, 0)
            SetPedHeadOverlayColor(player, 1, 1, 0, 0)
            SetPedHeadOverlayColor(player, 2, 1, 0, 0)
            SetPedHeadOverlayColor(player, 4, 2, 0, 0)
            SetPedHeadOverlayColor(player, 5, 2, 0, 0)
            SetPedHeadOverlayColor(player, 8, 2, 0, 0)
            SetPedHeadOverlayColor(player, 10, 1, 0, 0)
            SetPedHeadOverlay(player, 1, 0, 0.0)
            SetPedHairColor(player, 1, 1)
        end
    end
    SetEntityInvincible(PlayerPedId(),false)
end


RegisterNUICallback('updateclothes', function(data, cb)
    toggleClothing[data["name"]] = nil
    selectedValue = has_value(drawable_names, data["name"])
    if (selectedValue > -1) then
        SetPedComponentVariation(player, tonumber(selectedValue), tonumber(data["value"]), tonumber(data["texture"]), 2)
        cb({
            GetNumberOfPedTextureVariations(player, tonumber(selectedValue), tonumber(data["value"]))
        })
    else
        selectedValue = has_value(prop_names, data["name"])
        if (tonumber(data["value"]) == -1) then
            ClearPedProp(player, tonumber(selectedValue))
        else
            SetPedPropIndex(
                player,
                tonumber(selectedValue),
                tonumber(data["value"]),
                tonumber(data["texture"]), true)
        end
        cb({
            GetNumberOfPedPropTextureVariations(
                player,
                tonumber(selectedValue),
                tonumber(data["value"])
            )
        })
    end
end)

RegisterNUICallback('customskin', function(data, cb)
    if canUseCustomSkins() then
        local valid_model = isInSkins(data)
        if valid_model then
            SetSkin(GetHashKey(data), true)
        end
    end
end)

RegisterNUICallback('setped', function(data, cb)
    PlayerModel(data)
    RefreshUI()
    cb('ok')
end)

RegisterNUICallback('resetped', function(data, cb)
    LoadPed(oldPed)
    cb('ok')
end)


------------------------------------------------------------------------------------------
-- Barber

function GetPedHeadBlendData()
    local blob = string.rep("\0\0\0\0\0\0\0\0", 6 + 3 + 1) -- Generate sufficient struct memory.
    if not Citizen.InvokeNative(0x2746BD9D88C5C5D0, player, blob, true) then -- Attempt to write into memory blob.
        return nil
    end

    return {
        shapeFirst = string.unpack("<i4", blob, 1),
        shapeSecond = string.unpack("<i4", blob, 9),
        shapeThird = string.unpack("<i4", blob, 17),
        skinFirst = string.unpack("<i4", blob, 25),
        skinSecond = string.unpack("<i4", blob, 33),
        skinThird = string.unpack("<i4", blob, 41),
        shapeMix = string.unpack("<f", blob, 49),
        skinMix = string.unpack("<f", blob, 57),
        thirdMix = string.unpack("<f", blob, 65),
        hasParent = string.unpack("b", blob, 73) ~= 0,
    }
end

function SetPedHeadBlend(data)
    if data ~= nil then
        SetPedHeadBlendData(player,
            tonumber(data['shapeFirst']),
            tonumber(data['shapeSecond']),
            tonumber(data['shapeThird']),
            tonumber(data['skinFirst']),
            tonumber(data['skinSecond']),
            tonumber(data['skinThird']),
            tonumber(data['shapeMix']),
            tonumber(data['skinMix']),
            tonumber(data['thirdMix']),
            false)
    end
end

function GetHeadOverlayData()
    local headData = {}
    for i = 1, #head_overlays do
        local retval, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(player, i-1)
        if retval then
            headData[i] = {}
            headData[i].name = head_overlays[i]
            headData[i].overlayValue = overlayValue
            headData[i].colourType = colourType
            headData[i].firstColour = firstColour
            headData[i].secondColour = secondColour
            headData[i].overlayOpacity = overlayOpacity
        end
    end
    return headData
end

function SetHeadOverlayData(data)
    if json.encode(data) ~= "[]" then
        for i = 1, #head_overlays do
            SetPedHeadOverlay(player,  i-1, tonumber(data[i].overlayValue),  tonumber(data[i].overlayOpacity))
            -- SetPedHeadOverlayColor(player, i-1, data[i].colourType, data[i].firstColour, data[i].secondColour)
        end

        SetPedHeadOverlayColor(player, 0, 0, tonumber(data[1].firstColour), tonumber(data[1].secondColour))
        SetPedHeadOverlayColor(player, 1, 1, tonumber(data[2].firstColour), tonumber(data[2].secondColour))
        SetPedHeadOverlayColor(player, 2, 1, tonumber(data[3].firstColour), tonumber(data[3].secondColour))
        SetPedHeadOverlayColor(player, 3, 0, tonumber(data[4].firstColour), tonumber(data[4].secondColour))
        SetPedHeadOverlayColor(player, 4, 2, tonumber(data[5].firstColour), tonumber(data[5].secondColour))
        SetPedHeadOverlayColor(player, 5, 2, tonumber(data[6].firstColour), tonumber(data[6].secondColour))
        SetPedHeadOverlayColor(player, 6, 0, tonumber(data[7].firstColour), tonumber(data[7].secondColour))
        SetPedHeadOverlayColor(player, 7, 0, tonumber(data[8].firstColour), tonumber(data[8].secondColour))
        SetPedHeadOverlayColor(player, 8, 2, tonumber(data[9].firstColour), tonumber(data[9].secondColour))
        SetPedHeadOverlayColor(player, 9, 0, tonumber(data[10].firstColour), tonumber(data[10].secondColour))
        SetPedHeadOverlayColor(player, 10, 1, tonumber(data[11].firstColour), tonumber(data[11].secondColour))
        SetPedHeadOverlayColor(player, 11, 0, tonumber(data[12].firstColour), tonumber(data[12].secondColour))
    end
end

function GetHeadOverlayTotals()
    local totals = {}
    for i = 1, #head_overlays do
        totals[head_overlays[i]] = GetNumHeadOverlayValues(i-1)
    end
    return totals
end

function GetPedHair()
    local hairColor = {}
    hairColor[1] = GetPedHairColor(player)
    hairColor[2] = GetPedHairHighlightColor(player)
    return hairColor
end

function GetHeadStructureData()
    local structure = {}
    for i = 1, #face_features do
        structure[face_features[i]] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function GetHeadStructure(data)
    local structure = {}
    for i = 1, #face_features do
        structure[i] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function SetHeadStructure(data)
    for i = 1, #face_features do
        SetPedFaceFeature(player, i-1, data[i])
    end
end


RegisterNUICallback('saveheadblend', function(data, cb)
    SetPedHeadBlendData(player,
    tonumber(data.shapeFirst),
    tonumber(data.shapeSecond),
    tonumber(data.shapeThird),
    tonumber(data.skinFirst),
    tonumber(data.skinSecond),
    tonumber(data.skinThird),
    tonumber(data.shapeMix) / 100,
    tonumber(data.skinMix) / 100,
    tonumber(data.thirdMix) / 100, false)
    cb('ok')
end)

RegisterNUICallback('savehaircolor', function(data, cb)
    SetPedHairColor(player, tonumber(data['firstColour']), tonumber(data['secondColour']))
    cb('ok')
end)

RegisterNUICallback('savefacefeatures', function(data, cb)
    local index = has_value(face_features, data["name"])
    if (index <= -1) then return end
    local scale = tonumber(data["scale"]) / 100
    SetPedFaceFeature(player, index, scale)
    cb('ok')
end)

RegisterNUICallback('saveheadoverlay', function(data, cb)
    if data["name"] == "fadeStyle" then
      setTattoosAndFacial(nil, tonumber(data["value"]))
    else
      local index = has_value(head_overlays, data["name"])
      SetPedHeadOverlay(player,  index, tonumber(data["value"]), tonumber(data["opacity"]) / 100)
    end
    cb('ok')
end)

RegisterNUICallback('saveheadoverlaycolor', function(data, cb)
    local index = has_value(head_overlays, data["name"])
    local success, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(player, index)
    local sColor = tonumber(data['secondColour'])
    if (sColor == nil) then
        sColor = tonumber(data['firstColour'])
    end
    SetPedHeadOverlayColor(player, index, colourType, tonumber(data['firstColour']), sColor)
    cb('ok')
end)


----------------------------------------------------------------------------------
-- UTIL SHIT


function has_value (tab, val)
    for index = 1, #tab do
        if tab[index] == val then
            return index-1
        end
    end
    return -1
end

function EnableGUI(enable, menu, pPriceText, pPrice,disableDestroyCams)
    enabled = enable
    SetCustomNuiFocus(enable, enable)
    SendNUIMessage({
        type = "enableclothing_shop",
        enable = enable,
        menu = menu,
        priceText = '250',
        price = 250
    })

    if (not enable and not startingMenu) then
        SaveToggleProps()
        oldPed = {}
        DestroyAllCams(true)
        RenderScriptCams(false, true, 1, true, true)
    end
end

function CustomCamera(position,ending)
    if startingMenu and position == "torso" then return end
    if not enabled then return end
    if customCam  then
        FreezePedCameraRotation(player, false)
        SetCamActive(cam, false)
        if not ending and not startingMenu then
            RenderScriptCams(false,  false,  0,  true,  true)
            if (DoesCamExist(cam)) then
               DestroyCam(cam, false)
            end
        end
        customCam = false
    else
        if (DoesCamExist(cam)) then
            DestroyCam(cam, false)
        end

        local pos = GetEntityCoords(player, true)
        if not startingMenu then
            SetEntityRotation(player, 0.0, 0.0, 0.0, 1, true)
        end

        FreezePedCameraRotation(player, true)

        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamCoord(cam, player)
        SetCamRot(cam, 0.0, 0.0, 0.0)

        SetCamActive(cam, true)
        RenderScriptCams(true,  false,  0,  true,  true)

        SwitchCam(position)
        customCam = true
    end
end

function rotation(dir)
    local pedRot = GetEntityHeading(PlayerPedId())+dir
    SetEntityHeading(PlayerPedId(), pedRot % 360)
end

function TogRotation()
    local pedRot = GetEntityHeading(PlayerPedId())+90 % 360
    SetEntityHeading(PlayerPedId(), math.floor(pedRot / 90) * 90.0)
end

function SwitchCam(name)
    if name == "cam" then
        TogRotation()
        return
    end

    local pos = GetEntityCoords(player, true)
    local bonepos = false
    if (name == "head") then
        bonepos = GetPedBoneCoords(player, 31086)
        if startingMenu then
            bonepos = vector3(bonepos.x - 0.7, bonepos.y + 0.0, bonepos.z + 0.05)
        else
            bonepos = vector3(bonepos.x - 0.1, bonepos.y + 0.4, bonepos.z + 0.05)
        end
        
    end
    if (name == "torso") then
        bonepos = GetPedBoneCoords(player, 11816)
        bonepos = vector3(bonepos.x - 0.4, bonepos.y + 2.2, bonepos.z + 0.2)
    end
    if (name == "leg") then
        bonepos = GetPedBoneCoords(player, 46078)

        if startingMenu then
            bonepos = vector3(bonepos.x - 0.9, bonepos.y + 0.0, bonepos.z-0.2)
        else
            bonepos = vector3(bonepos.x - 0.1, bonepos.y + 1, bonepos.z)
        end

    end

    SetCamCoord(cam, bonepos.x, bonepos.y, bonepos.z)
    if startingMenu and name ~= "torso" then
        SetCamRot(cam, 0.0, 0.0, 250.0)
    else
        SetCamRot(cam, 0.0, 0.0, 180.0)
    end
    
end

RegisterNetEvent("clothing:close")
AddEventHandler("clothing:close", function()
    EnableGUI(false, false)
    FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNUICallback('escape', function(data, cb)
    local shouldSave = data['save'] or false
    local newFadeStyle = data["fadeStyle"] or 255
    local paymentType = data["paymentType"] or "cash"

    if shouldSave and currentPrice > 0 then
        TriggerServerEvent("clothing:checkMoney", currentPrice, paymentType)
        local Player = QBCore.Functions.GetPlayerData()
        local balance = Player.money[paymentType]
        if balance < currentPrice then
            shouldSave = false
        end
    end
    if not startingMenu then
        TriggerServerEvent("Police:getMeta")
    end
    Save(shouldSave, true, newFadeStyle)
    cb('ok')
end)

RegisterNUICallback('togglecursor', function(data, cb)
    if not startingMenu then
        CustomCamera("torso")
        SetCustomNuiFocus(false, false)
        FreezePedCameraRotation(player, false)
    end
    cb('ok')
end)

RegisterNUICallback('rotate', function(data, cb)
    if (data["key"] == "left") then
        rotation(20)
    else
        rotation(-20)
    end
    cb('ok')
end)

RegisterNUICallback('switchcam', function(data, cb)
    CustomCamera(data['name'])
    cb('ok')
end)

RegisterNUICallback('toggleclothes', function(data, cb)
    ToggleProps(data)
    cb('ok')
end)


------------------------------------------------------------------------
-- Tattooooooos


-- currentTats [[collectionHash, tatHash], [collectionHash, tatHash]]
-- loop tattooHashList [categ] find [tatHash, collectionHash]

function GetTats()
    local tempTats = {}
    if currentTats == nil then return {} end
    for i = 1, #currentTats do
        for key in pairs(tattooHashList) do
            for j = 1, #tattooHashList[key] do
                if tattooHashList[key][j][1] == currentTats[i][2] then
                    tempTats[key] = j
                end
            end
        end
    end
    return tempTats
end

function SetTats(data)
    currentTats = {}
    for k, v in pairs(data) do
        for categ in pairs(tattooHashList) do
            if k == categ then
                local something = tattooHashList[categ][tonumber(v)]
                if something ~= nil then
                    table.insert(currentTats, {something[2], something[1]})
                end
            end
        end
    end
    ClearPedDecorations(PlayerPedId())
    for i = 1, #currentTats do
        ApplyPedOverlay(PlayerPedId(), currentTats[i][1], currentTats[i][2])
    end
end

RegisterNUICallback('settats', function(data, cb)
    setTattoosAndFacial(data["tats"], currentFadeStyle)
    cb('ok')
end)


--------------------------------------------------------------------
-- Main menu

function OpenMenu(name, pPriceText, pPrice)
    player = PlayerPedId()
    oldPed = GetCurrentPed()
    local isAllowed = false
    if(oldPed.model == 1885233650 or oldPed.model == -1667301416) then isAllowed = true end
    if((oldPed.model ~= 1885233650 or oldPed.model ~= -1667301416) and (name == "clothing_shop" or name == "tattoo_shop" or name == "barber_shop")) then isAllowed = true end
    if isAllowed then
        FreezePedCameraRotation(player, true)
        RefreshUI()
        EnableGUI(true, name, pPriceText, pPrice)
        TriggerEvent("inmenu", true)
    else
        exports['lrp-notify']:Alert("Clothing", "You need to leave sir", 5000, 'info');
    end
end

function Save(save, close, newFadeStyle)

    if save then

        currentFadeStyle = newFadeStyle 

        data = GetCurrentPed()

        if (GetCurrentPed().model == GetHashKey("mp_f_freemode_01") or GetCurrentPed().model == GetHashKey("mp_m_freemode_01")) and startingMenu then
            --passedClothing = false
        else
            passedClothing = true
        end
        

        if not startingMenu or passedClothing then
            TriggerServerEvent("iconic-clothingmenu:insert_character_current", data)
            TriggerServerEvent("iconic-clothingmenu:insert_character_face", data)
            TriggerServerEvent("iconic-clothingmenu:set_tats", currentTats)
            TriggerEvent("iconic-login:finishedClothing","Finished")
        elseif not passedClothing then 
            passedClothing = true
            Wait(2000)
            OpenMenu("barber_shop")
            return
        end
        
    else
        TriggerEvent("iconic-login:finishedClothing","Old")
        TriggerServerEvent("police:getAnimData")
        TriggerServerEvent("police:SetMeta")
        LoadPed(oldPed)
    end

    if close then
        EnableGUI(false, false)
    end

    TriggerEvent("inmenu", false)
    TriggerEvent("ressurection:relationships:norevive")
    TriggerEvent("gangs:setDefaultRelations")
    TriggerEvent("facewear:update")
    TriggerEvent('iconic-weapons:getAmmo')
    CustomCamera('torso',true)
    startingMenu = false
end

local showBarberShopBlips = false
local showTattooShopBlips = false

RegisterNetEvent('hairDresser:ToggleHair')
AddEventHandler('hairDresser:ToggleHair', function()
   showBarberShopBlips = not showBarberShopBlips
   for _, item in pairs(barberShops) do
        if not showBarberShopBlips then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[2])
            SetBlipScale(item.blip, 0.7)
            SetBlipSprite(item.blip, 71)
            SetBlipColour(item.blip, 10)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Barber Shop")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

function addBlips()
    showBarberShopBlips = true
    TriggerEvent('hairDresser:ToggleHair')
end

local ShowTatShops = true

RegisterNetEvent('tattoo:ToggleTattoo')
AddEventHandler('tattoo:ToggleTattoo', function()
    ShowTatShops = not ShowTatShops
   for _, item in pairs(tattoosShops) do
        if not ShowTatShops then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[2])
            SetBlipScale(item.blip, 0.7)
            SetBlipSprite(item.blip, 75)
            SetBlipColour(item.blip, 10)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Tattoo Shop")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)


function addBlips()
    TriggerEvent('hairDresser:ToggleHair')
    TriggerEvent('tattoo:ToggleTattoo')
end

AddEventHandler("iconic-fw:initialSpawnModelLoaded", function()
    TriggerServerEvent("clothing:checkIfNew")
end)

RegisterNetEvent("iconic-clothingmenu:inService")
AddEventHandler("iconic-clothingmenu:inService", function(service)
    isService = service
end)

RegisterNetEvent("iconic-clothingmenu:hasEnough")
AddEventHandler("iconic-clothingmenu:hasEnough", function(menu)
    if menu == "tattoo_shop" then
        TriggerServerEvent("iconic-clothingmenu:retrieve_tats")
        while currentTats == nil do
            Citizen.Wait(1)
        end
    end

    OpenMenu(menu)
end)

RegisterNetEvent("iconic-clothingmenu:setclothes")
AddEventHandler("iconic-clothingmenu:setclothes", function(data,alreadyExist)
    player = PlayerPedId()
    local function setDefault()
        --- decapritated function
    end

	if not data.model and alreadyExist <= 0 then setDefault() return end
    if not data.model and alreadyExist >= 1 then return end
    model = data.model
    model = model ~= nil and tonumber(model) or false

	if not IsModelInCdimage(model) or not IsModelValid(model) then setDefault() return end
    SetSkin(model, false)
    Citizen.Wait(500)
    SetClothing(data.drawables, data.props, data.drawtextures, data.proptextures)
    Citizen.Wait(500)
	TriggerEvent("facewear:update")
    TriggerServerEvent("iconic-clothingmenu:get_character_face", nil, data.fadeStyle)
    TriggerServerEvent("iconic-clothingmenu:retrieve_tats")
    TriggerServerEvent("police:getAnimData")
    TriggerServerEvent("police:SetMeta")

end)

RegisterNetEvent("iconic-clothingmenu:AdminSetModel")
AddEventHandler("iconic-clothingmenu:AdminSetModel", function(model)
    local hashedModel = GetHashKey(model)
    if not IsModelInCdimage(hashedModel) or not IsModelValid(hashedModel) then return end
    SetSkin(hashedModel, true)
end)

RegisterNetEvent("iconic-clothingmenu:defaultReset")
AddEventHandler("iconic-clothingmenu:defaultReset", function()
    DoScreenFadeOut(10)
    --local LocalPlayer = exports["iconic-fw"]:getModule("LocalPlayer")
    local gender = 0
    if gender ~= 0 then
        SetSkin(`mp_f_freemode_01`, true)
    else
        SetSkin(`mp_m_freemode_01`, true)
    end
    DoScreenFadeIn(2500)
    SetEntityCoords(PlayerPedId(), -474.53564453125, -670.66833496094, 11.809024810791)
    SetEntityHeading(PlayerPedId(), 359.04397583008)

    TriggerEvent("raid_clothes:openClothing")
    TriggerEvent("iconic-clothingmenu:inSpawn", true)
end)

RegisterNetEvent("iconic-clothingmenu:settattoos")
AddEventHandler("iconic-clothingmenu:settattoos", function(playerTattoosList)
    currentTats = playerTattoosList

    setTattoosAndFacial(nil, currentFadeStyle)
end)

RegisterNetEvent("iconic-clothingmenu:setpedfeatures")
AddEventHandler("iconic-clothingmenu:setpedfeatures", function(data)
    player = PlayerPedId()
    if data == false then
        SetSkin(GetEntityModel(PlayerPedId()), true)
        return
    end
    local head = data.headBlend
    local haircolor = data.hairColor

    SetPedHeadBlendData(player,
        tonumber(head['shapeFirst']),
        tonumber(head['shapeSecond']),
        tonumber(head['shapeThird']),
        tonumber(head['skinFirst']),
        tonumber(head['skinSecond']),
        tonumber(head['skinThird']),
        tonumber(head['shapeMix']),
        tonumber(head['skinMix']),
        tonumber(head['thirdMix']),
        true)
    SetHeadStructure(data.headStructure)
    SetPedHairColor(player, tonumber(haircolor[1]), tonumber(haircolor[2]))
    SetHeadOverlayData(data.headOverlay)
    currentFadeStyle = data.fadeStyle
    --print(tonumber(currentFadeStyle))
    setTattoosAndFacial(nil, currentFadeStyle)
end)

function GetFadeTotal()
    local data = getFacialDecorationsData()
    return #data
end

function isFreemodeModel(pModelHash)
    return pModelHash == `mp_f_freemode_01` or pModelHash == `mp_m_freemode_01`
  end

  
function getFacialDecorationsData()
    local playerPed = PlayerPedId()
    local playerModel = GetEntityModel(playerPed)
    if isFreemodeModel(playerModel) then
      return FADE_CONFIGURATIONS[playerModel == `mp_m_freemode_01` and "male" or "female"]
    else
      return {}
    end
  end


  function setTattoosAndFacial(pTattoos, pFadeStyle)
    currentTats = {}
    local fadeStyle = tonumber(pFadeStyle) or 255
    local playerPed = PlayerPedId()
    local playerModel = GetEntityModel(playerPed)

    ClearPedFacialDecorations(playerPed)

    if fadeStyle and fadeStyle > 0 and fadeStyle ~= 255 and isFreemodeModel(playerModel) then
        local facialDecoration = FADE_CONFIGURATIONS[playerModel == `mp_m_freemode_01` and "male" or "female"][fadeStyle]
        if facialDecoration then
            Wait(1)
            SetPedFacialDecoration(playerPed, facialDecoration[1], facialDecoration[2])
        end
    end

    if pTattoos then
        currentTats = {}

        for k, v in pairs(pTattoos) do
            for category in pairs(tattooHashList) do
                if k == category then
                    local tattoo = tattooHashList[category][tonumber(v)]
                    if tattoo ~= nil then
                        currentTats[#currentTats + 1] = {tattoo[2], tattoo[1]}
                    end
                end
            end
        end
    end

    for i = 1, #currentTats do
        ApplyPedOverlay(playerPed, currentTats[i][1], currentTats[i][2])
    end
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function SetCustomNuiFocus(hasKeyboard, hasMouse)
  HasNuiFocus = hasKeyboard or hasMouse
  SetNuiFocus(hasKeyboard, hasMouse)
end


Citizen.CreateThread(function()
    addBlips()
    SetCustomNuiFocus(false, false)


    while true do
        Wait(0)
        if enabled then
            if (IsControlJustReleased(1, 25)) then
                SetCustomNuiFocus(true, true)
                FreezePedCameraRotation(player, true)
            end
            if (IsControlJustReleased(1, 202)) then
                SetCustomNuiFocus(true, true)
                FreezePedCameraRotation(player, true)
            end
            InvalidateIdleCam()
        end
    end
end)

local function listenForKeypress(zoneName, zoneData, isFree)
    listening = true
    doonce = true
    Citizen.CreateThread(function()
        while listening do
            if IsControlJustReleased(0, 46) then
                if zoneName == "tattoo_shop" and doonce then
                    doonce = false
                    TriggerServerEvent("iconic-clothingmenu:retrieve_tats")
                    --TriggerEvent('iconic-clothingmenu:settattoos')
                    while not currentTats do
                        Wait(10)
                    end
                end

                OpenMenu(zoneName, 0, 0)

                exports['textUi']:Close()
            end
            Wait(0)
        end
    end)
    doonce = true
end

RegisterNetEvent('raid_clothes:openClothing')
AddEventHandler('raid_clothes:openClothing', function(pDontShowBarber, pShouldCost, pStartingMenu)
    if pShouldCost ~= nil and pShouldCost then
        local priceWithTax = 500
        OpenMenu("clothing_shop", priceWithTax, currentPrice)
        startingMenu = pStartingMenu
    else
        currentPrice = 0
        currentPriceWithoutTax = 0
        OpenMenu("clothing_shop", '', 0)
        startingMenu = pStartingMenu
    end
    passedClothing = pDontShowBarber or false
end)

AddEventHandler("polyzonehelper:enter", function(zone, data)
    local currentZone = MenuData[zone]
    if currentZone then
--        TriggerEvent('iconic-textui:ShowUI', 'show', ("[M] %s"):format(currentZone.text))
        exports['textUi']:Show("Clothing", "Press [E] To access shop | Do /outfits , /outfitadd 1-20")
        TriggerEvent("iconic-clothingmenu:enable", true)
        listenForKeypress(zone, currentZone, ((data and data.isFree) and true or false))
    end
end)

AddEventHandler("polyzonehelper:exit", function(zone)
    local currentZone = MenuData[zone]
    if currentZone then
        listening = false
        --TriggerEvent('iconic-textui:HideUI')
        exports['textUi']:Close()
        TriggerEvent("iconic-clothingmenu:enable", false)
    end
end)

RegisterNetEvent('iconic-clothingmenu:outfits')
AddEventHandler('iconic-clothingmenu:outfits', function(pAction, pId, pName)
    if pAction == 1 then
        TriggerServerEvent("iconic-clothingmenu:set_outfit",pId, pName, GetCurrentPed())
    elseif pAction == 2 then
        TriggerServerEvent("iconic-clothingmenu:remove_outfit",pId)
    elseif pAction == 3 then 
        TriggerEvent('item:deleteClothesDna')
        TriggerEvent('InteractSound_CL:PlayOnOne','Clothes1', 0.6)
        TriggerServerEvent("iconic-clothingmenu:get_outfit", pId)
    else
        TriggerEvent("hud:saveCurrentMeta")
        TriggerServerEvent("iconic-clothingmenu:list_outfits")
    end
end)

--[[
RegisterCommand("testface", function(source, args, rawCommand)
    TriggerServerEvent("iconic-clothingmenu:get_character_face", 1)
end, false)
]]--

RegisterCommand("g1", function(source, args, rawCommand)
    TriggerEvent("facewear:adjust",2,false)
end, false)

RegisterCommand("g0", function(source, args, rawCommand)
    TriggerEvent("facewear:adjust",2,true)
end, false)

RegisterCommand("m1", function(source, args, rawCommand)
    --if exports["iconic-inventory"]:hasEnoughOfItem("mask",1) then
        TriggerEvent("facewear:adjust",4,false)   
    --else 
    exports['lrp-notify']:Alert("Clothing", "You're not wearing a mask", 5000, 'info')
    --end 
end, false)

RegisterCommand("m0", function(source, args, rawCommand)
    TriggerEvent("facewear:adjust",4,true)
end, false)

RegisterCommand("vest", function(source, args, rawCommand)
    if GetPedDrawableVariation(PlayerPedId(), 9) ~= 0 then
        TriggerEvent("facewear:adjust",7,true)
    elseif GetPedDrawableVariation(PlayerPedId(), 9) == 0 or GetPedDrawableVariation(PlayerPedId(), 9) == -1 then
        TriggerEvent("facewear:adjust",7,false)
    end
end, false)

RegisterCommand("h1", function(source, args, rawCommand)
    TriggerEvent("facewear:adjust",6,false)
end, false)

RegisterCommand("h0", function(source, args, rawCommand)
    TriggerEvent("facewear:adjust",6,true)
end, false)


RegisterNetEvent('iconic-clothingmenu:enable')
AddEventHandler('iconic-clothingmenu:enable', function(status)
    actionDress = status
end)

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

RegisterCommand("outfitadd", function(source, args, rawCommand)
    local slot = args[1]

    table.remove(args, 1)

    local arguments = table.concat(args, ' ')
    
    if actionDress then
        if slot and arguments then
            TriggerEvent('iconic-clothingmenu:outfits', 1, slot, arguments)
        else
            --TriggerEvent('DoLongHudText', "You need to do something like /outfitadd 1 party | 1 being the slot id, party is the name of your outfit", 1)
            exports['lrp-notify']:Alert("Clothing", "You need to do something like /outfitadd 1 party | 1 being the slot id, party is the name of your outfit", 5000, 'info')
        end
    else
        --TriggerEvent('DoLongHudText', "You are not near a wardrobe", 2)
        exports['lrp-notify']:Alert("Clothing", "You are not near a wardrobe", 5000, 'info')
    end

end, false)

-- Note, the command has to start with `/`.
TriggerEvent('chat:addSuggestion', '/outfitadd', 'Create New Outfit', {
    { name="slot", help="Enter a number" },
    { name="name", help="Enter a name for your outfit" }
})

RegisterCommand("outfits", function(source, args, rawCommand)
    if actionDress == true then
        TriggerEvent('iconic-clothingmenu:outfits', 4)
    else
        --TriggerEvent('DoLongHudText', "You are not near a wardrobe", 2)
        exports['lrp-notify']:Alert("Clothing", "You are not near a wardrobe", 5000, 'info')
    end
end, false)  

RegisterNetEvent("iconic-clothingmenu:list:outfits")
AddEventHandler("iconic-clothingmenu:list:outfits", function(data)
    TriggerServerEvent("iconic-clothingmenu:options:oufits", data.slot)
end)


RegisterNetEvent("iconic-clothingmenu:use:outfit")
AddEventHandler("iconic-clothingmenu:use:outfit", function(data)
    TriggerServerEvent("iconic-clothingmenu:get_outfit", data.slot)
end)

RegisterNetEvent("iconic-clothingmenu:remove:outfit")
AddEventHandler("iconic-clothingmenu:remove:outfit", function(data)
    TriggerServerEvent("iconic-clothingmenu:remove_outfit", data.slot)
end)


RegisterNetEvent("iconic-clothingmenu:return", function()
    TriggerEvent("hud:saveCurrentMeta")
    TriggerServerEvent("iconic-clothingmenu:list_outfits")
end)

RegisterNetEvent("iconic-clothingmenu:attempt:change", function(data)
    local pNewName = exports['lrp-input']:ShowInput({
        header = "New Outfit Name",
        submitText = "Submit",
        inputs = {
            {
                text = "What do you want to rename it to?", -- text you want to be displayed as a place holder
                name = "clothingoutfitrename", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
			}
		}})
    if pNewName then
        TriggerServerEvent('iconic-clothingmenu:attempt:change',  data.slot, pNewName.clothingoutfitrename)
    else
        exports['lrp-notify']:Alert("Clothing", "Name cannot be blank!", 5000, 'error')
    end
end)

--[[
local Clothing = {
    {-162.658, -303.397, 39.733},
    {75.950, -1392.891, 29.376},
    {-822.194, -1074.134, 11.328},
    {-1450.711, -236.83, 49.809},
    {4.254, 6512.813, 31.877},
    {615.180, 2762.933, 44.088},
    {1196.785, 2709.558, 38.222},
    {-3171.453, 1043.857, 20.863},
    {-1100.959, 2710.211, 19.107},
    {-1192.9453125, -772.62481689453, 17.3254737854},
    {-707.33416748047, -155.07914733887, 37.415187835693},
    {1683.45667, 4823.17725, 42.1631294},
    {-712.215881, -155.352982, 37.4151268},
    {121.76, -224.6, 54.56},
    {-1207.5267333984, -1456.9530029297, 4.3763856887817},
    {1949.61, 3766.26, 32.6}
}
]]--

local Clothing = {
    {425.236,-806.008,29.491},
    {-162.658,-303.397,39.733},
    {75.950,-1392.891,29.376},
    {-822.194,-1074.134,11.328},
    {-1450.711,-236.83,49.809},
    {4.254,6512.813,31.877},
    {615.180,2762.933,44.088},
    {1196.785,2709.558,38.222},
    {-3171.453,1043.857,20.863},
    {-1100.959,2710.211,19.107},
    {-1192.9453125,-772.62481689453,17.3254737854},
    {-707.33416748047,-155.07914733887,37.415187835693},
    {1683.45667,4823.17725,42.1631294},
    {121.76,-224.6,54.56},
    {1950.24,3766.1,32.6},
}

local showClothes = true

RegisterNetEvent('clothing:blips')
AddEventHandler('clothing:blips', function()
    showClothes = not showClothes
   for _, item in pairs(Clothing) do
        if not showClothes then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[3])
            SetBlipSprite(item.blip, 73)
            SetBlipScale(item.blip, 0.6)
			SetBlipColour(item.blip, 3)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Clothing Store")
            EndTextCommandSetBlipName(item.blip)
        end
    end
    for _, item in pairs(Clothing) do
        if not showClothes then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[3])
            SetBlipSprite(item.blip, 73)
            SetBlipScale(item.blip, 0.6)
			SetBlipColour(item.blip, 3)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Clothing Store")
            EndTextCommandSetBlipName(item.blip)
        end
    end
    for _, item in pairs(Clothing) do
        if not showClothes then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[3])
            SetBlipSprite(item.blip, 73)
            SetBlipScale(item.blip, 0.6)
			SetBlipColour(item.blip, 3)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Clothing Store")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

Citizen.CreateThread(function()
    showClothes = false
    TriggerEvent('clothing:blips')
end)


local facialWear = {
	[1] = { ["Prop"] = -1, ["Texture"] = -1 },
	[2] = { ["Prop"] = -1, ["Texture"] = -1 },
	[3] = { ["Prop"] = -1, ["Texture"] = -1 },
	[4] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- this is actually a pedtexture variations, not a prop
	[5] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- this is actually a pedtexture variations, not a prop
	[6] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- this is actually a pedtexture variations, not a prop
    [7] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- this is actually a pedtexture variations, not a prop
}

RegisterNetEvent("facewear:update")
AddEventHandler("facewear:update",function()
	for i = 0, 3 do
		if GetPedPropIndex(PlayerPedId(), i) ~= -1 then
			facialWear[i+1]["Prop"] = GetPedPropIndex(PlayerPedId(), i)
		end
		if GetPedPropTextureIndex(PlayerPedId(), i) ~= -1 then
			facialWear[i+1]["Texture"] = GetPedPropTextureIndex(PlayerPedId(), i)
		end
	end

	if GetPedDrawableVariation(PlayerPedId(), 1) ~= -1 then
		facialWear[4]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 1)
		facialWear[4]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 1)
		facialWear[4]["Texture"] = GetPedTextureVariation(PlayerPedId(), 1)
	end

	if GetPedDrawableVariation(PlayerPedId(), 11) ~= -1 then
		facialWear[5]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 11)
		facialWear[5]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 11)
		facialWear[5]["Texture"] = GetPedTextureVariation(PlayerPedId(), 11)
	end
end)


RegisterNetEvent("facewear:adjust")
AddEventHandler("facewear:adjust",function(faceType,remove)
	local handcuffed = false
	if handcuffed then return end
	local AnimSet = "none"
	local AnimationOn = "none"
	local AnimationOff = "none"
	local PropIndex = 0

	local AnimSet = "mp_masks@on_foot"
	local AnimationOn = "put_on_mask"
	local AnimationOff = "put_on_mask"


	for i = 0, 3 do
		if GetPedPropIndex(PlayerPedId(), i) ~= -1 then
			facialWear[i+1]["Prop"] = GetPedPropIndex(PlayerPedId(), i)
		end
		if GetPedPropTextureIndex(PlayerPedId(), i) ~= -1 then
			facialWear[i+1]["Texture"] = GetPedPropTextureIndex(PlayerPedId(), i)
		end
	end

	if GetPedDrawableVariation(PlayerPedId(), 1) ~= -1 then
		facialWear[4]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 1)
		facialWear[4]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 1)
		facialWear[4]["Texture"] = GetPedTextureVariation(PlayerPedId(), 1)
	end

	if GetPedDrawableVariation(PlayerPedId(), 11) ~= -1 then
		facialWear[5]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 11)
		facialWear[5]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 11)
		facialWear[5]["Texture"] = GetPedTextureVariation(PlayerPedId(), 11)
	end



	if faceType == 1 then
		PropIndex = 0
	elseif faceType == 2 then
		PropIndex = 1

		AnimSet = "clothingspecs"
		AnimationOn = "take_off"
		AnimationOff = "take_off"

	elseif faceType == 3 then
		PropIndex = 2
	elseif faceType == 4 then
		PropIndex = 1
		if remove then
			AnimSet = "missfbi4"
			AnimationOn = "takeoff_mask"
			AnimationOff = "takeoff_mask"
		end
	elseif faceType == 5 then
		PropIndex = 11
		AnimSet = "oddjobs@basejump@ig_15"
		AnimationOn = "puton_parachute"
		AnimationOff = "puton_parachute"	
		--mp_safehouseshower@male@ male_shower_idle_d_towel
		--mp_character_creation@customise@male_a drop_clothes_a
		--oddjobs@basejump@ig_15 puton_parachute_bag
	elseif faceType == 7 then
		PropIndex = 9
		AnimSet = "clothingshirt"
		AnimationOn = "try_shirt_positive_d"
		AnimationOff = "try_shirt_positive_d"	

	end

	loadAnimDict( AnimSet )
	if faceType == 5 then
		if remove then
			SetPedComponentVariation(PlayerPedId(), 3, 2, facialWear[6]["Texture"], facialWear[6]["Palette"])
		end
	end
	if remove then
		TaskPlayAnim( PlayerPedId(), AnimSet, AnimationOff, 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
		Citizen.Wait(500)
		if faceType ~= 5 then
			if faceType == 4 then
				SetPedComponentVariation(PlayerPedId(), PropIndex, -1, -1, -1)
			else
				if faceType ~= 2 then
					ClearPedProp(PlayerPedId(), tonumber(PropIndex))
				end
			end
		end
	else
		TaskPlayAnim( PlayerPedId(), AnimSet, AnimationOn, 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
		Citizen.Wait(500)
		if faceType ~= 5 and faceType ~= 2 and faceType ~= 7 then
			if faceType == 4 then
				SetPedComponentVariation(PlayerPedId(), PropIndex, facialWear[faceType]["Prop"], facialWear[faceType]["Texture"], facialWear[faceType]["Palette"])
			else
				SetPedPropIndex( PlayerPedId(), tonumber(PropIndex), tonumber(facialWear[PropIndex+1]["Prop"]), tonumber(facialWear[PropIndex+1]["Texture"]), false)
			end
		end
	end
	if faceType == 5 then
		if not remove then
			SetPedComponentVariation(PlayerPedId(), 3, 1, facialWear[6]["Texture"], facialWear[6]["Palette"])
			SetPedComponentVariation(PlayerPedId(), PropIndex, facialWear[faceType]["Prop"], facialWear[faceType]["Texture"], facialWear[faceType]["Palette"])
		else
			SetPedComponentVariation(PlayerPedId(), PropIndex, -1, -1, -1)
		end
		Citizen.Wait(1800)
	end
	if faceType == 2 then
		Citizen.Wait(600)
		if remove then
			ClearPedProp(PlayerPedId(), tonumber(PropIndex))
		end

		if not remove then
			Citizen.Wait(140)
			SetPedPropIndex( PlayerPedId(), tonumber(PropIndex), tonumber(facialWear[PropIndex+1]["Prop"]), tonumber(facialWear[PropIndex+1]["Texture"]), false)
		end
	end
	if faceType == 4 and remove then
		Citizen.Wait(1200)
	end

	if faceType == 7 then
		Citizen.Wait(600)
		if remove then
			facialWear[7]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 9)
			facialWear[7]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 9)
			facialWear[7]["Texture"] = GetPedTextureVariation(PlayerPedId(), 9)
			SetPedComponentVariation(PlayerPedId(), tonumber(PropIndex), 0, 0, false)
		end

		if not remove then
			Citizen.Wait(140)
			-- SetPedPropIndex( PlayerPedId(), tonumber(PropIndex), tonumber(facialWear[PropIndex+1]["Prop"]), tonumber(facialWear[PropIndex+1]["Texture"]), false)
			SetPedComponentVariation(PlayerPedId(), tonumber(PropIndex), tonumber(facialWear[7]["Prop"]), tonumber(facialWear[7]["Texture"]), false)
			-- SetPedComponentVariation(PlayerPedId(), tonumber(PropIndex), 4, 0, false)
		end
	end
	ClearPedTasks(PlayerPedId())
end)


function loadAnim( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end



function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

