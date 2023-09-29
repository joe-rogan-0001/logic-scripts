--<!>-- BLIPS CODE START --<!>-- **COMMENT OUT THIS CODE OR MOVE THE FILE IN ORDER TO DISABLE BLIPS OR COMMENT OUT COORDS IN CONFIG**
Citizen.CreateThread(function()
	for _, info in pairs(Config.Blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.6)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)
--<!>-- BLIPS CODE END --<!>-- **COMMENT OUT THIS CODE OR MOVE THE FILE IN ORDER TO DISABLE BLIPS OR COMMENT OUT COORDS IN CONFIG**