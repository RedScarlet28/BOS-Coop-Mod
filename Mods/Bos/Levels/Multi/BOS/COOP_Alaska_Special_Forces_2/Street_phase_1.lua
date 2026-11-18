function InitLevel_Street_phase_1()
	_bPlayerStreet = true
	_bCtrlDoorExpl = false
end

function UpdateLevel_Street_phase_1()

	Change_Bot_behavior("Char_UAN_Street1_Trooper_1",80,50,"AIOL_FA_Player")

	Change_Bot_behavior("Char_UAN_Street1_Trooper_1",80,50,"AIOL_FA_Player")
end

-------------------------------------------------------------
-- :::: Street1 :::::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function OnEnter_SE_Street1_Trigger_1(id)
	if (id == _idPlayer) then
		FreezeAll(GetGroupID("Group_Street1_Turtle_1"), false)
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
	end
end

function OnEnter_SE_Parking_Trigger_3(id)
	if (id == _idPlayer) then
		_bPlayerStreet = false
	end
end

function OnEnter_SE_Parking_Trigger_2(id)
	if (id == _idPlayer) then
		_bPlayerStreet = true
	end
end

function ActiveDesactiveFog()
	if (_bPlayerStreet == true) then
		SetVarValue(GetFog_ClientID("Fog_Client_Street"), "Active",true)
		SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Street_Cloud_1"), "FxState","Fx Started")
		SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Street_Cloud_2"), "FxState","Fx Started")
	else
		SetVarValue(GetFog_ClientID("Fog_Client_Street"), "Active",false)
		SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Street_Cloud_1"), "FxState","Fx Paused")
		SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Street_Cloud_2"), "FxState","Fx Paused")
	end
end

function Test_Explosion_Door_Parking()

_bIsDestroyedDoor_Parking = GetVarValue(GetDestructible_ObjectID("Destructible_Door_Parking"),"Destroyed")
	if((_bIsDestroyedDoor_Parking == true) and (_bCtrlDoorExpl == false)) then
		ObjectiveDoneNewObjectiveNewSubObjective("Obj_A","Obj_B","Obj_B_1")
		_bCtrlDoorExpl = true
		SetVarValue(GetSound_ClientID("Sound_Client_Alarm"),"Playing", true)
--		SetVarValue(GetSound_ClientID("Sound_Client_Zik_Parking"),"Playing", true)
--		SetVarValue(GetSound_ClientID("Sound_Client_Wind"),"Playing", false)
		MiniMapTrack(GetDestructible_ObjectID("Destructible_Truck_1"),2,true)
		MiniMapTrack(GetDestructible_ObjectID("Destructible_Truck_2"),2,true)
		MiniMapTrack(GetDestructible_ObjectID("Destructible_Truck_3"),2,true)
		MiniMapTrack(GetDestructible_ObjectID("Destructible_Truck_4"),2,true)
	end
end

