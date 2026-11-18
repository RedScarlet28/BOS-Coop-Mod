------------------------------------------------------------
------------------------------------------------------------

-- ::: Arrivée des Snipers :::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Speaker --]]

function DIA_SPE_NIV_M_COMMENT_RADIO_10()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_10
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_10",3)
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_11", 4)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_10", true,100,1,"DIA_SPE_NIV_M_COMMENT_RADIO_11")
end

------------------------------------------------------------

--[[ Speaker --]]

function DIA_SPE_NIV_M_COMMENT_RADIO_64()
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_11_B",3)
	-- CreationTimer(true, true, false, "Speaker3", 3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_11_B", true,100,1,"Speaker3")
end

function Speaker3()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_12
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_12",3)
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_65", 4)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_12", true,100,1,"DIA_SPE_NIV_M_COMMENT_RADIO_65")
end

function DIA_SPE_NIV_M_COMMENT_RADIO_65()
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_12_B",3)
	-- CreationTimer(true, true, false, "GUI3", 3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_12_B", true,100,1,"")
end

------------------------------------------------------------

--[[ Objectif --]]

function GUI3()
--	Dialogue(true,3,"::: Objectif ::: Débusquer et éliminer les 8 snipers en position autour de l'arène")
--	DisplayObjective ( "HUD_OBJ_ADDED",GetObjectiveID("Obj_Snipers"), 2, 5 )

		-- :::: OBJECTIF ::::
		NewSubObjective("Obj_A4","Obj_A5")
		SetVarValue(GetObjectiveID("Obj_W3"),"Active", true)
end


------------------------------------------------------------

--[[ Spawn des 8 snipers --]]

function DIA_SPE_NIV_M_COMMENT_RADIO_11()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_11
--	Dialogue(true,3,"Les adversaires qui se présentent maintenant devant vous, cher public, \nsont les tireurs les plus redoutables d'Europe. \nJe vous demande d'applaudir bien fort les snipers de Innsbrück !\n")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_11",3)
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_64", 4)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_11", true,100,1,"DIA_SPE_NIV_M_COMMENT_RADIO_64")

	FreezeAll(GetGroupID("Grp_Syndic_Snipers_01"), false)
	TeletransportationAsc1(4,"Repere_Asc_1_","Char_Syndic_Snipers_01_")

	FreezeAll(GetGroupID("Grp_Syndic_Snipers_02"), false)
	TeletransportationAsc1(4,"Repere_Asc_2_","Char_Syndic_Snipers_02_")



	_bVieSniper_01_1 = true
	_bVieSniper_01_2 = true
	_bVieSniper_01_3 = true
	_bVieSniper_01_4 = true

	_bVieSniper_02_1 = true
	_bVieSniper_02_2 = true
	_bVieSniper_02_3 = true
	_bVieSniper_02_4 = true

		-- Désactive les Cmd du Player
		DisableCharCmd()
		-- Désactive les Cmd de Mister Five
		DisableCmdMisterFive()

		TP_Player_Cine()

	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_01_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_01_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_01_3"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_01_4"), false)

	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_02_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_02_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_02_3"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_02_4"), false)

	-- Ouverture de la porte
	CloseDoor(GetDoorID("Door_Asc1_1"))
--	CloseDoor(GetDoorID("Door_Asc1_2"))
	LockDoor(GetDoorID("Door_Asc1_1"))
--	LockDoor(GetDoorID("Door_Asc1_2"))

	-- :::: BLAM :::: --
	CreationTimer(true, true, false, "AIOL_Sniper_01_1", 1)	

		-- Détruit les SRB susceptibles de géner
		ReleaseSingleRigidBodyInBox("SE_Rlz_SRB_Asc1")

	-- Séquence Caméra
	CamSnipers_01()
end

------------------------------------------------------------

--[[ Attribution des AIOL toutes les 0.3 secondes --]]

function AIOL_Sniper_01_1()
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_01_1"), true)
	CreationTimer(true, true, false, "AIOL_Sniper_01_2", 1)		
end
function AIOL_Sniper_01_2()
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_01_2"), true)
	CreationTimer(true, true, false, "AIOL_Sniper_01_3", 1.1)		
end
function AIOL_Sniper_01_3()
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_01_3"), true)
	CreationTimer(true, true, false, "AIOL_Sniper_01_4", 1.5)		
end
function AIOL_Sniper_01_4()
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_01_4"), true)
end

------------------------------------------------------------

--[[ Active les Snipers 02 --]]

