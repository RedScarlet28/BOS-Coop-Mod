------------------------------------------------------------
------------------------------------------------------------

-- ::: Prologue ::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Ctrl Room Speak --]]

function PrologueAsc_1()
	-- Désactive les Cmd du Player
--	DisableCharCmd()
	-- Désactive les Cmd de Mister Five
--	DisableCmdMisterFive()
	EnableCharacterFire(_idPlayer,false)
	-- AMBIANCE SOUND : 
	-- Foule : Cris et applaudissements "moyens"
	CreationTimer(true, true, false, "Rallonge",2)

end

function ShakeTaCam()
    -- encore dans l'ascenceur
    if (_bElevatorSequence == true) then
        CameraShake(600.0,0.5,0.5,0.5) -- brrrr
    end
end

------------------------------------------------------------

function Rallonge()
	-- DIA_SPE_NIV_M_CONTROL_ROOM_01 :
--	DisplaySubtitle("DIA_SPE_NIV_M_CONTROL_ROOM_01",3)
	SpeakerMessage("DIA_SPE_NIV_M_CONTROL_ROOM_01", false, 100, 0,"DIA_SPE_NIV_M_CONTROL_ROOM_02")
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_CONTROL_ROOM_02",3)


end

------------------------------------------------------------

--[[ Chrono Ctrl Room --]]

function DIA_SPE_NIV_M_CONTROL_ROOM_02()
	-- DIA_SPE_NIV_M_CONTROL_ROOM_02
--	DisplaySubtitle("DIA_SPE_NIV_M_CONTROL_ROOM_02",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_CONTROL_ROOM_03",1)
	SpeakerMessage("DIA_SPE_NIV_M_CONTROL_ROOM_02", false, 100, 0,"DIA_SPE_NIV_M_CONTROL_ROOM_03")
end

function DIA_SPE_NIV_M_CONTROL_ROOM_03()
	-- DIA_SPE_NIV_M_CONTROL_ROOM_03
--	DisplaySubtitle("DIA_SPE_NIV_M_CONTROL_ROOM_03",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_CONTROL_ROOM_04",1)
	SpeakerMessage("DIA_SPE_NIV_M_CONTROL_ROOM_03", false, 100, 0,"DIA_SPE_NIV_M_CONTROL_ROOM_04")
end

function DIA_SPE_NIV_M_CONTROL_ROOM_04()
	-- DIA_SPE_NIV_M_CONTROL_ROOM_04
--	DisplaySubtitle("DIA_SPE_NIV_M_CONTROL_ROOM_04",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_CONTROL_ROOM_05", 1)
	SpeakerMessage("DIA_SPE_NIV_M_CONTROL_ROOM_04", false, 100, 0,"DIA_SPE_NIV_M_CONTROL_ROOM_05")
end

function DIA_SPE_NIV_M_CONTROL_ROOM_05()
	-- DIA_SPE_NIV_M_CONTROL_ROOM_05
--	DisplaySubtitle("DIA_SPE_NIV_M_CONTROL_ROOM_05",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_CONTROL_ROOM_06", 1)
	SpeakerMessage("DIA_SPE_NIV_M_CONTROL_ROOM_05", false, 100, 0,"DIA_SPE_NIV_M_CONTROL_ROOM_06")
end

function DIA_SPE_NIV_M_CONTROL_ROOM_06()
	-- DIA_SPE_NIV_M_CONTROL_ROOM_06
--	DisplaySubtitle("DIA_SPE_NIV_M_CONTROL_ROOM_06",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_CONTROL_ROOM_07", 1)
	SpeakerMessage("DIA_SPE_NIV_M_CONTROL_ROOM_06", false, 100, 0,"DIA_SPE_NIV_M_CONTROL_ROOM_07")
end

function DIA_SPE_NIV_M_CONTROL_ROOM_07()
	-- DIA_SPE_NIV_M_CONTROL_ROOM_07
--	DisplaySubtitle("DIA_SPE_NIV_M_CONTROL_ROOM_07",3)
--	CreationTimer(true, true, false, "PrologueAsc_2", 2)
	SpeakerMessage("DIA_SPE_NIV_M_CONTROL_ROOM_07", false, 100, 0,"PrologueAsc_2")
end

------------------------------------------------------------

--[[ Speaker Intro --]]

function PrologueAsc_2()

	-- AMBIANCE SOUND : 
	-- Foule : Hurlements et applaudissements

	-- DIA_SPE_NIV_M_COMMENT_RADIO_43 :
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_43",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_RADIO_44", 4)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_43", true, 100,0,"DIA_SPE_NIV_M_RADIO_44")

end

------------------------------------------------------------

--[[ Speaker Intro (suite) --]]

function DIA_SPE_NIV_M_RADIO_44()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_44
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_44",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_RADIO_45", 4)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_44", true, 100,0,"DIA_SPE_NIV_M_RADIO_45")
end

function DIA_SPE_NIV_M_RADIO_45()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_45
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_45",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_IGOR_BORYENKA_01", 4)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_45", true, 100,0,"DIA_SPE_NIV_M_IGOR_BORYENKA_01")
end

function DIA_SPE_NIV_M_IGOR_BORYENKA_01()
	-- DIA_SPE_NIV_M_IGOR_BORYENKA_01
--	DisplaySubtitle("DIA_SPE_NIV_M_IGOR_BORYENKA_01",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_RADIO_47", 4)
	if (_idMerc[0] ~= nil) then 
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_M_IGOR_BORYENKA_01",true,100,1,0,"DIA_SPE_NIV_M_RADIO_47",100)
	end
end

function DIA_SPE_NIV_M_RADIO_47()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_47
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_47",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_RADIO_48", 4)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_47", true, 100,0,"DIA_SPE_NIV_M_RADIO_48")
	CameraShake(0.5, 1.0, 1.0, 1.0)
	CreationTimer(true, true, false, "DemarrageAsc",1)
end


function DemarrageAsc()
	_bElevatorSequence = true
	SetVarValue(GetSound_ClientID("Sound_Client_Elevator"),"Playing",true)
end

function DIA_SPE_NIV_M_RADIO_48()

	-- DIA_SPE_NIV_M_COMMENT_RADIO_48
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_48",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_RADIO_49", 4)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_48", true, 100,0,"DIA_SPE_NIV_M_RADIO_49")
end

function DIA_SPE_NIV_M_RADIO_49()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_49
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_49",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_RADIO_50", 4)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_49", true, 100,0,"DIA_SPE_NIV_M_RADIO_50")
end

