function TrackingCams()
	TrackingCamPoint_1_1()
	TrackingCamPoint_1_2()
	TrackingCamPoint_1_3()
	TrackingCamPoint_1_3b()
	TrackingCamPoint_1_6()
	TrackingCamPoint_1_7()
	TrackingCamPoint_1_7b()
	TrackingCamPoint_Soldats2_1_1()
	TrackingCamPoint_Soldats2_1_2()
	TrackingCamPoint_2_1()
	TrackingCamPoint_2_2()
	TrackingCamPoint_2_3()
	TrackingCamPoint_2_3b()
	TrackingCamPoint_Ours_01_1()
	TrackingCamPoint_Ours_01_2()
	TrackingCamPoint_Ours_02_1()
	TrackingCamPoint_Ours_02_2()
	TrackingCamPoint_Syndic_5()
	TrackingCamPoint_Syndic_6()
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Global ::::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function EnableCharCmd()
	EnableCharacterCommand(_idPlayer, true)
end

function DisableCharCmd()
	EnableCharacterCommand(_idPlayer, false)
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: Sequence Soldats 01 A :::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function CamAsc1_1()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc1_1"))
	EnableCharacterCommand(_idPlayer, false)
	SetGodMode(_idPlayer,true)
	ShowCinematicBlackStripes(true)
	UnLockDoor(GetDoorID("Door_Asc1_1"))
--	UnLockDoor(GetDoorID("Door_Asc1_2"))
	OpenDoor(GetDoorID("Door_Asc1_1"))
--	OpenDoor(GetDoorID("Door_Asc1_2"))
end

function TrackingCamPoint_1_1()
	CamPointTargetCharacter(GetCamPointID("CamPoint_1_1"),GetCharacterID("Repere_Asc_1_1"))
end

function TrackingCamPoint_1_2()
	CamPointTargetCharacter(GetCamPointID("CamPoint_1_2"),GetCharacterID("Repere_Asc_1_1"))
end

function TrackingCamPoint_1_3()
	CamPointTargetCharacter(GetCamPointID("CamPoint_1_3"),GetCharacterID("Repere_Asc_1_7"))
end

function TrackingCamPoint_1_3b()
	CamPointTargetCharacter(GetCamPointID("CamPoint_1_3b"),GetCharacterID("Repere_Asc_1_7"))
end

function CamAsc1_2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc1_2"))
	SetGodMode(_idPlayer,true)
end

function CamAsc1_3()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc1_3"))
	SetGodMode(_idPlayer,true)

end

function CamAsc1_4()

	----------
	_idChar_Syndic_Soldats_01_1=GetCharacterID("Char_Syndic_Soldats_01_1")
	_idChar_Syndic_Soldats_01_2=GetCharacterID("Char_Syndic_Soldats_01_2")
	_idChar_Syndic_Soldats_01_3=GetCharacterID("Char_Syndic_Soldats_01_3")
	_idChar_Syndic_Soldats_01_4=GetCharacterID("Char_Syndic_Soldats_01_4")

	---------

	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc1_4"))
	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_01_1, "STAND COMPLETE BOS VICTORY_ARM_UP W_ALL_2HAND_HEAVY", true, false)
	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_01_2, "STAND COMPLETE WAIT W_NONE COOL", true, false)
	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_01_3, "STAND COMPLETE BOS COME W_ALL_2HAND_LIGHT", true, false)
	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_01_4, "STAND COMPLETE BOS NECK_CUT_SLOWLY W_ALL_2HAND_LIGHT", true, false)
	SetGodMode(_idPlayer,true)
end

function CamAsc1_5()
--	CamPointTargetCharacter(GetCamPointID("CamPoint_1_6"),GetCharacterID("Char_Syndic_Soldats_01_1"))
--	CamPointTargetCharacter(GetCamPointID("CamPoint_1_7"),GetCharacterID("Char_Syndic_Soldats_01_1"))
--	CamPointTargetCharacter(GetCamPointID("CamPoint_1_7b"),GetCharacterID("Char_Syndic_Soldats_01_1"))
	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_01_3, "STAND COMPLETE BOS COME W_ALL_2HAND_LIGHT", true, false)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc1_5"))
	SetGodMode(_idPlayer,true)
