function UpdateLevel_Camp1 ()

	Defreeze_BOS ()
	Defreeze_Paratroopers_Camp1 ()
	Exo_07_Change_Behavior ()
	Defreeze_Group_WRF_Camp1_03()

end

function Begining()
	ShowCinematicBlackStripes(false)
	EnableCharacterCommand(_idPlayer, true)
	if (_idMerc[1] ~= nil) then
		Freeze(_idMerc[1], false)
	end
	SetVarValue(GetTimerID("Timer_Camp1_00"),"Active",true)	
	SetVarValue(GetTimerID("Timer_Camp1_03"),"Active",true)
	SetVarValue(GetSound_ClientID("Sound_Alarma_01"),"Playing",true)
	SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_05"),"ExoskeletonAI",GetExoskeleton_AIID("Exo_AI_02"))			
	SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_05"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_O_Use_Path_Camp1_D"))
	SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_07"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_O_Use_Path_Camp1_E"))
end



-- premier message radio
function Briefing_01 ()
	if (_bBriefing_01 == 0) then
		RadioMessage("DIA_SPE_NIV_K_GENERAL_RADIO_01", true, 110, 0,"")
		_bBriefing_01 = 1
	end
end

-- OBJECTIF DEPART
function Obj_A_Begin ()
	NewObjectiveNewSubObjective ( "Obj_A", "Obj_A_1" )
end