function ActivSniper_02()

	AIOL_Sniper_02_1()
	UnLockDoor(GetDoorID("Door_Asc2_1"))
	OpenDoor(GetDoorID("Door_Asc2_1"))

		-- Détruit les SRB susceptibles de géner
		ReleaseSingleRigidBodyInBox("SE_Rlz_SRB_Asc2")

	SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_1"),"CharacterAI",GetCharacter_AIID("Char_AI_Syndic_Snipers_01"))
	SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_2"),"CharacterAI",GetCharacter_AIID("Char_AI_Syndic_Snipers_01"))
	SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_3"),"CharacterAI",GetCharacter_AIID("Char_AI_Syndic_Snipers_01"))
	SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_4"),"CharacterAI",GetCharacter_AIID("Char_AI_Syndic_Snipers_01"))

	SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_1"),"CharacterOrderList",GetAI_Order_ListID("AIO_List_Sniper_01_1"))
	SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_2"),"CharacterOrderList",GetAI_Order_ListID("AIO_List_Sniper_01_2"))
	SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_3"),"CharacterOrderList",GetAI_Order_ListID("AIO_List_Sniper_01_3"))
	SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_4"),"CharacterOrderList",GetAI_Order_ListID("AIO_List_Sniper_01_4"))

	CamSnipers_02()
end

------------------------------------------------------------

--[[ Attribution des AIOL toutes les 0.3 secondes --]]

function AIOL_Sniper_02_1()
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_02_1"), true)
	CreationTimer(true, true, false, "AIOL_Sniper_02_2", 2)		
end
function AIOL_Sniper_02_2()
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_02_3"), true)
	CreationTimer(true, true, false, "AIOL_Sniper_02_3",2.5)		
end
function AIOL_Sniper_02_3()
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_02_2"), true)
	CreationTimer(true, true, false, "AIOL_Sniper_02_4", 2)		
end
function AIOL_Sniper_02_4()
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Snipers_02_4"), true)
end

------------------------------------------------------------

--[[ Change l'OrderList des groupes Soldats_02 et Soldats_03 après la cinématique (No Formation) --]]

function ActivePlayerMister2()
	-- Rétablit les Cmd du Player
	EnableCharCmd()
	StartCountDown(5,"EnableFireSniper_01_02",false)
	EnableCharacterFire(_idPlayer,false)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],false)
	end

	-- Rétablit les Cmd de Mister Five s'il est en vie
	EnableCmdMisterFive()

	ShowCinematicBlackStripes(false)

	SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_1"),"CharacterAI",GetCharacter_AIID("Char_AI_Syndic_Snipers_01"))
	SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_2"),"CharacterAI",GetCharacter_AIID("Char_AI_Syndic_Snipers_01"))
	SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_3"),"CharacterAI",GetCharacter_AIID("Char_AI_Syndic_Snipers_01"))
	SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_4"),"CharacterAI",GetCharacter_AIID("Char_AI_Syndic_Snipers_01"))

	SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_1"),"CharacterOrderList",GetAI_Order_ListID("AIO_List_Sniper_02_1"))
	SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_2"),"CharacterOrderList",GetAI_Order_ListID("AIO_List_Sniper_02_2"))
	SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_3"),"CharacterOrderList",GetAI_Order_ListID("AIO_List_Sniper_02_3"))
	SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_4"),"CharacterOrderList",GetAI_Order_ListID("AIO_List_Sniper_02_4"))
end

function EnableFireSniper_01_02()
--	StartCountDown(5,"EnableFireSoldats_01",true)
	EnableCharacterFire(_idPlayer,true)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],true)
	end
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_01_1"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_01_2"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_01_3"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_01_4"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_02_1"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_02_2"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_02_3"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Snipers_02_4"), true)
	GUI3()
end

------------------------------------------------------------

--[[ Teste le nb de persos qui restent ds les grpes Syndic_Snîpers_01 et 02 et lance le defreeze des Kenyans

function TestGrp_Syndic_Snipers_01_02()
	local nSnipers01 = AliveMembersCount(GetGroupID("Grp_Syndic_Snipers_01"))
	local nSnipers02 = AliveMembersCount(GetGroupID("Grp_Syndic_Snipers_02"))
	local nTotalSnipers = nSnipers01 + nSnipers02
	if (nTotalSnipers <= 2) and (_bDefreezeKenyans == false) then
		DefreezeKenyans01_02()
		_bDefreezeKenyans = true
	end
end
 --]]

------------------------------------------------------------