end

function CamAsc1_6()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc1_6"))
	SetGodMode(_idPlayer,true)
end

function TrackingCamPoint_1_6()
	CamPointTargetCharacter(GetCamPointID("CamPoint_1_6"),GetCharacterID("Char_Syndic_Soldats_01_3"))
end

function TrackingCamPoint_1_7()
	CamPointTargetCharacter(GetCamPointID("CamPoint_1_7"),GetCharacterID("Char_Syndic_Soldats_01_3"))
end

function TrackingCamPoint_1_7b()
	CamPointTargetCharacter(GetCamPointID("CamPoint_1_7b"),GetCharacterID("Char_Syndic_Soldats_01_3"))
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Sequence Soldats 01 B :::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------


function TrackingCamPoint_2_1()
	CamPointTargetCharacter(GetCamPointID("CamPoint_2_1"),GetCharacterID("Repere_Asc_2_1"))
end

function TrackingCamPoint_2_2()
	CamPointTargetCharacter(GetCamPointID("CamPoint_2_2"),GetCharacterID("Repere_Asc_2_1"))
end

function CamAsc2_1()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc2_1"))
	EnableCharacterCommand(_idPlayer, false)
	SetGodMode(_idPlayer,true)
	ShowCinematicBlackStripes(true)
	UnLockDoor(GetDoorID("Door_Asc2_1"))
	OpenDoor(GetDoorID("Door_Asc2_1"))
end

function CamAsc2_2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc2_2"))
	SetGodMode(_idPlayer,true)
end

function TrackingCamPoint_2_3()
	CamPointTargetCharacter(GetCamPointID("CamPoint_2_3"),GetCharacterID("Repere_Asc_1_8"))
end

function TrackingCamPoint_2_3b()
	CamPointTargetCharacter(GetCamPointID("CamPoint_2_3b"),GetCharacterID("Repere_Asc_1_8"))
end

function CamAsc2_3()

	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc2_3"))
	SetGodMode(_idPlayer,true)

	_idChar_Syndic_Soldats_01_1=GetCharacterID("Char_Syndic_Soldats_01_1")
	_idChar_Syndic_Soldats_01_2=GetCharacterID("Char_Syndic_Soldats_01_2")
	_idChar_Syndic_Soldats_01_3=GetCharacterID("Char_Syndic_Soldats_01_3")
	_idChar_Syndic_Soldats_01_4=GetCharacterID("Char_Syndic_Soldats_01_4")

	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_01_1, "STAND COMPLETE WAIT W_NONE COOL", true, false)
	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_01_2, "STAND COMPLETE WAIT W_NONE COOL", true, false)
	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_01_3, "STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL", true, false)
	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_01_4, "STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL", true, false)

end

function CamAsc2_4()

	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc2_4"))
	SetGodMode(_idPlayer,true)
	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_01_1, "STAND COMPLETE BOS VICTORY_ARM_UP W_ALL_2HAND_HEAVY", true, false)
	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_01_2, "STAND COMPLETE WAIT W_NONE COOL", true, false)
	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_01_3, "STAND COMPLETE BOS HIT_CHEST W_ALL_2HAND_LIGHT", true, false)
	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_01_4, "STAND COMPLETE BOS PROVOC_RAP W_ALL_2HAND_LIGHT", true, false)
end

function CamAsc2_5()

	CamPointTargetCharacter(GetCamPointID("CamPoint_2_6"),GetCharacterID("Char_Syndic_Soldats_01_1"))
	CamPointTargetCharacter(GetCamPointID("CamPoint_2_7"),GetCharacterID("Char_Syndic_Soldats_01_1"))
	CamPointTargetCharacter(GetCamPointID("CamPoint_2_7b"),GetCharacterID("Char_Syndic_Soldats_01_1"))
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc2_5"))
	SetGodMode(_idPlayer,true)
