function InitConvoy1()
end

function UpdateLevel_Convoy1 ()
	if (_bObjectif_2_done == 1) then	
		Defreeze_Convoy1 ()
		Life_Armor_Global_Convoy1 ()
		Group_UAN_Convoy1_03_Go_Fighting ()
		Group_UAN_Convoy1_02_Go_Fighting ()
		Group_UAN_Convoy1_01_Go_Fighting ()
		Group_UAN_Convoy1_04_Go_Fighting ()
		Group_UAN_Convoy1_05_Go_Fighting ()
		Group_UAN_Convoy1_06_Go_Fighting ()
		Group_UAN_Convoy1_07_Go_Fighting ()
		Change_Follow_Convoy ()
		Mission_Destucting_Exo ()
		Convoy_Arrive_Near_Portal ()
		Convoy_Arrive_Near_Portal_2 ()
	end
end

-- Cette function retourne la vie global et l'armure globale du convoit
function 	Life_Armor_Global_Convoy1 ()
		_bLife_Global_Convoy1 = 
		(
		(
		GetHealthPct  (GetCharacterID("Char_UAN_Convoy1_01_1")) +
		GetHealthPct  (GetCharacterID("Char_UAN_Convoy1_01_2")) +
		GetHealthPct  (GetCharacterID("Char_UAN_Convoy1_01_3")) +
		GetHealthPct  (GetCharacterID("Char_UAN_Convoy1_02_1")) +
		GetHealthPct  (GetCharacterID("Char_UAN_Convoy1_03_1")) 
		) / 5
		)

		_bArmor_Global_Convoy1 = 
		(
		(
		GetArmorGlobalHPPct  (GetCharacterID("Char_UAN_Convoy1_01_1")) +
		GetArmorGlobalHPPct  (GetCharacterID("Char_UAN_Convoy1_01_2")) +
		GetArmorGlobalHPPct  (GetCharacterID("Char_UAN_Convoy1_01_3")) +
		GetArmorGlobalHPPct  (GetCharacterID("Char_UAN_Convoy1_02_1")) +
		GetArmorGlobalHPPct  (GetCharacterID("Char_UAN_Convoy1_03_1")) 
		) / 5	
		)
		_bLife_Exo_01 = GetVarValue(GetExoskeletonID("Exoskeleton_Convoy_01"),"Health")
		_bLife_Exo_02 = GetVarValue(GetExoskeletonID("Exoskeleton_Convoy_02"),"Health")
		_bLife_Weak_Exo_01 = GetVarValue(GetExoskeletonID("Exoskeleton_Convoy_01"),"Weakpoint Health")
		_bLife_Weak_Exo_02 = GetVarValue(GetExoskeletonID("Exoskeleton_Convoy_02"),"Weakpoint Health")

end

-- Le convoy est defreezé quand Nolan accomplit son objectif
-- le reste des troopes sont refreezés, il ne doit rester que Nolan et ses mercs
function Defreeze_Convoy1 ()
	if (_bObjectif_2_done == 1) then
		if (_bDefreeze_Convoy1 == 0)then
		
			FreezeAll(GetGroupID("Group_WRF_City1_01"), true)
			FreezeAll(GetGroupID("Group_UAN_City1_01"), true)
			FreezeAll(GetGroupID("Group_UAN_City1_02"), true)
			FreezeAll(GetGroupID("Group_UAN_City1_04"), true)
			FreezeAll(GetGroupID("Group_UAN_City1_06"), true)
			FreezeAll(GetGroupID("Group_UAN_City1_07"), true)
			FreezeAll(GetGroupID("Group_UAN_City1_08"), true)

			--	Freeze(GetCharacterID("EXO_TRANS_1"), false)
			SetVarValue(GetExoskeletonID("Exoskeleton_Convoy_01"),"Freeze",false)
			SetVarValue(GetExoskeletonID("Exoskeleton_Convoy_02"),"Freeze",false)
			FreezeAll(GetGroupID("Group_UAN_Convoy1_07"), false)
			FreezeAll(GetGroupID("Group_UAN_Convoy1_01"), false)
			FreezeAll(GetGroupID("Group_UAN_Convoy1_02"), false)
			FreezeAll(GetGroupID("Group_UAN_Convoy1_03"), false)
			StopMusic()
			StartMusic("Sounds//Music//BoS - Little theme 2.wav",false)
			ShowCinematicBlackStripes(true)
			LaunchCameraTransition(GetCamTransitionID("CamTransition_A_01"))
			EnableCharacterCommand(_idPlayer, false)
			CreationTimer(true,true,false, "Close_Portal_Begin", 20.0)
			_bDefreeze_Convoy1 = 1
		end
	end	
