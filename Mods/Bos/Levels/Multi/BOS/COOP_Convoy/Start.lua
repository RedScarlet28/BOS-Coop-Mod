function UpdateLevel_Start ()
	if(_bObjectif_1_done == 0)then
		Defreeze_Group_UAN_Start_02()
		Allied_Goto_Waypoint_Start_A_01()
		Behavior_Char_Officer ()
	end
end


-- CINE
function Cine_Intro_A ()
	StopMusic()
	StartMusic("Sounds//Music//Bos - War theme.wav",false)
	ShowCinematicBlackStripes(true)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Cine_A"))
	EnableCharacterCommand(_idPlayer, false)
end

function Cine_Intro_B ()
	SetVarValue(_idPlayer_False,"Armor",GetVarValue(_idPlayer,"Armor"))
	Freeze (_idPlayer_False, false)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Cine_B"))
end

--		
function Cine_Intro_End ()
	rCountDown = 235
 	idTimerCountDown_1 = CreateTimer()
 	SetVarValue(idTimerCountDown_1, "Active", true)
	SetVarValue(idTimerCountDown_1, "DestroyOnExpire", false)
 	SetVarValue(idTimerCountDown_1, "Loop", true)
	SetVarValue(idTimerCountDown_1, "TriggerFunction", "CountDown_1")
	SetVarValue(idTimerCountDown_1, "Duration", 1.0)
	Freeze (_idPlayer_False, true)
	Freeze (_idPlayer, false)
	EnableCharacterCommand(_idPlayer, true)
	FreezeAll(GetGroupID("Group_CINE_UAN"), true)
	FreezeAll(GetGroupID("Group_UAN_Start_01"), false)
	SetVarValue(GetTimerID("Timer_Start_B_00"),"Active",true)
	SetVarValue(GetTimerID("Timer_Start_A_00"),"Active",true)
	SetVarValue(GetTimerID("Timer_Start_C_00"),"Active",true)
	CreationTimer(true, false, false, "Cine_Intro_End_2", 4.5)
	ShowCinematicBlackStripes(false)
	SetVarValue(GetCharacterID("Char_WRF_Start_00_1"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_EMPTY"))
	SetVarValue(GetCharacterID("Char_WRF_Start_00_2"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_EMPTY"))
	SetVarValue(GetCharacterID("Char_WRF_Start_00_3"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_EMPTY"))
end

function Cine_Intro_End_2 ()
	FreezeAll(GetGroupID("Group_CINE_WRF"), true)	
end

-- MINUTEUR
function CountDown_1()
	if (_bObjectif_1_done == 0)
	and (GetHealth(_idPlayer)> 0)
	and (_bDefreeze_Defreeze_BOS == 0)then
 		rCountDown = rCountDown - 1
		if (rCountDown > 30)then
			Display_CountDown(rCountDown)
			elseif ( rCountDown == -1 ) then
 		 	ReleaseEntity(idTimerCountDown_1)
		else
			Display_CountDown_red(rCountDown)
			SetVarValue(GetSound_ClientID("Sound_CountDown"), "Playing", true)
		end
	end
end


-- dialogue de début radio
function Timer_dialogue_1()
	--MakeCharacterSpeak(_idPlayer,"DIA_SPE_NIV_J_GENERAL_RADIO_01",true,2)
	RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_01", true, 110, 0,"")
	SetVarValue(GetTimerID("Timer_Start_D_00"),"Active",true)
end

-- NEW OBJECTIVE
function New_Obj_A ()
	NewObjectiveNewSubObjective ("Obj_A","Obj_A_1")
	SetVarValue ( GetObjectiveID ("Obj_A_a"),"Active", true )
end


-- Spawn du premier groupe d'ennemis qui arrivent vers joueur
function OnEnter_Sector_Event_Start_A_00(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bObjectif_1_done == 0) and (_bOnEnter_Sector_Event_Start_A_00 == 0)then
			Timer_Start_A_00 ()
			Freeze (GetCharacterID("Char_PARA_FAKE_WRF_01"),false)
			CreationTimer(true,true,false,"Char_PARA_FAKE_WRF_01_Refreeze",15)
			_bOnEnter_Sector_Event_Start_A_00 = 1
		end
	end
end

function Char_PARA_FAKE_WRF_01_Refreeze ()
	Freeze (GetCharacterID("Char_PARA_FAKE_WRF_01"),true)
end


function Timer_Start_A_00 ()
	if (_bTimer_Start_A_00 == 0) then
		if (_bObjectif_1_done == 0)then
			FreezeAll(GetGroupID("Group_UAN_Start_00"), false)
			_bTimer_Start_A_00 = 1
		end	
	end
end

-- Spawn du premier groupe d'ennemis qui arrivent vers joueur
function OnEnter_Sector_Event_Start_A_01(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bObjectif_1_done == 0)then
			Defreeze_Group_UAN_Start_02 ()
		end
	end
end

function Defreeze_Group_UAN_Start_02 ()
	if (_bDefreeze_Group_UAN_Start_02 == 0) then
		if ( AliveMembersCount(GetGroupID("Group_UAN_Start_00")) <= 1 ) then
			if (_bObjectif_1_done == 0)then
				FreezeAll(GetGroupID("Group_UAN_Start_02"), false)
				_bDefreeze_Group_UAN_Start_02 = 1	
			end		
		end
	end
end

-- Les alliés avacent un peu
function Allied_Goto_Waypoint_Start_A_01 ()
	if (_bAllied_Goto_Waypoint_Start_A_01 == 0) then
		if ( AliveMembersCount(GetGroupID("Group_UAN_Start_00")) < 1 ) then
			if ( AliveMembersCount(GetGroupID("Group_UAN_Start_02")) < 1 ) then
			SetVarValue(GetGroupID("Group_WRF_Start_00"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Typ_WRF_Start_A_00"))	
			_bAllied_Goto_Waypoint_Start_A_01 = 1			
			end
		end
	end
end


-- Nolan passe la porte et défreeze un petit groupe & des snipers
function OnEnter_Sector_Event_Start_A_03(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
			if (_bOnEnter_Sector_Event_Start_A_03 == 0) then
				if (_bObjectif_1_done == 0)then
					FreezeAll(GetGroupID("Group_UAN_Start_03"), false)
					FreezeAll(GetGroupID("Group_UAN_Start2_01"), false)
					_bOnEnter_Sector_Event_Start_A_03 = 1
				end			
			end
	end
end

-- Nolan passe une boite les alliés suivent
-- Il defreeze des gars dans la rue qui vont se battre(WRF vs UAN)
function OnEnter_Sector_Event_Start_A_04(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
			if (_bOnEnter_Sector_Event_Start_A_04 == 0) then
				if (_bObjectif_1_done == 0)then
					SetVarValue(GetGroupID("Group_WRF_Start_00"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Typ_WRF_Start_A_01"))	
					Freeze(GetCharacterID("Char_WRF_Start2_01_1"), false)
					FreezeAll(GetGroupID("Group_UAN_Start2_04"), false)
					_bOnEnter_Sector_Event_Start_A_04 = 1	
				end		
			end
	end
end

-- un UAN change de abandonne son crouh
function ExpirationChar_UAN_Start_03_2_Crouching(idCharacter)
    if ((idCharacter == GetCharacterID("Char_UAN_Start_03_2")))then 
			if (_bOnEnter_Sector_Event_Start_A_04 == 1 )then
        return true
			end
    end
    return false
end


-- Nolan passe la porte et défreeze un petit groupe sur la première terrasse
function OnEnter_Sector_Event_Start_A_05(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Start_A_05 == 0) then
			if (_bObjectif_1_done == 0)then
				FreezeAll(GetGroupID("Group_UAN_Start_05"), false)
				FreezeAll(GetGroupID("Group_WRF_Start_01"), false)
				_bOnEnter_Sector_Event_Start_A_05 = 1
			end		
		end
	end
end

-- un autre UAN change de abandonne son crouh
function ExpirationChar_UAN_Start_03_3_Crouching(idCharacter)
  if (idCharacter == GetCharacterID("Char_UAN_Start_03_3"))then 
		if  (_bOnEnter_Sector_Event_Start_A_05 == 1 )then
    	return true
    end
	end
	return false
end


-- Nolan passe la porte et défreeze un petit groupe sous la première terrasse
-- Nolan passe la porte et défreeze un groupe qui vient du buidling
-- Nolan passe la porte et défreeze des snipers dans les entrepots
-- Les alliés avacent jusqu'à la terrasse et resteront dans les parages
-- Baisse de la vie des premiers alliés si ils sont arrivés vivants jusqu'ici (sauf le leader)
function OnEnter_Sector_Event_Start_A_06(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
			if (_bOnEnter_Sector_Event_Start_A_06 == 0) then
				if (_bObjectif_1_done == 0)then
					FreezeAll(GetGroupID("Group_UAN_Start2_02"), false)
					Freeze(GetCharacterID("Char_UAN_Start2_03_2"), false)
					SetVarValue(GetGroupID("Group_WRF_Start_00"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Typ_WRF_Start_A_02"))			
							
					Freeze (GetCharacterID("Char_PARA_FAKE_WRF_02"),false)
					CreationTimer(true,true,false,"Char_PARA_FAKE_WRF_02_Refreeze",10)
					_bOnEnter_Sector_Event_Start_A_06 = 1
				end			
			end
	end
end


function Char_PARA_FAKE_WRF_02_Refreeze ()
	Freeze (GetCharacterID("Char_PARA_FAKE_WRF_02"),true)
	Freeze (GetCharacterID("Char_PARA_FAKE_WRF_03"),false)
	CreationTimer(true,true,false,"Char_PARA_FAKE_WRF_03_Refreeze",25)
end

function Char_PARA_FAKE_WRF_03_Refreeze ()
	Freeze (GetCharacterID("Char_PARA_FAKE_WRF_03"),true)
end

-- TIMER DE L'OBJECTIF
function Timer_Start_Objectif_1()
	if (_bObjectif_1_done == 0)then
		RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_02", true, 110, 0,"")
		SetVarValue(GetTimerID("Timer_Start_B_01"),"Active",true)
	end
end

function Timer_Start_Objectif_2()
	if (_bObjectif_1_done == 0)then
		SetVarValue(GetTimerID("Timer_Start_B_02"),"Active",true)
		RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_03", true, 110, 0,"")
	end	
end

function Timer_Start_Objectif_3()
	if (_bObjectif_1_done == 0)then
		RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_06", true, 110, 0,"")
		MissionFailed ("HUD_MISSION_FAILED_REASON_05")
		_bObjectif_1_done = 2
	end	
end

-------------------------------------------------------------------
---------------OFFICIER-------------------------------------------
-------------------------------------------------------------------

-- Comportement de l'officier qui montre le chemein à Nolan
function Behavior_Char_Officer ()
	if IsEntityInBox(_idOfficier,"Sector_Event_Start_B_01") and (_nPosition_Officer ~= 1) then
		_nPosition_Officer = 1
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Start_B_01")and (_nPosition_Player ~= 1)then
		_nPosition_Player = 1
	end
	if (_nPosition_Officer <= _nPosition_Player)and (_nPosition_Officer == 1) and (_nOfficier_GoTo  == 1)then
		MakeCharacterSpeak(_idOfficier,_idPlayer, "DIA_SPE_NIV_J_USWE_A_1",true,110,2, 0, "",11)
		CharacterPlaySpecialAction(_idOfficier, "STAND MEDHI ORDER_GO W_NONE",false,false)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Start_B_01"),"PriorityTorso",1)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Start_B_01"),"PriorityLegs",1)
		_nOfficier_GoTo = 2
	end
	if IsEntityInBox(_idOfficier,"Sector_Event_Start_B_02") and (_nPosition_Officer ~= 2) then
		CharacterPlaySpecialAction(_idOfficier, "STAND MEDHI ORDER_STOP W_NONE",false,false)
		_nPosition_Officer = 2
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Start_B_02")and (_nPosition_Player ~= 2)then
		_nPosition_Player = 2
	end
	if (_nPosition_Officer <= _nPosition_Player)and (_nPosition_Officer == 2) and (_nOfficier_GoTo  == 2)then
		MakeCharacterSpeak(_idOfficier,_idPlayer, "DIA_SPE_NIV_J_USWE_A_2",true,110,2, 0, "",11)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Start_B_02"),"PriorityTorso",1)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Start_B_02"),"PriorityLegs",1)
		_nOfficier_GoTo = 3
	end
	if IsEntityInBox(_idOfficier,"Sector_Event_Start_B_03") and (_nPosition_Officer ~= 3) then
		_nPosition_Officer = 3
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Start_B_03")and (_nPosition_Player ~= 3)then
		_nPosition_Player = 3
	end
	if (_nPosition_Officer <= _nPosition_Player)and (_nPosition_Officer == 3) and (_nOfficier_GoTo  == 3)then
		MakeCharacterSpeak(_idOfficier,_idPlayer, "DIA_SPE_NIV_J_USWE_A_3",true,110,2, 0, "",11)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Start_B_03"),"PriorityTorso",1)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Start_B_03"),"PriorityLegs",1)
		_nOfficier_GoTo = 4
	end
	if IsEntityInBox(_idOfficier,"Sector_Event_Start_B_04") and (_nPosition_Officer ~= 4) then
		_nPosition_Officer = 4
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Start_B_04")and (_nPosition_Player ~= 4)then
		_nPosition_Player = 4
		-- obj_A_2 -- HERE --
		NewSubObjective ( "Obj_A_1", "Obj_A_2")
	end
	if (_nPosition_Officer <= _nPosition_Player)and (_nPosition_Officer == 4) and (_nOfficier_GoTo  == 4)then
		MakeCharacterSpeak(_idOfficier,_idPlayer, "DIA_SPE_NIV_J_USWE_A_4",true,110,2, 0, "",11)
		CharacterPlaySpecialAction(_idOfficier, "STAND MEDHI ORDER_GO W_NONE",false,false)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Start_B_04"),"PriorityTorso",1)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Start_B_04"),"PriorityLegs",1)
		_nOfficier_GoTo = 5
	end
	if IsEntityInBox(_idOfficier,"Sector_Event_Start_B_05") and (_nPosition_Officer ~= 5) then
		_nPosition_Officer = 5
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Start_B_05b")and (_nPosition_Player ~= 5)then
		_nPosition_Player = 5
	end
	if (_nPosition_Officer <= _nPosition_Player)and (_nPosition_Officer == 5) and (_nOfficier_GoTo  == 5)then
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Start_B_05"),"PriorityTorso",1)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Start_B_05"),"PriorityLegs",1)
		_nOfficier_GoTo = 6
	end
	if IsEntityInBox(_idOfficier,"Sector_Event_Start_B_06") and (_nPosition_Officer ~= 6) then
		_nPosition_Officer = 6
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Start_B_06")and (_nPosition_Player ~= 6)then
		_nPosition_Player = 6
	end
	if (_nPosition_Officer <= _nPosition_Player)and (_nPosition_Officer == 6) and (_nOfficier_GoTo  == 6)then
		CharacterPlaySpecialAction(_idOfficier, "STAND MEDHI ORDER_THIS_WAY W_NONE",false,false)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Start_B_06"),"PriorityTorso",1)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Start_B_06"),"PriorityLegs",1)
		_nOfficier_GoTo = 7
	end
		if IsEntityInBox(_idOfficier,"Sector_Event_Start_B_07") and (_nPosition_Officer ~= 7) then
		_nPosition_Officer = 7
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_Start_B_07")and (_nPosition_Player ~= 7)then
		_nPosition_Player = 7
	end
	if (_nPosition_Officer <= _nPosition_Player)and (_nPosition_Officer == 7) and (_nOfficier_GoTo  == 7)then
	SetVarValue(_idOfficier,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Follow_Player"))
	end
end