end

function CamAsc2_6()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc2_6"))
	SetGodMode(_idPlayer,true)
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Sequence Soldats 02 et 03 :::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function TrackingCamPoint_Soldats2_1_1()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Soldats2_1_1"),GetCharacterID("Repere_Asc_2_1"))
end


function TrackingCamPoint_Soldats2_1_2()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Soldats2_1_2"),GetCharacterID("Repere_Asc_2_1"))
end

function CamSoldats_02()

	------
	_idChar_Syndic_Soldats_02_1=GetCharacterID("Char_Syndic_Soldats_02_1")
	------

	LaunchCameraTransition(GetCamTransitionID("CamTransition_CamSoldats_02"))
	ShowCinematicBlackStripes(true)
	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_02_1, "STAND MEDHI ORDER_FOLLOW_ME W_NONE", true, false)
	SetGodMode(_idPlayer,true)

	UnLockDoor(GetDoorID("Door_Asc2_1"))
--	UnLockDoor(GetDoorID("Door_Asc2_2"))
	OpenDoor(GetDoorID("Door_Asc2_1"))
--	OpenDoor(GetDoorID("Door_Asc2_2"))
end

function CamSoldats_03()

	------
	_idChar_Syndic_Soldats_03_1=GetCharacterID("Char_Syndic_Soldats_03_1")
	------
	LaunchCameraTransition(GetCamTransitionID("CamTransition_CamSoldats_03"))
	CharacterPlaySpecialAction(_idChar_Syndic_Soldats_03_1, "STAND MEDHI ORDER_GO W_NONE", true, false)
	SetGodMode(_idPlayer,true)

	UnLockDoor(GetDoorID("Door_Asc1_1"))
--	UnLockDoor(GetDoorID("Door_Asc1_2"))
	OpenDoor(GetDoorID("Door_Asc1_1"))
--	OpenDoor(GetDoorID("Door_Asc1_2"))
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: SequenceParas ::::::::::;::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function CamParas1_1()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Paras_01"))
	ShowCinematicBlackStripes(true)
end

function CamParas1_2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Paras_02"))
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Sequence Ours :::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function TrackingCamPoint_Ours_01_1()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Ours_01_1"),GetCharacterID("Char_Syndic_Ours_1"))
end

function TrackingCamPoint_Ours_01_2()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Ours_01_2"),GetCharacterID("Char_Syndic_Ours_1"))
end

function TrackingCamPoint_Ours_02_1()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Ours_02_1"),GetCharacterID("Char_Syndic_Ours_2"))
end

function TrackingCamPoint_Ours_02_2()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Ours_02_2"),GetCharacterID("Char_Syndic_Ours_2"))
end

function CamOurs_1()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Ours_01"))
	ShowCinematicBlackStripes(true)
end

function CamOurs_2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Ours_02"))
	CreationTimer(true, true, false, "ActiveShieldOurs2", 3.5)
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Sequence Snipers 01 et 02 :::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function CamSnipers_01()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Snipers_01"))
	ShowCinematicBlackStripes(true)
	UnLockDoor(GetDoorID("Door_Asc1_1"))
--	UnLockDoor(GetDoorID("Door_Asc1_2"))
	OpenDoor(GetDoorID("Door_Asc1_1"))
--	OpenDoor(GetDoorID("Door_Asc1_2"))
end

function CamSnipers_01b()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Snipers_01b"))

	CloseDoor(GetDoorID("Door_Asc2_1"))
--	CloseDoor(GetDoorID("Door_Asc2_2"))
	LockDoor(GetDoorID("Door_Asc2_1"))
--	LockDoor(GetDoorID("Door_Asc2_2"))
end

function CamSnipers_02()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Snipers_02"))

end

function CamSnipers_02b()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Snipers_02b"))
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Sequence Kenyans 01 :::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function CamAsc1_1bis()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc1_1bis"))
end

