-------------------------------
-- ::::::::::::::::::::::::: --
function InitLevel()
	CheckInitLevel_resistance_1()
	
	_idPlayer=GetLocalCharacterID()
	EnableCharacterCommand(_idPlayer,false)
	StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav",true)
-- ::::::::::::::::::::::::: --
-------------------------------
	InitScriptVariable()


	_nBotActive=GetTotalActiveCharacterCount()
	ConfigMerc()
end

		
-------------------------------
-- ::::::::::::::::::::::::: --
function OnMissionBegins()
-- ::::::::::::::::::::::::: --
-------------------------------

-------------------------------------------------------------
-- :::: CHAMPIONS :::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

-- Aucun Champion dans ce Load

-------------------------------------------------------------
-- :::: MERCENAIRES :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère les ID des Mercs actifs : _idMerc[0] et _idMerc[1]
		_idMerc={}
		number = GetMercenaryCount() 
		number = number - 1
		for i=0,number,1 do 
				_idMerc[i] = GetMercenary(i) 
				--SetVarValue(_idMerc[i],"CharacterOrderList",GetInvalidEntityID())
		end

--------------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires... ETC ::::::: --
--------------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	ActiveTrackingMercs()
	SetVarValue(GetCharacterID("Player"),"Team","RESISTANCE")

end


-------------------------------
-- ::::::::::::::::::::::::: --
function UpdateLevel()
-- ::::::::::::::::::::::::: --
-------------------------------
	Cam_1()
	Is_Saved()
	Cam_save_1()
Block_Grotte()
Freeze_Hang()
	FIN_INGE()
Tank_Fire_At_Position()
--End_Block_Check_dial()
Cpar_la()
TANK_VS_EXO()
--	Soldier_1()
--Exo_Desactivating()
 Exo_Destroyed()
	EXOS_Vs_Player()
	No_EXO()	
	Renforts()
Mort_Snip_04()
Mort_Snip_05()
Tests_Renforts()
Go_Steal_Exo()
In_Exo()
Huber_Passage()
--REPAIR()
New_WeakPoint_health ()
--------------------------------

		if IsAValidID(GetCharacterCurrentExoskeleton(_idPlayer))then
			_bIS_IN_EXO=true
		else _bIS_IN_EXO=false
		end
	_nBotActive=GetTotalActiveCharacterCount()
	PrintDebug("Bots actifs: ".._nBotActive)
	DesactiveTrackingMercs()
	_nHealth_EXO_D=GetVarValue(GetExoskeletonID("Exoskeleton_4"),"Health")
_nHEALTH_WEAK_POINT=GetVarValue(GetExoskeletonID("Exoskeleton_4"),"Weakpoint Health")
-----------------------------------------------------------------
-- ::::::::::::::::::::: Mission Failed :::::::::::::::::::::: --
-----------------------------------------------------------------

	GlobalPlayerIsDead()
	GlobalHuberIsDead()
	DesactiveTrackingMercs()

end

--[[
On initialise toutes les variables globales à un niveau
(toutes les variables nommées _NomDeVariable) 
dans cette fonction appelée dans InitLevel()
--]]

-------------------------------
-- ::::::::::::::::::::::::: --
function InitScriptVariable()
-- ::::::::::::::::::::::::: --
-------------------------------

-- Déclaration des "CharacterID"

	-- RES

	_idPlayer=GetLocalCharacterID()
	_idDoor_Main=GetDoorID("Door-58")
	_idDoor_Main2=GetDoorID("Door-59")
	_idChar_RES_ENGINEER_00_1=GetCharacterID("Char_RES_ENGINEER_00_1")	

_idSound_Client_PLANE_blaster=GetSound_ClientID("Sound_Client_PLANE_blaster")