function DIA_SPE_NIV_M_RADIO_50()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_50
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_50",3)
--	CreationTimer(true, true, false, "PrologueAsc_4", 4)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_50", true, 100,0,"PrologueAsc_5")
end

------------------------------------------------------------

--[[ Speaker Intro (suite) --]]

function PrologueAsc_4()

	-- AMBIANCE SOUND : 
	-- Foule : Hurlements et applaudissements "Nolan ! Nolan ! Igor ! Igor !"

	-- DIA_SPE_NIV_M_IGOR_BORYENKA_02
--	DisplaySubtitle("DIA_SPE_NIV_M_IGOR_BORYENKA_02",3)
--	CreationTimer(true, true, false, "PrologueAsc_5", 4)
	if (_idMerc[0] ~= nil) then 
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_M_IGOR_BORYENKA_02",true,100,1,1,"DIA_SPE_NIV_M_RADIO_51",100)
	end
end

------------------------------------------------------------

--[[ Speaker Bet Speak --]]

function PrologueAsc_5()

    _bElevatorSequence = false
    CameraShake(0.5, 1.0, 1.0, 1.0)
		EnableCharacterFire(_idPlayer,true)
   -- SetVarValue(GetSound_ClientID("SoundElevatorArrival"), "Playing",
      -- pffffiiiioouuuu...

    -- petit stress avant ouverture des portes
	CreationTimer(true, true, false, "OpenIntroDoor",1)

--	EnableCharCmd()
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_RADIO_51", 4)
end

function OpenIntroDoor()
	-- OUVERTURE DE LA PORTE
	UnLockDoor(GetDoorID("Door_Asc1_1"))
--	UnLockDoor(GetDoorID("Door_Asc1_2"))
	OpenDoor(GetDoorID("Door_Asc1_1"))
--	OpenDoor(GetDoorID("Door_Asc1_2"))
--	EnableCmdMisterFive()
	--SetVarValue(_idMerc[0],"CharacterAI",GetCharacter_AIID("Char_AI_MisterFive"))
	SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AIO_List_MisterFive_1"))
	PrologueAsc_4()
	SetVarValue(GetSound_ClientID("Sound_Client_Elevator"),"Playing",false)
	_bTestPlayerExterieur = true
end
------------------------------------------------------------

--[[ Speaker Bet Speak (suite) --]]

function DIA_SPE_NIV_M_RADIO_51()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_51
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_51",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_RADIO_52", 4)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_51", true, 100,0,"DIA_SPE_NIV_M_RADIO_52")
end

function DIA_SPE_NIV_M_RADIO_52()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_52
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_52",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_RADIO_53", 4)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_52", true, 100,0,"DIA_SPE_NIV_M_RADIO_53")
end

function DIA_SPE_NIV_M_RADIO_53()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_53
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_53",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_RADIO_54", 4)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_53", true, 100,0,"DIA_SPE_NIV_M_RADIO_54")
end

