function InitLevel()
	CheckInitLevel_hold_that_point_1()

	InitScriptVariable ()
	InitPrecacheDialogue ()	
	
	AssignChampionToPlayer( "Champion_Nolan_Hold_That_Point_0" )



ConfigMerc()


---debug!!!!!!!!
--	Attack_On_Second_Portal ()
--Objectif_1_Done ()


end

function OnMissionBegins()
-------------------------------------------------------------
-- :::: CHAMPIONS :::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère l'ID du Champion actif pour la zone 0
		_idChampion_0 = GetChampionFromArea(0)
		_idChampion_1 = GetChampionFromArea(1)

-------------------------------------------------------------
-- :::: MERCENAIRES :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
		-- Récupère les ID des Mercs actifs : _idMerc[0] et _idMerc[1]
		_idMerc={}
		number = GetMercenaryCount() 
		number = number - 1
		for i=0,number,1 do
				_idMerc[i] = GetMercenary(i) 
		end


--Tracking
		if (_idMerc[1] ~= nil) then
			MiniMapTrack(_idMerc[1], 4, true)
		end


-- ingé
	_idEngineer														= _idMerc[0]
	Freeze(_idEngineer, true)
	if (_idMerc[1] ~= nil) then
		Freeze(_idMerc[1], true)
		G_bCtrl_AliveMerc1 = true
	end
	ShowMercenary(0,false)


	OpenDoor (GetDoorID("Door_Portal_02"))
	OpenDoor (GetDoorID("Door_Portal_05"))

	--OpenDoor(GetDoorID("Door_Portal_04"))-- FOR DEBUG
	--OpenDoor(GetDoorID("Door_Portal_03"))-- FOR DEBUG


--------------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires... ETC ::::::: --
--------------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	Freeze(_idMerc[0],true)





	Cine_Begin_A () --remettre!!!!!!!



--debug
--	SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_TYP_Engineer_2"))
 --Objectif_1_Done ()
--Champion_0_OnTimeOut()



end


function UpdateLevel ()

	UpdateLevel_Camp1 ()
	UpdateLevel_Camp2 ()
	UpdateLevel_Suite1 ()
	UpdateLevel_Suite2 ()

-------------------------------------------------------------
-- :::::::: mort Player - mort INGENIEUR - ...ETC ::::::: --
-------------------------------------------------------------
	GlobalIngenieurIsDead()
	GlobalPlayerIsDead()
	DesactiveTrackingMercs()

	Debug_TELEPORT_1 ()


	if _idChampion_0 == (GetCharacterID("Char_Champion_0_2"))then
		Champion_Shield_Desactivation_Reloading(_idChampion_0,"Plug_MShield_Champion_0_2")
	end

	if _idChampion_0 == (GetCharacterID("Char_Champion_0_3"))then
		Champion_Stop_Turning_Reloading(_idChampion_0,"AI_O_List_Force_Attack_Player_HIGH")
	end

--debug bot actif
	_nBotActifs = GetTotalActiveCharacterCount()
	PrintDebug("bots actif = " .. _nBotActifs )


	PrintDebug("_bOnEnter_Sector_Event_Camp1_B_00 = " .. _bOnEnter_Sector_Event_Camp1_B_00 )


end





function InitScriptVariable()
	_idMusic															= nil
	_idPlayer															= GetCharacterID("Player")