_idObj_2_4=GetObjectiveID("Obj_2_4")

	_idTank_SYND_01=GetTankID("Tank_SYND_01")
	_idChar_HANG=GetCharacterID("Char_HANG")
	_idChar_RES_CAMP_00_1=GetCharacterID("Char_RES_CAMP_00_1")
	_idChar_RES_CAMP_00_2=GetCharacterID("Char_RES_CAMP_00_2")
	_idChar_RES_CAMP_00_3=GetCharacterID("Char_RES_CAMP_00_3")
	_idChar_RES_CAMP_00_4=GetCharacterID("Char_RES_CAMP_00_4")
	_idChar_RES_CAMP_00_5=GetCharacterID("Char_RES_CAMP_00_5")
	_idChar_RES_CAMP_00_6=GetCharacterID("Char_RES_CAMP_00_6")
	_idChar_RES_CAMP_00_7=GetCharacterID("Char_RES_CAMP_00_7")
	_idChar_RES_CAMP_00_8=GetCharacterID("Char_RES_CAMP_00_8")
	_idChar_RES_CAMP_00_9=GetCharacterID("Char_RES_CAMP_00_9")
	_idChar_RES_CAMP_00_10=GetCharacterID("Char_RES_CAMP_00_10")
	_idChar_RES_CAMP_00_11=GetCharacterID("Char_RES_CAMP_00_11")
	_idChar_RES_CAMP_00_12=GetCharacterID("Char_RES_CAMP_00_12")
	_idChar_RES_CAMP_00_13=GetCharacterID("Char_RES_CAMP_00_13")
	_idChar_RES_CAMP_00_14=GetCharacterID("Char_RES_CAMP_00_14")
	_idChar_RES_CAMP_00_15=GetCharacterID("Char_RES_CAMP_00_15")
	_idChar_RES_CAMP_00_16=GetCharacterID("Char_RES_CAMP_00_16")
	_idChar_RES_CAMP_00_17=GetCharacterID("Char_RES_CAMP_00_17")
	_idChar_RES_CAMP_00_18=GetCharacterID("Char_RES_CAMP_00_18")
	_idChar_RES_CAMP_00_19=GetCharacterID("Char_RES_CAMP_00_19")
	_idChar_RES_CAMP_00_20=GetCharacterID("Char_RES_CAMP_00_20")
	_idChar_RES_CAMP_00_21=GetCharacterID("Char_RES_CAMP_00_21")
	_idChar_RES_CAMP_00_22=GetCharacterID("Char_RES_CAMP_00_22")
	_idChar_RES_CAMP_00_23=GetCharacterID("Char_RES_CAMP_00_23")
	_idChar_RES_CAMP_00_24=GetCharacterID("Char_RES_CAMP_00_24")

		-----------------------
		-----------------------
	_idExoskeleton_1=GetExoskeletonID("Exoskeleton_1")
	_idExoskeleton_2=GetExoskeletonID("Exoskeleton_2")
	_idExoskeleton_3=GetExoskeletonID("Exoskeleton_3")	
	_idExoskeleton_4=GetExoskeletonID("Exoskeleton_4")