--[[ Teste si les membres du groupe Syndic_Soldats_01 sont encore vivant et si non defreeze le grpe Syndic_Soldats_02 --]]

function TestGrp_Syndic_Snipers_01_02()
	_bVieSyndic_Snipers_01 = IsAlive(GetGroupID("Grp_Syndic_Snipers_01"))
	_bVieSyndic_Snipers_02 = IsAlive(GetGroupID("Grp_Syndic_Snipers_02"))
	if ((_bVieSyndic_Snipers_01 == false) and (_bVieSyndic_Snipers_02 == false) and (_bDesactiveVieSyndic_Snipers_01 == false) and (_bDesactiveVieSyndic_Snipers_02 == false)) then
		CreationTimer(true, true, false, "DefreezeKenyans02",4)
		_bDesactiveVieSyndic_Snipers_01 = true
		_bDesactiveVieSyndic_Snipers_02 = true
	end
end

------------------------------------------------------------

--[[ Phrases speaker Snipers --]]

function NbAlive_Syndic_Snipers_01_02()
	_nNbAliveSyndic_Snipers_01 = AliveMembersCount(GetGroupID("Grp_Syndic_Snipers_01"))
	_nNbAliveSyndic_Snipers_02 = AliveMembersCount(GetGroupID("Grp_Syndic_Snipers_02"))
	_nNbAliveSyndic_Snipers_01_02 = _nNbAliveSyndic_Snipers_01 + _nNbAliveSyndic_Snipers_02


	if ((_nNbAliveSyndic_Snipers_01_02 == 7) and (_bCtrNbSnip7 == false)) then
		-- :::: OBJECTIF ::::
	--	NewSubObjective("Obj_A6","Obj_A7")
		SilentNewSubObjective ("Obj_A5","Obj_A6")
	--	SetVarValue(GetObjectiveID("Obj_A5"),"Active", false)
	-- SetVarValue(GetObjectiveID("Obj_A6"),"Active", true)
		_bCtrNbSnip7 = true

	elseif ((_nNbAliveSyndic_Snipers_01_02 == 6) and (_bCtrNbSnip6 == false)) then
		-- DIA_SPE_NIV_M_COMMENT_RADIO_55
		-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_55",3)
		SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_55", true,100,0,"")
		_bCtrNbSnip6 = true

		-- :::: OBJECTIF ::::
	--	NewSubObjective("Obj_A7","Obj_A8")
		SilentNewSubObjective ("Obj_A6","Obj_A7")

	elseif ((_nNbAliveSyndic_Snipers_01_02 == 5) and (_bCtrNbSnip5 == false)) then
		_bCtrNbSnip5 = true

		-- :::: OBJECTIF ::::
	--	NewSubObjective("Obj_A8","Obj_A9")
		SilentNewSubObjective ("Obj_A7","Obj_A8")


	elseif ((_nNbAliveSyndic_Snipers_01_02 == 4) and (_bCtrNbSnip4 == false)) then
		-- DIA_SPE_NIV_M_COMMENT_RADIO_56
		-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_56",3)
		SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_56", true,100,0,"")
		_bCtrNbSnip4 = true

		-- :::: OBJECTIF ::::
	--	NewSubObjective("Obj_A9","Obj_A10")
		SilentNewSubObjective ("Obj_A8","Obj_A9")

	elseif ((_nNbAliveSyndic_Snipers_01_02 == 3) and (_bCtrNbSnip3 == false)) then
		_bCtrNbSnip3 = true

		-- :::: OBJECTIF ::::
	--	NewSubObjective("Obj_A10","Obj_A11")
		SilentNewSubObjective ("Obj_A9","Obj_A10")

	elseif ((_nNbAliveSyndic_Snipers_01_02 == 2) and (_bCtrNbSnip2 == false)) then
		_bCtrNbSnip2 = true

		-- :::: OBJECTIF ::::
		SilentNewSubObjective ("Obj_A10","Obj_A11")

	elseif ((_nNbAliveSyndic_Snipers_01_02 == 1) and (_bCtrNbSnip1 == false)) then
		-- DIA_SPE_NIV_M_COMMENT_RADIO_XX
		-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_57",3)
		SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_57", true,100,0,"")
		_bCtrNbSnip1 = true

		-- :::: OBJECTIF ::::
	--	NewSubObjective("Obj_A12","Obj_A13")
		SilentNewSubObjective ("Obj_A11","Obj_A12")
	end
end

------------------------------------------------------------

