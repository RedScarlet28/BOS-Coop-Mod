function UpdateLevel_Suite2 ()
	Behavior_Char_Engineer2 ()
	Defreeze_Group_UAN_Suite2_03 ()
--	IA_Snipers_Battlefield ()
	Defreeze_Group_UAN_Suite2_05 ()
	Defreeze_Group_UAN_Suite2_06 ()
	Defreeze_Group_UAN_Suite2_07 ()
	Defreeze_Group_UAN_Suite2_Para_02 ()
	Char_Engineer_Go_Follow_Near_Mine()
	Defreeze_BOS2 ()
end

function War_On_The_Battlefield ()
	_nPhase = 4
	FreezeAll(GetGroupID("Group_UAN_Suite2_00"), false)
	FreezeAll(GetGroupID("Group_WRF_Suite2_00"), false)
	FreezeAll(GetGroupID("Group_UAN_Suite2_01"), false)
	FreezeAll(GetGroupID("Group_UAN_Suite2_02"), false)
	StartMusic("Sounds//Music//Bos - War theme.wav",true)
end


-- Comportement  général de l'ingénieur en-dehors du combat
function Behavior_Char_Engineer2 ()
	if IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_09") and (_nPosition_Engineer ~= 9) then
		_nPosition_Engineer = 9
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_09")and (_nPosition_Player ~= 9)then
		_nPosition_Player = 9
	end
	if (_nPosition_Engineer == _nPosition_Player)and (_nPosition_Engineer == 9) and (_nEngineer_GoTo  == 9)then
		_nOrder_List_Inge = 0
		SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_TYP_Mercenary"))
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_09"),"PriorityTorso",1)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_09"),"PriorityLegs",1)	
		SetVarValue(GetTimerID("Timer_Suite2_A_01"),"Active",true)
		MakeCharacterSpeak(_idEngineer,_idPlayer, "DIA_SPE_NIV_K_INGENIEUR_12",true,110,2, 0, "",21)
		_nEngineer_GoTo = 10
	end
	if IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_10") and (_nPosition_Engineer ~= 10) then
		_nPosition_Engineer = 10
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_10")and (_nPosition_Player ~= 10)then
		_nPosition_Player = 10
	end
	if (_nPosition_Engineer == _nPosition_Player)and (_nPosition_Engineer == 10) and (_nEngineer_GoTo  == 10)then
		SetVarValue(GetTimerID("Timer_Suite2_A_02"),"Active",true)
		MakeCharacterSpeak(_idEngineer,_idPlayer, "DIA_SPE_NIV_K_INGENIEUR_13",true,110,2, 0, "",21)
		_nEngineer_GoTo = 11
	end
	if IsEntityInBox(_idEngineer,"Sector_Event_Suite1_A_11") and (_nPosition_Engineer ~= 11) then
		_nPosition_Engineer = 11
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Suite1_A_11")and (_nPosition_Player ~= 11)then
		_nPosition_Player = 11
		if (_bBoS2_Done == 1) and (_bEndOfLevel_Hoist == 0) then
			CreationTimer(true,true,false,"EndOfLevel_Hoist",1.5)
			_bEndOfLevel_Hoist = 1
		end
	end
	if (_nPosition_Engineer == _nPosition_Player)and (_nPosition_Engineer == 11) and (_nEngineer_GoTo  == 11)then
		--EndOfLevel ()
	end
end

function EndOfLevel_Hoist () 
	EndOfLevel ()
end



-- L'ingénieur a dit au joueur qu'il va le suivre
function Char_Engineer_Go_Follow_Player()
	MakeCharacterSpeak(_idEngineer,_idPlayer, "DIA_SPE_NIV_K_INGENIEUR_15",true,110,2, 0, "",21)
	-- obj updated
	SetVarValue(GetTimerID("Timer_Suite2_B_01"),"Active",true)
end

-- OBJ UPDATED
-- cross battlefield
function Obj_B_2_Update ()
	NewSubObjective ( "Obj_B_2", "Obj_B_3")
	MiniMapTrack(_idMerc[0], 2, false)
	MiniMapTrack(_idMerc[0], 4, true)	
end


-- OBJ UPDATED
-- take the hoist
function OnEnter_Sector_Event_Suite2_B_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite2_B_00 == 0) then
				NewSubObjective ( "Obj_B_3", "Obj_B_4")
			_bOnEnter_Sector_Event_Suite2_B_00 = 1
		end
	end
end