_nHealth_EXO_A=GetVarValue(GetExoskeletonID("Exoskeleton_1"),"Health")
_nHealth_EXO_B=GetVarValue(GetExoskeletonID("Exoskeleton_2"),"Health")
_nHealth_EXO_C=GetVarValue(GetExoskeletonID("Exoskeleton_3"),"Health")
_nHealth_EXO_D=GetVarValue(GetExoskeletonID("Exoskeleton_4"),"Health")
_nHEALTH_WEAK_POINT=GetVarValue(GetExoskeletonID("Exoskeleton_4"),"Weakpoint Health")

	-----------------------	
	_idParticleFX_Client_1=GetParticleFX_ClientID("ParticleFX_Client-1015")
	_idParticleFX_Client_2=GetParticleFX_ClientID("ParticleFX_Client-1016")
	_idParticleFX_Client_3=GetParticleFX_ClientID("ParticleFX_Client-1017")
	
	-----------------------
	_idChar_SYND_Exoman_01=GetCharacterID("Char_SYND_Exoman_01")
	_idChar_SYND_Exoman_02=GetCharacterID("Char_SYND_Exoman_02")
	_idChar_SYND_Exoman_03=GetCharacterID("Char_SYND_Exoman_03")
	_idChar_SYND_Exoman_04=GetCharacterID("Char_SYND_Exoman_04")

	----------------------
	----------------------
	_idChar_SYND_01=GetCharacterID("Char_SYND_01")
	_idChar_SYND_02=GetCharacterID("Char_SYND_02")
	_idChar_SYND_03=GetCharacterID("Char_SYND_03")
	_idChar_SYND_04=GetCharacterID("Char_SYND_04")
	_idChar_SYND_05=GetCharacterID("Char_SYND_05")
	_idChar_SYND_06=GetCharacterID("Char_SYND_06")
	_idChar_SYND_07=GetCharacterID("Char_SYND_07")
	_idChar_SYND_08=GetCharacterID("Char_SYND_08")
	_idChar_SYND_09=GetCharacterID("Char_SYND_09")
	_idChar_SYND_10=GetCharacterID("Char_SYND_10")
	_idChar_SYND_11=GetCharacterID("Char_SYND_11")
	_idChar_SYND_12=GetCharacterID("Char_SYND_12")
	_idChar_SYND_13=GetCharacterID("Char_SYND_13")

	------------------------
	--------------------------
	_idChar_SYND_PARA_01=GetCharacterID("Char_SYND_PARA_01")
	_idChar_SYND_PARA_02=GetCharacterID("Char_SYND_PARA_02")
	_idChar_SYND_PARA_03=GetCharacterID("Char_SYND_PARA_03")
	_idChar_SYND_PARA_04=GetCharacterID("Char_SYND_PARA_04")
	_idChar_SYND_PARA_05=GetCharacterID("Char_SYND_PARA_05")
	_idChar_SYND_PARA_06=GetCharacterID("Char_SYND_PARA_06")
	_idChar_SYND_PARA_07=GetCharacterID("Char_SYND_PARA_07")
	_idChar_SYND_PARA_08=GetCharacterID("Char_SYND_PARA_08")
	_idChar_SYND_PARA_09=GetCharacterID("Char_SYND_PARA_09")
	_idChar_SYND_PARA_10=GetCharacterID("Char_SYND_PARA_10")
	_idChar_SYND_PARA_11=GetCharacterID("Char_SYND_PARA_11")
	_idChar_SYND_PARA_12=GetCharacterID("Char_SYND_PARA_12")
	_idChar_SYND_PARA_13=GetCharacterID("Char_SYND_PARA_13")
	_idChar_SYND_PARA_14=GetCharacterID("Char_SYND_PARA_14")
	_idChar_SYND_PARA_15=GetCharacterID("Char_SYND_PARA_15")
	_idChar_SYND_PARA_16=GetCharacterID("Char_SYND_PARA_16")
	_idChar_SYND_PARA_17=GetCharacterID("Char_SYND_PARA_17")
	_idChar_SYND_PARA_18=GetCharacterID("Char_SYND_PARA_18")
	_idChar_SYND_PARA_19=GetCharacterID("Char_SYND_PARA_19")
	_idChar_SYND_PARA_20=GetCharacterID("Char_SYND_PARA_20")
	_idChar_SYND_PARA_21=GetCharacterID("Char_SYND_PARA_21")
	_idChar_SYND_PARA_22=GetCharacterID("Char_SYND_PARA_22")
	_idChar_SYND_PARA_23=GetCharacterID("Char_SYND_PARA_23")
	_idChar_SYND_PARA_24=GetCharacterID("Char_SYND_PARA_24")
	_idChar_SYND_PARA_25=GetCharacterID("Char_SYND_PARA_25")
	_idChar_SYND_PARA_26=GetCharacterID("Char_SYND_PARA_26")
	_idChar_SYND_PARA_27=GetCharacterID("Char_SYND_PARA_27")
	_idChar_SYND_PARA_28=GetCharacterID("Char_SYND_PARA_28")
	_idChar_SYND_PARA_29=GetCharacterID("Char_SYND_PARA_29")
	_idChar_SYND_PARA_30=GetCharacterID("Char_SYND_PARA_30")
	_idChar_SYND_PARA_31=GetCharacterID("Char_SYND_PARA_31")