--	_idEngineer														= GetCharacterID("Char_Engineer")
	_idCharInBox													=	nil
	_bOn_Enter_Sector_Event_Camp1_A_00		= 0
	_bChar_WRF_Camp1_00_1_Near_Player			= 0
	_bBriefing_01													= 0
	_bOnEnter_Sector_Event_Camp1_A_01			= 0
	_bDefreeze_Group_UAN_Camp1_01					=	0
	_bDefreeze_Group_UAN_Camp1_02					= 0
	_bDefreeze_Group_UAN_Camp1_03					= 0
	_bOnEnter_Sector_Event_Camp1_B_00 		= 1
	_bDefreeze_Group_WRF_Camp1_03					= 0
	_bDefreeze_Group_UAN_Camp1_04					=	0
	_bOnEnter_Sector_Event_Camp1_C_00 		= 0
	_bOnEnter_Sector_Event_Camp1_C_01			= 0
	_bDefreeze_Char_UAN_Camp1_BOS					= 0
	_nPhase																= 1 -- 1 !!!!!!!!!!!!!!
	_bDefreeze_Group_WRF_Camp2_00					= 0
	_bReFreeze_All_Char_Camp1							= 0
	n_time																= -7
	_nBombardement												=	50
	nShoot																= 50
	_bDefreeze_Assault_1									= 0
	_bDefreeze_Assault_2									=	0
	_bDefreeze_Assault_3									= 0
	_bDefreeze_Assault_4									= 0
	_bDefreeze_Assault_5									= 0
	_bDefreeze_Assault_6									= 0
	_bDefreeze_Assault_7									=	0
	_bDefreeze_Assault_8									= 0
	_bDefreeze_Assault_9									= 0
	_bDefreeze_Assault_10									= 0
	_bDefreeze_Assault_10b								= 0
	_bDefreeze_Assault_11									= 0
	_bDefreeze_Assault_12									=	0
	_bDefreeze_Assault_13									= 0
	_bDefreeze_Assault_14									= 0
	_bDefreeze_Char_WRF_Camp2_01_1				= 0
	_bOnEnter_Sector_Event_Camp2_B_00			= 0
	_bAttack_On_Second_Portal							= 0
	_bDefreeze_Assault_Second_Portal_01		= 0
	_bDefreeze_Assault_Second_Portal_02		= 0
	_bDefreeze_EXO_03											= 0
	_bBehavior_Char_WRF_Camp2_01_1				= 0
	_nPosition_Player											= 0
	_nPosition_Engineer										= 0
	_nEngineer_GoTo												=	1
	_bOnEnter_Sector_Event_Suite1_B_00		= 0
	_bOnEnter_Sector_Event_Suite1_B_01		= 0
	_bDefreeze_Group_UAN_Suite1_01				= 0
	_bOnEnter_Sector_Event_Suite1_B_02		= 0
	_bOnEnter_Sector_Event_Suite1_B_03		= 0
	_bOnEnter_Sector_Event_Suite1_B_04		=	0
	_bDefreeze_Group_UAN_Suite2_03				= 0
	_bOnEnter_Sector_Event_Suite2_A_01		= 0
	_bDefreeze_Group_UAN_Suite2_05				= 0
	_bDefreeze_Group_UAN_Suite2_06				= 0
	_bDefreeze_Group_UAN_Suite2_07				= 0
	_bOnEnter_Sector_Event_Suite2_A_03		= 0
	_bOnEnter_Sector_Event_Suite2_A_04		= 0
	_bDefreeze_Group_UAN_Suite2_Para_02		= 0	
	_bOnEnter_Sector_Event_Suite2_A_05		= 0
	_bOnEnter_Sector_Event_Suite2_A_06		= 0
	_bChar_Engineer_Go_Follow_Near_Mine 	= 0
	_bDefreeze_Char_Engineer							= 0
	_bClose_Second_Portal									= 0
	_bOnEnter_Sector_Event_Suite2_B_00 		= 0
	_bDefreeze_Defreeze_BOS								= 0
	_bDefreeze_Defreeze_BOS2							= 0
	_bBoS2_Done 													= 0
	_bDeath_All_Exo 											= 0
	_nOrder_List_Inge											= 1
	_bEndOfLevel_Hoist										= 0


	--------------------------------------
	--------------------------------------
	_idPara_00_1													= GetCharacterID("Char_UAN_Camp1_00_1")
	_idPara_00_2													= GetCharacterID("Char_UAN_Camp1_00_2")
	_idPara_00_3													= GetCharacterID("Char_UAN_Camp1_00_3")
	_idPara_00_4													= GetCharacterID("Char_UAN_Camp1_00_4")
	_idPara_01_1													= GetCharacterID("Char_UAN_Camp1_01_1")
	_idPara_01_2													= GetCharacterID("Char_UAN_Camp1_01_2")
	_idPara_02_1													= GetCharacterID("Char_UAN_Camp1_02_1")
	_idPara_03_1													= GetCharacterID("Char_UAN_Camp1_03_1")
	_idPara_03_2													= GetCharacterID("Char_UAN_Camp1_03_2")
	_idPara_03_3													= GetCharacterID("Char_UAN_Camp1_03_3")
	_idPara_04_1													= GetCharacterID("Char_UAN_Camp1_04_1")
	_idPara_04_2													= GetCharacterID("Char_UAN_Camp1_04_2")
	_idPara_04_3													= GetCharacterID("Char_UAN_Camp1_04_3")
	_idPara_04_4													= GetCharacterID("Char_UAN_Camp1_04_8")
	_idExo_05															= GetExoskeletonID("Exo_05")
	_idExo_07															= GetExoskeletonID("Exo_07")