function DIA_SPE_NIV_M_RADIO_54()
	-- DIA_SPE_NIV_M_RADIO_54
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_54",3)
--	CreationTimer(true, true, false, "DefreezeSyndic_Soldats_01", 6)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_54", true, 100,0,"DefreezeSyndic_Soldats_01")
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Arrivée du 1er groupe d'ennemis : Soldats_01 ::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Defreeze le groupe Grp_Syndic_Soldats_01 et le téléporte si besoin + commentaire speaker --]]

function DefreezeSyndic_Soldats_01()
	FreezeAll(GetGroupID("Grp_Syndic_Soldats_01"), false)
	-- DIA_SPE_NIV_M_COMMENT_RADIO_02
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_02",3)
		-- Dialogue(true,3,"Que le combat commence !")

	-- Teletransportation du groupe de soldats 01
	TeletransportationAsc1ou2(4,"Repere_Asc_1_","Repere_Asc_2_","Char_Syndic_Soldats_01_")

	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_01_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_01_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_01_3"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_01_4"), false)

	-- Assignation des ordres de Go to waypoint pdt la séquence cam
		-- si le joueur est dans la zone 2, le spawn s'est fait dans l'Asc1 
		-- et on attribue une AIOL toutes les 0.5 secondes pour que les bots 
		-- se gènent pas en sortant de l'asc.

	

	if (_bPlayerLocation == 2) then
		-- Ouverture de la porte
	CloseDoor(GetDoorID("Door_Asc1_1"))
--	CloseDoor(GetDoorID("Door_Asc1_2"))
	LockDoor(GetDoorID("Door_Asc1_1"))
--	LockDoor(GetDoorID("Door_Asc1_2"))

	SetVarValue(GetDoorID("Door_Asc1_1"),"Opened Time",8)
--	SetVarValue(GetDoorID("Door_Asc1_2"),"Opened Time",8)

		-- :::: BLAM :::: --		CreationTimer(true, true, false, "AIOL_Soldats_01_1b", 0.3)
		CreationTimer(true, true, false, "AIOL_Soldats_01_1a", 2)
		-- Séquence Caméra

		-- Détruit les SRB susceptibles de géner
		ReleaseSingleRigidBodyInBox("SE_Rlz_SRB_Asc1")

		CamAsc1_1()
		-- Désactive les Cmd du Player
		DisableCharCmd()
		-- Désactive les Cmd de Mister Five
		DisableCmdMisterFive()

	else
		-- Ouverture de la porte

	CloseDoor(GetDoorID("Door_Asc2_1"))
--	CloseDoor(GetDoorID("Door_Asc2_2"))
	LockDoor(GetDoorID("Door_Asc2_1"))
--	LockDoor(GetDoorID("Door_Asc2_2"))

		-- :::: BLAM :::: --		CreationTimer(true, true, false, "AIOL_Soldats_01_1b", 0.3)
		CreationTimer(true, true, false, "AIOL_Soldats_01_2a", 2)

		-- Détruit les SRB susceptibles de géner
		ReleaseSingleRigidBodyInBox("SE_Rlz_SRB_Asc2")

		-- Séquence Caméra
		CamAsc2_1()
		-- Désactive les Cmd du Player
		DisableCharCmd()
		-- Désactive les Cmd de Mister Five
		DisableCmdMisterFive()
	end	
end

------------------------------------------------------------

--[[ Attribution des AIOL toutes les 0.5 secondes --]]

function AIOL_Soldats_01_1a()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_1a"))
	CreationTimer(true, true, false, "AIOL_Soldats_01_1b", 0.8)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_01_1"), true)	
end
function AIOL_Soldats_01_1b()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_1b"))
	CreationTimer(true, true, false, "AIOL_Soldats_01_1c", 0.8)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_01_2"), true)	
end
function AIOL_Soldats_01_1c()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_1c"))
	CreationTimer(true, true, false, "AIOL_Soldats_01_1d", 1)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_01_3"), true)		
end
function AIOL_Soldats_01_1d()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_4"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_1d"))	
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_01_4"), true)
end
------------------------------------------------------------
function AIOL_Soldats_01_2a()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_2a"))
	CreationTimer(true, true, false, "AIOL_Soldats_01_2b",1)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_01_1"), true)	
end
function AIOL_Soldats_01_2b()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_2b"))
	CreationTimer(true, true, false, "AIOL_Soldats_01_2c",1)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_01_2"), true)
end
function AIOL_Soldats_01_2c()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_2c"))
	CreationTimer(true, true, false, "AIOL_Soldats_01_2d",1)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_01_3"), true)		
end
function AIOL_Soldats_01_2d()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_4"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_2d"))	
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_01_4"), true)
end

------------------------------------------------------------

