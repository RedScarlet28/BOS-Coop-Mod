------------------------------------------------------------
------------------------------------------------------------

-- ::: InitLevel :::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function InitLevelPhase1()
	_bCtrlSE_Phase1_Trigger_1 = false
	_bCtrlSE_Phase1_Trigger_2 = false
	_nPlayerZone = 0
	_bCtrlSE_Phase1_Zone_1 = false
	_bCtrlSE_Phase1_Zone_2 = false
	_bCtrlMiniBoS1 = false
	_bCtrlMiniBoS2 = false
	_bCtrlMiniBoS3 = false
	_bCtrlMiniBoS4 = false
	_CtrlChar_Phase1_Resist_Sniper_1 = false
	_CtrlChar_Phase1_Resist_Sniper_2 = false
	_CtrlChar_Phase1_Resist_Sniper_3 = false
	_CtrlChar_Phase1_Resist_Sniper_4 = false
	_CtrlChar_Phase1_Resist_Sniper_5 = false
	_CtrlChar_Phase1_Resist_Sniper_6 = false
	_CtrlChar_Phase1_Resist_Sniper_7 = false
	_CtrlChar_Phase1_Resist_Sniper_8 = false
	_CtrlChar_Phase1_Resist_Sniper_9 = false
	_CtrlChar_Phase1_Resist_Sniper_10 = false
	_CtrlChar_Phase1_Resist_Sniper_11a = false
	_CtrlChar_Phase1_Resist_Sniper_11b = false
	_CtrlChar_Phase1_Resist_Sniper_12 = false
	_CtrlChar_Phase1_Resist_Sniper_13 = false
	_CtrlChar_Phase1_Resist_Sniper_14 = false
	_CtrlChar_Phase1_Resist_Sniper_15 = false
	_CtrlChar_Phase1_Resist_Trooper_1 = false
	_CtrlChar_Phase1_Resist_Trooper_2 = false
	_CtrlChar_Phase1_Resist_Trooper_3 = false
	_CtrlChar_Phase1_Resist_Trooper_4 = false
	_CtrlChar_Phase1_Resist_Trooper_5 = false
	_CtrlChar_Phase1_Resist_Trooper_6 = false
	_CtrlChar_Phase1_Resist_Trooper_7 = false
	_CtrlChar_Phase1_Resist_Trooper_8 = false
	_CtrlChar_Phase1_Resist_Trooper_9 = false
	_CtrlChar_Phase1_Resist_Trooper_10 = false
	_bCtrlEndE3 = false
	_bAliveMiniBoS1 = true
	_bAliveMiniBoS2 = true
	_bAliveMiniBoS3 = true
	_bAliveMiniBoS4 = true
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: UpdateLevel :::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function UpdateLevelPhase1()
Change_Bot_behavior ("Char_Phase1_Resist_Trooper_1",80,50,"AIOL_FA_Player")
Change_Bot_behavior ("Char_Phase1_Resist_Trooper_2",80,50,"AIOL_FA_Player")
Change_Bot_behavior ("Char_Phase1_Resist_Trooper_3",80,50,"AIOL_FA_Player")
Change_Bot_behavior ("Char_Phase1_Resist_Trooper_4",80,50,"AIOL_FA_Player")
Change_Bot_behavior ("Char_Phase1_Resist_Trooper_5",80,50,"AIOL_FA_Player")

TestZonePlayer()

AliveTroopers_Part1()
AliveTroopers_Part2()
EndE3()
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Warfield Part1 ::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnEnter_SE_Phase1_Trigger_1(id)
	if ((id == _idPlayer) and (_bCtrlSE_Phase1_Trigger_1 == false)) then

