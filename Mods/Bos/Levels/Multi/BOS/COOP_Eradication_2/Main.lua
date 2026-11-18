function InitLevel()
	CheckInitLevel_eradication_2()

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
		end
			_idChar_Merc_0=_idMerc[0]
			if (_idMerc[1] ~= nil) then 
				_idChar_Merc_1=_idMerc[1]
			end
			_idPasDeListe=GetInvalidEntityID()

		

		--_bAlive_idChar_Merc_0=IsAlive(_idMerc[0])
		
		if (_idMerc[1] ~= nil) then 
			_bAlive_idChar_Merc_1=IsAlive(_idMerc[1])
		end
		
		_nActifBots=GetTotalActiveCharacterCount()
		_nBotsMorts=0		

ActiveTrackingMercs()

InitScriptVariable()

StartMusic("Sounds//Music//Bos - South theme.wav",true)
-------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires ::::::: --
-------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
end
--------------------------------------------------
function UpdateLevel()


			DesactiveTrackingMercs()
			

	Appel_Dialogue(_bDepart,_nTime,_strText)
	_nActifBots=GetTotalActiveCharacterCount()
	_nBotsMorts=GetTotalDeadCharacterCount()
------------------------cloitre------------------
	Obj_3()
	Obj_5()
	ClearCloitre()
	Embush()
	Time30()
--	MaVie()
	GlobalPlayerIsDead()
	GlobalIngenieurIsDead()
--	DeaD_Inge()
	Nothing()
	Diversion()
	Renforts_terrasse()
	Renforts_terrasse_1()
	Renforts_terrasse_2()
--	Sound_Hack()
	Terrasse()
----------------------------Heliport----------------
	Renforts_start()
	Renforts_maison_1()
	Renforts_Heli()
--	Renforts_Court_1()
	Renforts_bas()
	Renforts_maison_3()

--------------------------------------------------------
---DEBUG BOTactiv
   
PrintDebug("Nb. Bots "..GetTotalActiveCharacterCount().."\n	Actifs :")
PrintDebug("Nb de morts : "..GetTotalDeadCharacterCount().."\n")
end
-----------------------------------------------------
function InitScriptVariable()
	--les acteurs:


	_idTimer_debut=GetTimerID("Timer_debut")
	_idTimer_terrasse=GetTimerID("Timer_terrasse")

	--_idChar_SYND_allie_ingenieur1=GetCharacterID("Char_SYND_allie_ingenieur1")
	_idPlayer=GetLocalCharacterID("Player")
	--_idChar_SYND_allie_ingenieur=GetCharacterID("Char_SYND_allie_ingenieur")
	_idChar_SYND_allie_01_1=GetCharacterID("Char_SYND_allie_01_1")
	_idChar_SYND_allie_01_2=GetCharacterID("Char_SYND_allie_01_2")
	_idExoskeleton_RES=GetExoskeletonID("Exoskeleton_RES")
-----------------------------------------------------
_idChar_RES_RDC_01_1=GetCharacterID("Char_RES_RDC_01_1")
_idChar_RES_RDC_01_2=GetCharacterID("Char_RES_RDC_01_2")
_idChar_RES_RDC_01_3=GetCharacterID("Char_RES_RDC_01_3")
_idChar_RES_RDC_01_4=GetCharacterID("Char_RES_RDC_01_4")
_idChar_RES_RDC_01_5=GetCharacterID("Char_RES_RDC_01_5")
_idChar_RES_RDC_01_6=GetCharacterID("Char_RES_RDC_01_6")
_idChar_RES_RDC_01_7=GetCharacterID("Char_RES_RDC_01_7")
_idChar_RES_RDC_01_8=GetCharacterID("Char_RES_RDC_01_8")

-----------------------------------------------------
_idChar_RES_Snip_00_1=GetCharacterID("Char_RES_Snip_00_1")
_idChar_RES_Snip_00_2=GetCharacterID("Char_RES_Snip_00_2")
_idChar_RES_Snip_00_3=GetCharacterID("Char_RES_Snip_00_3")
_idChar_RES_Snip_00_4=GetCharacterID("Char_RES_Snip_00_4")
_idChar_RES_Snip_00_5=GetCharacterID("Char_RES_Snip_00_5")

