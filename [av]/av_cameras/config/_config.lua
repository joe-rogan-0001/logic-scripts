Config = {}
Config.Debug = false 
Config.Framework = "QBCore" -- QBCore or ESX (for latest ESX go to fxmanifest.lua and uncomment the import)
Config.VehicleThumbnail = "https://i.imgur.com/QsUBHkb.jpg" -- Used as thumbnail for vehicles in Camera App
Config.AdminLevel = "admin"
Config.TestCommand = "camera:debug" -- Used to get coords for _cameras.lua, only accessible by players with Config.AdminLevel permission
Config.CameraJammerItem = "cam_jammer" -- Used to remove cameras from vehicle and to hack public cameras (_cameras.lua)
Config.Cameras = {
    -- itemName: string, duration: number (battery hours), vehicle: boolean (can be installed in vehicles?)
    -- You can add multiple camera items, make sure to register them in your inventory.
    {itemName = "gopro", expires = 48, vehicle = true},
}