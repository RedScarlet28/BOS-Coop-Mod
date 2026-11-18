function UpdateLevel_Suite1 ()
	Defreeze_Char_Engineer ()
	Behavior_Char_Engineer ()
	Behavior_Char_Engineer_Combat ()
	Defreeze_Group_UAN_Suite1_01 ()
	Refresh_Position_Player ()
	Refresh_Position_Inge ()
	Close_Second_Portal ()
	Close_Portal_02 ()
end


-- objectif 1 done
-- passage à la prochaine phase, Suite1
function Objectif_1_Done ()
	if (_nPhase == 2)then
		_nPhase = 3
		RadioMessage("DIA_SPE_NIV_K_GENERAL_RADIO_07", true, 110, 0,"")
		if (_idMerc[1] ~= nil) then
			SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_TYP_Mercenary"))
		end
		StartMusic("Sounds//Music//Bos - South theme.wav",true)
		SetVarValue(GetTimerID("Timer_Suite1_C_01"),"Active",true)		
	end
end

-- OBJECTIF NEW
-- Find the engineer near bunkers
function Obj_B_New ()
	ObjectiveDoneNewObjectiveNewSubObjective ( "Obj_A", "Obj_B", "Obj_B_1" )
	SetVarValue ( GetObjectiveID ("Obj_B_a"),"Active", true )
	MiniMapTrack(_idMerc[0], 2, true)
	ShowMercenary(0,true)
end


-------------------------------------------------------------------
---------------INGENIEUR-------------------------------------------
-------------------------------------------------------------------


-- L'ingénieur est defreezé
function Defreeze_Char_Engineer ()
	if not IsEntityInBox(_idPlayer,"Sector_Event_Camp1_B_00")then
		if (_bDefreeze_Char_Engineer == 0)then
			if (_nPhase == 3) then
				Freeze(_idMerc[0], false)
				MiniMapTrack(_idMerc[0], 2, true)
				ShowCinematicBlackStripes(true)
				LaunchCameraTransition(GetCamTransitionID("CamTransition_Suite1_A_01"))
				EnableCharacterCommand(_idPlayer, false)
				SetGodMode(_idPlayer,true)
				_bDefreeze_Char_Engineer = 1
			end
		end
	end
end

-- cine suite
function Cine_Suite1_A_01()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Suite1_A_02"))
end



