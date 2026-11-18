
-------------------------------------------------------------
-- :::: CHAMPION DE DEBUG :::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedChampions()

	return "Champion_Master_Loa"
	-- Champion_Masatosi_Yamibushi_Togawa
	-- Champion_Smoking_Rifle_Felipe
	-- Champion_Master_Loa
end

-------------------------------------------------------------
-- :::: MERCS DE DEBUG ::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedMercenaries()
 
    return "Char_Merc_0_Debug", "Char_Merc_1_Debug"
 
end


function Debug_GetSelectedMercenariesName()

    return "Mercenary_Davis_Bell", "Mercenary_Arnold_Saunderson"

end

-------------------------------------------------------------
-- :::: KILL ZONE :::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function OnEnter_SE_KillZone_Mordor(id)

	-- Char_UAN_Mordor_01_Destroyer_1
	if (id == GetCharacterID("Char_UAN_Mordor_01_Destroyer_1")) then
		SetVarValue(GetCharacterID("Char_UAN_Mordor_01_Destroyer_1"),"Health",0)
		Freeze(GetCharacterID("Char_UAN_Mordor_01_Destroyer_1"), true)
	end

	-- Char_UAN_Mordor_01_Protector_1
	if (id == GetCharacterID("Char_UAN_Mordor_01_Protector_1")) then
		SetVarValue(GetCharacterID("Char_UAN_Mordor_01_Protector_1"),"Health",0)
		Freeze(GetCharacterID("Char_UAN_Mordor_01_Protector_1"), true)
	end

	-- Char_UAN_Mordor_02_Trooper_1
	if (id == GetCharacterID("Char_UAN_Mordor_02_Trooper_1")) then
		SetVarValue(GetCharacterID("Char_UAN_Mordor_02_Trooper_1"),"Health",0)
		Freeze(GetCharacterID("Char_UAN_Mordor_02_Trooper_1"), true)
	end

	-- Char_UAN_Mordor_02_Trooper_2
	if (id == GetCharacterID("Char_UAN_Mordor_02_Trooper_2")) then
		SetVarValue(GetCharacterID("Char_UAN_Mordor_02_Trooper_2"),"Health",0)
		Freeze(GetCharacterID("Char_UAN_Mordor_02_Trooper_2"), true)
	end

	-- Char_UAN_Mordor_03_Trooper_1
	if (id == GetCharacterID("Char_UAN_Mordor_03_Trooper_1")) then
		SetVarValue(GetCharacterID("Char_UAN_Mordor_03_Trooper_1"),"Health",0)
		Freeze(GetCharacterID("Char_UAN_Mordor_03_Trooper_1"), true)
	end

	-- Char_UAN_Mordor_03_Trooper_2
	if (id == GetCharacterID("Char_UAN_Mordor_03_Trooper_2")) then
		SetVarValue(GetCharacterID("Char_UAN_Mordor_03_Trooper_2"),"Health",0)
		Freeze(GetCharacterID("Char_UAN_Mordor_03_Trooper_2"), true)
	end

	-- Char_UAN_Mordor_Sniper_1
	if (id == GetCharacterID("Char_UAN_Mordor_Sniper_1")) then
		SetVarValue(GetCharacterID("Char_UAN_Mordor_Sniper_1"),"Health",0)
		Freeze(GetCharacterID("Char_UAN_Mordor_Sniper_1"), true)
	end

	-- Char_UAN_Mordor_Sniper_2
	if (id == GetCharacterID("Char_UAN_Mordor_Sniper_2")) then
		SetVarValue(GetCharacterID("Char_UAN_Mordor_Sniper_2"),"Health",0)
		Freeze(GetCharacterID("Char_UAN_Mordor_Sniper_2"), true)
	end

	-- Char_UAN_Mordor_Sniper_3
	if (id == GetCharacterID("Char_UAN_Mordor_Sniper_3")) then
		SetVarValue(GetCharacterID("Char_UAN_Mordor_Sniper_3"),"Health",0)
		Freeze(GetCharacterID("Char_UAN_Mordor_Sniper_3"), true)
	end
end