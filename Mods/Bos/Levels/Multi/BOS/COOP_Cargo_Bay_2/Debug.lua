-------------------------------------------------------------
-- :::: MERCS DE DEBUG ::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedMercenaries()

    return "Char_Merc_0" , "Char_Merc_1"
end

function Debug_GetSelectedMercenariesName()

    return "Mercenary_Chris_Halirott", "Mercenary_Taylor_Moore"
		--Mercenary_Chris_Halirott
		--Mercenary_Taylor_Moore
		--Mercenary_Peter_Linberg
		--Mercenary_Sunny_Mayers
		--Mercenary_Kenny_Parker
		--Mercenary_Martin_Laurence
		
end


-------------------------------------------------------------
-- :::: CHAMPION DE DEBUG :::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

-------------------------------------------------------------
-- :::: DEBUG :::::::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function OnEnter_DebugTest()
	SetVarValue(GetExoskeletonID("Exo_Camp2"), "Freeze", false)
	Freeze(_idChampion_0, false)
--BoomDca1()
--		SetVarValue(GetExoskeletonID("Exo_Camp1"), "Freeze", false)
--		Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_22"), false)
--		FreezeAll(GetGroupID("Grp_Camp1_UAN_29_30"), false)
--		CreationTimer(true, true, false, "CamExoCamp1",2)
end