--[[ Phrases speaker Snipers --]]

		-- DIA_SPE_NIV_M_COMMENT_RADIO_XX
	--	DisplaySubtitle("Il reste 6 adversaires dans l'arène !",3)
		-- DIA_SPE_NIV_M_COMMENT_RADIO_XX
	--	DisplaySubtitle("Il en reste encore 4 ! Aller Nolan !",3)
		-- DIA_SPE_NIV_M_COMMENT_RADIO_XX
	--	DisplaySubtitle("Plus qu'un ! Il n'y en a plus qu'un !",3)

------------------------------------------------------------

--[[ Defreeze les 2 1ers grpes de Kenyans --]]

function DefreezeKenyans01()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_13
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_13",3)
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_66", 3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_13", true,100,1,"DIA_SPE_NIV_M_COMMENT_RADIO_66")

	FreezeAll(GetGroupID("Grp_Syndic_Kenyans_01"), false)
	TeletransportationAsc1(3,"Repere_Asc_1_","Char_Syndic_Kenyans_01_")
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Kenyans_01_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Kenyans_01_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Kenyans_01_3"), false)
	CreationTimer(true, true, false, "AIOL_Kenyans_01_1a", 1)
end

function DIA_SPE_NIV_M_COMMENT_RADIO_66()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_66
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_13_B",3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_13_B", true,100,0,"")
end

------------------------------------------------------------

--[[ Defreeze les 2 1ers grpes de Kenyans --]]

function DefreezeKenyans02()
	FreezeAll(GetGroupID("Grp_Syndic_Kenyans_02"), false)
	TeletransportationAsc1(3,"Repere_Asc_2_","Char_Syndic_Kenyans_02_")
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Kenyans_02_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Kenyans_02_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Kenyans_02_3"), false)

	CloseDoor(GetDoorID("Door_Asc2_1"))
--	CloseDoor(GetDoorID("Door_Asc2_2"))
	LockDoor(GetDoorID("Door_Asc2_1"))
--	LockDoor(GetDoorID("Door_Asc2_2"))

	CloseDoor(GetDoorID("Door_Asc1_1"))
--	CloseDoor(GetDoorID("Door_Asc1_2"))
	LockDoor(GetDoorID("Door_Asc1_1"))
--	LockDoor(GetDoorID("Door_Asc1_2"))

		-- Détruit les SRB susceptibles de géner
		ReleaseSingleRigidBodyInBox("SE_Rlz_SRB_Asc2")

		-- Détruit les SRB susceptibles de géner
		ReleaseSingleRigidBodyInBox("SE_Rlz_SRB_Asc1")

	CamAsc2_2bis()
	CreationTimer(true, true, false, "AIOL_Kenyans_02_1a", 2)
	CreationTimer(true, true, false, "DefreezeKenyans01",3)
	DisableCharCmd()
	DisableCmdMisterFive()
	TP_Player_Cine()
	ShowCinematicBlackStripes(true)
end

------------------------------------------------------------

--[[ Attribution des AIOL toutes les 0.3 secondes --]]

function AIOL_Kenyans_01_1a()
	SetVarValue(GetCharacterID("Char_Syndic_Kenyans_01_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_03_1a"))
	CreationTimer(true, true, false, "AIOL_Kenyans_01_1b", 0.8)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Kenyans_01_1"), true)	
end
function AIOL_Kenyans_01_1b()
	SetVarValue(GetCharacterID("Char_Syndic_Kenyans_01_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_03_1b"))
	CreationTimer(true, true, false, "AIOL_Kenyans_01_1c", 0.8)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Kenyans_01_2"), true)	
end
function AIOL_Kenyans_01_1c()
	SetVarValue(GetCharacterID("Char_Syndic_Kenyans_01_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_03_1c"))
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Kenyans_01_3"), true)		
end

------------------------------------------------------------

--[[ Attribution des AIOL toutes les 0.3 secondes --]]

function AIOL_Kenyans_02_1a()
	SetVarValue(GetCharacterID("Char_Syndic_Kenyans_02_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_02_1a"))
	CreationTimer(true, true, false, "AIOL_Kenyans_02_1b", 0.8)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Kenyans_02_1"), true)	
end
function AIOL_Kenyans_02_1b()
	SetVarValue(GetCharacterID("Char_Syndic_Kenyans_02_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_02_1b"))
	CreationTimer(true, true, false, "AIOL_Kenyans_02_1c", 0.8)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Kenyans_02_2"), true)	
end
function AIOL_Kenyans_02_1c()
	SetVarValue(GetCharacterID("Char_Syndic_Kenyans_02_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_02_1c"))
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Kenyans_02_3"), true)		
end