--[[
-- debug ingenieur
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_01"),"PriorityTorso",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_01"),"PriorityLegs",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_02"),"PriorityTorso",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_02"),"PriorityLegs",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_03"),"PriorityLegs",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_03"),"PriorityTorso",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_04"),"PriorityLegs",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_04"),"PriorityTorso",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_05"),"PriorityLegs",1)	
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_05"),"PriorityTorso",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_06"),"PriorityLegs",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_06"),"PriorityTorso",1)
	
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_07"),"PriorityLegs",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_07"),"PriorityTorso",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_08"),"PriorityLegs",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_08"),"PriorityTorso",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_09"),"PriorityLegs",1)
	SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Go_Waypoint_Suite1_A_09"),"PriorityTorso",1)
	_nEngineer_GoTo = 10
--]]


end


function InitPrecacheDialogue ()
	PrecacheSentence("DIA_SPE_NIV_K_USWE_D_01")
	PrecacheSentence("DIA_SPE_NIV_K_GENERAL_RADIO_09") 
	PrecacheSentence("DIA_SPE_NIV_K_GENERAL_RADIO_02") 
	PrecacheSentence("DIA_SPE_NIV_K_GENERAL_RADIO_01") 
	PrecacheSentence("DIA_SPE_NIV_K_INGENIEUR_12") 
	PrecacheSentence("DIA_SPE_NIV_K_INGENIEUR_13") 
	PrecacheSentence("DIA_SPE_NIV_K_INGENIEUR_15") 
	PrecacheSentence("DIA_SPE_NIV_K_INGENIEUR_15") 
	PrecacheSentence("DIA_SPE_NIV_K_GENERAL_RADIO_07") 
	PrecacheSentence("DIA_SPE_NIV_K_INGENIEUR_01") 
	PrecacheSentence("DIA_SPE_NIV_K_INGENIEUR_16") 
	PrecacheSentence("DIA_SPE_NIV_K_INGENIEUR_02") 
	PrecacheSentence("DIA_SPE_NIV_K_INGENIEUR_03")
	PrecacheSentence("DIA_SPE_NIV_K_INGENIEUR_17") 
	PrecacheSentence("DIA_SPE_NIV_K_INGENIEUR_18") 
	PrecacheSentence("DIA_SPE_NIV_K_INGENIEUR_02_B") 
	PrecacheSentence("DIA_SPE_NIV_K_USWE_E_01") 
	PrecacheSentence("DIA_SPE_NIV_K_INGENIEUR_03")
	PrecacheSentence("DIA_SPE_NIV_K_USWE_A_01")  
end


