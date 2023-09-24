# 919 ADMIN

Thank you for purchasing my custom made resource 919 ADMIN. 

**919 ADMIN** is an admin menu that I set out to create after being unsatisfied with the options that are available currently. While there are a lot of great free options such as EasyAdmin or VMenu, I found myself looking for an admin menu with a deeper integration with my framework, as well as a good graphical user interface. 919 ADMIN has been designed from the ground up to excel at those two main things.

**919 ADMIN** is _very_ closely integrated with the QBCore Framework and as such, offers a very deep level of interactivity with your RP server's players, as well as its database. Over a hundred different actions and changes can be made through the menu to yourself, your players, peds around you, objects, vehicles, and your server's database. I really tried to cover as much as possible with it.

Another crucial benefit of using **919 ADMIN** is its ease of use and simple learning curve. Your admins and moderators won't need to know how to mess with the database or enter complicated commands to **DO MORE**!


# Installation

Installation of 919ADMIN is simple, and involves drag-and-dropping the resource as well as some basic configuration.

## Extract Resource to Server Files
Extract the resource to the server files directory.


## Configuration

Edit the file _config.lua_ to your liking. Here is the default configuration:
```lua
Config.EnableDebug                          = true         -- Whether to enable debug prints or not

Config.DefaultDarkMode                      = 1            -- Whether dark mode should be enabled by default. 1 is on by default, 0 is off

Config.ServerName                           = "QBCore Server"
Config.ServerDiscord                        = "discord.gg/ChangeMe" -- For kick/ban messages
Config.ScreenshotWebhook                    = "https://discord.gg/webhookchangeme"

Config.AdminPanelKey                        = "PAGEDOWN"

Config.DB.VehiclesTable                     = "player_vehicles"
Config.DB.CharactersTable                   = "players"
Config.DB.StaffTable                        = "permissions"
Config.DB.BansTable                         = "bans"

Config.AnnounceBan                          = true

```

## Set up SQL Table
Open your database, and execute the following SQL code:
```mysql
--
-- Table structure for table `warns`
--

CREATE TABLE `warns` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `license` varchar(50) NOT NULL,
  `reason` text NOT NULL,
  `warnedby` varchar(50) NOT NULL,
  `warnedtime` bigint(20) NOT NULL DEFAULT unix_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `warns`
--
ALTER TABLE `warns`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `warns`
--
ALTER TABLE `warns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;
```

## Set up 919 Admin with QBCore logging system
All actions in this menu are logged using the QBCore logging system. Simply navigate to qb-smallresources/server/logs.lua and add the following webhook types to the "Webhooks" table:
```lua
['adminactions'] = 'webhook_url_here',
['warns'] = 'webhook_url_here',
```

## Add Resource to server.cfg or resources.cfg
If your server has a _resources.cfg_ or _server.cfg_ in the main directory, add the following line to the end:
``ensure qb-admin``

# Done!
You are done! Don't forget to join our Discord for support at https://discord.gg/Xv7faqUXUf