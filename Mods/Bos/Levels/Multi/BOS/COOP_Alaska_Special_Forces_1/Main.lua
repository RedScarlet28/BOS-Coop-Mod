-------------------------------
-- ::::::::::::::::::::::::: --
function InitLevel()
-- ::::::::::::::::::::::::: --
-------------------------------
	CheckInitLevel_special_forces_1()

	InitScriptVariable()

	Precache_Dials()

	OpenDoor(GetDoorID("Door_64"))
	OpenDoor(GetDoorID("Door_65"))
	OpenDoor(GetDoorID("Door_57"))
	OpenDoor(GetDoorID("Door_58"))
	ConfigMerc()

	
end
		
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
			_idPasdeListe=GetInvalidEntityID()
			SetVarValue(_idMerc[i],"CharacterOrderList",_idPasdeListe)
		end

-------------------------------------------------------------
-- :::: CHAMPIONS :::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

-- Champion_Blackcat_Kity ->	Char_Champion_0_1
-- Champion_Guillermo_Canas	->	Char_Champion_0_2
-- Champion_Hakim Ragab_the_Destroyer	->	Char_Champion_0_3


		-- Récupère l'ID du Champion actif pour la zone 0
		_idChampion_0 = GetChampionFromArea(0)
		_bAlive_idChampion_0=IsAlive(_idChampion_0)

		AssignChampionToPlayer("Champion_Nolan_Special_Forces_0")

		ActiveTrackingMercs()

				EnableCharacterCommand(_idChar_SCENE_00_3,false)
				EnableCharacterCommand(_idChar_SCENE_00_4,false)
				EnableCharacterCommand(_idChar_SCENE_00_5,false)
				EnableCharacterCommand(_idChar_SCENE_00_6,false)

	StartMusic("Sounds//Music//BoS - Twilight theme.wav",true)
	
-------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires ::::::: --
-------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	SetVarValue(GetCharacterID("Player"),"Paratrooper",true)
	Freeze(GetCharacterID("Player"),true)
	
end


-------------------------------
-- ::::::::::::::::::::::::: --
function UpdateLevel()
-- ::::::::::::::::::::::::: --
-------------------------------

	GlobalPlayerIsDead()

	UpdateLevel_Start()
	UpdateLevel_Warehouse()
	UpdateLevel_Avenue()
	UpdateLevel_Place()
	GlobalPlayerIsDead()
--	GlobalIngenieurIsDead()
--	MaVie()
--	Vie()
	Cam_intro()
--	InitLevel_Reload()
	--MercAlive() 
--------------------------------Start-----------
--	Objectif_Principal_1()
	SecondWave()
	Parcours_WRF_1()
	WRF_etape_3()
	WRF_etape_4()
	WRF_etape_5()
--	Plan_fix()
-------------------------------------------------------
------------------------------------------------------
	UpdateLevel_FX_CARS()
----------------------------------------------------
--------------------------------Place------------
	Alerte_place()
	Renforts_Place_1()
	Exterminer()
	--------------------------------Avenue-----------
	Renforts_Avenue()
	Renforts_avenue_1()
	Renforts_Avenue_2()
	Renforts_Avenue_2bis()
	--------------------------------Warehouse-----------
	--Win()
	Renforts_warehouse()
	Boss()
	Entrpot()
--	Disable_Merc()
--	Combat_BOSS()
	--Loose()
---DEBUG BOTactiv
   
PrintDebug(" "..GetTotalActiveCharacterCount().."\n")

	if _idChampion_0 == (GetCharacterID("Char_Champion_0_3")) then
		Champion_Shield_Desactivation_Reloading(_idChampion_0,"Plug_MagneticShield_Champion_0_3")
	end
	if _idChampion_0 == (GetCharacterID("Char_Champion_0_2")) then
		Champion_Stop_Turning_Reloading(_idChampion_0,"AI_Order_List_champion_2")
	end

	DesactiveTrackingMercs()
end
-----------------------------------------------------
function InitScriptVariable()

	--les acteurs:
_idParticleFX_Client_1023=GetParticleFX_ClientID("ParticleFX_Client_1023")
	_idPlayer=GetLocalCharacterID("Player")
----------------------------------------------------
	_idChar_WRF_01_1=GetCharacterID("Char_WRF_01_1")
	_idChar_WRF_01_2=GetCharacterID("Char_WRF_01_2")
	_idGrp_WRF_01=GetGroupID("Grp_WRF_01")
---------------------------------------------------
	_idChar_Merc_1=GetCharacterID("Char_Merc_1")
	_idChar_Merc_2=GetCharacterID("Char_Merc_2")
	_idChar_REPERE=GetCharacterID("Char_REPERE")

	------------------------------------------------------------------
	_idChar_SYNDICAT_1=GetCharacterID("Char_SYNDICAT_1")
	_idChar_SYNDICAT_2=GetCharacterID("Char_SYNDICAT_2")	
