------------------------------------------------------------
------------------------------------------------------------

-- ::: InitLevel :::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function InitLevelCamp1()
	_bCtrlAliveVague1a = false
	_bCtrlAliveVague1b = false
	_bCtrlAliveVague1c = false
	_bCtrlTotalAliveVague2a = false
	_bCtrlTotalAliveVague2b = false
	_bCtrlTotalAliveVague2c = false
	_bCtrlTotalAliveVague3a = false
	_bCtrlTotalAliveVague3b = false
	_bCtrlTotalAliveVague3c = false
	_bCtrlTotalAliveVague4a = false
	_bCtrlTotalAliveVague4b = false
	_bCtrlTotalAliveVague4c = false
	_bCtrlTotalAliveVague5a = false
	_bCtrlTotalAliveVague5b = false
	_bCtrlTotalAliveVague5c = false
	_idExoBoS = GetExoskeletonID("Exo_Camp2")
	_idCamPointExoBoS = GetCamPointID("CamPoint_Track_Exo_BoS")
	_idCamPointExoBoS1 = GetCamPointID("CamPoint_Exo_BoS1")
	_idCamPointExoBoS2 = GetCamPointID("CamPoint_Exo_BoS2")
	_bExoBoSCine = false
	_bCtrlBoSEnCours = false
	_bCtrlDejaJoue1 = false
	_bIsPlayerInExo = false
	_bPlayerBunker = false
	_bSpeedGrenade = false
	_bBoSEnCours = false
	_bCtrlSE_Camp1_Trigger_3 = false
	_bExpirTurtlesPlainA = false
	_bExpirTurtlesPlainB = false
	_CrtActiveDesactiveMagneticSHield = false
	_bCtrlSE_Camp1_Exo_Stop = false
	_bCtrlSE_Camp1_Exo_Cine = false
	_bCtrlSE_Camp1_Trigger_0 = false
	_bCtrlSE_Camp1_Trigger_1 = false
	_bCtrlSE_Camp1_Trigger_1b = false
	_bCtrlSE_Camp1_Trigger_1c = false
	_bCtrlSE_Camp1_Trigger_2 = false
	_bCtrlSE_Camp1_Exo_Open = false
	_bExpirWPExTurtles = false
	_bCtrlSE_Camp1_ExpirTurtlesPlain1 = false
	_bCtrlSE_Camp1_ExpirTurtlesPlain2 = false
	_bCtrlSE_Camp1_ExpirTurtlesPlain3 = false
	_bCtrlSE_Camp1_ExpirTurtlesPlain4 = false
	_bTestPlayerExoCamp1 = false
	_bActiveTestPlayerExoCamp1 = false
	_bCtrlSE_Camp1_FZ_Entree = false
	_bCtrlFreezeChamp0 = false
	_bExoSorti = false
	_bCtrlSE_Player_Exo_Camp1 = false
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: UpdateLevel :::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------
function UpdateLevelCamp1()
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_4",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_5",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_6",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_7",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_10",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_11",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_12",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_13",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_14",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_15",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_16",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_17",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_18",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_19",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_20",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_21",90,60,"AIOL_FA_Player")
--	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_22",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_23",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_24",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_25",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_26",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_27",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_28",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_29",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Camp1_UAN_Trooper_30",90,60,"AIOL_FA_Player")

	AliveVague1()
	AliveVague2()
	AliveVague3()
	AliveVague4()
	AliveVague5()

	AliveVaguesAndExoCamp1()

	TrackingCamExoBoS()
--	TrackingCamExoBoS1()
	TrackingCamExoBoS2()

	TestPlayerExoDuringBoS()
end
------------------------------------------------------------
------------------------------------------------------------

-- ::: Alarme ::::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnEnter_SE_Camp1_Trigger_0(id)
	if ((id == _idPlayer) and (_bCtrlSE_Camp1_Trigger_0 == false)) then
		NewObjectiveNewSubObjective("Obj_A","Obj_A_1")
		SetVarValue(GetObjectiveID("Obj_A_3"),"Active",true)
--		CreationTimer(true, true, false, "TIPS",8)
		_bCtrlSE_Camp1_Trigger_0 = true
	end
end



function OnEnter_SE_Camp1_Trigger_1(id)
	if ((id == _idPlayer) and (_bCtrlSE_Camp1_Trigger_1 == false)) then
		StartMusic("Sounds//Music//Bos - War theme.wav", false)
 -- 	PauseMusic()
 --		StopMusic()
 --		StartMusic()
		SetVarValue(GetSound_ClientID("Sound_Client_Camp1_Alarm"),"Playing",true)
		CreationTimer(true, true, false, "Defrise_PremiereVague",2)	
		_bCtrlSE_Camp1_Trigger_1 = true
	end
end

function Defrise_PremiereVague()

	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_4"), false)
