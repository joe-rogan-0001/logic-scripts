SimpleBanking = SimpleBanking or {} 
SimpleBanking.Config = SimpleBanking.Config or {}


SimpleBanking.Config["Days_Transaction_History"] = 5 -- How many days should the transaction history go back in the bank?

SimpleBanking.Config["business_ranks"] = { -- what ranks can see the society accounts in the menu, and deposit/withdraw/transfer from them?
    ['chief'] = true,
    ['boss'] = true,
    ['ceo'] = true,
    --['menađer'] = true,
    --['vlasnik'] = true,
    --['načelnik'] = true,
    --['ravnatelj'] = true,
}

SimpleBanking.Config["business_ranks_overrides"] = {
    ['police'] = {
        ['chief'] = true,
    },
    ['casino'] = {
        ['ceo'] = true,
    },
    ['burgershot'] = {
        --['zamjenik vlasnika'] = true,
    },
    ['vlada'] = {
        --['predsjednik vlade'] = true,
    },
    ['ambulance'] = {
        ['chief'] = true,
    },
    ['realestate'] = {
        ['boss'] = true,
    },
    ['cardealer'] = {
        --['zamjenik menađera'] = true,
    },
    ['mechanic'] = {
        --['zamjenik vlasnika'] = true,
    },
}

SimpleBanking.Config["gang_ranks"] = {
    ['boss'] = true,
    ['founder'] = true,
    ['ceo'] = true,
}

SimpleBanking.Config["gang_ranks_overrides"] = {

}
