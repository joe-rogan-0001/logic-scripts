
function addPedZone(entity,allowed,drug) -- We are close to the NPC, let's create the interaction zone (can be target or textUI)
    if Config.TargetSystem then
        exports[Config.TargetSystem]:AddTargetEntity(entity, {
            options = {
                {
                    type = "client",
                    event = "av_runs:npcMenu",
                    icon = "fas fa-comment",
                    label = Lang['talk_npc'],
                    canInteract = allowed,
                    drug = drug
                },
            },
            distance = 2.5
        })
    end
end

function removePedZone(entity)
    if Config.TargetSystem then
        exports[Config.TargetSystem]:RemoveTargetEntity(entity, Lang['talk_npc'])
    end
end

RegisterNetEvent('av_runs:npcMenu', function(data)
    local drug = data['drug']
    if drug then
        openMenu(drug)
    else
        print("^2[ERROR] Something went wrong in client/framework/interaction.lua(?)^7")
    end
end)