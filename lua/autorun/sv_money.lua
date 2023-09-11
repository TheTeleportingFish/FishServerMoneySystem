--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	Sandbox Money System. Made by KRisU. Special thanks to fghdx, Rejn, Romanov, Rubat. Shoutout to your mom!
	Version: 2.0

]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

AddCSLuaFile() -- Mark file for client downloads

--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	GAME BASED CONVARS
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

CreateConVar( "money_starting", 2500, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; Money amount given to every new player.
CreateConVar( "money_freeze", 0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; Prevent any bank account action?

CreateConVar( "money_paydays", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; Do paydays occur?
-- Payday Amount and Payday Time Interval is not a Console Variable - see settings[] below.

CreateConVar( "money_bounty_system", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; Is bounty system enabled?
-- Bounty Events Time Interval is not a Console Variable - see settings[] below.

CreateConVar( "money_spawncosts", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; Are spawncosts enabled?
CreateConVar( "money_oninsufficient_respawn", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; Is respawning with insufficient funds (e.g. 0 $) available?

CreateConVar( "money_roi", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Bool; Does ROI take effect?
CreateConVar( "money_roi_maxoffset", 0.25, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; Maximum absolute ROI value.

CreateConVar( "money_defaultweaponsforfree", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; Allow or disallow free weapons.

CreateConVar( "money_onkillplayer_steal", 0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; Do killers get money from server or steal from the victim?
CreateConVar( "money_onkillplayer_steal_fraction", 0.05, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; How much percent (0.07 = 7%) of victim's bank account killers steal?

CreateConVar( "money_multiplier_penalty", 1.0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; Multiplier for penalties.
CreateConVar( "money_multiplier_award", 1.0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; Multiplier for awardments.
CreateConVar( "money_multiplier_spawncost_npc", 1.0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; Multiplier for NPC costs.
CreateConVar( "money_multiplier_spawncost_swep", 1.0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; Multiplier for SWEP costs.
CreateConVar( "money_multiplier_spawncost_vehicle", 1.0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; Multiplier for VEHICLES costs.
CreateConVar( "money_multiplier_spawncost_sent", 5.0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; Multiplier for SENT costs.
CreateConVar( "money_multiplier_spawncost_prop", 1.0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; Multiplier for PROP costs.

CreateConVar( "money_distinguish_teams", 0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY } ) -- Bool; Are teams distinguished from one another in terms of money system settings? See below for more info.

CreateConVar( "money_payday_percentage_team0", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team1", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team2", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team3", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team4", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team5", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team6", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team7", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team8", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team9", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )

CreateConVar( "money_awards_percentage_team0", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team1", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team2", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team3", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team4", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team5", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team6", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team7", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team8", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team9", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )

CreateConVar( "spc_mugging", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; Allow or disallow manual robbing.
CreateConVar( "spc_threatening", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; Allow or disallow manual threatening (freezing a player and causing them to take a random action).
CreateConVar( "spc_weapon_unbuying", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; Allow or disallow manual selling of equipped weapons or items.
CreateConVar( "spc_weapon_dropping", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; Allow or disallow manual weapons drop.

CreateConVar( "npc_killcounter", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; Allow or disallow counting up killed NPCs to the scoreboard.

--CreateConVar( "money_randomevents", 0, { FCVAR_ARCHIVE , FCVAR_NOTIFY } ) -- Bool; Do random money-earning or money-losing events occur? | FUTURE PLANS

--function notifySpecOnConVarChanged( name, old, new ) -- Internal hook that could be handy with default system convars and concommands states changes announcements.
--hook.Add("OnConVarChanged", "notifySpecOnConVarChanged", notifySpecOnConVarChanged) -- Not recommended though.


--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	MAIN TABLES
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


local settings = {

	-- Paydays; Setting less than 1 won't work.
	
		payday_amount = 505, 		-- How much money to add in a payday. Shouldn't really be more than starting money.
		payday_time_interval = 240, -- Time between paydays in seconds. 270 seconds by default. Please do not set less than 2 seconds, it will become messy in-game. In-game cannot be set less than 30s.
		
	-- Bounties; Setting less than 1 won't work.
	
		bounty_time_interval = 360,	-- Interval between bounty events in seconds. Should NOT be less than 90 seconds. Like, for real this time.
		
	-- Penalties for actions; Setting less than 1 won't work.
	
		penalty_deathby_self = 75, 		-- Best setting is slightly less than 2 * 'award_on_killnpc_else'.
		penalty_deathby_entity = 45,	-- Defines death by any other source than self or player. Best setting is less than half of 'award_on_killplayer'.
		penalty_deathby_player = 8,		-- It should circle between 2 to 5 times 'penalty_respawn' value.
		penalty_respawn = 2,			-- It'd be a robbery if this was set to more than 10.
		
	-- Awards for actions; Setting less than 1 won't work.

		award_on_killplayer = 99,			-- Is used when 'on_killplayer_steal' is set to false. Should be 25%-40% of payday amount.
		award_on_killnpc_ultrabig = 2004,	-- Best setting is about quadruple the npc_big award value.
		award_on_killnpc_big = 460, 		-- Best setting is adding the three values below, multiplying by 10 and then dividing by 2.5.
		award_on_killnpc_else = 65,  		-- Award for NPC other than big, small, and friendly - best around half of 'award_on_killplayer'.
		award_on_killnpc_small = 35, 		-- Best setting is in between 'else' and 'friendly' and not more than 15% of payday amount.
		award_on_killnpc_friendly = 15	 	-- For disabling the money-grinding, has to be set significantly less than 'spawncost_npc_friendly'.
	
}


local spawncosts = {

	-- Others; There are NOT any multipliers for effects' and ragdolls' costs.
		
		effect = 2, 	-- Leave it 2 or 4.
		ragdoll = 15,	-- For best results should be equal 'award_on_killnpc_friendly'.

	-- Weapons Costs; Setting less than 1 won't work.  Any and every weapon that's free is defined below in "free_weapons" table. Always free weapons are listed in "true_weapons" table.
		
		weapon = 73, -- Best setting is around 2 * 'award_on_killnpc_else'.
		m9k_gdcw_app = 9, -- These 'apps' are little additions to said type of weaponry's cost.
		fas2_app = 8,
		cw20_app = 4,
		q3_app = 3,
		cs_ttt_rp_dod_app = 2,
		eq_gmod_stranded_app = -1,
		
	-- NPC Costs; Setting less than 1 won't work.
		
		npc_ultrabig = 606, -- NPC listed as ultrabig; see below (about tripled value of npc_big).
		npc_big = 150, 		-- NPC listed as big; see below.
		npc_else = 40, 	 	-- Every NPC that is NOT listed as small, big, ultrabig or friendly.
		npc_small = 30,	 	-- NPC listed as small; see below.
		npc_friendly = 25, 	-- NPC listed as friendly; see below.
		
	-- Vehicle Costs; Setting less than 1 won't work.
		
		vehicle_seat = 88, 		-- Base of any seat.
		vehicle_airboat = 400, 	-- Base of airboat.
		vehicle_jeep_old = 275,	-- Base of old, red jeep (Jeep).
		vehicle_hl2apc = 900, 	-- Base of HL2 APC. It is not really used anywhere though.
		vehicle_jeep = 333, 	-- Base of new, yellow muscle car (Jalopy) and handler of unknown vehicles!
		vehicle_tank = 775,		-- -vv-------------------vv- -- 
		vehicle_delorean = 455,	--  SCars 2.0 by sakarias88  -- 
		vehicle_junk = 255,		--  SCars 2.0 by sakarias88  --
		vehicle_gtone = 440,	-- -^^-------------------^^- --  
		
	-- SENT Costs; Setting less than 1 won't work.
		
		-- SENTs cost its' mass multiplied by 'sent_multiplier'; except these below:
		
		sent_stat = 288,					-- Additional HL2 Content & Extras + Some others + Emplacements + This Addon -- 
		sent_jet = 2250,					-- -vv-------------------vv- --
		sent_jet_nonadmin = 1850,			-- AirVehicles by sakarias88 --
		sent_helicopter = 1450,				-- AirVehicles by sakarias88 --
		sent_helicopter_nonadmin = 1050,	-- -^^-------------------^^- --
		sent_gasstation = 2000,		        -- SCars 2.0 by sakarias88 -- 
		sent_combinemech = 1150,			-- Combine Mech Fixed addon --
		cw_ammo_crate_regular = 444,		-- -vv-------------------vv- --
		cw_ammo_crate_small = 299, 			-- Customizable Weaponry 2.0 --
		cw_ammo_kit_regular = 123,			-- Customizable Weaponry 2.0 --
		cw_ammo_kit_small = 75,				-- -^^-------------------^^- --
		anomaly = 1250,						-- Stalker RP Anomalies --
		sent_tardis = 3600,
		acf_ammo = 160,
		acf_gun = 36,
		acf_rack = 52,
		acf_engine = 250,                 -- TARDIS by MattJeanes --
		
	-- PROP COSTS, defined by >>entity mass<<; If entity's mass is >>less than<< N, then it costs group accordingly; Setting less than 1 won't work.

		prop_under_5 = 2,
		prop_under_10 = 5,
		prop_under_20 = 8,
		prop_under_40 = 11,
		prop_under_60 = 15,
		prop_under_80 = 19,
		prop_under_100 = 23,
		prop_under_150 = 28,
		prop_under_200 = 33,
		prop_under_300 = 39,
		prop_under_400 = 45,
		prop_under_600 = 50,
		prop_under_800 = 55,
		prop_under_1200 = 60,
		prop_under_1600 = 65,
		prop_under_2400 = 73,
		prop_under_3200 = 81,
		prop_under_4800 = 95,
		prop_under_6400 = 110,
		prop_under_9999 = 140,
		prop_over_9999 = 175
		
}


--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	> FREE WEAPONS
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Free when "money_defaultweaponsforfree" is set to true.
local free_weapons = { -- Add Weapon:GetClass() name string at the end of the table to recognize it as free. A-Z sorting is optional.
	"eq_flashlight", "eq_parachute", "eq_torch", "eq_torch_bms", "eq_wrench", "eq_zparachute", "flashlight", "gm_hands", "gmod_camera", "gmod_fists", "gmod_hands", 
	"gmod_tool", "rp_hands", "rphands", "stalker_bolt", "ttt_hands", "weapon_357", "weapon_ar1", "weapon_ar2", "weapon_bolt", "weapon_crossbow", "weapon_crowbar", 
	"weapon_fists", "weapon_flashlight", "weapon_frag", "weapon_knife", "weapon_parachute", "weapon_physcannon", "weapon_physgun", "weapon_pistol", "weapon_rock", 
	"weapon_rpg", "weapon_scarkeys", "weapon_shotgun", "weapon_smg1", "weapon_smoke", "weapon_smokegrenade", "weapon_stick", "weapon_stone", "weapon_stunstick", 
	"weapon_torch", "zparachute"
}

-- Free when "money_defaultweaponsforfree" is set to false.
local true_weapons = { -- Add Weapon:GetClass() name string at the end of the table to recognize it as always free. A-Z sorting is optional.
	"eq_flashlight", "eq_parachute", "eq_torch", "eq_torch_bms", "eq_zparachute", "flashlight", "gmod_camera", "gmod_fists", "gmod_hands", "gmod_tool", "rp_hands", 
	"rphands", "stalker_bolt", "weapon_bolt", "weapon_crowbar", "weapon_fists", "weapon_flashlight", "weapon_knife", "weapon_parachute", "weapon_physcannon", 
	"weapon_physgun", "weapon_rock", "weapon_stick", "weapon_stone", "weapon_stunstick", "weapon_torch", "zparachute"
}



--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	> NPC GROUPS; Every Entity:NPC with name not contained in one of these three groups will be labeled as 'else'.
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

local npc_friendly = { -- Add entity.npc string name here to list it with others allies. A-Z sorting is optional.
	"monster_barney", "monster_freeman", "monster_gman", "monster_otis", "monster_rosenberg", "monster_wheelchair", "npc_alyx", "npc_barney", "npc_breen", "npc_dog", 
	"npc_eli", "npc_fisherman", "npc_freeman", "npc_friendly", "npc_gman", "npc_kleiner", "npc_magnusson", "npc_monk", "npc_mossman"
}

local npc_small = { -- Add entity.npc string name here to list it with others smalls. A-Z sorting is optional.
	"combine_mine", "monster_alien_babyvoltigore", "monster_babycrab", "monster_cockroach", "monster_headcrab", "monster_penguin", "npc_antlion_grub", "npc_barnacle", 
	"npc_chicken", "npc_chumtoad", "npc_clawscanner", "npc_combine_camera", "npc_combine_mine", "npc_crow", "npc_cscanner", "npc_bird", "npc_headcrab", 
	"npc_headcrab_black", "npc_headcrab_fast", "npc_manhack", "npc_owl", "npc_parrot", "npc_pigeon", "npc_seagull", "npc_turret_ceiling"
}

local npc_big = { -- Add entity.npc string name here to list it with others bigs. A-Z sorting is optional.
	"combine_apc", "monster_babygarg", "monster_bigmomma", "monster_gargantua", "monster_gargantuar", "npc_advisor", "npc_antlionguard", "npc_antlionguardian", 
	"npc_apache", "npc_apc", "npc_blackhawk", "npc_combineapc", "npc_combinedropship", "npc_combinegunship", "npc_crabsynth", "npc_deathclaw", "npc_deathclaw_alphamale", 
	"npc_deathclaw_mother", "npc_dragon", "npc_dragon_ancient", "npc_dragon_blood", "npc_dragon_elder", "npc_dragon_frost", "npc_dragon_revered", "npc_dragon_serpentine",
	"npc_dragon_skeleton", "npc_gecko_gojira", "npc_heli", "npc_helicopter", "npc_hellknight", "npc_mudcrab_legendary", "npc_strider", "npc_tank", "npc_ultron", 
	"npc_vj_tank", "npc_vj_zss_zboss", "npc_vj_zps_zboss"
}

local npc_ultrabig = { -- Add entity.npc string name here to list it with others super-bigs. A-Z sorting is optional.
	"monster_nihilanth", "npc_guardian",  "npc_vj_fo3ene_libertyprime", "npc_vj_fo3bhs_libertyprime", "npc_vj_libertyprime", "npc_dragon_alduin", "npc_dragon_odahviing", 
	"npc_dragon_paarthurnax", "npc_libertyprime", "npc_spaceship"
}



--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	INITIALIZATION AND PRE-LOAD
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	
	function GetPaydayAmount()
		return settings['payday_amount']
	end
	
	
	if (SERVER) then
	
	
	player_data = FindMetaTable("Player") -- Gets all the functions that affect player.
	
	
	-- Money:
	
	function player_data:money_initLoad()
		if self:GetPData( "money" ) == nil then -- See if there is data under "money" for the player.
			self:SetPData( "money", GetConVar("money_starting"):GetInt() ) -- If not, add money.
		end
		self:SetNWInt("money", self:GetPData( "money" )) -- Set the network int so the client can grab the info.
	end
	
	-- Money' Rate of Interest:
	
	function player_data:roi_initLoad()
		if self:GetPData( "moneyROI" ) == nil then -- See if there is data under "moneyROI" for the player.
			self:SetPData( "moneyROI", 0.00 ) -- If not, set 0.
		end
		self:SetNWFloat("moneyROI", (math.floor(self:GetPData( "moneyROI" )*100)*0.01)) -- Set the network float so the client can grab the info. This function gets rid of any unnecessary numbers after the second decimal position.
	end
	
	-- Fame Points (Bounty System):
	
	function player_data:fame_initLoad()
		if self:GetPData( "bountyFame" ) == nil then -- See if there is data under "bountyFame" for the player.
			self:SetPData( "bountyFame", 1 ) -- If not, set 1.
		end
		self:SetNWInt("bountyFame", (math.ceil(self:GetPData( "bountyFame" )))) -- Set the network int so the client can grab the info.
	end
	
	-- Player Initial Spawn Hook:
	
	function system_initLoadOnSpawn( ply ) -- Load systems on player initial spawn.
		ply:money_initLoad()
		ply:roi_initLoad()
		ply:fame_initLoad()
		ply:fame_interact(1,1)
		ply:SetNWBool( "isHunted" , false )
		ply:SetNWInt( "bountyPrice" , 0 )
		ply:SetNWBool( "antitheftEq" , false )
		ply:SetNWInt( "latestExpense1", 0 )
		ply:SetNWInt( "latestExpense2", 0 )
		ply:SetNWInt( "latestExpense3", 0 )
	end
	hook.Add( "PlayerInitialSpawn", "SMSInitLoadOnSpawn", system_initLoadOnSpawn )

	
	-- Init message:
	
	hook.Add( "Initialize", "SMSInit", function ()
		print("[Sandbox Money System] Serverside initialized.")
	end )
	
	
	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	SYSTEMS INTERACTION METHODS
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


	-- Money Method.
	-- Money is interpreted as full-sized currency. No pennies and small shit like that.
	function player_data:money_interact( method, amount ) -- Add or take money.
		
		if (GetConVar( "money_freeze" ):GetBool() == false) then
		
			local money = self:GetNWInt( "money" ) -- Gets the players money.
			
			if (method == 0) then						-- Method 0 is take money, method 1 (not 0) is give money.
				self:SetNWInt("money", money - amount) 	-- Set the network int for the money. This way we can get it on the client.
				self:SetPData("money", money - amount) 	-- Users money gets updated to what the currently have - the amount from interaction.
			else
				self:SetNWInt("money", money + amount)	-- Set the network int for the money. This way we can get it on the client.
				self:SetPData("money", money + amount) 	-- Users money gets updated to what the currently have + the amount from interaction.
			end
			
		else
			return
		end
	end
	
	-- ROI Method.
	-- Amount is interpreted as number of percents (e.g. 3% is 3.0).
	function player_data:roi_interact( method, amount ) -- Increase or decrease ROI.
		
		if (GetConVar("money_roi"):GetBool() == true) then 	-- The one and only check for money roi availability - 
															-- there is no need to check for it anywhere else, the function simply won't do anything if it retrieves false.
			
			local roi = self:GetNWFloat( "moneyROI" ) -- Gets the players ROI.
			
			if (method == 0) then -- Method 0 is subtract
				if ( ((roi - amount - 0.01)/100) < (GetConVar("money_roi_maxoffset"):GetFloat()*(-1)) ) then
					self:SetNWFloat("moneyROI", ((math.ceil((GetConVar("money_roi_maxoffset"):GetFloat()*100))*0.010)*(-1)) )
					self:SetPData("moneyROI", ((math.ceil((GetConVar("money_roi_maxoffset"):GetFloat()*100))*0.010)*(-1)) )
				else
					self:SetNWFloat("moneyROI", ((math.ceil((roi - amount)*100))*0.010)) -- Set the network float for the roi. This way we can get it on the client.
					self:SetPData("moneyROI", ((math.ceil((roi - amount)*100))*0.010)) 	 -- Update PData.
				end
			else -- Method NOT 0 (e.g. 1) is add.
				if ( ((roi + amount + 0.01)/100) > (GetConVar("money_roi_maxoffset"):GetFloat()*1) ) then
					self:SetNWFloat("moneyROI", ((math.floor((GetConVar("money_roi_maxoffset"):GetFloat()*100))*0.010)*(1)) )
					self:SetPData("moneyROI", ((math.floor((GetConVar("money_roi_maxoffset"):GetFloat()*100))*0.010)*(1)) )
				else
					self:SetNWFloat("moneyROI", ((math.floor((roi + amount)*100))*0.010))	-- Set the network float for the roi. This way we can get it on the client.
					self:SetPData("moneyROI", ((math.floor((roi + amount)*100))*0.010)) 	-- Update PData.
				end
			end
		
		else
			return
		end
		
	end

	-- Bounty Method.
	-- Bounty System works on integers ranged from 0 up. Analogical function to money_interact.
	function player_data:fame_interact( method, amount ) -- Add or take fame points.
		
		if (GetConVar("money_bounty_system"):GetBool() == true) then	-- The one and only check for bounty systems availability - 
																		-- there is no need to check for it anywhere else, the function simply won't do anything if it retrieves false.
			
			local fame = self:GetNWInt( "bountyFame" )
			
			if (method == 0) then -- Method 0 is decrease fame, method 1 (not 0) is increase fame.
				if (fame - amount <= 0) then
					self:SetNWInt("bountyFame", 0)
					self:SetPData("bountyFame", 0)
				else
					self:SetNWInt("bountyFame", fame - amount)
					self:SetPData("bountyFame", fame - amount)
				end
			else
				self:SetNWInt("bountyFame", fame + amount)
				self:SetPData("bountyFame", fame + amount)
			end
		
		else
			return
		end
		
	end
	
	
	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	MONEY BASIC METHODS
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	
	-- This is used to check if the player has enough money to do what they are requesting.
	function player_data:money_enough( amount ) 		-- Check if the player has enough money for an Action.
		
		local money = tonumber(self:GetNWInt( "money" )) 	
		
		if (money >= amount) then 	-- If they have, it will return true.					
			return true
		else						-- If they have not, the function will return false.
			return false
		end
	end
	
	-- This is used to give player money with internal correctness check.
	function player_data:money_give( amount )
		if (tonumber(amount) > 0) then 		-- Check if the amount is over 0 to prevent players sending or giving negative amounts.
			self:money_interact(1, amount) 	-- Add money .
		end
	end

	-- This is used to take money from a player.
	function player_data:money_take( amount )
		if ((tonumber(amount) > 0) and self:money_enough(amount) == true) then -- Check if the amount is over 0 to prevent players sending or giving negative amounts.
			self:money_interact(0, amount) -- Take money.
			self:SetNWInt( "latestExpense1", self:GetNWInt( "latestExpense2" ))
			self:SetNWInt( "latestExpense2", self:GetNWInt( "latestExpense3" ))
			self:SetNWInt( "latestExpense3", amount )
			return true
		else
			return false
		end
	end

	-- This function takes money from player and zeroes up the bank account if the payment is more than saldo.
	function player_data:money_take_absolute( amount )
		
		local money = tonumber(self:GetNWInt( "money" ))	-- Gets the player's money.
		
		if (amount > 0 and money > amount) then 			-- Check if the amount is over 0 to prevent sending or giving negative amounts.
			self:money_interact(0, amount)
			self:SetNWInt( "latestExpense1", self:GetNWInt( "latestExpense2" ))
			self:SetNWInt( "latestExpense2", self:GetNWInt( "latestExpense3" ))
			self:SetNWInt( "latestExpense3", amount )
		elseif (amount > 0 and money <= amount) then 		-- If amount given as argument is more than money the player has, take all of it (Zero up bank account).
			self:money_interact(0, money)
			self:SetNWInt( "latestExpense1", self:GetNWInt( "latestExpense2" ))
			self:SetNWInt( "latestExpense2", self:GetNWInt( "latestExpense3" ))
			self:SetNWInt( "latestExpense3", money )
		end
	end

	
	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	SYSTEMS
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


	-- BASIC PAYDAY FUNCTION
	
	function doPayday()
		
		-- Declare variables and initiate them always outside of any loops when writing in C or any derivative or deviation.
		
		local randomFactor = math.random() -- Generate pseudo-random number.
		local roi = 0 			-- Declare and initiate local variable, for later use.
		local paydayMoney = 0	-- Declare and initiate local variable, for later use.
		local teamIndex = 0		-- Declare and initiate local variable, for later use.
		
		for key, ply in pairs(player.GetAll()) do 	-- Iterate over every player in the server.
		
			-- Calculate.
		
			teamIndex = ply:Team()
			roi = ply:GetNWFloat( "moneyROI" ) -- Gets the players rate of interest.
			
			if (teamIndex != nil and GetConVar("money_distinguish_teams"):GetBool() == true) then -- Differentiate teams.
				if (teamIndex == 0) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team0"):GetInt())/100))
				elseif (teamIndex == 1) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team1"):GetInt())/100))
				elseif (teamIndex == 2) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team2"):GetInt())/100))
				elseif (teamIndex == 3) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team3"):GetInt())/100))
				elseif (teamIndex == 4) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team4"):GetInt())/100))
				elseif (teamIndex == 5) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team5"):GetInt())/100))
				elseif (teamIndex == 6) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team6"):GetInt())/100))
				elseif (teamIndex == 7) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team7"):GetInt())/100))
				elseif (teamIndex == 8) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team8"):GetInt())/100))
				elseif (teamIndex == 9) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team9"):GetInt())/100))
				else
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*3.1))*(1.0+(roi/100.0)))
				end
			else
				paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*3.1))*(1.0+(roi/100.0)))
			end
			
			-- Make sure that payday always gives out at least 10$.
			
			if (paydayMoney < 11) then 
				paydayMoney = 10
			end
			
			-- Decrease fame.
		
			ply:fame_interact(0, math.ceil(paydayMoney/99))
			
			-- Reward Admins.
			
			if ( ply:IsAdmin() or ply:IsSuperAdmin() or ply:IsUserGroup( "server owner" ) or ply:IsUserGroup( "serverowner" ) or ply:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher
				paydayMoney = paydayMoney + math.ceil(math.random(11,33))
			end
			
			-- Give money.
		
			ply:money_give(paydayMoney)
		
			-- Notify, if available.
		
			if (ply:GetInfoNum( "money_notifications", 1 ) == 1) then -- Retrieve clientsided variable value and check if it is 1 (true).
					
				ply:roi_interact(1, 0.01)
				
				if (randomFactor < 0.34) then -- Generate two announcements for more variety.
					ply:PrintMessage( HUD_PRINTTALK, ">> Payday! You made " .. paydayMoney .. "$!") -- Print to chat.
				else
					ply:PrintMessage( HUD_PRINTTALK, ">> Payday! You were paid " .. paydayMoney .. "$.") -- Print to chat.
				end

			end
			
		end
		
	end

	
	-- BASIC BOUNTY FUNCTION
	
	local bountyStatus = false
	
	function doBounty()
		
		-- Declare variables and initiate them always outside of any loops when writing in C or any derivative or deviation.
		
		if (#player.GetHumans() >= 2 and bountyStatus != true) then
			
			local plyBounty = 0
			local bountyTarget = nil
			local bountyPrice = 1
		
			for key, ply in pairs(player.GetAll()) do -- Iterate over every player in the server.
				if (ply:GetNWInt( "bountyFame" ) >= plyBounty and ply:HasGodMode() != true and ply:TimeConnected() > 25 and ply:IsFrozen() != true and ply:Alive() == true) then
					plyBounty = ply:GetNWInt( "bountyFame" )
					bountyTarget = ply
					bountyPrice = (math.ceil((ply:GetNWInt( "money" )/(math.ceil(math.random(4,8))))+(ply:GetNWInt( "bountyFame" )*1.25)+math.random(-1,32)))
				end
			end			
			
			if (bountyTarget == nil) then
				bountyTarget = ply:GetByID(1)
				bountyPrice = 16
			end
			
			if (bountyPrice > settings['payday_amount']*4) then
				bountyPrice = math.floor((settings['payday_amount']*math.random(3.33,4.44))+math.random(-2.22,5.55))
			elseif (bountyPrice < 16) then
				bountyPrice = 16
			end
			
			bountyStatus = true
			
			bountyTarget:SetNWBool( "isHunted", true )
			bountyTarget:SetNWInt( "bountyPrice", bountyPrice)
			
			timer.Simple( 59, function()
			
				if (bountyStatus == false) then
					
					for key, ply in pairs(player.GetAll()) do
						ply:SetNWBool( "isHunted", false )
						ply:SetNWInt( "bountyPrice", 0 )
					end
					
				else
				
					bountyStatus = false
					
					for key, ply in pairs(player.GetAll()) do
						if (ply:GetInfoNum( "money_notifications", 1 ) == 1) then
								ply:PrintMessage( HUD_PRINTTALK, ">> Bounty unclaimed.") -- Tell them what happened.
						end
						ply:SetNWBool( "isHunted", false )
						ply:SetNWInt( "bountyPrice", 0 )
					end
					
				end
				
			end)
			
		else
			return
		end
		
	end
	
	hook.Add("PlayerDeath", "SMSBountyEvent", function(victim, inflictor, killer)
				if (bountyStatus == true) then
					if (victim != killer and victim:GetNWBool("isHunted") == true and victim:IsPlayer() == true and killer:IsPlayer() == true) then
						
						bountyStatus = false
						victim:SetNWBool( "isHunted", false )
						killer:money_give(victim:GetNWInt( "bountyPrice" ))
						killer:fame_interact(1, 6)
						killer:roi_interact(1, 0.01)
						victim:fame_interact(0, 7)
						
						if (killer:GetInfoNum( "money_notifications", 1 ) == 1) then
							killer:PrintMessage( HUD_PRINTTALK, ">> You claimed " .. victim:GetNWInt( "bountyPrice" ) .. "$ of bounty.") -- Tell them what happened.
						end
						
						for key, ply in pairs(player.GetAll()) do
							if ply != killer then
								if (ply:GetInfoNum( "money_notifications", 1 ) == 1) then
									ply:PrintMessage( HUD_PRINTTALK, ">> Bounty claimed!") -- Tell them what happened.
								end
							end
						end
						
					end
				end
			end)
	
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Systems Initialization and loop-through.  --
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	
	
	function systemsCheckInit( method )
	
		if (method == 0) then
		
			if (GetConVar("money_paydays"):GetBool() == true and GetConVar("money_freeze"):GetBool() == false) then -- If paydays are enabled then:
				if (timer.Exists( "paydayTimer" ) == false) then -- If timer does not exist.
					timer.Create( "paydayTimer" , settings['payday_time_interval'] , 0 ,  doPayday ) -- Create it.
				else -- We do not want to create timer if it exists to NOT reset it's time.
					return
				end
			else -- If paydays are disabled then: .. We don't have to check here if the timer exists, because only calling to remove is more resource efficient.
				timer.Remove( "paydayTimer" ) -- Remove timer for CPU's sake.
			end
			
		else
		
			if (GetConVar("money_bounty_system"):GetBool() == true and GetConVar("money_freeze"):GetBool() == false) then -- If Bounties are enabled then:
				if (timer.Exists( "bountyTimer" ) == false) then -- If timer does not exist.
					timer.Create( "bountyTimer" , settings['bounty_time_interval'] , 0 ,  doBounty ) -- Create it.
				else -- We do not want to create timer if it exists to NOT reset it's time.
					return
				end
			else -- If Bounties are disabled then: .. We don't have to check here if the timer exists, because only calling to remove is more resource efficient.
				timer.Remove( "bountyTimer" ) -- Remove timer for CPU's sake.
			end
			
		end
		
	end
		
	timer.Create( "paydayChecker" , 2 , 0 ,  function() systemsCheckInit(0) end) -- Add timer on start. Happens every 2 seconds, for efficiency's sake.
	timer.Create( "bountyChecker" , 2 , 0 ,  function() systemsCheckInit(1) end) -- Add timer on start. Happens every 2 seconds, for efficiency's sake.
	
	
	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	GIVE/TAKE (EYETRACE) FUNCTIONS
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Give Money to player @ CrosshairPos (In-Game).  --
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	
	
	function player_data:plyGiveMoney_Pos( amount )
		
		if (amount == nil or amount == error or tonumber(amount) <= 0) then
			self:PrintMessage( HUD_PRINTTALK, ">> Invalid values to transfer!" )
			return
		end
		
		if (GetConVar( "money_freeze" ):GetBool() != true) then
			
			local target = self:GetEyeTrace().Entity -- Get the entity the player is looking at.
			
			if target:IsPlayer() then -- If the entity is a player:
			
				-- Always make sure that Ints will be Ints - that's why there is flooring function.
			
				if ( self:money_enough(math.floor(tonumber(amount))) ) then	-- If the player has enough money, continue.
					target:money_give(math.floor(tonumber(amount))) 		-- Give money to the player they are looking at.
					self:money_take(math.floor(tonumber(amount)))			-- Take money from the player.
					self:PrintMessage( HUD_PRINTTALK, ">> Transferred " .. math.floor(amount) .. "$ to " .. target:Nick() .. ".") -- Print to chat.
					target:PrintMessage( HUD_PRINTTALK, ">> " .. self:Nick() .. " paid you " .. math.floor(amount) .. "$.") 	 -- Print to target chat.
					
					self:roi_interact(1, 0.07)
					self:fame_interact(0, 9)
				else
					self:PrintMessage( HUD_PRINTTALK, ">> You do not have enough money!" ) -- If the player does not have enough money print it to chat.
				end
			else
				self:PrintMessage( HUD_PRINTTALK, ">> Please aim at a player." ) -- If the player is not aiming at player print to chat.
			end
		
		else
			self:PrintMessage( HUD_PRINTTALK, ">> Transaction rejected due to bank accounts being frozen." )
		end
		
	end

-- Creating the console command for func plyGiveMoney_Pos
	function plyGiveMoney_CC1( client, command, arguments )
		client:plyGiveMoney_Pos(arguments[1])
	end
concommand.Add("money_give", plyGiveMoney_CC1, nil, "Used to give a certain amount of money to player at crosshair position. Args: <amount>") -- Name of command, func callback, nil, help info.


	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Give Money to player with given ID (In-Game).   --
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	
	
	function player_data:plyGiveMoney_ID( playerid, amount )
				
		if (amount == nil or playerid == nil or tonumber(playerid) < 0 or playerid == error or amount == error or tonumber(amount) <= 0) then
			self:PrintMessage( HUD_PRINTCONSOLE, " Invalid values!" )
			self:ConCommand("help money_transfer")
			return
		end
		
		if (GetConVar( "money_freeze" ):GetBool() != true) then
		
			if ( player.GetByID( tonumber(playerid) ) != nil ) then
			
				if ( self:money_enough(math.floor(tonumber(amount))) ) then
					player.GetByID( tonumber(playerid) ):money_give( math.floor(tonumber(amount)) ) -- Give money to the player of index at playerid.
					self:money_take(math.floor(tonumber(amount)))									-- Take money from the player.
					self:PrintMessage( HUD_PRINTCONSOLE, " Transferred " .. math.floor(amount) .. "$ to " .. target:Nick() .. ".") -- Print to chat.
					player.GetByID( tonumber(playerid) ):PrintMessage( HUD_PRINTTALK, ">> " .. self:Nick() .. " paid you " .. math.floor(amount) .. "$.") -- Print to target chat.
					
					self:roi_interact(1, 0.03)
					self:fame_interact(0, 3)
				else
					self:PrintMessage( HUD_PRINTCONSOLE, " You do not have enough money!" ) -- If the player does not have enough money print it to chat.
				end
			
			else
				self:PrintMessage( HUD_PRINTCONSOLE, " Player not found!" )
			end
			
		else
			self:PrintMessage( HUD_PRINTCONSOLE, " Transaction rejected due to bank accounts being frozen." )
		end
		
	end
	
-- Creating the console command for func plyGiveMoney_ID
	function plyGiveMoney_CC2( client, command, arguments )
		client:plyGiveMoney_ID(arguments[1], arguments[2])
	end
concommand.Add("money_transfer", plyGiveMoney_CC2, nil, "Used to give a certain amount of money to player with given ID. Args: <id,amount>") -- Name of command, func callback, nil, help info.


	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Take money from (mug) player @ CrosshairPos (In-Game). 	--
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

	
	function player_data:plyMug_Pos( amount )
		
		if (amount == nil or amount == error or tonumber(amount) <= 0) then
			self:PrintMessage( HUD_PRINTTALK, ">> Invalid values to perform action!" )
			return
		end
		
		if (GetConVar( "money_freeze" ):GetBool() != true) then
		
			if (GetConVar("spc_mugging"):GetBool() == true) then -- If robbing is allowed, continue.
				
				local randomfactor = math.random()*2.0 		-- Generate pseudo-random number for success factor.
				local target = self:GetEyeTrace().Entity 	-- Get the entity the player is looking at.
				
				if ( target:IsPlayer() ) then -- If the entity is a player:
				
					if ( target:GetNWBool( "antitheftEq" ) == false ) then
					
						self:roi_interact(0, 0.05)
					
						if (tonumber(amount) > (math.floor(2.34*settings['payday_amount']))) then
						
							self:PrintMessage( HUD_PRINTTALK, ">> You can't rob this much.") -- Print info to self.
							
						else
							if target:money_enough(math.floor(tonumber(amount))) then -- If the TARGET player has enough money, continue.
								
								if (tonumber(amount) <= math.floor(0.67*settings['payday_amount'])) then -- Not much money, high probability.
									
									
									if (randomfactor < 1.00) then -- Success in theft
									
										target:money_take(math.floor(tonumber(amount))-1)	-- Rob player (take their money).
										self:money_give(math.floor(tonumber(amount)))		-- Give money to self.
										self:PrintMessage( HUD_PRINTTALK, ">> You successfully robbed " .. target:Nick() .. " for " .. math.floor(tonumber(amount)) .. "$!") -- Print info to chat.
										
										self:fame_interact(1, 16)
										target:fame_interact(0, 2)
										
										for key, ply in pairs(player.GetAll()) do -- Iterate over every player in the server.
											ply:PrintMessage( HUD_PRINTTALK, ">> Someone's been robbed!") -- Let them know.
										end
										
									elseif (randomfactor > 1.88) then -- Epic fail in theft, they know you tried to rob them.
									
										self:roi_interact(0, 0.02)
										self:PrintMessage( HUD_PRINTTALK, ">> " .. target:Nick() .. " spotted your criminal action!")	-- Print info to self.
										target:PrintMessage( HUD_PRINTTALK, ">> Player " .. self:Nick() .. " tried to rob you!")	-- Let them know.
									
										self:fame_interact(1, 6)
									
									else -- You didn't manage to rob them.
										self:PrintMessage( HUD_PRINTTALK, ">> You didn't manage to rob " .. target:Nick() .. ".") -- Print info to self.
										self:fame_interact(1, 1)
									end
							
								elseif (tonumber(amount) > math.floor(0.67*settings['payday_amount']) and tonumber(amount) <= math.floor(1.67*settings['payday_amount'])) then -- Medium money, medium probability.
									
									if (randomfactor < 0.84) then -- Success in theft
										
										target:money_take(math.floor(tonumber(amount))-1)	-- Rob player (take their money).
										self:money_give(math.floor(tonumber(amount)))		-- Give money to self.
										self:PrintMessage( HUD_PRINTTALK, ">> You successfully robbed " .. target:Nick() .. " for " .. math.floor(tonumber(amount)) .. "$!") -- Print info to chat.
										
										self:fame_interact(1, 25)
										target:fame_interact(0, 6)
										
										for key, ply in pairs(player.GetAll()) do -- Iterate over every player in the server.
											ply:PrintMessage( HUD_PRINTTALK, ">> Someone's been robbed!") -- Let them know.
										end
										
									elseif (randomfactor > 1.66) then -- Epic fail in theft, they know you tried to rob them
										
										self:roi_interact(0, 0.01)
										self:PrintMessage( HUD_PRINTTALK, ">> " .. target:Nick() .. " spotted your criminal action!")	-- Print info to self.
										target:PrintMessage( HUD_PRINTTALK, ">> Player " .. self:Nick() .. " tried to rob you!")	-- Let them know.
									
										self:fame_interact(1, 10)
									
									else -- You didn't manage to rob them.
										self:PrintMessage( HUD_PRINTTALK, ">> You didn't manage to rob " .. target:Nick() .. ".") -- Print info to self.
										self:fame_interact(1, 1)
									end
								
								else -- Loads of money, low probability.
									
									if (randomfactor < 0.66) then -- Success in theft
										
										target:money_take(math.floor(tonumber(amount))-1)	-- Rob player (take their money).
										self:money_give(math.floor(tonumber(amount)))		-- Give money to self.
										self:PrintMessage( HUD_PRINTTALK, ">> You successfully robbed " .. target:Nick() .. " for " .. math.floor(tonumber(amount)) .. "$!") -- Print info to chat.
										
										self:fame_interact(1, 39)
										target:fame_interact(0, 10)
										
										for key, ply in pairs(player.GetAll()) do -- Iterate over every player in the server.
											ply:PrintMessage( HUD_PRINTTALK, ">> Someone's been robbed!") -- Let them know.
										end
										
									elseif (randomfactor > 1.44) then -- Epic fail in theft, they know you tried to rob them
									
										self:PrintMessage( HUD_PRINTTALK, ">> " .. target:Nick() .. " spotted your criminal action!")	-- Print info to self.
										target:PrintMessage( HUD_PRINTTALK, ">> Player " .. self:Nick() .. " tried to rob you!")	-- Let them know.
									
										self:fame_interact(1, 17)
									
									else -- You didn't manage to rob them.
										self:PrintMessage( HUD_PRINTTALK, ">> You didn't manage to rob " .. target:Nick() .. ".") -- Print info to self.
										self:fame_interact(1, 1)
									end
								
								end						
								
							else
								self:PrintMessage( HUD_PRINTTALK, ">> Something pushes you away from commiting this crime." ) -- If the player does not have enough money print it to chat.
							end
							
						end
					
					else
						self:PrintMessage( HUD_PRINTTALK, ">> They are protected with Anti-Theft Module." ) -- If the player is not aiming at player print to chat.
					end
					
				else
					self:PrintMessage( HUD_PRINTTALK, ">> Please aim at a player." ) -- If the player is not aiming at player print to chat.
				end
			
			else -- If robbing is not allowed, print to chat.
			
				self:PrintMessage( HUD_PRINTTALK, ">> Mugging is not possible for now." )
				
			end
		
		else
			self:PrintMessage( HUD_PRINTTALK, ">> Action cancelled due to bank accounts being frozen." )
		end
		
	end
	
-- Creating the console command for func plyMug_Pos
function plyMug_CC( client, command, arguments )
		client:plyMug_Pos(arguments[1])
	end
concommand.Add("money_steal", plyMug_CC, nil, "Used to steal given amount from a player at crosshair pos. Args: <amount>") -- Name of command, func callback, nil, help info.


	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Threat player @ CrosshairPos (In-Game). 	 --
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	
	
	function player_data:plyThreat_Pos()
		
		if (GetConVar("spc_threatening"):GetBool() == true) then -- If robbing is allowed, continue.
			
			local randomfactor = math.random()*2.0 		-- Generate pseudo-random number for success factor.
			local target = self:GetEyeTrace().Entity 	-- Get the entity the player is looking at.
			
			if ( target:IsPlayer() ) then -- If the entity is a player:
			
				self:roi_interact(0, 0.05)
				target:roi_interact(0, 0.03)
				
				local money = (math.floor(settings['payday_amount']/10.1 + randomfactor*10.1))
			
				sound.Play( "physics/glass/glass_sheet_break3.wav", target:GetPos() )
			
				if (randomfactor < 0.66) then -- Success in theft.
				
					target:money_take_absolute(money) -- Rob player (take their money).
					self:money_give(money) -- Give money to self.
					self:PrintMessage( HUD_PRINTTALK, ">> You threatened " .. target:Nick() .. "!") -- Print info to chat.
					target:PrintMessage( HUD_PRINTTALK, ">> You were threarened by " .. self:Nick() .. "!")
					
					self:fame_interact(1, 20)
					target:fame_interact(0, 8)
					
					if (randomfactor < 0.33) then
						target:ConCommand( "weapon_drop" )
					end
					
					target:SendLua( "RunConsoleCommand( \"act\", \"zombie\" )" )
					
					timer.Simple( 2.5, function() 
							if (target:Alive() == true) then
								target:ConCommand( "weapon_drop" )
								target:SendLua( "RunConsoleCommand( \"act\", \"zombie\" )" )
							end
						end)
					
				elseif (randomfactor > 1.55) then -- Partial success.
				
					self:PrintMessage( HUD_PRINTTALK, ">> You threatened " .. target:Nick() .. "!") -- Print info to chat.
					target:PrintMessage( HUD_PRINTTALK, ">> You were threatened by " .. self:Nick() .. "!")
					
					self:fame_interact(1, 15)
					target:fame_interact(0, 6)
					
					if (randomfactor > 1.80) then
						target:SendLua( "RunConsoleCommand( \"act\", \"zombie\" )" )
					else
						target:ConCommand( "weapon_drop" )
						timer.Simple( 0.5, function() 
								if (target:Alive() == true) then
									target:ConCommand( "weapon_drop" )
								end
							end)
					end
				
				else -- You didn't manage to rob them.
				
					self:PrintMessage( HUD_PRINTTALK, ">> You didn't manage to threaten " .. target:Nick() .. "!") -- Print info to self.
					self:fame_interact(0, 1)
					target:fame_interact(1, 7)
					
				end
				
			else
				self:PrintMessage( HUD_PRINTTALK, ">> Please aim at a player." ) -- If the player is not aiming at player print to chat.
			end
			
		else -- If robbing is not allowed, print to chat.
		
			self:PrintMessage( HUD_PRINTTALK, ">> Calm down, will ya?" )
			
		end
	
	end
	
-- Creating the console command for func plyMug_Pos
function plyThreat_CC( client, command, arguments )
		client:plyThreat_Pos()
	end
concommand.Add("money_threaten", plyThreat_CC, nil, "Used to threat a player at crosshair pos. Args: <>") -- Name of command, func callback, nil, help info.


	-- -- -- -- -- -- -- -- -- -- -- -- --
	-- Weapon unbuy / drop (In-Game).   --
	-- -- -- -- -- -- -- -- -- -- -- -- --
	
	
	function player_data:plyWeaponAction( method )
	
		local currentWep = self:GetActiveWeapon()
		
		if !(currentWep and IsValid(currentWep)) then 
			return
		elseif (method == 0 and GetConVar( "spc_weapon_unbuying"):GetBool() == false) then
			self:PrintMessage( HUD_PRINTTALK , ">> You cannot sell weapons." )
			return
		elseif (method == 0 and GetConVar( "money_freeze"):GetBool() == true) then
			self:PrintMessage( HUD_PRINTTALK, ">> Transaction rejected due to bank accounts being frozen." )
			return
		elseif (method == 1 and (GetConVar( "spc_weapon_dropping"):GetBool() == false or GetConVar( "sbox_weapons" ):GetInt() == 0)) then
			self:PrintMessage( HUD_PRINTTALK , ">> You cannot drop weapons for safety reasons." )
			return
		end
		
		local retCost = 0

		if (table.HasValue(free_weapons, currentWep:GetClass()) and GetConVar("money_defaultweaponsforfree"):GetBool() == true) then
			self:fame_interact(0, 1)
			retCost = 1
		elseif (table.HasValue(true_weapons, currentWep:GetClass()) and GetConVar("money_defaultweaponsforfree"):GetBool() == false) then
			self:fame_interact(0, 1)
			retCost = 2
		else

			local wgt = 0
			local app = 0
			
			if (currentWep:GetWeight() != nil) then
				if (currentWep:GetWeight() > (spawncosts['weapon']*0.75)) then
					wgt = (spawncosts['weapon']*0.75)
				else
					wgt = currentWep:GetWeight()
				end
			else
				wgt = 0
			end
			
			if (string.match( currentWep:GetClass() , 'm9k_.-') != nil or string.match( currentWep:GetClass() , 'gdcw_.-') != nil) then
				app = spawncosts['m9k_gdcw_app']
			elseif (string.match( currentWep:GetClass() , 'fas_.-') != nil or string.match( currentWep:GetClass() , 'fas2_.-') != nil or string.match( currentWep:GetClass() , 'fas20_.-') != nil) then
				app = spawncosts['fas2_app']
			elseif (string.match( currentWep:GetClass() , 'cw20_.-') != nil or string.match( currentWep:GetClass() , 'cw2_.-') != nil or string.match( currentWep:GetClass() , 'cw_.-') != nil) then
				app = spawncosts['cw20_app']
			elseif (string.match( currentWep:GetClass() , 'q3_.-') != nil or string.match( currentWep:GetClass() , 'q3a_.-') != nil) then
				app = spawncosts['q3_app']
			elseif (string.match( currentWep:GetClass() , 'cs_.-') != nil or string.match( currentWep:GetClass() , 'ttt_.-') != nil or string.match( currentWep:GetClass() , 'rp_.-') != nil or string.match( currentWep:GetClass() , 'dod_.-') != nil or string.match( currentWep:GetClass() , 'ww2_.-') != nil) then
				app = spawncosts['cs_ttt_rp_dod_app']
			elseif (string.match( currentWep:GetClass() , 'eq_.-') != nil or string.match( currentWep:GetClass() , 'gmod_.-') != nil or string.match( currentWep:GetClass() , 'stranded_.-') != nil) then
				app = spawncosts['eq_gmod_stranded_app']
			else
				app = 0
			end
			
			retCost = (spawncosts['weapon']+wgt+app-6)
			self:roi_interact(1, 0.08)
			self:fame_interact(1, 2)
			
		end
		
		if ( method == 0 ) then -- Method 0 is sell weapon.
		
			self:money_give(math.floor(retCost*(math.abs(GetConVar("money_multiplier_spawncost_swep"):GetFloat()))))
			self:StripWeapon(currentWep:GetClass())
			
		else -- Method 1 (or not 0) is drop weapon.

			self:money_give(math.floor(1.23*(math.abs(GetConVar("money_multiplier_spawncost_swep"):GetFloat()))))
			
			local newWeapon = ents.Create(currentWep:GetClass())
		 
			newWeapon:SetClip1(currentWep:Clip1())
			newWeapon:SetClip2(currentWep:Clip2())

			self:StripWeapon(currentWep:GetClass())

			newWeapon:SetPos(self:GetShootPos() + (self:GetAimVector() * 80) + Vector(0,0,1))

			newWeapon:Spawn()
			
			newWeapon:SetVelocity((self:GetAimVector() * 150) + ((Vector(0,0,1):Cross(self:GetAimVector())):GetNormalized() * (math.random(0, 80))))
			
		end
		
	end
	
-- Creating the console command for funcs plyWeaponAction

function plyWeaponUnbuy_CC( client, command, arguments )
		client:plyWeaponAction( 0 )
	end
concommand.Add("weapon_sell", plyWeaponUnbuy_CC, nil, "Used to sell currently held weapon. Args: <>") -- Name of command, func callback, nil, help info.

function plyWeaponDrop_CC( client, command, arguments )
		client:plyWeaponAction( 1 )
	end
concommand.Add("weapon_drop", plyWeaponDrop_CC, nil, "Used to drop currently held weapon. Args: <>") -- Name of command, func callback, nil, help info.


	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	CHAT COMMANDS
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	function SMSChatCommands(ply, text)

		text = string.lower(text) -- Make the message sent lower case so the command is not case sensitive.
		text = string.Explode(" ", text) -- Explode the string into a table on every space.
										 -- We do this so we can get the arguments.

		if (text[1] == "!givemoney" or text[1] == "/givemoney") then 
			ply:plyGiveMoney_Pos(tonumber(text[2]))
			return "Transaction: Sent."	-- Do not display how much money someone transfered.
		elseif (text[1] == "!rob" or text[1] == "/rob") then
			ply:plyMug_Pos(tonumber(text[2]))
			return "" -- Do not display on chat what someone wrote.
		elseif (text[1] == "!mug" or text[1] == "/mug") then
			ply:plyMug_Pos(tonumber(math.floor(math.random(math.ceil(settings['payday_amount']/10),math.floor(settings['payday_amount']*1.9)))))
			return "" -- Do not display on chat what someone wrote.	
		elseif (text[1] == "!threaten" or text[1] == "/threaten") then
			ply:plyThreat_Pos()
			return "Hands up! On the ground, now!"
		elseif (text[1] == "!check" or text[1] == "/check") then
			ply:ConCommand( "money_check" )
			return ""
		elseif (text[1] == "!sellweapon" or text[1] == "/sellweapon") then
			ply:plyWeaponAction( 0 )
			return ""
		elseif (text[1] == "!dropweapon" or text[1] == "/dropweapon") then
			ply:plyWeaponAction( 1 )
			return "Hurgh!"
		end
	end
		
	hook.Add("PlayerSay", "SMSChatCommands", SMSChatCommands) -- Hook into PlayerSay so the function is called every time a player makes a chat message. Clientside hook would be on OnPlayerChat.


	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	ADMIN COMMANDS. Remember, that concommands should do nothing if supplied with invalid amount of arguments or invalid variables.
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


	-- -- -- -- -- -- -- -- -- -- --
	-- Money Commands (In-Game).  --
	-- -- -- -- -- -- -- -- -- -- --

	
	-- GIVE/TAKE MONEY FROM PLAYER
	
	function player_data:adminInteractMoney_ID( method, playerid , amount )

		if (amount == nil or playerid == nil or tonumber(playerid) < 0 or playerid == error or tonumber(amount) <= 0) then
			if (method == 0) then
				self:ConCommand("help money_take_admin")
			else
				self:ConCommand("help money_give_admin")
			end
			return
		end
			
		if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher
			if (GetConVar( "money_freeze" ):GetBool() != true) then
				if ( player.GetByID( tonumber(playerid) ) != nil ) then
					if (method == 0) then
						player.GetByID( tonumber(playerid) ):money_take_absolute(math.floor(tonumber(amount))) -- Take money from the player of index at playerid.
						player.GetByID( tonumber(playerid) ):PrintMessage( HUD_PRINTTALK , ">> You lost " .. math.floor(tonumber(amount)) .. "$!")
						player.GetByID( tonumber(playerid) ):roi_interact(0, 0.09)
					else
						player.GetByID( tonumber(playerid) ):money_give( math.floor(tonumber(amount)) ) -- Give money to the player of index at playerid.
						player.GetByID( tonumber(playerid) ):PrintMessage( HUD_PRINTTALK, ">> You earned " .. math.floor(tonumber(amount)) .. "$!")
						player.GetByID( tonumber(playerid) ):roi_interact(1, (0.23+(math.ceil((((tonumber(amount))/(settings['payday_amount']))*0.005)*100)*0.01)))
					end
				else
					self:PrintMessage( HUD_PRINTCONSOLE, " Player not found!" )
				end
			else
					self:PrintMessage( HUD_PRINTCONSOLE, " Transaction rejected due to bank accounts being frozen." )
			end
		else
			self:PrintMessage( HUD_PRINTCONSOLE , " You are not allowed to use this command!" )
		end
			
	end

	function adminGiveMoney_CC( client, command, arguments ) -- Add console command.
		client:adminInteractMoney_ID(1, arguments[1], arguments[2])
	end
	concommand.Add("money_give_admin", adminGiveMoney_CC , nil, "Admin-only command used to give money to players with given ID. Args: <id,amount>")

	function adminTakeMoney_CC( client, command, arguments ) -- Add console command.
		client:adminInteractMoney_ID(0, arguments[1], arguments[2])
	end
	concommand.Add("money_take_admin", adminTakeMoney_CC, nil, "Admin-only command used to take money from players with given ID. Args: <id,amount>")


	-- CHECK MONEY, BEFORE YOU'LL DO ANYTHING
	function player_data:adminCheckMoney_ID( playerid )

			if (playerid == nil or tonumber(playerid) < 0 or playerid == error) then
				self:ConCommand("help money_check_admin")
				return
			end

			if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher
				if ( player.GetByID( tonumber(playerid) ) != nil ) then
					self:PrintMessage( HUD_PRINTCONSOLE, " Player's [" .. player.GetByID(tonumber(playerid)):Nick() .. "] bank account ballance is: " .. (tonumber(player.GetByID(tonumber(playerid)):GetNWInt( "money" ))) .. "$.\n")
				else
					self:PrintMessage( HUD_PRINTCONSOLE, " Player not found!" )
				end
			else
				self:PrintMessage( HUD_PRINTCONSOLE , " You are not allowed to use this command!" )
			end
		end

	function adminCheckMoney_CC1( client, command, arguments ) -- Add console command.
		client:adminCheckMoney_ID(arguments[1])
	end
	concommand.Add("money_check_admin", adminCheckMoney_CC1, nil, "Admin-only command used to check players' with given ID bank account ballance. Args: <id>")

	
	-- -- -- -- -- -- -- -- -- -- -- --
	-- For-All Commands (In-Game).	 --
	-- -- -- -- -- -- -- -- -- -- -- --
	
	
	-- CHECK ALL CONNECTED PLAYERS MONEY
	function player_data:adminCheckMoney_All()

		if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher

			local moneyAvg = 0
			local fameAvg = 0
			
			for key, ply in pairs(player.GetAll()) do -- Iterate over every player in the server.
				moneyAvg = moneyAvg + ply:GetNWInt( "money" )
				fameAvg = fameAvg + ply:GetNWInt( "bountyFame" )
			end	
				
			moneyAvg = (math.ceil((1.5+GetConVar("money_roi_maxoffset"):GetFloat())*(moneyAvg/(#player.GetAll()))))
			fameAvg = (math.ceil(4.5+fameAvg/(#player.GetAll())))
			
			local moneyStatus = ""
			local fameStatus = ""
			local roiStatus = ""
				
			for key, ply in pairs(player.GetAll()) do -- Iterate over every player in the server.
				
				if (ply:GetNWInt( "money" ) > moneyAvg) then
					moneyStatus = "(too much?) "
				elseif (ply:GetNWInt( "money" ) < settings['payday_amount']) then
					moneyStatus = "(not enough?) "
				else
					moneyStatus = ""
				end
				
				if (GetConVar( "money_bounty_system" ):GetBool() == true) then
					if (ply:GetNWInt( "bountyFame") > fameAvg) then
						fameStatus = "(suspicious?)"
					elseif (ply:GetNWInt( "bountyFame") < 33) then
						fameStatus = "(newcomer?)"
					else
						fameStatus = ""
					end
				else
					fameStatus = ""
				end
				
				if (GetConVar( "money_roi" ):GetBool() == true) then
					roiStatus = "ROI: [ " .. ply:GetNWFloat( "moneyROI" ) .. "]% ; "
				else
					roiStatus = ""
				end
				
				-- SteamID (Unused in Money System): [" .. ply:SteamID() .. "];
				self:PrintMessage( HUD_PRINTCONSOLE, "Connection ID: [" .. ply:EntIndex() .. "]; Playername: [" .. ply:Nick() .. "]; Balance: [" .. ply:GetNWInt( "money" ) .. "]$ " .. moneyStatus .. "; " .. roiStatus .. "Fame: [" .. ply:GetNWInt("bountyFame") .. "] " .. fameStatus .. ".")
			end	
					
		else
			self:PrintMessage( HUD_PRINTCONSOLE , " You are not allowed to use this command!" )
		end
	end

	function adminCheckMoney_CC2( client, command, arguments ) -- Add console command.
		client:adminCheckMoney_All()
	end
	concommand.Add("money_checkall", adminCheckMoney_CC2, nil, "Admin-only command used to list out players' money system significant info. Args: <>")

	
	-- RESET ALL PLAYERS MONEY TO STARTING AMOUNT
	function player_data:adminSetAccounts_All()
	
		if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher
			for key, ply in pairs(player.GetAll()) do -- Iterate over every player in the server.
				ply:SetNWInt( "bountyFame", math.ceil(ply:GetNWInt( "bountyFame" )/2))
				ply:SetNWInt( "moneyROI", (math.ceil(ply:GetNWInt( "moneyROI" )/2*100))/100)
				ply:SetPData( "money", GetConVar("money_starting"):GetInt() )
				ply:SetNWInt( "money", GetConVar("money_starting"):GetInt() )
				ply:PrintMessage( HUD_PRINTTALK , ">> Bank accounts have been reset to " .. GetConVar("money_starting"):GetInt() .. "$!" )
			end
		else
				self:PrintMessage( HUD_PRINTCONSOLE , " You are not allowed to use this command!" )
		end
	end

	function adminSetAccounts_CC( client, command, arguments ) -- Add console command.
		client:adminSetAccounts_All(arguments[1])
	end
	concommand.Add("money_setall", adminSetAccounts_CC, nil, "Admin-only command used to set all connected players money to Starting (Newcomers') Amount. Args: <>")

	
	-- RESET ALL TO DEFAULTS
	function player_data:adminResetToDefaults()

		if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher

			GetConVar( "money_starting" ):SetInt( GetConVar( "money_starting" ):GetDefault())
			GetConVar( "money_paydays" ):SetInt( GetConVar( "money_paydays" ):GetDefault())
			GetConVar( "money_spawncosts" ):SetInt( GetConVar( "money_spawncosts" ):GetDefault())
			GetConVar( "money_oninsufficient_respawn" ):SetInt( GetConVar( "money_oninsufficient_respawn" ):GetDefault())
			GetConVar( "money_freeze" ):SetInt( GetConVar( "money_freeze" ):GetDefault())
			GetConVar( "money_bounty_system" ):SetInt( GetConVar( "money_bounty_system" ):GetDefault())
			GetConVar( "money_roi" ):SetInt( GetConVar( "money_roi" ):GetDefault())
			GetConVar( "money_roi_maxoffset" ):SetFloat( GetConVar( "money_roi_maxoffset" ):GetDefault())
			GetConVar( "money_defaultweaponsforfree" ):SetInt( GetConVar( "money_defaultweaponsforfree" ):GetDefault())
			GetConVar( "money_distinguish_teams" ):SetInt( GetConVar( "money_distinguish_teams" ):GetDefault())
			
			GetConVar( "money_onkillplayer_steal" ):SetInt( GetConVar( "money_onkillplayer_steal" ):GetDefault())
			GetConVar( "money_onkillplayer_steal_fraction" ):SetFloat( GetConVar( "money_onkillplayer_steal_fraction" ):GetDefault())
			
			GetConVar( "money_multiplier_penalty" ):SetFloat( GetConVar( "money_multiplier_penalty" ):GetDefault())
			GetConVar( "money_multiplier_award" ):SetFloat( GetConVar( "money_multiplier_award" ):GetDefault())
			GetConVar( "money_multiplier_spawncost_npc" ):SetFloat( GetConVar( "money_multiplier_spawncost_npc" ):GetDefault())
			GetConVar( "money_multiplier_spawncost_swep" ):SetFloat( GetConVar( "money_multiplier_spawncost_swep" ):GetDefault())
			GetConVar( "money_multiplier_spawncost_vehicle" ):SetFloat( GetConVar( "money_multiplier_spawncost_vehicle" ):GetDefault())
			GetConVar( "money_multiplier_spawncost_sent" ):SetFloat( GetConVar( "money_multiplier_spawncost_sent" ):GetDefault())
			GetConVar( "money_multiplier_spawncost_prop" ):SetFloat( GetConVar( "money_multiplier_spawncost_prop" ):GetDefault())
			
			GetConVar( "npc_killcounter" ):SetInt( GetConVar( "npc_killcounter" ):GetDefault())
			
			GetConVar( "spc_mugging" ):SetInt( GetConVar( "spc_mugging" ):GetDefault())
			GetConVar( "spc_threatening" ):SetInt( GetConVar( "spc_threatening" ):GetDefault())
			GetConVar( "spc_weapon_unbuying" ):SetInt( GetConVar( "spc_weapon_unbuying" ):GetDefault())
			GetConVar( "spc_weapon_dropping" ):SetInt( GetConVar( "spc_weapon_dropping" ):GetDefault())
			
			settings['payday_amount'] = 505
			settings['payday_time_interval'] = 240
			settings['bounty_time_interval'] = 360
			
			GetConVar( "money_payday_percentage_team0" ):SetInt( GetConVar( "money_payday_percentage_team0" ):GetDefault())
			GetConVar( "money_payday_percentage_team1" ):SetInt( GetConVar( "money_payday_percentage_team1" ):GetDefault())
			GetConVar( "money_payday_percentage_team2" ):SetInt( GetConVar( "money_payday_percentage_team2" ):GetDefault())
			GetConVar( "money_payday_percentage_team3" ):SetInt( GetConVar( "money_payday_percentage_team3" ):GetDefault())
			GetConVar( "money_payday_percentage_team4" ):SetInt( GetConVar( "money_payday_percentage_team4" ):GetDefault())
			GetConVar( "money_payday_percentage_team5" ):SetInt( GetConVar( "money_payday_percentage_team5" ):GetDefault())
			GetConVar( "money_payday_percentage_team6" ):SetInt( GetConVar( "money_payday_percentage_team6" ):GetDefault())
			GetConVar( "money_payday_percentage_team7" ):SetInt( GetConVar( "money_payday_percentage_team7" ):GetDefault())
			GetConVar( "money_payday_percentage_team8" ):SetInt( GetConVar( "money_payday_percentage_team8" ):GetDefault())
			GetConVar( "money_payday_percentage_team9" ):SetInt( GetConVar( "money_payday_percentage_team9" ):GetDefault())
			
			GetConVar( "money_awards_percentage_team0" ):SetInt( GetConVar( "money_awards_percentage_team0" ):GetDefault())
			GetConVar( "money_awards_percentage_team1" ):SetInt( GetConVar( "money_awards_percentage_team1" ):GetDefault())
			GetConVar( "money_awards_percentage_team2" ):SetInt( GetConVar( "money_awards_percentage_team2" ):GetDefault())
			GetConVar( "money_awards_percentage_team3" ):SetInt( GetConVar( "money_awards_percentage_team3" ):GetDefault())
			GetConVar( "money_awards_percentage_team4" ):SetInt( GetConVar( "money_awards_percentage_team4" ):GetDefault())
			GetConVar( "money_awards_percentage_team5" ):SetInt( GetConVar( "money_awards_percentage_team5" ):GetDefault())
			GetConVar( "money_awards_percentage_team6" ):SetInt( GetConVar( "money_awards_percentage_team6" ):GetDefault())
			GetConVar( "money_awards_percentage_team7" ):SetInt( GetConVar( "money_awards_percentage_team7" ):GetDefault())
			GetConVar( "money_awards_percentage_team8" ):SetInt( GetConVar( "money_awards_percentage_team8" ):GetDefault())
			GetConVar( "money_awards_percentage_team9" ):SetInt( GetConVar( "money_awards_percentage_team9" ):GetDefault())
			
			for key, ply in pairs(player.GetAll()) do -- Iterate over every player in the server.
				ply:PrintMessage( HUD_PRINTCONSOLE , "[Sandbox Money System] Server: Reset settings to defaults." )
			end	
			
		else
			self:PrintMessage( HUD_PRINTCONSOLE , " You are not allowed to use this command!" )
		end
		
	end

	function adminResetToDefaults_CC( client, command, arguments ) -- Add console command.
		client:adminResetToDefaults()
	end
	concommand.Add("money_defaults", adminResetToDefaults_CC, nil, "Admin-only command to reset ALL options to default values. Args: <>")
	
	
	-- -- -- -- -- -- -- -- -- -- --
	-- Payday Commands (In-Game). --
	-- -- -- -- -- -- -- -- -- -- --

	
	--ADMIN PAYDAY AMOUNT
	function player_data:paydayAmount( amount )
	
		if (amount == nil or tonumber(amount) < 1) then
			self:ConCommand("help money_payday_amount")
		end
		
		if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher
			
			if (tonumber(amount) > 10) then
				settings['payday_amount'] = (math.ceil(tonumber(amount)))
				
				timer.Create( "paydayTimer" , settings['payday_time_interval'] , 0 ,  doPayday ) -- Create it.
				
			else -- You cannot set payday amount less than 1$ in-game.
				settings['payday_amount'] = 1
				
				timer.Create( "paydayTimer" , settings['payday_time_interval'] , 0 ,  doPayday ) -- Create it.
				
			end
		else
				self:PrintMessage( HUD_PRINTCONSOLE , " You are not allowed to use this command!" )
		end
	end

	function paydayAmount_CC( client, command, arguments ) -- Add console command.
		client:paydayAmount(arguments[1])
	end
	concommand.Add("money_payday_amount",  paydayAmount_CC, nil, "Admin-only command used to change payday cash amount. 500 by default. Args: <amount>")


	--ADMIN PAYDAY TIME INTERVAL
	function player_data:paydayTimeInterval ( amount )
	
		if (amount == nil or tonumber(amount) < 2) then
			self:ConCommand("help money_payday_time_interval")
			return
		end
	
		if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher.
			if (tonumber(amount) > 30) then
				settings['payday_time_interval'] = math.floor(tonumber(amount))
			
				timer.Create( "paydayTimer" , settings['payday_time_interval'] , 0 ,  doPayday ) -- Create it.
				
			else
				settings['payday_time_interval'] = 1 -- You cannot set the payday time interval less than a second in-game.
				
				timer.Create( "paydayTimer" , settings['payday_time_interval'] , 0 ,  doPayday ) -- Create it.
				
			end
		else
				self:PrintMessage( HUD_PRINTCONSOLE , " You are not allowed to use this command!" )
		end
	end

	function paydayTimeInterval_CC( client, command, arguments ) -- Add console command.
		client:paydayTimeInterval(arguments[1])
	end
	concommand.Add("money_payday_time_interval",  paydayTimeInterval_CC, nil, "Admin-only command used to change payday time interval (in seconds). Not less than 30 secs. 240 by default. Args: <amount>")

	
	-- -- -- -- -- -- -- -- -- -- -- --
	-- Bounties Commands (In-Game).  --
	-- -- -- -- -- -- -- -- -- -- -- --
	
	
	--ADMIN BOUNTY TIME INTERVAL
	function player_data:bountyTimeInterval ( amount )
	
		if (amount == nil or tonumber(amount) < 2) then
			self:ConCommand("help money_payday_time_interval")
			return
		end
	
		if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher.
			if (tonumber(amount) > 90) then
			
				settings['bounty_time_interval'] = math.floor(tonumber(amount))
			
				timer.Create( "bountyTimer" , settings['bounty_time_interval'] , 0 ,  doBounty ) -- Create it.
				
			else
			
				settings['bounty_time_interval'] = 90 -- You cannot set the payday time interval less than half a minute in-game.
				
				timer.Create( "bountyTimer" , settings['bounty_time_interval'] , 0 ,  doBounty ) -- Create it.
				
			end
		else
				self:PrintMessage( HUD_PRINTCONSOLE , " You are not allowed to use this command!" )
		end
	end

	function bountyTimeInterval_CC( client, command, arguments ) -- Add console command.
		client:bountyTimeInterval(arguments[1])
	end
	concommand.Add("money_bounty_time_interval",  bountyTimeInterval_CC, nil, "Admin-only command used to change bounty time interval (in seconds). Not less than 90 secs. 404 by default. Args: <amount>")


	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	KILLS AND DEATHS
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	-- MONEY ON KILL
	function addMoneyOnKillPlayer(victim, inflictor, killer) -- Function start:
	
		local money = 0
		local victimRoi = ((victim:GetNWFloat( "moneyROI" ))/10)
		
		if (victim == killer) then -- Check if victim and killer is the same person:
			
			victim:money_take_absolute(math.floor((settings['penalty_deathby_self']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat())))-victimRoi))
			victim:roi_interact(0, 0.29)
			victim:fame_interact(0, 7)
		
		elseif (killer:IsPlayer() and (victim != killer)) then -- Check if killer is player and is not the same player as victim:

			if (GetConVar("money_onkillplayer_steal"):GetBool() == true) then
			
				money = (math.floor(((tonumber(victim:GetNWInt( "money" ))*(math.abs(GetConVar("money_onkillplayer_steal_fraction"):GetFloat()))*(math.abs(GetConVar("money_multiplier_award"):GetFloat()))))+((killer:GetNWFloat( "moneyROI" ))/11)))
			
				if (victim:GetNWInt( "antitheftEq" ) == true) then
					money = math.ceil(money/4)+1
				end
			
				killer:money_give(money) -- Award the killer
				killer:roi_interact(1, 0.06)
				killer:fame_interact(1, 6)
				
				if (killer:GetInfoNum( "money_notifications", 1 ) == 1) then
					killer:PrintMessage( HUD_PRINTTALK, ">> You earned " .. money .. "$ for killing " .. victim:Nick() .. "!") -- Tell them what happened.
				end
				
				money = math.floor((money*0.98)-victimRoi)
				
				victim:money_take_absolute(money) -- Rob the victim
				victim:roi_interact(0, 0.05)
				victim:fame_interact(0, 3)
				
				if (victim:GetInfoNum( "money_notifications", 1 ) == 1) then
					if (victim:GetNWInt( "antitheftEq" ) == true) then
						victim:PrintMessage( HUD_PRINTTALK, ">> With [Anti-Theft Module] you lost " .. money .. "$.") -- Tell them what happened.
					else
							victim:PrintMessage( HUD_PRINTTALK, ">> You lost " .. money .. "$.") -- Tell them what happened.
					end
				end
			
			else
				
				local teamIndex = killer:Team()
				
				if (teamIndex != nil and GetConVar( "money_distinguish_teams" ):GetBool() != false) then
					if (tonumber(teamIndex) == 0) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team0"))/100))
					elseif (tonumber(teamIndex) == 1) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team1"))/100))
					elseif (tonumber(teamIndex) == 2) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team2"))/100))
					elseif (tonumber(teamIndex) == 3) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team3"))/100))
					elseif (tonumber(teamIndex) == 4) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team4"))/100))
					elseif (tonumber(teamIndex) == 5) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team5"))/100))
					elseif (tonumber(teamIndex) == 6) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team6"))/100))
					elseif (tonumber(teamIndex) == 7) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team7"))/100))
					elseif (tonumber(teamIndex) == 8) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team8"))/100))
					elseif (tonumber(teamIndex) == 9) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team9"))/100))
					else
						money = (math.floor((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1))
					end
				else
					money = (math.floor((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1))
				end
					
					
				killer:money_give(money) -- Award the killer
				killer:roi_interact(1, 0.06)
				killer:fame_interact(1, 6)
				
				if (killer:GetInfoNum( "money_notifications", 1 ) == 1) then
					killer:PrintMessage( HUD_PRINTTALK, ">> You earned " .. money .. "$ for killing " .. victim:Nick() .. "!") -- Tell them what happened.
				end
				
				money = (math.floor((settings['penalty_deathby_player']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat())))+killer:Deaths()-victimRoi))
			
				victim:money_take_absolute(money) -- Penalty for victim
				victim:roi_interact(0, 0.05)
				victim:fame_interact(0, 3)
				
				if (victim:GetInfoNum( "money_notifications", 1 ) == 1) then
					victim:PrintMessage( HUD_PRINTTALK, ">> You lost " .. money .. "$.") -- Tell them what happened.
				end
			
			end
		
		else -- If the source of player death is different, it is some sort of entity (world/sent/veh/npc/prop):
			
			if (killer:IsPlayer() == true) then
				victim:fame_interact(1, 2)
			end
			
			victim:money_take_absolute(math.floor((settings['penalty_deathby_entity']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat())))-victimRoi))
			victim:roi_interact(0, 0.04)
			victim:fame_interact(0, 4)
		
		end
		
		if (GetConVar("money_oninsufficient_respawn"):GetBool() == false and victim:money_enough(math.floor(settings['penalty_respawn']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat())))) == false) then
			victim:PrintMessage( HUD_PRINTTALK, ">> You'll NOT be able to spawn for now because of insufficient funds.")
		end
		
	end
	hook.Add("PlayerDeath", "addMoneyOnKillPlayer", addMoneyOnKillPlayer)
	
	
	-- MONEY AWARDED WHEN KILLED AN NPC
	function addMoneyOnKillNPC( npc, attacker, inflictor) -- Function that awards players for killing NPCs:
		
		if (attacker:IsPlayer() and IsValid( attacker )) then
		
			local randomFactor = (math.random()*3.0)
			local roi = attacker:GetNWFloat( "moneyROI" ) -- Gets the players rate of interest.
			local mp = 1.0
			local teamIndex = attacker:Team()
				
				if (teamIndex != nil and GetConVar( "money_distinguish_teams" ):GetBool() != false) then
					if (tonumber(teamIndex) == 0) then
						mp = (math.abs(GetConVar("money_awards_percentage_team0"))/100)
					elseif (tonumber(teamIndex) == 1) then
						mp = (math.abs(GetConVar("money_awards_percentage_team1"))/100)
					elseif (tonumber(teamIndex) == 2) then
						mp = (math.abs(GetConVar("money_awards_percentage_team2"))/100)
					elseif (tonumber(teamIndex) == 3) then
						mp = (math.abs(GetConVar("money_awards_percentage_team3"))/100)
					elseif (tonumber(teamIndex) == 4) then
						mp = (math.abs(GetConVar("money_awards_percentage_team4"))/100)
					elseif (tonumber(teamIndex) == 5) then
						mp = (math.abs(GetConVar("money_awards_percentage_team5"))/100)
					elseif (tonumber(teamIndex) == 6) then
						mp = (math.abs(GetConVar("money_awards_percentage_team6"))/100)
					elseif (tonumber(teamIndex) == 7) then
						mp = (math.abs(GetConVar("money_awards_percentage_team7"))/100)
					elseif (tonumber(teamIndex) == 8) then
						mp = (math.abs(GetConVar("money_awards_percentage_team8"))/100)
					elseif (tonumber(teamIndex) == 9) then
						mp = (math.abs(GetConVar("money_awards_percentage_team9"))/100)
					else
						mp = 1.0
					end
				else
					mp = 1.0
				end
				
			if (	table.HasValue(npc_small, npc:GetClass())) then 	-- Handle npcs listed in "npc_small" group.
				attacker:money_give(math.floor((settings['award_on_killnpc_small']*(math.abs(GetConVar("money_multiplier_award"):GetFloat()))+(roi/11))*mp))
				attacker:roi_interact(1, 0.07)
				attacker:fame_interact(1, 5)
				
				if (attacker:GetInfoNum( "money_notifications", 1 ) == 1) then
					attacker:PrintMessage( HUD_PRINTTALK, ">> You earned some money.")
				end
				
			elseif (table.HasValue(npc_big, npc:GetClass())) then 		-- Handle npcs listed in "npc_big" group.
				attacker:money_give(math.floor(((settings['award_on_killnpc_big']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+randomFactor+(roi/9))*mp))
				attacker:roi_interact(1, 0.75)
				attacker:fame_interact(1, 23)
				
				if (attacker:GetInfoNum( "money_notifications", 1 ) == 1) then
					attacker:PrintMessage( HUD_PRINTTALK, ">> You earned some proper money." )
				end
				
			elseif (table.HasValue(npc_ultrabig, npc:GetClass())) then 	-- Handle npcs listed in "npc_big" group.
				attacker:money_give(math.floor(((settings['award_on_killnpc_ultrabig']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+randomFactor+(roi/8))*mp))
				attacker:roi_interact(1, 5.0)
				attacker:fame_interact(1, 75)
				
				if (attacker:GetInfoNum( "money_notifications", 1 ) == 1) then
					attacker:PrintMessage( HUD_PRINTTALK, ">> You earned some badass money!")
				end
				
			elseif (table.HasValue(npc_friendly, npc:GetClass())) then 	-- Handle npcs listed in "npc_friendly" group.
				attacker:money_give(math.floor((settings['award_on_killnpc_friendly']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))*mp))
				attacker:roi_interact(0, 0.16)
				attacker:fame_interact(1, 3)
				
				if (attacker:GetInfoNum( "money_notifications", 1 ) == 1) then
					attacker:PrintMessage( HUD_PRINTTALK, ">> You earned some blood money.")
				end
				
			else														-- Handle unlisted npcs.
				attacker:money_give(math.floor(((settings['award_on_killnpc_else']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+randomFactor+(roi/10))*mp))
				attacker:roi_interact(1, 0.40)
				attacker:fame_interact(1, 11)
				
				if (attacker:GetInfoNum( "money_notifications", 1 ) == 1) then
					attacker:PrintMessage( HUD_PRINTTALK, ">> You made some money.")
				end
				
			end
			
			-- NPC KILLCOUNTER
			if (GetConVar("npc_killcounter"):GetBool() == true) then	-- If npc killcounter is enabled, then add frags on npc killed.
				attacker:AddFrags(1)
			else 
				return
			end
		end
	end
	hook.Add("OnNPCKilled", "addMoneyOnKillNPC", addMoneyOnKillNPC)

			
	-- MONEY LOST ON RESPAWN
		function loseMoneyOnRespawn( ply )
			ply:money_take(math.floor(settings['penalty_respawn']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat()))))  -- Take money from respawning player
			ply:PrintMessage( HUD_PRINTCONSOLE , " You lost " .. math.floor(settings['penalty_respawn']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat()))) .. "$ on respawn.") -- Log it in simple form in console
		end
		hook.Add("PlayerSpawn", "loseMoneyOnRespawn", loseMoneyOnRespawn) -- Add hook
	
	
	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	PLAYER RESPAWN TOGGLER; enabler or disabler of playerspawns when their bank account has less money than the cost of respawn. See concommand below in ADMIN MISC COMMANDS.
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	function togglePlayerSpawn( ply )
		if (GetConVar("money_oninsufficient_respawn"):GetBool() == true or ply:money_enough(math.floor(settings['penalty_respawn']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat()))+0.1)) == true) then
			return -- YOU HAVE TO RETURN NULL, returning true will result in ALWAYS true.
		elseif (GetConVar("money_oninsufficient_respawn"):GetBool() == false and ply:money_enough(math.floor(settings['penalty_respawn']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat())))) == false) then
			return false
		end
	end
	hook.Add("PlayerDeathThink", "togglePlayerSpawn", togglePlayerSpawn)
	


--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	SPAWNING PENALTIES
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	function toggleSpawncosts()
		
		if (GetConVar("money_spawncosts"):GetBool() == true) then -- If func takes true, add hooks (hook up script functions to game events)

			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add( "PlayerSpawnEffect", "effect_cost", function ( ply, model ) -- Effect cost
				if (ply:money_take(spawncosts['effect']) and GetConVar("sbox_maxeffects"):GetInt() != 0) then
					ply:roi_interact(1, 0.01)
					return true
				else
					ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy that." )
					return false
				end
			end )
			
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add( "PlayerSpawnRagdoll", "ragdoll_cost", function( ply, model ) -- Ragdoll cost
				if (ply:money_take(spawncosts['ragdoll']) and GetConVar("sbox_maxragdolls"):GetInt() != 0)  then
					ply:roi_interact(1, 0.02)
					ply:fame_interact(1, 1)
					return true
				else
					ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy that." )
					return false
				end
			end )
				
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add ("PlayerCanPickupWeapon", "swep_pickup_cost", function ( ply, wep )
				if (GetConVar( "sbox_weapons" ):GetInt() != 0 or ply:Alive() != false) then -- I know it's pedantic and not really necessary, but it makes it work /more/.
					if (ply:GetInfoNum( "money_weaponpickup", 1 ) == 1) then -- Retrieve clientsided variable value and check if it is 1 (true).
						if (table.HasValue(free_weapons, wep:GetClass()) and GetConVar("money_defaultweaponsforfree"):GetBool() == true) then
							return true
						elseif (table.HasValue(true_weapons, wep:GetClass()) and GetConVar("money_defaultweaponsforfree"):GetBool() == false) then
							ply:fame_interact(0, 1)
							return true
						else
							local wgt = 0
							local app = 0
							
							if (wep:GetWeight() != nil) then
								if (wep:GetWeight() > (spawncosts['weapon']*0.75)) then
									wgt = (spawncosts['weapon']*0.75)
								else
									wgt = wep:GetWeight()
								end
							else
								wgt = 0
							end
							
							if (string.match( wep:GetClass() , 'm9k_.-') != nil or string.match( wep:GetClass() , 'gdcw_.-') != nil) then
								app = spawncosts['m9k_gdcw_app']
							elseif (string.match( wep:GetClass() , 'fas_.-') != nil or string.match( wep:GetClass() , 'fas2_.-') != nil or string.match( wep:GetClass() , 'fas20_.-') != nil) then
								app = spawncosts['fas2_app']
							elseif (string.match( wep:GetClass() , 'cw20_.-') != nil or string.match( wep:GetClass() , 'cw2_.-') != nil or string.match( wep:GetClass() , 'cw_.-') != nil) then
								app = spawncosts['cw20_app']
							elseif (string.match( wep:GetClass() , 'q3_.-') != nil or string.match( wep:GetClass() , 'q3a_.-') != nil) then
								app = spawncosts['q3_app']
							elseif (string.match( wep:GetClass() , 'cs_.-') != nil or string.match( wep:GetClass() , 'ttt_.-') != nil or string.match( wep:GetClass() , 'rp_.-') != nil or string.match( wep:GetClass() , 'dod_.-') != nil or string.match( wep:GetClass() , 'ww2_.-') != nil) then
								app = spawncosts['cs_ttt_rp_dod_app']
							elseif (string.match( wep:GetClass() , 'eq_.-') != nil or string.match( wep:GetClass() , 'gmod_.-') != nil or string.match( wep:GetClass() , 'stranded_.-') != nil) then
								app = spawncosts['eq_gmod_stranded_app']
							else
								app = 0
							end
							
							if (ply:money_take(math.floor((spawncosts['weapon']+wgt+app)*(math.abs(GetConVar("money_multiplier_spawncost_swep"):GetFloat()))))) then
								ply:roi_interact(0, 0.15)
								ply:fame_interact(1, tonumber(math.floor(3+(app/3))))
								return true
							else
								if (timer.Exists( "wepPickupCheckFalse1" )) then
									return false
								else
									timer.Create( "wepPickupCheckFalse1", 1, 1, function()
										ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to get this weapon." )
									end)
								end
								return false
							end
						end
					else
						if (timer.Exists( "wepPickupCheckFalse2" )) then
							return false
						else
							timer.Create( "wepPickupCheckFalse2", 1, 1, function()
								ply:PrintMessage( HUD_PRINTTALK, ">> You manually disabled weapon pickup." )
							end)
						end
						return false
					end
				else
					return false
				end
			end)
		
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add( "PlayerSpawnNPC", "npc_costs", function( ply, npc_type, weapon ) -- Npc costs
				if (GetConVar( "sbox_maxnpcs"):GetInt() != 0) then
					if (	table.HasValue(npc_small, npc_type)) then
						if (ply:money_take(math.floor(spawncosts['npc_small']*(math.abs(GetConVar("money_multiplier_spawncost_npc"):GetFloat())))) == true) then -- Execute spawncost penalty
							ply:roi_interact(0, 0.07)
							ply:fame_interact(0, 1)
							return true
						else
							ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to summon that." )
							return false
						end
					elseif 	(table.HasValue(npc_ultrabig, npc_type)) then
						if (ply:money_take(math.floor(spawncosts['npc_ultrabig']*(math.abs(GetConVar("money_multiplier_spawncost_npc"):GetFloat())))) == true) then -- Execute spawncost penalty
							ply:roi_interact(0, 2.25)
							ply:fame_interact(1, 9)
							return true
						else
							ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to unleash that much power." )
							return false
						end			
					elseif 	(table.HasValue(npc_big, npc_type)) then
						if (ply:money_take(math.floor(spawncosts['npc_big']*(math.abs(GetConVar("money_multiplier_spawncost_npc"):GetFloat())))) == true) then -- Execute spawncost penalty
							ply:roi_interact(0, 0.67)
							ply:fame_interact(1, 3)
							return true
						else
							ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy that." )
							return false
						end
					elseif (table.HasValue(npc_friendly, npc_type)) then
						if (ply:money_take(math.floor(spawncosts['npc_friendly']*(math.abs(GetConVar("money_multiplier_spawncost_npc"):GetFloat())))) == true) then -- Execute spawncost penalty
							ply:roi_interact(1, 0.09)
							ply:fame_interact(1, 1)
							return true
						else
							ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to hire them." )
							return false
						end
					else	-- Everything else
						if (ply:money_take(math.floor(spawncosts['npc_else']*(math.abs(GetConVar("money_multiplier_spawncost_npc"):GetFloat())))) == true) then -- Execute spawncost penalty
							ply:roi_interact(0, 0.33)
							ply:fame_interact(1, 2)
							return true
						else
							ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to summon that." )
							return false
						end
					end
				else
					return false
				end
			end )
			
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add( "PlayerSpawnVehicle", "vehicle_cost", function( ply, model, name, info) -- Vehicle cost
				if (GetConVar( "sbox_maxvehicles"):GetInt() != 0) then
					if (GetConVar( "money_freeze" ):GetBool() != true) then	
						if (table.HasValue(info, "prop_vehicle_prisoner_pod") or table.HasValue(info, "prop_vehicle_seat")) then -- Seat/chair/pod cost
							if ply:money_take(math.floor(spawncosts['vehicle_seat']*(math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat())))) then
								ply:roi_interact(1, 0.05)
								ply:fame_interact(1, 2)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy a seat." )
								return false
							end
						elseif (table.HasValue(info, "prop_vehicle_airboat")) then -- Airboat base cost
							if ply:money_take(math.floor(spawncosts['vehicle_airboat']*(math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat())))) then
								ply:roi_interact(0, 0.03)
								ply:fame_interact(1, 1)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy this hovering vehicle." )
								return false
							end
						elseif (table.HasValue(info, "prop_vehicle_jeep_old")) then -- Jeep base (red, old) cost
							if ply:money_take(math.floor(spawncosts['vehicle_jeep_old']*(math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat())))) then
								ply:roi_interact(0, 0.04)
								ply:fame_interact(1, 3)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy this vehicle." )
								return false
							end
						elseif (table.HasValue(info, "prop_vehicle_apc") or table.HasValue(info, "prop_vehicle_zapc")) then
							if ply:money_take(math.floor(spawncosts['vehicle_hl2apc']*(math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat())))) then
								ply:roi_interact(0, 0.25)
								ply:fame_interact(1, 10)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy an APC." )
								return false
							end
						elseif (table.HasValue(info, "sent_sakarias_car_abrams") or table.HasValue(info, "sent_tank") or table.HasValue(info, "sent_abrams")) then -- SCars 2.0 tank and tank handlers costs.
							if ply:money_take(math.floor(spawncosts['vehicle_tank']*((math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat()))))) then
								ply:roi_interact(0, 0.25)
								ply:fame_interact(1, 8)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy a tank." )
								return false
							end
						elseif (table.HasValue(info, "sent_sakarias_car_delorean")) then -- SCars 2.0 DeLorean DMC-12 cost.
							if ply:money_take(math.floor(spawncosts['vehicle_delorean']*((math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat()))))) then
								ply:roi_interact(0, 0.05)
								ply:fame_interact(1, 2)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy a DeLorean." )
								return false
							end
						elseif (table.HasValue(info, "sent_sakarias_car_toyotagtone")) then -- SCars 2.0 Toyota GT One cost.
							if ply:money_take(math.floor(spawncosts['vehicle_gtone']*((math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat()))))) then
								ply:roi_interact(0, 0.05)
								ply:fame_interact(1, 1)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy Toyota GT One." )
								return false
							end
						-- SCars 2.0 Junk cars
						elseif (table.HasValue(info, "sent_sakarias_car_junker1") or table.HasValue(info, "sent_sakarias_car_junker2") or table.HasValue(info, "sent_sakarias_car_junker3") or table.HasValue(info, "sent_sakarias_car_junker4") or table.HasValue(info, "sent_sakarias_car_junker5") or table.HasValue(info, "sent_vehicle_junker")) then
							if ply:money_take(math.floor(spawncosts['vehicle_junk']*((math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat()))))) then
								ply:roi_interact(1, 0.03)
								ply:fame_interact(0, 4)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy this vehicle." )
								return false
							end
						else  -- Jalopy base (yellow muscle car) cost, and everything else (unhandled).
							if ply:money_take(math.floor(spawncosts['vehicle_jeep']*(math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat())))) then
								ply:roi_interact(0, 0.04)
								ply:fame_interact(1, 4)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy this vehicle." )
								return false
							end
						end
					else
						ply:PrintMessage( HUD_PRINTTALK, ">> Transaction rejected due to bank accounts being frozen." )
						return false
					end
				else
					return false
				end
			end )
			
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add( "PlayerSpawnSENT", "sent_prespawn", function( ply, class ) -- SENT Cost.
				if (GetConVar( "sbox_maxsents" ):GetInt() != 0) then
					if (GetConVar( "money_freeze" ):GetBool() != true) then
				
						local money = 1.0
						local message = ""
						
						if (class == "sent_sakariasjet" or class == "sent_sakariasjet_rfl") then -- Sakarias88 AirVehicles Armed Jet 
							money = spawncosts['sent_jet']
							message = ">> You do not have enough to buy fully-armed military jet."
						elseif (class == "sent_sakariasjet_nonadmin" or class == "sent_sakariasjet_nonadmin_rfl") then -- Sakarias88 AirVehicles Unarmed Jet cost
							money = spawncosts['sent_jet_nonadmin']
							message = ">> You do not have enough to buy a military jet."
						elseif (class == "sent_helicopter" or class == "sent_sakariashelicopter" or class == "sent_blackhawk") then -- Sakarias88 AirVehicles Armed Heli cost
							money = spawncosts['sent_helicopter']
							message = ">> You do not have enough to buy a fully-equipped transport vehicle."
						elseif (class == "sent_helicopter_nonadmin" or class == "sent_sakariashelicopter_nonadmin") then -- Sakarias88 AirVehicles Unarmed Heli cost
							money = spawncosts['sent_helicopter_nonadmin']
							message = ">> You do not have enough to buy a heli."
						elseif (class == "sent_zar3" or class == "sent_emplacementgun" or class == "sent_emplacement" or class == "turret_bullets") then -- Emplacement gun cost
							money = spawncosts['sent_stat']
							message = ">> You do not have enough to buy an emplacement."
						elseif (class == "sent_zar4" or class == "turret_bullets2" or class == "turret_rail" or class == "turret_grenade") then -- Emplacements gun cost
							money = spawncosts['sent_stat']*1.21
							message = ">> You do not have enough to buy an emplacement."
						elseif (class == "item_healthcharger" or class == "sent_healthcharger") then -- Health charger cost
							money = (spawncosts['sent_stat']-GetConVar( "money_multiplier_spawncost_sent" ):GetFloat())
							message = ">> You do not have enough to buy a health charger."
						elseif (class == "item_suitcharger" or class == "sent_suitcharger") then -- Suit charger cost
							money = (spawncosts['sent_stat']-(2.1*GetConVar( "money_multiplier_spawncost_sent" ):GetFloat()))
							message = ">> You do not have enough to buy a suit charger."
						elseif (class == "prop_thumper" or class == "sent_thumper" or class == "sent_vj_fireplace" or class == "sent_sakarias_gaspump") then -- Thumper (HL2), fireplace (VJ Base) and Gas Pump (SCars 2.0) cost
							money = (spawncosts['sent_stat']-(4*GetConVar( "money_multiplier_spawncost_sent" ):GetFloat()))
							message = ">> You do not have enough to buy an emplacement."
						elseif (class == "zombies_mysterybox" or class == "zombie_mysterybox" or class == "cod_mysterybox" or class == "codwaw_mysterybox" or class == "zombies_weaponbox") then -- Mystery Box cost
							money = (spawncosts['sent_stat']*2.02)
							message = ">> You do not have enough to buy a Mystery Box."
						elseif (class == "sent_sakarias_gasstation") then -- SCars 2.0 gas station cost
							money = spawncosts['sent_gasstation']
							message = ">> You do not have enough to buy a gas station."
						elseif (class == "sent_combinemech" or class == "sent_zcombinemech" or class == "sent_mechatron") then -- Combine Mech cost
							money = spawncosts['sent_combinemech']
							message = ">> You do not have enough to buy a mech."
						elseif (class == "cw_ammo_crate_regular") then -- Customizable Weaponry 2.0 36x ammo crate cost
							money = spawncosts['cw_ammo_crate_regular']
							message = ">> You do not have enough to buy an ammo emplacement."
						elseif (class == "cw_ammo_crate_small") then -- Customizable Weaponry 2.0 24x ammo crate cost
							money = spawncosts['cw_ammo_crate_small']
							message = ">> You do not have enough to buy an ammo crate."
						elseif (class == "cw_ammo_kit_regular") then -- Customizable Weaponry 2.0 10x ammo crate cost
							money = spawncosts['cw_ammo_kit_regular']
							message = ">> You do not have enough to buy an ammo crate."
						elseif (class == "cw_ammo_kit_small") then -- Customizable Weaponry 2.0 6x ammo crate cost
							money = spawncosts['cw_ammo_kit_small']
							message = ">> You do not have enough to buy an ammo crate."
						elseif (class == "sent_tardis") then -- Tardis cost
							money = spawncosts['sent_tardis']
							message = ">> You do not have enough to buy TARDIS."
						elseif (class == "acf_ammo") then -- Tardis cost
							money = spawncosts['acf_ammo']
							message = ">> You do not have enough to buy this ammo crate."
						elseif (class == "acf_gun") then -- Tardis cost
							money = spawncosts['acf_gun']
							message = ">> You do not have enough to buy this gun."
						elseif (class == "acf_engine") then -- Tardis cost
							money = spawncosts['acf_engine']
							message = ">> You do not have enough to buy this engine."
						elseif (class == "acf_rack") then -- Tardis cost
							money = spawncosts['acf_rack']
							message = ">> You do not have enough to buy this rack."
						elseif ((string.match( class , 'anom_.-') != nil) or (string.match( class , 'anomaly_.-') != nil)) then -- Customizable Weaponry 2.0 6x ammo crate cost
							money = spawncosts['anomaly']
							message = ">> You do not have enough to summon an anomaly."
						elseif (class == "sent_sms_antitheftmodule") then -- SMS Anti-Theft Module
							money = math.floor(spawncosts['sent_stat']*0.66)
							message = ">> You need more to be able to buy Anti-Theft Module."
						elseif (class == "sent_sms_moneyprinter") then -- SMS Anti-Theft Module
							money = math.ceil(spawncosts['sent_stat']*0.67)
							message = ">> You need more to be able to get a Money Printer."
						else
							money = 0
							message = ">> You need more to be able to spawn SENTs."
						end
						
						money = math.floor(money*((math.abs(GetConVar("money_multiplier_spawncost_sent"):GetFloat()))/5.0))
						
						if (money <= 0) then
							if ply:money_enough(math.floor(200*((math.abs(GetConVar("money_multiplier_spawncost_sent"):GetFloat()))/5.0))+1) then
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, message )
								return false
							end
						else
							if ply:money_take(money) then
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, message )
								return false
							end
						end
						
					else
						ply:PrintMessage( HUD_PRINTTALK, ">> Transaction rejected due to bank accounts being frozen." )
						return false
					end
				else
					return false
				end
			end )
			
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add("PlayerSpawnedSENT", "sent_postspawn", function (ply, ent) -- SENT spawncost penalty executor

				local mass = 0
				local phys = ent:GetPhysicsObject() -- Get Physics Object from Entity
				
				local senthelper = { 
					"anom_beads", "anom_bubble", "anom_burner", "anom_circus", "anom_damage", "anom_divide", "anom_electro", "anom_static", "anom_well", 
					"cw_ammo_crate_regular", "cw_ammo_crate_small", "cw_ammo_kit_regular", "cw_ammo_kit_small", "item_healthcharger", "item_suitcharger", "prop_thumper", 
					"sent_abrams", "sent_sms_antitheftmodule", "sent_blackhawk", "sent_combinemech", "sent_emplacement", "sent_emplacementgun", "sent_healthcharger", 
					"sent_helicopter", "sent_helicopter_nonadmin", "sent_mechatron", "sent_sakarias_car_abrams", "sent_sakarias_car_delorean", "sent_sakarias_car_junker1", 
					"sent_sakarias_car_junker2", "sent_sakarias_car_junker3", "sent_sakarias_car_junker4", "sent_sakarias_car_junker5", "sent_sakarias_car_toyotagtone", 
					"sent_sakarias_gaspump", "sent_sakarias_gasstation", "sent_sakariashelicopter", "sent_sakariashelicopter_nonadmin", "sent_sakariasjet", 
					"sent_sakariasjet_nonadmin", "sent_sakariasjet_nonadmin_rfl", "sent_sakariasjet_rfl", "sent_suitcharger", "sent_tank", "sent_tardis", "sent_thumper", 
					"sent_vj_fireplace", "sent_zar3", "sent_zar4", "sent_zcombinemech", "turret_bullets", "turret_bullets2", "turret_grenade", "turret_rail",
					"sent_sms_moneyprinter", "acf_ammo", "acf_rack", "acf_gun", "acf_engine"
				}
				
				ply:fame_interact(1, 5)
				
				if (table.HasValue(senthelper, ent:GetClass())) then -- If a name of an entity matches anything handled specifically, then do nothing.
					return
				else
					if phys:IsValid() then -- If physics models are valid:
						mass = math.ceil(tonumber(phys:GetMass())) -- Get mass.
						ply:money_take_absolute(math.floor(mass*((math.abs(GetConVar("money_multiplier_spawncost_sent"):GetFloat()))))) -- Execute.
					else
						return
					end
				end
			end )
			
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add( "PlayerSpawnProp", "prop_prespawn", function( ply, model ) -- Prop spawncost CHECKER
				if (GetConVar( "sbox_maxprops"):GetInt() != 0) then
					if ply:money_enough(math.floor((spawncosts['prop_under_3200']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat())))-1.1)) then
						ply:roi_interact(1, 0.01)
						ply:fame_interact(0, 2)
						return true
					else
						ply:PrintMessage( HUD_PRINTTALK, ">> You have to have more to be able to buy props." )
						return false
					end
				else
					return false
				end
			end )
			
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add( "PlayerSpawnedProp", "prop_postspawn", function ( ply, model, ent ) -- Prop spawncost penalty executor
				
				local mass = 0
				local phys = ent:GetPhysicsObject()
				
				if phys:IsValid() then
				
					mass = math.ceil(tonumber(phys:GetMass())) -- Get mass and execute spawncost penalty based on mass factor
					
					if (mass < 5) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_5']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 10) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_10']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 20) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_20']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 40) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_40']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 60) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_60']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 80) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_80']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 100) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_100']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 150) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_150']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 200) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_200']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 300) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_300']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 400) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_400']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 600) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_600']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 800) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_800']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 1200) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_1200']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 1600) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_1600']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 2400) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_2400']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 3200) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_3200']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
						ply:roi_interact(1, 0.01)
					elseif (mass < 4800) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_4800']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
						ply:roi_interact(1, 0.01)
					elseif (mass < 6400) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_6400']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
						ply:roi_interact(1, 0.01)
					elseif (mass < 9999) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_9999']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
						ply:roi_interact(1, 0.01)
					else
						ply:money_take_absolute(math.floor(spawncosts['prop_over_9999']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
						ply:fame_interact(0, 1)
						ply:roi_interact(1, 0.01)
					end
				else
					ply:money_take_absolute(math.floor(spawncosts['prop_under_5']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					return
				end
				
			end )
			
		else
			
			hook.Remove( "PlayerSpawnEffect", "effect_cost")
			hook.Remove( "PlayerSpawnRagdoll", "ragdoll_cost")
			hook.Remove( "PlayerCanPickupWeapon", "swep_pickup_cost")
			
			hook.Remove( "PlayerSpawnNPC", "npc_costs")
			hook.Remove( "PlayerSpawnVehicle", "vehicle_cost")
			
			hook.Remove( "PlayerSpawnSENT", "sent_prespawn")
			hook.Remove( "PlayerSpawnedSENT", "sent_postspawn")

			hook.Remove( "PlayerSpawnProp", "prop_prespawn")
			hook.Remove( "PlayerSpawnedProp", "prop_postspawn")	
				
		end
		
	end
	
	
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- SPAWNCOSTS INITIALIZATION. Creates a timer to check everything over time.  --
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	
		timer.Create( "SMSSpawncostChecker" , 2 , 0 ,  toggleSpawncosts )
	
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

end

-- END OF FILE --