-- Comportement  général de l'ingénieur en-dehors du combat
function Behavior_Char_Engineer ()
	if IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_01") and (_nPosition_Engineer ~= 1) then
		_nPosition_Engineer = 1
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_01")and (_nPosition_Player ~= 1)then
		_nPosition_Player = 1
	end
	if (_nPosition_Engineer == _nPosition_Player)and (_nPosition_Engineer == 1) and (_nEngineer_GoTo  == 1)then
		SetVarValue(GetTimerID("Timer_Suite1_A_01"),"Active",true)
		MakeCharacterSpeak(_idEngineer,_idPlayer, "DIA_SPE_NIV_K_INGENIEUR_01",true,110,2, 0, "",60)
		CharacterPlaySpecialAction(_idEngineer, "STAND COMPLETE MILITARY_SALUT W_ALL_2HAND_LIGHT",false,false)
		-- obj updated
		SetVarValue(GetTimerID("Timer_Suite1_C_02"),"Active",true)
		_nEngineer_GoTo = 2
	end
	if IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_02") and (_nPosition_Engineer ~= 2) then
		_nPosition_Engineer = 2
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_02")and (_nPosition_Player ~= 2)then
		_nPosition_Player = 2
	end
	if (_nPosition_Engineer == _nPosition_Player)and (_nPosition_Engineer == 2) and (_nEngineer_GoTo  == 2)then
		SetVarValue(GetTimerID("Timer_Suite1_A_02"),"Active",true)
		MakeCharacterSpeak(_idEngineer,_idPlayer, "DIA_SPE_NIV_K_INGENIEUR_16",true,110,2, 0, "",21)
		CharacterPlaySpecialAction(_idEngineer, "STAND COMPLETE CODE_ACT W_ALL",true,false)
		SetVarValue(GetSound_ClientID("Sound_Code"),"Playing",true)
		_nEngineer_GoTo = 3
	end
		if IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_03") and (_nPosition_Engineer ~= 3) then
		_nPosition_Engineer = 3
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_03")and (_nPosition_Player ~= 3)then
		_nPosition_Player = 3
	end
	if (_nPosition_Engineer == _nPosition_Player)and (_nPosition_Engineer == 3) and (_nEngineer_GoTo  == 3)then
		SetVarValue(GetTimerID("Timer_Suite1_A_03"),"Active",true)
		MakeCharacterSpeak(_idEngineer,_idPlayer, "DIA_SPE_NIV_K_INGENIEUR_02",true,110,2, 0, "",61)
		_nEngineer_GoTo = 4
	end
	if IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_04") and (_nPosition_Engineer ~= 4) then
		_nPosition_Engineer = 4
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_04")and (_nPosition_Player ~= 4)then
		_nPosition_Player = 4
	end
	if (_nPosition_Engineer == _nPosition_Player)and (_nPosition_Engineer == 4) and (_nEngineer_GoTo  == 4)then
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_04"),"PriorityTorso",1)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_04"),"PriorityLegs",1)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_05"),"PriorityTorso",1)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_05"),"PriorityLegs",1)
		Mission_End_Demo()
		--_nEngineer_GoTo = 5
		_nEngineer_GoTo = 6
	end
	if IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_05") and (_nPosition_Engineer ~= 5) then
	--	_nPosition_Engineer = 5
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_05")and (_nPosition_Player ~= 5)then
	--	_nPosition_Player = 5
	end
	if (_nPosition_Engineer == _nPosition_Player)and (_nPosition_Engineer == 5) and (_nEngineer_GoTo  == 5)then
	--	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_05"),"PriorityTorso",1)
		--SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_05"),"PriorityLegs",1)
		_nEngineer_GoTo = 6
	end
	if IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_06") and (_nPosition_Engineer ~= 6) then
		_nPosition_Engineer = 6
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_06")and (_nPosition_Player ~= 6)then
		_nPosition_Player = 6
	end
	if (_nPosition_Engineer == _nPosition_Player)and (_nPosition_Engineer == 6) and (_nEngineer_GoTo  == 6)then
		SetVarValue(GetTimerID("Timer_Suite1_A_06"),"Active",true)
		-- Hot damn! What are we gonna do?… Let's go by the other side
		MakeCharacterSpeak(_idEngineer,_idPlayer, "DIA_SPE_NIV_K_INGENIEUR_03",true,110,2, 0, "",61)
		_nEngineer_GoTo = 7
	end
	if IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_07") and (_nPosition_Engineer ~= 7) then
		_nPosition_Engineer = 7
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_07")and (_nPosition_Player ~= 7)then
		_nPosition_Player = 7
	end
	if (_nPosition_Engineer == _nPosition_Player)and (_nPosition_Engineer == 7) and (_nEngineer_GoTo  == 7)then
			_nOrder_List_Inge = 2
			SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_TYP_Engineer_2"))
			_nEngineer_GoTo = 9
			if (_bClose_Second_Portal == 0)then
				Close_Second_Portal_3 ()
			end
	end
	--if IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_08") and (_nPosition_Engineer ~= 8) then
	--	_nPosition_Engineer = 8
	--end
	--if IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_08")and (_nPosition_Player ~= 8)then
--		_nPosition_Player = 8
	--end
--	if (_nPosition_Engineer == _nPosition_Player)and (_nPosition_Engineer == 8) and (_nEngineer_GoTo  == 8)then
	--	SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_TYP_Engineer_2"))
	--	_nEngineer_GoTo = 9
--	end
end