function CamAsc1_2bis()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc1_2bis"))
--	ShowCinematicBlackStripes(true)
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Sequence Kenyans 02 :::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function CamAsc2_1bis()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc2_1bis"))
	UnLockDoor(GetDoorID("Door_Asc1_1"))
--	UnLockDoor(GetDoorID("Door_Asc1_2"))
	OpenDoor(GetDoorID("Door_Asc1_1"))
--	OpenDoor(GetDoorID("Door_Asc1_2"))
end

function CamAsc2_2bis()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Asc2_2bis"))
	UnLockDoor(GetDoorID("Door_Asc2_1"))
--	UnLockDoor(GetDoorID("Door_Asc2_2"))
	OpenDoor(GetDoorID("Door_Asc2_1"))
--	OpenDoor(GetDoorID("Door_Asc2_2"))
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Sequence Cubains ::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function CamCubains1()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Cubains_01"))
	UnLockDoor(GetDoorID("Door_Asc1_1"))
--	UnLockDoor(GetDoorID("Door_Asc1_2"))
	OpenDoor(GetDoorID("Door_Asc1_1"))
--	OpenDoor(GetDoorID("Door_Asc1_2"))
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Sequence Boucher ::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function CamBoucher1()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Boucher_1"))
--	ShowCinematicBlackStripes(true)
end

function CamBoucher2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Boucher_2"))
--	CamPointTargetCharacter(GetCamPointID("CamPoint_Boucher_3"),GetCharacterID("Char_Syndic_Boucher"))
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Boucher"), true)
end

function CamBoucher3()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Boucher_3"))
--	CamPointTargetCharacter(GetCamPointID("CamPoint_Boucher_3"),GetCharacterID("Char_Syndic_Boucher"))
--	CamPointTargetCharacter(GetCamPointID("CamPoint_Boucher_4"),GetCharacterID("Char_Syndic_Boucher"))
	SetVarValue(GetPlug_MagneticShieldID("Plug_MagneticShield_Boucher"),"Active",true)
end

function CamBoucher4()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Boucher_4"))
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Sequence Resistants :::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function CamResist1()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Resist_1"))
	ShowCinematicBlackStripes(true)
end

function CamResist2()
	AIOL_Syndic_1a()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Resist_2"))
	Freeze(GetCharacterID("Char_Hoshaiming"), false)
	CreationTimer(true, true, false, "AIOL_Syndic",3)
end

function CamResist3()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Resist_3"))
	EnableCharacterCommand(GetCharacterID("Char_Hoshaiming"), true)
end


function TrackingCamPoint_Syndic_5()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Syndic_5"),GetCharacterID("Char_Hoshaiming"))
end
function TrackingCamPoint_Syndic_6()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Syndic_6"),GetCharacterID("Char_Hoshaiming"))
end
function CamResist4()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Resist_4"))
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Position Player Cine ::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function Where_Is_Player_Cine()
	if (
	(IsEntityInBox(_idPlayer,"SE_TP_Player_Asc1"))
	or (IsEntityInBox(_idPlayer,"SE_TP_Player_Asc2"))
	) then
		_bWhere_Is_Player_Cine = 1
	else
		_bWhere_Is_Player_Cine = 0	
	end
end

function TP_Player_Cine()
	if (_bWhere_Is_Player_Cine == 1) then
		Teletransportation("Repere_Player",_idPlayer)
		if (_idMerc[0] ~= nil) then
			Teletransportation("Repere_Igor",_idMerc[0])
		end
	end
end


function Where_Is_Player_Cine2()
	if (
	(IsEntityInBox(_idPlayer,"SE_TP_Player_Asc3"))
	) then
		_bWhere_Is_Player_Cine2 = 1
	else
		_bWhere_Is_Player_Cine2 = 0	
	end
end

function TP_Player_Cine2()
	if (_bWhere_Is_Player_Cine2 == 1) then
		Teletransportation("Repere_Player",_idPlayer)
		if (_idMerc[0] ~= nil) then
			Teletransportation("Repere_Igor",_idMerc[0])
		end
	end
end