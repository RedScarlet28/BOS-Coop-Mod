------------------------------------------------------------
------------------------------------------------------------

-- ::: InitLevel :::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function InitLevel()
	CheckInitLevel_patrol_1()

		InitScriptVariable()
		InitLevel_Camp_1()
		InitLevel_Trench_1()
		InitLevel_Trench_2()
		InitLevel_Sport()
--		InitLevel_Tips()

		_nBotActive=GetTotalActiveCharacterCount()
		_nBotAlive=GetTotalAliveCharacterCount()

--		AddPlayerMoney(-GetPlayerMoney())
-- 		AddPlayerMoney(18000)
		StartMusic("Sounds//Music//BoS - Big Boy theme.wav",true)	
		SoundPrecache()
		ConfigMerc()
		SetGodMode(GetCharacterID("Char_WRF_Trench_2_04_1"),true)
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: OnMissionBegins :::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnMissionBegins()

-------------------------------------------------------------
-- :::::::: CHAMPIONS :::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

-- Aucun Champion dans ce Load

-------------------------------------------------------------
-- :::::::: MERCENAIRES :::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère les ID des Mercs actifs : _idMerc[0] et _idMerc[1]
		_idMerc={}
		number = GetMercenaryCount() 
		number = number - 1
		for i=0,number,1 do
				_idMerc[i] = GetMercenary(i)
				SetVarValue(_idMerc[i],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Char_Merc"))
		end
		
		-- Active l'affichage des Mercs sur la map
		ActiveTrackingMercs()

	
-------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires ::::::: --
-------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	
		Debut()

--GoAccesNord()
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: UpdateLevel :::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function UpdateLevel()

		UpdateLevel_Camp_1()
		UpdateLevel_Trench_1()
		UpdateLevel_Trench_2()
		UpdateLevel_Sport()

--		UpdateLevel_Tips()
-----------------------------------------------------------------
-- :::::::: Debug :::::::::::::::::::::::::::::::::::::::::::: --
-----------------------------------------------------------------

		_nBotActive=GetTotalActiveCharacterCount()
--		_nBotAlive=GetTotalAliveCharacterCount()
		PrintDebug("Bots actifs: ".._nBotActive)
--		PrintDebug("Bots vivants: ".._nBotAlive)

-----------------------------------------------------------------
-- :::::::: Mission Failed ::::::::::::::::::::::::::::::::::: --
-----------------------------------------------------------------

		GlobalPlayerIsDead()

-----------------------------------------------------------------
-- :::::::: Tracking de Mercs :::::::::::::::::::::::::::::::: --
-----------------------------------------------------------------

		-- Désactive l'affichage des Mercs sur la map
		DesactiveTrackingMercs()

end


------------------------------------------------------------
------------------------------------------------------------

-- ::: InitScriptVariable ::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function InitScriptVariable()

-- Déclaration des "CharacterID"
	--WRF
		_idPlayer=GetLocalCharacterID()
--		_idMerc[0]=GetCharacterID("Char_Merc_1")
--		_idMerc[1]=GetCharacterID("Char_Merc_2")

		--Camp_1
		_idCharacter_Teleport=GetCharacterID("Character_Teleport")
		_idCharacter_Teleport1=GetCharacterID("Character_Teleport1")
		_idCharacter_Teleport2=GetCharacterID("Character_Teleport2")

		_idChar_WRF_Camp_1_Caporal=GetCharacterID("Char_WRF_Camp_1_Caporal")
		_idChar_WRF_Solberg_Camp_1=GetCharacterID("Char_WRF_Camp_1_Solberg")

		_idChar_WRF_Camp_1_01_1=GetCharacterID("Char_WRF_Camp_1_01_1")
		_idChar_WRF_Camp_1_01_2=GetCharacterID("Char_WRF_Camp_1_01_2")
		_idChar_WRF_Camp_1_01_3=GetCharacterID("Char_WRF_Camp_1_01_3")
		_idChar_WRF_Camp_1_01_4=GetCharacterID("Char_WRF_Camp_1_01_4")
		_idChar_WRF_Camp_1_01_5=GetCharacterID("Char_WRF_Camp_1_01_5")
		--------------
		--_idChar_WRF_Camp_1_01_5=GetCharacterID("Char_WRF_Camp_1_01_5")
		--	_idAI_Order_List_Peloton_1=GetAI_Order_ListID("AI_Order_List_Peloton_1")
	--	_idChar_WRF_Camp_1_01_6=GetCharacterID("Char_WRF_Camp_1_01_6")
	--		_idAI_Order_List_Peloton_2=GetAI_Order_ListID("AI_Order_List_Peloton_2")
		----------------

		_idChar_WRF_Camp_1_02_1=GetCharacterID("Char_WRF_Camp_1_02_1")
		_idChar_WRF_Camp_1_02_2=GetCharacterID("Char_WRF_Camp_1_02_2")
		_idChar_WRF_Camp_1_02_3=GetCharacterID("Char_WRF_Camp_1_02_3")
		_idChar_WRF_Camp_1_03_5=GetCharacterID("Char_WRF_Camp_1_03_5")
		_idChar_WRF_Camp_1_04_1=GetCharacterID("Char_WRF_Camp_1_04_1")

		_idChar_WRF_Camp_1_Garde=GetCharacterID("Char_WRF_Camp_1_Garde")
		_idChar_WRF_Camp_1_1=GetCharacterID("Char_WRF_Camp_1_1")

		--Trench_1

		--Trench_2
		_idChar_WRF_Trench_2_02_1=GetCharacterID("Char_WRF_Trench_2_02_1")
		_idChar_WRF_Trench_2_02_2=GetCharacterID("Char_WRF_Trench_2_02_2")
		_idChar_WRF_Trench_2_03_1=GetCharacterID("Char_WRF_Trench_2_03_1")
		_idChar_WRF_Trench_2_03_2=GetCharacterID("Char_WRF_Trench_2_03_2")
		_idChar_WRF_Trench_2_03_3=GetCharacterID("Char_WRF_Trench_2_03_3")
		_idChar_WRF_Trench_2_04_1=GetCharacterID("Char_WRF_Trench_2_04_1")
		_idChar_WRF_Trench_2_1=GetCharacterID("Char_WRF_Trench_2_1")
		_idChar_WRF_Trench_2_2=GetCharacterID("Char_WRF_Trench_2_2")

	--UAN
		_idChar_UAN_Trench_2_1=GetCharacterID("Char_UAN_Trench_2_1")
		_idChar_UAN_Trench_2_2=GetCharacterID("Char_UAN_Trench_2_2")
		_idChar_UAN_Trench_2_01_3=GetCharacterID("Char_UAN_Trench_2_01_3")

-- Déclaration des "GroupID"
	--WRF
		_idGrp_WRF_Camp_1_1=GetGroupID("Grp_WRF_Camp_1_1")
		_idGrp_WRF_Camp_1_2=GetGroupID("Grp_WRF_Camp_1_2")
		_idGrp_WRF_Camp_1_3=GetGroupID("Grp_WRF_Camp_1_3")
		_idGrp_WRF_Camp_1_4=GetGroupID("Grp_WRF_Camp_1_4")
		_idGrp_WRF_Camp_1_5=GetGroupID("Grp_WRF_Camp_1_5")

--		_idGrp_WRF_Trench_2_1=GetGroupID("Grp_WRF_Trench_2_1")
		_idGrp_WRF_Trench_2_2=GetGroupID("Grp_WRF_Trench_2_2")
		_idGrp_WRF_Trench_2_3=GetGroupID("Grp_WRF_Trench_2_3")
		_idGrp_WRF_Trench_2_4=GetGroupID("Grp_WRF_Trench_2_4")
	
	--UAN
		_idGrp_UAN_Camp_1_1=GetGroupID("Grp_UAN_Camp_1_1")
		_idGrp_UAN_Camp_1_2=GetGroupID("Grp_UAN_Camp_1_2")
		_idGrp_UAN_Camp_1_3=GetGroupID("Grp_UAN_Camp_1_3")
		_idGrp_UAN_Camp_1_4=GetGroupID("Grp_UAN_Camp_1_4")
		_idGrp_UAN_Camp_1_5=GetGroupID("Grp_UAN_Camp_1_5")
		_idGrp_UAN_Trench_1_1=GetGroupID("Grp_UAN_Trench_1_1")
		_idGrp_UAN_Trench_1_2=GetGroupID("Grp_UAN_Trench_1_2")
		_idGrp_UAN_Trench_1_3=GetGroupID("Grp_UAN_Trench_1_3")
		_idGrp_UAN_Trench_1_4=GetGroupID("Grp_UAN_Trench_1_4")
		_idGrp_UAN_Trench_1_5=GetGroupID("Grp_UAN_Trench_1_5")
		_idGrp_UAN_Trench_1_6=GetGroupID("Grp_UAN_Trench_1_6")
		_idGrp_UAN_Trench_2_1=GetGroupID("Grp_UAN_Trench_2_1")
		_idGrp_UAN_Trench_2_2=GetGroupID("Grp_UAN_Trench_2_2")
		_idGrp_UAN_Trench_2_3=GetGroupID("Grp_UAN_Trench_2_3")
		_idGrp_UAN_Trench_2_4=GetGroupID("Grp_UAN_Trench_2_4")
		_idGrp_UAN_Trench_2_5=GetGroupID("Grp_UAN_Trench_2_5")
		_idGrp_UAN_Trench_2_6=GetGroupID("Grp_UAN_Trench_2_6")
		_idGrp_UAN_Trench_2_7=GetGroupID("Grp_UAN_Trench_2_7")
		_idGrp_UAN_Trench_2_8=GetGroupID("Grp_UAN_Trench_2_8")
		_idGrp_UAN_Trench_2_9=GetGroupID("Grp_UAN_Trench_2_9")
		_idGrp_UAN_Trench_2_10=GetGroupID("Grp_UAN_Trench_2_10")

-- Déclaration des "ArsenalID"
		_idArs_Global_UAN_1=GetArsenalID("Ars_Global_UAN_1")
		_idArs_Global_UAN_2=GetArsenalID("Ars_Global_UAN_2")

-- Déclaration des "Order_ListID"
		_idAI_O_List_Spe_WRF_Solberg=GetAI_Order_ListID("AI_O_List_Spe_WRF_Solberg")
		_idAI_O_List_Grp_UAN_Camp_1_1=GetAI_Order_ListID("AI_O_List_Grp_UAN_Camp_1_1")
		_idAI_O_List_Spe_WRF_Limit_Zone_1=GetAI_Order_ListID("AI_O_List_Spe_WRF_Camp_1_LZ_1")
		_idAI_O_List_Spe_WRF_Limit_Zone_2=GetAI_Order_ListID("AI_O_List_Spe_WRF_Camp_1_LZ_2")
		_idAI_O_List_Spe_WRF_Limit_Zone_3=GetAI_Order_ListID("AI_O_List_Spe_WRF_Camp_1_LZ_3")
		_idAI_O_List_Goto_Waypoint_Camp_1_Caisse_3_Spe_WRF=GetAI_Order_ListID("AI_O_List_Spe_WRF_Camp_1_GW_3")
		_idAI_O_List_Goto_Waypoint_Camp_1_Caisse_2_Spe_WRF=GetAI_Order_ListID("AI_O_List_Spe_WRF_Camp_1_GW_2")
		_idAI_O_List_Goto_Waypoint_Camp_1_Caisse_1_Spe_WRF=GetAI_Order_ListID("AI_O_List_Spe_WRF_Camp_1_GW_1")

-- Déclaration des "AI_Order_Use_PathwayID"

-- Déclaration des "AI_Order_Follow"
		_idAI_O_Follow_Char_Merc_Player=GetAI_Order_FollowID("AI_O_Follow_Char_Merc_Player")
		_idAI_O_Follow_Player=GetAI_Order_FollowID("AI_O_Follow_Player_1")

-- Déclaration des "AI_O_Fire_At_Position"
		_idAI_O_Fire_At_Position_Char_WRF_Caporal=GetAI_Order_Fire_At_PositionID("AI_O_Fire_At_Position_Char_WRF_Caporal")

-- Déclaration des "AI_Order_Goto_Waypoint"
		_idAI_O_Goto_Player=GetAI_Order_Goto_WaypointID("AI_O_Goto_Player_1")

-- Déclaration des "WaypointID"
		_idWaypoint_Camp_1_Solberg_1=GetWaypointID("Waypoint_Camp_1_Solberg_1")
		_idWaypoint_Camp_1_Solberg_2=GetWaypointID("Waypoint_Camp_1_Solberg_2")
		_idWaypoint_Trench_1_1=GetWaypointID("Waypoint_Trench_1_1")
		_idWaypoint_Trench_1_Teleportation1=GetWaypointID("Waypoint_Trench_1_Teleportation1")
		_idWaypoint_Trench_1_Teleportation2=GetWaypointID("Waypoint_Trench_1_Teleportation2")
		_idWaypoint_Trench_2_1=GetWaypointID("Waypoint_Trench_2_1")

-- Déclaration des "TimerID"
		_idTimer_Camp_1_01=GetTimerID("Timer_Camp_1_01")
		_idTimer_Camp_1_02=GetTimerID("Timer_Camp_1_02")
		_idTimer_Camp_1_03=GetTimerID("Timer_Camp_1_03")
		_idTimer_Camp_1_04=GetTimerID("Timer_Camp_1_04")
		_idTimer_Camp_1_05=GetTimerID("Timer_Camp_1_05")
		_idTimer_Camp_1_06=GetTimerID("Timer_Camp_1_06")
		_idTimer_Trench_2_01=GetTimerID("Timer_Trench_2_01")
		_idTimer_Trench_2_EoF=GetTimerID("Timer_Trench_2_EoF")

-- Position d'où le Général Solberg va donner ses ordres 
		_vPosition_Solberg=GetVarValue(_idWaypoint_Camp_1_Solberg_2,"Position")

		_idParticleFX_Client_Bombone=GetParticleFX_ClientID("ParticleFX_Client_Bombone")

		_vPosition_Exp=GetVarValue(_idParticleFX_Client_Bombone,"Position")


end






------------------------------------------------------------
------------------------------------------------------------

-- ::: Précache des dial. ::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function SoundPrecache()

	PrecacheSentence("DIA_SPE_NIV_D_WRF_B_03")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_B_04")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_F_02")			
	PrecacheSentence("DIA_SPE_NIV_D_GENERAL_RADIO_01")
	PrecacheSentence("DIA_SPE_NIV_D_UAN_A_01")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_B_05")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_B_06")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_F_01")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_B_05")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_F_04")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_F_05")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_F_03")
	PrecacheSentence("DIA_GEN_DO_GO_GO_TEAM_A_VOICE_A_1")
	PrecacheSentence("DIA_SPE_NIV_D_GENERAL_RADIO_05")
	PrecacheSentence("DIA_GEN_DO_GO_GO_TEAM_A_VOICE_A_1")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_A_01")
	PrecacheSentence("DIA_SPE_NIV_D_GENERAL_05")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_A_04")
	PrecacheSentence("DIA_SPE_NIV_D_GENERAL_01")
	PrecacheSentence("DIA_SPE_NIV_D_CAPORAL_01")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_A_08")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_A_09")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_A_10")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_A_11")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_A_12")
	PrecacheSentence("DIA_SPE_NIV_D_GENERAL_04")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_A_02")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_A_01")
	PrecacheSentence("DIA_SPE_NIV_D_GENERAL_06")
	PrecacheSentence("DIA_SPE_NIV_D_GENERAL_08")
	PrecacheSentence("DIA_SPE_NIV_D_GENERAL_09")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_A_13")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_A_14")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_A_03")
	PrecacheSentence("DIA_GEN_ACKNOWLEDGE_TEAM_A_VOICE_B_1")
	PrecacheSentence("DIA_GEN_DO_HEAR_NOISE_TEAM_A_VOICE_A_2")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_A_05")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_A_06")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_A_07")
	PrecacheSentence("DIA_SPE_NIV_D_CAPORAL_02")
	PrecacheSentence("DIA_SPE_NIV_D_CAPORAL_03")
	PrecacheSentence("DIA_SPE_NIV_D_CAPORAL_04")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_A_02")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_A_03")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_A_04")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_RADIO_A_01")
	PrecacheSentence("DIA_SPE_NIV_D_OFFICER_RADIO_A_02")

end