--	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_5"), false)
--	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_6"), false)
--	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_7"), false)
--	CreationTimer(true, true, false, "DebloqueGroup_PremiereVague",20)	
end

---------------------------------------------------------

function DebloqueGroup_PremiereVague()
--	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
--	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
--	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_6"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
--	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_7"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

---------------------------------------------------------

function OnEnter_SE_Camp1_Trigger_2(id)
	if ((id == _idPlayer) and (_bCtrlSE_Camp1_Trigger_2 == false)) then
	--	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_8"), false)
	--	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_9"), false)
		Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_10"), false)
		Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_11"), false)
		Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_12"), false)
		Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_13"), false)
		Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_14"), false)
--		CreationTimer(true, true, false, "DebloqueGroup_PremiereVague_b",10)
		_bCtrlSE_Camp1_Trigger_2 = true	
	end
end

---------------------------------------------------------

function DebloqueGroup_PremiereVague_b()
--	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_8"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
--	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_9"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_10"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_11"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_12"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_13"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_14"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Vague 2 :::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function AliveVague1()
	_nAliveGrp_Camp1_UAN_1 = AliveMembersCount(GetGroupID("Grp_Camp1_UAN_1"))
	if ((_nAliveGrp_Camp1_UAN_1 <= 2) and (_bCtrlAliveVague1a == false)) then
		CreationTimer(true, true, false, "SpawnVague2",2)	
		_bCtrlAliveVague1a = true
	end
	if ((_nAliveGrp_Camp1_UAN_1 <= 1) and (_bCtrlAliveVague1b == false) and (_bPlayerBunker == false)) then
		_bCtrlAliveVague1b = true
		Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_16"), false)
	end
	if ((_nAliveGrp_Camp1_UAN_1 <= 0) and (_bCtrlAliveVague1c == false) and (_bPlayerBunker == false)) then
		_bCtrlAliveVague1c = true
		Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_17"), false)
	end
end

function SpawnVague2()
	UnLockDoor(GetDoorID("Door_Hangar_3"))
	UnLockDoor(GetDoorID("Door_Hangar_4"))
	OpenDoor(GetDoorID("Door_Hangar_3"))
	OpenDoor(GetDoorID("Door_Hangar_4"))
	FreezeAll(GetGroupID("Grp_Camp1_UAN_House1"), false)
	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_15"), false)
	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_24"), false)
--	CreationTimer(true, true, false, "DebloqueGroup_Vague2",10)
end

---------------------------------------------------------

function DebloqueGroup_Vague2()
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Protector_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Destroyer_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_15"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_24"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Vague 3 :::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function AliveVague2()
	_nAliveGrp_Camp1_UAN_House1 = AliveMembersCount(GetGroupID("Grp_Camp1_UAN_House1"))
	_bAliveChar_Camp1_UAN_Trooper_16 = IsAlive(GetCharacterID("Char_Camp1_UAN_Trooper_16"))
	_bAliveChar_Camp1_UAN_Trooper_17 = IsAlive(GetCharacterID("Char_Camp1_UAN_Trooper_17"))
	_bAliveChar_Camp1_UAN_Trooper_15 = IsAlive(GetCharacterID("Char_Camp1_UAN_Trooper_15"))
	_bAliveChar_Camp1_UAN_Trooper_24 = IsAlive(GetCharacterID("Char_Camp1_UAN_Trooper_24"))

	if (_bAliveChar_Camp1_UAN_Trooper_16 == true) then
		_nAliveChar_Camp1_UAN_Trooper_16 = 1
	else
		_nAliveChar_Camp1_UAN_Trooper_16 = 0		
	end

	if (_bAliveChar_Camp1_UAN_Trooper_17 == true) then
		_nAliveChar_Camp1_UAN_Trooper_17 = 1
	else
		_nAliveChar_Camp1_UAN_Trooper_17 = 0		
	end

	if (_bAliveChar_Camp1_UAN_Trooper_15 == true) then
		_nAliveChar_Camp1_UAN_Trooper_15 = 1
	else
		_nAliveChar_Camp1_UAN_Trooper_15 = 0		
	end

	if (_bAliveChar_Camp1_UAN_Trooper_24 == true) then
		_nAliveChar_Camp1_UAN_Trooper_24 = 1
	else
		_nAliveChar_Camp1_UAN_Trooper_24 = 0		
	end

	_nTotalAliveVague2 = (_nAliveGrp_Camp1_UAN_House1 + _nAliveChar_Camp1_UAN_Trooper_15 + _nAliveChar_Camp1_UAN_Trooper_24)

	if ((_nTotalAliveVague2 <= 1) and (_bCtrlTotalAliveVague2a == false)) then
		CreationTimer(true, true, false, "SpawnVague3",2)	
		_bCtrlTotalAliveVague2a = true
	end

	if ((_nTotalAliveVague2 <= 0) and (_bCtrlTotalAliveVague2b == false) and (_bPlayerBunker == false)) then
		_bCtrlTotalAliveVague2b = true
		Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_19"), false)
	end

