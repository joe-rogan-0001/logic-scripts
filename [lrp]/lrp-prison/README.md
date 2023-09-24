# qb-prison
Updated Prison Script for QB-Policejob modified

(v1.0.0) qb-prison - Added Multiple prison jobs w/ animation tasks to lower sentencing time, qb targeting system of canteen, slushy, time check.

# Just Added
- qb-targeting for time checks, shop canteen
- slushy system functions & targeting by Primal#4155 (you will need to add "slushy" as an item i dont have a provided image.
- Added 2 new job to the stock "electrician" job now there is "electrician", "cook", and "janitor" that once sentenced inmate will have randomly chosen for him.

-----------------------------------------------------------------------------------------------------------------

## Please note

- I am trying to enhance this resource more and will build a prison lifer style "job system" that will require a new prison rep system for crafting new items, gaining pay increases, etc.

- If you have issues with the resource just put in an issue on my github.

- This Script was tested on the latest build as of 03/10/2021.

## Add to qb-target/init.lua

```Config.BoxZones = {
    ["prisonslushy"] = {
        name = "prisonslushy",
        coords = vector3(1777.66, 2560.07, 45.67),
        length = 0.6,
        width = 0.6,
        heading = 0,
        debugPoly = false,
		minZ = 45.67,
		maxZ = 46.67,
        options = {
			{
                type = "client",
                event = "qb-prison:client:slushy",
                icon = "fas fa-wine-bottle",
                label = "Make Slushy",
            },
        },
        distance = 1.5
    },
	["prisontime"] = {
        name = "prisontime",
        coords = vector3(1827.3, 2587.72, 46.01),
        length = 0.45,
        width = 0.55,
        heading = 0,
        debugPoly = false,
		minZ = 46.11,
		maxZ = 47.01,
        options = {
			{
                type = "client",
                event = "qb-prison:client:checkTime",
                icon = "fas fa-user-clock",
                label = "Check Jail Time",
            },
        },
        distance = 1.5
    },
	["prisoncanteen"] = {
        name = "prisoncanteen",
        coords = vector3(1783.12, 2559.56, 45.67),
        length = 0.4,
        width = 0.55,
        heading = 0,
        debugPoly = false,
		minZ = 45.62,
		maxZ = 46.07,
        options = {
			{
                type = "client",
                event = "qb-prison:client:useCanteen",
                icon = "fas fa-utensils",
                label = "Open Canteen",
            },
        },
        distance = 1.5
    },
}

-----------------------------------------------------------------------------------------------------------------

`Known Bugs`

The qb-menu job change system - DOES NOT Work currently its part of the lifer update (next release)

-----------------------------------------------------------------------------------------------------------------

## Plans to be added in future update - 
`prison lifer job`
`prison crafting and rep system`
`new items & recipes for crafting`

-----------------------------------------------------------------------------------------------------------------

## Dependancies

- qb-target
- qb-lock (for slushy & eventually all tasks will require (success) in order to get next blimp)

-----------------------------------------------------------------------------------------------------------------

# License

    QBCore Framework
    Copyright (C) 2021 Joshua Eger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>
