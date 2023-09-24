# 919 MAILJOB

Thank you for purchasing my custom made resource 919 MAILJOB. 

**919 MAILJOB** is a simple QBCore based mail carrier job built with qb-target that offers a progression system. Multiple mail routes are available, and each are able to be locked to specific carrier levels. Each player's carrier level is determined by how many packages they have delivered. As each player's carrier level increases, so do their multipliers for how much money is earned.


# Installation

Installation of 919 MAILJOB is simple, is essentially drag-and-drop.

Add the following lines to the file qb-core/shared/jobs.lua:
```lua
    ['mailcarrier'] = {
		label = 'Mail Carrier',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Worker',
                payment = 50
            },
        },
	},
```

Add the following line to the file qb-cityhall/server/main.lua inside the AvailableJobs table to make the job available:
```lua
"mailcarrier"```

It should now look similar to this:

```lua
local AvailableJobs = {
    "trucker",
    "taxi",
    "tow",
    "reporter",
    "garbage",
    "bus",
    "mailcarrier"
}```

Also add the following line to qb-cityhall/html/index.html after line 43:
```html
<div class="job-page-block" data-job="mailcarrier"><p>Mail Carrier</p></div>
```

## Extract Resource to Server Files
Extract the resource to the server resources directory.


## Add Resource to server.cfg or resources.cfg
If your server has a _resources.cfg_ or _server.cfg_ in the main directory, add the following line to the end:
``ensure qb-mailjob``

# Done!
You are done! Don't forget to join our Discord for support at https://discord.gg/Xv7faqUXUf