--16
--17

end

function SpawnVague3()
	UnLockDoor(GetDoorID("Door_Hangar_Double_1_1"))
	UnLockDoor(GetDoorID("Door_Hangar_Double_1_2"))
	UnLockDoor(GetDoorID("Door_Hangar_Double_1_3"))
	UnLockDoor(GetDoorID("Door_Hangar_Double_1_4"))
	OpenDoor(GetDoorID("Door_Hangar_Double_1_1"))
	OpenDoor(GetDoorID("Door_Hangar_Double_1_2"))
	OpenDoor(GetDoorID("Door_Hangar_Double_1_3"))
	OpenDoor(GetDoorID("Door_Hangar_Double_1_4"))
	FreezeAll(GetGroupID("Grp_Camp1_UAN_House3"), false)
	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_25"), false)
	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_26"), false)
--	CreationTimer(true, true, false, "DebloqueGroup_Vague3",10)
 		
end

---------------------------------------------------------

function DebloqueGroup_Vague3()
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Protector_3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Protector_4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Destroyer_3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Destroyer_4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_25"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_26"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: Vague 4 :::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------


function AliveVague3()
	_nAliveGrp_Camp1_UAN_House3 = AliveMembersCount(GetGroupID("Grp_Camp1_UAN_House3"))
	_bAliveChar_Camp1_UAN_Trooper_19 = IsAlive(GetCharacterID("Char_Camp1_UAN_Trooper_19"))
	_bAliveChar_Camp1_UAN_Trooper_25 = IsAlive(GetCharacterID("Char_Camp1_UAN_Trooper_25"))
	_bAliveChar_Camp1_UAN_Trooper_26 = IsAlive(GetCharacterID("Char_Camp1_UAN_Trooper_26"))


	if (_bAliveChar_Camp1_UAN_Trooper_19 == true) then
		_nAliveChar_Camp1_UAN_Trooper_19 = 1
	else
		_nAliveChar_Camp1_UAN_Trooper_19 = 0		
	end

	if (_bAliveChar_Camp1_UAN_Trooper_25 == true) then
		_nAliveChar_Camp1_UAN_Trooper_25 = 1
	else
		_nAliveChar_Camp1_UAN_Trooper_25 = 0		
	end

	if (_bAliveChar_Camp1_UAN_Trooper_26 == true) then
		_nAliveChar_Camp1_UAN_Trooper_26 = 1
	else
		_nAliveChar_Camp1_UAN_Trooper_26 = 0		
	end

	_nTotalAliveVague3 = (_nAliveGrp_Camp1_UAN_House3 + _nAliveChar_Camp1_UAN_Trooper_25 + _nAliveChar_Camp1_UAN_Trooper_26)

	if ((_nTotalAliveVague3 <= 1) and (_bCtrlTotalAliveVague3a == false)) then
		CreationTimer(true, true, false, "SpawnVague4",2)	
		_bCtrlTotalAliveVague3a = true
	end
end

--19

function SpawnVague4()
	UnLockDoor(GetDoorID("Door_Hangar_2"))
	UnLockDoor(GetDoorID("Door_Hangar_1"))
	OpenDoor(GetDoorID("Door_Hangar_2"))
	OpenDoor(GetDoorID("Door_Hangar_1"))
	FreezeAll(GetGroupID("Grp_Camp1_UAN_House2"), false)
	if  (_bPlayerBunker == false) then
		Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_20"), false)
	end
	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_23"), false)
--	CreationTimer(true, true, false, "DebloqueGroup_Vague4",10)
end

---------------------------------------------------------

function DebloqueGroup_Vague4()
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Protector_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Destroyer_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_23"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: Vague 5 :::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function AliveVague4()
	_nAliveGrp_Camp1_UAN_House2 = AliveMembersCount(GetGroupID("Grp_Camp1_UAN_House2"))
	_bAliveChar_Camp1_UAN_Trooper_20 = IsAlive(GetCharacterID("Char_Camp1_UAN_Trooper_20"))
	_bAliveChar_Camp1_UAN_Trooper_23 = IsAlive(GetCharacterID("Char_Camp1_UAN_Trooper_25"))


	if (_bAliveChar_Camp1_UAN_Trooper_20 == true) then
		_nAliveChar_Camp1_UAN_Trooper_20 = 1
	else
		_nAliveChar_Camp1_UAN_Trooper_20 = 0		
	end

	if (_bAliveChar_Camp1_UAN_Trooper_23 == true) then
		_nAliveChar_Camp1_UAN_Trooper_23 = 1
	else
		_nAliveChar_Camp1_UAN_Trooper_23 = 0		
	end

	_nTotalAliveVague4 = (_nAliveGrp_Camp1_UAN_House2 + _nAliveChar_Camp1_UAN_Trooper_23)

	if ((_nTotalAliveVague4 <= 1) and (_bCtrlTotalAliveVague4a == false)) then
		CreationTimer(true, true, false, "SpawnVague5",2)	
		_bCtrlTotalAliveVague4a = true
	end

	if ((_nTotalAliveVague4 <= 0) and (_bCtrlTotalAliveVague4b == false) and (_bPlayerBunker == false)) then
		_bCtrlTotalAliveVague4b = true
		Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_21"), false)
	end

