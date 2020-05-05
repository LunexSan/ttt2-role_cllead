-- Icon Materials


-- General settings

function ROLE:PreInitialize()
	self.color = Color(072, 061, 139, 255) -- rolecolour
	
	self.abbr = 'cllead' -- Abbreviation
	self.unknownTeam = false -- No teamchat
	self.defaultTeam = TEAM_CULT -- Part of the Cult team
	self.preventFindCredits = true
	self.preventKillCredits = true
	self.preventTraitorAloneCredits = true
	self.preventWin = false -- cannot win unless he switches roles
	self.scoreKillsMultiplier       = 2
    self.scoreTeamKillsMultiplier   = -12
	
	-- ULX convars

		if not GetConVar("ttt_cultleader_spawn_clti_deagle"):GetBool() then
		table.insert(self.fallbackTable, {id = "weapon_ttt2_cultistdeagle"})
	end

	self.conVarData = {
		pct = 0.20, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 9, -- minimum amount of players until this role is able to get selected
		credits = 1, -- the starting credits of a specific role
		shopFallback = SHOP_CULTLEADER,
		togglable = true, -- option to toggle a role for a client if possible (F1 menu)
		random = 100
	}
end

if SERVER then
	-- modify roles table of rolesetup addon
	hook.Add("TTTAModifyRolesTable", "ModifyRoleClleadToInno", function(rolesTable)
		local cultleaders = rolesTable[ROLE_CULTLEADER]

		if not cultleaders then return end

		rolesTable[ROLE_INNOCENT] = rolesTable[ROLE_INNOCENT] + cultleaders
		rolesTable[ROLE_CULTLEADER] = 0
	end)

	-- Give Loadout on respawn and rolechange
	function ROLE:GiveRoleLoadout(ply, isRoleChange)
		if isRoleChange and WEPS.IsInstalled("weapon_ttt2_cultistdeagle")
			and GetConVar("ttt_jackal_spawn_clti_deagle"):GetBool() then -- TODO: maybe give Clti deagle on respawn if not used before
			ply:GiveEquipmentWeapon("weapon_ttt2_cultistdeagle")
		end

		ply:GiveArmor(GetConVar("ttt_cultleader_armor_value"):GetInt())
	end

	-- Remove Loadout on death and rolechange
	function ROLE:RemoveRoleLoadout(ply, isRoleChange)
		if WEPS.IsInstalled("weapon_ttt2_cultistdeagle") then
			ply:StripWeapon("weapon_ttt2_cultistdeagle")
		end

		ply:RemoveArmor(GetConVar("ttt_cultleader_armor_value"):GetInt())
	end
end