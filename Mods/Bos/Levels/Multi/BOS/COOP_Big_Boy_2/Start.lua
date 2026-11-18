function UpdateLevel_Start ()
	Defreeze_Group_Start_UAN_02 ()
	Defreeze_Group_Start_UAN_04 ()
	Defreeze_Group_Start_UAN_05 ()
	Defreeze_Group_Start_UAN_10 ()
	Defreeze_Group_Start_UAN_12 ()
	Defreeze_Char_Start_UAN_15_01 ()
	Char_Engineer_Place_C4 ()
end


-- defreeze premier renfort
function Defreeze_Group_Start_UAN_02 ()
	if	AliveMembersCount(GetGroupID("Group_Start_UAN_00"))<= 1 
	or	IsEntityInBox(_idPlayer,"Sector_Event_Start_A_00")then
		if (_bDefreeze_Group_Start_UAN_02 == 0) then
			FreezeAll(GetGroupID("Group_Start_UAN_01"), false)

			_bDefreeze_Group_Start_UAN_02 = 1
		end
	end
end


-- Defreeze Gardes & rondes
function OnEnter_Sector_Event_Start_A_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Start_A_01 == 0) then
			FreezeAll(GetGroupID("Group_Start_UAN_02"), false)
			FreezeAll(GetGroupID("Group_Start_UAN_03"), false)
			StartMusic("Sounds//Music//BoS - Big Boy theme.wav",true)
			_bOnEnter_Sector_Event_Start_A_01 = 1
		end
	end
end

-- defreeze deuxième renfort
-- defreeze sniper hauteur
function Defreeze_Group_Start_UAN_04 ()
	if	((AliveMembersCount(GetGroupID("Group_Start_UAN_02")) + AliveMembersCount(GetGroupID("Group_Start_UAN_03")) <= 2)) 
	or	(IsEntityInBox(_idPlayer,"Sector_Event_Start_B_00") and (_bComputer_Hacked == 0))then
		if (_bDefreeze_Group_Start_UAN_04 == 0) then
			FreezeAll(GetGroupID("Group_Start_UAN_04"), false)
			Freeze(GetCharacterID("Char_Start_UAN_07_01"), false)
			_bDefreeze_Group_Start_UAN_04 = 1
		end
	end
end


-- defreeze groupe snipers
function Defreeze_Group_Start_UAN_05 ()
	if	(AliveMembersCount(GetGroupID("Group_Start_UAN_04"))<= 2)
	or	(IsEntityInBox(_idPlayer,"Sector_Event_Start_B_01")and (_bComputer_Hacked == 0))then
		if (_bDefreeze_Group_Start_UAN_05 == 0) then
			FreezeAll(GetGroupID("Group_Start_UAN_05"), false)
			_bDefreeze_Group_Start_UAN_05 = 1
		end
	end
end

-- defreeze "grosse attack"
function OnEnter_Sector_Event_Start_B_03 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Start_B_03 == 0) and (_bComputer_Hacked == 0) then
			FreezeAll(GetGroupID("Group_Start_UAN_06"), false)
			FreezeAll(GetGroupID("Group_Start_UAN_08"), false)
			FreezeAll(GetGroupID("Group_Start_UAN_09"), false)
			_bOnEnter_Sector_Event_Start_B_03 = 1
		end
	end
end

-- renforts "grosse attack"
function Defreeze_Group_Start_UAN_10 ()
	if	(AliveMembersCount(GetGroupID("Group_Start_UAN_06"))
			+ AliveMembersCount(GetGroupID("Group_Start_UAN_08"))
			+ AliveMembersCount(GetGroupID("Group_Start_UAN_09")) <= 3)
	or	(IsEntityInBox(_idPlayer,"Sector_Event_Start_B_05")and (_bComputer_Hacked == 0))then
		if (_bDefreeze_Group_Start_UAN_10 == 0) then
			FreezeAll(GetGroupID("Group_Start_UAN_10"), false)
			_bDefreeze_Group_Start_UAN_10 = 1
		end
	end
end

-- Spawn premier entrepot
function OnEnter_Sector_Event_Start_C_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Start_C_01 == 0) and (_bComputer_Hacked == 0)then
			FreezeAll(GetGroupID("Group_Start_UAN_11"), false)
			_bOnEnter_Sector_Event_Start_C_01 = 1
		end
	end
end

