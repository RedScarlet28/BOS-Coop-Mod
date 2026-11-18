function UpdateLevel_Sequence()

end
----------------------------------------------------
--function OnEnter_Sector_Event_Camp(id)
function debut ()
	_idCamTransition_1=GetCamTransitionID("CamTransition_1")
	
--	if(_bOnEnter_Sector_Event_Camp==0)and not(_byet_bOnEnter_Sector_Event_Camp)and IsAlive(_idPlayer)then
		--if(GetLocalCharacterID("Player")==id)then

			ShowCinematicBlackStripes(true)
			StartMusic("Sounds//Music//Bos - War theme.wav",true)
			FreezeAll(_idGroup_EXEC_01,false)
			FreezeAll(_idGroup_Prison,false)
			Freeze(_idChampion,false)


			EnableCharacterCommand(_idPlayer,false)
			EnableCharacterCommand(_idChar_UAN_Infanterie_00_11,false)
			EnableCharacterCommand(_idChar_UAN_Infanterie_00_13,false)
			EnableCharacterCommand(_idChar_UAN_Infanterie_00_14,false)
			EnableCharacterCommand(_idChar_UAN_Infanterie_00_15,false)
			EnableCharacterCommand(_idChar_UAN_Infanterie_00_16,false)

			EnableCharacterCommand(_idChar_WRF_exec_01_1,false)
			CharacterPlaySpecialAction(_idChar_WRF_exec_01_1,"STAND COMPLETE WAIT W_NONE COOL",true,false)

			EnableCharacterCommand(_idChar_WRF_exec_01_2,false)
			CharacterPlaySpecialAction(_idChar_WRF_exec_01_2,"STAND COMPLETE WAIT W_NONE COOL",true,false)

			EnableCharacterCommand(_idChar_WRF_exec_01_3,false)
			CharacterPlaySpecialAction(_idChar_WRF_exec_01_3,"STAND COMPLETE WAIT W_NONE COOL",true,false)

			EnableCharacterCommand(_idChar_WRF_exec_01_4,false)
			CharacterPlaySpecialAction(_idChar_WRF_exec_01_4,"STAND COMPLETE WAIT W_NONE COOL",true,false)

			LaunchCameraTransition(_idCamTransition_1)
			EnableCharacterCommand(_idChampion,false)
		_byet_bOnEnter_Sector_Event_Camp=true
		_bOnEnter_Sector_Event_Camp=1
--		end
--	end 
end
------------------------------------------------------
function Cam_2()

	_idCamTransition_2=GetCamTransitionID("CamTransition_2")
		EnableCharacterCommand(_idChar_UAN_Infanterie_00_11,false)
		EnableCharacterCommand(_idChar_UAN_Infanterie_00_13,false)
		EnableCharacterCommand(_idChar_UAN_Infanterie_00_14,false)
		EnableCharacterCommand(_idChar_UAN_Infanterie_00_15,false)
		EnableCharacterCommand(_idChar_UAN_Infanterie_00_16,false)

		EnableCharacterCommand(_idChar_WRF_exec_01_1,false)
		EnableCharacterCommand(_idChar_WRF_exec_01_2,false)
		EnableCharacterCommand(_idChar_WRF_exec_01_3,false)
		EnableCharacterCommand(_idChar_WRF_exec_01_4,false)
		
		LaunchCameraTransition(_idCamTransition_2)
end
------------------------------------------------------
function Cam_3()

	_idCamTransition_3=GetCamTransitionID("CamTransition_3")
		
	LaunchCameraTransition(_idCamTransition_3)