--------------------------------
-------------------------------
	_idChar_SYND_RUIN_01=GetCharacterID("Char_SYND_RUIN_01")
	_idChar_SYND_RUIN_02=GetCharacterID("Char_SYND_RUIN_02")
	_idChar_SYND_RUIN_03=GetCharacterID("Char_SYND_RUIN_03")
	_idChar_SYND_RUIN_04=GetCharacterID("Char_SYND_RUIN_04")
	_idChar_SYND_RUIN_05=GetCharacterID("Char_SYND_RUIN_05")
	_idChar_SYND_RUIN_06=GetCharacterID("Char_SYND_RUIN_06")
	_idChar_SYND_RUIN_07=GetCharacterID("Char_SYND_RUIN_07")
	_idChar_SYND_RUIN_08=GetCharacterID("Char_SYND_RUIN_08")
	_idChar_SYND_RUIN_09=GetCharacterID("Char_SYND_RUIN_09")
	_idChar_SYND_RUIN_10=GetCharacterID("Char_SYND_RUIN_10")
	_idChar_SYND_RUIN_11=GetCharacterID("Char_SYND_RUIN_11")
	_idChar_SYND_RUIN_12=GetCharacterID("Char_SYND_RUIN_12")
	_idChar_SYND_RUIN_13=GetCharacterID("Char_SYND_RUIN_13")
	_idChar_SYND_RUIN_14=GetCharacterID("Char_SYND_RUIN_14")
	_idChar_SYND_RUIN_15=GetCharacterID("Char_SYND_RUIN_15")
	_idChar_SYND_RUIN_16=GetCharacterID("Char_SYND_RUIN_16")
	_idChar_SYND_RUIN_17=GetCharacterID("Char_SYND_RUIN_17")
	_idChar_SYND_RUIN_18=GetCharacterID("Char_SYND_RUIN_18")



-----------------------------	
-----------------------------	

--ObjectiveDoneNewObjectiveNewSubObjective ("Obj_A","Obj_B","Obj_B_1" )

--NewSubObjective("Obj_A_1", "Obj_A_2")

--NewObjectiveNewSubObjective ("Obj_A","Obj_A_1")

-------------------------------------------------------------------------------------------------
	_bCam_1=0
	_bDepart=0
	_bFreeze_Hang=0
	_bOnExit_Sector_Event_0=0
	_bOnEnter_Sector_Event_Boom_1=0
	_bOnEnter_Sector_Event_0=0	
	_bOnEnter_Sector_Event_Ascenseur=0
	_bOnEnter_Sector_Event_Tente_1_heliport=0
	_bOnEnter_Sector_Event_Game=0
	_bOnEnter_Sector_Event_Dial_Snipers=0
	_bNo_EXO=0
_bHuber_Gallery_1=0
_bExo_Destroyed=0
_bExo_Desactivating=0
	_bHuber_Passage=0
	_bMort_Snip_04=0
	_bMort_Snip_05=0
	_bonEnter_Sector_Event_Check_Dial=0
	_bOnEnter_Sector_Event_DEF_WEST=0
	_bOnExit_Sector_Event_DEF_WEST=0
--	_bRenforts=0
	_bOnEnter_Sector_Event_Debut_Corniche=0
	_bOnEnter_Sector_Event_Corniche_SECOURS=0
	_bOnEnter_Sector_Event_Corniche_2=0
	_bOnEnter_Sector_Event_Corniche_3=0
	_bCpar_la=0
	_bOnEnter_Sector_Event_RUIN_01=0
	_bOnEnter_Sector_Event_RUIN_02=0
	_bOnEnter_Sector_Event_RUIN_03=0
	_bOnEnter_Sector_Event_RUIN_04=0
	_bGo_Steal_Exo=0
	_bIn_Exo=0
	_bBlock_Grotte=0
	_bBlock_Grotte_Player=0
	_bOnEnter_Sector_Event_BOYAU=0
	_bOnExit_Sector_Event_BOYAU=0
	_bOnDeath_Tank_SYND_01=0
	_bFIN_INGE=0
_bTank_Vs_player=0
_bTank_Fire_At_Position=0
	_bonEnter_Sector_Event_Check_Dial=0
	_bOnStay_Sector_Event_Control_Player_Right=0
	_bOnExit_Sector_Event_Control_Player_Right=0
	_bEXO_A_VS_HUBER=0
_bExo_Desactivating=0
_bExo_Destroyed=0
_bOnEnter_Sector_Event_Go_Back=0
_bOnEnter_Sector_Event_End_Of_Level=0
--_bREPAIR=0
_bIs_Saved=0
_bIS_IN_EXO=false
_bNew_WeakPoint_health = 0
end