--[[ Change l'OrderList du groupe Soldats_01 après la cinématique (Formation Turtle) --]]

function ChangeOrderListSoldats_01()
--	SetVarValue(GetGroupID("Grp_Syndic_Soldats_01"), "GroupAIOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_3"))

		-----		
				_idChar_Syndic_Soldats_01_1=GetCharacterID("Char_Syndic_Soldats_01_1")
				_idChar_Syndic_Soldats_01_2=GetCharacterID("Char_Syndic_Soldats_01_2")
				_idChar_Syndic_Soldats_01_3=GetCharacterID("Char_Syndic_Soldats_01_3")
				_idChar_Syndic_Soldats_01_4=GetCharacterID("Char_Syndic_Soldats_01_4")
	
		------
				CharacterStopSpecialAction(_idChar_Syndic_Soldats_01_1)
				CharacterStopSpecialAction(_idChar_Syndic_Soldats_01_2)
				CharacterStopSpecialAction(_idChar_Syndic_Soldats_01_3)
				CharacterStopSpecialAction(_idChar_Syndic_Soldats_01_4)
		------
	SetVarValue(GetGroupID("Grp_Syndic_Soldats_01"), "GroupAI", GetGroup_AIID("Grp_AI_Syndic_Soldats_01"))
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Vide"))
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Vide"))
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Vide"))
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_4"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Vide"))
	_nTurtleGrp_Syndic_Soldats_01 = true

	-- Rétablit les Cmd du Player
	EnableCharCmd()
	StartCountDown(5,"EnableFireSoldats_01",true)
	EnableCharacterFire(_idPlayer,false)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],false)
	end
	-- Rétablit les Cmd de Mister Five s'il est en vie
	EnableCmdMisterFive()
	
	ShowCinematicBlackStripes(false)
	SetGodMode(_idPlayer,false)
end

function EnableFireSoldats_01()
--	StartCountDown(5,"EnableFireSoldats_01",true)
	EnableCharacterFire(_idPlayer,true)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],true)
	end
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_01_1"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_01_2"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_01_3"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_01_4"), true)
--[[ Mister Five 2 --]]

	-- DIA_SPE_NIV_M_IGOR_BORYENKA_03
	DisplaySubtitle("DIA_SPE_NIV_M_IGOR_BORYENKA_03",3)

	-- Objectif : Survivre/Eliminer les autres combattants
--	DisplayObjective ( "HUD_OBJ_ADDED",GetObjectiveID("Obj_Survivre_1"), 2, 5 )
	-- :::: OBJECTIF ::::
	NewObjectiveNewSubObjective("Obj_A_SURVIVRE","Obj_A1_ELIMINATE")
	SetVarValue(GetObjectiveID("Obj_W1"),"Active", true)
	SetVarValue(GetObjectiveID("Obj_W2"),"Active", false)
	SetVarValue(GetObjectiveID("Obj_W3"),"Active", false)
	SetVarValue(GetObjectiveID("Obj_W4"),"Active", false)
	SetVarValue(GetObjectiveID("Obj_W5"),"Active", false)
end

------------------------------------------------------------

--[[ Disable la Turtle dès que le Player n'est plus en extérieur --]]

function NoMoreTurtle()
	if (_bTestPlayerExterieur == false) and (_nTurtleGrp_Syndic_Soldats_01 == true) then
		SetVarValue(GetGroupID("Grp_Syndic_Soldats_01"), "GroupAIOrderList", GetAI_Order_ListID("AIO_List_Vide"))
		SetVarValue(GetGroupID("Grp_Syndic_Soldats_01"), "Freeze", true)
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_3a"))
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_3b"))
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_3a"))
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_4"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_3b"))
		_nTurtleGrp_Syndic_Soldats_01 = false
	end
end

------------------------------------------------------------

--[[ Disable les Forbid Zones des Characters lorsqu'il n'en reste qu'un en vie --]]

function DisableFZChar_Syndic_Soldats_01()
	_nAliveGrp_Syndic_Soldats_01 = AliveMembersCount(GetGroupID("Grp_Syndic_Soldats_01"))
	if (_nAliveGrp_Syndic_Soldats_01 <=1) then
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_3"))
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_3"))
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_3"))
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_4"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_01_3"))
	end
end

------------------------------------------------------------

--[[ Teste si les membres du groupe Syndic_Soldats_01 sont encore vivant et si non defreeze le grpe Syndic_Soldats_02 --]]

function IsAliveSyndic_Soldats_01()
	_bVieSyndic_Soldats_01 = IsAlive(GetGroupID("Grp_Syndic_Soldats_01"))
	if (_bVieSyndic_Soldats_01 == false) and (_bDesactiveVieSyndic_Soldats_01 == false) then
		CreationTimer(true, true, false, "DefreezeSyndic_Soldats_02",4)
		_bDesactiveVieSyndic_Soldats_01 = true
	end
end

--[[ Speaker --]]

