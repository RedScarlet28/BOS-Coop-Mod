function UpdateLevel_QG ()
	Exploxion_In_Corridor ()
	Defreeze_Group_QG_UAN_03 ()
	Defreeze_Group_QG_UAN_04 ()
	Defreeze_Group_QG_UAN_05 ()
	Defreeze_Group_QG_UAN_06 ()
	Char_Engineer_Go_Near_System ()
	Char_Engineer_Hack_Computer ()
	Char_Engineer_Go_Hacking ()
end

-- Declenchement de l'explosion
-- ATTENTION mercenaire !!!!!!!!!!!!!!!
function Exploxion_In_Corridor ()
	if IsEntityInBox(_idPlayer,"Sector_Event_QG_A_00")
	and IsEntityInBox(_idEngineer,"Sector_Event_QG_A_00") then
		if (_bExploxion_In_Corridor == 0)then
			idexplosion = CreateExplosion ()
			SetVarValue(idexplosion,"Position",Vector3D(872,-1772,20))
			_bExploxion_In_Corridor = 1
		end
	end	
end


-- L'ingénieur dit qu'ils sont pas loin de l'objectif
-- sub objectif DONE
function OnEnter_Sector_Event_QG_B_06 (_idCharInBox)
	if (_idCharInBox == _idEngineer) then
		if (_bOnEnter_Sector_Event_QG_B_06 == 0) then
			MakeCharacterSpeak(_idEngineer,_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_03",true,110,2, 0, "",21)
			

			_bOnEnter_Sector_Event_QG_B_06 = 1
		end
	end
end

-- sub objectif DONE
function OnEnter_Sector_Event_QG_B_07 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_QG_B_07 == 0) then	
			NewSubObjective ("Obj_A_1","Obj_A_2")
			StopMusic()
			_bOnEnter_Sector_Event_QG_B_07 = 1
		end
	end
end



-- Defreeze des gars du QG
function OnEnter_Sector_Event_QG_B_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_QG_B_00 == 0) then
			FreezeAll(GetGroupID("Group_QG_UAN_02"), false)
			_bOnEnter_Sector_Event_QG_B_00 = 1
		end
	end
end

-- defreeze renfort gars du QG
function Defreeze_Group_QG_UAN_03 ()
	if	(AliveMembersCount(GetGroupID("Group_QG_UAN_02"))<= 1)
	or	IsEntityInBox(_idPlayer,"Sector_Event_QG_B_01")
	or	IsEntityInBox(_idPlayer,"Sector_Event_QG_B_05")then
		if (_bDefreeze_Group_QG_UAN_03 == 0) then
			FreezeAll(GetGroupID("Group_QG_UAN_03"), false)
			_bDefreeze_Group_QG_UAN_03 = 1
		end
	end
end

-- defreeze renfort gars du QG...
function Defreeze_Group_QG_UAN_04 ()
	--if	(AliveMembersCount(GetGroupID("Group_QG_UAN_03"))<= 1)
	if	IsEntityInBox(_idPlayer,"Sector_Event_QG_B_03")
	or	IsEntityInBox(_idPlayer,"Sector_Event_QG_B_05")then
		if (_bDefreeze_Group_QG_UAN_04 == 0) then
			FreezeAll(GetGroupID("Group_QG_UAN_04"), false)
			_bDefreeze_Group_QG_UAN_04 = 1
		end
	end
end

-- defreeze renfort gars du QG...
function Defreeze_Group_QG_UAN_05 ()
	if	(AliveMembersCount(GetGroupID("Group_QG_UAN_03"))<= 2)
	or	IsEntityInBox(_idPlayer,"Sector_Event_QG_B_02")
	or	IsEntityInBox(_idPlayer,"Sector_Event_QG_B_04")then
		if (_bDefreeze_Group_QG_UAN_05 == 0) then
			FreezeAll(GetGroupID("Group_QG_UAN_05"), false)
			_bDefreeze_Group_QG_UAN_05 = 1
		end
	end
end

-- defreeze renfort gars du QG...
function Defreeze_Group_QG_UAN_06 ()
	if	(AliveMembersCount(GetGroupID("Group_QG_UAN_05"))<= 2)
	or	IsEntityInBox(_idPlayer,"Sector_Event_QG_B_05")
	or	IsEntityInBox(_idPlayer,"Sector_Event_QG_B_04")then
		if (_bDefreeze_Group_QG_UAN_06 == 0) then
			FreezeAll(GetGroupID("Group_QG_UAN_06"), false)
			_bDefreeze_Group_QG_UAN_06 = 1
		end
	end
