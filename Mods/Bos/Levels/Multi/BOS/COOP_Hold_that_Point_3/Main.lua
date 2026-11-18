function InitLevel()

	CheckInitLevel_hold_that_point_3()

-------------------------------------------------------------
-------------------------------------------------------------


-------------------------------------------------------------
---:::: PRECACHAGE DES DIALOGUES :::-------------------------
-------------------------------------------------------------
Precache_Dials()
StartMusic("Sounds//Music//Bos - South theme.wav",true)
-------------------------------------------------------------
-- :::: MERCENAIRES :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère les ID des Mercs actifs et leur colle une AIOL
		_idMerc={}
		number = GetMercenaryCount() 
		number = number - 1
		for i=0,number,1 do
				_idMerc[i] = GetMercenary(i) 
				_idPasDeListe=GetInvalidEntityID()
				SetVarValue(_idMerc[i],"CharacterOrderList",_idPasDeListe)
		end

		_idChar_Merc_0=_idMerc[0]
		----
		----
		_nBotsMorts=0
		_nBotsActifs=GetTotalActiveCharacterCount()
		----
-------------------------------------------------------------
-- :::: CHAMPIONS :::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

-- Champion_Takeshi_Kojima ->	Char_Champion_0_1
-- Champion_Chico_Flamingo	->	Char_Champion_0_2
-- Champion_Konfu_Qong	->	Char_Champion_0_3


		-- Récupère l'ID du Champion actif pour la zone 2
		_idChampion_0 = GetChampionFromArea(0)
		_bAlive_idChampion_0=IsAlive(_idChampion_0)

		AssignChampionToPlayer("Champion_Nolan_Hold_That_Point_2")
		

-- ::::::::::::::::::::::::: --
----------------------
		
----------------------
		InitScriptVariable()

--------------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires... ETC ::::::: --
--------------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	ActiveTrackingMercs()


----------------------
	Plan_Fix()
-----------------------
end
--------------------------------------------------
function UpdateLevel()

			DesactiveTrackingMercs()
		---DEBUG BOTactiv---------
			PrintDebug("Nb bots Actifs : "..GetTotalActiveCharacterCount().."\n")
			PrintDebug("Nb de morts : "..GetTotalDeadCharacterCount().."\n")   
			---------------------------
			
-----------------------------------------
			_nLife_Exo= GetVarValue(GetExoskeletonID("Exoskeleton_Player"),"Health") 
			PrintDebug("_nLife_Exo : ".._nLife_Exo.."\n")
			_nLife_Tank_1=GetVarValue(GetTankID("Tank_1"),"Health")
			PrintDebug("_nLife_Tank_1 : ".._nLife_Tank_1.."\n")
		-----------------------
		--FONCTION QUI TESTE SI LE PLAYER EST DANS L'EXO--
		----------------------
	if( IsAValidID(GetCharacterCurrentExoskeleton(_idPlayer)))then
		_bIS_IN = 0
	end


	if _idChampion_0 == (GetCharacterID("Char_Champion_0_2"))then
		Champion_Shield_Desactivation_Reloading(_idChampion_0,"Plug_MShield_Champion_0_2")
	end


		-----------------------
		--QUEL EST LE NOMBRE DE MORTS ?--Quel est le nombre de bots actifs ?--
		-----------------------
		_nBotsMorts=GetTotalDeadCharacterCount()
		_nBotsActifs=GetTotalActiveCharacterCount()

		-----------------------
		OBJ_CLEAN_AREA()
		Exo_Destroyed()
		Mort_Boss()
		Renforts_Tunnel()
		Remplacements()
		VieTank()
	--	Vie()
		Renforts_Rochers()
		Renforts_Tunnel_A()
		Renforts_Tunnel_B()
		Renforts_Baraques_1()
		Renforts_Baraques_2()
		Renforts_Baraques_3()
		Surprise()
		EXO_2_COME()
		Door_TECHROOM()
		Boss()
--		Disable_Merc()

-------------------------------------------------------------
-- :::::::: mort Player - mort INGENIEUR - ...ETC ::::::: --
-------------------------------------------------------------
	GlobalIngenieurIsDead()
	GlobalPlayerIsDead()
	DesactiveTrackingMercs()


end
-----------------------------------------------------
function InitScriptVariable()
--	les acteurs:

