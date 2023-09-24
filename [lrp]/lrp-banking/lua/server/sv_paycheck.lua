RegisterNetEvent('qb-banking:server:sendPaycheck', function(pAmount, pSource)
    local src = pSource
    if not src then return end
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    if not citizenid then return end

    local tax = CalculateTax(pAmount, 'global')
    tax = math.ceil(tax)
    local total = math.ceil(pAmount - tax)

    local result = MySQL.Sync.fetchAll("SELECT paycheck FROM players WHERE citizenid = ?", {citizenid})
    local data = result[1]

    if data then
        print("paid"..citizenid.." "..total)
        --TriggerClientEvent("lrp-notify:Alert", src, "Banking", "Head to the Pacific Standard bank to get you payslip", 5000, 'info')
        local setter = MySQL.Sync.fetchAll("UPDATE players SET paycheck = paycheck + @amount WHERE citizenid = @citizenid",{ ['citizenid'] = citizenid, ['amount'] = total})

        local res = MySQL.Sync.fetchAll("SELECT paycheck FROM players WHERE citizenid = ?", {citizenid})
        local paychecktotal = res[1].paycheck

        TriggerClientEvent("lrp-notify:Alert", src, "Banking", "A payslip of $"..total.. " making a total of $" ..paychecktotal.." with $"..tax.." tax withheld on your last payment.", 5000, 'info')
    end

end)

RegisterNetEvent('qb-banking:server:Paycheck:pickup', function()
    local src = source
    if not src then return end
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    local cid = player.PlayerData.citizenid
    if not cid then return end

    local result = MySQL.Sync.fetchAll("SELECT paycheck FROM players WHERE citizenid = ?", {cid})
    local data = result[1].paycheck

    --print(data)

    if data ~= nil then
        local paycheck = tonumber(data)
        if (paycheck > 0) then
            player.Functions.AddMoney('bank', paycheck)
            local setter = MySQL.Sync.fetchAll("UPDATE players SET paycheck = ? WHERE citizenid = ?", {0, cid})
            AddTransaction(src, "personal", paycheck, "deposit", "N/A", (note ~= "" and note or "Payslip of $"..format_int(paycheck)))
            TriggerClientEvent("QBCore:Notify",src,"A payslip of $"..paycheck.." has been transferred to your bank account.", "primary")

            TriggerEvent('qb-log:server:CreateLog', 'pdbanking', 'Payslip Cash-in', 'green', "Name: ".. player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname .. "\nPayslip of $"..format_int(paycheck))
        else
            TriggerClientEvent('QBCore:Notify', src, 'Imagine trying to withdraw $0', 'error')
        end
    end
end)