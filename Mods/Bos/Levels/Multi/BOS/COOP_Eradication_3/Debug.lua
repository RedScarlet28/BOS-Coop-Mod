
-------------------------------------------------------------
-- :::: MERCS DE DEBUG ::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedMercenaries()
 
    return "Char_Merc_0" , "Char_Merc_1";
 
end

function Debug_GetSelectedMercenariesName()

    return "Mercenary_David_Julian", "Mercenary_Martin_Lenoir"

end

-------------------------------------------------------------
-- :::: MERCS DE DEBUG ::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function OnEnter_Debug(id)
	if (id == _idPlayer) then
--		DefriseMonastery_MiniBoS_1Floor2()
--		DefriseMonastery_ActivCouloir()

		if IsAlive(GetCharacterID("Char_Phase1_Resist_Sniper_1")) then
			Freeze(GetCharacterID("Char_Phase1_Resist_Sniper_1"), true)
		end

	if (_bCtrlRoofBaldingCineBegin == false) then
			Teletransportation("Char_Repere_Player_Roof2",_idPlayer)
			EnableCharacterCommand(_idPlayer,false)
			if (_idMerc[0] ~= nil) then
				Teletransportation("Char_Repere_Merc0_Roof",_idMerc[0])
				EnableCharacterCommand(_idMerc[0],false)
			end
			if (_idMerc[1] ~= nil) then
				Teletransportation("Char_Repere_Merc1_Roof",_idMerc[1])
				EnableCharacterCommand(_idMerc[1],false)	
			end
			_bCtrlRoofBaldingCineBegin = true
			Freeze(GetCharacterID("Char_Max_Balding_Roof"), false)
			Freeze(GetCharacterID("Player_Cine_Roof"), false)
			SetGodMode(GetCharacterID("Player_Cine_Roof"), true)
			ShowCinematicBlackStripes(true)
			ReleaseSingleRigidBodyInBox("SE_SRB_RLZ_Roof_Balding")
			LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_A1"))
			CreationTimer(true, true, false,"DialogueNolan1",2)
			SkinPlayer()
		end

	end
end
