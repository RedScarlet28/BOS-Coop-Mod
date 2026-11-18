-------------------------------------------------------------
-- :::: Objectives ::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Test_Explosion_Trucks()

_bIsDestroyedTruck1 = GetVarValue(GetDestructible_ObjectID("Destructible_Truck_1"),"Destroyed")
_bIsDestroyedTruck2 = GetVarValue(GetDestructible_ObjectID("Destructible_Truck_2"),"Destroyed")
_bIsDestroyedTruck3 = GetVarValue(GetDestructible_ObjectID("Destructible_Truck_3"),"Destroyed")
_bIsDestroyedTruck4 = GetVarValue(GetDestructible_ObjectID("Destructible_Truck_4"),"Destroyed")

	if ((_bIsDestroyedTruck1 == true) and (_bCtrl_nIsDestroyedTruck1 == false)) then
		_nIsDestroyedTruck1 = 1
		_bCtrl_nIsDestroyedTruck1 = true
		MiniMapTrack(GetDestructible_ObjectID("Destructible_Truck_1"),2,false)
	end

	if ((_bIsDestroyedTruck2 == true) and (_bCtrl_nIsDestroyedTruck2 == false)) then
		_nIsDestroyedTruck2 = 1
		_bCtrl_nIsDestroyedTruck2 = true
		MiniMapTrack(GetDestructible_ObjectID("Destructible_Truck_2"),2,false)
	end

	if ((_bIsDestroyedTruck3 == true) and (_bCtrl_nIsDestroyedTruck3 == false)) then
		_nIsDestroyedTruck3 = 1
		_bCtrl_nIsDestroyedTruck3 = true
		MiniMapTrack(GetDestructible_ObjectID("Destructible_Truck_3"),2,false)
	end

	if ((_bIsDestroyedTruck4 == true) and (_bCtrl_nIsDestroyedTruck4 == false)) then
		_nIsDestroyedTruck4 = 1
		_bCtrl_nIsDestroyedTruck4 = true
		MiniMapTrack(GetDestructible_ObjectID("Destructible_Truck_4"),2,false)
	end

_bAllDestroyedTrucks = (_nIsDestroyedTruck1 + _nIsDestroyedTruck2 + _nIsDestroyedTruck3 + _nIsDestroyedTruck4)

	if((_bAllDestroyedTrucks == 1) and (_bCtrlDestroyedTruck1 == false)) then
		CreationTimer(true, true, false, "ObjectiveB_2",2)
		_bCtrlDestroyedTruck1 = true
	end
	if((_bAllDestroyedTrucks == 2) and (_bCtrlDestroyedTruck2 == false)) then
		CreationTimer(true, true, false, "ObjectiveB_3",2)
		_bCtrlDestroyedTruck2 = true
	end
	if((_bAllDestroyedTrucks == 3) and (_bCtrlDestroyedTruck3 == false)) then
			CreationTimer(true, true, false, "ObjectiveB_4",2)
		_bCtrlDestroyedTruck3 = true
	end
	if((_bAllDestroyedTrucks == 4) and (_bCtrlDestroyedTruck4 == false)) then
		CreationTimer(true, true, false, "ObjectiveC_1",2)
		_bCtrlDestroyedTruck4 = true
	end
end

function ObjectiveB_2()
	NewSubObjective ("Obj_B_1","Obj_B_2")
end

function ObjectiveB_3()
	NewSubObjective ("Obj_B_2","Obj_B_3")
end

function ObjectiveB_4()
	NewSubObjective ("Obj_B_3","Obj_B_4")
end

function ObjectiveC_1()
	ObjectiveDoneNewObjectiveNewSubObjective("Obj_B","Obj_C","Obj_C_1")
	_bTrucksExplosed = true
end

function TestVieParking()
	_nAliveGroup_Parking_1 = AliveMembersCount(GetGroupID("Group_Parking_1"))
	_nAliveGroup_Parking_2 = AliveMembersCount(GetGroupID("Group_Parking_2"))
	--
	_nAliveGroup_Parking_3 = AliveMembersCount(GetGroupID("Group_Parking_3"))
	_nAliveGroup_Parking_4 = AliveMembersCount(GetGroupID("Group_Parking_4"))

	_nAliveGroup_Parking_5 = AliveMembersCount(GetGroupID("Group_Parking_5"))
	_nAliveGroup_Parking_6 = AliveMembersCount(GetGroupID("Group_Parking_6"))
	--
	_nAliveGroup_Parking_7 = AliveMembersCount(GetGroupID("Group_Parking_7"))
	_nAliveGroup_Parking_8 = AliveMembersCount(GetGroupID("Group_Parking_8"))

	_nAliveGroup_Parking_9 = AliveMembersCount(GetGroupID("Group_Parking_9"))
	-- 
	_nAliveGroup_Parking_10 = AliveMembersCount(GetGroupID("Group_Parking_10"))
	_nAliveGroup_Parking_11 = AliveMembersCount(GetGroupID("Group_Parking_11"))

	_nAliveGroup_Parking_12 = AliveMembersCount(GetGroupID("Group_Parking_12"))
	_nAliveGroup_Parking_Turtle_1 = AliveMembersCount(GetGroupID("Group_Parking_Turtle_1"))	

	
	_nTotalAliveParking = (_nAliveGroup_Parking_1 + _nAliveGroup_Parking_2 + _nAliveGroup_Parking_3 + _nAliveGroup_Parking_4 + _nAliveGroup_Parking_5 + _nAliveGroup_Parking_6 + _nAliveGroup_Parking_7 + _nAliveGroup_Parking_8 + _nAliveGroup_Parking_9 + _nAliveGroup_Parking_10 + _nAliveGroup_Parking_11 + _nAliveGroup_Parking_12 + _nAliveGroup_Parking_Turtle_1)

	if ((_nTotalAliveParking <= 7) and (_bCtrlNettoyageParking == false)) then
		_bNettoyageParking = true
		_bCtrlNettoyageParking = true
	end
end

function ObjectiveD_1()
--	ObjectiveDoneNewObjectiveNewSubObjective("Obj_C","Obj_D","Obj_D_1")
	MissionSucceed()
end