------------------------------------------------------------

--[[ Enable les Cmd du Player et de Mister Five --]]

function EnablePlayerMister()
	EnableCharCmd()
	StartCountDown(5,"EnableFireKenyans",false)
	EnableCharacterFire(_idPlayer,false)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],false)
	end

	EnableCmdMisterFive()

	ShowCinematicBlackStripes(false)

	SetVarValue(GetCharacterID("Char_Syndic_Kenyans_02_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Kenyans_01_3a"))
	SetVarValue(GetCharacterID("Char_Syndic_Kenyans_02_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Kenyans_01_3b"))
	SetVarValue(GetCharacterID("Char_Syndic_Kenyans_02_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Kenyans_01_3a"))

	SetVarValue(GetCharacterID("Char_Syndic_Kenyans_01_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Kenyans_01_3b"))
	SetVarValue(GetCharacterID("Char_Syndic_Kenyans_01_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Kenyans_01_3a"))
	SetVarValue(GetCharacterID("Char_Syndic_Kenyans_01_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Kenyans_01_3b"))
		-- :::: OBJECTIF ::::
		NewSubObjective ("Obj_A12","Obj_A1_ELIMINATE")
		SetVarValue(GetObjectiveID("Obj_W3"),"Active", false)
end

function EnableFireKenyans()
--	StartCountDown(5,"EnableFireSoldats_01",true)
	EnableCharacterFire(_idPlayer,true)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],true)
	end
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_01_1"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_01_2"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_01_3"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_02_1"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_02_2"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_02_3"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_03_1"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_03_2"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Kenyans_03_3"), true)
end

------------------------------------------------------------

--[[ Teste la mort des Kenyans --]]

function TestMortKenyans()
	_bTestMortKenyans1 = IsAlive(GetGroupID("Grp_Syndic_Kenyans_01"))
	_bTestMortKenyans2 = IsAlive(GetGroupID("Grp_Syndic_Kenyans_02"))
--	_bTestMortKenyans3 = IsAlive(GetGroupID("Grp_Syndic_Kenyans_03"))
	if ((_bTestMortKenyans1 == false) and (_bTestMortKenyans2 == false) --[[ and (_bTestMortKenyans3 == false) --]] and (_bCtrlMortKenyans == false)) then
		-- DIA_SPE_NIV_M_COMMENT_RADIO_14
		-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_14",2)
		-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_67",2)
		SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_14", true,100,1,"DIA_SPE_NIV_M_COMMENT_RADIO_67")

		_bCtrlMortKenyans = true
	end
end

function DIA_SPE_NIV_M_COMMENT_RADIO_67()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_67
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_14_B",2)
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_68",3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_14_B", true,100,1,"DIA_SPE_NIV_M_COMMENT_RADIO_68")
end

function DIA_SPE_NIV_M_COMMENT_RADIO_68()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_68
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_14_C",2)
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_15",7)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_14_C", true,100,6,"DIA_SPE_NIV_M_COMMENT_RADIO_15")
end
------------------------------------------------------------

--[[ Defreeze les Champions Cubains --]]

function DIA_SPE_NIV_M_COMMENT_RADIO_15()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_15
--	Dialogue(true,4,"Ah les voilà ils arrivent... Ce sont eux ! Ils sont trois ! \nCe sont nos 3 champions cubains préférés. Ils ont été entraînés à l'école de Santa Clara ! \nIls sont en Ligue 1 depuis 7 ans déjà ! Vous pouvez les applaudir !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_15",3)
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_69",3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_15", true,100,1,"DIA_SPE_NIV_M_COMMENT_RADIO_69")

	FreezeAll(GetGroupID("Grp_Syndic_Cubains"), false)
	TeletransportationAsc1(3,"Repere_Asc_1_","Char_Syndic_Cubains_")

	CloseDoor(GetDoorID("Door_Asc1_1"))
--	CloseDoor(GetDoorID("Door_Asc1_2"))
	LockDoor(GetDoorID("Door_Asc1_1"))
--	LockDoor(GetDoorID("Door_Asc1_2"))

		-- Détruit les SRB susceptibles de géner
		ReleaseSingleRigidBodyInBox("SE_Rlz_SRB_Asc1")

	CamCubains1()
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cubains_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cubains_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cubains_3"), false)
	DisableCharCmd()
	DisableCmdMisterFive()
	TP_Player_Cine()
	CreationTimer(true, true, false, "AIOL_Cubains_1a", 2)
	ShowCinematicBlackStripes(true)
end

