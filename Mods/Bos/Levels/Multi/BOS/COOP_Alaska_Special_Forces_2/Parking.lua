function InitLevel_Parking()
	_CtrlChar_UAN_Parking_Trooper_6 = false
	_CtrlChar_UAN_Parking_Trooper_7 = false
	_CtrlChar_UAN_Parking_Destroyer_2 = false
	_bCtrlSE_Parking_Trigger_5 = false
	_bCtrlDestroyedTruck1 = false
	_bCtrlDestroyedTruck2 = false
	_bCtrlDestroyedTruck3 = false
	_bCtrlDestroyedTruck4 = false
	_nIsDestroyedTruck1 = 0
	_bCtrl_nIsDestroyedTruck1 = false
	_nIsDestroyedTruck2 = 0
	_bCtrl_nIsDestroyedTruck2 = false
	_nIsDestroyedTruck3 = 0
	_bCtrl_nIsDestroyedTruck3 = false
	_nIsDestroyedTruck4 = 0
	_bCtrl_nIsDestroyedTruck4 = false
	_bCtrlSE_Parking_Trigger_8 = false
	_bGroup_Parking_1 = false
	_bGroup_Parking_2 = false
	_bGroup_Parking_3 = false
	_bGroup_Parking_4 = false
	_bGroup_Parking_5 = false
	_bGroup_Parking_6 = false
	_bGroup_Parking_7 = false
	_bGroup_Parking_8 = false
	_bCtrlSE_Parking_Trigger_12 = false
	_bNettoyageParking = false
	_bCtrlNettoyageParking = false
	_bBoSEnd = false
	_bCtrlLaunchBoS = false
	_bTrucksExplosed = false
	_bSpeedGrenade = true
	_bBoucherFight = false
end


function UpdateLevel_Parking()
	Change_Bot_behavior("Char_UAN_Parking_Trooper_2",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_3",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_4",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_5",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_6",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_7",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_8",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_9",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_10",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_11",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_12",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_13",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_14",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_15",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_16",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_17",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_18",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_19",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_20",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_21",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Trooper_22",80,50,"AIOL_FA_Player")

	Change_Bot_behavior("Char_UAN_Parking_Sniper_1",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Sniper_2",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Sniper_3",80,50,"AIOL_FA_Player")

	Change_Bot_behavior("Char_UAN_Parking_Destroyer_1",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Destroyer_2",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Destroyer_3",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Destroyer_4",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Destroyer_5",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Destroyer_6",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Destroyer_7",80,50,"AIOL_FA_Player")
	Change_Bot_behavior("Char_UAN_Parking_Destroyer_8",80,50,"AIOL_FA_Player")

	ActiveDesactiveFog()
	TestVieGroup_Parking_1()
	Test_Explosion_Trucks()
	Test_Explosion_Door_Parking()
	TestVieParking()
	DeclencheBoS()
end

-------------------------------------------------------------
-- :::: Parking :::::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function OnEnter_SE_Parking_Trigger_1(id)
	if (id == _idPlayer) then
		FreezeAll(GetGroupID("Group_Parking_1"), false)
		CreationTimer(true, true, false, "DebloqueGroup_Parking_1",10)
	end
end

function OnEnter_SE_Parking_Trigger_4(id)
	if (id == _idPlayer) then
		FreezeAll(GetGroupID("Group_Parking_2"), false)
		CreationTimer(true, true, false, "DebloqueGroup_Parking_2",10)
	end
end

function TestVieGroup_Parking_1()
-----
	_bAliveChar_UAN_Parking_Trooper_1 = IsAlive(GetCharacterID("Char_UAN_Parking_Trooper_1"))

	if ((_bAliveChar_UAN_Parking_Trooper_1 == false) and (_CtrlChar_UAN_Parking_Trooper_6 == false)) then
		Freeze(GetCharacterID("Char_UAN_Parking_Trooper_6"), false)
		_CtrlChar_UAN_Parking_Trooper_6 = true
	end
-----
	_bAliveChar_UAN_Parking_Trooper_2 = IsAlive(GetCharacterID("Char_UAN_Parking_Trooper_2"))

	if ((_bAliveChar_UAN_Parking_Trooper_2 == false) and (_CtrlChar_UAN_Parking_Trooper_7 == false)) then
		Freeze(GetCharacterID("Char_UAN_Parking_Trooper_7"), false)
		_CtrlChar_UAN_Parking_Trooper_7 = true
	end