--		SetVarValue(_idChar_Ami_1,"CharacterOrderList",GetAI_Order_ListID("AIOL_Ami_1"))
--		SetVarValue(_idChar_Ami_2,"CharacterOrderList",GetAI_Order_ListID("AIOL_Ami_2"))
		Freeze(GetCharacterID("Char_Phase1_Resist_Sniper_1"), false)
		Freeze(GetCharacterID("Char_Phase1_Resist_Sniper_11a"), false)
		_bCtrlSE_Phase1_Trigger_1 = true

			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
				StartMusic("Sounds//Music//BoS - Resistance theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Eradication theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Twilight theme.wav", true)
			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 1.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav", true)
	
				 -- 	PauseMusic()
				 --		StopMusic()
				 --		StartMusic(
	end
end


function OnEnter_SE_Phase1_Trigger_2(id)
	if ((id == _idPlayer) and (_bCtrlSE_Phase1_Trigger_2 == false)) then

		SetVarValue(GetCharacterID("Char_Phase1_Resist_Trooper_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Phase1_Resist_Trooper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Phase1_Resist_Trooper_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))

		_bCtrlSE_Phase1_Trigger_2 = true
	end
end

function AliveTroopers_Part1()
	_bAliveChar_Phase1_Resist_Trooper_1 = IsAlive(GetCharacterID("Char_Phase1_Resist_Trooper_1"))
	_bAliveChar_Phase1_Resist_Trooper_2 = IsAlive(GetCharacterID("Char_Phase1_Resist_Trooper_2"))
	_bAliveChar_Phase1_Resist_Trooper_4 = IsAlive(GetCharacterID("Char_Phase1_Resist_Trooper_4"))
	_bAliveChar_Phase1_Resist_Trooper_5 = IsAlive(GetCharacterID("Char_Phase1_Resist_Trooper_5"))

	_bAliveChar_Phase1_Resist_Sniper_1 = IsAlive(GetCharacterID("Char_Phase1_Resist_Sniper_1"))
	_bAliveChar_Phase1_Resist_Sniper_11a = IsAlive(GetCharacterID("Char_Phase1_Resist_Sniper_11a"))

	if ((_bAliveChar_Phase1_Resist_Trooper_1 == false) and (_nPlayerZone == 1) and (_CtrlChar_Phase1_Resist_Trooper_6 == false))  then
		Freeze(GetCharacterID("Char_Phase1_Resist_Trooper_6"), false)
		_CtrlChar_Phase1_Resist_Trooper_6 = true
	elseif ((_bAliveChar_Phase1_Resist_Trooper_1 == false) and (_nPlayerZone == 2) and (_bCtrlMiniBoS1 == false)) then
		_idMiniBoS1 = GetCharacterID("Char_Phase1_Resist_MiniBoS_1")
		Freeze(_idMiniBoS1, false)
		Teletransportation("Char_Repere_Door1",_idMiniBoS1)
		_bCtrlMiniBoS1 = true
	end

	if ((_bAliveChar_Phase1_Resist_Trooper_2 == false) and (_CtrlChar_Phase1_Resist_Sniper_11b == false)) then
		Freeze(GetCharacterID("Char_Phase1_Resist_Sniper_11b"), false)
		_idChar_Phase1_Resist_Sniper_11b = GetCharacterID("Char_Phase1_Resist_Sniper_11b")
		_CtrlChar_Phase1_Resist_Sniper_11b = true
		if (_nPlayerZone == 2) then
			Teletransportation("Char_Repere_Door1",_idChar_Phase1_Resist_Sniper_11b)
		elseif (_nPlayerZone == 1) then
			Teletransportation("Char_Repere_Door2",_idChar_Phase1_Resist_Sniper_11b)
		end
	end

	if ((_bAliveChar_Phase1_Resist_Trooper_5 == false) and (_CtrlChar_Phase1_Resist_Trooper_7 == false)) then
		Freeze(GetCharacterID("Char_Phase1_Resist_Trooper_7"), false)
		_idChar_Phase1_Resist_Sniper_7 = GetCharacterID("Char_Phase1_Resist_Trooper_7")
		_CtrlChar_Phase1_Resist_Trooper_7 = true
		if (_nPlayerZone == 2) then
			Teletransportation("Char_Repere_Door3",_idChar_Phase1_Resist_Sniper_7)
		elseif (_nPlayerZone == 1) then
			Teletransportation("Char_Repere_Door5",_idChar_Phase1_Resist_Sniper_7)
		end
	end

	if ((_bAliveChar_Phase1_Resist_Trooper_4 == false) and (_CtrlChar_Phase1_Resist_Trooper_6 == false)) then
		Freeze(GetCharacterID("Char_Phase1_Resist_Trooper_6"), false)
		_idChar_Phase1_Resist_Sniper_6 = GetCharacterID("Char_Phase1_Resist_Trooper_6")
		_CtrlChar_Phase1_Resist_Trooper_6 = true
		if (_nPlayerZone == 2) then
			Teletransportation("Char_Repere_Door4",_idChar_Phase1_Resist_Sniper_6)
		elseif (_nPlayerZone == 1) then
			Teletransportation("Char_Repere_Door6",_idChar_Phase1_Resist_Sniper_6)
		end
	end
	if ((	_bAliveChar_Phase1_Resist_Sniper_1 == false) and (_CtrlChar_Phase1_Resist_Sniper_10 == false)) then
		Freeze(GetCharacterID("Char_Phase1_Resist_Sniper_10"), false)
		_idChar_Phase1_Resist_Sniper_10 = GetCharacterID("Char_Phase1_Resist_Trooper_10")
		_CtrlChar_Phase1_Resist_Sniper_10 = true
		if (_nPlayerZone == 2) then
			Teletransportation("Char_Repere_Door1",_idChar_Phase1_Resist_Sniper_10)
		elseif (_nPlayerZone == 1) then
			Teletransportation("Char_Repere_Door2",_idChar_Phase1_Resist_Sniper_10)
		end
	end
	if ((	_bAliveChar_Phase1_Resist_Sniper_11a == false) and (_CtrlChar_Phase1_Resist_Sniper_9 == false)) then
		Freeze(GetCharacterID("Char_Phase1_Resist_Sniper_9"), false)
		_idChar_Phase1_Resist_Sniper_9 = GetCharacterID("Char_Phase1_Resist_Trooper_9")
		_CtrlChar_Phase1_Resist_Sniper_9 = true
		if (_nPlayerZone == 2) then
			Teletransportation("Char_Repere_Door3",_idChar_Phase1_Resist_Sniper_9)
		elseif (_nPlayerZone == 1) then
			Teletransportation("Char_Repere_Door5",_idChar_Phase1_Resist_Sniper_9)
		end
	end

end
------------------------------------------------------------
------------------------------------------------------------

-- ::: Warfield Part2 ::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnEnter_SE_Phase1_Zone_1(id)
	if ((id == _idPlayer) and (_bCtrlSE_Phase1_Zone_1 == false)) then
		_nPlayerZone = 1.0
	end
end

function OnEnter_SE_Phase1_Zone_2(id)
	if ((id == _idPlayer) and (_bCtrlSE_Phase1_Zone_2 == false)) then
		_nPlayerZone = 2.0
	end
end

function TestZonePlayer()
	if (_nPlayerZone == 1.0) then
		LockDoor(GetDoorID("Door_Monastery_Enter"))
		UnLockDoor(GetDoorID("Door_Monastery_Spawn"))
	elseif (_nPlayerZone == 2.0) then
		UnLockDoor(GetDoorID("Door_Monastery_Enter"))
		LockDoor(GetDoorID("Door_Monastery_Spawn"))
	else
		LockDoor(GetDoorID("Door_Monastery_Enter"))
		LockDoor(GetDoorID("Door_Monastery_Spawn"))
	end
end


function AliveTroopers_Part2()
	_bAliveChar_Phase1_Resist_Trooper_3 = IsAlive(GetCharacterID("Char_Phase1_Resist_Trooper_3"))
	_bAliveChar_Phase1_Resist_Trooper_6 = IsAlive(GetCharacterID("Char_Phase1_Resist_Trooper_6"))
	_bAliveChar_Phase1_Resist_Trooper_7 = IsAlive(GetCharacterID("Char_Phase1_Resist_Trooper_7"))
	_bAliveChar_Phase1_Resist_Trooper_8 = IsAlive(GetCharacterID("Char_Phase1_Resist_Trooper_8"))
	_bAliveChar_Phase1_Resist_Trooper_9 = IsAlive(GetCharacterID("Char_Phase1_Resist_Trooper_9"))
	_bAliveChar_Phase1_Resist_Trooper_10 = IsAlive(GetCharacterID("Char_Phase1_Resist_Trooper_10"))
	_bAliveMiniBoS1 = IsAlive(GetCharacterID("Char_Phase1_Resist_MiniBoS_1"))
	_bAliveMiniBoS2 = IsAlive(GetCharacterID("Char_Phase1_Resist_MiniBoS_2"))
	_bAliveMiniBoS3 = IsAlive(GetCharacterID("Char_Phase1_Resist_MiniBoS_3"))
	_bAliveMiniBoS4 = IsAlive(GetCharacterID("Char_Phase1_Resist_MiniBoS_4"))

	if ((_bAliveChar_Phase1_Resist_Trooper_6 == false) and (_bCtrlMiniBoS1 == false))  then
		_idMiniBoS1 = GetCharacterID("Char_Phase1_Resist_MiniBoS_1")
		Freeze(_idMiniBoS1, false)
		if (_nPlayerZone == 2) then
			Teletransportation("Char_Repere_Door1",_idMiniBoS1)
		elseif (_nPlayerZone == 1) then
			Teletransportation("Char_Repere_Door2",_idMiniBoS1)
		else
			Teletransportation("Char_Repere_Door2",_idMiniBoS1)
		end
		_bCtrlMiniBoS1 = true
	end

	if ((_bAliveChar_Phase1_Resist_Trooper_3 == false) and (_bCtrlMiniBoS2 == false))  then
		_idMiniBoS2 = GetCharacterID("Char_Phase1_Resist_MiniBoS_2")
		Freeze(_idMiniBoS2, false)
		if (_nPlayerZone == 2) then
			Teletransportation("Char_Repere_Door3",_idMiniBoS2)
		elseif (_nPlayerZone == 1) then
			Teletransportation("Char_Repere_Door5",_idMiniBoS2)
		else
			Teletransportation("Char_Repere_Door5",_idMiniBoS2)
		end
		_bCtrlMiniBoS2 = true
	end

	if ((_bAliveChar_Phase1_Resist_Trooper_7 == false) and (_CtrlChar_Phase1_Resist_Trooper_8 == false)) then
		_idChar_Phase1_Resist_Trooper_8 = GetCharacterID("Char_Phase1_Resist_Trooper_8")
		Freeze(GetCharacterID("Char_Phase1_Resist_Trooper_8"), false)
		if (_nPlayerZone == 2) then
			Teletransportation("Char_Repere_Door4",_idChar_Phase1_Resist_Trooper_8)
		elseif (_nPlayerZone == 1) then
			Teletransportation("Char_Repere_Door6",_idChar_Phase1_Resist_Trooper_8)
		else
			Teletransportation("Char_Repere_Door6",_idChar_Phase1_Resist_Trooper_8)
		end
		_CtrlChar_Phase1_Resist_Trooper_8 = true
	end

	if ((_bAliveMiniBoS1 == false) and (_CtrlChar_Phase1_Resist_Trooper_9 == false)) then
		_idChar_Phase1_Resist_Trooper_9 = GetCharacterID("Char_Phase1_Resist_Trooper_9")
		Freeze(GetCharacterID("Char_Phase1_Resist_Trooper_9"), false)
		if (_nPlayerZone == 2) then
			Teletransportation("Char_Repere_Door1",_idChar_Phase1_Resist_Trooper_9)
		elseif (_nPlayerZone == 1) then
			Teletransportation("Char_Repere_Door2",_idChar_Phase1_Resist_Trooper_9)
		else
			Teletransportation("Char_Repere_Door2",_idChar_Phase1_Resist_Trooper_9)
		end
		_CtrlChar_Phase1_Resist_Trooper_9 = true
	end

	if ((_bAliveMiniBoS2 == false) and (_CtrlChar_Phase1_Resist_Trooper_10 == false)) then
		_idChar_Phase1_Resist_Trooper_10 = GetCharacterID("Char_Phase1_Resist_Trooper_10")
		Freeze(GetCharacterID("Char_Phase1_Resist_Trooper_10"), false)
		if (_nPlayerZone == 2) then
			Teletransportation("Char_Repere_Door3",_idChar_Phase1_Resist_Trooper_10)
		elseif (_nPlayerZone == 1) then
			Teletransportation("Char_Repere_Door5",_idChar_Phase1_Resist_Trooper_10)
		else
			Teletransportation("Char_Repere_Door5",_idChar_Phase1_Resist_Trooper_10)
		end
		_CtrlChar_Phase1_Resist_Trooper_10 = true
	end

	if ((_bAliveChar_Phase1_Resist_Trooper_8 == false) and (_bCtrlMiniBoS3 == false)) then
		_idMiniBoS3 = GetCharacterID("Char_Phase1_Resist_MiniBoS_3")
		Freeze(_idMiniBoS3, false)
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Resistance theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Eradication theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Twilight theme.wav", true)
			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 1.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav", true)
	
				 -- 	PauseMusic()
				 		StopMusic()
				 --		StartMusic(
		if (_nPlayerZone == 2) then
			Teletransportation("Char_Repere_Door4",_idMiniBoS3)
		elseif (_nPlayerZone == 1) then
			Teletransportation("Char_Repere_Door6",_idMiniBoS3)
		else
			Teletransportation("Char_Repere_Door6",_idMiniBoS3)
		end
		_bCtrlMiniBoS3 = true
	end

	if ((_bAliveChar_Phase1_Resist_Trooper_9 == false) and (_bCtrlMiniBoS4 == false)) then
		_idMiniBoS4 = GetCharacterID("Char_Phase1_Resist_MiniBoS_4")
		Freeze(_idMiniBoS4, false)
		if (_nPlayerZone == 2) then
			Teletransportation("Char_Repere_Door1",_idMiniBoS4)
		elseif (_nPlayerZone == 1) then
			Teletransportation("Char_Repere_Door2",_idMiniBoS4)
		else
			Teletransportation("Char_Repere_Door2",_idMiniBoS4)
		end
		_bCtrlMiniBoS4 = true
	end
end

function EndE3()
	if ((_bAliveMiniBoS1 == false) and (_bAliveMiniBoS2 == false) and (_bAliveMiniBoS3 == false) and (_bAliveMiniBoS4 == false) and (_bCtrlEndE3 == false)) then
	--	Mission_End_Demo()
--		MissionSucceed()
		_bCtrlEndE3 = true
--		SetGodMode(_idPlayer,true)
	ObjectiveDoneNewObjectiveNewSubObjective ("Obj_A","Obj_B","Obj_B1")
	Freeze(GetCharacterID("Char_Monastery_Syndic_Trooper_1"),false)
	UnLockDoor(GetDoorID("Door_Monastery_Enter"))
	OpenDoor(GetDoorID("Door_Monastery_Enter"))
	end
end