--	_idDoor_bos_1=GetDoorID("Door_bos_1")
--	_idDoor_bos_2=GetDoorID("Door_bos_2")	
--------------------------------------------------
	_idChar_UAN_Place_00_1=GetCharacterID("Char_UAN_Place_00_1")
	_idChar_UAN_Place_00_3=GetCharacterID("Char_UAN_Place_00_3")
	_idChar_UAN_Place_00_4=GetCharacterID("Char_UAN_Place_00_4")	
	_idChar_UAN_Place_00_6=GetCharacterID("Char_UAN_Place_00_6")
	_idGroup_UAN_Place_01=GetGroupID("Group_UAN_Place_01")
--------------------------------------------------
	_idChar_UAN_Rue_01_1=GetCharacterID("Char_UAN_Rue_01_1")
	_idChar_UAN_Rue_01_5=GetCharacterID("Char_UAN_Rue_01_5")
	_idChar_UAN_Rue_01_3=GetCharacterID("Char_UAN_Rue_01_3")
	_idChar_UAN_Rue_01_7=GetCharacterID("Char_UAN_Rue_01_7")
	_idGrp_UAN_Rue_01=GetGroupID("Grp_UAN_Rue_01")
---------------------------------------------------
	_idChar_UAN_porte_Place_02_1=GetCharacterID("Char_UAN_porte_Place_02_1")
-----------------------------------------------------
	_idChar_UAN_porte_Place_03_2=GetCharacterID("Char_UAN_porte_Place_03_2")
--------------------------------------------------------
	--_idChar_UAN_Avenue_00_1=GetCharacterID("Char_UAN_Avenue_00_1")
	_idChar_UAN_Avenue_00_3=GetCharacterID("Char_UAN_Avenue_00_3")
	_idChar_UAN_Avenuecour_00_4=GetCharacterID("Char_UAN_Avenuecour_00_4")
-----------------------------------------------------------
	_idChar_UAN_Avenue_01_1=GetCharacterID("Char_UAN_Avenue_01_1")
	_idChar_UAN_Avenue_01_2=GetCharacterID("Char_UAN_Avenue_01_2")
	_idGrp_UAN_Avenue_01=GetGroupID("Grp_UAN_Avenue_01")
	_idGrp_UAN_Avenue_03=GetGroupID("Grp_UAN_Avenue_03")
	_idGrp_UAN_Avenue_04=GetGroupID("Grp_UAN_Avenue_04")
		_idGrp_UAN_Avenue_05=GetGroupID("Grp_UAN_Avenue_05")
---------------------------------------------------------
	_idChar_UAN_Avenue_02_1=GetCharacterID("Char_UAN_Avenue_02_1")

	_idChar_UAN_Avenue_02_3=GetCharacterID("Char_UAN_Avenue_02_3")
	_idGrp_UAN_Avenue_02=GetGroupID("Grp_UAN_Avenue_02")
----------------------------------------------
	_idChar_UAN_Chaudiere_03_1=GetCharacterID("Char_UAN_Chaudiere_03_1")
	_idChar_UAN_Chaudiere_03_2=GetCharacterID("Char_UAN_Chaudiere_03_2")
----------------------------------------------------------
	_idChar_UAN_Palissade_00_1=GetCharacterID("Char_UAN_Palissade_00_1")
	_idChar_UAN_Warehouse_00_1=GetCharacterID("Char_UAN_Warehouse_00_1")
	_idChar_UAN_Warehouse_00_2=GetCharacterID("Char_UAN_Warehouse_00_2")
	_idChar_UAN_Warehouse_00_3=GetCharacterID("Char_UAN_Warehouse_00_3")
	_idChar_UAN_Warehouse_00_4=GetCharacterID("Char_UAN_Warehouse_00_4")
	_idChar_UAN_Warehouse_01_1=GetCharacterID("Char_UAN_Warehouse_01_1")
	_idChar_UAN_Warehouse_01_2=GetCharacterID("Char_UAN_Warehouse_01_2")
	_idChar_UAN_Warehouse_01_5=GetCharacterID("Char_UAN_Warehouse_01_5")
	_idGroup_UAN_Warehouse_01=GetGroupID("Group_UAN_Warehouse_01")
	_idGroup_UAN_Warehouse_02=GetGroupID("Group_UAN_Warehouse_02")
------------------------------------------------------------------
	
	_idGroup_UAN_Warehouse_02=GetGroupID("Group_UAN_Warehouse_02")
	_idChar_UAN_Peloton_00_1=GetCharacterID("Char_UAN_Peloton_00_1")
	_idChar_UAN_Peloton_00_2=GetCharacterID("Char_UAN_Peloton_00_2")
	_idChar_UAN_Peloton_00_3=GetCharacterID("Char_UAN_Peloton_00_3")