function DIA_SPE_NIV_M_COMMENT_RADIO_69()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_69
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_15_B",2)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_15_B", true,100,0,"")
end

------------------------------------------------------------

--[[ Attribution des AIOL toutes les 0.3 secondes --]]

function AIOL_Cubains_1a()
	SetVarValue(GetCharacterID("Char_Syndic_Cubains_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_02_1a"))
	CreationTimer(true, true, false, "AIOL_Cubains_1b", 0.8)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cubains_1"), true)	
end
function AIOL_Cubains_1b()
	SetVarValue(GetCharacterID("Char_Syndic_Cubains_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_02_1b"))
	CreationTimer(true, true, false, "AIOL_Cubains_1c", 0.8)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cubains_2"), true)	
end
function AIOL_Cubains_1c()
	SetVarValue(GetCharacterID("Char_Syndic_Cubains_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_02_1c"))
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cubains_3"), true)		
end

------------------------------------------------------------

--[[ Enable les Cmd du Player et de Mister Five --]]

function EnablePlayerMisterCubains()
	EnableCharCmd()
	StartCountDown(5,"EnableFireCubains",false)
	EnableCharacterFire(_idPlayer,false)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],false)
	end

	EnableCmdMisterFive()
	ShowCinematicBlackStripes(false)
	SetVarValue(GetCharacterID("Char_Syndic_Cubains_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Kenyans_01_3a"))
	SetVarValue(GetCharacterID("Char_Syndic_Cubains_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Kenyans_01_3b"))
	SetVarValue(GetCharacterID("Char_Syndic_Cubains_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Kenyans_01_3a"))
end

function EnableFireCubains()
--	StartCountDown(5,"EnableFireSoldats_01",true)
	EnableCharacterFire(_idPlayer,true)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],true)
	end
	EnableCharacterFire(GetCharacterID("Char_Syndic_Cubains_1"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Cubains_2"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Cubains_3"), true)
end

------------------------------------------------------------

--[[ Teste la mort des Cubains --]]

function TestMortCubains()
	_bTestMortCubains = IsAlive(GetGroupID("Grp_Syndic_Cubains"))
	if (_bTestMortCubains == false) and (_bCtrlMortCubains == false) then
		-- DIA_SPE_NIV_M_COMMENT_RADIO_16
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_70",3)
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_16",3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_16", true,100,0,"DIA_SPE_NIV_M_COMMENT_RADIO_70")
		_bCtrlMortCubains = true
	end
end

function DIA_SPE_NIV_M_COMMENT_RADIO_70()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_70
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_16_B",3)
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_71",3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_16_B", true,100,0,"DIA_SPE_NIV_M_COMMENT_RADIO_71")
end

function DIA_SPE_NIV_M_COMMENT_RADIO_71()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_71
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_16_C",3)
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_17",3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_16_C", true,100,10,"DIA_SPE_NIV_M_COMMENT_RADIO_17")
end
------------------------------------------------------------

--[[ Defreeze le Boucher --]]

function DIA_SPE_NIV_M_COMMENT_RADIO_17()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_17
	Freeze(GetCharacterID("Char_Syndic_Boucher"), false)
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_17",3)
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_72",3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_17", true,100,0,"DIA_SPE_NIV_M_COMMENT_RADIO_72")

		-- Détruit les SRB susceptibles de géner
		ReleaseSingleRigidBodyInBox("SE_Rlz_SRB_Asc3")

	CamBoucher1()
	DisableCharCmd()
	DisableCmdMisterFive()
	TP_Player_Cine2()
	ShowCinematicBlackStripes(true)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Boucher"), false)
	idExplosion = CreateExplosion()
	SetVarValue(idExplosion,"Position",	Vector3D(20.115259,-7.654076,10.725795))
	SetVarValue(idExplosion,"Type","Explosion_Rocket_Bombardement")
--	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Explosion"), "FxState", "Fx Started")	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Explosion"), "FxState", "Fx Started")

	SetVarValue(GetParticleFX_ClientID("ParticleFX_XPL_4"), "FxState", "Fx Started")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_XPL_5"), "FxState", "Fx Started")
	CreationTimer(true, true, false, "ActivFX_FLM_Butcher",0.5)

end

function ActivFX_FLM_Butcher()
	SetVarValue(GetParticleFX_ClientID("ParticleFX_FLM_4"), "FxState", "Fx Started")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_FLM_5"), "FxState", "Fx Started")
	-- Fait disparadin la porte
	ReleaseEntity(GetDoorID("Door_Butcher"))
end