end

-- l'ingénieur part près de l'escalier ordi
function Char_Engineer_Go_Near_System ()
		if	(AliveMembersCount(GetGroupID("Group_QG_UAN_02")) <= 0)
		and (AliveMembersCount(GetGroupID("Group_QG_UAN_03")) <= 0)
		and (AliveMembersCount(GetGroupID("Group_QG_UAN_04")) <= 0)
		and (AliveMembersCount(GetGroupID("Group_QG_UAN_06")) <= 0)
		and (AliveMembersCount(GetGroupID("Group_QG_UAN_05")) <= 0)then
			if (_bEngineer_Go_Near_System == 0)then
				SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_O_Use_Path_QG_G"))	
				MakeCharacterSpeak(_idEngineer,_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_25",true,110,2, 0, "",21)

				NewSubObjective ("Obj_A_2","Obj_A_3")
			
				_bEngineer_Go_Near_System = 1
			end
		end
end


-- l'ingénieur part hacker
function Char_Engineer_Go_Hacking ()
	if IsEntityInBox(_idPlayer,"Sector_Event_QG_C_01")
	and IsEntityInBox(_idEngineer,"Sector_Event_QG_C_01") then
		if (_bEngineer_Go_Near_System == 1)then	
			if (_bEngineer_Go_Hacking == 0)then
				SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_O_Use_Path_QG_F"))	
				MakeCharacterSpeak(_idEngineer,_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_26",true,110,2, 0, "",21)						
				_bEngineer_Go_Hacking = 1
			end
		end	
	end
end

function Ouverture_Code_B_Sound ()
	SetVarValue(GetSound_ClientID("Sound_Code_B"),"Playing",true)
end


-- l'ingénieur va hacker l'ordi
function Char_Engineer_Hack_Computer ()
		if	IsEntityInBox(_idEngineer,"Sector_Event_QG_C_00")
		and (_bEngineer_Go_Hacking == 1)then
			if (_bComputer_Hacked == 0)then
				LaunchCameraTransition(GetCamTransitionID("CamTransition_QG_A_01"))
				ShowCinematicBlackStripes(true)
				EnableCharacterCommand(_idPlayer, false)
				MakeCharacterSpeak(_idEngineer,_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_27",true,110,2, 0, "",21)	
				
				_bComputer_Hacked = 1
			end
		end
end

-- cine suite
-- ouverture porte 1
function Cine_QG_A_01()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_QG_A_02"))
	SetVarValue(GetDoorID("Door_01"),"Locked",false) 
	CreationTimer(true,true,false,"Cine_QG_A_01bis",1.8)
end

function Cine_QG_A_01bis()
	SetVarValue(GetDynamic_Light_ClientID("Dynamic_Light_B"),"Color",Color(0.0,1.0,0.0))
end


-- cine suite
-- ouverture porte fin
function Cine_QG_A_02()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_QG_A_03"))
	SetVarValue(GetDoorID("Door_08"),"Locked",false)
	CreationTimer(true,true,false,"Cine_QG_A_02bis",1.8)
end

function Cine_QG_A_02bis()
	SetVarValue(GetDynamic_Light_ClientID("Dynamic_Light_A"),"Color",Color(0.0,1.0,0.0))
end

-- cine suite
function Cine_QG_A_03()
	ShowCinematicBlackStripes(false)
	DisplaySubtitle ( "DIA_SPE_NIV_E_INGENIEUR_04", 0, 3.5 )
	LaunchCameraTransition(GetCamTransitionID("CamTransition_QG_A_04"))
end

-- end cine
-- defreeze d'un dernier petit groupe QG
function Cine_QG_A_04()
	SetVarValue(GetDoorID("Door_11"),"Locked",true)
	EnableCharacterCommand(_idPlayer, true)
	SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Follow_Player"))	
	FreezeAll(GetGroupID("Group_QG_UAN_07"), false)
	SetVarValue(GetSound_ClientID("Sound_Code_B"),"Playing",false)
	SetVarValue(GetSound_ClientID("Sound_QG_Alarm"),"Playing",true)

	ObjectiveDoneNewObjectiveNewSubObjective ("Obj_A","Obj_B","Obj_B_1")
	SetVarValue ( GetObjectiveID ( "Obj_B_a"),"Active", true )

end