-----
	_bAliveChar_UAN_Parking_Destroyer_1 = IsAlive(GetCharacterID("Char_UAN_Parking_Destroyer_1"))

	if ((_bAliveChar_UAN_Parking_Destroyer_1 == false) and (_CtrlChar_UAN_Parking_Destroyer_2 == false)) then
		Freeze(GetCharacterID("Char_UAN_Parking_Destroyer_2"), false)
		_CtrlChar_UAN_Parking_Destroyer_2 = true
	end
end

function OnEnter_SE_Parking_Trigger_5(id)
	if ((id == _idPlayer) and (_bCtrlSE_Parking_Trigger_5 == false)) then
		FreezeAll(GetGroupID("Group_Parking_3"), false)
		CreationTimer(true, true, false, "DebloqueGroup_Parking_3",10)
		_bCtrlSE_Parking_Trigger_5 = true
		SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_6"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	end
end

function OnEnter_SE_Parking_Trigger_5b(id)
	if ((id == _idPlayer) and (_bCtrlSE_Parking_Trigger_5 == false)) then
		FreezeAll(GetGroupID("Group_Parking_4"), false)
		CreationTimer(true, true, false, "DebloqueGroup_Parking_4",10)
		_bCtrlSE_Parking_Trigger_5 = true
	end
end

function OnEnter_SE_Parking_Trigger_6(id)
	if (id == _idPlayer) then
		FreezeAll(GetGroupID("Group_Parking_5"), false)
	end
end

function OnEnter_SE_Parking_Trigger_7(id)
	if (id == _idPlayer) then
		FreezeAll(GetGroupID("Group_Parking_6"), false)
		CreationTimer(true, true, false, "DebloqueGroup_Parking_6",10)
	end
end

function OnEnter_SE_Parking_Trigger_8(id)
	if ((id == _idPlayer) and (_bCtrlSE_Parking_Trigger_8 == false)) then
		FreezeAll(GetGroupID("Group_Parking_7"), false)
		CreationTimer(true, true, false, "DebloqueGroup_Parking_7",10)
		_bCtrlSE_Parking_Trigger_8 = true
		SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_6"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	end
end

function OnEnter_SE_Parking_Trigger_8b(id)
	if ((id == _idPlayer) and (_bCtrlSE_Parking_Trigger_8 == false)) then
		FreezeAll(GetGroupID("Group_Parking_8"), false)
		CreationTimer(true, true, false, "DebloqueGroup_Parking_8",10)
		_bCtrlSE_Parking_Trigger_8 = true
	end
end

function OnEnter_SE_Parking_Trigger_9(id)
	if (id == _idPlayer) then
		FreezeAll(GetGroupID("Group_Parking_9"), false)
		CreationTimer(true, true, false, "DebloqueGroup_Parking_9",10)
	end
end