------------------------------------------------------------
	_idChar_UAN_Entrepot_00_1=GetCharacterID("Char_UAN_Entrepot_00_1")
	_idChar_UAN_Entrepot_00_2=GetCharacterID("Char_UAN_Entrepot_00_2")
	_idChar_UAN_Entrepot_00_4=GetCharacterID("Char_UAN_Entrepot_00_4")
	_idChar_UAN_Entrepot_00_5=GetCharacterID("Char_UAN_Entrepot_00_5")
	_idChar_UAN_Entrepot_00_6=GetCharacterID("Char_UAN_Entrepot_00_6")
	_idChar_UAN_Entrepot_00_7=GetCharacterID("Char_UAN_Entrepot_00_7")
	_idChar_UAN_Entrepot_00_8=GetCharacterID("Char_UAN_Entrepot_00_8")
	_idChar_UAN_Entrepot_00_9=GetCharacterID("Char_UAN_Entrepot_00_9")
	_idChar_UAN_Entrepot_00_10=GetCharacterID("Char_UAN_Entrepot_00_10")
	_idChar_UAN_Entrepot_00_11=GetCharacterID("Char_UAN_Entrepot_00_11")
	_idChar_UAN_Entrepot_00_12=GetCharacterID("Char_UAN_Entrepot_00_12")
	_idChar_UAN_Entrepot_00_13=GetCharacterID("Char_UAN_Entrepot_00_13")
	_idChar_UAN_Entrepot_00_14=GetCharacterID("Char_UAN_Entrepot_00_14")
	_idChar_UAN_Entrepot_00_15=GetCharacterID("Char_UAN_Entrepot_00_15")
	_idChar_UAN_Entrepot_00_16=GetCharacterID("Char_UAN_Entrepot_00_16")
-----------------------------------------------------------------
	_idChar_UAN_Renforts_warehouse_02_1=GetCharacterID("Char_UAN_Renforts_warehouse_02_1")
	_idChar_UAN_Renforts_warehouse_02_2=GetCharacterID("Char_UAN_Renforts_warehouse_02_2")
	_idChar_UAN_Renforts_warehouse_02_3=GetCharacterID("Char_UAN_Renforts_warehouse_02_3")
	_idChar_UAN_Renforts_warehouse_02_4=GetCharacterID("Char_UAN_Renforts_warehouse_02_4")
-----------------------------------------------------------------
	_idChar_SCENE_00_1=GetCharacterID("Char_SCENE_00_1")
	_idChar_SCENE_00_2=GetCharacterID("Char_SCENE_00_2")
	_idChar_SCENE_00_3=GetCharacterID("Char_SCENE_00_3")
	_idChar_SCENE_00_4=GetCharacterID("Char_SCENE_00_4")
	_idChar_SCENE_00_5=GetCharacterID("Char_SCENE_00_5")
	_idChar_SCENE_00_6=GetCharacterID("Char_SCENE_00_6")

-----------------------------------------------------
		

		--LES OBJETS DETRUITS :

	_idDestructible_Object_18=GetDestructible_ObjectID("Destructible_Object-18")
	_idDestructible_Object_19=GetDestructible_ObjectID("Destructible_Object-19")
	_idDestructible_Object_20=GetDestructible_ObjectID("Destructible_Object-20")
	_idDestructible_Object_21=GetDestructible_ObjectID("Destructible_Object-21")
	_idDestructible_Object_22=GetDestructible_ObjectID("Destructible_Object-22")
	_idDestructible_Object_23=GetDestructible_ObjectID("Destructible_Object-23")
	_idDestructible_Object_24=GetDestructible_ObjectID("Destructible_Object-24")
	_idDestructible_Object_25=GetDestructible_ObjectID("Destructible_Object-25")
	_idDestructible_Object_26=GetDestructible_ObjectID("Destructible_Object-26")
	_idDestructible_Object_27=GetDestructible_ObjectID("Destructible_Object-27")
	_idDestructible_Object_28=GetDestructible_ObjectID("Destructible_Object-28")
	_idDestructible_Object_29=GetDestructible_ObjectID("Destructible_Object-29")
	_idDestructible_Object_30=GetDestructible_ObjectID("Destructible_Object-30")
	_idDestructible_Object_31=GetDestructible_ObjectID("Destructible_Object-31")



		--LES FX :

			