function DIA_SPE_NIV_M_COMMENT_RADIO_04()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_04
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_04",3)
--	Dialogue(true,3,"Nolan a l'air en forme !")
--	CreationTimer(true, true, false, "DefreezeSyndic_Soldats_02", 5)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_04", true, 100,2,"DefreezeSyndic_Soldats_02")
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Arrivée des 2 groupes d'ennemis suivants ::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Defreeze le groupe Syndic_Soldats_02 --]]

function DefreezeSyndic_Soldats_02()
	
	FreezeAll(GetGroupID("Grp_Syndic_Soldats_02"), false)
	TeletransportationAsc1(4,"Repere_Asc_2_","Char_Syndic_Soldats_02_")

	SetVarValue(GetDoorID("Door_Asc1_1"),"Opened Time",8)
--	SetVarValue(GetDoorID("Door_Asc1_2"),"Opened Time",8)

		-- Désactive les Cmd du Player
		DisableCharCmd()
		-- Désactive les Cmd de Mister Five
		DisableCmdMisterFive()

	TP_Player_Cine()

	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_02_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_02_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_02_3"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_02_4"), false)

	-- DIA_SPE_NIV_M_COMMENT_RADIO_03
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_03",3)
	-- Dialogue(true,3,"De nouveaux adversaires arrivent, le combat continue...")
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_03", true, 100,1,"AIOL_Soldats_02_1a")

	-- Ouverture de la porte

	CloseDoor(GetDoorID("Door_Asc2_1"))
--	CloseDoor(GetDoorID("Door_Asc2_2"))
	LockDoor(GetDoorID("Door_Asc2_1"))
--	LockDoor(GetDoorID("Door_Asc2_2"))

	-- :::: BLAM :::: --
--	CreationTimer(true, true, false, "AIOL_Soldats_02_1a", 1)	

		-- Détruit les SRB susceptibles de géner
		ReleaseSingleRigidBodyInBox("SE_Rlz_SRB_Asc2")

	-- Séquence Caméra
	CamSoldats_02()
end

------------------------------------------------------------

--[[ Attribution des AIOL toutes les 0.3 secondes --]]

function AIOL_Soldats_02_1a()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_02_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_02_1a"))
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_02_1"), true)
	CreationTimer(true, true, false, "AIOL_Soldats_02_1b", 1)		
end
function AIOL_Soldats_02_1b()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_02_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_02_1b"))
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_02_3"), true)
	CreationTimer(true, true, false, "AIOL_Soldats_02_1c", 1.5)		
end
function AIOL_Soldats_02_1c()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_02_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_02_1c"))
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_02_2"), true)
	CreationTimer(true, true, false, "AIOL_Soldats_02_1d", 1.5)		
end
function AIOL_Soldats_02_1d()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_02_4"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_02_1d"))	
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_02_4"), true)
end

------------------------------------------------------------

--[[ Defreeze le groupe Syndic_Soldats_03 --]]

function DefreezeSyndic_Soldats_03()

		---------------
		CharacterStopSpecialAction(_idChar_Syndic_Soldats_02_1)	
		
		---------------

	
	FreezeAll(GetGroupID("Grp_Syndic_Soldats_03"), false)
	TeletransportationAsc1(4,"Repere_Asc_1_","Char_Syndic_Soldats_03_")

	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_03_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_03_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_03_3"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_03_4"), false)

	-- Ouverture de la porte
	CloseDoor(GetDoorID("Door_Asc1_1"))
--	CloseDoor(GetDoorID("Door_Asc1_2"))
	LockDoor(GetDoorID("Door_Asc1_1"))
--	LockDoor(GetDoorID("Door_Asc1_2"))

	-- :::: BLAM :::: --
	CreationTimer(true, true, false, "AIOL_Soldats_03_1a", 1)	

		-- Détruit les SRB susceptibles de géner
		ReleaseSingleRigidBodyInBox("SE_Rlz_SRB_Asc1")

	-- Séquence Caméra
	CamSoldats_03()
end

------------------------------------------------------------

--[[ Attribution des AIOL toutes les 0.3 secondes --]]

function AIOL_Soldats_03_1a()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_03_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_03_1a"))
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_03_1"), true)
	CreationTimer(true, true, false, "AIOL_Soldats_03_1b", 0.8)		
end
function AIOL_Soldats_03_1b()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_03_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_03_1b"))
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_03_2"), true)
	CreationTimer(true, true, false, "AIOL_Soldats_03_1c", 0.8)		
end
function AIOL_Soldats_03_1c()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_03_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_03_1c"))
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_03_3"), true)
	CreationTimer(true, true, false, "AIOL_Soldats_03_1d", 1)		
end
function AIOL_Soldats_03_1d()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_03_4"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_03_1d"))	
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_03_4"), true)
end

------------------------------------------------------------

