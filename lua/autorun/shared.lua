-- replicated convars have to be created on both client and server
CreateConVar("ttt_cultleader_armor_value", 30, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED})
CreateConVar("ttt_cultleader_spawn_clti_deagle", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED})

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_dynamic_cultleader_convars", function(tbl)
	tbl[ROLE_CULTLEADER] = tbl[ROLE_CULTLEADER] or {}

	table.insert(tbl[ROLE_CULTLEADER], {cvar = "ttt_cultleader_armor_value", slider = true, min = 0, max = 100, decimal = 0, desc = "ttt_cultleader_armor_value (def. 30)"})
	table.insert(tbl[ROLE_CULTLEADER], {cvar = "ttt_cultleader_spawn_clti_deagle", checkbox = true, desc = "ttt_cultleader_spawn_clti_deagle (def. 1)"})
end)