-- L'ingénieur a dit au joueur qu'il faut prendre le monte charge
function Char_Engineer_Go_Waypoint_Suite1_A_11 ()
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_10"),"PriorityTorso",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_10"),"PriorityLegs",1)	
end



-- Le dernier BOS est mort, l'ingénieur rejoint l'ascenseur
function Char_Engineer_Go_Follow_Near_Mine()
	if _bBoS2_Done == 1 then
		if(_bChar_Engineer_Go_Follow_Near_Mine == 0) then
			SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_TYP_Engineer_2"))
			_bChar_Engineer_Go_Follow_Near_Mine = 1
		end	
	end
end

-- l'ingénieur passe près de l'arene et dit a Nolan gogo
function OnEnter_Sector_Event_Suite2_A_06 (_idCharInBox)
	if (_idCharInBox == _idEngineer) then
		if (_bOnEnter_Sector_Event_Suite2_A_06 == 0) then
			MakeCharacterSpeak(_idEngineer,_idPlayer, "DIA_SPE_NIV_K_INGENIEUR_15",true,110,2, 0, "",21)	
			_bOnEnter_Sector_Event_Suite2_A_06 = 1
		end
	end
end

-------------------------------------------------------------------
---------------AUTRES BATTLEFIELD----------------------------------
-------------------------------------------------------------------

-- Spawn
function Defreeze_Group_UAN_Suite2_03 ()
	if	(AliveMembersCount(GetGroupID("Group_UAN_Suite2_01")) +  AliveMembersCount(GetGroupID("Group_UAN_Suite2_02"))<= 2 )
	or	(IsEntityInBox(_idPlayer,"Sector_Event_Suite2_A_00")== true )then
		if (_bDefreeze_Group_UAN_Suite2_03 == 0) then
			FreezeAll(GetGroupID("Group_UAN_Suite2_04"), false)
			_bDefreeze_Group_UAN_Suite2_03 = 1
		end
		end
	end



-- Spawn snipers
function OnEnter_Sector_Event_Suite2_A_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite2_A_01 == 0) then
			FreezeAll(GetGroupID("Group_UAN_Suite2_03"), false)
			Freeze(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_06"), false)
			SetVarValue(GetExoskeletonID("Exo_06"),"Freeze",false)
			CreationTimer(true,true,false,"OnEnter_Sector_Event_Suite2_A_01_BIS",15.0)			
			_bOnEnter_Sector_Event_Suite2_A_01 = 1
		end
	end
end


function OnEnter_Sector_Event_Suite2_A_01_BIS ()
	CloseDoor(GetDoorID("Door_Portal_04"))
	CloseDoor(GetDoorID("Door_Portal_03"))
end



-- Spawn 2
function Defreeze_Group_UAN_Suite2_05 ()
	if	(AliveMembersCount(GetGroupID("Group_UAN_Suite2_04"))<= 1 )
	or	(IsEntityInBox(_idPlayer,"Sector_Event_Suite2_A_02") )then
		if (_bDefreeze_Group_UAN_Suite2_05 == 0) then
			FreezeAll(GetGroupID("Group_UAN_Suite2_05"), false)
			Freeze(GetCharacterID("Char_UAN_Suite2_11_1"), false)
			_bDefreeze_Group_UAN_Suite2_05 = 1
		end
	end
end


-- Spawn 3
function Defreeze_Group_UAN_Suite2_06 ()
	if	(AliveMembersCount(GetGroupID("Group_UAN_Suite2_05"))<= 1 )
	or	(IsEntityInBox(_idPlayer,"Sector_Event_Suite2_A_03")== true )then
		if (_bDefreeze_Group_UAN_Suite2_06 == 0) then
			FreezeAll(GetGroupID("Group_UAN_Suite2_06"), false)
			_bDefreeze_Group_UAN_Suite2_06 = 1
		end
	end
end

-- Spawn 4
function Defreeze_Group_UAN_Suite2_07 ()
	if	(AliveMembersCount(GetGroupID("Group_UAN_Suite2_06"))<= 1 )
	or	(IsEntityInBox(_idPlayer,"Sector_Event_Suite2_A_03")== true )then
		if (_bDefreeze_Group_UAN_Suite2_07 == 0) then
			FreezeAll(GetGroupID("Group_UAN_Suite2_07"), false)
			FreezeAll(GetGroupID("Group_UAN_Suite2_08"), false)
			_bDefreeze_Group_UAN_Suite2_07 = 1
		end
	end
end

-- Spawn Parachutistes
function OnEnter_Sector_Event_Suite2_A_03 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite2_A_03 == 0) then
			FreezeAll(GetGroupID("Group_UAN_Suite2_Para_01"), false)
			_bOnEnter_Sector_Event_Suite2_A_03 = 1
		end
	end
