function UpdateLevel_Start2 ()
	if(_bObjectif_1_done == 0)then
		Defreeze_Group_UAN_Start2_05()
	end
end

-- Les UAN Viennent en renfort depuis un entrepot
function OnEnter_Sector_Event_Start2_A_01(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bObjectif_1_done == 0)then
			if (_bOnEnter_Sector_Event_Start2_A_01 == 0) then
					_bOnEnter_Sector_Event_Start2_A_01 = 1			
			end
		end
	end
end

function Defreeze_Group_UAN_Start2_05()
	if (_bDefreeze_Group_UAN_Start2_05 == 0) then	
		if ((AliveMembersCount(GetGroupID("Group_UAN_Start2_02")) <= 1 )or (_bOnEnter_Sector_Event_Start2_A_01 == 1)) then
			if (_bObjectif_1_done == 0)then
				FreezeAll(GetGroupID("Group_UAN_Start2_05"), false)
				_bDefreeze_Group_UAN_Start2_05 = 1
			end
		end
	end
end

-- Nolan defreeze des mecs dans l'escalier devant lui
function OnEnter_Sector_Event_Start2_A_03(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Start2_A_03 == 0) then
			if (_bObjectif_1_done == 0)then	
				FreezeAll(GetGroupID("Group_UAN_Start_04"), false)
				_bOnEnter_Sector_Event_Start2_A_03 = 1
			end			
		end
	end
end

-- Nolan defreeze d'autres combats ( wrf vs  UAN)au loin sur le place (EUH??)
-- Nolan defreeze l'officier qui lui montre le chemin
-- et lance du timer pour le speech de l'officierd
function OnEnter_Sector_Event_Start2_A_02(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Start2_A_02 == 0) then	
			if (_bObjectif_1_done == 0)then
			--	FreezeAll(GetGroupID("Group_WRF_Start2_02"), false)
			--	FreezeAll(GetGroupID("Group_UAN_Start2_06"), false)
				Freeze(GetCharacterID("Char_WRF_Start_02_1"), false)
				_bOnEnter_Sector_Event_Start2_A_02 = 1
			end			
		end
	end
end

-- deuxième speech de l'officier
function OnEnter_Sector_Event_Start2_B_00(_idCharInBox)
	if (_idCharInBox == GetCharacterID("Char_WRF_Start_02_1")) then
		if (_bOnEnter_Sector_Event_Start2_B_00 == 0) then
			if (_bObjectif_1_done == 0)then	
				MakeCharacterSpeak(_idOfficier,_idPlayer, "DIA_SPE_NIV_J_USWE_A_6",true,110,2, 0, "",21)
				_bOnEnter_Sector_Event_Start2_B_00 = 1
			end		
		end
	end
end