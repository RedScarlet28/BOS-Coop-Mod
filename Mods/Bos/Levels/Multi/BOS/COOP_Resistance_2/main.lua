------------------------------------------------------------
------------------------------------------------------------

-- ::: InitLevel :::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function InitLevel()
	CheckInitLevel_resistance_2()

-------------------------------------------------------------
-- :::: MERCENAIRES :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère les ID des Mercs actifs et leur colle une AIOL
		_idMerc={}
		number = GetMercenaryCount() 
		number = number - 1
		for i=0,number,1 do
				_idMerc[i] = GetMercenary(i) 
		end

	if (_idMerc[0] ~= nil) then 
		SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AIOL_Huber_Intro"))
	end
	if (_idMerc[1] ~= nil) then 
		SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AIOL_Merc1_Intro"))
	end 

	ActiveTrackingMercs()
-------------------------------------------------------------
-- :::: AUTRES INIT. ::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

	InitScriptVariable()

	
-------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires ::::::: --
-------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	
--[[ Démarrage de l'action --]]

	Demarrage()

	SoundPrecache()

end

------------------------------------------------------------
------------------------------------------------------------

-- ::: UpdateLevel :::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function UpdateLevel()

------------------------------------------------------------
-- ::: Debug Functions :::::::::::::::::::::::::::::::::: --
------------------------------------------------------------

--[[ Teste en permanence s'il y a un dialogue à afficher ou pas --]]

	AppelDialogue(_bDepart,_nTime,_strText)

--[[ :::: DEBUG :::: Compteur persos actifs --]]

	ActiveBots()

--[[ Teste si Huber est vivant --]]

	GlobalHuberIsDead()

	GlobalPlayerIsDead()

------------------------------------------------------------
-- ::: Cloister ::::::::::::::::::::::::::::::::::::::::: --
------------------------------------------------------------

	UpdateCloister()

------------------------------------------------------------
-- ::: Heliport ::::::::::::::::::::::::::::::::::::::::: --
------------------------------------------------------------

	UpdateHeliport()

------------------------------------------------------------
-- ::: Court :::::::::::::::::::::::::::::::::::::::::::: --
------------------------------------------------------------

	UpdateCourt()

	DesactiveTrackingMercs()

end

--[[ On initialise toutes les variables globales à un niveau
	(toutes les variables nommées _NomDeVariable) 
	dans cette fonction appelée dans InitLevel() --]]

function InitScriptVariable()
	_idPlayer = GetLocalCharacterID(Player)
--	_idHuber = GetCharacterID("Char_Resist_Huber")

	_bPlayerIci = true
	_bActiveSpawnGrp5 = false

	_bHuberEtage = false
	_PathHuberActiv = true

	_bCtrlSector_Event_Court_4 = false

	_bCtrlReloadRoom = true

	_bCtrlSector_Event_Cloister_LZ_2 = false

	_bOrdreTroopers_FT_Resist_Cloister_00_10 = false
	_bOrdreTroopers_FT_Resist_Cloister_00_11 = false

	_bCtrlDIA_SPE_NIV_O_HUBER_D_26 = false
	_bCtrlDIA_SPE_NIV_O_HUBER_D_04 = false

	_bCtrlAliveTroopers_01_02 = false
	_bCtrlAliveTroopers_03 = false
	_bCtrlAliveTroopers_04 = false
	_bCtrlAliveTroopers_05_06a = false
	_bCtrlAliveTroopers_05_06b = false
	_bCtrlAliveTroopers_07_08 = false

	_bOrdreHuber1 = false
	_bOrdreHuber2 = false
	_bOrdreHuber3 = false
	_bOrdreHuber3b = false
	_bOrdreHuber4 = false
	_bOrdreHuber5 = false
	_bOrdreHuber6 = false
	_bOrdreHuber7 = false
	_bOrdreHuber8 = false
	_bOrdreHuber9 = false
	_bOrdreHuber10 = false
	_bOrdreHuber11 = false

	_bCtrlVieHuber = false

	_bCtrlTestVieHuber = false

	_bReActiveSector_Event_Court_11 = false
	_bWaypointDoor_CourtMonastery = false

	_bDjaJoue1 = false
	_bDjaJoue2 = false
	_bDjaJoue3 = false

	_bCtrlSector_Event_Court_3 = false

	_bOrdrePlayer_Cinema_1 = false
	_bOrdrePlayer_Cinema_2 = false
	_bOrdreMerc_Cinema_1 = false
	_bOrdreMerc_Cinema_2 = false

	_bCtrlGrp_Syndic_Court_Vrai_03 = false

	_bCtrlJoueurApprocheFin = false

	_bWaypointSyndicCourt1 = false

	_bCtrlDoor_CourtMonastery = false

	_nHuberPasse = 0
	_nPlayerPasse = 0
	_bCtrlDialogCaporal = false
	_bCtrlDialogHuber1 = false

	_nAliveSniper_1 = 1
	_nAliveSniper_2 = 1

	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_2 = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_3 = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_4 = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_5 = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_6 = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_7 = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_8 = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_8b = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_9 = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_10 = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_11 = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_12 = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_13 = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_14 = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_15 = false
	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_16 = false

	_bReActiveSector_Event_Court_4 = false

	_CtrlDialogHuber04 = false
	_nCompteurSpawns = 0
	_bNbActifsMax = true
	_bActivRespawn = false
	_bOkParas1 = false
	_bNbActifsMax2 = true
	_bGroup5Unfreeze = false
	_bCtrlParasCloitre = false
	_bCtrlHuberCanSeePlayer = false
	_bCtrlDialogueHuber = false
	_bCtrlAliveSyndicCloitre = false
	_bActiveFollowHuber = false
	_nHuberPasse = 0
	_nPlayerPasse2 = 0
	_bPlayerPasseHeli1 = false
	_bKillPathHeli1 = false
	_bKillPathHeli2 = false
	_bKillPathHeli3 = false
	_nHuberHeliPasse = 98
	_nPlayerHeliPasse = 98
	_bKillGrp_Syndic_Heliport_01 = false
	_bNbActifsMax3 = true
	_bGrp_Syndic_Heliport_01Unfreeze = false
	_bCtrlParasHeliport1 = false
	_bOkParas2 = false
	_bKillGrp_Syndic_Heliport_02 = false
	_bNbActifsMax4 = true
	_bGrp_Syndic_Heliport_02Unfreeze = false
	_bCtrlParasHeliport2 = false
	_bOkParas3 = false
	_bCtrlAliveSyndicHeli = true
	_bCtrlSector_Event_Heliport_4 = false
	_bCtrlSector_Event_Heliport_5 = false
	_nPlayerCourtPasse = true
	_nHuberCourtPasse = true
	_bWaypointExpir1 = false
	_bKillLimitZoneSyndic = false
	_bKillLimitZoneResist = false
	_bKillLimitZoneHuber = false
	_bKillFollowHuber = false
	PasDejaFait1 = true
	PasDejaFait2 = true
	_bGrp_Syndic_Court_02Unfreeze = false
	_bCtrlParasCourt2 = false
	_bCtrlAliveSyndicCourt2 = true
	_bCtrlAliveSyndicCourt1 = true
	_bChar_Syndic_01aPasSorti = true
	_bChar_Syndic_01bPasSorti = true
	_bCtrlAliveSyndic_Court_01 = true
	_bCtrlAliveSyndic_Court_02 = true
	_bCtrlHuberHeliPasse2 = false
	_bPlayerHeliPasse2 = false
	_bCtrlLibererFront1 = true
	_bCtrlLibererFront2 = true
	_bCtrlLibererFront3 = true
	_bCtrlLibererFront4 = true
	_bCtrl_Sector_Event_Heliport_5 = false
	_bCtrlParasHeliport3 = false
	_bCtrlSpawnParasHeliport1 = false
	_bCtrlSpawnParasHeliport2 = false
	_bCtrlSpawnParasHeliport3 = false
	_bActiveSector_Event_Heliport_8 = false
	_bCtrlSector_Event_Heliport_8 = true

	_bCtrlOpenDoor_HeliCourt = false

	_bPlayerPasseSector_Event_Court_10 = false

	_bPathway = false

	_bHuberPasseSector_Event_Heliport_8 = false
	_bPlayerPasseSector_Event_Heliport_8 = false

	_bFollowIngeTortue1 = false
	_bFollowIngeTortue2 = false
	_bFollowIngeTortue3 = false
	_bFollowIngeTortue4 = false
	_bFollowIngeTortue5 = false

	_bCtrlVieTortue1 = true
	_bCtrlVieTortue2 = true
	_bCtrlVieTortue3 = true
	_bCtrlVieTortue4 = true
	_bCtrlVieTortue5 = true
end




------------------------------------------------------------
------------------------------------------------------------

-- ::: Précache des dial. ::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function SoundPrecache()

	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_19")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_20")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_21")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_32")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_33")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_34")
	PrecacheSentence("DIA_SPE_NIV_O_INGENIEUR_01")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_06")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_07")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_25")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_26")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_27")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_08")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_28")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_14")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_15")
	PrecacheSentence("DIA_SPE_NIV_O_SERGENT_01")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_16")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_17")
	PrecacheSentence("DIA_GEN_ACKNOWLEDGE_TEAM_B_VOICE_A_1")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_18")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_22")
	PrecacheSentence("DIA_GEN_ACKNOWLEDGE_TEAM_A_VOICE_B_3")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_23")
	PrecacheSentence("DIA_GEN_ACKNOWLEDGE_TEAM_A_VOICE_B_1")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_24")
	PrecacheSentence("DIA_GEN_START_FIRE_TEAM_A_VOICE_A_1")
	PrecacheSentence("DIA_SPE_NIV_O_HUBER_D_26")
	PrecacheSentence("DIA_GEN_DO_GROUP_FEAR_TEAM_B_VOICE_B_1")
	PrecacheSentence("DIA_SPE_NIV_O_RESIS_G_04")

end