end

--20

function SpawnVague5()
	StopMusic()
	UnLockDoor(GetDoorID("Door_Hangar_Double_2_1"))
	UnLockDoor(GetDoorID("Door_Hangar_Double_2_2"))
	UnLockDoor(GetDoorID("Door_Hangar_Double_2_3"))
	UnLockDoor(GetDoorID("Door_Hangar_Double_2_4"))
	OpenDoor(GetDoorID("Door_Hangar_Double_2_1"))
	OpenDoor(GetDoorID("Door_Hangar_Double_2_2"))
	OpenDoor(GetDoorID("Door_Hangar_Double_2_3"))
	OpenDoor(GetDoorID("Door_Hangar_Double_2_4"))
	FreezeAll(GetGroupID("Grp_Camp1_UAN_House4"), false)
	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_27"), false)
	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_28"), false)
--	CreationTimer(true, true, false, "DebloqueGroup_Vague5",10)
end

---------------------------------------------------------

function DebloqueGroup_Vague5()
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Protector_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Destroyer_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Protector_6"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Destroyer_6"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_27"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_28"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: Exo :::::::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function AliveVague5()
	_nAliveGrp_Camp1_UAN_House4 = AliveMembersCount(GetGroupID("Grp_Camp1_UAN_House4"))

	_nTotalAliveVague5 = (_nAliveGrp_Camp1_UAN_House4)

	if ((_nTotalAliveVague5 <= 2) and (_bCtrlTotalAliveVague5a == false)) then
		SetVarValue(GetExoskeletonID("Exo_Camp1"), "Freeze", false)
		Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_22"), false)
		FreezeAll(GetGroupID("Grp_Camp1_UAN_29_30"), false)
		_bCtrlTotalAliveVague5a = true
		CreationTimer(true, true, false, "CamExoCamp1",2)
	--	TestPlayerExoCamp1()
	end

end

function CamExoCamp1()
		UnLockDoor(GetDoorID("Door_Hangar_BigA"))
		OpenDoor(GetDoorID("Door_Hangar_BigA"))	
		UnLockDoor(GetDoorID("Door_Hangar_BigB"))
		OpenDoor(GetDoorID("Door_Hangar_BigB"))
		LaunchCameraTransition(GetCamTransitionID("CamTransition_Camp1_Exo"))
		StartMusic("Sounds//Music//BoS - Little theme 2.wav", false)
 -- 	PauseMusic()
 --		StopMusic()
 --		StartMusic()
		EnableCharacterCommand(_idPlayer,false)
		SetGodMode(_idPlayer,true)
		SetGodMode(_idMerc[0],true)

		ShowCinematicBlackStripes(true)

		if (IsEntityInBox(_idPlayer,"SE_BoxCineExoCamp1")) then
			Teletransportation("Repere_Player3",_idPlayer)			
		end
		if (_idMerc[1] ~= nil) then 
			SetGodMode(_idMerc[1],true)
			if (IsEntityInBox(_idMerc[1],"SE_BoxCineExoCamp1")) then
				Teletransportation("Repere_Merc5",_idMerc[1])			
			end
		end
		if (_idMerc[0] ~= nil) then
			SetGodMode(_idMerc[0],true) 
			if (IsEntityInBox(_idMerc[0],"SE_BoxCineExoCamp1")) then
				Teletransportation("Repere_Merc5",_idMerc[0])			
			end
		end
end

function CamExoCamp1b()
		LaunchCameraTransition(GetCamTransitionID("CamTransition_Camp1_Exo1"))
end

function EndCamTransCamp1Exo()
		ShowCinematicBlackStripes(false)
		SetGodMode(_idPlayer,false)
		EnableCharacterCommand(_idPlayer,true)
		_bTestPlayerExoCamp1 = true
	--	TestPlayerExoCamp1()
		if (_idMerc[1] ~= nil) then 
			SetGodMode(_idMerc[1],false)
		end
		if (_idMerc[0] ~= nil) then 
			SetGodMode(_idMerc[0],false)
		end
end

function TestPlayerExoCamp1()
	if (_bExoSorti == true) then
		if ((_bTestPlayerExoCamp1 == true) and (IsEntityInBox(_idPlayer,"SE_Player_Exo_Camp1")) ) then
			SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_22"),"ExoskeletonOrderList",GetAI_Order_ListID("AIOL_Camp1_Exo_Path"))	
		else
			SetVarValue(GetCharacterID("Char_Camp1_UAN_Trooper_22"),"ExoskeletonOrderList",GetAI_Order_ListID("AIOL_FA_Player_Exo"))	
		end
		CreationTimer(true, true, false, "TestPlayerExoCamp1",8)
	end
