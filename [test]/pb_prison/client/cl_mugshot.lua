local Scaleform = nil
local Handle = nil
local MugshotBoard = nil
local MugshotOverlay = nil
IsGoingToPhoto = false

CreateThread(function()
    Scaleform = LoadScaleform("mugshot_board_01")
    Handle = CreateNamedRenderTargetForModel("ID_Text", GetHashKey("prop_police_id_text"))
    while Handle do
        if IsGoingToPhoto then
            SetTextRenderId(Handle)
            Set_2dLayer(4)
            Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
            DrawScaleformMovie(Scaleform, 0.405, 0.37, 0.81, 0.74, 255, 255, 255, 255, 0)
            Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
            SetTextRenderId(GetDefaultScriptRendertargetRenderId())
            Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
            Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
            Wait(0)
        else
            Wait(1500)
        end
    end
end)

function AddMugshot(Name, Months, CitizenId, Date)
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    -- Set Information --
    PushScaleformMovieFunction(Scaleform, "SET_BOARD")
    PushScaleformMovieFunctionParameterString("SAN ANDREAS POLICE")
    PushScaleformMovieFunctionParameterString(Date) -- Datum
    PushScaleformMovieFunctionParameterString("Convicted of "..Months.." Month(s)")  -- Convicted
    PushScaleformMovieFunctionParameterString(Name) -- Character Name
    PushScaleformMovieFunctionParameterFloat(0.0)
    PushScaleformMovieFunctionParameterString(CitizenId) -- CitizenId
    PushScaleformMovieFunctionParameterFloat(0.0)
    PopScaleformMovieFunctionVoid()
    -- Add Prop --
    RequestModel(GetHashKey("prop_police_id_board"))
    RequestModel(GetHashKey("prop_police_id_text"))
    loadAnimDict("mp_character_creation@lineup@male_a")
    while not HasModelLoaded(GetHashKey("prop_police_id_board")) or not HasModelLoaded(GetHashKey("prop_police_id_text")) do
    Wait(1)
    end
    MugshotBoard = CreateObject(GetHashKey("prop_police_id_board"), PlayerCoords, false, true, false)
    MugshotOverlay = CreateObject(GetHashKey("prop_police_id_text"), PlayerCoords, false, true, false)
    AttachEntityToEntity(MugshotOverlay, MugshotBoard, -1, 4103, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(GetHashKey("prop_police_id_board"))
    SetModelAsNoLongerNeeded(GetHashKey("prop_police_id_text"))
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), 1)
    AttachEntityToEntity(MugshotBoard, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
    TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "loop_raised", 8.0, 8.0, -1, 49, 0, false, false, false)
end

function ResetMugshot()
    DeleteObject(MugshotOverlay)
    DeleteObject(MugshotBoard)
    ClearPedSecondaryTask(PlayerPedId())
    PushScaleformMovieFunction(Scaleform, "SET_BOARD")
    PushScaleformMovieFunctionParameterString("")
    PushScaleformMovieFunctionParameterString('')  -- Date
    PushScaleformMovieFunctionParameterString("") -- Convicted
    PushScaleformMovieFunctionParameterString('') -- Charact
    PushScaleformMovieFunctionParameterFloat(0.0)
    PushScaleformMovieFunctionParameterString('') -- CitizenId
    PushScaleformMovieFunctionParameterFloat(0.0)
    PopScaleformMovieFunctionVoid()
end

function CreateNamedRenderTargetForModel(name, model)
    local Handle = 0
    if not IsNamedRendertargetRegistered(name) then
        RegisterNamedRendertarget(name, 0)
    end
    if not IsNamedRendertargetLinked(model) then
        LinkNamedRendertarget(model)
    end
    if IsNamedRendertargetRegistered(name) then
        Handle = GetNamedRendertargetRenderId(name)
    end
    return Handle
    end

    function LoadScaleform(Scaleform)
    local Handle = RequestScaleformMovie(Scaleform)
    if Handle ~= 0 then
        while not HasScaleformMovieLoaded(Handle) do
            Wait(0)
        end
    end
    return Handle
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end