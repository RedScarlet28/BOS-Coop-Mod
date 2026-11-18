function InitLevel()
	CheckInitLevel_tanks_in_the_city_4()

Precache_Dials()
-------------------------------------------------------------
-- :::: MERCENAIRES :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère les ID des Mercs actifs et leur colle une AIOL
		_idMerc={}
		number = GetMercenaryCount() 
		number = number - 1
		for i=0,number,1 do
				_idMerc[i] = GetMercenary(i) 
				SetVarValue(_idMerc[i],"CharacterOrderList",GetInvalidEntityID())
		end
	
		AssignChampionToPlayer("Champion_Nolan_Tanks_in_the_city_3")


	StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav",true)
	InitScriptVariable()


-------------------------------------------------------------
-- :::: CHAMPIONS :::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère l'ID du Champion actif pour la zone 0
		_idChampion_0 = GetChampionFromArea(0)


--------------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires... ETC ::::::: --
--------------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	ActiveTrackingMercs()


	debut ()
	--CharacterPlaySpecialAction(_idChar_WRF_exec_01_1,"STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)
	--CharacterPlaySpecialAction(_idChar_WRF_exec_01_2,"STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)
	--CharacterPlaySpecialAction(_idChar_WRF_exec_01_3,"STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)
	--CharacterPlaySpecialAction(_idChar_WRF_exec_01_4,"STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)
end

function UpdateLevel()


--Renforts_Right()
--Renforts_Right_2()
--Feu()
--EndCam()
--Scene_1()
--Scene_2()
Pre_bet()
--Suite_scene_1()
--Scene_3()
Next_1()
Next_2()
Next_3()
UpdateLevel_Objectives()

	if _idChampion_0 == (GetCharacterID("Char_Champion_0_1"))and (_bWeakPointHealthTest == 0) and (g_bBoSEnCours == true) then
		Champion_Stop_Turning_Reloading(_idChampion_0,"AI_Order_List_champion")
	end
	

	if (IsAlive(_idChampion_0))then
		if (GetVarValue(GetPlug_MagneticShieldID("Plug_MShield_Champion_0_1"),"WeakPointHealth") <= 0)then
			if (_bWeakPointHealthTest == 0) and (g_bBoSEnCours == true) then
				SetVarValue(_idChampion_0,"CurrentSlot","TwoHded")
				SetVarValue(GetArsenalID("Arsenal_IGOR"),"Heavy","<NONE>")
				SetVarValue(GetCharacter_AIID("Char_AI_IGOR_FIGHT"),"AttackType","Automatic")
				SetVarValue(_idChampion_0,"CharacterOrderList",CreateAI_Order_List"AI_Order_List_champion")
				_bWeakPointHealthTest = 1
			end
		end
	end		


	Change_Bot_behavior ("Char_UAN_Infanterie_00_15",80,50,"AI_Order_List_force_target_Player")
	Change_Bot_behavior ("Char_UAN_Infanterie_00_13",80,50,"AI_Order_List_force_target_Player")
	Change_Bot_behavior ("Char_UAN_Infanterie_00_11",80,50,"AI_Order_List_force_target_Player")
	Change_Bot_behavior ("Char_UAN_Infanterie_00_16",80,50,"AI_Order_List_force_target_Player")
	Change_Bot_behavior ("Char_UAN_Infanterie_00_14",80,50,"AI_Order_List_force_target_Player")

-------------------------------------------------------------
-- :::::::: mort Player - mort INGENIEUR - ...ETC ::::::: --
-------------------------------------------------------------
	GlobalPlayerIsDead()
	DesactiveTrackingMercs()


end

--[[ On initialise toutes les variables globales à un niveau
	(toutes les variables nommées _NomDeVariable) 
	dans cette fonction appelée dans InitLevel() --]]

function InitScriptVariable()
	_idPlayer = GetLocalCharacterID()
	_idEXO_PLAYER=GetExoskeletonID("Exoskeleton-127")
---------INDVD--------------
	
	_idTank_2=GetTankID("Tank_UAN_2nd")
	_idChampion=GetCharacterID("Char_Champion_0_1")



	_idChar_UAN_Infanterie_00_11=GetCharacterID("Char_UAN_Infanterie_00_11")
	_idChar_UAN_Infanterie_00_12=GetCharacterID("Char_UAN_Infanterie_00_12")
	_idChar_UAN_Infanterie_00_13=GetCharacterID("Char_UAN_Infanterie_00_13")
	_idChar_UAN_Infanterie_00_14=GetCharacterID("Char_UAN_Infanterie_00_14")
	_idChar_UAN_Infanterie_00_15=GetCharacterID("Char_UAN_Infanterie_00_15")
	_idChar_UAN_Infanterie_00_16=GetCharacterID("Char_UAN_Infanterie_00_16")
	_idChar_UAN_Infanterie_00_17=GetCharacterID("Char_UAN_Infanterie_00_17")
	_idChar_UAN_Infanterie_00_18=GetCharacterID("Char_UAN_Infanterie_00_18")
	_idChar_UAN_Infanterie_00_19=GetCharacterID("Char_UAN_Infanterie_00_19")


	_idChar_WRF_exec_01_1=GetCharacterID("Char_WRF_exec_01_1")
	_idChar_WRF_exec_01_2=GetCharacterID("Char_WRF_exec_01_2")
	_idChar_WRF_exec_01_3=GetCharacterID("Char_WRF_exec_01_3")
	_idChar_WRF_exec_01_4=GetCharacterID("Char_WRF_exec_01_4")
	_idChar_WRF_exec_01_6=GetCharacterID("Char_WRF_exec_01_6")


	_idChar_UAN_Barricades_01_1=GetCharacterID("Char_UAN_Barricades_01_1")
	_idChar_UAN_Barricades_01_2=GetCharacterID("Char_UAN_Barricades_01_1")
	_idChar_UAN_Barricades_01_3=GetCharacterID("Char_UAN_Barricades_01_1")
	_idChar_UAN_Barricades_01_4=GetCharacterID("Char_UAN_Barricades_01_1")
	
-------------GROUP------------
	_idGroup_EXEC_01=GetGroupID("Group_EXEC_01")
	_idGroup_Prison=GetGroupID("Group_Prison")
	_idGroup_UAN_Barricades_01=GetGroupID("Group_UAN_Barricades_01")
	_idGroup_UAN_Barricades_02=GetGroupID("Group_UAN_Barricades_02")

------------------------------------------------------------

	_idParticleFX_Client_1022=GetParticleFX_ClientID("ParticleFX_Client_1022")
	_idParticleFX_Client_1023=GetParticleFX_ClientID("ParticleFX_Client_1023")
	_idParticleFX_Client_1024=GetParticleFX_ClientID("ParticleFX_Client_1024")
	_idParticleFX_Client_1025=GetParticleFX_ClientID("ParticleFX_Client_1025")	
	_idParticleFX_Client_1026=GetParticleFX_ClientID("ParticleFX_Client_1026")
		
	--_idSound_Client_Music_cuba_theme_2=GetSound_ClientID("Sound_Client-510")

	_idAI_Order_List_wp_exec_1=GetAI_Order_ListID("AI_Order_List_wp_exec_1")
	_idAI_Order_List_wp_exec_2=GetAI_Order_ListID("AI_Order_List_wp_exec_2")
	_idAI_Order_List_wp_exec_3=GetAI_Order_ListID("AI_Order_List_wp_exec_3")
	_idAI_Order_List_wp_exec_4=GetAI_Order_ListID("AI_Order_List_wp_exec_4")
	_idAI_Order_List_wp_exec_5=GetAI_Order_ListID("AI_Order_List_wp_exec_5")

----------------------------------------------------------------
_bOnExit_Sector_Event_Ouverture=0
_bOnEnter_Sector_Event_Detect_Right=0
_bOnExit_Sector_Event_Detect_Right=0
_bOnEnter_Sector_Event_Left_1=0
_bOnExit_Sector_Event_Left_1=0
_bRenforts_Right=0
_bRenforts_Right_2=0
_bOnEnter_Sector_Event_Camp=0
_bScene_1=0
_bPre_bet=0
_bSuite_scene_1=0
--_bScene_3=0
_bEndCam=0

_bObj_3_clear=0


_bFeu=0
_bOnEnter_Sector_Event_TANK_1=0
_bOnEnter_Sector_Event_TANK_2=0
_bObj_3_did_yet_BUT_notdeath_on_TANKS=0
_bOnDeath_Tank_UAN_1st=0
_bOnDeath_Tank_UAN_2nd=0

_bOnEnter_Sector_Event_debut=0
_bExecution=0
_bOnEnter_Sector_Event_exec=0

_bWeakPointHealthTest = 0

_bObj_A_1 = 0
_bDefreeze_Group_UAN_Barricades_02 = 0
_bDefreeze_Group_UAN_Barricades_03 = 0

end
--------------------------------------------
function Precache_Dials()


PrecacheSentence("DIA_SPE_NIV_L_GENERAL_RADIO_08")
PrecacheSentence("DIA_GEN_IS_IN_STRESS_TEAM_B_VOICE_B_2")
end
