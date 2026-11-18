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

function Debug_GetSelectedChampions()

		return "Champion_Hassan_Dawa", "Champion_Shota_Junbei"
		-- Champion_Hassan_Dawa
		-- Champion_Seng_Cheam
		-- Champion_Vladimir_the_Bloody

  	-- Champion_Shota_Junbei
 		-- Champion_Le_Bucheron
  	-- Champion_Taka_The_Dark_Herald

end



-------------------------------------------------------------
-- :::: DEBUG :::::::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function OnEnter_DebugTest(id)
	if (id == _idPlayer) then
	SetVarValue(GetExoskeletonID("Exo_Camp2"), "Freeze", false)
	Freeze(_idChampion_0, false)
--BoomDca1()
--		SetVarValue(GetExoskeletonID("Exo_Camp1"), "Freeze", false)
--		Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_22"), false)
--		FreezeAll(GetGroupID("Grp_Camp1_UAN_29_30"), false)
--		CreationTimer(true, true, false, "CamExoCamp1",2)
	end
end