_idChar_RES_SNIPER_1=GetCharacterID("Char_RES_SNIPER_1")
_idChar_RES_SNIPER_2=GetCharacterID("Char_RES_SNIPER_2")
_idChar_RES_SNIPER_3=GetCharacterID("Char_RES_SNIPER_3")
_idChar_RES_SNIPER_4=GetCharacterID("Char_RES_SNIPER_4")
_idChar_RES_SNIPER_5=GetCharacterID("Char_RES_SNIPER_5")
_idChar_RES_SNIPER_6=GetCharacterID("Char_RES_SNIPER_6")
_idChar_RES_SNIPER_7=GetCharacterID("Char_RES_SNIPER_7")
---------------------------------------------------------------------------
_idChar_RES_RDC_01_11=GetCharacterID("Char_RES_RDC_01_11")
_idChar_RES_RDC_01_13=GetCharacterID("Char_RES_RDC_01_13")
_idChar_RES_RDC_01_14=GetCharacterID("Char_RES_RDC_01_14")
_idChar_RES_RDC_01_15=GetCharacterID("Char_RES_RDC_01_15")
_idChar_RES_RDC_01_18=GetCharacterID("Char_RES_RDC_01_18")
_idChar_RES_RDC_01_20=GetCharacterID("Char_RES_RDC_01_20")
_idGroup_renforts_cloitre=GetGroupID("Group_renforts_cloitre")
_idGroup_renforts_cloitre1=GetGroupID("Group_renforts_cloitre1")
-----------------------------------------------------------------------------------------
_idChar_RES_1FLOOR_1=GetCharacterID("Char_RES_1FLOOR_1")
_idChar_RES_1FLOOR_2=GetCharacterID("Char_RES_1FLOOR_2")
_idChar_RES_1FLOOR_3=GetCharacterID("Char_RES_1FLOOR_3")
_idChar_RES_1FLOOR_5=GetCharacterID("Char_RES_1FLOOR_5")
_idChar_RES_1FLOOR_7=GetCharacterID("Char_RES_1FLOOR_7")
_idChar_RES_1FLOOR_8=GetCharacterID("Char_RES_1FLOOR_8")
_idChar_RES_1FLOOR_11=GetCharacterID("Char_RES_1FLOOR_11")
_idChar_RES_1FLOOR_12=GetCharacterID("Char_RES_1FLOOR_12")
_idChar_RES_1FLOOR_16=GetCharacterID("Char_RES_1FLOOR_16")
_idChar_RES_1FLOOR_17=GetCharacterID("Char_RES_1FLOOR_17")
_idChar_RES_1FLOOR_18=GetCharacterID("Char_RES_1FLOOR_18")
_idChar_RES_1FLOOR_19=GetCharacterID("Char_RES_1FLOOR_19")
_idChar_RES_1FLOOR_20=GetCharacterID("Char_RES_1FLOOR_20")
_idChar_RES_1FLOOR_21=GetCharacterID("Char_RES_1FLOOR_21")
_idChar_RES_1FLOOR_22=GetCharacterID("Char_RES_1FLOOR_22")
_idChar_RES_1FLOOR_25=GetCharacterID("Char_RES_1FLOOR_25")
_idChar_RES_1FLOOR_27=GetCharacterID("Char_RES_1FLOOR_27")
_idChar_RES_1FLOOR_28=GetCharacterID("Char_RES_1FLOOR_28")
_idChar_RES_1FLOOR_29=GetCharacterID("Char_RES_1FLOOR_29")
_idChar_RES_1FLOOR_30=GetCharacterID("Char_RES_1FLOOR_30")
-------------------------------------
_idGroup_terrasse=GetGroupID("Group_terrasse")
_idGroup_terrasse1=GetGroupID("Group_terrasse1")
_idGroup_terrasse_2=GetGroupID("Group_terrasse_2")
-----------------------------------------------------------------------------------------
_idChar_RES_2FLOOR_1=GetCharacterID("Char_RES_2FLOOR_1")
_idChar_RES_2FLOOR_7=GetCharacterID("Char_RES_2FLOOR_7")
_idChar_RES_2FLOOR_8=GetCharacterID("Char_RES_2FLOOR_8")
----------------
_idGroup_2FLOOR_01=GetGroupID("Group_2FLOOR_01")
-----------------------------------------------------------------------------------------
_idChar_RES_HELPORT_1=GetCharacterID("Char_RES_HELPORT_1")
_idChar_RES_HELPORT_2=GetCharacterID("Char_RES_HELPORT_2")
_idChar_RES_HELPORT_4=GetCharacterID("Char_RES_HELPORT_4")
_idChar_RES_HELPORT_6=GetCharacterID("Char_RES_HELPORT_6")
_idChar_RES_HELPORT_10=GetCharacterID("Char_RES_HELPORT_10")
_idChar_RES_HELPORT_11=GetCharacterID("Char_RES_HELPORT_11")
_idChar_RES_HELPORT_13=GetCharacterID("Char_RES_HELPORT_13")
_idChar_RES_HELPORT_15=GetCharacterID("Char_RES_HELPORT_15")
_idChar_RES_HELPORT_16=GetCharacterID("Char_RES_HELPORT_16")
_idChar_RES_HELPORT_18=GetCharacterID("Char_RES_HELPORT_18")
_idChar_RES_HELPORT_22=GetCharacterID("Char_RES_HELPORT_22")
_idChar_RES_HELPORT_24=GetCharacterID("Char_RES_HELPORT_24")
_idChar_RES_HELPORT_25=GetCharacterID("Char_RES_HELPORT_25")
_idChar_RES_HELPORT_27=GetCharacterID("Char_RES_HELPORT_27")
_idChar_RES_HELPORT_28=GetCharacterID("Char_RES_HELPORT_28")
_idChar_RES_HELPORT_30=GetCharacterID("Char_RES_HELPORT_30")
_idChar_RES_HELPORT_34=GetCharacterID("Char_RES_HELPORT_34")
_idChar_RES_HELPORT_35=GetCharacterID("Char_RES_HELPORT_35")
_idChar_RES_HELPORT_38=GetCharacterID("Char_RES_HELPORT_38")
_idChar_RES_HELPORT_40=GetCharacterID("Char_RES_HELPORT_40")
_idChar_RES_HELPORT_42=GetCharacterID("Char_RES_HELPORT_42")
_idChar_RES_HELPORT_43=GetCharacterID("Char_RES_HELPORT_43")
_idChar_RES_HELPORT_44=GetCharacterID("Char_RES_HELPORT_44")
_idChar_RES_HELPORT_45=GetCharacterID("Char_RES_HELPORT_45")
_idChar_RES_HELPORT_46=GetCharacterID("Char_RES_HELPORT_46")
_idChar_RES_HELPORT_47=GetCharacterID("Char_RES_HELPORT_47")
_idChar_RES_HELPORT_48=GetCharacterID("Char_RES_HELPORT_48")
_idChar_RES_HELPORT_49=GetCharacterID("Char_RES_HELPORT_49")
_idChar_RES_HELPORT_50=GetCharacterID("Char_RES_HELPORT_50")
_idChar_RES_HELPORT_51=GetCharacterID("Char_RES_HELPORT_51")
_idChar_RES_HELPORT_52=GetCharacterID("Char_RES_HELPORT_52")
_idChar_RES_HELPORT_53=GetCharacterID("Char_RES_HELPORT_53")
_idChar_RES_HELPORT_54=GetCharacterID("Char_RES_HELPORT_54")
_idChar_RES_HELPORT_55=GetCharacterID("Char_RES_HELPORT_55")
_idChar_RES_HELPORT_58=GetCharacterID("Char_RES_HELPORT_58")
------------------------------------------------------------------------
_idChar_RES_COURT_1=GetCharacterID("Char_RES_COURT_1")
_idChar_RES_COURT_2=GetCharacterID("Char_RES_COURT_2")
_idChar_RES_COURT_3=GetCharacterID("Char_RES_COURT_3")
_idChar_RES_COURT_4=GetCharacterID("Char_RES_COURT_4")
_idChar_RES_COURT_5=GetCharacterID("Char_RES_COURT_5")
_idChar_RES_COURT_6=GetCharacterID("Char_RES_COURT_6")
_idChar_RES_COURT_7=GetCharacterID("Char_RES_COURT_7")
_idChar_RES_COURT_8=GetCharacterID("Char_RES_COURT_8")
_idChar_RES_COURT_9=GetCharacterID("Char_RES_COURT_9")
_idChar_RES_COURT_10=GetCharacterID("Char_RES_COURT_10")
_idChar_RES_COURT_11=GetCharacterID("Char_RES_COURT_11")
_idChar_RES_COURT_12=GetCharacterID("Char_RES_COURT_12")
_idChar_RES_COURT_15=GetCharacterID("Char_RES_COURT_15")
_idChar_RES_COURT_17=GetCharacterID("Char_RES_COURT_17")
-----------------------------------
_idGroup_HELIPORT_Maison_2_02=GetGroupID("Group_HELIPORT_Maison_2_02")
_idGroup_HELIPORT_Maison_2_03=GetGroupID("Group_HELIPORT_Maison_2_03")
_idGroup_HELIPORT_Maison_2_04=GetGroupID("Group_HELIPORT_Maison_2_04")
----------------------------------------------------------------------------------------
_bEmbush=0
_bMaVie=0
_bClearCloitre=0
_bOnEnter_Sector_Event_HELI_1=0
_bObj_3=0
_bHack=0
_bObj_5=0
_bOnEnter_Sector_Event_change_terrasse=0
_bOnEnter_Sector_Event_suite_allies=0
_bOnEnter_Sector_Event_shift=0
_bOnEnter_Sector_Event_limit_zone_allie_1=0
_bOnEnter_Sector_Event_cloitre_A=0
_bOnEnter_Sector_Event_cloitre_B=0
_bOnEnter_Sector_Event_cloitre_B1=0
_bOnEnter_Sector_Event_cloitre_C=0
_bOnEnter_Sector_Event_cloitre_C1=0
_bOnEnter_Sector_Event_cloitre_D=0
_bOnEnter_Sector_Event_cloitre_A1=0
_bOnEnter_Sector_Event_cloitre_RDC_room_top=0
_bOnEnter_Sector_Event_cloitre_bas=0
_bOnEnter_Sector_Event_cloitre_transition=0
_bOnExit_Sector_Event_cloitre_terrasse_1=0
_bOnExit_Sector_Event_cloitre_rdc_right=0
_bOnExit_Sector_Event_cloitre_transit_2=0
_bOnExit_Sector_Event_shift=0
_bRenforts_terrasse=0
_bRenforts_terrasse_1=0
_bRenforts_terrasse_2=0
_bDeaD_Inge=0
_bNothing=0
_bOnStay_Sector_Event_PlayerBas=0
_bOnStay_Sector_Event_PlayerBas1=0
_bDiversion=0
_bTerrasse=0
_bOnEnter_Sector_Event_1st_Floor=0
_bOnEnter_Sector_Event_middle_terrasse=0
_bOnExit_Sector_Event_Coin_Droit_terrasse=0
------------------------------
_bOnEnter_Sector_Event_heliport_intro=0
_bOnEnter_Sector_Event_heliport_start=0
_bOnExit_Sector_Event_heliport_start=0
_bOnEnter_Sector_Event_heliport_start1=0
_bRenforts_Start2=0
_bRenforts_start=0
_bRenforts_maison_1=0
_bOnOnExit_Sector_Event_stair=0
_bOnEnter_Sector_Event_maison_2=0
_bOnEnter_Sector_Event_HELI_2=0
_bOnEnter_Sector_Event_HELI_3=0
_bRenforts_Heli=0
_bOnEnter_Sector_Event_porte_maison_3=0
_bRenforts_maison_3=0
_bOnEnter_Sector_Event_embuscade=0
_bRenforts_bas=0
_bOnEnter_Sector_Event_Heliport_porte=0
--_bOnEnter_Sector_Event_allie_go_hel=0
_bOnExit_Sector_Event_Retour_part_1=0
_bOnExit_Sector_Event_HELI_3=0
-----------------------------------------------------------------------------------------
_bOnExit_Sector_Event_HELI_1=0
_bOnEnter_Sector_Event_Court_1=0
_bOnEnter_Sector_Event_Court_2=0
_bOnEnter_Sector_Event_Court_3=0
_bOnEnter_Sector_Event_COURT_place=0
_bRenforts_Court_1=0
_bOnEnter_Sector_Event_endoflevel=0
_bOnExit_Sector_Event_endoflevel=0
--_bCam_debut=0
_bSound_Hack=0
end
-----------------------------------------
function Precache_Dials()

PrecacheSentence("DIA_SPE_NIV_N_INGENIEUR_A_08")
PrecacheSentence("DIA_SPE_NIV_N_INGENIEUR_A_01")
PrecacheSentence("DIA_SPE_NIV_N_INGENIEUR_A_03")
PrecacheSentence("DIA_SPE_NIV_N_GENERAL_RADIO_07")
PrecacheSentence("DIA_SPE_NIV_N_GENERAL_RADIO_16")
PrecacheSentence("DIA_SPE_NIV_N_GENERAL_RADIO_04")
PrecacheSentence("DIA_SPE_NIV_N_INGENIEUR_A_09")
PrecacheSentence("DIA_SPE_NIV_N_RESIS_B_01")
PrecacheSentence("DIA_SPE_NIV_N_INGENIEUR_B_10")

end