_idPlayer=GetLocalCharacterID("Player")
_idExo_Player=GetExoskeletonID("Exoskeleton_Player")
_idTank_1=GetTankID("Tank_1")
_idTank_2=GetTankID("Tank_2")

_idSound_Client_helico=GetSound_ClientID("Sound_Client_helico")

_idDoor_bos_1=GetDoorID("Door_bos_1")
_idDoor_bos_2=GetDoorID("Door_bos_2")
_idDoor_bos_3=GetDoorID("Door_bos_3")
_idDoor_bos_4=GetDoorID("Door_bos_4")
_idDoor_bos_5=GetDoorID("Door_bos_5")
_idDoor_bos_6=GetDoorID("Door_bos_6")
_idDoor_bos_7=GetDoorID("Door_bos_7")
_idDoor_bos_8=GetDoorID("Door_bos_8")







	--INDVD UAN--
_idSound_Client_509=GetSound_ClientID("Sound_Client509")
--_idSound_Client_510=GetSound_ClientID("Sound_Client510")

	_idCharacter_teleport_boss=GetCharacterID("Character_teleport_boss")

	_idChar_Champion_0_1=GetCharacterID("Char_Champion_0_1")
	_idChar_Champion_0_2=GetCharacterID("Char_Champion_0_2")
	_idChar_Champion_0_3=GetCharacterID("Char_Champion_0_3")		
		

	_idChar_UAN_SCENE_00_1=GetCharacterID("Char_UAN_SCENE_00_1")
	_idChar_UAN_SCENE_00_2=GetCharacterID("Char_UAN_SCENE_00_2")
	_idChar_UAN_SCENE_00_3=GetCharacterID("Char_UAN_SCENE_00_3")
	_idChar_UAN_SCENE_00_4=GetCharacterID("Char_UAN_SCENE_00_4")
	_idChar_UAN_SCENE_00_5=GetCharacterID("Char_UAN_SCENE_00_5")
	_idChar_UAN_SCENE_00_6=GetCharacterID("Char_UAN_SCENE_00_6")
	_idChar_UAN_SCENE_00_7=GetCharacterID("Char_UAN_SCENE_00_7")
	_idChar_UAN_SCENE_00_8=GetCharacterID("Char_UAN_SCENE_00_8")
	_idChar_UAN_SCENE_00_9=GetCharacterID("Char_UAN_SCENE_00_9")
	_idChar_UAN_SCENE_00_10=GetCharacterID("Char_UAN_SCENE_00_10")
	_idChar_UAN_SCENE_00_11=GetCharacterID("Char_UAN_SCENE_00_11")
	_idChar_UAN_SCENE_00_12=GetCharacterID("Char_UAN_SCENE_00_12")
	_idChar_UAN_SCENE_00_13=GetCharacterID("Char_UAN_SCENE_00_13")
	_idChar_UAN_SCENE_00_14=GetCharacterID("Char_UAN_SCENE_00_14")
	_idChar_UAN_SCENE_00_15=GetCharacterID("Char_UAN_SCENE_00_15")
	_idChar_UAN_SCENE_00_16=GetCharacterID("Char_UAN_SCENE_00_16")
	_idChar_UAN_SCENE_00_17=GetCharacterID("Char_UAN_SCENE_00_17")
			------------
	_idChar_UAN_TUNNEL_01_1=GetCharacterID("Char_UAN_TUNNEL_01_1")
	_idChar_UAN_TUNNEL_01_2=GetCharacterID("Char_UAN_TUNNEL_01_2")
	_idChar_UAN_TUNNEL_01_3=GetCharacterID("Char_UAN_TUNNEL_01_3")
	_idChar_UAN_TUNNEL_01_4=GetCharacterID("Char_UAN_TUNNEL_01_4")
	_idChar_UAN_TUNNEL_01_5=GetCharacterID("Char_UAN_TUNNEL_01_5")
	_idChar_UAN_TUNNEL_01_6=GetCharacterID("Char_UAN_TUNNEL_01_6")

			------------
	_idChar_UAN_ENTRANCE_01_1=GetCharacterID("Char_UAN_ENTRANCE_01_1")
	_idChar_UAN_ENTRANCE_01_2=GetCharacterID("Char_UAN_ENTRANCE_01_2")
	_idChar_UAN_ENTRANCE_01_3=GetCharacterID("Char_UAN_ENTRANCE_01_3")
	_idChar_UAN_ENTRANCE_01_4=GetCharacterID("Char_UAN_ENTRANCE_01_4")
	--------------

	_idChar_UAN_HOUSE_01_1=GetCharacterID("Char_UAN_HOUSE_01_1")	
	_idChar_UAN_HOUSE_01_2=GetCharacterID("Char_UAN_HOUSE_01_2")
	_idChar_UAN_HOUSE_01_3=GetCharacterID("Char_UAN_HOUSE_01_3")
	_idChar_UAN_HOUSE_01_4=GetCharacterID("Char_UAN_HOUSE_01_4")
	
	_idChar_UAN_HOUSE_02_1=GetCharacterID("Char_UAN_HOUSE_02_1")
	_idChar_UAN_HOUSE_02_2=GetCharacterID("Char_UAN_HOUSE_02_2")
	_idChar_UAN_HOUSE_02_3=GetCharacterID("Char_UAN_HOUSE_02_3")
	_idChar_UAN_HOUSE_02_4=GetCharacterID("Char_UAN_HOUSE_02_4")

			------------
	_idChar_UAN_MIRADOR_00_1=GetCharacterID("Char_UAN_MIRADOR_00_1")
	_idChar_UAN_MIRADOR_00_2=GetCharacterID("Char_UAN_MIRADOR_00_2")
	_idChar_UAN_PLAINE_01_1=GetCharacterID("Char_UAN_PLAINE_01_1")
	_idChar_UAN_PLAINE_01_2=GetCharacterID("Char_UAN_PLAINE_01_2")
			------------
	_idChar_UAN_CAMION_01_1=GetCharacterID("Char_UAN_CAMION_01_1")
	_idChar_UAN_CAMION_01_2=GetCharacterID("Char_UAN_CAMION_01_2")
	_idChar_UAN_CAMION_01_3=GetCharacterID("Char_UAN_CAMION_01_3")
	_idChar_UAN_CAMION_01_4=GetCharacterID("Char_UAN_CAMION_01_4")
	_idChar_UAN_CAMION_01_5=GetCharacterID("Char_UAN_CAMION_01_5")
	_idChar_UAN_CAMION_01_6=GetCharacterID("Char_UAN_CAMION_01_6")
			------------
	_idChar_UAN_WAREHOUSE_00_1=GetCharacterID("Char_UAN_WAREHOUSE_00_1")
	_idChar_UAN_WAREHOUSE_00_2=GetCharacterID("Char_UAN_WAREHOUSE_00_2")
	_idChar_UAN_WAREHOUSE_00_3=GetCharacterID("Char_UAN_WAREHOUSE_00_3")
	_idChar_UAN_WAREHOUSE_00_4=GetCharacterID("Char_UAN_WAREHOUSE_00_4")
	_idChar_UAN_WAREHOUSE_00_5=GetCharacterID("Char_UAN_WAREHOUSE_00_5")
	_idChar_UAN_WAREHOUSE_00_6=GetCharacterID("Char_UAN_WAREHOUSE_00_6")
	_idChar_UAN_WAREHOUSE_00_7=GetCharacterID("Char_UAN_WAREHOUSE_00_7")
	_idChar_UAN_WAREHOUSE_00_8=GetCharacterID("Char_UAN_WAREHOUSE_00_8")
	_idChar_UAN_WAREHOUSE_00_9=GetCharacterID("Char_UAN_WAREHOUSE_00_9")
		------------------
	_idChar_UAN_TANK_01_1=GetCharacterID("Char_UAN_TANK_01_1")
	_idChar_UAN_TANK_01_3=GetCharacterID("Char_UAN_TANK_01_3")
	-------------------------
	_idChar_UAN_PLATEFORME_01_2=GetCharacterID("Char_UAN_PLATEFORME_01_2")
		----------------
	_idChar_UAN_TECHROOM_00_1=GetCharacterID("Char_UAN_TECHROOM_00_1")
	_idChar_UAN_TECHROOM_00_2=GetCharacterID("Char_UAN_TECHROOM_00_2")
	_idChar_UAN_TECHROOM_00_3=GetCharacterID("Char_UAN_TECHROOM_00_3")
	_idChar_UAN_TECHROOM_00_4=GetCharacterID("Char_UAN_TECHROOM_00_4")
	_idChar_UAN_TECHROOM_00_5=GetCharacterID("Char_UAN_TECHROOM_00_5")
	_idChar_UAN_TECHROOM_00_6=GetCharacterID("Char_UAN_TECHROOM_00_6")
	_idChar_UAN_TECHROOM_00_7=GetCharacterID("Char_UAN_TECHROOM_00_7")
	_idChar_UAN_TECHROOM_00_8=GetCharacterID("Char_UAN_TECHROOM_00_8")
	_idChar_UAN_TECHROOM_00_9=GetCharacterID("Char_UAN_TECHROOM_00_9")
	_idChar_UAN_TECHROOM_00_10=GetCharacterID("Char_UAN_TECHROOM_00_10")
	_idChar_UAN_TECHROOM_00_11=GetCharacterID("Char_UAN_TECHROOM_00_11")
			------------
	_idChar_UAN_BARAQUES_01_1=GetCharacterID("Char_UAN_BARAQUES_01_1")
	_idChar_UAN_BARAQUES_01_2=GetCharacterID("Char_UAN_BARAQUES_01_2")
	_idChar_UAN_BARAQUES_01_3=GetCharacterID("Char_UAN_BARAQUES_01_3")
	_idChar_UAN_BARAQUES_01_4=GetCharacterID("Char_UAN_BARAQUES_01_4")
	_idChar_UAN_BARAQUES_02_1=GetCharacterID("Char_UAN_BARAQUES_02_1")
	_idChar_UAN_BARAQUES_02_2=GetCharacterID("Char_UAN_BARAQUES_02_2")
	_idChar_UAN_BARAQUES_02_3=GetCharacterID("Char_UAN_BARAQUES_02_3")
	_idChar_UAN_BARAQUES_02_4=GetCharacterID("Char_UAN_BARAQUES_02_4")
	_idChar_UAN_BARAQUES_03_1=GetCharacterID("Char_UAN_BARAQUES_03_1")
	_idChar_UAN_BARAQUES_03_2=GetCharacterID("Char_UAN_BARAQUES_03_2")
	_idChar_UAN_BARAQUES_03_3=GetCharacterID("Char_UAN_BARAQUES_03_3")
			-------------
	_idChar_UAN_GALERIE_00_1=GetCharacterID("Char_UAN_GALERIE_00_1")
	_idChar_UAN_GALERIE_00_2=GetCharacterID("Char_UAN_GALERIE_00_2")
	_idChar_UAN_GALERIE_00_3=GetCharacterID("Char_UAN_GALERIE_00_3")
	_idChar_UAN_GALERIE_00_4=GetCharacterID("Char_UAN_GALERIE_00_4")
			-------------
	--GROUP UAN--
	_idGroup_ENTRANCE_01=GetGroupID("Group_ENTRANCE_01")
	_idGroup_ENTRANCE_02=GetGroupID("Group_ENTRANCE_02")
	_idGroup_ENTRANCE_03=GetGroupID("Group_ENTRANCE_03")
	_idGroup_HOUSE_00=GetGroupID("Group_HOUSE_00")
	_idGroup_HOUSE_01=GetGroupID("Group_HOUSE_01")
	_idGroup_HOUSE_05=GetGroupID("Group_HOUSE_05")
	_idGroup_PATROUILLE_A=GetGroupID("Group_PATROUILLE_A")
	_idGroup_PATROUILLE_B=GetGroupID("Group_PATROUILLE_B")
	_idGroup_PATROUILLE_C=GetGroupID("Group_PATROUILLE_C")
	_idGroup_Scene=GetGroupID("Group_ENTRANCE_02")
	_idGroup_TUNNEL_02=GetGroupID("Group_TUNNEL_02")
	_idGroup_TUNNEL_03=GetGroupID("Group_TUNNEL_03")
	_idGroup_TUNNEL_04=GetGroupID("Group_TUNNEL_04")
	_idGroup_TUNNEL_05=GetGroupID("Group_TUNNEL_05")
	_idGroup_TANK_1=GetGroupID("Group_TANK_1")
	_idGroup_ROCHER_01=GetGroupID("Group_ROCHER_01")
	_idGroup_ROCHER_02=GetGroupID("Group_ROCHER_02")
	_idGroup_ROCHER_03=GetGroupID("Group_ROCHER_03")
	_idGroup_CAMION=GetGroupID("Group_CAMION")
	_idGroup_PLATEFORME_1=GetGroupID("Group_PLATEFORME_1")
	_idGroup_PLATEFORME_2=GetGroupID("Group_PLATEFORME_2")




