------------------------------------------------------------
------------------------------------------------------------

-- ::: InitLevel :::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function InitLevel()
	CheckInitLevel_good_choice()
	
	InitScriptVariable()
	SoundPrecache()
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: OnMissionBegins :::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnMissionBegins()

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
		MiniMapTrack(_idMerc[0], 4, true)
	end

	
-------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires ::::::: --
-------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	
	SetVarValue(GetCharacterID("Player"),"Team","RESISTANCE")

	PrologueAsc_1()
--	PrologueAsc_5()

end

------------------------------------------------------------
------------------------------------------------------------

-- ::: UpdateLevel :::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function UpdateLevel()

	VolumeSounds()

------------------------------------------------------------
-- ::: Debug Functions :::::::::::::::::::::::::::::::::: --
------------------------------------------------------------

--[[ Teste en permanence s'il y a un dialogue à afficher ou pas --]]

	AppelDialogue(_bDepart,_nTime,_strText)

------------------------------------------------------------
-- ::: Global Functions ::::::::::::::::::::::::::::::::: --
------------------------------------------------------------

--[[ Teste vie Player --]]

	GlobalPlayerIsDead()

DesactiveTrackingMercs()

------------------------------------------------------------
-- ::: Phase 1 :::::::::::::::::::::::::::::::::::::::::: --
------------------------------------------------------------

--[[ Effet ascenseur --]]

	ShakeTaCam()

--[[ Est-ce que le Player est devant un des ascenseurs au moment des cinématique ? --]]

	Where_Is_Player_Cine()
	Where_Is_Player_Cine2()

--[[ Disable la Tortue du Group_Soldats_01 --]]

	NoMoreTurtle()

--[[ Disable les Forbid Zones du Group_Soldats_01 quand il n'en reste qu'un --]]

	DisableFZChar_Syndic_Soldats_01()

--[[ Teste si les membres du groupe Syndic_Soldats_01 st vivants --]]

	IsAliveSyndic_Soldats_01()

--[[ Teste si Mister Five est blessé ou mort --]]

	MisterFive()

--[[ Teste si les membres des groupes Syndic_Soldats_02, 03 et 04 st vivants --]]

	IsAliveSyndic_Soldats_02_03()

--[[ Teste la mort des Bots ennemis --]]

	TestMortBot()

--[[ Teste si plusieurs soldats ennemis st blessés --]]

	HurtTest()

--[[ Teste combien de membres des groupes Syndic_Para_01 et 02 st vivants --]]

	TestGrp_Syndic_Para_01_02()

------------------------------------------------------------
-- ::: Phase 2 :::::::::::::::::::::::::::::::::::::::::: --
------------------------------------------------------------

--[[ Teste la mort des Ours --]]

	TestMortOurs()

--(( Teste le nb de persos qui restent ds les grpes Syndic_Snîpers_01 et 02 et lance le defreeze des Kenyans --]]

	TestGrp_Syndic_Snipers_01_02()

--[[ Teste la mort des Kenyans --]]

	TestMortKenyans()

--[[ Teste la mort des Cubains --]]

	TestMortCubains()

--[[ Phrases speaker Snipers --]]

	NbAlive_Syndic_Snipers_01_02()

--[[ Comportement du Boucher --]]

if (_bBoucherFight == true) then
	Champion_Stop_Turning_Reloading(_idBoucher,"AIO_List_Boucher_FA")
end
------------------------------------------------------------
-- ::: Phase 3 :::::::::::::::::::::::::::::::::::::::::: --
------------------------------------------------------------

--[[ Teste la mort du Boucher --]]

	TestMortBoucher()

--[[ Random sur les phrases liées au boucher qd le perso est en intérieur --]]

	RandomBoucherDialogues()

--[[ Teste si le joueur entre ds l'Arène avent les Parachutistes --]]

	Speaker2test()

--[[ Random sur les phrases du speaker qd le perso est en intérieur --]]

	RandomSpeakerDialogues3()

--[[ Teste si les snipers sont en vie --]]

	TestVieSnipers()

--[[ Vérifie que le boucher est bien dans l'arène ou le force à y retourner --]]

--	BoucherExterieur()

	TrackingCams()


	Add_Money_To_Reward("Char_Syndic_Snipers_01_1",300)
	Add_Money_To_Reward("Char_Syndic_Snipers_01_2",300)
	Add_Money_To_Reward("Char_Syndic_Snipers_01_3",300)
	Add_Money_To_Reward("Char_Syndic_Snipers_01_4",300)
	Add_Money_To_Reward("Char_Syndic_Snipers_02_1",300)
	Add_Money_To_Reward("Char_Syndic_Snipers_02_2",300)
	Add_Money_To_Reward("Char_Syndic_Snipers_02_3",300)
	Add_Money_To_Reward("Char_Syndic_Snipers_02_4",300)
	Add_Money_To_Reward("Char_Syndic_Boucher",500)
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: InitScriptVariable ::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function InitScriptVariable()
	_idPlayer = GetLocalCharacterID(Player)
	_idBoucher = GetCharacterID("Char_Syndic_Boucher")
	_bBoucherFight = false
	_bTestPassageIGOR = false
	_bElevatorSequence = false

	_bTestSortiePlayer = false
	_bTestPlayerExterieur = false
	_bTestSortieBoucher = false
	_bTestBoucherExterieur = true
	_nVieMisterFive = 0
	_bPlayerLocation = 0
	_nTurtleGrp_Syndic_Soldats_01 = false
	_bVieSyndic_Soldats_01 = true
	_bDesactiveVieSyndic_Soldats_01 = false
	_bTestPassagePlayer = false

	_bCtrl_OBJ = true
	_bMisterActive = false

	_bCtrlVieMisterFive = false
	_bCtrlMortMisterFive = false
	_bTestMortBot = false
	_bTestVieGrp = false
	_bVieSyndic_Soldats_02 = true
	_bDesactiveVieSyndic_Soldats_02 = false
	_bVieSyndic_Soldats_03 = true
	_bDesactiveVieSyndic_Soldats_03 = false
	_bVieSyndic_Soldats_04 = true
	_bDesactiveVieSyndic_Soldats_04 = false
	_bVieSyndic_Para_01 = true
	_bVieSyndic_Para_02 = true
	_bActiveHurtTest = true
	_nNbHurtSoldiers = 0
	_bCtrlPassageMisterFive = false
	_nTotalParaAlive = 0
	_nTotalPara1Alive = 0
	_nTotalPara2Alive = 0
	_bSpawnOurs = false
	_bCtrlMortOurs = false
	_bDefreezeKenyans = false
	_bCtrlMortKenyans = false
	_bTestMortKenyans1 = true
	_bTestMortKenyans2 = true
	_bTestMortKenyans3 = true
	_bTestMortCubains = true 
	_bCtrlMortCubains = false
	_bTestMortBoucher = true
	_bCtrlMortBoucher = false
	_bBoucherActif = false
	_bVieSyndic_Soldats_07 = true
	_bVieSyndic_Soldats_08 = true
	_bChrono = true
	_bTestGameOver = true
	_bLeJoueurEntreDansLArene = false
	_bCtrlSpeakDial3 = false
	_bCtrlSpeakDial3_2 = true
	_bOkParas1 = false
	_bOkParas2 = false
	_bVieSniper_01_1 = false
	_bVieSniper_01_2 = false
	_bVieSniper_01_3 = false
	_bVieSniper_01_4 = false
	_bVieSniper_01_5 = false
	_bVieSniper_02_1 = false
	_bVieSniper_02_2 = false
	_bVieSniper_02_3 = false
	_bVieSniper_02_4 = false
	_bVieSniper_02_5 = false
	_bCtrlSniperBoxPlayer = false
	_bDefriseParas = false
	_bDesactiveVieSyndic_Paras_01 = false
	_bDesactiveVieSyndic_Paras_02 = false
	_bDesactiveVieSyndic_Snipers_01 = false
	_bDesactiveVieSyndic_Snipers_02 = false
	_bCtrlCharAI_Sniper_01_1 = false
	_bCtrlCharAI_Sniper_01_2 = false
	_bCtrlCharAI_Sniper_01_3 = false
	_bCtrlCharAI_Sniper_01_4 = false
	_bCtrlCharAI_Sniper_02_1 = false
	_bCtrlCharAI_Sniper_02_2 = false
	_bCtrlCharAI_Sniper_02_3 = false
	_bCtrlCharAI_Sniper_02_4 = false
	_bCtrNbSnip1 = false
	_bCtrNbSnip2 = false
	_bCtrNbSnip3 = false
	_bCtrNbSnip4 = false
	_bCtrNbSnip5 = false
	_bCtrNbSnip6 = false
	_bCtrNbSnip7 = false
	_bCtrNbSnip8 = false
	_bCtrlCineBoucher = false
	_bCtrlBoucherDialogues = false
	_nPassageBoucherExterieur1 = false
	_nPassageBoucherExterieur2 = false
	_nPassageBoucherExterieur3 = false
	EnableCharacterFire(GetCharacterID("Char_Syndic_Boucher"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Cubains_1"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Cubains_2"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Cubains_3"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_01_1"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_01_2"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_01_3"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_02_1"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_02_2"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_02_3"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_03_1"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_03_2"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_03_3"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Ours_1"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Ours_2"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Para_01_1"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Para_01_2"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Para_01_3"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Para_02_1"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Para_02_2"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Para_02_3"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_01_1"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_01_2"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_01_3"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_01_4"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_02_1"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_02_2"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_02_3"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_02_4"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_01_1"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_01_2"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_01_3"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_01_4"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_02_1"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_02_2"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_02_3"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_02_4"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_03_1"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_03_2"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_03_3"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_03_4"), false) --
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_05_1"), false)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_05_2"), false)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_05_3"), false)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_05_4"), false)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_05_5"), false)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_06_1"), false)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_06_2"), false)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_06_3"), false)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_06_4"), false)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_06_5"), false)
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: Précache des dial. ::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function SoundPrecache()

	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_26")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_27")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_28")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_29")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_30")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_31")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_32")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_33")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_34")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_35")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_36")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_37")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_38")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_39")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_40")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_41")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_42")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_25")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_25_B")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_25_C")
	PrecacheSentence("DIA_SPE_NIV_M_SHAIMING_01")
	PrecacheSentence("DIA_SPE_NIV_M_SHAIMING_02")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_10")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_11_B")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_12")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_12_B")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_11")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_55")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_56")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_57")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_13")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_13_B")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_14")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_14_B")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_14_C")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_15")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_15_B")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_16")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_16_B")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_16_C")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_17")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_17_B")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_17_C")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_18")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_18_B")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_18_C")
	PrecacheSentence("DIA_SPE_NIV_M_BUTCHER_01")
	PrecacheSentence("DIA_SPE_NIV_M_BUTCHER_02")
	PrecacheSentence("DIA_SPE_NIV_M_BUTCHER_03")
	PrecacheSentence("DIA_SPE_NIV_M_BUTCHER_04")
	PrecacheSentence("DIA_SPE_NIV_M_BUTCHER_05")
	PrecacheSentence("DIA_SPE_NIV_M_BUTCHER_06")
	PrecacheSentence("DIA_SPE_NIV_M_CONTROL_ROOM_01")
	PrecacheSentence("DIA_SPE_NIV_M_CONTROL_ROOM_02")
	PrecacheSentence("DIA_SPE_NIV_M_CONTROL_ROOM_03")
	PrecacheSentence("DIA_SPE_NIV_M_CONTROL_ROOM_04")
	PrecacheSentence("DIA_SPE_NIV_M_CONTROL_ROOM_05")
	PrecacheSentence("DIA_SPE_NIV_M_CONTROL_ROOM_06")
	PrecacheSentence("DIA_SPE_NIV_M_CONTROL_ROOM_07")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_43")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_44")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_45")
	PrecacheSentence("DIA_SPE_NIV_M_IGOR_BORYENKA_01")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_47")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_48")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_49")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_50")
	PrecacheSentence("DIA_SPE_NIV_M_IGOR_BORYENKA_02")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_51")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_52")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_53")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_54")
	PrecacheSentence("DIA_SPE_NIV_M_IGOR_BORYENKA_03")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_04")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_03")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_05")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_63")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_06")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_07")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_08")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_09")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_61")
	PrecacheSentence("DIA_SPE_NIV_M_COMMENT_RADIO_62")

end