function OnEnter_SE_Parking_Trigger_10(id)
	if (id == _idPlayer) then
		SetVarValue(GetCharacterID("Char_UAN_Parking_Sniper_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_UAN_Parking_Sniper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	end
end

function OnEnter_SE_Parking_Trigger_11(id)
	if (id == _idPlayer) then
		SetVarValue(GetCharacterID("Char_UAN_Parking_Sniper_3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_UAN_Parking_Sniper_4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	end
end

function OnEnter_SE_Parking_Trigger_12(id)
	if ((id == _idPlayer) and (_bCtrlSE_Parking_Trigger_12 == false)) then
		FreezeAll(GetGroupID("Group_Parking_Turtle_1"), false)
		FreezeAll(GetGroupID("Group_Parking_11"), false)
		CreationTimer(true, true, false, "DebloqueGroup_Parking_11",10)
		_bCtrlSE_Parking_Trigger_12 = true
	end
end

function OnEnter_SE_Parking_Trigger_12b(id)
	if ((id == _idPlayer) and (_bCtrlSE_Parking_Trigger_12 == false)) then
		FreezeAll(GetGroupID("Group_Parking_Turtle_1"), false)
		FreezeAll(GetGroupID("Group_Parking_10"), false)
		CreationTimer(true, true, false, "DebloqueGroup_Parking_10",10)
		_bCtrlSE_Parking_Trigger_12 = true
	end
end

function OnEnter_SE_Parking_Trigger_13(id)
	if ((id == _idPlayer) and (_bCtrlSE_Parking_Trigger_12 == false)) then
		FreezeAll(GetGroupID("Group_Parking_Turtle_1"), false)
		FreezeAll(GetGroupID("Group_Parking_10"), false)
		CreationTimer(true, true, false, "DebloqueGroup_Parking_10",10)
		_bCtrlSE_Parking_Trigger_12 = true
	end
end

---------------------------------------------------------

function DebloqueGroup_Parking_1()
	SetVarValue(GetCharacterID("Char_UAN_Parking_Destroyer_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_22"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

function DebloqueGroup_Parking_2()
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

function DebloqueGroup_Parking_3()
	SetVarValue(GetCharacterID("Char_UAN_Parking_Destroyer_3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_8"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_9"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

function DebloqueGroup_Parking_4()
	SetVarValue(GetCharacterID("Char_UAN_Parking_Destroyer_4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_10"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_11"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

function DebloqueGroup_Parking_6()
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_12"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_13"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_14"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

function DebloqueGroup_Parking_7()
	SetVarValue(GetCharacterID("Char_UAN_Parking_Destroyer_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Destroyer_6"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

function DebloqueGroup_Parking_8()
	SetVarValue(GetCharacterID("Char_UAN_Parking_Destroyer_7"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Destroyer_8"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

function DebloqueGroup_Parking_9()
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_15"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_16"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_17"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

function DebloqueGroup_Parking_10()
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_18"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_19"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

function DebloqueGroup_Parking_11()
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_20"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_UAN_Parking_Trooper_21"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

-------------------------------------------------------------
-- :::: BoS :::::::::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function DeclencheBoS()
	if ((_bNettoyageParking == true) and (IsEntityInBox(_idPlayer,"SE_Parking_Trigger_BoS_1") == true)  and (_bCtrlLaunchBoS == false) and (_bTrucksExplosed == true)) then
		CreationTimer(true, true, false, "LancementBoS1",3)
		_bCtrlLaunchBoS = true
	end
	if ((_bNettoyageParking == true) and (IsEntityInBox(_idPlayer,"SE_Parking_Trigger_BoS_2") == true) and (_bCtrlLaunchBoS == false) and (_bTrucksExplosed == true)) then
		CreationTimer(true, true, false, "LancementBoS2",3)
		_bCtrlLaunchBoS = true
	end
end

function LancementBoS1()
	if (_idChampion_0 ~= nil) then 

		Freeze(_idChampion_0, false)

		-- Télétransportation Player et Champion
		Teletransportation("Char_Repere_1",_idPlayer)
		Teletransportation("Char_Repere_2",_idChampion_0)

		-- Lance la séquence d'introduction du B.O.S
		LaunchBOS(0,"","WarmUpBOS", "CombatBOS", "BoS_End", "BoS_Lost","BoS_End")
		g_bBoSEnCours = true

		CloseDoor(GetDoorID("Door_BoS_1"))
		LockDoor(GetDoorID("Door_BoS_1"))
		CloseDoor(GetDoorID("Door_BoS_2"))
		LockDoor(GetDoorID("Door_BoS_2"))
		CloseDoor(GetDoorID("Door_BoS_3"))
		LockDoor(GetDoorID("Door_BoS_3"))
		CloseDoor(GetDoorID("Door_BoS_4"))
		LockDoor(GetDoorID("Door_BoS_4"))
		CloseDoor(GetDoorID("Door_BoS_5"))
		LockDoor(GetDoorID("Door_BoS_5"))
		CloseDoor(GetDoorID("Door_BoS_6"))
		LockDoor(GetDoorID("Door_BoS_6"))
		CloseDoor(GetDoorID("Door_BoS_7"))
		LockDoor(GetDoorID("Door_BoS_7"))
		CloseDoor(GetDoorID("Door_BoS_8"))
		LockDoor(GetDoorID("Door_BoS_8"))
		CloseDoor(GetDoorID("Door_BoS_9"))
		LockDoor(GetDoorID("Door_BoS_9"))
		CloseDoor(GetDoorID("Door_BoS_10"))
		LockDoor(GetDoorID("Door_BoS_10"))
		CloseDoor(GetDoorID("Door_BoS_11"))
		LockDoor(GetDoorID("Door_BoS_11"))

		FreezeAll(GetGroupID("Group_Parking_Syndic"), false)

		EnableCharacterCommand(GetCharacterID("Char_Syndic_Parking_BoS_1"), false)
		EnableCharacterCommand(GetCharacterID("Char_Syndic_Parking_BoS_2"), false)
		EnableCharacterCommand(GetCharacterID("Char_Syndic_Parking_BoS_3"), false)
		EnableCharacterCommand(GetCharacterID("Char_Syndic_Parking_BoS_4"), false)

		-- Déclare que le Champion est défrisé
		_bChampion_defreeze = true

	-- Si le 1er membre de la liste correspond à une entité valide (donc s'il reste 1 mercenaire en vie au moins)
	if (_idMerc[0] ~= nil) then 

		-- Télétransportation des Mercs en zone "sécurisée"
		Teletransportation("Char_Champion_0_Repere_Merc1",_idMerc[0])

		-- Disable les cmd du Merc[0]
		EnableCharacterCommand(_idMerc[0], false)
		SetGodMode(_idMerc[0], true)
		Freeze(_idMerc[0],true)

		-- Crée un Forbid Target pour que le Champion ne tire pas sur le Merc[0]
		_idFT_0 = CreateAI_Order_Forbid_Target()
		SetVarValue(_idFT_0,"Target",_idMerc[0])
		SetVarValue(_idFT_0,"PriorityTorso",100)
	end

	-- Si le 2ème membre de la liste correspond à une entité valide (donc si les 2 mercenaires sont en vie)
	if (_idMerc[1] ~= nil) then 

		-- Télétransportation des Mercs en zone "sécurisée"
		Teletransportation("Char_Champion_0_Repere_Merc2",_idMerc[1])

		-- Disable les cmd du Merc 1
		EnableCharacterCommand(_idMerc[1], false)
		SetGodMode(_idMerc[1], true)
		Freeze(_idMerc[1],true)

		-- Crée un Forbid Target pour que le Champion ne tire pas sur le mercenaire
		_idFT_1 = CreateAI_Order_Forbid_Target()
		SetVarValue(_idFT_1,"Target",_idMerc[1])
		SetVarValue(_idFT_1,"PriorityTorso",100)
	end
	end
end


function LancementBoS2()
	if (_idChampion_0 ~= nil) then 

		Freeze(_idChampion_0, false)

		-- Télétransportation Player et Champion
		Teletransportation("Char_Repere_2",_idPlayer)
		Teletransportation("Char_Repere_1",_idChampion_0)

		-- Lance la séquence d'introduction du B.O.S
		LaunchBOS(0,"","WarmUpBOS", "CombatBOS", "BoS_End", "BoS_Lost","BoS_End")
		g_bBoSEnCours = true

		CloseDoor(GetDoorID("Door_BoS_1"))
		LockDoor(GetDoorID("Door_BoS_1"))
		CloseDoor(GetDoorID("Door_BoS_2"))
		LockDoor(GetDoorID("Door_BoS_2"))
		CloseDoor(GetDoorID("Door_BoS_3"))
		LockDoor(GetDoorID("Door_BoS_3"))
		CloseDoor(GetDoorID("Door_BoS_4"))
		LockDoor(GetDoorID("Door_BoS_4"))
		CloseDoor(GetDoorID("Door_BoS_5"))
		LockDoor(GetDoorID("Door_BoS_5"))
		CloseDoor(GetDoorID("Door_BoS_6"))
		LockDoor(GetDoorID("Door_BoS_6"))
		CloseDoor(GetDoorID("Door_BoS_7"))
		LockDoor(GetDoorID("Door_BoS_7"))
		CloseDoor(GetDoorID("Door_BoS_8"))
		LockDoor(GetDoorID("Door_BoS_8"))
		CloseDoor(GetDoorID("Door_BoS_9"))
		LockDoor(GetDoorID("Door_BoS_9"))
		CloseDoor(GetDoorID("Door_BoS_10"))
		LockDoor(GetDoorID("Door_BoS_10"))
		CloseDoor(GetDoorID("Door_BoS_11"))
		LockDoor(GetDoorID("Door_BoS_11"))

		FreezeAll(GetGroupID("Group_Parking_Syndic"), false)

		EnableCharacterCommand(GetCharacterID("Char_Syndic_Parking_BoS_1"), false)
		EnableCharacterCommand(GetCharacterID("Char_Syndic_Parking_BoS_2"), false)
		EnableCharacterCommand(GetCharacterID("Char_Syndic_Parking_BoS_3"), false)
		EnableCharacterCommand(GetCharacterID("Char_Syndic_Parking_BoS_4"), false)

		-- Déclare que le Champion est défrisé
		_bChampion_defreeze = true
	end

	-- Si le 1er membre de la liste correspond à une entité valide (donc s'il reste 1 mercenaire en vie au moins)
	if (_idMerc[0] ~= nil) then 

		-- Télétransportation des Mercs en zone "sécurisée"
		Teletransportation("Char_Champion_0_Repere_Merc1",_idMerc[0])

		-- Disable les cmd du Merc[0]
		EnableCharacterCommand(_idMerc[0], false)
		SetGodMode(_idMerc[0], true)
		Freeze(_idMerc[0],true)

		-- Crée un Forbid Target pour que le Champion ne tire pas sur le Merc[0]
		_idFT_0 = CreateAI_Order_Forbid_Target()
		SetVarValue(_idFT_0,"Target",_idMerc[0])
		SetVarValue(_idFT_0,"PriorityTorso",100)
	end

	-- Si le 2ème membre de la liste correspond à une entité valide (donc si les 2 mercenaires sont en vie)
	if (_idMerc[1] ~= nil) then 

		-- Télétransportation des Mercs en zone "sécurisée"
		Teletransportation("Char_Champion_0_Repere_Merc2",_idMerc[1])

		-- Disable les cmd du Merc 1
		EnableCharacterCommand(_idMerc[1], false)
		SetGodMode(_idMerc[1], true)
		Freeze(_idMerc[1],true)

		-- Crée un Forbid Target pour que le Champion ne tire pas sur le mercenaire
		_idFT_1 = CreateAI_Order_Forbid_Target()
		SetVarValue(_idFT_1,"Target",_idMerc[1])
		SetVarValue(_idFT_1,"PriorityTorso",100)
	end
end

function SetUpBOS()

end

function WarmUpBOS()
	EnableCharacterCommand(_idChampion_0, false)
	EnableCharacterFire(_idPlayer, false)
end

function CombatBOS()
	_bBoSEnCours = true
	if (_idChampion_0 == GetCharacterID("Char_Champion_0_3")) then
--		SetVarValue(GetPlug_MagneticShieldID("Plug_MShield_Champion_0_3"),"Active", true)
	end

	if (_idChampion_0 == GetCharacterID("Char_Champion_0_2")) then
		_bBoucherFight = true
	end

	EnableCharacterCommand(_idChampion_0, true)
	EnableCharacterFire(_idPlayer, true)
end

function ScriptShieldBoS2()
	if (_idChampion_0 == GetCharacterID("Char_Champion_0_2")) then
		if (_bBoucherFight == true) then
			Champion_Stop_Turning_Reloading(_idChampion_0,"AIOL_Champion_0_2")
		end
	end
end

function BoS_End()
	_bBoSEnd = true
	CreationTimer(true, true, false, "ObjectiveD_1",3)
	g_bBoSEnCours = false	
	if (_idMerc[0] ~= nil) then 
	EnableCharacterCommand(_idMerc[0], false)
	SetGodMode(_idMerc[0], true)
	Freeze(_idMerc[0],false)
	end
	if (_idMerc[1] ~= nil) then 
	EnableCharacterCommand(_idMerc[1], false)
	SetGodMode(_idMerc[1], true)
	Freeze(_idMerc[1],false)
	end
	Freeze(_idChampion_0, true)
	FreezeAll(GetGroupID("Group_Parking_Syndic"), true)
		UnLockDoor(GetDoorID("Door_BoS_1"))
		OpenDoor(GetDoorID("Door_BoS_1"))
		UnLockDoor(GetDoorID("Door_BoS_2"))
		OpenDoor(GetDoorID("Door_BoS_2"))
		UnLockDoor(GetDoorID("Door_BoS_3"))
		OpenDoor(GetDoorID("Door_BoS_3"))
		UnLockDoor(GetDoorID("Door_BoS_4"))
		OpenDoor(GetDoorID("Door_BoS_4"))
		UnLockDoor(GetDoorID("Door_BoS_5"))
		OpenDoor(GetDoorID("Door_BoS_5"))
		UnLockDoor(GetDoorID("Door_BoS_6"))
		OpenDoor(GetDoorID("Door_BoS_6"))
		UnLockDoor(GetDoorID("Door_BoS_7"))
		OpenDoor(GetDoorID("Door_BoS_7"))
		UnLockDoor(GetDoorID("Door_BoS_8"))
		OpenDoor(GetDoorID("Door_BoS_8"))
		UnLockDoor(GetDoorID("Door_BoS_9"))
		OpenDoor(GetDoorID("Door_BoS_9"))
		UnLockDoor(GetDoorID("Door_BoS_10"))
		OpenDoor(GetDoorID("Door_BoS_10"))
		UnLockDoor(GetDoorID("Door_BoS_11"))
		OpenDoor(GetDoorID("Door_BoS_11"))
		_bBoSEnCours = false
--		CreationTimer(true, true, false, "ObjectiveD_1",3)
--		MissionSucceed ()
end

function BoS_Lost()
	MissionFailed("HUD_MISSION_FAILED_REASON_01")
end
