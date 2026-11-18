function InitLevel()
	CheckInitLevel_eradication_1()
	
	_idPlayer = GetLocalCharacterID()
	EnableCharacterCommand(_idPlayer,false)
	CharacterPlaySpecialAction(_idPlayer,"STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)

	Precache_Dials()

	_nBotsActifs=GetTotalActiveCharacterCount()
			
	InitScriptVariable()
--	CAM_1()

			_nLife_Exo_UAN_3= GetVarValue(GetExoskeletonID("Exoskeleton_Hangar_3"),"Health")
			PrintDebug("_nLife_Exo : ".._nLife_Exo_UAN_3.."\n")
			
			_nLife_Exo_UAN_5= GetVarValue(GetExoskeletonID("Exoskeleton_Hangar_5"),"Health")
			PrintDebug("_nLife_Exo : ".._nLife_Exo_UAN_5.."\n")
	ConfigMerc()
end
--CAM()

-------------------------------
-- ::::::::::::::::::::::::: --
function OnMissionBegins()
-- ::::::::::::::::::::::::: --
-------------------------------

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
		
		if (_idMerc[0]~=nil) then
				SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_Mercs_Spawn_0"))
				_idMerc_0 = _idMerc[0]
		end
		if (_idMerc[1]~=nil) then		
				SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_Mercs_Spawn_1"))
				_idMerc_1 = _idMerc[1]
		end

	ActiveTrackingMercs()

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	SetVarValue(GetCharacterID("Player"),"Team","SYNDICATE")

end

function UpdateLevel()

			DesactiveTrackingMercs()

			_nLife_Exo_UAN_3= GetVarValue(GetExoskeletonID("Exoskeleton_Hangar_3"),"Health")
				PrintDebug("_nLife_Exo : ".._nLife_Exo_UAN_3.."\n")
			_nLife_Exo_UAN_5= GetVarValue(GetExoskeletonID("Exoskeleton_Hangar_5"),"Health")
				PrintDebug("_nLife_Exo : ".._nLife_Exo_UAN_5.."\n")

	CAM_1()
	--CAM()
_nBotsActifs=GetTotalActiveCharacterCount()

Coursive_left_1()
Coursive_left_2()
Coursive_left_3()
Exo_Colline_Recharge()
Coursive_right_1()
Coursive_right_2()
Coursive_right_3()
Coursive_right_4()
MORT_EXO_3()
MORT_EXO_5()
Releve_Exo()
Releve_Exo_1()

Suite_ruines_1()
Suite_ruines_2()
Obj_C()
--Change_Ars_MERC()
Cam_camp()
Renforts_Galerie_1()
--Renforts_Galerie_2()
Renforts_camp_1()
First_renforts()
--Exo_1_Come()
Heliport()
Obj_D()
Objectif_1()
--ENDofDEMO()
---DEBUG BOTactiv

GlobalIngenieurIsDead()
GlobalPlayerIsDead()

PrintDebug(" "..GetTotalActiveCharacterCount().."\n")

end

--[[ On initialise toutes les variables globales à un niveau
	(toutes les variables nommées _NomDeVariable) 
	dans cette fonction appelée dans InitLevel() --]]

function InitScriptVariable()

_bCtrlWPExo3 = false
_bCtrlWPExo5 = false

_idList_Inge=GetAI_Order_ListID("AI_Order_List_INGE")

_idUse_Pathway_INGE_1=GetAI_Order_Use_PathwayID("AI_Order_Use_Pathway_INGE_1")
_idUse_Pathway_INGE_2=GetAI_Order_Use_PathwayID("AI_Order_Use_Pathway_INGE_2")
_idUse_Pathway_INGE_3=GetAI_Order_Use_PathwayID("AI_Order_Use_Pathway_INGE_3")

_idTimer_dial_inge_1=GetTimerID("Timer_dial_inge_1")
_idTimer_dial_inge_2=GetTimerID("Timer_dial_inge_2")



_nLife_Exo_UAN_3= GetVarValue(GetExoskeletonID("Exoskeleton_Hangar_3"),"Health")
_nLife_Exo_UAN_5= GetVarValue(GetExoskeletonID("Exoskeleton_Hangar_5"),"Health")






_idTimer_rad_1=GetTimerID("Timer_radio_one")
_idTimer_rad_2=GetTimerID("Timer_radio_two")
_nBotsActifs=GetTotalActiveCharacterCount()
	_idPlayer = GetLocalCharacterID()
_idChar_SYND_00_1=GetCharacterID("Char_SYND_00_1")
_idChar_SYND_00_2=GetCharacterID("Char_SYND_00_2")
_idChar_SYND_00_3=GetCharacterID("Char_SYND_00_3")
_idChar_SYND_00_5=GetCharacterID("Char_SYND_00_5")
_idChar_SYND_00_6=GetCharacterID("Char_SYND_00_6")
_idChar_SYND_00_7=GetCharacterID("Char_SYND_00_7")
_idChar_SYND_00_8=GetCharacterID("Char_SYND_00_8")
_idChar_SYND_00_10=GetCharacterID("Char_SYND_00_10")
_idExoskeleton_Hangar_3=GetExoskeletonID("Exoskeleton_Hangar_3")
_idExoskeleton_Hangar_5=GetExoskeletonID("Exoskeleton_Hangar_5")
_idExoskeleton_Hangar_2=GetExoskeletonID("Exoskeleton_Hangar_2")
_idTank_3=GetTankID("Tank_3")
--------------------------------------------------------------
_idGroup_SYND_01=GetGroupID("Group_SYND_01")
_idChar_SYND_01_1=GetCharacterID("Char_SYND_01_1")
_idChar_SYND_01_2=GetCharacterID("Char_SYND_01_2")
_idChar_SYND_01_3=GetCharacterID("Char_SYND_01_3")
_idChar_SYND_01_4=GetCharacterID("Char_SYND_01_4")
---------------------------------------------------------------
_idGroup_SYND_02=GetGroupID("Group_SYND_02")
_idChar_SYND_02_1=GetCharacterID("Char_SYND_02_1")
_idChar_SYND_02_2=GetCharacterID("Char_SYND_02_2")
_idChar_SYND_02_3=GetCharacterID("Char_SYND_02_3")
_idChar_SYND_02_4=GetCharacterID("Char_SYND_02_4")
---------------------------------------------------------------
_idGroup_SYND_03=GetGroupID("Group_SYND_03")
_idChar_SYND_03_1=GetCharacterID("Char_SYND_03_1")
_idChar_SYND_03_2=GetCharacterID("Char_SYND_03_2")
_idChar_SYND_03_3=GetCharacterID("Char_SYND_03_3")
_idChar_SYND_03_4=GetCharacterID("Char_SYND_03_4")

---------------------------------------------------------------
_idGroup_SYND_04=GetGroupID("Group_SYND_04")
_idChar_SYND_04_1=GetCharacterID("Char_SYND_04_1")
_idChar_SYND_04_2=GetCharacterID("Char_SYND_04_2")
_idChar_SYND_04_3=GetCharacterID("Char_SYND_04_3")
_idChar_SYND_04_4=GetCharacterID("Char_SYND_04_4")
---------------------------------------------------------------
_idGroup_SYND_05=GetGroupID("Group_SYND_05")
_idChar_SYND_05_1=GetCharacterID("Char_SYND_05_1")
_idChar_SYND_05_2=GetCharacterID("Char_SYND_05_2")
_idChar_SYND_05_3=GetCharacterID("Char_SYND_05_3")
_idChar_SYND_05_4=GetCharacterID("Char_SYND_05_4")
------------------------------------------------------------------

_idChar_RES_Ruine_00_1=GetCharacterID("Char_RES_Ruine_00_1")
_idChar_RES_Ruine_00_2=GetCharacterID("Char_RES_Ruine_00_2")
---------------------------------------------------
_idChar_RES_ExoMan_00_1=GetCharacterID("Char_RES_ExoMan_00_1")
_idChar_RES_ExoMan_00_2=GetCharacterID("Char_RES_ExoMan_00_2")
_idChar_RES_Coursive_00_1=GetCharacterID("Char_RES_Coursive_00_1")
_idChar_RES_Coursive_00_2=GetCharacterID("Char_RES_Coursive_00_2")
_idChar_RES_Coursive_00_3=GetCharacterID("Char_RES_Coursive_00_3")
_idChar_RES_Coursive_00_4=GetCharacterID("Char_RES_Coursive_00_4")
_idChar_RES_Coursive_00_5=GetCharacterID("Char_RES_Coursive_00_5")
_idChar_RES_Coursive_00_6=GetCharacterID("Char_RES_Coursive_00_6")
_idChar_RES_Coursive_00_7=GetCharacterID("Char_RES_Coursive_00_7")
_idChar_RES_Coursive_00_8=GetCharacterID("Char_RES_Coursive_00_8")
_idChar_RES_Coursive_00_9=GetCharacterID("Char_RES_Coursive_00_9")
_idChar_RES_Coursive_00_10=GetCharacterID("Char_RES_Coursive_00_10")
_idChar_RES_Coursive_00_11=GetCharacterID("Char_RES_Coursive_00_11")
_idChar_RES_Coursive_00_12=GetCharacterID("Char_RES_Coursive_00_12")
_idChar_RES_Coursive_00_13=GetCharacterID("Char_RES_Coursive_00_13")
_idChar_RES_Coursive_00_14=GetCharacterID("Char_RES_Coursive_00_14")
_idChar_RES_Coursive_00_15=GetCharacterID("Char_RES_Coursive_00_15")
_idChar_RES_Coursive_00_16=GetCharacterID("Char_RES_Coursive_00_16")
_idChar_RES_Coursive_00_17=GetCharacterID("Char_RES_Coursive_00_17")
_idChar_RES_Coursive_00_18=GetCharacterID("Char_RES_Coursive_00_18")
_idChar_RES_Coursive_00_19=GetCharacterID("Char_RES_Coursive_00_19")
_idChar_RES_Coursive_00_20=GetCharacterID("Char_RES_Coursive_00_20")
_idChar_RES_Coursive_00_21=GetCharacterID("Char_RES_Coursive_00_21")
_idChar_RES_Coursive_00_22=GetCharacterID("Char_RES_Coursive_00_22")
_idChar_RES_Coursive_00_23=GetCharacterID("Char_RES_Coursive_00_23")
--------------------------------------------------------------------------
_idChar_RES_Camp_00_1=GetCharacterID("Char_RES_Camp_00_1")
_idChar_RES_Camp_00_2=GetCharacterID("Char_RES_Camp_00_2")
_idChar_RES_Camp_00_3=GetCharacterID("Char_RES_Camp_00_3")
_idChar_RES_Camp_00_4=GetCharacterID("Char_RES_Camp_00_4")
_idChar_RES_Camp_00_5=GetCharacterID("Char_RES_Camp_00_5")
_idChar_RES_Camp_00_6=GetCharacterID("Char_RES_Camp_00_6")
_idChar_RES_Camp_00_7=GetCharacterID("Char_RES_Camp_00_7")
_idChar_RES_Camp_00_8=GetCharacterID("Char_RES_Camp_00_8")
_idChar_RES_Camp_00_9=GetCharacterID("Char_RES_Camp_00_9")
_idChar_RES_Camp_00_10=GetCharacterID("Char_RES_Camp_00_10")
_idChar_RES_Camp_00_11=GetCharacterID("Char_RES_Camp_00_11")
_idChar_RES_Camp_00_12=GetCharacterID("Char_RES_Camp_00_12")
_idChar_RES_Camp_00_13=GetCharacterID("Char_RES_Camp_00_13")
_idChar_RES_Camp_00_14=GetCharacterID("Char_RES_Camp_00_14")
_idChar_RES_Camp_00_15=GetCharacterID("Char_RES_Camp_00_15")
_idChar_RES_Camp_00_16=GetCharacterID("Char_RES_Camp_00_16")
----------------------------------------------------------------------------
_idGroup_CAMP_01=GetGroupID("Group_CAMP_01")
_idChar_RES_Camp_01_1=GetCharacterID("Char_RES_Camp_01_1")
_idChar_RES_Camp_01_2=GetCharacterID("Char_RES_Camp_01_2")
_idChar_RES_Camp_01_3=GetCharacterID("Char_RES_Camp_01_3")
_idChar_RES_Camp_01_4=GetCharacterID("Char_RES_Camp_01_4")
_idGroup_BATAILLE=GetGroupID("Group_BATAILLE")
_idChar_SYND_00_3=GetCharacterID("Char_SYND_00_3")
_idChar_SYND_00_5=GetCharacterID("Char_SYND_00_5")
_idChar_SYND_00_6=GetCharacterID("Char_SYND_00_6")
_idChar_SYND_00_7=GetCharacterID("Char_SYND_00_7")
_idChar_SYND_00_8=GetCharacterID("Char_SYND_00_8")
_idGroup_Galerie_01=GetGroupID("Group_GALERIE_01")
_idGroup_Galerie_02=GetGroupID("Group_GALERIE_02")
---------------------------------------------------------------------
_idChar_RES_HANGAR_00_1=GetCharacterID("Char_RES_HANGAR_00_1")
_idChar_RES_HANGAR_00_2=GetCharacterID("Char_RES_HANGAR_00_2")
_idChar_RES_HANGAR_00_3=GetCharacterID("Char_RES_HANGAR_00_3")
_idChar_RES_HANGAR_00_4=GetCharacterID("Char_RES_HANGAR_00_4")
_idChar_RES_HANGAR_00_5=GetCharacterID("Char_RES_HANGAR_00_5")
_idChar_RES_HANGAR_00_6=GetCharacterID("Char_RES_HANGAR_00_6")
_idChar_RES_HANGAR_00_7=GetCharacterID("Char_RES_HANGAR_00_7")
_idChar_RES_HANGAR_00_8=GetCharacterID("Char_RES_HANGAR_00_8")
_idChar_RES_HANGAR_00_9=GetCharacterID("Char_RES_HANGAR_00_9")
_idChar_RES_HANGAR_00_10=GetCharacterID("Char_RES_HANGAR_00_10")
_idChar_RES_HANGAR_00_11=GetCharacterID("Char_RES_HANGAR_00_11")
_idChar_RES_HANGAR_00_12=GetCharacterID("Char_RES_HANGAR_00_12")
_idChar_RES_HANGAR_00_13=GetCharacterID("Char_RES_HANGAR_00_13")
_idChar_RES_HANGAR_00_14=GetCharacterID("Char_RES_HANGAR_00_14")
---------------------------------------------------------------------

_idChar_RES_SCENE_00_1=GetCharacterID("Char_RES_SCENE_00_1")
_idChar_RES_SCENE_00_2=GetCharacterID("Char_RES_SCENE_00_2")
_idChar_RES_SCENE_00_3=GetCharacterID("Char_RES_SCENE_00_3")
_idChar_RES_SCENE_00_4=GetCharacterID("Char_RES_SCENE_00_4")
_idChar_RES_SCENE_00_5=GetCharacterID("Char_RES_SCENE_00_5")
_idChar_RES_SCENE_00_6=GetCharacterID("Char_RES_SCENE_00_6")
_idChar_RES_SCENE_00_7=GetCharacterID("Char_RES_SCENE_00_7")
_idChar_RES_SCENE_00_8=GetCharacterID("Char_RES_SCENE_00_8")
_idChar_RES_SCENE_00_9=GetCharacterID("Char_RES_SCENE_00_9")
_idChar_RES_SCENE_00_10=GetCharacterID("Char_RES_SCENE_00_10")
_idChar_RES_SCENE_00_11=GetCharacterID("Char_RES_SCENE_00_11")
_idChar_RES_SCENE_00_12=GetCharacterID("Char_RES_SCENE_00_12")
--------------------------------------------------------------------------
_idGroup_Ruine_01=GetGroupID("Group_Ruine_01")
_idChar_RES_Ruine_01_1=GetCharacterID("Char_RES_Ruine_01_1")
_idChar_RES_Ruine_01_2=GetCharacterID("Char_RES_Ruine_01_2")
_idChar_RES_Ruine_01_3=GetCharacterID("Char_RES_Ruine_01_3")
_idGroup_Ruine_02=GetGroupID("Group_Ruine_02")
_idGroup_Ruine_03=GetGroupID("Group_Ruine_03")
_idChar_RES_Ruine_03_1=GetCharacterID("Char_RES_Ruine_03_1")
_idChar_RES_Ruine_03_2=GetCharacterID("Char_RES_Ruine_03_2")
_idChar_RES_Ruine_03_3=GetCharacterID("Char_RES_Ruine_03_3")
_idChar_RES_Ruine_03_4=GetCharacterID("Char_RES_Ruine_03_4")
_idChar_RES_Ruine_03_5=GetCharacterID("Char_RES_Ruine_03_5")

_idGroup_Ruine_04=GetGroupID("Group_Ruine_04")
_idGroup_Ruine_05=GetGroupID("Group_Ruine_05")
_idChar_RES_Ruine_05_1=GetCharacterID("Char_RES_Ruine_05_1")
_idChar_RES_Ruine_05_2=GetCharacterID("Char_RES_Ruine_05_2")
_idGroup_Ruine_06=GetGroupID("Group_Ruine_06")
_idGroup_Ruine_07=GetGroupID("Group_Ruine_07")
_idGroup_Ruine_08=GetGroupID("Group_Ruine_08")
---------------------------RESERVE------------------------------
_bBackInge=0
_bCAM_1=0
_bVie=0
_bHACK_ok=false
_bOnEnter_Sector_Event_recharge=0
--------------------------PLAINE----------------------------
_bOnEnter_Sector_Event_depart=0
_bOnEnter_Sector_Event_etage_ruine=0
_bCoursive_left_1=0
_bCoursive_left_2=0
_bCoursive_left_3=0
_bCoursive_right_1=0
_bCoursive_right_2=0
_bCoursive_right_3=0
_bCoursive_right_4=0
_bOnEnter_Sector_Event_RUINE_1=0
_bOnEnter_Sector_Event_RUINE_2=0
_bOnStay_Sector_Event_RUINE_2=0
_bOnEnter_Sector_Event_RUINE_3=0
_bOnEnter_Sector_Event_RUINE_4=0
_bOnEnter_Sector_Event_RUINE_5=0
_bOnExit_Sector_Event_RUINE_5=0
_bOnEnter_Sector_Event_RUINE_7=0
_bOnEnter_Sector_Event_Synd_ruines=0
_bOnStay_Sector_Event_limit_zone_1=0
_nBombardement=50
_bOnExit_Sector_Event_Camp_2=0
_bOnEnter_Sector_Event_Camp_3=0
_bReleve=0
_bReleve_1=0
--------------------RUINES------------------------------------
_bENDofDEMO=0
_bFreeze_Two=0
_bFreeze_One=0
_bOnExit_Sector_Event_CORNICHE=0
_bOnExit_Sector_Event_back=0
_bOnEnter_Sector_Event_BOYAU=0
_bOnExit_Sector_Event_BOYAU=0
_bOnEnter_Sector_Event_Entree_boyau=0
_bOnEnter_Sector_Event_Check_point=0
_bOnEnter_Sector_Event_fin_Boyau=0
_bOnEnter_Sector_Event_middle_corniche=0
_bOnExit_Sector_Event_fin_Boyau=0
-------------CAMP--------------
_bOnEnter_Sector_Event_CORNICHE=0
_bOnExit_Sector_Event_middle_corniche=0
_bOnEnter_Sector_Event_illusion_bataille=0
_bOnExit_Sector_Event_Camp_3=0
_bCam_camp=0
_bOnEnter_Sector_Event_LEFT_COLLINE=0
_bOnEnter_Sector_Event_RIGHT_COLLINE=0
_bOnEnter_Sector_Event_Camp_2=0
_bOnEnter_Sector_Event_Camp_1=0
_bOnEnter_Sector_Event_hack=0
_bRenforts_camp_1=0
_bOnExit_Sector_Event_Hangar_exo=0
_bRenforts_Galerie_1=0
_bRenforts_Galerie_2=0
_bExo_1_Come=0
--_bExo_2_Come=0
_bOnEnter_Sector_Event_HELIPORT=0
_bHeliport=0
_bMORT_EXO_3=0
_bMORT_EXO_5=0
_bOnEnter_Sector_Event_CAM_INGE=0
_bOnEnter_Sector_Event_CHECK=0
_bOnEnter_Sector_Event_freeze_defreeze_corniche=0
_bOnExit_Sector_Event_freeze_defreeze_corniche=0
_bMaVie=0
--------------------------------------
_bOnEnter_Sector_Event_Freeze_1=0
_bSuite_RUINES_1=0
_bSuite_RUINES_2=0
_bOnEnter_Sector_Event_BLINDAGE_HACK=0
_bOnExit_Sector_Event_Camp_2=0
_bOnEnter_Sector_Event_groupe_ruine_08=0
----------------------------------------
--OBJECTIFS-------
_bObj_C=0
_bObj_D=0
_bObjectif_1=0
_bFinDeNiveau=0
_bOnEnter_Sector_Event_CHECK=0
_bOnEnter_Sector_Event_CHECK1=0
_bOnEnter_Sector_Event_CHECK2=0
_byet_did=true
_byet_did_2=true
-----------------------------
end

function Precache_Dials()
PrecacheSentence("DIA_SPE_NIV_N_GENERAL_01")
PrecacheSentence("DIA_SPE_NIV_N_GENERAL_02")
PrecacheSentence("DIA_SPE_NIV_N_GENERAL_03")
PrecacheSentence("DIA_SPE_NIV_K_GENERAL_RADIO_08")
PrecacheSentence("DIA_SPE_NIV_N_SYNDI_A_01")
PrecacheSentence("DIA_SPE_NIV_N_SYNDI_B_01")
PrecacheSentence("DIA_SPE_NIV_N_GENERAL_RADIO_12")
PrecacheSentence("DIA_SPE_NIV_N_RESIS_A_01")
PrecacheSentence("DIA_SPE_NIV_N_RESIS_A_02")
PrecacheSentence("DIA_SPE_NIV_N_GENERAL_RADIO_13")
PrecacheSentence("DIA_SPE_NIV_N_SYNDI_C_01")
PrecacheSentence("DIA_SPE_NIV_N_GENERAL_RADIO_15")
PrecacheSentence("DIA_SPE_NIV_E_INGENIEUR_05")
PrecacheSentence("DIA_SPE_NIV_N_GENERAL_RADIO_14")
PrecacheSentence("DIA_SPE_NIV_N_GENERAL_RADIO_17")
PrecacheSentence("DIA_SPE_NIV_H_INGENIEUR_26")
PrecacheSentence("DIA_SPE_NIV_H_INGENIEUR_31")
PrecacheSentence("DIA_SPE_NIV_H_INGENIEUR_24")

end