end

-------------------------------------------------------------------
---------------AUTRES MINE UPSIDE----------------------------------
-------------------------------------------------------------------

-- Spawn from canyon
function OnEnter_Sector_Event_Suite2_A_04 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite2_A_04 == 0) then
			FreezeAll(GetGroupID("Group_UAN_Suite2_09"), false)
			StopMusic()
			_bOnEnter_Sector_Event_Suite2_A_04 = 1
		end
	end
end

-- Spawn parachutistes 2
function Defreeze_Group_UAN_Suite2_Para_02 ()
	if	(AliveMembersCount(GetGroupID("Group_UAN_Suite2_09"))<= 2 )then
		if (_bDefreeze_Group_UAN_Suite2_Para_02 == 0) then
			FreezeAll(GetGroupID("Group_UAN_Suite2_Para_02"), false)
			_bDefreeze_Group_UAN_Suite2_Para_02 = 1
		end
	end
end

-- Defreeze soldats maisons
function OnEnter_Sector_Event_Suite2_A_05 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite2_A_05 == 0) then
			FreezeAll(GetGroupID("Group_UAN_Suite2_10"), false)
			_bOnEnter_Sector_Event_Suite2_A_05 = 1
		end
	end
end

-- defreeze BOS
function Defreeze_BOS2 ()
	if	((AliveMembersCount(GetGroupID("Group_UAN_Suite2_10"))<= 0) and IsEntityInBox(_idPlayer,"Sector_Event_Suite2_A_06"))
	or (IsEntityInBox(_idPlayer,"Sector_Event_Suite2_C_00")) then
		if (_bDefreeze_Defreeze_BOS2 == 0) then
			SetVarValue(GetTimerID("Timer_Suite2_C_00"),"Active",true)		
			_bDefreeze_Defreeze_BOS2 = 1
		end
	end
end

function Cine_BOS2 ()
	FreezeAllCharactersButBetters()
	Teletransportation("Char_Champion_1_Repere_Player",_idPlayer)
	Freeze(_idChampion_1, false)
	StartMusic("Sounds//Music//BoS - Little theme 2.wav",false)
	ShowCinematicBlackStripes(true)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Suite2_A_00"))
	EnableCharacterCommand(_idPlayer, false)
	EnableCharacterCommand(_idChampion_1, false)
end



-- defreeze BOS
-- WARNING BOS --
function Defreeze_BOS2_02 ()
	ShowCinematicBlackStripes(false)
	LaunchBOS(1,"Champion_1_Setup","Champion_1_WarmUp","Champion_1_Combat", "Champion_1_OnTimeOut", "Champion_1_OnTimeOut", "Champion_1_OnTimeOut") 
	g_bBoSEnCours = true
end


function Champion_1_Setup ()
	if (_idMerc[0] ~= nil) then 
		Teletransportation("Char_Champion_1_Repere_Merc_2",_idMerc[0])
		EnableCharacterCommand(_idMerc[0], false)
		Freeze(_idMerc[0], true)
	end
	if (_idMerc[1] ~= nil) then 
		Teletransportation("Char_Champion_1_Repere_Merc_1",_idMerc[1])
		EnableCharacterCommand(_idMerc[1], false)
		Freeze(_idMerc[1], true)
	end
	Freeze(_idChampion_0, false)
end


function Champion_1_WarmUp()
	EnableCharacterCommand(_idChampion_1, false)
	EnableCharacterCommand(_idPlayer, true)
	EnableCharacterFire(_idPlayer, false)
end

function Champion_1_Combat()
	EnableCharacterCommand(_idChampion_1, true)
	EnableCharacterFire(_idPlayer, true)
end

function Champion_1_OnTimeOut()
	Freeze(_idChampion_1, true)
	if (_idMerc[0] ~= nil) then 
		Freeze(_idMerc[0], false)
		EnableCharacterCommand(_idMerc[0], true)
	end
	if (_idMerc[1] ~= nil) then 
		Freeze(_idMerc[1], false)
		EnableCharacterCommand(_idMerc[1], true)
	end
	g_bBoSEnCours = false
	_bBoS2_Done = 1
end

