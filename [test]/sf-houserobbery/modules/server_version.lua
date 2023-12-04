PerformHttpRequest('https://raw.githubusercontent.com/scriptforge-gg/sf-versions/main/versions.json', function(errorCode, resultData, resultHeaders)
    if not resultData then print('Failed to check for updates') return end
    local result = json.decode(resultData)
    if GetResourceMetadata(GetCurrentResourceName(), 'version', 0) ~= result[GetCurrentResourceName()] then
        print('New version of '..GetCurrentResourceName()..' is available!')
    end
end)