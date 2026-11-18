function InitLevel()
	CheckInitLevel_convoy()


  InitScriptVariable()
	InitConvoy1()


	AssignChampionToPlayer("Champion_Nolan_Convoy" )

	
	OpenDoor(GetDoorID("Door-BOS_01"))
	OpenDoor(GetDoorID("Door-BOS_02"))
	OpenDoor(GetDoorID("Door-BOS_03"))
	OpenDoor(GetDoorID("Door-BOS_04"))
	OpenDoor(GetDoorID("Door-BOS_05"))
	OpenDoor(GetDoorID("Door-BOS_06"))
end

function OnMissionBegins()

-------------------------------------------------------------
-- :::: CHAMPIONS :::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère l'ID du Champion actif pour la zone 0
		_idChampion_0 = GetChampionFromArea(0)

--------------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires... ETC ::::::: --
--------------------------------------------------------------------

	GlobalGivePlayerHealth()
	--SetVarValue(GetCharacterID("Player"),"Paratrooper",false)
	--SetVarValue(GetCharacterID("Player"),"Paratrooper",true)
	Freeze(GetCharacterID("Player"),true)



--	debug_freeze_debut()---debug
		Cine_Intro_A ()

	_strArmorPlayer = GetVarValue(_idPlayer,"Armor")
	_nArmorBodyPlayer = GetArmorPartHP(_idPlayer,"Body")
	_nArmorLegsPlayer = GetArmorPartHP(_idPlayer,"Legs")
	_strBodyModelPlayer = GetVarValue(_idPlayer,"BodyModel")
	_strHeadModelPlayer = GetVarValue(_idPlayer,"HeadModel")
	_idArsenalPlayer = GetVarValue(_idPlayer,"Arsenal")
	SetVarValue(GetCharacterID("Player_False"),"Armor",_strArmorPlayer)
	SetVarValue(GetCharacterID("Player_False"),"BodyHitPoints",_nArmorBodyPlayer)
	SetVarValue(GetCharacterID("Player_False"),"LegsHitPoints",_nArmorLegsPlayer)
	SetVarValue(GetCharacterID("Player_False"),"Arsenal",_idArsenalPlayer)


end




function UpdateLevel ()
	UpdateLevel_Start 	()
	UpdateLevel_Start2 	()
	UpdateLevel_Start3 	()
	UpdateLevel_City1   ()	
	UpdateLevel_Convoy1 () 

-------------------------------------------------------------
-- :::::::: mort Player - mort INGENIEUR - ...ETC ::::::: --
-------------------------------------------------------------
	GlobalPlayerIsDead()



--debug bot actif
	_nBotActifs = GetTotalActiveCharacterCount()
	PrintDebug("bots actif = " .. _nBotActifs )

--	PrintDebug("_nPosition_Player = " .. 			_nPosition_Player )
	--PrintDebug("_nPosition_Officier = " .. 			_nPosition_Officer )
	


 
	Change_Bot_behavior("Char_UAN_Start2_01_1",70,40,"AI_O_List_Force_Attack_Player")
	Change_Bot_behavior("Char_UAN_Start3_04_1",80,50,"AI_O_List_Force_Attack_Player")
	Change_Bot_behavior("Char_UAN_Start_05_1",50,30,"AI_O_List_Force_Attack_Player")
	Change_Bot_behavior("Char_UAN_Start_05_2",50,30,"AI_O_List_Force_Attack_Player")
	Change_Bot_behavior("Char_UAN_Start3_03_3",80,50,"AI_O_List_Force_Attack_Player")
	Change_Bot_behavior("Char_UAN_Start3_01_1",40,25,"AI_O_List_Force_Attack_Player")

	SetGodMode(GetCharacterID("Char_Syn_Bos_A_01"),true)
	SetGodMode(GetCharacterID("Char_Syn_Bos_A_02"),true)
	SetGodMode(GetCharacterID("Char_Syn_Bos_A_03"),true)
	SetGodMode(GetCharacterID("Char_Syn_Bos_A_04"),true)

	if _idChampion_0 == (GetCharacterID("Char_Champion_0_1"))then
		Champion_Shield_Desactivation_Reloading(_idChampion_0,"Plug_MShield_Champion_0_1")
	end
	if _idChampion_0 == (GetCharacterID("Char_Champion_0_2"))then
		Champion_Shield_Desactivation_Reloading(_idChampion_0,"Plug_MShield_Champion_0_2")
	end
	if _idChampion_0 == (GetCharacterID("Char_Champion_0_3"))then
		Champion_Stop_Turning_Reloading(_idChampion_0,"AI_O_List_Force_Attack_Player")
	end


end