-- renfort premier entrepot
function Defreeze_Group_Start_UAN_12 ()
	if	(AliveMembersCount(GetGroupID("Group_Start_UAN_11"))<= 2)
	or	(IsEntityInBox(_idPlayer,"Sector_Event_Start_C_02") and (_bComputer_Hacked == 0))then
		if (_bDefreeze_Group_Start_UAN_12 == 0) then
			FreezeAll(GetGroupID("Group_Start_UAN_12"), false)
			_bDefreeze_Group_Start_UAN_12 = 1
		end
	end
end

-- Spawn deuxième entrepot
function OnEnter_Sector_Event_Start_C_03 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Start_C_03 == 0) and (_bComputer_Hacked == 0) then
			FreezeAll(GetGroupID("Group_Start_UAN_13"), false)
			_bOnEnter_Sector_Event_Start_C_03 = 1
		end
	end
end

-- Spawn après deuxième entrepot
function OnEnter_Sector_Event_Start_C_04 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Start_C_04 == 0) and (_bComputer_Hacked == 0) then
			FreezeAll(GetGroupID("Group_Start_UAN_14"), false)
			_bOnEnter_Sector_Event_Start_C_04 = 1
		end
	end
end

-- renfort après deuxième entrepot
function Defreeze_Char_Start_UAN_15_01 ()
	if	(AliveMembersCount(GetGroupID("Group_Start_UAN_14"))<= 2)
	or	(IsEntityInBox(_idPlayer,"Sector_Event_Start_C_05") and (_bComputer_Hacked == 0))then
		if (_bDefreeze_Char_Start_UAN_15_01 == 0) then
			Freeze(GetCharacterID("Char_Start_UAN_15_01"), false)
			_bDefreeze_Char_Start_UAN_15_01 = 1
		end
	end
end

-- Spawn troisième entrepot
function OnEnter_Sector_Event_Start_C_07 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Start_C_07 == 0) and (_bComputer_Hacked == 0)then
			FreezeAll(GetGroupID("Group_Start_UAN_16"), false)
			_bOnEnter_Sector_Event_Start_C_07 = 1
		end
	end
end

-- l'ingénieur pose une charge sur la porte
function Char_Engineer_Place_C4 ()
		if	(AliveMembersCount(GetGroupID("Group_Start_UAN_16"))
				--+AliveMembersCount(GetGroupID("Group_Start_UAN_14"))
				--+AliveMembersCount(GetGroupID("Group_Start_UAN_13"))  
				<= 0)then
			if (_bC4_First_Door_Placed == 0)then
			MakeCharacterSpeak(_idEngineer,_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_05",true,110,2, 0, "",21)	
		Teletransportation("Repere_Debug",_idEngineer)		
		--	SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_O_Use_Path_Start_E"))
			SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Play_Animation_Code_A"))
			_bC4_First_Door_Placed = 1
			end
		end
end

-- Declenchement de l'explosion
function OnEnter_Sector_Event_Start_D_01 (_idCharInBox)
	--if (_idCharInBox == _idEngineer) then
	--	if (_bC4_First_Door_Placed == 1) then
		--	if (_bOnEnter_Sector_Event_Start_D_01 == 0)then 
		--	SetVarValue(GetTimerID("Timer_Start_C4"),"Active",true)
		--	SetVarValue(GetTimerID("Timer_Start_C4_B"),"Active",true)
		--	SetVarValue(GetSound_ClientID("Sound_Code_A"),"Playing",true)
		--	_bOnEnter_Sector_Event_Start_D_01 = 1
	--		end
	--	end
--	end
end


function Ouverture_Code_A_Sound ()
	SetVarValue(GetSound_ClientID("Sound_Code_A"),"Playing",true)
	CreationTimer(true,true,false,"Ouverture_Code_A",2.5)
end

-- Explosion
-- defreeze du premier groupe Qg derrière la porte
function Ouverture_Code_A ()
	FreezeAll(GetGroupID("Group_QG_UAN_01"), false)
	SetVarValue(GetDoorID("Door_09"),"Locked",false)
	SetVarValue(GetDoorID("Door_09"),"OpenAtContact",true)	
	SetVarValue(GetSound_ClientID("Sound_Code_A"),"Playing",false)
	SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Follow_Player"))	
--	idexplosion = CreateExplosion ()
--	SetVarValue(idexplosion,"Position",Vector3D(882,-1773,21))
--	SetVarValue(idexplosion,"Type","Explosion_Rocket_A")
end

-- l'ingenieur reprend son comportement normal
function Engineer_Follow_Player ()
	SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Follow_Player"))	
end