-- le soldat va vers Nolan
-- timer pour lancement dialogue
function OnEnter_Sector_Event_Camp1_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOn_Enter_Sector_Event_Camp1_A_00 == 0)then
			SetVarValue(GetCharacterID("Char_WRF_Camp1_00_1"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Go_Waypoint_Camp1_C_00"))
			SetVarValue(GetTimerID("Timer_Camp1_01"),"Active",true)
			ShowCinematicBlackStripes(true)
			LaunchCameraTransition(GetCamTransitionID("CamTransition-63"))
			Teletransportation("Char_Cine_Repere_A",_idPlayer)
			if (_idMerc[1] ~= nil) then
				Teletransportation("Char_Cine_Repere_B",_idMerc[1])
			end
			EnableCharacterCommand(_idPlayer, false)
			if (_idMerc[1] ~= nil) then
				EnableCharacterCommand(_idMerc[1], false)
			end
			_bOn_Enter_Sector_Event_Camp1_A_00 = 1
		end
	end
end

function End_Cine_01()
	ShowCinematicBlackStripes(false)
	EnableCharacterCommand(_idPlayer, true)
	if (_idMerc[1] ~= nil) then
				EnableCharacterCommand(_idMerc[1], true)
	end
	SetGodMode(_idPlayer,false)
end


-- après le fin du petite timer, le soldat parle à nolan
-- autre timer pour changer comportement du soldat
function Char_WRF_Camp1_00_1_Near_Player ()
	if (_bChar_WRF_Camp1_00_1_Near_Player == 0) then
		MakeCharacterSpeak(GetCharacterID("Char_WRF_Camp1_00_1"),_idPlayer, "DIA_SPE_NIV_K_USWE_A_01",true,110,2, 0, "",21)
		CharacterPlaySpecialAction(GetCharacterID("Char_WRF_Camp1_00_1"), "STAND COMPLETE MILITARY_SALUT W_ALL_2HAND_LIGHT",false,false)
		SetVarValue(GetTimerID("Timer_Camp1_02"),"Active",true)
		_bChar_WRF_Camp1_00_1_Near_Player = 1
	end
end

-- changement de comportement du soldat, il part au combat
function Char_WRF_Camp1_00_Go_Fighting ()
	SetVarValue(GetCharacterID("Char_WRF_Camp1_00_1"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_O_Use_Path_Camp1_F"))	
end


-- Nolan déclenche les combats
function OnEnter_Sector_Event_Camp1_A_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Camp1_A_01 == 0)then
			FreezeAll(GetGroupID("Group_WRF_Camp1_01"), false)
			FreezeAll(GetGroupID("Group_WRF_Camp1_02"), false)
			Freeze(GetCharacterID("Char_UAN_Camp1_00_1"), false)
		--	Freeze(GetExoskeletonID("Exo_05"), false)
			--Freeze(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_05"), false)
		--	Freeze(GetExoskeletonID("Exo_07"), false)
		--	Freeze(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_07"), false)
			_bOnEnter_Sector_Event_Camp1_A_01 = 1
		end
	end
end


-- defreeze des parachutistes ennemis un par un...
function Defreeze_Paratroopers_Camp1 ()

	if not IsAlive (_idPara_00_1) and IsAlive (_idPara_00_2) and (GetVarValue(_idPara_00_2,"Freeze") == true) then
		Freeze(_idPara_00_2, false)
		if not IsAlive (_idExo_05)then
			Freeze(_idPara_00_3, false)	
		end
		if not IsAlive (_idExo_07)then
			Freeze(_idPara_00_4, false)	
		end
	end

	if not IsAlive (_idPara_00_2)and IsAlive (_idPara_00_3) and (GetVarValue(_idPara_00_3,"Freeze") == true) then
		Freeze(_idPara_00_3, false)
		if not IsAlive (_idExo_05)then
			Freeze(_idPara_00_4, false)	
		end
		if not IsAlive (_idExo_07)then
			Freeze(_idPara_01_1, false)	
		end
	end

	if not IsAlive (_idPara_00_3)and IsAlive (_idPara_00_4) and (GetVarValue(_idPara_00_4,"Freeze") == true) then
		Freeze(_idPara_00_4, false)
		if not IsAlive (_idExo_05)then
			Freeze(_idPara_01_2, false)	
		end
		if not IsAlive (_idExo_07)then
			Freeze(_idPara_01_2, false)	
		end
	end

	if not IsAlive (_idPara_00_4)and IsAlive (_idPara_01_1) and (GetVarValue(_idPara_01_1,"Freeze") == true) then
		Freeze(_idPara_01_1, false)
		if not IsAlive (_idExo_05)then
			Freeze(_idPara_01_2, false)	
		end
		if not IsAlive (_idExo_07)then
			Freeze(_idPara_03_1, false)	
		end
	end

	if not IsAlive (_idPara_01_1)and IsAlive (_idPara_01_2) and (GetVarValue(_idPara_01_2,"Freeze") == true) then
		Freeze(_idPara_01_2, false)
		if not IsAlive (_idExo_05)then
			Freeze(_idPara_02_1, false)	
		end
		if not IsAlive (_idExo_07)then
			Freeze(_idPara_03_1, false)	
		end
	end

	if not IsAlive (_idPara_01_2)and IsAlive (_idPara_02_1) and (GetVarValue(_idPara_02_1,"Freeze") == true) then
		Freeze(_idPara_02_1, false)
		if not IsAlive (_idExo_05)then
			Freeze(_idPara_03_1, false)	
		end
		if not IsAlive (_idExo_07)then
			Freeze(_idPara_03_2, false)	
		end
	end

	if not IsAlive (_idPara_02_1)and IsAlive (_idPara_03_1) and (GetVarValue(_idPara_03_1,"Freeze") == true) then
		Freeze(_idPara_03_1, false)
		if not IsAlive (_idExo_05)then
			Freeze(_idPara_03_2, false)	
		end
		if not IsAlive (_idExo_07)then
			Freeze(_idPara_03_3, false)	
		end
	end

	if not IsAlive (_idPara_03_1)and IsAlive (_idPara_03_2) and (GetVarValue(_idPara_03_2,"Freeze") == true) then
		Freeze(_idPara_03_2, false)
		if not IsAlive (_idExo_05)then
			Freeze(_idPara_03_3, false)	
		end
		if not IsAlive (_idExo_07)then
			Freeze(_idPara_04_1, false)	
		end
	end

	if not IsAlive (_idPara_03_2)and IsAlive (_idPara_03_3) and (GetVarValue(_idPara_03_3,"Freeze") == true) then
		Freeze(_idPara_03_3, false)
		if not IsAlive (_idExo_05)then
			Freeze(_idPara_04_1, false)	
		end
		if not IsAlive (_idExo_07)then
			Freeze(_idPara_04_2, false)
			Freeze(_idPara_04_4, false)
		end
	end

	if not IsAlive (_idPara_03_3)and IsAlive (	_idPara_04_1) and (GetVarValue(	_idPara_04_1,"Freeze") == true) then
		Freeze(	_idPara_04_1, false)
		if not IsAlive (_idExo_05)then
			Freeze(_idPara_04_2, false)
			Freeze(_idPara_04_4, false)	
		end
		if not IsAlive (_idExo_07)then
			Freeze(_idPara_04_3, false)
		end
	end

	if not IsAlive (_idPara_04_1)and IsAlive (_idPara_04_2) and (GetVarValue(_idPara_04_2,"Freeze") == true) then
		Freeze(	_idPara_04_2, false)
		Freeze(_idPara_04_4, false)
		if not IsAlive (_idExo_05)then
			Freeze(_idPara_04_3, false)
		end
	end

	if not IsAlive (_idPara_04_2)and IsAlive (_idPara_04_3) and (GetVarValue(_idPara_04_3,"Freeze") == true) then
		Freeze(	_idPara_04_3, false)
	end

end	

function Exo_07_Change_Behavior ()
	if not IsAlive (_idExo_05)
	and	GetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_07"),"ExoskeletonOrderList") ~= GetAI_Order_ListID("AI_O_List_O_Use_Path_Camp1_D")then
		SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_07"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_O_Use_Path_Camp1_D"))
	end
end

-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------

-- defreeze BOS
function Defreeze_BOS ()
	if 	(AliveMembersCount(GetGroupID("Group_UAN_Camp1_00")) <= 0 ) 
	and (AliveMembersCount(GetGroupID("Group_UAN_Camp1_01")) <= 0 )
	and (AliveMembersCount(GetGroupID("Group_UAN_Camp1_02")) <= 0 )
	and (AliveMembersCount(GetGroupID("Group_UAN_Camp1_03")) <= 0 )
	and (AliveMembersCount(GetGroupID("Group_UAN_Camp1_04")) <= 0)
	and (not IsAlive (GetCharacterID("Char_UAN_Camp2_Pilote_EXO_07")))
	and (not IsAlive (GetCharacterID("Char_UAN_Camp2_Pilote_EXO_05"))) then
		if (_bDefreeze_Defreeze_BOS == 0) then
			StartMusic("Sounds//Music//BoS - Little theme.wav",false)
			Freeze(_idChampion_0, false)
			SetGodMode(_idChampion_0, true)
			EnableCharacterCommand(_idChampion_0, false)
			--SetVarValue(GetTimerID("Timer_Camp1_04"),"Active",true)
			SetVarValue(GetTimerID("Timer_Camp1_05"),"Active",true)			
			_bDefreeze_Defreeze_BOS = 1
		end
	end
end

function Defreeze_BOS_02 ()
	EnableCharacterCommand(_idPlayer, false)
	ShowCinematicBlackStripes(true)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Camp1_A"))
end


-- defreeze BOS
-- WARNING BOS --
function Defreeze_BOS_01 ()
	ShowCinematicBlackStripes(false)
	ReFreeze_All_Char_Camp1()
	g_bBoSEnCours = true
	LaunchBOS(0,"Champion_0_Setup","Champion_0_WarmUp","Champion_0_Combat","Champion_0_OnTimeOut","Champion_0_OnTimeOut","Champion_0_OnTimeOut")
end

function Champion_0_Setup()
	Teletransportation("Char_Champion_0_Repere_Player",_idPlayer)
	if (_idMerc[1] ~= nil) then 
		Teletransportation("Char_Champion_0_Repere_Merc2",_idMerc[1])
		EnableCharacterCommand(_idMerc[1], false)
	end
end


function Champion_0_WarmUp()
	EnableCharacterCommand(_idChampion_0, false)
	EnableCharacterCommand(_idPlayer, true)
	EnableCharacterFire(_idPlayer, false)
end


function Champion_0_Combat()
	SetGodMode(_idChampion_0, false)
	EnableCharacterCommand(_idChampion_0, true)
	EnableCharacterFire(_idPlayer, true)
end


function Champion_0_OnTimeOut()
	if (_idMerc[1] ~= nil) then 
		Freeze(_idMerc[1], false)
		EnableCharacterCommand(_idMerc[1], true)
	end
	Freeze(_idChampion_0, true)
	Defreeze_Group_WRF_Camp2_00()
	g_bBoSEnCours = false
	if IsAlive(_idPlayer) then
		_bBoS_Done = 1
		_nPhase = 2
	end

end





-- Refreeze à faire pendant le BOS
-- Refreeze de tous les UAN et WRF de la pahse Camp1d
function ReFreeze_All_Char_Camp1()
	if (_bReFreeze_All_Char_Camp1 == 0) then
			FreezeAll(GetGroupID("Group_WRF_Camp1_01"), true)
			FreezeAll(GetGroupID("Group_WRF_Camp1_02"), true)
			FreezeAll(GetGroupID("Group_WRF_Camp1_03"), true)
			Freeze(GetCharacterID("Char_WRF_Camp1_00_1"), true)
			FreezeAll(GetGroupID("Group_WRF_Camp1_03"), true)
			_bReFreeze_All_Char_Camp1 = 1
	end
end


-- test pour vérifié si le joueur est dans le tunel de départ
function OnEnter_Sector_Event_Camp1_B_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Camp1_B_00 == 0) then
			_bOnEnter_Sector_Event_Camp1_B_00 = 1
		end
	end	
end

function OnExit_Sector_Event_Camp1_B_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Camp1_B_00 == 1) then
			_bOnEnter_Sector_Event_Camp1_B_00 = 0
		end	
	end
end


-- spawn d'alliés
function Defreeze_Group_WRF_Camp1_03()
	if (_bDefreeze_Group_WRF_Camp1_03 == 0) then	
		if (AliveMembersCount(GetGroupID("Group_WRF_Camp1_01")) <= 0 ) 
		and (_bOnEnter_Sector_Event_Camp1_B_00 == 0) then
			FreezeAll(GetGroupID("Group_WRF_Camp1_03"), false) 
			_bDefreeze_Group_WRF_Camp1_03 = 1
		end
	end
end

-- Si le joueur passe cette zone dans la phase 1, il devient la cible prévilégiée des ennemis
function OnEnter_Sector_Event_Camp1_C_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Camp1_C_00 == 0) then
			SetVarValue(GetGroupID("Group_UAN_Camp1_00"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Force_Target_Player"))	
			SetVarValue(GetGroupID("Group_UAN_Camp1_01"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Force_Target_Player"))	
			SetVarValue(GetGroupID("Group_UAN_Camp1_02"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Force_Target_Player"))	
			SetVarValue(GetGroupID("Group_UAN_Camp1_03"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Force_Target_Player"))
			SetVarValue(GetGroupID("Group_UAN_Camp1_04"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Force_Target_Player"))		
			_bOnEnter_Sector_Event_Camp1_C_00 = 1
		end
	end
end

function OnExit_Sector_Event_Camp1_C_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Camp1_C_00 == 1) then
			SetVarValue(GetGroupID("Group_UAN_Camp1_00"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Go_Waypoint_Camp1_B_00"))	
			SetVarValue(GetGroupID("Group_UAN_Camp1_01"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Go_Waypoint_Camp1_B_00"))	
			SetVarValue(GetGroupID("Group_UAN_Camp1_02"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Go_Waypoint_Camp1_B_00"))	
			SetVarValue(GetGroupID("Group_UAN_Camp1_03"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Go_Waypoint_Camp1_B_00"))
			SetVarValue(GetGroupID("Group_UAN_Camp1_04"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Go_Waypoint_Camp1_B_00"))		
			_bOnEnter_Sector_Event_Camp1_C_00 = 0
		end
	end
end

-- Si le joueur passe cette zone dans la phase 1, quelques ennemis spaw dans la plaine

function OnEnter_Sector_Event_Camp1_C_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if(_nPhase == 1)then
			if (_bOnEnter_Sector_Event_Camp1_C_01 == 0) then
				--FreezeAll(GetGroupID("Group_UAN_Camp1_05"), false)
				_bOnEnter_Sector_Event_Camp1_C_01 = 1
			end
		end
	end
end


function OnExit_Sector_Event_Camp1_C_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Camp1_C_01 == 1) then
		--FreezeAll(GetGroupID("Group_UAN_Camp1_05"), true)
			_bOnEnter_Sector_Event_Camp1_C_01 = 0	
		end
	end
end