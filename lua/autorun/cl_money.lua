--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	Sandbox Simple Money System. Made by KRisU. Special thanks to fghdx, Rubat.
	Version: 2.0

]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

AddCSLuaFile() -- Mark file for client downloads

if (CLIENT) then

surface.CreateFont( "SMSBountyFont", {
	font = "Trebuchet", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 13,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false
} )

surface.CreateFont( "SMSMoneyFont", { 
	font = "Myriad Pro", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 36,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
} )

local function checkIfAdmin() -- A really good clientside function to check whether a player is an admin, covers all fields; feel free to copy and redistribute this and only this function.
	local ply = LocalPlayer()
	if ply:IsValid() then
		if ( ply:IsAdmin() || ply:IsSuperAdmin() || ply:IsUserGroup( "server owner" ) || ply:IsUserGroup( "serverowner" ) || ply:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher
			return true
		else
			return false
		end
	end
	return false
end


player_data = FindMetaTable("Player") -- Gets all the functions that affect player.


--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	CLIENTSIDED CONVARS
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

CreateConVar( "money_displayhud", 1, FCVAR_ARCHIVE )
CreateConVar( "money_notifications", 1, { FCVAR_ARCHIVE, FCVAR_USERINFO } )
CreateConVar( "money_weaponpickup", 1, { FCVAR_ARCHIVE, FCVAR_USERINFO } )
CreateConVar( "money_bounty_marker", 1, { FCVAR_ARCHIVE, FCVAR_USERINFO } )

--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	MAIN
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

	
	function drawMoneyBoxOnHUD() -- Make our HudPaint function to draw the money.
		
		local money = LocalPlayer():GetNWInt( "money" ) -- Get players money from the network int.
		
		if (GetConVar("money_displayhud"):GetInt() == 0) then
			return
		elseif (GetConVar("money_displayhud"):GetInt() == 1) then
			draw.WordBox(8, 10, 10, money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- Make a wordbox container.
		elseif (GetConVar("money_displayhud"):GetInt() == 2) then
			draw.WordBox(8, 10, 230, money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- Make a wordbox container.
		elseif (GetConVar("money_displayhud"):GetInt() == 3) then
			draw.WordBox(8, 10, (ScrH()/2), money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- Make a wordbox container.
		elseif (GetConVar("money_displayhud"):GetInt() == 4) then
			draw.WordBox(8, 10, (ScrH()/2)+(ScrH()/5), money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- Make a wordbox container.
		elseif (GetConVar("money_displayhud"):GetInt() == 5) then
			draw.WordBox(8, 230, 10, money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- Make a wordbox container.	
		elseif (GetConVar("money_displayhud"):GetInt() == 6) then
			draw.WordBox(8, (ScrW()/2)+(ScrW()/5), 230, money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- Make a wordbox container.
		elseif (GetConVar("money_displayhud"):GetInt() == 7) then
			draw.WordBox(8, (ScrW()/2)+(ScrW()/5), 10, money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- Make a wordbox container.
		else
			draw.WordBox(8, ((ScrW()/2)-(ScrW()/32)), 10, money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- Make a wordbox container.
		end
		
	end
	hook.Add("HUDPaint", "drawMoneyBoxOnHUD", drawMoneyBoxOnHUD) -- Hook up.
	
	
	hook.Add("HUDPaint", "SMSBountyMarker", function()
		
		if (GetConVar( "money_bounty_marker" ):GetBool() == false) then
			return
		end
		
		local bStatus = false
		local bTarget = nil
		
		for key, ply in pairs(player.GetAll()) do
			if (ply:GetNWBool( "isHunted" ) == true and ply:GetNWInt( "bountyPrice" ) > 1) then
				bStatus = true
				bTarget = ply
				break
			end
		end
		
		if (bStatus == false) then 
			return 
		elseif (bTarget == LocalPlayer() or bTarget == nil) then
			return
		end
		
		local targetPos = (bTarget:GetPos() + Vector(0,0,75))
		local targetDistance = 0
		
		if ((math.floor((LocalPlayer():GetPos():Distance(targetPos))/30.5)-1) < 2) then
			targetDistance = 1 
		else 
			targetDistance = (math.floor((LocalPlayer():GetPos():Distance(targetPos))/30.5)-1)
		end
		
		local targetScreenPos = targetPos:ToScreen()
		
		surface.SetTextColor(255,75,0)
		surface.SetFont("SMSBountyFont")
	    
		surface.SetTextPos( tonumber(targetScreenPos.x)-tonumber(ScrW()*0.022), tonumber(targetScreenPos.y)-tonumber(ScrH()*0.009)-13 )
		surface.DrawText("Bounty: +" .. bTarget:GetNWInt( "bountyPrice" ) .. "$")
		
		surface.SetTextColor(255,75,0)
		surface.SetFont("SMSBountyFont")
	    
		if (targetDistance % 73 >= tonumber(0+math.random(2,9)) && targetDistance % 73 <= tonumber(30+math.random(-2,9))) then
			surface.SetTextPos( tonumber(targetScreenPos.x)-tonumber(ScrW()*0.022), tonumber(targetScreenPos.y)-tonumber(ScrH()*0.009) )
			surface.DrawText("Distance: " .. targetDistance .. "u")
		end
	
	end)
	


--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	CONCOMMANDS
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	-- LISTPLAYERS (NON-ADMIN)
	function listplayers( client, command, arguments ) -- Add console command
		PrintTable( player.GetAll() )
	end
	concommand.Add("listplayers", listplayers , nil, "Command used to print-out connected players list.")
	
	-- CHECK ACCOUNT (NON-ADMIN)
	function money_check_CC( client, command, arguments ) -- Add console command
		client:PrintMessage( HUD_PRINTTALK , ">> Your account ballance is: " .. (tonumber(client:GetNWInt( "money" ))) .. "$.\n")
		if (GetConVar("money_roi"):GetBool() == true) then
			client:PrintMessage( HUD_PRINTTALK , ">> Your rate of interest is: " .. ((math.floor(client:GetNWFloat( "moneyROI" )*100))*0.01) .. "%.\n")
		end
		if (GetConVar("money_bounty_system"):GetBool() == true) then
			client:PrintMessage( HUD_PRINTTALK , ">> Your fame is: " .. (tonumber(client:GetNWFloat( "bountyFame" ))) .. ".\n")
		end
		if (GetConVar("money_freeze"):GetBool() == true) then
			client:PrintMessage( HUD_PRINTTALK , ">> Bank accounts are frozen.\n")
		end
		client:PrintMessage( HUD_PRINTTALK , ">> Your latest expenses are: " .. client:GetNWInt( "latestExpense3" ) .. "$, " .. client:GetNWInt( "latestExpense2" ) .. "$, " .. client:GetNWInt( "latestExpense1" ) .. "$.\n")
	end
	concommand.Add("money_check", money_check_CC , nil, "Command used to print-out self account info.")

	

--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	PANELS: Money System - Client > Client, Commands List; Money System - Server > General Management, Money Systems, Player Actions, Death-related, Team Settings
									1		2										3					4				5				6			 7
	1 Addon Info, Clientside (Notifications, HUDPos, Check)
	2 All commands with descriptons
	3 Freeze, SetAll, Defaults, CheckAll, SENTSpawn
	4 Paydays, Payday Amount, Payday Time Interval, ROI, ROI offset, Bounty, Bounty Time Interval, Spawncosts, Multipliers
	5 Mugging/Robbing, Threatening, Unbuying, Dropping
	6 NPC Killcounter, On Insufficient Respawn, On Killplayer Steal, On Killplayer Stolen Fraction
	7 Distinguish Teams, Team Payday Percentages, Team Awards Perentages
	
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	-- -- -- -- --
	-- CLIENT   --
	-- -- -- -- --
	
	function SMS1_Client(Panel)

		Panel:AddControl    ("Label" ,{ Text = ">> 1. ADDON INFO" })
		
		if game.SinglePlayer() then
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			Panel:ControlHelp 	("This addon is not suitable for singleplayer.")
		end
		
		Panel:ControlHelp	("") -- Create a smaller vertical space.
		Panel:ControlHelp 	("Sandbox Money System, ver. 2.0")
		Panel:ControlHelp 	("(c) KRisU, with special thanks to fghdx, Rejn, Romanov.") -- ControlHelps are these little blue strings under the main text.
		Panel:ControlHelp 	("Do not reupload.")

		Panel:AddControl    ("Label" ,{ Text = "" })
		Panel:AddControl    ("Label" ,{ Text = ">> 2. CLIENTSIDE" })
		
		Panel:AddControl  	("CheckBox" ,{ Label = "Toggle Notifications", Command = "money_notifications" }) -- Notifications
		Panel:ControlHelp 	("Toggles only the most frequent ones (on chat).")
		
		Panel:AddControl  	("CheckBox" ,{ Label = "Toggle Bounty Marker", Command = "money_bounty_marker" }) -- Notifications
		Panel:ControlHelp 	("Toggles the text displayed over the bounty target when bounty event occurs.")
		
		Panel:AddControl  	("CheckBox" ,{ Label = "Toggle Weapon Pickup", Command = "money_weaponpickup" }) -- Notifications
		Panel:ControlHelp 	("Also if disabled, will NOT give any weapons upon respawn.")
		
		Panel:ControlHelp	("") -- Create a smaller vertical space.
		
		Panel:AddControl("Slider", {			-- HUDPos	
				Label = "Money HUD Pos",
				Command = "money_displayhud",
				Type = "Int",
				Min = "0",
				Max = "8" })
				
		Panel:ControlHelp	("") -- Create a smaller vertical space.
		
		Panel:Button("Print out bank info", "money_check")	-- Selfcheck
		
	end
	
	-- -- -- -- -- -- --
	-- COMMANDS LIST  --
	-- -- -- -- -- -- --
	
	function SMS1_CommandsList(Panel)
	
		Panel:AddControl    ("Label" ,{ Text = "Sandbox Money System" }) -- Create a label (single-liner) with said text.
		Panel:ControlHelp	("") -- Create a smaller vertical space.
		
		Panel:ControlHelp	("") -- Create a smaller vertical space.
		Panel:AddControl    ("Label" ,{ Text = ">> CLIENT COMMANDS LIST" })
		
		Panel:ControlHelp	(" --- ") -- Create a smaller vertical space.
		
		Panel:AddControl    ("Label" ,{ Text = "(in console) money_give #"})
		Panel:AddControl    ("Label" ,{ Text = "(in chat) /givemoney #"})
		Panel:AddControl    ("Label" ,{ Text = "(in chat) !givemoney #"})
		Panel:ControlHelp 	("Give # dollars from your bank account to player under crosshair position.")
		
		Panel:ControlHelp	("-- AND --") -- Create a smaller vertical space.
		
		Panel:AddControl    ("Label" ,{ Text = "(in console) money_transfer @ #"})
		Panel:ControlHelp 	("Give # dollars from your bank account to player with @ connection ID.")
		
		Panel:ControlHelp	(" --- ") -- Create a smaller vertical space.
		
		Panel:AddControl    ("Label" ,{ Text = "(in console) money_steal #"})
		Panel:AddControl    ("Label" ,{ Text = "(in chat) /rob #"})
		Panel:AddControl    ("Label" ,{ Text = "(in chat) !rob #"})
		Panel:ControlHelp 	("Rob player under crosshair position for # dollars.")
		
		Panel:ControlHelp	("-- AND --") -- Create a smaller vertical space.
		
		Panel:AddControl    ("Label" ,{ Text = "(in chat) !mug"})
		Panel:AddControl    ("Label" ,{ Text = "(in chat) !mug"})
		Panel:ControlHelp 	("Rob player under crosshair position for a random valid amount of dollars.")
		
		Panel:ControlHelp	(" --- ") -- Create a smaller vertical space.
		
		Panel:AddControl    ("Label" ,{ Text = "(in console) money_threaten"})
		Panel:AddControl    ("Label" ,{ Text = "(in chat) /threaten"})
		Panel:AddControl    ("Label" ,{ Text = "(in chat) !threaten"})
		Panel:ControlHelp 	("Threaten player under crosshair position.")
		
		Panel:ControlHelp	(" --- ") -- Create a smaller vertical space.
		
		Panel:AddControl    ("Label" ,{ Text = "(in console) weapon_sell"})
		Panel:AddControl    ("Label" ,{ Text = "(in chat) /sellweapon"})
		Panel:AddControl    ("Label" ,{ Text = "(in chat) !sellweapon"})
		Panel:ControlHelp 	("Sell currently equipped weapon.")
		
		Panel:ControlHelp	(" --- ") -- Create a smaller vertical space.
		
		Panel:AddControl    ("Label" ,{ Text = "(in console) weapon_drop"})
		Panel:AddControl    ("Label" ,{ Text = "(in chat) /dropweapon"})
		Panel:AddControl    ("Label" ,{ Text = "(in chat) !dropweapon"})
		Panel:ControlHelp 	("Drop currently equipped weapon.")
		
		Panel:ControlHelp	(" --- ") -- Create a smaller vertical space.
		
		Panel:AddControl    ("Label" ,{ Text = "(in console) money_check"})
		Panel:AddControl    ("Label" ,{ Text = "(in chat) /check"})
		Panel:AddControl    ("Label" ,{ Text = "(in chat) !check"})
		Panel:ControlHelp 	("Prints out account ballance and rate of interest percentage.")
		
		Panel:ControlHelp	(" --- ") -- Create a smaller vertical space.
		
		Panel:AddControl    ("Label" ,{ Text = "(in console) money_displayhud [0-8]"})
		Panel:ControlHelp 	("Change position of money display on HUD. 0 is hidden; 1 is default.")
		
		Panel:ControlHelp	(" --- ") -- Create a smaller vertical space.
		
		Panel:AddControl    ("Label" ,{ Text = "(in console) money_notifications 0/1"})
		Panel:ControlHelp 	("Toggle in-chat money earn notifications.")
		
		Panel:ControlHelp	(" --- ") -- Create a smaller vertical space.
		
		Panel:AddControl    ("Label" ,{ Text = "(in console) listplayers"})
		Panel:ControlHelp 	("Print current connected players list to console.")
		
		Panel:AddControl    ("Label" ,{ Text = "" }) -- I encourage to force some space at the bottom, to make sure nothing is hidden over the edges with that much of content.
		
	end
		
	-- -- -- -- -- -- -- -- --
	-- GENERAL MANAGEMENT   --
	-- -- -- -- -- -- -- -- --
	
	function SMS2_GeneralManagement(Panel)
	
		Panel:AddControl    ("Label" ,{ Text = "Sandbox Money System" }) -- Create a label (single-liner) with said text.
		Panel:ControlHelp	("") -- Create a smaller vertical space.
		
		Panel:ControlHelp 	(">> GENERAL MANAGEMENT")
		Panel:ControlHelp	("") -- Create a smaller vertical space.
		
		if game.SinglePlayer() then
			Panel:ControlHelp 	("This addon is not suitable for singleplayer.")
			Panel:ControlHelp	("") -- Create a smaller vertical space.
		end	
			
		if checkIfAdmin() then

			Panel:AddControl  	("CheckBox" ,{ Label = "Freeze Accounts", Command = "money_freeze" }) -- CheckBox defaultly uses 0 and 1, so don't worry.
			Panel:ControlHelp   ("Allows (OFF) or disallows (ON) any bank account operations.")
			Panel:ControlHelp   ("Also toggles Paydays, Bounty Events and Vehicle and SENT spawning.")
			Panel:ControlHelp   ("Default: OFF.")
			
			Panel:ControlHelp	("") -- Create a smaller vertical space.
		
			Panel:Button("Reset Options to Defaults", "money_defaults")
			
			Panel:ControlHelp	("") -- Create a smaller vertical space.
		
			Panel:Button("Check All Players", "money_checkall")
			Panel:ControlHelp   ("Prints out to console all CONNECTED players' info.")
			
			Panel:ControlHelp	("") -- Create a smaller vertical space.
		
			Panel:Button("Set All to Starting", "money_setall")
			Panel:ControlHelp   ("Resets all CONNECTED players' money to Newcomers' $ (starting amount).")
			
			Panel:AddControl("Slider", {
				Label = "Newcomers' $",
				Command = "money_starting",
				Type = "Int",
				Min = "300",
				Max = "7000" })
			Panel:ControlHelp 	("Default: 2500")
			
		else 
		
			Panel:ControlHelp 	("You are not an admin.") -- ControlHelps are these little blue strings under the main text.
			Panel:ControlHelp 	("")
			
		end
		
	end
	
	-- -- -- -- --
	-- SYSTEMS  --
	-- -- -- -- --
	
	function SMS2_MoneySystems(Panel)
	
		Panel:AddControl    ("Label" ,{ Text = "Sandbox Money System" }) -- Create a label (single-liner) with said text.
		Panel:ControlHelp	("") -- Create a smaller vertical space.
	
		if game.SinglePlayer() then
			Panel:ControlHelp 	("This addon is not suitable for singleplayer.")
			Panel:ControlHelp	("") -- Create a smaller vertical space.
		end	
			
		if checkIfAdmin() then
		
			Panel:AddControl    ("Label" ,{ Text = ">> 1. PAYDAYS" }) -- Create a label (single-liner) with said text.
			Panel:ControlHelp	("") -- Create a smaller vertical space.
		
			Panel:AddControl  	("CheckBox" ,{ Label = "Paydays", Command = "money_paydays" })
			Panel:ControlHelp   ("Paydays give out money after a specified amount of time.")
			
			Panel:AddControl    ("Textbox"   ,{ Label = "^Base Cash Amount", Command = "money_payday_amount"}) -- Textbox is user *string* input, single-lined. Remember to handle other types of data inside functions, because these babies can't.
			Panel:ControlHelp   ("Changes the base amount of cash a payday gives. Resets timer.")	-- Explode into two lines for better reading
			Panel:ControlHelp	("Units: $. Default: 505. Min: 10.")								-- on small-width screen resolutions.
			
			Panel:AddControl    ("Textbox"   ,{ Label = "^Time Interval", Command = "money_payday_time_interval"}) -- WaitForEnter flag is to refresh ONLY after Textbox lost focus or is pressed ENTER.
			Panel:ControlHelp   ("Changes the time interval between paydays. Resets timer.")
			Panel:ControlHelp	("Units: secs. Default: 240. Min: 30.")
			
			
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			Panel:AddControl    ("Label" ,{ Text = ">> 2. RATE OF INTEREST" }) -- Create a label (single-liner) with said text.
			Panel:ControlHelp	("") -- Create a smaller vertical space.
		
		
			Panel:AddControl  	("CheckBox" ,{ Label = "ROI", Command = "money_roi" })
			Panel:ControlHelp   ("ROI alters the amount of money a player gets from a payday, based on their activity.")
			
			Panel:AddControl("Slider", {
				Label = "ROI Max Offset",
				Command = "money_roi_maxoffset",
				Type = "Float",
				Min = "0.05",
				Max = "0.50" })
			Panel:ControlHelp 	("Maximum absolute value (fraction of 1) of ROI.")	
			Panel:ControlHelp 	("Default: 0.25")
			
			
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			Panel:AddControl    ("Label" ,{ Text = ">> 3. BOUNTY SYSTEM" }) -- Create a label (single-liner) with said text.
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			
			
			Panel:AddControl  	("CheckBox" ,{ Label = "Bounty Events", Command = "money_bounty_system" })
			Panel:ControlHelp   ("After specified amount of time, sets additional price on some players' head, based on their activity.")
			
			Panel:AddControl    ("Textbox"   ,{ Label = "^Time Interval", Command = "money_bounty_time_interval"}) -- WaitForEnter flag is to refresh ONLY after Textbox lost focus or is pressed ENTER.
			Panel:ControlHelp   ("Changes the time interval between bounty events. Resets timer.")
			Panel:ControlHelp	("Units: secs. Default: 360. Min: 90.")
			
			
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			Panel:AddControl    ("Label" ,{ Text = ">> 4. SPAWNCOSTS" }) -- Create a label (single-liner) with said text.
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			
			
			Panel:AddControl  	("CheckBox" ,{ Label = "Spawncosts", Command = "money_spawncosts" })
			Panel:ControlHelp   ("Toggles spawn and summon prices.")
			Panel:ControlHelp   ("Default: ON.")
			
			Panel:AddControl  	("CheckBox" ,{ Label = "Default Weapons for Free", Command = "money_defaultweaponsforfree" })
			Panel:ControlHelp   ("Toggles whether the default GMod/HL2/RP weapons are free.")
			Panel:ControlHelp   ("Useful ONLY for custom loadouts servers.")
			Panel:ControlHelp   ("Default: ON.")
			
			
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			Panel:AddControl    ("Label" ,{ Text = ">> 5. MULTIPLIERS" }) -- Create a label (single-liner) with said text.
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			
			Panel:AddControl("Slider", {
				Label = "Penalties",
				Command = "money_multiplier_penalty",
				Type = "Float",
				Min = "0.5",
				Max = "5.0" })
			Panel:ControlHelp   ("Changes the multiplier of cash penalties.")
			
			Panel:AddControl("Slider", {
				Label = "Awards",
				Command = "money_multiplier_award",
				Type = "Float",
				Min = "0.5",
				Max = "5.0" })
			Panel:ControlHelp   ("Changes the multiplier of cash awards.")
				
			Panel:AddControl("Slider", {
				Label = "NPCs",
				Command = "money_multiplier_spawncost_npc",
				Type = "Float",
				Min = "0.5",
				Max = "5.0" })
			Panel:ControlHelp   ("Changes the multiplier of NPCs' spawncosts.")
			
			Panel:AddControl("Slider", {
				Label = "SWEPs",
				Command = "money_multiplier_spawncost_swep",
				Type = "Float",
				Min = "0.5",
				Max = "5.0" })
			Panel:ControlHelp   ("Changes the multiplier of weapons' costs.")
			
			Panel:AddControl("Slider", {
				Label = "Vehicles",
				Command = "money_multiplier_spawncost_vehicle",
				Type = "Float",
				Min = "0.5",
				Max = "5.0" })
			Panel:ControlHelp   ("Changes the multiplier of vehicles' and seats' spawncosts.")
			
			Panel:AddControl("Slider", {
				Label = "SENTs",
				Command = "money_multiplier_spawncost_sent",
				Type = "Float",
				Min = "1.0",
				Max = "10.0" })
			Panel:ControlHelp   ("Changes the multiplier of SENTs' spawncosts.")
			
			Panel:AddControl("Slider", {
				Label = "Props",
				Command = "money_multiplier_spawncost_prop",
				Type = "Float",
				Min = "0.5",
				Max = "5.0" })
			Panel:ControlHelp   ("Changes the multiplier of props' spawncosts.")
			
			Panel:AddControl    ("Label" ,{ Text = "" }) -- I encourage to force some space at the bottom, to make sure nothing is hidden over the edges with that much of content.
			
		else 
		
			Panel:ControlHelp 	("You are not an admin.") -- ControlHelps are these little blue strings under the main text.
			Panel:ControlHelp 	("")
			
		end
	
	end
	
	-- -- -- -- -- -- -- --
	-- PLAYER ACTIONS    --
	-- -- -- -- -- -- -- --
	
	function SMS2_PlayerActions(Panel)
	
		Panel:AddControl    ("Label" ,{ Text = "Sandbox Money System" }) -- Create a label (single-liner) with said text.
		Panel:ControlHelp	("") -- Create a smaller vertical space.
	
		if game.SinglePlayer() then
			Panel:ControlHelp 	("This addon is not suitable for singleplayer.")
			Panel:ControlHelp	("") -- Create a smaller vertical space.
		end	
			
		if checkIfAdmin() then
		
			Panel:AddControl    ("Label" ,{ Text = ">> PLAYER ACTIONS" }) -- Create a label (single-liner) with said text.
			Panel:ControlHelp	("") -- Create a smaller vertical space.
	
			Panel:AddControl  	("CheckBox" ,{ Label = "Mugging/Robbing", Command = "spc_mugging" })
			Panel:ControlHelp   ("Toggles the ability to use money-stealing commands.")
			
			Panel:AddControl  	("CheckBox" ,{ Label = "Threatening", Command = "spc_threatening" })
			Panel:ControlHelp   ("Toggles the ability to use \"money_threaten\".")
			
			Panel:AddControl  	("CheckBox" ,{ Label = "Weapon Selling", Command = "spc_weapon_unbuying" })
			Panel:ControlHelp   ("Toggles the ability to use weapon selling commands.")
			
			Panel:AddControl  	("CheckBox" ,{ Label = "Weapon Dropping", Command = "spc_weapon_dropping" })
			Panel:ControlHelp   ("Toggles the ability to use weapon dropping commands.")
			
		else 
		
			Panel:ControlHelp 	("You are not an admin.") -- ControlHelps are these little blue strings under the main text.
			Panel:ControlHelp 	("")
			
		end
			
	end
	
	-- -- -- -- -- -- --
	-- DEATH RELATED  --
	-- -- -- -- -- -- --
	
	function SMS2_DeathRelated(Panel)
	
		Panel:AddControl    ("Label" ,{ Text = "Sandbox Money System" }) -- Create a label (single-liner) with said text.
		Panel:ControlHelp	("") -- Create a smaller vertical space.
	
		if game.SinglePlayer() then
			Panel:ControlHelp 	("This addon is not suitable for singleplayer.")
			Panel:ControlHelp	("") -- Create a smaller vertical space.
		end	
			
		if checkIfAdmin() then
		
			Panel:AddControl    ("Label" ,{ Text = ">> DEATH-RELATED / SCORE-RELATED" }) -- Create a label (single-liner) with said text.
			Panel:ControlHelp	("") -- Create a smaller vertical space.
	
			Panel:AddControl  	("CheckBox" ,{ Label = "NPC Killcounter", Command = "npc_killcounter" }) -- CheckBox defaultly uses 0 and 1, so don't worry.
			Panel:ControlHelp   ("Toggles whether any NPC counts up in the scoreboard.")
			Panel:ControlHelp   ("Default: ON.")
			
			Panel:AddControl  	("CheckBox" ,{ Label = "Respawn when at 0$", Command = "money_oninsufficient_respawn" }) -- CheckBox defaultly uses 0 and 1, so don't worry.
			Panel:ControlHelp   ("Toggles player respawns when with insufficient funds.")
			Panel:ControlHelp   ("Default: ON.")
		
			Panel:AddControl  	("CheckBox" ,{ Label = "Steal victim's money", Command = "money_onkillplayer_steal" }) -- CheckBox defaultly uses 0 and 1, so don't worry.
			Panel:ControlHelp   ("Toggles whether the killer gets an award from the server or steals a fraction of the victim's money.")
			Panel:ControlHelp   ("Default: OFF.")
			
			Panel:AddControl("Slider", {
				Label = "^ PvP stolen frac.",
				Command = "money_onkillplayer_steal_fraction",
				Type = "Float",
				Min = "0.01",
				Max = "0.25" })
			Panel:ControlHelp	("Default: 0.05.")
		
		else 
		
			Panel:ControlHelp 	("You are not an admin.") -- ControlHelps are these little blue strings under the main text.
			Panel:ControlHelp 	("")
			
		end
		
	end
	
	-- -- -- -- -- -- --
	-- TEAM SETTINGS  --
	-- -- -- -- -- -- --
	
	function SMS2_TeamSettings(Panel)
		
		Panel:AddControl    ("Label" ,{ Text = "Sandbox Money System" }) -- Create a label (single-liner) with said text.
		Panel:ControlHelp	("") -- Create a smaller vertical space.
	
		if game.SinglePlayer() then
			Panel:ControlHelp 	("This addon is not suitable for singleplayer.")
			Panel:ControlHelp	("") -- Create a smaller vertical space.
		end	
			
		if checkIfAdmin() then
		
			Panel:AddControl    ("Label" ,{ Text = ">> 1. TEAM SETTINGS" }) -- Create a label (single-liner) with said text.
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			
			Panel:AddControl  	("CheckBox" ,{ Label = "Distinguish Teams", Command = "money_distinguish_teams" }) -- CheckBox defaultly uses 0 and 1, so don't worry.
			Panel:ControlHelp   ("Toggles whether teams are distinguished from each other.")
			Panel:ControlHelp   ("Also toggles whether Payday and Awards percentages take effect.")
			Panel:ControlHelp   ("Default: OFF.")
			
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			Panel:AddControl    ("Label" ,{ Text = ">> 2. PAYDAY PERCENTAGES" }) -- Create a label (single-liner) with said text.
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			
			Panel:ControlHelp	("These percentage variables works in 1 = 1% analogy.") -- Create a smaller vertical space.
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			
			Panel:AddControl("Slider", {
				Label = "Team #0",
				Command = "money_payday_percentage_team0",
				Type = "Int",
				Min = "5",
				Max = "200" })
			
			Panel:AddControl("Slider", {
				Label = "Team #1",
				Command = "money_payday_percentage_team1",
				Type = "Int",
				Min = "5",
				Max = "200" })
				
			Panel:AddControl("Slider", {
				Label = "Team #2",
				Command = "money_payday_percentage_team2",
				Type = "Int",
				Min = "5",
				Max = "200" })
			
			Panel:AddControl("Slider", {
				Label = "Team #3",
				Command = "money_payday_percentage_team3",
				Type = "Int",
				Min = "5",
				Max = "200" })
				
			Panel:AddControl("Slider", {
				Label = "Team #4",
				Command = "money_payday_percentage_team4",
				Type = "Int",
				Min = "5",
				Max = "200" })
				
			Panel:AddControl("Slider", {
				Label = "Team #5",
				Command = "money_payday_percentage_team5",
				Type = "Int",
				Min = "5",
				Max = "200" })
				
			Panel:AddControl("Slider", {
				Label = "Team #6",
				Command = "money_payday_percentage_team6",
				Type = "Int",
				Min = "5",
				Max = "200" })
				
			Panel:AddControl("Slider", {
				Label = "Team #7",
				Command = "money_payday_percentage_team7",
				Type = "Int",
				Min = "5",
				Max = "200" })
				
			Panel:AddControl("Slider", {
				Label = "Team #8",
				Command = "money_payday_percentage_team8",
				Type = "Int",
				Min = "5",
				Max = "200" })
			
			Panel:AddControl("Slider", {
				Label = "Team #9",
				Command = "money_payday_percentage_team9",
				Type = "Int",
				Min = "5",
				Max = "200" })
				
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			
			Panel:AddControl    ("Label" ,{ Text = ">> 3. AWARDS PERCENTAGES" }) -- Create a label (single-liner) with said text.
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			
			Panel:ControlHelp	("These percentage variables works in 1 = 1% analogy.") -- Create a smaller vertical space.
			Panel:ControlHelp	("") -- Create a smaller vertical space.
			
			Panel:AddControl("Slider", {
				Label = "Team #0",
				Command = "money_awards_percentage_team0",
				Type = "Int",
				Min = "5",
				Max = "200" })
			
			Panel:AddControl("Slider", {
				Label = "Team #1",
				Command = "money_awards_percentage_team1",
				Type = "Int",
				Min = "5",
				Max = "200" })
				
			Panel:AddControl("Slider", {
				Label = "Team #2",
				Command = "money_awards_percentage_team2",
				Type = "Int",
				Min = "5",
				Max = "200" })
			
			Panel:AddControl("Slider", {
				Label = "Team #3",
				Command = "money_awards_percentage_team3",
				Type = "Int",
				Min = "5",
				Max = "200" })
				
			Panel:AddControl("Slider", {
				Label = "Team #4",
				Command = "money_awards_percentage_team4",
				Type = "Int",
				Min = "5",
				Max = "200" })
				
			Panel:AddControl("Slider", {
				Label = "Team #5",
				Command = "money_awards_percentage_team5",
				Type = "Int",
				Min = "5",
				Max = "200" })
				
			Panel:AddControl("Slider", {
				Label = "Team #6",
				Command = "money_awards_percentage_team6",
				Type = "Int",
				Min = "5",
				Max = "200" })
				
			Panel:AddControl("Slider", {
				Label = "Team #7",
				Command = "money_awards_percentage_team7",
				Type = "Int",
				Min = "5",
				Max = "200" })
				
			Panel:AddControl("Slider", {
				Label = "Team #8",
				Command = "money_awards_percentage_team8",
				Type = "Int",
				Min = "5",
				Max = "200" })
			
			Panel:AddControl("Slider", {
				Label = "Team #9",
				Command = "money_awards_percentage_team9",
				Type = "Int",
				Min = "5",
				Max = "200" })
			
			Panel:AddControl    ("Label" ,{ Text = "" }) -- I encourage to force some space at the bottom, to make sure nothing is hidden over the edges with that much of content.
			
		else 
		
			Panel:ControlHelp 	("You are not an admin.") -- ControlHelps are these little blue strings under the main text.
			Panel:ControlHelp 	("")
			
		end
			
	end
	
	-- -- -- --
	-- HOOKS --
	-- -- -- --
	
	hook.Add("PopulateToolMenu", "SMSMenus", function () -- Look the function and the hook up on wiki.garrysmod.com for more info.
		spawnmenu.AddToolMenuOption("Utilities", "Money Sys - Client", "SMS1_Client", "Clientside", "", "", SMS1_Client)
		spawnmenu.AddToolMenuOption("Utilities", "Money Sys - Client", "SMS1_CommandsList", "Commands List", "", "", SMS1_CommandsList)
		
		spawnmenu.AddToolMenuOption("Utilities", "Money Sys - Server", "SMS2_GeneralManagement", "1. General Management", "", "", SMS2_GeneralManagement)
		spawnmenu.AddToolMenuOption("Utilities", "Money Sys - Server", "SMS2_MoneySystems", "2. Money Systems", "", "", SMS2_MoneySystems)
		spawnmenu.AddToolMenuOption("Utilities", "Money Sys - Server", "SMS2_PlayerActions", "3. Player Actions", "", "", SMS2_PlayerActions)
		spawnmenu.AddToolMenuOption("Utilities", "Money Sys - Server", "SMS2_DeathRelated", "4. Death-related", "", "", SMS2_DeathRelated)
		spawnmenu.AddToolMenuOption("Utilities", "Money Sys - Server", "SMS2_TeamSettings", "5. Team Settings", "", "", SMS2_TeamSettings)
	end)
	
	
	print( "[Sandbox Simple Money System] Clientside initialized." )
	
	
end



-- END OF FILE --