function DIA_SPE_NIV_M_COMMENT_RADIO_72()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_72
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_17_B",3)
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_73",3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_17_B", true,100,0,"DIA_SPE_NIV_M_COMMENT_RADIO_73")


end

function DIA_SPE_NIV_M_COMMENT_RADIO_73()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_73
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_17_C",3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_17_C", true,100,0,"")
end

------------------------------------------------------------

--[[ Enable les Cmd du Player et de Mister Five --]]

function EnablePlayerBoucher()
	EnableCharCmd()
	StartCountDown(5,"EnableFireBoucher",false)
	EnableCharacterFire(_idPlayer,false)
	_bBoucherFight = true
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],false)
	end

	EnableCmdMisterFive()
	SetVarValue(_idBoucher,"CharacterAI",GetCharacter_AIID("Char_AI_Syndic_Boucher_Fight"))	
	SetVarValue(_idBoucher,"CharacterOrderList",GetAI_Order_ListID("AIO_List_Boucher_FA"))	
	_bCtrlCineBoucher = true
	ShowCinematicBlackStripes(false)
end

function EnableFireBoucher()
--	StartCountDown(5,"EnableFireSoldats_01",true)
	EnableCharacterFire(_idPlayer,true)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],true)
	end
	EnableCharacterFire(GetCharacterID("Char_Syndic_Boucher"), true)
		-- :::: OBJECTIF ::::
		NewSubObjective ("Obj_A1_ELIMINATE","Obj_A14")
end

------------------------------------------------------------

--[[ Teste la mort du Boucher --]]

function TestMortBoucher()
	_bTestMortBoucher = IsAlive(GetCharacterID("Char_Syndic_Boucher"))
	if (_bTestMortBoucher == false) and (_bCtrlMortBoucher == false) then
		-- DIA_SPE_NIV_M_COMMENT_RADIO_18
		-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_18",3)
		-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_74",3)
		SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_18", true,100,0,"DIA_SPE_NIV_M_COMMENT_RADIO_74")
		_bCtrlBoucherDialogues = false
		_bCtrlMortBoucher = true
		_bCtrlCineBoucher = false
	end
end

function DIA_SPE_NIV_M_COMMENT_RADIO_74()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_74
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_18_B",3)
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_75",3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_18_B", true,100,0,"DIA_SPE_NIV_M_COMMENT_RADIO_75")
end

function DIA_SPE_NIV_M_COMMENT_RADIO_75()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_75
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_18_C",3)
	-- CreationTimer(true, true, false, "ExplosadinResist",6)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_18_C", true,100,3,"ExplosadinResist")
end

------------------------------------------------------------

--[[ Random sur les phrases liées au boucher qd le perso est en intérieur --]]

function RandomBoucherDialogues()
	if ((_bTestPlayerExterieur == false) and (_bCtrlBoucherDialogues == true)) then