-- debug ------------------------------------
function debug_freeze_debut()
	SetVarValue(GetTimerID("Timer_Start_A_00"),"Active",false)
	FreezeAll(GetGroupID("Group_UAN_Start_01"), true)
	FreezeAll(GetGroupID("Group_UAN_Start_04"), true)
	FreezeAll(GetGroupID("Group_UAN_Start_05"), true)
	FreezeAll(GetGroupID("Group_WRF_Start_00"), true)
	FreezeAll(GetGroupID("Group_UAN_Start_00"), true)
	FreezeAll(GetGroupID("Group_UAN_Start_02"), true)
	FreezeAll(GetGroupID("Group_UAN_Start_03"), true)
	FreezeAll(GetGroupID("Group_CINE_WRF"), true)
	FreezeAll(GetGroupID("Group_CINE_UAN"), true)
	Freeze (_idPlayer, false)
	OpenDoor(GetDoorID("Door_Portal_Begin"))
	OpenDoor(GetDoorID("Door_Portal_Begin1"))
end

function InitScriptVariable()
	_idMusic															= GetSound_ClientID("Sound_Music")
	_idPlayer 														= GetCharacterID("Player")
	_idPlayer_False												= GetCharacterID("Player_False")
	_idOfficier														= GetCharacterID("Char_WRF_Start_02_1")
	_idChampionZone1 											= GetChampionFromArea(0)
	_bObjectif_1_done											= 0 --debug 0
	_bObjectif_2_done											= 0 --debug 0
	_bOnEnter_Sector_Event_Convoy1_A_00 	= 0
	_bTimer_Start_A_00										= 0
	_bDefreeze_Group_UAN_Start_02 				= 0
	_bAllied_Goto_Waypoint_Start_A_01 		= 0
	_bOnEnter_Sector_Event_Start_A_03 		= 0
	_bOnEnter_Sector_Event_Start_A_04			= 0
	_bOnEnter_Sector_Event_Start_A_05 		= 0
	_bOnEnter_Sector_Event_Start_A_06 		= 0
	_bOnEnter_Sector_Event_Start2_A_01 		= 0
	_bDefreeze_Group_UAN_Start2_05 				= 0
	_bOnEnter_Sector_Event_Start3_A_00		= 0
	_bOnEnter_Sector_Event_Start3_A_01		= 0
	_bOnEnter_Sector_Event_Start3_B_01		= 0
	_bOnEnter_Sector_Event_Start3_B_02		= 0
	_bOnEnter_Sector_Event_Start3_C_01		= 0	
	_bOnEnter_Sector_Event_Start3_A_02		= 0
	_bOnEnter_Sector_Event_Start2_A_02    = 0
	_bOnEnter_Sector_Event_Start2_A_03    = 0
	_bOnEnter_Sector_Event_City1_A_01			= 0
	_bOnEnter_Sector_Event_Start3_DEBUG		= 0
	_bNolan_Near_Antenna 									= 0	
	_bOnEnter_Sector_Event_Start2_B_00		= 0
	_bDefreeze_Sniper_Building						= 0
	_bDefreeze_Group_UAN_City1_04					= 0
	_bDefreeze_Char_Champion							= 0
	_bDefreeze_Sniper_Parking							= 0
	_bOnEnter_Sector_Event_City1_B_00			= 0
	_bOnEnter_Sector_Event_City1_B_01			= 0
	_bDefreeze_Group_UAN_City1_01					= 0
	_bDefreeze_Group_UAN_City1_08					= 0
	_bChampion_defreeze										= 0
	_bLife_Global_Convoy1									= 0
	_bArmor_Global_Convoy1								= 0
	_bDefreeze_Convoy1										= 0
	_bGroup_UAN_Convoy1_03_Go_Fighting 		= 0
	_bGroup_UAN_Convoy1_02_Go_Fighting		= 0
	_bGroup_UAN_Convoy1_01_Go_Fighting 		= 0
	_bGroup_UAN_Convoy1_04_Go_Fighting		= 0
	_bGroup_UAN_Convoy1_05_Go_Fighting		= 0
	_bGroup_UAN_Convoy1_06_Go_Fighting		= 0
	_bGroup_UAN_Convoy1_07_Go_Fighting		= 0
	_nPosition_Officer										= 0
	_nPosition_Player											= 0
	_nOfficier_GoTo												= 1
	_bEnd_Of_Mission_01										= 0
	_bOne_EXO_Desactivated								= 0
	_bDefreeze_Defreeze_BOS								= 0
	_bBoS_Done 														= 0
	_bPortal_End_Open											= 0
	_bExo1_Is_Near_Portal									= 0
	_bExo2_Is_Near_Portal									= 0 
	_bMissionFailed_Exo_Destroy						= 0
	_bExo_Nearly_Destroy									= 0
	_bTwo_EXO_Desactivated								= 0
	_bExo_Nearly_Destroy_2								= 0
	_bOnEnter_Sector_Event_Convoy1_B_02 	= 0
	_bOnEnter_Sector_Event_Convoy1_B_01 	= 0
	_bOnEnter_Sector_Event_Start_A_00			= 0
	_nBombardement												= 80
	_bOnEnter_Sector_Event_Start_B_06			= 0


end














 


 