--[[ Change l'OrderList des groupes Soldats_02 et Soldats_03 après la cinématique (No Formation) --]]

function ChangeOrderListSoldats_02_03()

			---------------
		CharacterStopSpecialAction(_idChar_Syndic_Soldats_03_1)	
		
		---------------

	-- Groupe 02
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_02_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_02_2a"))
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_02_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_02_2a"))
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_02_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_02_2b"))
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_02_4"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_02_2b"))
	-- Groupe 03
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_03_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_03_2a"))
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_03_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_03_2a"))
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_03_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_03_2b"))
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_03_4"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Soldats_03_2b"))
	-- Rétablit les Cmd du Player
	EnableCharCmd()
	StartCountDown(5,"EnableFireSoldats_02_03",true)
	EnableCharacterFire(_idPlayer,false)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],false)
	end

	-- Rétablit les Cmd de Mister Five s'il est en vie
	EnableCmdMisterFive()

	ShowCinematicBlackStripes(false)
	SetGodMode(_idPlayer,false)
end

function EnableFireSoldats_02_03()
--	StartCountDown(5,"EnableFireSoldats_01",true)
	EnableCharacterFire(_idPlayer,true)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],true)
	end
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_02_1"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_02_2"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_02_3"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_02_4"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_03_1"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_03_2"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_03_3"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Soldats_03_4"), true)

end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Arrivée des Parachutistes :::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Teste si les membres du groupe Syndic_Soldats_02,03 sont encore vivant et si non defreeze les grpes Syndic_Para_01 et 02 --]]

function IsAliveSyndic_Soldats_02_03()
	_bVieSyndic_Soldats_02 = IsAlive(GetGroupID("Grp_Syndic_Soldats_02"))
	_bVieSyndic_Soldats_03 = IsAlive(GetGroupID("Grp_Syndic_Soldats_03"))
	if ((_bVieSyndic_Soldats_02 == false) and (_bVieSyndic_Soldats_03 == false) and (_bDesactiveVieSyndic_Soldats_02 == false) and (_bDesactiveVieSyndic_Soldats_03 == false)) then
	--	if (_bTestPlayerExterieur == false) then	
	--		CreationTimer(true, true, false, "Speaker1", 5)
	--		_bCtrl_OBJ = true
	--	else
			CreationTimer(true, true, false, "Speaker2", 5)
			_bCtrl_OBJ = false
	--	end
		_bDesactiveVieSyndic_Soldats_02 = true
		_bDesactiveVieSyndic_Soldats_03 = true
	end
end

------------------------------------------------------------

--[[ Si Nolan n'est pas dans l'Arène, le Speaker lui demande de remonter pour se faire acclamer par la foule --]]

function Speaker1()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_05
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_05",3)
--	Dialogue(true,3,"Les exploits de Nolan enthousiasment les spectateurs ! La foule réclame son Champion ! Que Nolan remonte dans l'Arène !")
--	CreationTimer(true, true, false, "GUI1", 12)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_05", true, 100,2,"GUI1")
end

------------------------------------------------------------

--[[ Dialogue GUI 1 --]]

function GUI1()
--	Dialogue(true,3,"::: Objectif ::: Sortir dans l'arène")
--	CreationTimer(true, true, false, "Speaker2", 5)

	-- :::: OBJECTIF ::::
--	NewSubObjective("Obj_A1_ELIMINATE","Obj_A2_LEAVE")
end

------------------------------------------------------------

--[[ Speaker --]]

function Speaker2()
	_bLeJoueurEntreDansLArene = true
	CreationTimer(true, true, false, "ActiveSpeakDial3", 5)
end

------------------------------------------------------------

--[[ Speaker --]]

function ActiveSpeakDial3()
	_bCtrlSpeakDial3 = true
end

------------------------------------------------------------

--[[ Speaker --]]

function Speaker2test()
	if --[[(_bTestPlayerExterieur == true) and--]] (_bLeJoueurEntreDansLArene == true) then
		-- DIA_SPE_NIV_M_COMMENT_RADIO_63
		-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_63",3)

		-- AMBIANCE SOUND : 
		-- Foule : Ovation (il faut que le joueur soit cloué sur place par le bruit)

		-- FX : feux de binguales et feux d'artifices

		-- CreationTimer(true, true, false, "SpeakerParas1", 8)
		SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_63", true, 100,5,"SpeakerParas1")

		_bLeJoueurEntreDansLArene = false
		_bCtrlSpeakDial3_2 = false
	end
end

------------------------------------------------------------

--[[ Speaker --]]

function SpeakerParas1()
		-- DIA_SPE_NIV_M_COMMENT_RADIO_06