end
------------------------------------------------------
function Cam_4()

	_idCamTransition_4=GetCamTransitionID("CamTransition_4")
	
	LaunchCameraTransition(_idCamTransition_4)
	SetVarValue(_idChampion,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_anim_exec"))
	EnableCharacterCommand(_idChampion,false)

end
--------------------------------------------------------
function Dial()

MakeCharacterSpeak(_idChampion,_idChar_UAN_Infanterie_00_14,"DIA_GEN_START_FIRE_TEAM_A_VOICE_B_1",true,95,2,1.0,"",95)

end
------------------------------------------------------
function Cam_5()


	_idCamTransition_5=GetCamTransitionID("CamTransition_5")
	
	LaunchCameraTransition(_idCamTransition_5)
	SetVarValue(_idChampion,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_wp_fuite_2"))
	EnableCharacterCommand(_idChampion,true)
	
		EnableCharacterCommand(_idChar_WRF_exec_01_1,true)
		EnableCharacterCommand(_idChar_WRF_exec_01_2,true)
		EnableCharacterCommand(_idChar_WRF_exec_01_3,true)
		EnableCharacterCommand(_idChar_WRF_exec_01_4,true)
end
---------------------------------------------------
function OnEnter_Sector_Event_exec(id)

--	
--	
--	
	_idAI_Order_Goto_Waypoint_exe_4=GetAI_Order_Goto_WaypointID("AI_Order_Goto_Waypoint_exe_4")
--	_idAI_Order_Goto_Waypoint_exe_5=GetAI_Order_Goto_WaypointID("AI_Order_Goto_Waypoint_exe_5")


	if(_bOnEnter_Sector_Event_exec==0)then
		if(id==_idChampion)then
				
		EnableCharacterCommand(_idChar_UAN_Infanterie_00_11,true)
			SetVarValue(_idAI_Order_List_wp_exec_4,"Order",GetAI_Order_Force_TargetID("AI_Order_Force_Target_4"),3)

		EnableCharacterCommand(_idChar_UAN_Infanterie_00_14,true)
			SetVarValue(_idAI_Order_List_wp_exec_4,"Order",GetAI_Order_Force_TargetID("AI_Order_Force_Target_4"),3)		
			SetVarValue(_idAI_Order_Goto_Waypoint_exe_4,"PriorityTorso",1)
--			SetVarValue(_idAI_Order_Goto_Waypoint_exe_5,"PriorityTorso",1)
	
--			SetVarValue(_idChar_WRF_exec_01_1,"Team","WRF")
--			SetVarValue(_idChar_WRF_exec_01_2,"Team","WRF")
--			SetVarValue(_idChar_WRF_exec_01_3,"Team","WRF")
--			SetVarValue(_idChar_WRF_exec_01_4,"Team","WRF")
		_bOnEnter_Sector_Event_exec=1		
		end		
	end
end
--------------------------------------------------
--mort de _idChar_WRF_exec_01_4
function Next_1()


		_idAI_Order_Goto_Waypoint_exe_2=GetAI_Order_Goto_WaypointID("AI_Order_Goto_Waypoint_exe_2")
		_nHealth_idChar_WRF_exec_01_4=GetHealth(_idChar_WRF_exec_01_4)

	if(_nHealth_idChar_WRF_exec_01_4==0)then
			EnableCharacterCommand(_idChar_UAN_Infanterie_00_13,true)
			SetVarValue(_idAI_Order_Goto_Waypoint_exe_2,"PriorityTorso",1)
			SetVarValue(_idAI_Order_List_wp_exec_2,"Order",GetAI_Order_Force_TargetID("AI_Order_Force_Target_2"),3)
	end
end
--------------------------------------------------
--mort de _idChar_WRF_exec_01_2
function Next_2()

	
		_idAI_Order_Goto_Waypoint_exe_3=GetAI_Order_Goto_WaypointID("AI_Order_Goto_Waypoint_exe_3")
		_nHealth_idChar_WRF_exec_01_2=GetHealth(_idChar_WRF_exec_01_2)

	if(_nHealth_idChar_WRF_exec_01_2==0)then		
			EnableCharacterCommand(_idChar_UAN_Infanterie_00_15,true)
			SetVarValue(_idAI_Order_Goto_Waypoint_exe_3,"PriorityTorso",1)
			SetVarValue(_idAI_Order_List_wp_exec_3,"Order",GetAI_Order_Force_TargetID("AI_Order_Force_Target_3"),3)
	end
end
--------------------------------------------------
--mort de _idChar_WRF_exec_01_3
function Next_3()
		
		_idAI_Order_Goto_Waypoint_exe_1=GetAI_Order_Goto_WaypointID("AI_Order_Goto_Waypoint_exe_1")
		_nHealth_idChar_WRF_exec_01_3=GetHealth(_idChar_WRF_exec_01_3)

	if(_nHealth_idChar_WRF_exec_01_3==0)then			
			EnableCharacterCommand(_idChar_UAN_Infanterie_00_16,true)
			SetVarValue(_idAI_Order_Goto_Waypoint_exe_1,"PriorityTorso",1)
			SetVarValue(_idAI_Order_List_wp_exec_1,"Order",GetAI_Order_Force_TargetID("AI_Order_Force_Target_1"),3)
	end
end
--------------------------------------------------

----------------------------------------------------
function EndCam()


	ShowCinematicBlackStripes(false)

	EnableCharacterCommand(_idPlayer,true)
	
--	SetVarValue(_idChar_UAN_Infanterie_00_11,"Position",Vector3D(917.444153,438.532440,4.841035))
		SetVarValue(_idChar_UAN_Infanterie_00_11,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_sniper_01"))

--	SetVarValue(_idChar_UAN_Infanterie_00_14,"Position",Vector3D(953.566345,485.672455,4.841035))
		SetVarValue(_idChar_UAN_Infanterie_00_14,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_sniper_02"))

--	SetVarValue(_idChar_UAN_Infanterie_00_13,"Position",Vector3D(1025.441040,376.947235,4.841035))
		SetVarValue(_idChar_UAN_Infanterie_00_13,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_wp_fuite_3"))

--	SetVarValue(_idChar_UAN_Infanterie_00_15,"Position",Vector3D(1024.174194,359.973145,4.841035))
		SetVarValue(_idChar_UAN_Infanterie_00_15,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_wp_fuite_1"))

--	SetVarValue(_idChar_UAN_Infanterie_00_16,"Position",Vector3D(1011.233765,270.171051,4.841035))
		SetVarValue(_idChar_UAN_Infanterie_00_16,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_wp_fuite_2"))


	Freeze(_idChampion,true)
	SetVarValue(_idChampion,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_champion"))
	SetVarValue(_idChampion,"Position",Vector3D(1081.070923,903.030029,3.899391))

end

