_idParticleFX_Client_feu_01=GetParticleFX_ClientID("ParticleFX_Client_feu_01")
_idParticleFX_Client_feu_02=GetParticleFX_ClientID("ParticleFX_Client_feu_02")
_idParticleFX_Client_feu_03=GetParticleFX_ClientID("ParticleFX_Client_feu_03")
_idParticleFX_Client_feu_04=GetParticleFX_ClientID("ParticleFX_Client_feu_04")
_idParticleFX_Client_feu_05=GetParticleFX_ClientID("ParticleFX_Client_feu_05")
_idParticleFX_Client_feu_06=GetParticleFX_ClientID("ParticleFX_Client_feu_06")
_idParticleFX_Client_feu_07=GetParticleFX_ClientID("ParticleFX_Client_feu_07")
_idParticleFX_Client_feu_08=GetParticleFX_ClientID("ParticleFX_Client_feu_08")
_idParticleFX_Client_feu_09=GetParticleFX_ClientID("ParticleFX_Client_feu_09")
_idParticleFX_Client_feu_10=GetParticleFX_ClientID("ParticleFX_Client_feu_10")
_idParticleFX_Client_feu_11=GetParticleFX_ClientID("ParticleFX_Client_feu_11")
_idParticleFX_Client_feu_12=GetParticleFX_ClientID("ParticleFX_Client_feu_12")
_idParticleFX_Client_feu_13=GetParticleFX_ClientID("ParticleFX_Client_feu_13")
_idParticleFX_Client_feu_14=GetParticleFX_ClientID("ParticleFX_Client_feu_14")














---------------------------------------------------------------
_bCam_1=0
--_bConsigne_depart=0
_bOnEnter_Sector_Event_start=0
_bParcours_WRF_1=0
_bOnEnter_Sector_Event_Start_1=0
--_bWarning=0
_bOnEnter_Sector_Event_Alarme_rue=0
_bSecondWave=0
_bOnExit_Sector_Event_Secure_Spawn=0
_bOnEnter_Sector_Event_coin_rue=0
_bChangeLeader=0
_bPlan_fix=0
_bOnEnter_Sector_Event_declencheur_spawn_1=0
_bAlerte_place=0
_bOnEnter_Sector_Event_Porte_1=0
_bRenforts_Place_1=0
_bOnEnter_Sector_Event_1_FLOOR=0
_bOnEnter_Sector_Event_Place=0
--_bRenforts_avenue_2=0
_bExterminer=0
_bOnExit_Sector_Event_Entree_porte_place=0
_bBoss_1=0
_bWRF_etape_3=0
_bWRF_etape_4=0
_bWRF_etape_5=0
_bOnExit_Sector_Event_Porte_2=0
_bRenforts_avenue_1=0

_bOnEnter_Sector_Event_Barricade_Avenue=0
_bOnEnter_Sector_Event_Avenue_Milieu=0
_bRenforts_Avenue=0
_bOnEnter_Sector_Event_Avenue_Reserve=0
--_bOnStay_Sector_Event_Zone_BOSS_1=0
_bOnEnter_Sector_Event_Entree_chaudiere=0
_bOnEnter_Sector_Event_Grille_Closed=0
_bOnEnter_Sector_Event_securit_grilleclosed=0

_bOnEnter_Sector_Event_securit_not_triche=0

_bOnEnter_Sector_Event_Entree_Warehouse=0
_bRenforts_warehouse=0
_bOnEnter_Sector_Event_Sortie_explo_ok=0
_bOnEnter_Sector_Event_Escalier_entrepot=0
_bOnEnter_Sector_Event_Warehouse_middle=0
_bOnEnter_Sector_Event_Peloton=0
_bOnEnter_Sector_Event_pass=0
_bOnEnter_Sector_Event_cour_warehouse=0
_bBoss=0
--_bOnEnter_Sector_Event_endoflevel=0
_bWin=0
_bEntrpot=0
_bDisable_Merc=0
_bCombat_BOSS=0
_bObjectif_Principal_1=0
_bLoose=0
_bMaVie=0
_bLaunch=0
_bOnEnter_Sector_Event_zone_interdite_entrepot=0
_bOnEnter_Sector_Event_securit_not_triche=0
----------------
--::INTRO CAM---::::
-------------------
_bCam_intro=0
_bVie=0
---------------------------
------------------------------
_bCAR_1=0
_bCAR_2=0
_bCAR_3=0
_bCAR_4=0
_bCAR_5=0
_bCAR_6=0
_bCAR_7=0
_bCAR_8=0
_bCAR_9=0
_bCAR_10=0
_bCAR_11=0
_bCAR_12=0
_bCAR_13=0
_bCAR_14=0

-----------------
end
--------------------------------------------------
function Precache_Dials()

PrecacheSentence("DIA_SPE_NIV_G_GENERAL_RADIO_01")
PrecacheSentence("DIA_SPE_NIV_G_GENERAL_RADIO_03")

PrecacheSentence("DIA_SPE_NIV_G_MERCE_B_01")
PrecacheSentence("DIA_SPE_NIV_G_MERCE_A_02")
PrecacheSentence("DIA_SPE_NIV_G_WRF_C_01")

end