-----------------------------------------------------
--_idChar_UAN_Champion=GetCharacterID("Char_UAN_Champion")
--------------------------------------------------------
_idChar_SYNDICATE_1=GetCharacterID("Char_SYNDICATE_1")

_idChar_SYNDICATE_2=GetCharacterID("Char_SYNDICATE_2")

_idChar_SYNDICATE_3=GetCharacterID("Char_SYNDICATE_3")

_idChar_SYNDICATE_4=GetCharacterID("Char_SYNDICATE_4")

-----------------------------------------------------------

---------------------------------------------------------
_bGroupBaraques_1_Mort=false
_bGroupBaraques_1_Mort=false
_bGroupBaraques_1_Mort=false
----------------------------------------------------------
_bPlan_Fix=0
_bVie=0
_bMaVie=0
--_bRenforts_Tunnel_A=0
--_bRenforts_Tunnel_B=0
_bOnEnter_Sector_Event_TUNNEL_1=0
_bOnEnter_Sector_Event_TUNNEL_2=0	
_bOnEnter_Sector_Event_TUNNEL_3=0
_bOnEnter_Sector_Event_TUNNEL_SORTIE=0
_bOnEnter_Sector_Event_TUNNEL_PORTE=0
_bOnEnter_Sector_Event_OUTSIDE_1=0
_bOnExit_Sector_Event_OUTSIDE_1=0
_bOnEnter_Sector_Event_OUTSIDE_2=0
_bOnEnter_Sector_Event_MIRADOR=0
_bOnExit_Sector_Event_HOUSE_1=0
_bOnEnter_Sector_Event_TANK=0
_bOnEnter_Sector_Event_CAMION=0
_bOnEnter_Sector_Event_RAMPE=0
_bOnEnter_Sector_Event_RAMPE_B=0
_bOnEnter_Sector_Event_LIMIT_ZONE_EXO_UAN=0
_bOnEnter_Sector_Event_WAREHOUSE=0
_bOnEnter_Sector_Event_CHAUDIERE_WAREHOUSE=0
_bOnEnter_Sector_Event_ISinDANGER=0
_bOnEnter_Sector_Event_MONTEE=0
_bOnEnter_Sector_Event_PLATEFORME_1=0
_bOnEnter_Sector_Event_DOWNSTAIRS=0
_bOnExit_Sector_Event_DOWNSTAIRS=0
_bSurprise=0
_bRenforts_Baraques_1=0
_bRenforts_Baraques_2=0
_bRenforts_Baraques_3=0
_bBoss=0
_bOnEnter_Sector_Event_ENTREE_TECHROOM=0
_bOnEnter_Sector_Event_COMMAND_TECHROOM=0
_bOnEnter_Sector_Event_SECURE_SPAWN_BARAK_2=0
_bCommand_OK=0
_bSUCCEED=0
_bIntro_Obj=0
_bDisable_Merc=0
_bOBJ_CLEAN_AREA=0
_bMort_Boss=0
_bVieTank=0
_bOnEnter_Sector_Event_SUITE_BOSS=0
_bEXO_2_COME=0
_bDoor_TECHROOM=0
_bOnEnter_Sector_Event_PLAINE_FIN=0
_bOnEnter_Sector_Event_Plateforme_inge=0
_bChange_color=0
_bChange_Door=0
_bOnEnter_Sector_Event_TUNNEL_TANK=0
_bOnExit_Sector_Event_TUNNEL_1=0
----
_bENDofDEMO=0
_bExo_Destroyed=0
_bOnExit_Sector_Event_TANK=0
_bOnEnter_Sector_Event_USINE=0
_bOnExit_Sector_Event_USINE=0
_bTeleportBoss=0
_bTeleportBoss_Third=0
_bCam_PreBOSS=0

_byetOnExit_Sector_Event_PLATEFORME_1=false
---------------------------------------------------------------
end

function Precache_Dials()

PrecacheSentence("DIA_GEN_COOL_TO_STRESS_TEAM_B_VOICE_B_1")
PrecacheSentence("DIA_SPE_NIV_K_INGENIEUR_09")
PrecacheSentence("DIA_SPE_NIV_E_INGENIEUR_26")
PrecacheSentence("DIA_SPE_NIV_H_INGENIEUR_24")
PrecacheSentence("DIA_SPE_NIV_K_GENERAL_RADIO_08")
PrecacheSentence("DIA_SPE_NIV_N_INGENIEUR_A_04")

end