--		Dialogue(true,3,"Oh ! Mais que se passe-t-il ? On dirait... des parachutistes ! Oui, les prochains adversaires de Nolan viennent du ciel !")
		-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_06",3)
		-- CreationTimer(true, true, false, "DefreezeSyndic_Para_01_02", 4)
		SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_06", true, 100,1,"DefreezeSyndic_Para_01_02")
end

------------------------------------------------------------

--[[ Defreeze les groupes Syndic_Para_01 et 02 --]]

function DefreezeSyndic_Para_01_02()
	FreezeAll(GetGroupID("Grp_Syndic_Para_01"), false)

	-- Teletransportation du groupe de paras 01
	TeletransportationAsc1(3,"Repere_Para_1_","Char_Syndic_Para_01_")

	FreezeAll(GetGroupID("Grp_Syndic_Para_02"), false)
	-- Teletransportation du groupe de paras 01
	TeletransportationAsc1(3,"Repere_Para_2_","Char_Syndic_Para_02_")

	_bDefriseParas = true

	EnableCharacterCommand(GetCharacterID("Char_Syndic_Para_01_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Para_01_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Para_01_3"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Para_02_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Para_02_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Para_02_3"), false)

		-- Séquence Caméra
		CamParas1_1()
		-- Désactive les Cmd du Player
		DisableCharCmd()
		-- Désactive les Cmd de Mister Five
		DisableCmdMisterFive()

		if (_bTestPlayerExterieur == true) then
			Teletransportation("Repere_Player",_idPlayer)
			if (_idMerc[0] ~= nil) then
				Teletransportation("Repere_Igor",_idMerc[0])
			end
		end
end

------------------------------------------------------------

--[[ Change l'OrderList des Paras --]]

function ChangeOrderListParas_01_02()

	-- MODIFS : 
	-- faire en sorte que le plan final nous montre l'atérrissage du 1er para, pour qu'on ait pendant 1 ou 2 s que lui à affronter.
	-- Les autres se posent en décallé, mais suffisament vite pour qu'on ne puisse pas faire du tir aux pigeons.

	-- Rétablit les Cmd du Player
	EnableCharCmd()
	StartCountDown(5,"EnableFireParas_01_02",true)
	EnableCharacterFire(_idPlayer,false)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],false)
	end
	-- Rétablit les Cmd de Mister Five s'il est en vie
	EnableCmdMisterFive()

	ShowCinematicBlackStripes(false)
	SetGodMode(_idPlayer,false)

	EnableCharacterCommand(GetCharacterID("Char_Syndic_Para_01_1"), true)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Para_01_2"), true)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Para_01_3"), true)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Para_02_1"), true)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Para_02_2"), true)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Para_02_3"), true)

end

function EnableFireParas_01_02()
--	StartCountDown(5,"EnableFireSoldats_01",true)
	EnableCharacterFire(_idPlayer,true)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],true)
	end
	EnableCharacterFire(GetCharacterID("Char_Syndic_Para_01_1"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Para_01_2"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Para_01_3"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Para_02_1"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Para_02_2"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Para_02_3"), true)
--	if (_bCtrl_OBJ == true) then
		-- :::: OBJECTIF ::::
		NewSubObjective("Obj_A1_ELIMINATE","Obj_A3")
--	else
		-- :::: OBJECTIF ::::
--		NewSubObjective("Obj_A2_LEAVE","Obj_A3")
--	end
end

------------------------------------------------------------

--[[ Teste le nb de persos qui restent ds les grpes Syndic_Para_01 et 02 et lance le defreeze des Ours

VieSyndic_Para_01_ = {}
VieSyndic_Para_02_ = {}

CtrlPara1 = {}
CtrlPara1[1] = false
CtrlPara1[2] = false
CtrlPara1[3] = false

CtrlPara2 = {}
CtrlPara2[1] = false
CtrlPara2[2] = false
CtrlPara2[3] = false

function TestGrp_Syndic_Para_01_02()
	for i=1,3,1 do
		VieSyndic_Para_01_[i] = IsAlive(GetCharacterID("Char_Syndic_Para_01_" .. i))
		if (VieSyndic_Para_01_[i] == false) and (CtrlPara1[i] == false) then
			_nTotalPara1Alive = _nTotalPara1Alive + 1
			CtrlPara1[i] = true
		end
	end
	for i=1,3,1 do
		VieSyndic_Para_02_[i] = IsAlive(GetCharacterID("Char_Syndic_Para_02_" .. i))
		if (VieSyndic_Para_02_[i] == false) and (CtrlPara2[i] == false) then
			_nTotalPara2Alive = _nTotalPara2Alive + 1
			CtrlPara2[i] = true
		end
	end
	if (((_nTotalPara1Alive + _nTotalPara2Alive) == 0) and (_bSpawnOurs == false) and (_bDefriseParas == true)) then
			CreationTimer(true, true, false, "DefreezeOurs", 5)
		_bSpawnOurs = true
	end
end

--]]

--[[ Teste si les membres du groupe Syndic_Soldats_02,03 sont encore vivant et si non defreeze les grpes Syndic_Para_01 et 02 --]]

function TestGrp_Syndic_Para_01_02()
	_bVieSyndic_Paras_01 = IsAlive(GetGroupID("Grp_Syndic_Para_01"))
	_bVieSyndic_Paras_02 = IsAlive(GetGroupID("Grp_Syndic_Para_02"))
	if ((_bVieSyndic_Paras_01 == false) and (_bVieSyndic_Paras_02 == false) and (_bDesactiveVieSyndic_Paras_01 == false) and (_bDesactiveVieSyndic_Paras_02 == false)) then

		CreationTimer(true, true, false, "DefreezeOurs", 5)
		_bSpawnOurs = true

		_bDesactiveVieSyndic_Paras_01 = true
		_bDesactiveVieSyndic_Paras_02 = true
	end
end
------------------------------------------------------------
------------------------------------------------------------

-- ::: Arrivée des Ours ::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Defreeze les Ours --]]

