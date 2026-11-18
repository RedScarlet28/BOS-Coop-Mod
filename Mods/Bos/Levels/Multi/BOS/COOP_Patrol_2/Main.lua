------------------------------------------------------------
------------------------------------------------------------

-- ::: InitLevel :::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function InitLevel()
	CheckInitLevel_patrol_2()


-------------------------------------------------------------
-- :::::::: CHAMPIONS :::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

-- Champion_Masatosi_Yamibushi_Togawa ->	Char_Champion_0_1
-- Champion_Smoking Rifle Felipe			->	Char_Champion_0_2
-- Champion_Master Loa								->	Char_Champion_0_3


		-- Récupère l'ID du Champion actif pour la zone 0
		_idChampion_0 = GetChampionFromArea(0)
	--	SetVarValue(_idChampion_0,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Char_Chp_Camp_3"))

		-- Récupère le nom du Champion actif pour la zone 0
		_sNomChampion_0 = GetVarValue(_idChampion_0, "Name")

		-- Assigne un description de Champion à Nolan		
		AssignChampionToPlayer( "Champion_Nolan_Patrol" )

-------------------------------------------------------------
-- :::::::: MERCENAIRES :::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère les ID des Mercs actifs et leur colle une AIOL
		_idMerc={}
		number = GetMercenaryCount() 
		number = number - 1
		for i=0,number,1 do
				_idMerc[i] = GetMercenary(i) 
		end

		-- Active l'affichage des Mercs sur la map
		ActiveTrackingMercs()

-------------------------------------------------------------
-- :::: AUTRES INIT. ::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		InitScriptVariable()
		InitLevel_Camp_2()
		InitLevel_Camp_3()
		InitLevel_Mordor()

		Explosion_Pluie()
		_nBotActive=GetTotalActiveCharacterCount()
		_nBotAlive=GetTotalAliveCharacterCount()
		
		if _bAliveCharWRF41 then
				SetVarValue(GetCharacterID("Char_WRF_Patrol"), "BodyHitPoints", _nBodyCharWRF41)
				SetVarValue(GetCharacterID("Char_WRF_Patrol"), "HelmetHitPoints", _nHelmetCharWRF41)
				SetVarValue(GetCharacterID("Char_WRF_Patrol"), "LegsHitPoints", _nLegsCharWRF41)
				SetVarValue(GetCharacterID("Char_WRF_Patrol"), "ShieldHitPoints", _nShieldCharWRF41)
				Freeze(GetCharacterID("Char_WRF_Patrol"),false)
		end
		
		SoundPrecache()


-------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires ::::::: --
-------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()

	SetVarValue(GetTV_Camera_ClientID("TV_Camera_Client-18"),"TrackedCharacter",_idChampion_0)
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: UpdateLevel :::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function UpdateLevel()

		Spot1 ()
		Spot2 ()
		Spot3 ()
		Spot4 ()
		UpdateLevel_Camp_2()
		UpdateLevel_Camp_3()
		UpdateLevel_Mordor()
--		UpdateLevel_Camp_4()
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
		_idPlayer=GetLocalCharacterID()

	--WRF
		_idChar_WRF_Camp_2_02_1=GetCharacterID("Char_WRF_Camp_2_02_1")
		_idChar_WRF_Camp_2_02_2=GetCharacterID("Char_WRF_Camp_2_02_2")
		_idChar_WRF_Camp_2_02_3=GetCharacterID("Char_WRF_Camp_2_02_3")
		_idChar_WRF_Camp_2_01_1=GetCharacterID("Char_WRF_Camp_2_01_1")

	--UAN
		_idChar_UAN_Camp_2_01_1=GetCharacterID("Char_UAN_Camp_2_01_1")
		_idChar_UAN_Camp_2_01_2=GetCharacterID("Char_UAN_Camp_2_01_2")
		_idChar_UAN_Camp_2_01_3=GetCharacterID("Char_UAN_Camp_2_01_3")
		_idChar_UAN_Camp_2_01_4=GetCharacterID("Char_UAN_Camp_2_01_4")
		_idChar_UAN_Camp_2_02_2=GetCharacterID("Char_UAN_Camp_2_02_2")
		_idChar_UAN_Camp_2_05_1=GetCharacterID("Char_UAN_Camp_2_05_1")
		_idChar_UAN_Camp_2_05_2=GetCharacterID("Char_UAN_Camp_2_05_2")
		_idChar_UAN_Camp_2_06_1=GetCharacterID("Char_UAN_Camp_2_06_1")
		_idChar_UAN_Camp_2_06_2=GetCharacterID("Char_UAN_Camp_2_06_2")
		_idChar_UAN_Camp_2_06_3=GetCharacterID("Char_UAN_Camp_2_06_3")

-- Déclaration des "GroupID"
	--WRF
		_idGrp_WRF_Camp_2_1=GetGroupID("Grp_WRF_Camp_2_1")
		_idGrp_WRF_Camp_2_2=GetGroupID("Grp_WRF_Camp_2_2")
	
	--UAN
		_idGrp_UAN_Camp_2_1=GetGroupID("Grp_UAN_Camp_2_1")
		_idGrp_UAN_Camp_2_2=GetGroupID("Grp_UAN_Camp_2_2")
		_idGrp_UAN_Camp_2_3=GetGroupID("Grp_UAN_Camp_2_3")
		_idGrp_UAN_Camp_2_4=GetGroupID("Grp_UAN_Camp_2_4")
		_idGrp_UAN_Camp_2_5=GetGroupID("Grp_UAN_Camp_2_5")
		_idGrp_UAN_Camp_2_6=GetGroupID("Grp_UAN_Camp_2_6")

-- Déclaration des "ArsenalID"
		_idArs_Global_UAN_1=GetArsenalID("Ars_Global_UAN_1")
		_idArs_Global_UAN_2=GetArsenalID("Ars_Global_UAN_2")

-- Déclaration des "Order_ListID"
	--WRF

-- Déclaration des "AI_Order_Use_PathwayID"

-- Déclaration des "AI_Order_Follow"
		_idAI_O_Follow_Char_Merc_Player=GetAI_Order_FollowID("AI_O_Follow_Char_Merc_Player")

-- Déclaration des "AI_Order_Goto_Waypoint"
	--UAN
		_idAI_O_Goto_Waypoint_Char_Chp_Camp_3_2=GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_Chp_Camp_3_2")

		_rRotX_Spot = -2.96
		_rRotX_Spot2 = -2.5
		_rRotX_Spot3 = 1
		_rRotX_Spot4 = 2.5
end






------------------------------------------------------------
------------------------------------------------------------

-- ::: Précache des dial. ::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function SoundPrecache()

	PrecacheSentence("DIA_GEN_SEE_ENNEMY_TEAM_A_VOICE_A_1")
	PrecacheSentence("DIA_SPE_NIV_D_UAN_A_02")
	PrecacheSentence("DIA_SPE_NIV_D_GENERAL_RADIO_02")
	PrecacheSentence("DIA_SPE_NIV_D_GENERAL_B_01")
	PrecacheSentence("DIA_SPE_NIV_D_GENERAL_RADIO_03")
	PrecacheSentence("DIA_SPE_NIV_D_MERCE_A_02")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_E_01")
	PrecacheSentence("DIA_GEN_COOL_TO_STRESS_TEAM_A_VOICE_B_2")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_E_02")
	PrecacheSentence("DIA_GEN_ACKNOWLEDGE_TEAM_A_VOICE_A_1")
	PrecacheSentence("DIA_SPE_NIV_D_GENERAL_RADIO_04")
	PrecacheSentence("DIA_GEN_SEE_EXOSOLDIER_TEAM_A_VOICE_A_1")
	PrecacheSentence("DIA_GEN_DO_RETREAT_TEAM_A_VOICE_A_1")
--	PrecacheSentence("DIA_GEN_WRF_40") ?????????????????
	PrecacheSentence("DIA_SPE_NIV_D_GENERAL_B_01")
	PrecacheSentence("DIA_GEN_SEE_EXOSOLDIER_TEAM_A_VOICE_A_1")
	PrecacheSentence("DIA_SPE_NIV_D_MERCE_B_02")
	PrecacheSentence("DIA_SPE_NIV_D_UAN_A_02")
	PrecacheSentence("DIA_GEN_SEE_SNIPERS_TEAM_A_VOICE_B_1")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_D_01")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_C_02")
	PrecacheSentence("DIA_GEN_START_FIRE_TEAM_B_VOICE_B_1")
	PrecacheSentence("DIA_SPE_NIV_D_WRF_C_03")
	PrecacheSentence("DIA_GEN_START_FIRE_TEAM_B_VOICE_A_1")

end