end

function OnEnter_SE_Player_Exo_Camp1(id)
	if ((id == GetCharacterID("Char_Camp1_UAN_Trooper_22")) and (_bCtrlSE_Player_Exo_Camp1 == false)) then
		_bExoSorti = true
		_bCtrlSE_Player_Exo_Camp1 = true
	 TestPlayerExoCamp1()
	end
end

function AliveVaguesAndExoCamp1()
	_bAliveChar_Camp1_UAN_Trooper_22 = IsAlive(GetCharacterID("Char_Camp1_UAN_Trooper_22"))

	if (_bAliveChar_Camp1_UAN_Trooper_22 == true) then
		_nAliveChar_Camp1_UAN_Trooper_22 = 1
	else
		_nAliveChar_Camp1_UAN_Trooper_22 = 0
		_bTestPlayerExoCamp1 = false
	end

	_nAliveGrp_Camp1_UAN_29_30 = AliveMembersCount(GetGroupID("Grp_Camp1_UAN_29_30"))

	_nTotalAliveCamp1 = (_nAliveChar_Camp1_UAN_Trooper_22 + _nAliveGrp_Camp1_UAN_1 + _nTotalAliveVague2 + _nTotalAliveVague3 + _nTotalAliveVague4 + _nTotalAliveVague5 + _nAliveGrp_Camp1_UAN_29_30)

	if ((_nTotalAliveCamp1 <= 0) and (_bCtrlFreezeChamp0 == false)) then
		SetVarValue(GetExoskeletonID("Exo_Camp2"), "Freeze", false)
		Freeze(_idChampion_0, false)
		_bCtrlFreezeChamp0 = true
	end
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: BoS :::::::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnEnter_SE_Camp1_Exo_Cine(id)
	if ((id == _idChampion_0) and (_bCtrlSE_Camp1_Exo_Cine == false)) then
		StartMusic("Sounds//Music//Bos - War theme.wav", false)
 -- 	PauseMusic()
 --		StopMusic()
 --		StartMusic()
		LaunchCameraTransition(GetCamTransitionID("CamTrans_Track_Exo_BoS"))
		ShowCinematicBlackStripes(true)
		Teletransportation("Repere_Player",_idPlayer)
			EnableCharacterCommand(_idPlayer, false)

				if (_idMerc[0] ~= nil) then 
					-- Télétransportation des Mercs en zone "sécurisée"
					Teletransportation("Repere_Merc0",_idMerc[0])
					Freeze(_idMerc[0],true)
					-- Disable les cmd du Merc 1
					EnableCharacterCommand(_idMerc[0], false)
				end

				if (_idMerc[1] ~= nil) then 
					-- Télétransportation des Mercs en zone "sécurisée"
					Teletransportation("Repere_Merc1",_idMerc[1])
					Freeze(_idMerc[1],true)
					-- Disable les cmd du Merc 1
					EnableCharacterCommand(_idMerc[1], false)
				end
		_bCtrlSE_Camp1_Exo_Cine = true
		_bExoBoSCine = true
	end
end





function ExpirTurtlesPlainA()
    if (_bExpirTurtlesPlainA == true) then
				return true
    end
 
    return false
end

function ExpirTurtlesPlainB()
    if (_bExpirTurtlesPlainB == true) then
				return true
    end
 
    return false
end

function OnEnter_SE_Camp1_ExpirTurtlesPlain1(id)
	if ((id == _idPlayer) and (_bCtrlSE_Camp1_ExpirTurtlesPlain1 == false)) then
		_bExpirTurtlesPlainA = true
		_bExpirTurtlesPlainB = true
		_bCtrlSE_Camp1_ExpirTurtlesPlain1 = true
	end
end

function OnEnter_SE_Camp1_ExpirTurtlesPlain2(id)
	if ((id == _idPlayer) and (_bCtrlSE_Camp1_ExpirTurtlesPlain2 == false)) then
		_bExpirTurtlesPlainA = true
		_bExpirTurtlesPlainB = true
		_bCtrlSE_Camp1_ExpirTurtlesPlain2 = true
	end
end

function OnEnter_SE_Camp1_ExpirTurtlesPlain3(id)
	if ((id == _idPlayer) and (_bCtrlSE_Camp1_ExpirTurtlesPlain3 == false)) then
		_bExpirTurtlesPlainA = true
		_bExpirTurtlesPlainB = true
		CreationTimer(true, true, false, "TimerExpirTurtle1",2)
		CreationTimer(true, true, false, "TimerExpirTurtle2",4)
		CreationTimer(true, true, false, "TimerExpirTurtle3",6)
		CreationTimer(true, true, false, "TimerExpirTurtle4",8)	
		_bCtrlSE_Camp1_ExpirTurtlesPlain3 = true		
	end
