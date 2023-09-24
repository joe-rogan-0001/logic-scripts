Steps to install:
1-Execute the sql scripts market.sql and territories.sql
2-You can configure the territories that you want in the database and the same name should be used in the config file
3-You can configure the drugs market. You can add or remove the drugs item from the database and from the config
4-By default the script will create 5 territories and 5 type of drugs that can be selled in the territories
5-If you need add some custom beahviour after selling drugs with success you can register the following event (the name can be changed in the config file)

RegisterServerEvent('qp-territories:server:successDrugs')
AddEventHandler('qp-territories:server:successDrugs', function(src, typeOfMoney, amountDrugs, priceDrugs, territoryName)
	print(src, typeOfMoney, amountDrugs, priceDrugs, territoryName)
end)

Dependencies:
-qb-core
-qb-target
-polyzone
-qb-bossmenu, if you want give money to gangs if some player sell drugs in your territory


exported functions SERVER SIDE:
-exports['qp-territories']:IsTerritoryDominated(src,territoryName)
-exports['qp-territories']:addDrugQuantity(quantity, idDrugInTheMarket)
-exports['qp-territories']:showDrugsList(source)
-exports['qp-territories']:getDrugPrice(idDrugInTheMarket)


exported functions CLIENT SIDE:
-exports['qp-territories']:IsTerritoryDominated(territoryName)
-exports['qp-territories']:IsInsideTerritory(PlayerPedId())
-exports['qp-territories']:IsTerritoryDominationMoreThanZero(territoryName)
-exports['qp-territories']:showDrugsList()