--		ObjectifBoucher()
		local nNumber1 = GetRandom(1,6)
		if (nNumber1 == 1) and (_bChrono == true) then
			-- DIA_SPE_NIV_M_BUTCHER_01
	-- DisplaySubtitle("DIA_SPE_NIV_M_BUTCHER_01",2)
	-- MakeCharacterSpeak(GetCharacterID("Char_Syndic_Boucher"),_idPlayer,"DIA_SPE_NIV_M_BUTCHER_01",true,99,2,5,"Chrono",100)
	SpeakerMessage("DIA_SPE_NIV_M_BUTCHER_01", true,100,5,"Chrono")

			_bChrono = false
			-- CreationTimer(true, true, false, "Chrono", 7)	
		elseif (nNumber1 == 2) and (_bChrono == true) then
			-- DIA_SPE_NIV_M_BUTCHER_02
	-- DisplaySubtitle("DIA_SPE_NIV_M_BUTCHER_02",2)
	-- MakeCharacterSpeak(GetCharacterID("Char_Syndic_Boucher"),_idPlayer,"DIA_SPE_NIV_M_BUTCHER_02",true,99,2,5,"Chrono",100)
	SpeakerMessage("DIA_SPE_NIV_M_BUTCHER_02", true,100,5,"Chrono")
			_bChrono = false
			-- CreationTimer(true, true, false, "Chrono", 7)
		elseif (nNumber1 == 3) and (_bChrono == true) then
			-- DIA_SPE_NIV_M_BUTCHER_03
	-- DisplaySubtitle("DIA_SPE_NIV_M_BUTCHER_03",2)
	-- MakeCharacterSpeak(GetCharacterID("Char_Syndic_Boucher"),_idPlayer,"DIA_SPE_NIV_M_BUTCHER_03",true,99,2,5,"Chrono",100)
	SpeakerMessage("DIA_SPE_NIV_M_BUTCHER_03", true,100,5,"Chrono")
			_bChrono = false
			-- CreationTimer(true, true, false, "Chrono", 7)
		elseif (nNumber1 == 4) and (_bChrono == true) then
			-- DIA_SPE_NIV_M_BUTCHER_04
	-- DisplaySubtitle("DIA_SPE_NIV_M_BUTCHER_04",2)
	-- MakeCharacterSpeak(GetCharacterID("Char_Syndic_Boucher"),_idPlayer,"DIA_SPE_NIV_M_BUTCHER_04",true,99,2,5,"Chrono",100)
	SpeakerMessage("DIA_SPE_NIV_M_BUTCHER_04", true,100,5,"Chrono")
			_bChrono = false
			-- CreationTimer(true, true, false, "Chrono", 7)	
		elseif (nNumber1 == 5) and (_bChrono == true) then
			-- DIA_SPE_NIV_M_BUTCHER_05
	-- DisplaySubtitle("DIA_SPE_NIV_M_BUTCHER_05",2)
	-- MakeCharacterSpeak(GetCharacterID("Char_Syndic_Boucher"),_idPlayer,"DIA_SPE_NIV_M_BUTCHER_05",true,99,2,5,"Chrono",100)
	SpeakerMessage("DIA_SPE_NIV_M_BUTCHER_05", true,100,5,"Chrono")
			_bChrono = false
			-- CreationTimer(true, true, false, "Chrono", 7)
		elseif (nNumber1 == 6) and (_bChrono == true) then
			-- DIA_SPE_NIV_M_BUTCHER_06
	-- DisplaySubtitle("DIA_SPE_NIV_M_BUTCHER_06",2)
	-- MakeCharacterSpeak(GetCharacterID("Char_Syndic_Boucher"),_idPlayer,"DIA_SPE_NIV_M_BUTCHER_06",true,99,2,5,"Chrono",100)
	SpeakerMessage("DIA_SPE_NIV_M_BUTCHER_06", true,100,5,"Chrono")
			_bChrono = false
			-- CreationTimer(true, true, false, "Chrono", 7)
		end
	end
end

------------------------------------------------------------

function ObjectifBoucher()
	--Dialogue(true,3,":::: Objectif :::: Rejoindre le Boucher dans l'arène")
		-- :::: OBJECTIF ::::
		NewSubObjective("Obj_A12","Obj_A14")
		SetVarValue(GetObjectiveID("Obj_W3"),"Active", false)
		SetVarValue(GetObjectiveID("Obj_W4"),"Active", true)
end

------------------------------------------------------------

function Chrono()
	_bChrono = true
end

------------------------------------------------------------

--[[ Vérifie que le boucher est bien dans l'arène ou le force à y retourner --]]

function BoucherExterieur()
	if ((_bTestBoucherExterieur == false) and (_bCtrlCineBoucher == true) and (_bTestPlayerExterieur == true) and (_nPassageBoucherExterieur1 == false)) then
		SetVarValue(_idBoucher,"CharacterOrderList",GetAI_Order_ListID("AIO_List_Boucher"))
	_bCtrlBoucherDialogues = false
	_nPassageBoucherExterieur1 = true
	_nPassageBoucherExterieur2 = false
	_nPassageBoucherExterieur3 = false
	elseif ((_bTestBoucherExterieur == true) and (_bCtrlCineBoucher == true) and (_bTestPlayerExterieur == true) and (_nPassageBoucherExterieur2 == false)) then
		SetVarValue(_idBoucher,"CharacterOrderList",GetAI_Order_ListID("AIO_List_Boucher_FA"))
	_bCtrlBoucherDialogues = false
	_nPassageBoucherExterieur2 = true
	_nPassageBoucherExterieur1 = false
	_nPassageBoucherExterieur3 = false
	elseif ((_bTestBoucherExterieur == true) and (_bCtrlCineBoucher == true) and (_bTestPlayerExterieur == false) and (_nPassageBoucherExterieur3 == false)) then
	SetVarValue(_idBoucher,"CharacterOrderList",GetAI_Order_ListID("AIO_List_Boucher"))
	_bCtrlBoucherDialogues = true
	_nPassageBoucherExterieur3 = true
	_nPassageBoucherExterieur2 = false
	_nPassageBoucherExterieur1 = false
	end
end

