function UpdateLevel_Camp ()
	Defreeze_Group_Camp_UAN_01 ()
end


-- OBJECTIF DEPART
function Obj_A_Begin ()
	NewObjectiveNewSubObjective ( "Obj_A", "Obj_A_1" )
	SetVarValue ( GetObjectiveID ( "Obj_A_a"),"Active", true )
end

-- le mercenaire 2 dit une petite phrase
function Mercenary_2_Lillte_Speak ()
	if (_idMerc[1] ~= nil) then 
		MakeCharacterSpeak(_idMerc[1],_idPlayer,"DIA_SPE_NIV_E_MERCE_B_01",true,110,2, 0, "",31)
	end
end

-- petit groupe alertés vient rejoindre le camp
function Defreeze_Group_Camp_UAN_01 ()
	if	AliveMembersCount(GetGroupID("Group_Camp_UAN_00")) <= 2
	or	(IsEntityInBox(_idPlayer,"Sector_Event_Camp_A_00")== true )then
		if (_bDefreeze_Group_Camp_UAN_01 == 0) then
			FreezeAll(GetGroupID("Group_Camp_UAN_01"), false)
			_bDefreeze_Group_Camp_UAN_01 = 1
		end
	end
end

-- l'ingénieur dit une petite phrase
function OnEnter_Sector_Event_Camp_A_02 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Camp_A_02 == 0) then
			MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_E_MERCE_A_01",true,110,2, 0, "",31)
			_bOnEnter_Sector_Event_Camp_A_02 = 1
		end
	end
end

-- Defreeze des ennemis sur la zone battlefield
function OnEnter_Sector_Event_Camp_A_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Camp_A_01 == 0) then
			FreezeAll(GetGroupID("Group_Field_UAN_00"), false)
			FreezeAll(GetGroupID("Group_Field_UAN_02"), false)
			FreezeAll(GetGroupID("Group_Field_UAN_08"), false)
			Freeze(GetCharacterID("Char_Field_UAN_01_01"), false)
			Freeze(GetCharacterID("Char_Field_UAN_03_01"), false)
			StartMusic("Sounds//Music//BoS - Big Boy theme.wav",true)
			_bOnEnter_Sector_Event_Camp_A_01 = 1
		end
	end
end