function DefreezeOurs()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_07
--	Dialogue(true,6,"Ah ! Mais qu'est-ce que je vois tomber du ciel ? Ah… On voit mal ! \nSi, voici nos deux premiers Champions ! Ils viennent tout droit du nord-ouest de la Russie ! \nCe sont les Ours de Volkograd !")
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_07",3)
--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_08", 4)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_07", true, 100,1,"DIA_SPE_NIV_M_COMMENT_RADIO_08")

	FreezeAll(GetGroupID("Grp_Syndic_Ours"), false)
	TeletransportationAsc1(2,"Repere_Ours_","Char_Syndic_Ours_")

	EnableCharacterCommand(GetCharacterID("Char_Syndic_Ours_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Ours_2"), false)

	CreationTimer(true, true, false, "ActiveShieldOurs1", 3.5)

	-- Séquence Caméra
	CamOurs_1()
	-- Désactive les Cmd du Player
	DisableCharCmd()
	-- Désactive les Cmd de Mister Five
	DisableCmdMisterFive()

		if (_bTestPlayerExterieur == true) then
			Teletransportation("Repere_Player",_idPlayer)
			if (_idMerc[0] ~= nil) then
				Teletransportation("Repere_Igor",_idMerc[0])
			end
		end
end

function ActiveShieldOurs1()
	SetVarValue(GetPlug_MagneticShieldID("Plug_MagneticShield-31"),"Active",true)
end

function ActiveShieldOurs2()
	SetVarValue(GetPlug_MagneticShieldID("Plug_MagneticShield-32"),"Active",true)
end

------------------------------------------------------------

--[[ Change l'AIOL des Ours quand la séquence Cam est finie --]]

function ChangeOrderListOurs()

	-- Rétablit les Cmd du Player
	EnableCharCmd()
	StartCountDown(5,"EnableFireOurs",false)
	EnableCharacterFire(_idPlayer,false)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],false)
	end

	-- Rétablit les Cmd de Mister Five s'il est en vie
	EnableCmdMisterFive()

	ShowCinematicBlackStripes(false)
	SetGodMode(_idPlayer,false)

	EnableCharacterCommand(GetCharacterID("Char_Syndic_Ours_1"), true)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Ours_2"), true)

end

function EnableFireOurs()
--	StartCountDown(5,"EnableFireSoldats_01",true)
	EnableCharacterFire(_idPlayer,true)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterFire(_idMerc[0],true)
	end
	EnableCharacterFire(GetCharacterID("Char_Syndic_Ours_1"), true)
	EnableCharacterFire(GetCharacterID("Char_Syndic_Ours_2"), true)

		-- :::: OBJECTIF ::::
		NewSubObjective("Obj_A3","Obj_A4")
end

------------------------------------------------------------

--[[ Speaker --]]

function DIA_SPE_NIV_M_COMMENT_RADIO_08()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_08
--	Dialogue(true,3,"L'ambiance est surchauffée !")
--	DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_08",3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_08", true, 100,0,"")
end

------------------------------------------------------------

--[[ Teste la mort des Ours --]]

function TestMortOurs()
	_bTestMortOurs = IsAlive (GetGroupID("Grp_Syndic_Ours"))
	if (_bTestMortOurs == false) and (_bCtrlMortOurs == false) then
		-- DIA_SPE_NIV_M_COMMENT_RADIO_09
		-- Dialogue(true,4,"Waouh ! Nolan vient d'éliminer les Ours de Volkograd ! Quel combat exceptionnel ! Applaudissez les combattants !")
		-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_09",3)
		-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_10", 12)
		SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_09", true,100,9,"DIA_SPE_NIV_M_COMMENT_RADIO_10")
		_bCtrlMortOurs = true
	end
end