end


function Cine_End ()
	EnableCharacterCommand(_idPlayer, true)
	ShowCinematicBlackStripes(false)
	SetVarValue(GetTimerID("Timer_Convoy_B_00"),"Active",true)
end

function Close_Portal_Begin ()
	SetVarValue(GetDoorID("Door_Portal_Begin"),"Speed",8)
	SetVarValue(GetDoorID("Door_Portal_Begin1"),"Speed",8)
	CloseDoor(GetDoorID("Door_Portal_Begin"))
	CloseDoor(GetDoorID("Door_Portal_Begin1"))
end

-- NEW OBJECTIVE
function New_Obj_C ()
	ObjectiveDoneNewObjectiveNewSubObjective ( "Obj_B", "Obj_C", "Obj_C_1" )
	MiniMapTrack(GetExoskeletonID("Exoskeleton_Convoy_01"),2, true)
	MiniMapTrack(GetExoskeletonID("Exoskeleton_Convoy_02"),2, true)

	SetVarValue ( GetObjectiveID ("Obj_C_a"),"Active", true )
	SetVarValue ( GetObjectiveID ("Obj_C_b"),"Active", true )
	SetVarValue ( GetObjectiveID ("Obj_C_c"),"Active", true )
end



-- Le groupe 03 se détache du convoit pour chercher Nolan
function Group_UAN_Convoy1_03_Go_Fighting ()
	if (_bGroup_UAN_Convoy1_03_Go_Fighting == 0)then
		if (_bLife_Global_Convoy1 < 99)
		or (_bArmor_Global_Convoy1 < 99)
		or IsCharacterInDanger(GetCharacterID("Char_UAN_Convoy1_01_1"))== true then
			SetVarValue (GetGroupID("Group_UAN_Convoy1_03"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Force_Attack_Player_Convoy"))
			_bGroup_UAN_Convoy1_03_Go_Fighting = 1
		end
	end
end


-- Le groupe 02 se détache du convoit pour chercher Nolan
function Group_UAN_Convoy1_02_Go_Fighting ()
	if (_bGroup_UAN_Convoy1_02_Go_Fighting == 0)then
		if ((_bLife_Global_Convoy1 < 81) or (_bArmor_Global_Convoy1 < 75))then
			SetVarValue (GetGroupID("Group_UAN_Convoy1_02"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Force_Attack_Player_Convoy"))
			_bGroup_UAN_Convoy1_02_Go_Fighting = 1
		end
	end
end

-- Le groupe 01 se détache du convoit pour chercher Nolan
function Group_UAN_Convoy1_01_Go_Fighting ()
	if (_bGroup_UAN_Convoy1_01_Go_Fighting == 0)then
		if ((_bLife_Global_Convoy1 < 61) or (_bArmor_Global_Convoy1 < 55))then
			SetVarValue (GetGroupID("Group_UAN_Convoy1_01"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Force_Attack_Player_Convoy"))
			_bGroup_UAN_Convoy1_01_Go_Fighting = 1
		end
	end
end


-- Si exo mort tous le groupe attack
function Group_UAN_Convoy1_07_Go_Fighting ()
	if (_bGroup_UAN_Convoy1_07_Go_Fighting == 0)then
		if (_bLife_Weak_Exo_01 <= 0) and (_bLife_Weak_Exo_02 <= 0) then
			SetVarValue (GetGroupID("Group_UAN_Convoy1_01"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Force_Attack_Player_Convoy"))
			SetVarValue (GetGroupID("Group_UAN_Convoy1_02"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Force_Attack_Player_Convoy"))
			SetVarValue (GetGroupID("Group_UAN_Convoy1_03"),"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Force_Attack_Player_Convoy"))
			_bGroup_UAN_Convoy1_07_Go_Fighting = 1
		end
	end
end


-- Changement de follow des exos
-- départ: exo2 follow exo 1 qui follow groupe 1
function Change_Follow_Convoy ()
	if ((AliveMembersCount(GetGroupID("Group_UAN_Convoy1_01")) <= 0) or (_bGroup_UAN_Convoy1_01_Go_Fighting == 1))
	and GetVarValue(GetCharacterID("Char_UAN_Convoy1_07_1"),"ExoskeletonOrderList") ~= GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_D_00")then
		SetVarValue (GetCharacterID("Char_UAN_Convoy1_07_1"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_D_00"))
	end
	if ((_bLife_Weak_Exo_01 <= 0) or (_bLife_Exo_01 <= 0))
	and (AliveMembersCount(GetGroupID("Group_UAN_Convoy1_01")) > 0)
	and GetVarValue(GetCharacterID("Char_UAN_Convoy1_07_2"),"ExoskeletonOrderList") ~= GetAI_Order_ListID("AI_O_List_Follow_Convoy_Chief_01")then
		SetVarValue (GetCharacterID("Char_UAN_Convoy1_07_2"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Follow_Convoy_Chief_01"))
	end
	if ((_bLife_Weak_Exo_01 <= 0) or (_bLife_Exo_01 <= 0))
	and (AliveMembersCount(GetGroupID("Group_UAN_Convoy1_01")) <= 0)
	and GetVarValue(GetCharacterID("Char_UAN_Convoy1_07_2"),"ExoskeletonOrderList") ~= GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_D_00")then
		SetVarValue (GetCharacterID("Char_UAN_Convoy1_07_2"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_D_00"))
	end
end


-- Nolan est dans la zone start?
function OnEnter_Sector_Event_Convoy1_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Convoy1_A_00 == 0)then
			_bOnEnter_Sector_Event_Convoy1_A_00 = 1
		end
	end
end

function OnExit_Sector_Event_Convoy1_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Convoy1_A_00 == 1)then
			_bOnEnter_Sector_Event_Convoy1_A_00 = 0
		end
	end
end

-- des groupes de renfort vont picoter Nolan
function Group_UAN_Convoy1_04_Go_Fighting ()
	if (_bOnEnter_Sector_Event_Convoy1_A_00 == 0)then 	
		if (_bGroup_UAN_Convoy1_04_Go_Fighting == 0)then
			if ((_bLife_Global_Convoy1 < 95) or (_bArmor_Global_Convoy1 < 95))then
				FreezeAll(GetGroupID("Group_UAN_Convoy1_04"), false)
				_bGroup_UAN_Convoy1_04_Go_Fighting = 1
			end
		end
	end
end

-- des groupes de renfort vont picoter Nolan
function Group_UAN_Convoy1_05_Go_Fighting ()
	if (_bOnEnter_Sector_Event_Convoy1_A_00 == 0)then 	
		if (_bGroup_UAN_Convoy1_05_Go_Fighting == 0)then
			if ((_bLife_Global_Convoy1 < 75) or (_bArmor_Global_Convoy1 < 75))then
				FreezeAll(GetGroupID("Group_UAN_Convoy1_05"), false)
				_bGroup_UAN_Convoy1_05_Go_Fighting = 1
			end
		end
	end
end

-- des groupes de renfort vont picoter Nolan
function Group_UAN_Convoy1_06_Go_Fighting ()
	if (_bOnEnter_Sector_Event_Convoy1_A_00 == 0)then 	
		if (_bGroup_UAN_Convoy1_06_Go_Fighting == 0)then
			if ((_bLife_Global_Convoy1 < 50) or (_bArmor_Global_Convoy1 < 40))then
				FreezeAll(GetGroupID("Group_UAN_Convoy1_06"), false)
				_bGroup_UAN_Convoy1_06_Go_Fighting = 1
			end
		end
	end
end



---------------------------------------------
---------------------------------------------
---------------------------------------------

-- ARRIVEE DU CONVOY
function Convoy_Arrive_Near_Portal ()
	if (_bPortal_End_Open == 0) then
		if IsEntityInBox(GetCharacterID("Char_UAN_Convoy1_01_1"),"Sector_Event_parking_A_00") 
		and GetVarValue(GetCharacterID("Char_UAN_Convoy1_01_1"),"CharacterOrderList") ~= GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_00")then
			SetVarValue(GetCharacterID("Char_UAN_Convoy1_01_1"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_00"))
 		end
		if IsEntityInBox(GetCharacterID("Char_UAN_Convoy1_01_2"),"Sector_Event_parking_A_00") 
		and GetVarValue(GetCharacterID("Char_UAN_Convoy1_01_2"),"CharacterOrderList") ~= GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_01")then
			SetVarValue(GetCharacterID("Char_UAN_Convoy1_01_2"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_01"))
 		end
		if IsEntityInBox(GetCharacterID("Char_UAN_Convoy1_01_3"),"Sector_Event_parking_A_00") 
		and GetVarValue(GetCharacterID("Char_UAN_Convoy1_01_3"),"CharacterOrderList") ~= GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_02")then
			SetVarValue(GetCharacterID("Char_UAN_Convoy1_01_3"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_02"))
 		end
		if IsEntityInBox(GetCharacterID("Char_UAN_Convoy1_02_1"),"Sector_Event_parking_A_00") 
		and GetVarValue(GetCharacterID("Char_UAN_Convoy1_02_1"),"CharacterOrderList") ~= GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_03")then
			SetVarValue(GetCharacterID("Char_UAN_Convoy1_02_1"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_03"))
 		end
		if IsEntityInBox(GetCharacterID("Char_UAN_Convoy1_03_1"),"Sector_Event_parking_A_00") 
		and GetVarValue(GetCharacterID("Char_UAN_Convoy1_03_1"),"CharacterOrderList") ~= GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_04")then
			SetVarValue(GetCharacterID("Char_UAN_Convoy1_03_1"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_04"))
 		end
		if IsEntityInBox(GetCharacterID("Char_UAN_Convoy1_07_1"),"Sector_Event_parking_A_00") 
		and GetVarValue(GetCharacterID("Char_UAN_Convoy1_07_1"),"ExoskeletonOrderList") ~= GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_05")
		and (_bLife_Weak_Exo_01 > 0) then
			SetVarValue(GetCharacterID("Char_UAN_Convoy1_07_1"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_05"))
 		end
		if IsEntityInBox(GetCharacterID("Char_UAN_Convoy1_07_2"),"Sector_Event_parking_A_00") 
		and GetVarValue(GetCharacterID("Char_UAN_Convoy1_07_2"),"ExoskeletonOrderList") ~= GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_06")
		and (_bLife_Weak_Exo_02 > 0) then
			SetVarValue(GetCharacterID("Char_UAN_Convoy1_07_2"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_06"))
 		end
		if (_bLife_Weak_Exo_01 > 0) and (_bLife_Weak_Exo_02 > 0) then
			if(_bExo1_Is_Near_Portal == 1) and (_bExo2_Is_Near_Portal == 1) then
				CreationTimer(true,true,false, "Cine_Convoy_Arrive_1", 2)
				_bExo1_Is_Near_Portal = 2
				_bExo2_Is_Near_Portal = 2
			end
		end
		if (_bLife_Weak_Exo_01 > 0) and (_bLife_Weak_Exo_02 <= 0) then
			if(_bExo1_Is_Near_Portal == 1) then
				CreationTimer(true,true,false, "Cine_Convoy_Arrive_1", 2)
				_bExo1_Is_Near_Portal = 2
				_bExo2_Is_Near_Portal = 2
			end
		end
		if (_bLife_Weak_Exo_02 > 0) and (_bLife_Weak_Exo_01 <= 0) then
			if(_bExo2_Is_Near_Portal == 1) then
				CreationTimer(true,true,false, "Cine_Convoy_Arrive_1", 2)
				_bExo1_Is_Near_Portal = 2
				_bExo2_Is_Near_Portal = 2
			end
		end
	end
end

function Convoy_Arrive_Near_Portal_2 ()
	if (_bExo1_Is_Near_Portal == 0) then
		if IsEntityInBox(GetCharacterID("Char_UAN_Convoy1_07_1"),"Sector_Event_parking_A_01")then
			_bExo1_Is_Near_Portal = 1
		end
	end
	if (_bExo2_Is_Near_Portal == 0) then
		if IsEntityInBox(GetCharacterID("Char_UAN_Convoy1_07_2"),"Sector_Event_parking_A_01")then
			_bExo2_Is_Near_Portal = 1
		end
	end
end


function Cine_Convoy_Arrive_1()
	_bPortal_End_Open = 1	
	OpenDoor(GetDoorID("Door_Portal_End"))
	ShowCinematicBlackStripes(true)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Convoy_D"))
	EnableCharacterCommand(_idPlayer, false)
	CreationTimer(true,true,false, "Cine_Convoy_Arrive_Exo_Move", 5)		
end

function Cine_Convoy_Arrive_2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Convoy_C"))
end


function Cine_Convoy_Arrive_End()
	ShowCinematicBlackStripes(false)
	RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_22", true, 100, 0,"")
	MissionFailed ("HUD_MISSION_FAILED_REASON_09")
end

function Cine_Convoy_Arrive_Exo_Move()
--	SetVarValue(GetCharacterID("Char_UAN_Convoy1_07_1"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_07"))
--	SetVarValue(GetCharacterID("Char_UAN_Convoy1_07_2"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Convoy_E_07"))
end


function OnEnter_Sector_Event_Convoy1_B_01 (_idCharInBox)
	if (_idCharInBox == GetCharacterID("Char_UAN_Convoy1_07_1"))
	or (_idCharInBox == GetCharacterID("Char_UAN_Convoy1_07_2"))then
		if (_bOnEnter_Sector_Event_Convoy1_B_01 == 0) then
			RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_16", true, 100, 0,"")
			StopMusic()
			StartMusic("Sounds//Music//Bos - War theme.wav",false)
			_bOnEnter_Sector_Event_Convoy1_B_01 = 1
		end
	end
end

function OnEnter_Sector_Event_Convoy1_B_02 (_idCharInBox)
	if (_idCharInBox == GetCharacterID("Char_UAN_Convoy1_07_1"))
	or (_idCharInBox == GetCharacterID("Char_UAN_Convoy1_07_2"))then
		if (_bOnEnter_Sector_Event_Convoy1_B_02 == 0) then
			RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_17", true, 100, 0,"")
			_bOnEnter_Sector_Event_Convoy1_B_02 = 1
		end
	end
end

---------------------------------------------
---------------------------------------------
---------------------------------------------	


-- Mission_Destucting_Exo
-- tous les messages par rapport à la vie du convoy et des exos
-- comme weak marche po pour l'instant on doit simplement détruire les exos
function Mission_Destucting_Exo ()

	--EXO DETRUIT
	if (_bLife_Exo_01 <= 0) or (_bLife_Exo_02 <= 0) then
		if (_bMissionFailed_Exo_Destroy == 0) then
			CreationTimer(true,true,false, "MissionFailed_Exo_Destroy", 1.5)
			_bMissionFailed_Exo_Destroy = 1
		end
	end

	--EXO NEARLY DESTROY phase 1
	if (_bLife_Exo_01 <= 700) or (_bLife_Exo_02 <= 700) then
		if (_bExo_Nearly_Destroy_1 == 0) then
			CreationTimer(true,true,false, "Exo_Nearly_Destroy_1", 1.5)
			_bExo_Nearly_Destroy_1 = 1
		end
	end

		--EXO NEARLY DESTROY phase 2
	if (_bLife_Exo_01 <= 300) or (_bLife_Exo_02 <= 300) then
		if (_bExo_Nearly_Destroy_2 == 0) then
			CreationTimer(true,true,false, "Exo_Nearly_Destroy_2", 1.5)
			_bExo_Nearly_Destroy_2 = 1
		end
	end

	--EXO 1 or 2 Désactivé
	if (_bLife_Weak_Exo_01 <= 0) 
	or (_bLife_Weak_Exo_02 <= 0) then
		if (_bOne_EXO_Desactivated == 0) then
			CreationTimer(true,true,false, "One_EXO_Desactivated", 1.5)
			_bOne_EXO_Desactivated = 1
		end
	end

	--EXO 1 & 2 Désactivés mais il reste des troupes
	if (_bLife_Weak_Exo_01 <= 0)
	and(_bLife_Weak_Exo_02 <= 0)
	and(_bLife_Global_Convoy1 > 0)then
		if (_bTwo_EXO_Desactivated == 0) then
			CreationTimer(true,true,false, "Two_EXO_Desactivated", 1.5)
			_bTwo_EXO_Desactivated = 1
		end
	end


	--EXO 1 & 2 Désactivés & tout le monde mort
	if (_bLife_Weak_Exo_01 <= 0)
	and(_bLife_Weak_Exo_02 <= 0)
	and(_bLife_Global_Convoy1 <= 0)then
		if (_bEnd_Of_Mission_01 == 0)then
			CreationTimer(true,true,false, "End_Of_Mission_01", 1.5)
			_bEnd_Of_Mission_01	= 1
		end
	end


	-- Objectif minimap, kill last troups
	if (_bLife_Weak_Exo_01 <= 0)
	and(_bLife_Weak_Exo_02 <= 0)then
		if IsAlive(GetCharacterID("Char_UAN_Convoy1_01_1"))then
			MiniMapTrack(GetCharacterID("Char_UAN_Convoy1_01_1"),2, true)
		else
			MiniMapTrack(GetCharacterID("Char_UAN_Convoy1_01_1"),2, false)
		end

		if IsAlive(GetCharacterID("Char_UAN_Convoy1_01_2"))then
			MiniMapTrack(GetCharacterID("Char_UAN_Convoy1_01_2"),2, true)
		else
			MiniMapTrack(GetCharacterID("Char_UAN_Convoy1_01_2"),2, false)
		end

		if IsAlive(GetCharacterID("Char_UAN_Convoy1_01_3"))then
			MiniMapTrack(GetCharacterID("Char_UAN_Convoy1_01_3"),2, true)
		else
			MiniMapTrack(GetCharacterID("Char_UAN_Convoy1_01_3"),2, false)
		end

		if IsAlive(GetCharacterID("Char_UAN_Convoy1_02_1"))then
			MiniMapTrack(GetCharacterID("Char_UAN_Convoy1_02_1"),2, true)
		else
			MiniMapTrack(GetCharacterID("Char_UAN_Convoy1_02_1"),2, false)
		end

		if IsAlive(GetCharacterID("Char_UAN_Convoy1_03_1"))then
			MiniMapTrack(GetCharacterID("Char_UAN_Convoy1_03_1"),2, true)
		else
			MiniMapTrack(GetCharacterID("Char_UAN_Convoy1_03_1"),2, false)
		end

	end

end




-- ONE EXO IS NEARLY DESTROY phase 1
function Exo_Nearly_Destroy_1 ()
	RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_14", true, 100, 0,"")
end

-- ONE EXO IS NEARLY DESTROY phase 2
function Exo_Nearly_Destroy_2 ()
	RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_15", true, 100, 0,"")
end

-- EXO DETRUITS, mission failed
function MissionFailed_Exo_Destroy ()
	MissionFailed ("HUD_MISSION_FAILED_REASON_03")
end

-- one EXO is DESACTIVATED
function One_EXO_Desactivated ()
	RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_18", true, 100, 0,"")
	NewSubObjective ( "Obj_C_1", "Obj_C_2")
	if (_bLife_Weak_Exo_01 <= 0) then
		MiniMapTrack(GetExoskeletonID("Exoskeleton_Convoy_01"),2, false)
	else
		MiniMapTrack(GetExoskeletonID("Exoskeleton_Convoy_02"),2, false)
	end
end

-- two EXO is DESACTIVATED, stil UAN troop
function Two_EXO_Desactivated ()
	RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_19", true, 100, 0,"")
	MiniMapTrack(GetExoskeletonID("Exoskeleton_Convoy_01"),2, false)
	MiniMapTrack(GetExoskeletonID("Exoskeleton_Convoy_02"),2, false)
	NewSubObjective ( "Obj_C_2", "Obj_C_3")
end

-- Tous les mecs du convoy sont mort
function End_Of_Mission_01 ()	
		SetVarValue(GetTimerID("Timer_Convoy_A_00"),"Active",true)
		RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_23", true, 110, 0,"")
end


-- END OF LEVEL
function End_Of_Mission_02 ()
	MissionSucceed ()
end



---------------------------------------------
---------------------------------------------
---------------------------------------------	