-- fonction de sécurité
function Refresh_Position_Player ()
	if	(( not IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_01")) and (_nPosition_Player == 1)) 
	or	(( not IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_02")) and (_nPosition_Player == 2)) 
	or	(( not IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_03")) and (_nPosition_Player == 3))
	or	(( not IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_04")) and (_nPosition_Player == 4)) 
	or	(( not IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_05")) and (_nPosition_Player == 5)) 
	or	(( not IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_06")) and (_nPosition_Player == 6)) 
	or	(( not IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_07")) and (_nPosition_Player == 7)) 
	or	(( not IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_08")) and (_nPosition_Player == 8)) 
--	or	(( not IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_09")) and (_nPosition_Player == 9)) 
	or	(( not IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_10")) and (_nPosition_Player == 10)) 
	or	(( not IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_11")) and (_nPosition_Player == 11)) then 
	_nPosition_Player = 0
	end
end

-- fonction de sécurité
function Refresh_Position_Inge ()
	if	(( not IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_01")) and (_nPosition_Player == 1)) 
	or	(( not IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_02")) and (_nPosition_Player == 2)) 
	or	(( not IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_03")) and (_nPosition_Player == 3))
	or	(( not IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_04")) and (_nPosition_Player == 4)) 
	or	(( not IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_05")) and (_nPosition_Player == 5)) 
	or	(( not IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_06")) and (_nPosition_Player == 6)) 
	or	(( not IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_07")) and (_nPosition_Player == 7)) 
	or	(( not IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_08")) and (_nPosition_Player == 8)) 
--	or	(( not IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_09")) and (_nPosition_Player == 9)) 
	or	(( not IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_10")) and (_nPosition_Player == 10)) 
	or	(( not IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_11")) and (_nPosition_Player == 11)) then 
	_nPosition_Engineer = 0
	end
end






-- L'ingénieur attend un peu avant de partir, le tps de parler
function Char_Engineer_Go_Waypoint_Suite1_A_02 ()
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_01"),"PriorityTorso",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_01"),"PriorityLegs",1)
	MakeCharacterSpeak(_idEngineer,_idPlayer, "DIA_SPE_NIV_K_INGENIEUR_17",true,110,2, 0, "",21)
	CharacterPlaySpecialAction(_idEngineer, "STAND MEDHI ORDER_THIS_WAY W_NONE",false,false)
end

-- L'ingénieur attend un peu avant de partir, le tps d'ouvrir la porte
-- ciné ouverture porte
function Char_Engineer_Go_Waypoint_Suite1_A_03()
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_02"),"PriorityTorso",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_02"),"PriorityLegs",1)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Suite1_B_01"))
	ShowCinematicBlackStripes(true)
	EnableCharacterCommand(_idPlayer, false)
	EnableCharacterCommand(_idEngineer, false)
	OpenDoor(GetDoorID"Door_Portal_01") 
end

-- fin cinématique porte
function Cine_Suite1_B_01()
	EnableCharacterCommand(_idPlayer, true)
	EnableCharacterCommand(_idEngineer, true)
	SetVarValue(GetTimerID("Timer_Suite1_A_07"),"Active",true)
	ShowCinematicBlackStripes(false)
	SetVarValue(GetSound_ClientID("Sound_Code"),"Playing",false)	
	CharacterStopSpecialAction(_idEngineer)
end

function Cine_Suite1_B_01_Speak()
	MakeCharacterSpeak(_idEngineer,_idPlayer, "DIA_SPE_NIV_K_INGENIEUR_18",true,110,2, 0, "",21)
end

-- L'ingénieur attend devant le portail et brief un peu
function Char_Engineer_Go_Waypoint_Suite1_A_04()
	MakeCharacterSpeak(_idEngineer,_idPlayer, "DIA_SPE_NIV_K_INGENIEUR_02_B",true,110,2, 0, "",21)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_03"),"PriorityTorso",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_03"),"PriorityLegs",1)
end

-- L'ingénieur attend pendant qu'il constate les dégats de la mine
function Char_Engineer_Go_Waypoint_Suite1_A_07()
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_06"),"PriorityTorso",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_06"),"PriorityLegs",1)
end


-- l'ingénieur change de comportement si il a du stress
-- il retourne a ses waypoints si il n'y a plus de stress

function Behavior_Char_Engineer_Combat ()
	if (_nPosition_Engineer < 3 )then
		if (GetCharacterStressState(_idEngineer)== 2)then		
			if GetVarValue(_idEngineer,"CharacterOrderList") ~= GetAI_Order_ListID("AI_O_List_EMPTY")then
				SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_EMPTY"))
				SetVarValue(_idEngineer,"CharacterOrderList",GetInvalidEntityID())
			end	
		else
			if (_nOrder_List_Inge == 1) then
				if GetVarValue(_idEngineer,"CharacterOrderList") ~= GetAI_Order_ListID("AI_O_List_TYP_Engineer_1")then
					SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_TYP_Engineer_1"))				end
			end	
			if (_nOrder_List_Inge == 2) then
				if GetVarValue(_idEngineer,"CharacterOrderList") ~= GetAI_Order_ListID("AI_O_List_TYP_Engineer_2")then
						SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_TYP_Engineer_2"))
				end	
			end
		end	
	end
end


-------------------------------------------------------------------
---------------AUTRES----------------------------------------------
-------------------------------------------------------------------

-- Follow the engineer
function Obj_B_Update ()
	NewSubObjective ( "Obj_B_1", "Obj_B_2")
end



-- Nolan et l'ingénieur déclemenche la fermeture de la port
-- freeze des gars qui servent plus à rien
function Close_Second_Portal ()
	if (_idMerc[1] ~= nil) then
		if IsEntityInBox(_idPlayer,"Sector_Event_Suite1_C_00")
		and	IsEntityInBox(_idEngineer,"Sector_Event_Suite1_C_00")
		and	IsEntityInBox(_idMerc[1],"Sector_Event_Suite1_C_00")
		and (_bClose_Second_Portal == 0)then
			Close_Second_Portal_2 ()
		end
	else
		if IsEntityInBox(_idPlayer,"Sector_Event_Suite1_C_00")
		and	IsEntityInBox(_idEngineer,"Sector_Event_Suite1_C_00")
		and (_bClose_Second_Portal == 0)then
			Close_Second_Portal_2 ()
		end
	end
end

function Close_Second_Portal_2 ()
	CloseDoor(GetDoorID("Door_Portal_01"))
	FreezeAll(GetGroupID("Group_UAN_Suite1_00"), true)
	Freeze(GetCharacterID("Char_WRF_Camp2_01_1"), true)
	FreezeAll(GetGroupID("Group_WRF_Camp2_00"), true)
	FreezeAll(GetGroupID("Group_UAN_Camp2_11"), true)	
	FreezeAll(GetGroupID("Group_UAN_Camp2_06"), true)
	FreezeAll(GetGroupID("Group_UAN_Camp2_24"), true)
	FreezeAll(GetGroupID("Group_UAN_Camp2_13"), true)
	FreezeAll(GetGroupID("Group_UAN_Camp2_05"), true)
	FreezeAll(GetGroupID("Group_UAN_Camp2_25"), true)
	FreezeAll(GetGroupID("Group_UAN_Camp2_23"), true)
	FreezeAll(GetGroupID("Group_UAN_Camp2_Para_03"), true)
	Freeze(GetExoskeletonID("Exo_05"), true)
	Freeze(GetExoskeletonID("Exo_07"), true)
	_bClose_Second_Portal = 1
end

-- si le merc1 est resté dans le camp depuis Suite1
-- teleportation du merc1 devant le portal 2
function Close_Second_Portal_3 ()
	if (_idMerc[1] ~= nil) then
		Teletransportation("Char_Portal2_Repere_Merc_1",_idMerc[1])
	end
	Close_Second_Portal_2 ()
end



-- Nolan ou l'ingénieur déclenchent spawn
function OnEnter_Sector_Event_Suite1_B_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer)or(_idCharInBox == _idEngineer)  then
		if (_bOnEnter_Sector_Event_Suite1_B_00 == 0) then
		--	FreezeAll(GetGroupID("Group_WRF_Camp2_00"), false)
			_bOnEnter_Sector_Event_Suite1_B_00 = 1
		end
	end
end

-- mort du premier groupe déclenche un autre spawn
function OnEnter_Sector_Event_Suite1_B_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) or (_idCharInBox == _idEngineer) then
		if (_bOnEnter_Sector_Event_Suite1_B_01 == 0) then
			FreezeAll(GetGroupID("Group_UAN_Suite1_01"), false)
			_bOnEnter_Sector_Event_Suite1_B_01 = 1
		end
	end
end

-- Sécurité pour le spawn d'avants
function Defreeze_Group_UAN_Suite1_01 ()
	if	(AliveMembersCount(GetGroupID("Group_UAN_Suite1_00")) <= 1 )then
		if (_bDefreeze_Group_UAN_Suite1_01 == 0) then
			FreezeAll(GetGroupID("Group_UAN_Suite1_01"), false)
			_bDefreeze_Group_UAN_Suite1_01 = 1
		end
	end
end


-- FERMETURE PORTAL 3
function Close_Portal_02 ()
	if IsEntityInBox(_idPlayer,"Sector_Event_Suite1_B_04")
	or	IsEntityInBox(_idEngineer,"Sector_Event_Suite1_B_04")then
		if IsDoorOpened(GetDoorID("Door_Portal_02")) then
			CloseDoor (GetDoorID("Door_Portal_02"))
			CloseDoor (GetDoorID("Door_Portal_05"))
		end
	end
end


-- petit spawn dans la gallerie
function OnEnter_Sector_Event_Suite1_B_03 (_idCharInBox)
	if (_idCharInBox == _idPlayer) or (_idCharInBox == _idEngineer) then
		if (_bOnEnter_Sector_Event_Suite1_B_03 == 0) then
			FreezeAll(GetGroupID("Group_UAN_Suite1_03"), false)
			_bOnEnter_Sector_Event_Suite1_B_03 = 1
		end
	end
end



-- Passage à Suite2
function OnEnter_Sector_Event_Suite1_A_08 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite1_B_04 == 0) then
			War_On_The_Battlefield ()
			_bOnEnter_Sector_Event_Suite1_B_04 = 1
		end
	end
end
