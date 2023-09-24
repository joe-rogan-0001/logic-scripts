----INSTALLATION DETAILS

- execute the phone.sql
- add ld-phone and camera to your server.cfg
------------------------

----Config
For saltychat:
 -You just need write "saltychat" to ScriptName variable.
For pma-voice:
 -Don't change anything, scripts defaults are compatible with pma-voice.
For mumblevoip & tokovoip:
 -Change the ScriptName variable to your voicechat script name.
 -Change AddPlayer, RemovePlayer functions with your own voicechat scripts functions.
----------



----EXPORTS

exports["ld-phone"]:Notify(title, message, sender)
exports["ld-phone"]:Call(number)
exports['ld-phone']:SendMailToEveryone(subject, sender, message)
exports['ld-phone']:SendMailToPlayer(playerId, subject, sender, message)
local InCall = exports["ld-phone"]:IsInCall()
local IsPhoneOpened = exports["ld-phone"]:IsOpen()
local PhoneNumber = exports["ld-phone"]:GetPhoneNumber()
-----------