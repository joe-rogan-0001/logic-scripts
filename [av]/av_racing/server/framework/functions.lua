-- Receive the racer source, identifier, position and the race ID
-- With raceId you can access allEvents[raceId] and retrieve all the info from the current race
-- This is just an EXAMPLE, do whatever you want here
local positions = {
    [1] = {prize = 100, accountName = "your_crypto_name"},
    [2] = {prize = 50, accountName = "your_crypto_name"},
    [3] = {prize = 20, accountName = "your_crypto_name"},
}
function FinishedRace(src,identifier,position,raceId)
    if positions[tonumber(position)] and allEvents[raceId]['numRacers'] >= 6 then
--        exports['av_laptop']:addMoney(tonumber(src), positions[tonumber(position)]['accountName'], positions[tonumber(position)]['prize'])
    end
end