# Weed system explanation:

Read this carefully before opening a ticket.

**DUE TO STUPID INVENTORY SYSTEM, MOST ITEMS (`packedbuds` and `weedbaggie`) MUST BE SEPERATED INTO DIFFERENT SLOTS** like this: https://i.imgur.com/U2FnZoP.jpeg
(we will make a good inventory resource very soon)

**WEED NOT DRYING**
Again, qb-inventory is pretty weird, maybe make sure your wetbuds gets recognized by the inventory before signing out.
Putting your weed in stashes slowly might fix, makes sure weed is next to an item?
Watch this clip for explanation: https://youtu.be/Utnp-c58kYY
Hopefully we come up with a fix to this in the near future, if not, again, we are making another inventory system!

## **If you cant see the plant while planting, switch to closer POV, first person helps the most **

(From: https://cdn.discordapp.com/attachments/1049776776664059904/1049796378706063380/image.png)
(To: https://cdn.discordapp.com/attachments/1049776776664059904/1049796860539318322/image.png)


## Growing

- Use `femaleseed` to plant, add `maleseed` on top for seed yields, if not, **default** females will yield buds.
- `Fertilizer` process will be needed for "Unknown" seeds. Talk to the boss if you forget your strains recipes.
- Water your plants! If not, they die and disappear. If fully watered, plants yields more products.
- More later...


## Drying
- `wetbuds` can **ONLY** dry in stashes.
- `drybuds` needs to be packed into `packedbuds`.


## Packing
- Go to boss location with atleast 5 `packedbuds`
- Make sure you collect your package after. Other people can collect it as well.
- `weedpackage` could be either bagged to corner, or do a weed run.


## Cornering
- **CORNERING IMPROVES YOUR STRAIN REPUTATION**
- 1 rep per baggie sold
- _More rep = more money_


## Renaming strains
- Once your strain reached `Config.RepName = 40000`, you can start custom strain name.
- **This will NOT take effect immediately in your inventory, you need to grow the plants after to get the new strain name.**


## Weed runs
- _More rep = more money_
- This **DO NOT** improve strain rep.


### Server Side export

To add rep for Strain if u don't use our cornering. Need n,p,k,amont
exports('addExpStrain', addExpStrain)
Example: 
```lua
exports['rep-weed']:addExpStrain(1,1,1, 20)
```
To get rep from Strain. Need n,p,k
exports('getExpStrain', getExpStrain)
Example: 
```lua
local exp = exports['rep-weed']:getExpStrain(1,1,1)
```