end

function TimerExpirTurtle1()
	SetVarValue(GetCharacterID("Char_UAN_Plain_10_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_UAN_Plain_10_1a"))
	SetVarValue(GetCharacterID("Char_UAN_Plain_10_6"),"CharacterOrderList",GetAI_Order_ListID("AIO_ExpirTurtlePlain"))
end

function TimerExpirTurtle2()
	SetVarValue(GetCharacterID("Char_UAN_Plain_10_4"),"CharacterOrderList",GetAI_Order_ListID("AIO_ExpirTurtlePlain"))
	SetVarValue(GetCharacterID("Char_UAN_Plain_10_7"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_UAN_Plain_10_7a"))
end

function TimerExpirTurtle3()
	SetVarValue(GetCharacterID("Char_UAN_Plain_10_2"),"CharacterOrderList",GetAI_Order_ListID("AIO_ExpirTurtlePlain"))
	SetVarValue(GetCharacterID("Char_UAN_Plain_10_3"),"CharacterOrderList",GetAI_Order_ListID("AIO_ExpirTurtlePlain"))
end

function TimerExpirTurtle4()
	SetVarValue(GetCharacterID("Char_UAN_Plain_10_5"),"CharacterOrderList",GetAI_Order_ListID("AIO_ExpirTurtlePlain"))
	SetVarValue(GetCharacterID("Char_UAN_Plain_10_8"),"CharacterOrderList",GetAI_Order_ListID("AIO_ExpirTurtlePlain"))
end

function ExpirWPExTurtles()
    if (_bExpirWPExTurtles == true) then
				return true
    end
 
    return false
end

function OnEnter_SE_Camp1_ExpirTurtlesPlain4(id)
	if ((id == _idPlayer) and (_bCtrlSE_Camp1_ExpirTurtlesPlain4 == false)) then
		_bExpirWPExTurtles = true
		_bCtrlSE_Camp1_ExpirTurtlesPlain4 = true
	end
end

function OnEnter_SE_Camp1_Exo_Open(id)
	if (id == _idChampion_0) and (_bCtrlSE_Camp1_Exo_Open == false) then
	UnLockDoor(GetDoorID("Door_Camp1_1"))
	OpenDoor(GetDoorID("Door_Camp1_1"))
	UnLockDoor(GetDoorID("Door_Camp1_2"))
	OpenDoor(GetDoorID("Door_Camp1_2"))
	_bCtrlSE_Camp1_Exo_Open = true
	end
end

function OnEnter_SE_Camp1_Exo_Stop(id)
	if ((id == _idChampion_0) and (_bCtrlSE_Camp1_Exo_Stop == false)) then
		SetVarValue(_idChampion_0, "ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Char_Champion_0a"))
		SetVarValue(_idChampion_0, "CharacterOrderList",GetInvalidEntityID())
		EnableCharacterCommand(_idChampion_0, false)
		_bCtrlSE_Camp1_Exo_Stop = true
	end
end

function TrackingCamExoBoS()
	if (_bExoBoSCine == true) then
		CamPointTargetCharacter(GetCamPointID("CamPoint_Track_Exo_BoS"),_idChampion_0)
	end
end

function TrackingCamExoBoS1()
	if (_bExoBoSCine == true) then
		CamPointTargetCharacter(GetCamPointID("CamPoint_Track_Exo_BoS1"),_idChampion_0)
	end
end

function TrackingCamExoBoS2()
	if (_bExoBoSCine == true) then
	--	CamPointTargetCharacter(_idCamPointExoBoS1,_idChampion_0)
	--	CamPointTargetCharacter(_idCamPointExoBoS2,_idChampion_0)
	end
end

function CamExoBoS2()
	LaunchCameraTransition(GetCamTransitionID("CamTrans_Exo_BoS"))
	Freeze(GetExoskeletonID("Exo_Camp1"), true)
end

function CamExoBoS3()
	LaunchCameraTransition(GetCamTransitionID("CamTrans_Exo_BoS1"))
end

function DeclencheBoS()
		StopMusic()
--		StartMusic("Sounds//Music//Bos - War theme.wav", true)
 -- 	PauseMusic()
 --		StopMusic()
 	--	StartMusic()

	LaunchBOS(0,"BoS_Setup","BoS_WarmUp", "CombatBOS", "BOS_End", "BoS_Lost", "BOS_End")
	
	ShowCinematicBlackStripes(false)
	_bActiveTestPlayerExoCamp1 = true
	CreationTimer(true, true, false, "ActiveShield_BoS_0",1.5)
end


function CombatBOS()
	g_bBoSEnCours = true
	SetGodMode(_idChampion_0,false)
--	SetVarValue(_idChampion_0, "CharacterOrderList", GetAI_Order_ListID("AIOL_FA_Player_BoS"))
	EnableCharacterCommand(_idChampion_0,true)
	EnableCharacterFire(_idChampion_0,true)
	EnableCharacterFire(_idPlayer,true)

	_bBoSEnCours = true

end

function ActiveShield_BoS_0()
	if (_idChampion_0 == GetCharacterID("Char_Champion_0_1")) then
		SetVarValue(GetPlug_MagneticShieldID("Plug_MagneticShield_Champion_0_1"),"Active", true)
	end
	if (_idChampion_0 == GetCharacterID("Char_Champion_0_2")) then
		SetVarValue(GetPlug_MagneticShieldID("Plug_MagneticShield_Champion_0_2"),"Active", true)
	end
	if (_idChampion_0 == GetCharacterID("Char_Champion_0_3")) then
		SetVarValue(GetPlug_MagneticShieldID("Plug_MagneticShield_Champion_0_3"),"Active", true)
	end
end

function BoS_Setup()
	SetVarValue(GetDoorID("Door_Camp1_1"),"Speed",100)
	SetVarValue(GetDoorID("Door_Camp1_2"),"Speed",100)
	CloseDoor(GetDoorID("Door_Camp1_1"))
	CloseDoor(GetDoorID("Door_Camp1_2"))
	LockDoor(GetDoorID("Door_Camp1_1"))
	LockDoor(GetDoorID("Door_Camp1_2"))
	_bCtrlBoSEnCours = true

end

function BoS_WarmUp()
	SetGodMode(_idChampion_0,true)
	EnableCharacterCommand(_idChampion_0,false)
	EnableCharacterCommand(_idPlayer,true)
	EnableCharacterFire(_idPlayer,false)
	EnableCharacterFire(_idChampion_0,false)
	if (_idChampion_0 == GetCharacterID("Char_Champion_0_1")) then
		SetVarValue(_idChampion_0,"CharacterAI",GetCharacter_AIID("Patrol_Char_AI_Champion_0_1"))
	end
	if (_idChampion_0 == GetCharacterID("Char_Champion_0_2")) then
		SetVarValue(_idChampion_0,"CharacterAI",GetCharacter_AIID("Patrol_Char_AI_Champion_0_2"))
	end
	if (_idChampion_0 == GetCharacterID("Char_Champion_0_3")) then
		SetVarValue(_idChampion_0,"CharacterAI",GetCharacter_AIID("Patrol_Char_AI_Champion_0_3"))
	end
end

function BOS_End()
	UnLockDoor(GetDoorID("Door_Camp1_1"))
	UnLockDoor(GetDoorID("Door_Camp1_2"))
	OpenDoor(GetDoorID("Door_Camp1_1"))
	OpenDoor(GetDoorID("Door_Camp1_2"))
		--	NewObjectiveNewSubObjective("Obj_A","Obj_A_1")
		NewSubObjective ("Obj_A_1","Obj_A_2")
		Freeze(_idChampion_0,true)
		g_bBoSEnCours = false
				if (_idMerc[0] ~= nil) then 
					-- Disable les cmd du Merc 1
					Freeze(_idMerc[0],false)
					EnableCharacterCommand(_idMerc[0],true)
				end

				if (_idMerc[1] ~= nil) then 
					-- Disable les cmd du Merc 1
					Freeze(_idMerc[1],false)
					EnableCharacterCommand(_idMerc[1],true)
				end
		_bBoSEnCours = false
		StopMusic()
--		StartMusic("Sounds//Music//BoS - Twilight theme.wav", true)
 -- 	PauseMusic()
 --		StopMusic()
 --		StartMusic()

end


function TestPlayerExoDuringBoS()

	if (_bCtrlBoSEnCours == true) then
		_bIsPlayerInExo = IsAValidID(GetCharacterCurrentExoskeleton(_idPlayer))

		if ((_bIsPlayerInExo == true) and (_bCtrlDejaJoue1 == false)) then
			SetVarValue(_idChampion_0, "CharacterOrderList", GetAI_Order_ListID("AIOL_Path_BOS_Camp1"))
			EnableCharacterCommand(_idChampion_0,true)
			_bCtrlDejaJoue1 = true
		elseif ((_bIsPlayerInExo == false) and (_bCtrlDejaJoue1 == true)) then
			if (_idChampion_0 == GetCharacterID("Char_Champion_0_2")) then
				SetVarValue(_idChampion_0, "CharacterOrderList", GetAI_Order_ListID("AIOL_Champion_02_Combat"))
			end

			if (_idChampion_0 == GetCharacterID("Char_Champion_0_1")) then
				SetVarValue(_idChampion_0, "CharacterOrderList", GetAI_Order_ListID("AIOL_Champion_01_Combat"))
			end

			if (_idChampion_0 == GetCharacterID("Char_Champion_0_3")) then
				SetVarValue(_idChampion_0, "CharacterOrderList", GetAI_Order_ListID("AIOL_Champion_03_Combat"))
			end
			_bCtrlDejaJoue1 = false
		end		
	end
end

function ActiveDesactiveMagneticSHield()
--_idChampion_0 == GetCharacterID("Char_Champion_0_3")
	if (_idChampion_0 == GetCharacterID("Char_Champion_0_3")) then

		_bChampion_03_Reload = GetIsReloading(_idChampion_0)

		if ((_bChampion_03_Reload == true) and (_bBoSEnCours == true) and (_CrtActiveDesactiveMagneticSHield == true)) then
			SetVarValue(GetPlug_MagneticShieldID("Plug_MShield_Champion_0_3"),"Active", false)
			_CrtActiveDesactiveMagneticSHield = false
		end

		if ((_bChampion_03_Reload == false) and (_bBoSEnCours == true) and (_CrtActiveDesactiveMagneticSHield == false)) then
			SetVarValue(GetPlug_MagneticShieldID("Plug_MShield_Champion_0_3"),"Active", true)
			_CrtActiveDesactiveMagneticSHield = true
		end
	end
end

function RandomThrowGrenade()
	if (_bSpeedGrenade == true) then
		SetVarValue(GetCharacter_AIID("Patrol_Char_AI_Champion_0_2"),"ThrowGrenadeRetryTime",0)
		_bSpeedGrenade = false
		if (_bBoSEnCours == true) then
			CreationTimer(true, true, false, "RandomThrowGrenade",20)
		end
	else
		SetVarValue(GetCharacter_AIID("Patrol_Char_AI_Champion_0_2"),"ThrowGrenadeRetryTime",-1)
		_bSpeedGrenade = true
		if (_bBoSEnCours == true) then
			CreationTimer(true, true, false, "RandomThrowGrenade",8)
		end
	end
end

function OnEnter_SE_Camp1_FZ_Entree(id)
	if ((id == _idPlayer) and (_bCtrlSE_Camp1_FZ_Entree == false)) then
		FreezeAll(GetGroupID("Grp_UAN_Plain_10"), false)
		FreezeAll(GetGroupID("Grp_UAN_Plain_16"), false)
		FreezeAll(GetGroupID("Grp_Camp1_UAN_Sniper_1"), false)
		CreationTimer(true, true, false, "DesactivTurtles",10)
		_bCtrlSE_Camp1_FZ_Entree = true
	end
end

function DesactivTurtles()
	_idExoPlayerPlain = GetCharacterCurrentExoskeleton(_idPlayer)
	if (_idExoPlayerPlain == GetInvalidEntityID()) then
--		SetVarValue(GetGroupID("Grp_UAN_Plain_10"),"GroupAIOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
--		SetVarValue(GetGroupID("Grp_UAN_Plain_16"),"GroupAIOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
			SetVarValue(GetCharacterID("Char_UAN_Plain_10_1"),"CharacterOrderList",GetInvalidEntityID())
			SetVarValue(GetCharacterID("Char_UAN_Plain_10_2"),"CharacterOrderList",GetInvalidEntityID())
			SetVarValue(GetCharacterID("Char_UAN_Plain_10_3"),"CharacterOrderList",GetInvalidEntityID())
			SetVarValue(GetCharacterID("Char_UAN_Plain_10_4"),"CharacterOrderList",GetInvalidEntityID())
			SetVarValue(GetCharacterID("Char_UAN_Plain_10_5"),"CharacterOrderList",GetInvalidEntityID())
			SetVarValue(GetCharacterID("Char_UAN_Plain_10_6"),"CharacterOrderList",GetInvalidEntityID())
			SetVarValue(GetCharacterID("Char_UAN_Plain_10_7"),"CharacterOrderList",GetInvalidEntityID())
			SetVarValue(GetCharacterID("Char_UAN_Plain_10_8"),"CharacterOrderList",GetInvalidEntityID())
	end
end

function OnEnter_SE_Plain_TANKS(id)
	if (id == _idPlayer) then
		SetVarValue(GetTankID("Tank_1"),"Rotation Speed",180)
		SetVarValue(GetTankID("Tank_1"),"Shoot Delay",0.5)
		SetVarValue(GetTankID("Tank_2"),"Rotation Speed",180)
		SetVarValue(GetTankID("Tank_2"),"Shoot Delay",0.5)
	end
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Bunker ::::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnEnter_SE_Camp1_Trigger_3(id)
	if ((id == _idPlayer) and (_bCtrlSE_Camp1_Trigger_3 == false)) then
		_bPlayerBunker = true
		Freeze(GetCharacterID("Char_Camp1_UAN_Sniper_1"), false)
		_bCtrlSE_Camp1_Trigger_3 = true
		if (_nBotActive <= 8)  then
			FreezeAll(GetGroupID("Grp_Camp1_UAN_Bunker"),false)
		end
	end
end



