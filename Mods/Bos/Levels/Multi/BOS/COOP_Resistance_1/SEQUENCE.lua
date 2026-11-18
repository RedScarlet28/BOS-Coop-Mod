function UpdateLevel_SEQUENCE()
end
------------------------------------
function Cam_1()

_idCamTransition_A=GetCamTransitionID("CamTransition_A")

	if(_bCam_1==0)then
	LaunchCameraTransition(_idCamTransition_A)

	EnableCharacterCommand(_idPlayer,false)
	if(_idMerc[0]~=nil)then
	EnableCharacterCommand(_idMerc[0],false)
	end
	if(_idMerc[1]~=nil)then
	EnableCharacterCommand(_idMerc[1],false)
	CharacterPlaySpecialAction(_idMerc[1],"STAND COMPLETE WAIT W_NONE COOL",true,false)
	end
	ShowCinematicBlackStripes(true)
	EnableCharacterCommand(_idChar_HANG,false)
	EnableCharacterCommand(_idChar_RES_CAMP_00_7,false)
	EnableCharacterCommand(_idChar_RES_CAMP_00_8,false)
	EnableCharacterCommand(_idChar_RES_CAMP_00_9,false)
	EnableCharacterCommand(_idChar_RES_CAMP_00_10,false)
	EnableCharacterCommand(_idChar_RES_CAMP_00_11,false)
	EnableCharacterCommand(_idChar_RES_CAMP_00_12,false)
	EnableCharacterCommand(_idChar_RES_CAMP_00_13,false)
	EnableCharacterCommand(_idChar_RES_CAMP_00_14,false)
	_bCam_1=1
	end
end
-----------------------------------------------------------
function Cam_2()
_idCamTransition_B=GetCamTransitionID("CamTransition_B")

LaunchCameraTransition(_idCamTransition_B)

end
-----------------------------------------------------------
function Cam_2_1()
_idCamTransition_B1=GetCamTransitionID("CamTransition_B1")

LaunchCameraTransition(_idCamTransition_B1)
Freeze(_idChar_RES_CAMP_00_22,true)
Freeze(_idChar_RES_CAMP_00_23,true)

--Freeze(_idChar_RES_CAMP_00_24,true)
end
-----------------------------------------------------------
function Cam_3()
_idCamTransition_C=GetCamTransitionID("CamTransition_C")

		LaunchCameraTransition(_idCamTransition_C)
		MakeCharacterSpeak(_idChar_HANG,_idChar_RES_CAMP_00_8,"DIA_SPE_NIV_N_RESIS_A_01",true,95,2,0.0,"",95)
			CharacterPlaySpecialAction(_idChar_HANG,"STAND COMPLETE TALK_FAR W_ALL_2HAND_LIGHT",true,false)

end
-----------------------------------------------------------
function Cam_4()

_idCamTransition_D=GetCamTransitionID("CamTransition_D")

_idWaypoint_Scene_2=GetWaypointID("Waypoint_SCENE_2")
_idWaypoint_Scene_4=GetWaypointID("Waypoint_SCENE_4")

	LaunchCameraTransition(_idCamTransition_D)
	MakeCharacterSpeak(_idChar_HANG,_idChar_RES_CAMP_00_8,"DIA_SPE_NIV_N_RESIS_A_02",true,95,2,0.0,"",95)	
	CharacterPlaySpecialAction(_idChar_HANG,"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)

	SetGodMode(_idMerc[0],true)
			SetVarValue(_idWaypoint_Scene_2,"MovementType","Running")
			SetVarValue(_idWaypoint_Scene_4,"MovementType","Running")
end
------------------------
function Cam_5()

_idCamTransition_D1=GetCamTransitionID("CamTransition_D1")
_idTimer_Explo=GetTimerID("Timer_Explo")

	LaunchCameraTransition(_idCamTransition_D1)
		CharacterPlaySpecialAction(_idChar_RES_CAMP_00_7,"STAND COMPLETE MILITARY_SALUT W_ALL_2HAND_LIGHT",false,false)
		CreationTimer(true, true, false,"Decal_gars_1",0.02)
		CharacterStopSpecialAction(_idChar_HANG)
		SetVarValue(_idTimer_Explo,"Active",true)		
end
--CharacterPlaySpecialAction(idCharacter, strSpecialActionName, bLoop, bOneFrame)
--CharacterStopSpecialAction(idCharacter)
--

--------------------------------------------------
function Decal_gars_1()
--CharacterPlaySpecialAction(_idChar_RES_CAMP_00_8,"STAND COMPLETE BOS VICTORY_ARM_UP W_ALL_2HAND_HEAVY",false,false)
MakeCharacterSpeak(_idChar_RES_CAMP_00_8,_idChar_HANG,"DIA_SPE_NIV_O_RESIS_F_01",true,95,2,0.0,"",95)
CreationTimer(true, true, false,"Decal_gars_2",1)

end
--------------------------------------------------
function Decal_gars_2()
CharacterPlaySpecialAction(_idChar_RES_CAMP_00_9,"STAND COMPLETE MILITARY_SALUT W_ALL_2HAND_LIGHT",false,false)
		
CreationTimer(true, true, false,"Decal_gars_4",0.05)
end
-----
function Decal_gars_3()
--CharacterPlaySpecialAction(_idChar_RES_CAMP_00_10,"STAND COMPLETE BOS VICTORY_ARM_UP W_ALL_2HAND_HEAVY",false,false)

CreationTimer(true, true, false,"Decal_gars_5",0.05)
end
---
function Decal_gars_4()
CharacterPlaySpecialAction(_idChar_RES_CAMP_00_11,"STAND COMPLETE MILITARY_SALUT W_ALL_2HAND_LIGHT",false,false)

CreationTimer(true, true, false,"Decal_gars_3",0.05)
end
-----
function Decal_gars_5()
--CharacterPlaySpecialAction(_idChar_RES_CAMP_00_12,"STAND COMPLETE BOS VICTORY_ARM_UP W_ALL_2HAND_HEAVY",false,false)

CreationTimer(true, true, false,"Decal_gars_6",0.05)
end
----
function Decal_gars_6()
CharacterPlaySpecialAction(_idChar_RES_CAMP_00_13,"STAND COMPLETE MILITARY_SALUT W_ALL_2HAND_LIGHT",false,false)
		MakeCharacterSpeak(_idChar_RES_CAMP_00_13,_idChar_HANG,"DIA_SPE_NIV_O_RESIS_F_01",true,95,2,0.0,"",95)
				SetVarValue(_idSound_Client_PLANE_blaster,"Playing",true)
CreationTimer(true, true, false,"Decal_gars_7",0.05)
end
----
function Decal_gars_7()
--CharacterPlaySpecialAction(_idChar_RES_CAMP_00_14,"STAND COMPLETE BOS VICTORY_ARM_UP W_ALL_2HAND_HEAVY",false,false)

end
----

-------------------------------------------------
function Cam_6()

_idCamTransition_E=GetCamTransitionID("CamTransition_E")


	LaunchCameraTransition(_idCamTransition_E)
	
	CharacterPlaySpecialAction(_idChar_RES_CAMP_00_5,"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)

--	SetVarValue(_idChar_RES_CAMP_00_5,"Rotation",Vector3D(-2.097627,1.517841,1.689164))
	--	SetVarValue(_idChar_RES_CAMP_00_6,"Rotation",Vector3D(-1.410796,0.639998,1.490797))
	--	MakeCharacterSpeak(_idChar_RES_CAMP_00_6,_idChar_RES_CAMP_00_5,"DIA_GEN_DO_HEAR_NOISE_TEAM_A_VOICE_B_1",true,100,2,0.0,"",100.0)

end
-----------------------------------------------------
function Cam_7()

_idCamTransition_E1=GetCamTransitionID("CamTransition_E1")


	LaunchCameraTransition(_idCamTransition_E1)
	

end
-------------------------------------------------
function Explo()


_idRocket_1st=CreateRocket()
_idRocket_2nd=CreateRocket()
_idTimer_Alarm_Air=GetTimerID("Timer_Alarm_Air")

		SetVarValue(_idRocket_1st,"Type","Projectile_Rocket_Bombardement_Hurt_2")
		SetVarValue(_idRocket_1st,"Position",Vector3D(-267.230408,-766.862122,400))
		SetVarValue(_idRocket_1st,"Rotation",Vector3D(1.570796,3.040012,-1.570796))

			SetVarValue(_idRocket_2nd,"Type","Projectile_Rocket_Bombardement_Hurt_2")
			SetVarValue(_idRocket_2nd,"Position",Vector3D(-305.837372,-382.895172,674.673157))
			SetVarValue(_idRocket_2nd,"Rotation",Vector3D(1.570796,3.040012,-1.570796))

		SetVarValue(_idTimer_Alarm_Air,"Active",true)
		
end
----------------------------------------------------------------------
function Alarm()

_idSound_Client_Alarm_air=GetSound_ClientID("Sound_Client_Alarm_air")
_idTimer_Depart=GetTimerID("Timer_Depart")

		SetVarValue(_idSound_Client_Alarm_air,"Playing",true)
		SetVarValue(_idTimer_Depart,"Active",true)
end
---------------------------------------------------------------------
function Depart()

		if(_bDepart==0)then


		Freeze(_idChar_RES_CAMP_00_8,true)

		Freeze(_idChar_RES_CAMP_00_10,true)

		Freeze(_idChar_RES_CAMP_00_12,true)

	EnableCharacterCommand(_idChar_RES_CAMP_00_7,true)
			SetVarValue(_idChar_RES_CAMP_00_7,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))

--	EnableCharacterCommand(_idChar_RES_CAMP_00_8,true)
--			SetVarValue(_idChar_RES_CAMP_00_8,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))

	EnableCharacterCommand(_idChar_RES_CAMP_00_9,true)
		SetVarValue(_idChar_RES_CAMP_00_9,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))
	
--	EnableCharacterCommand(_idChar_RES_CAMP_00_10,true)
--		SetVarValue(_idChar_RES_CAMP_00_10,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))
		
	EnableCharacterCommand(_idChar_RES_CAMP_00_11,true)
		SetVarValue(_idChar_RES_CAMP_00_11,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))

--	EnableCharacterCommand(_idChar_RES_CAMP_00_12,true)
--		SetVarValue(_idChar_RES_CAMP_00_12,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))
	
	EnableCharacterCommand(_idChar_RES_CAMP_00_13,true)
		SetVarValue(_idChar_RES_CAMP_00_13,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))
		CharacterPlaySpecialAction(_idChar_RES_CAMP_00_13,"STAND MEDHI ORDER_SEPARATE W_NONE",true,false)

	EnableCharacterCommand(_idChar_RES_CAMP_00_14,true)
		SetVarValue(_idChar_RES_CAMP_00_14,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))

	EnableCharacterCommand(_idChar_RES_CAMP_00_15,true)
		SetVarValue(_idChar_RES_CAMP_00_15,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))

	EnableCharacterCommand(_idChar_RES_CAMP_00_16,true)
		SetVarValue(_idChar_RES_CAMP_00_16,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))

	EnableCharacterCommand(_idChar_RES_CAMP_00_17,true)
		SetVarValue(_idChar_RES_CAMP_00_17,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))

	EnableCharacterCommand(_idChar_RES_CAMP_00_18,true)
		SetVarValue(_idChar_RES_CAMP_00_18,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))

	EnableCharacterCommand(_idChar_RES_CAMP_00_19,true)
		SetVarValue(_idChar_RES_CAMP_00_19,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))

	EnableCharacterCommand(_idChar_RES_CAMP_00_20,true)
		SetVarValue(_idChar_RES_CAMP_00_20,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))

	EnableCharacterCommand(_idChar_RES_CAMP_00_21,true)
		SetVarValue(_idChar_RES_CAMP_00_21,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))

	EnableCharacterCommand(_idChar_RES_CAMP_00_22,true)
		SetVarValue(_idChar_RES_CAMP_00_22,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))
		

	EnableCharacterCommand(_idChar_RES_CAMP_00_23,true)
		SetVarValue(_idChar_RES_CAMP_00_23,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))

	EnableCharacterCommand(_idChar_RES_CAMP_00_24,true)
		SetVarValue(_idChar_RES_CAMP_00_24,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))
		CharacterPlaySpecialAction(_idChar_RES_CAMP_00_24,"STAND MEDHI ORDER_SEPARATE W_NONE",true,false)
	SetVarValue(_idChar_RES_CAMP_00_2,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))

	MakeCharacterSpeak(_idChar_RES_CAMP_00_13,_idChar_RES_CAMP_00_9,"DIA_SPE_NIV_J_USWE_A_6",false,100,2,0.0,"",100.0)
		_bDepart=1
	end
end
----------------------------------------------------------------------
function OnEnter_Sector_Event_Boom_1(id)

	_idRocket_2=GetTimerID("Rocket_2")

	if(_bOnEnter_Sector_Event_Boom_1==0)then
		if(id==_idChar_RES_CAMP_00_13)then
		_idRocket_1st=CreateRocket()
		SetVarValue(_idRocket_1st,"Type","Projectile_Rocket_Bombardement_Hurt_2")
		SetVarValue(_idRocket_1st,"Position",Vector3D(-322.873260,-664.633484,145.288116))
		SetVarValue(_idRocket_1st,"Rotation",Vector3D(0.0,3.059998,0.000000))
					
				SetVarValue(_idRocket_2,"Active",true)

					SetVarValue(_idChar_RES_CAMP_00_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_LEFT_01"))
					SetGodMode(_idChar_RES_CAMP_00_2,true)
	
					SetVarValue(_idChar_RES_CAMP_00_4,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_LEFT_02"))
					SetGodMode(_idChar_RES_CAMP_00_4,true)

					SetVarValue(_idChar_RES_CAMP_00_24,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_LEFT_03"))
					SetGodMode(_idChar_RES_CAMP_00_24,true)

				--	SetVarValue(_idChar_RES_CAMP_00_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_Middle_01"))
				--	SetGodMode(_idChar_RES_CAMP_00_3,true)

					--SetVarValue(_idChar_RES_CAMP_00_15,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_Middle_02"))
				--SetGodMode(_idChar_RES_CAMP_00_15,true)

					SetVarValue(_idChar_RES_CAMP_00_18,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_Middle_03"))
					SetGodMode(_idChar_RES_CAMP_00_18,true)

			_bOnEnter_Sector_Event_Boom_1=1
		end
	end
end
----------------------------------------------------------------------------------
function Rocket_2nd()

			_idRocket_3=GetTimerID("Rocket_3")

			_idRocket_2nd=CreateRocket()
			SetVarValue(_idRocket_2nd,"Type","Projectile_Rocket_Bombardement_Hurt_2")
			SetVarValue(_idRocket_2nd,"Position",Vector3D(-269.971130,-742.895752,147.508179))
			SetVarValue(_idRocket_2nd,"Rotation",Vector3D(0.000000,3.059998,-1.570796))

			SetVarValue(_idRocket_3,"Active",true)
			if(_idMerc[0]~=nil)then
				EnableCharacterCommand(_idMerc[0],true)
				SetVarValue(_idMerc[0],"CharacterAI",GetCharacter_AIID("Character_AI_Merc_0"))
			end
end
-------------------------------------------------------------------------------------
function Rocket_3rd()
	_idRocket_3rd=CreateRocket()
	_idTimer_Message_0=GetTimerID("Timer_Message_0")
		SetVarValue(_idRocket_3rd,"Type","Projectile_Rocket_Bombardement_Hurt_2")
		SetVarValue(_idRocket_3rd,"Position",Vector3D(-277.404877,-653.154358,157.345428))
		SetVarValue(_idRocket_3rd,"Rotation",Vector3D(0.000000,3.059998,-1.570796))

	
		if(_idMerc[1]~=nil)then
				CharacterStopSpecialAction(_idMerc[1])
				EnableCharacterCommand(_idMerc[1],true)
		end

		EnableCharacterCommand(_idPlayer,true)
		SetVarValue(_idTimer_Message_0,"Active",true)
		PauseMusic()
		ShowCinematicBlackStripes(false)
end
---------------------------------------------------------------------------------

------------------------------------------------------------------------------------
function Change_list_Huber()

_idAI_Order_List_Huber=GetAI_Order_ListID("AI_Order_List_Huber")
	
	SetVarValue(_idAI_Order_List_Huber,"Order",GetAI_Order_Goto_WaypointID("AI_Order_Goto_Waypoint_Huber_colline"),1)
	Freeze(_idChar_RES_CAMP_00_20,true)
	Freeze(_idChar_RES_CAMP_00_21,true)
	
	StartMusic("Sounds//Music//BoS - Resistance theme.wav",true)
	EnableCharacterCommand(_idChar_HANG,true)	
	SetVarValue(_idChar_HANG,"CharacterAI",GetCharacter_AIID("Character_AI_PANIC"))

		SetVarValue(_idChar_RES_CAMP_00_16,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_FOLLOW_HANG"))
		SetVarValue(_idChar_RES_CAMP_00_17,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_FOLLOW_HANG"))
		SetVarValue(_idChar_RES_CAMP_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_FOLLOW_HANG"))
		SetVarValue(_idChar_RES_CAMP_00_22,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_FOLLOW_HANG"))
		SetVarValue(_idChar_RES_CAMP_00_23,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_FOLLOW_HANG"))

end
-------------------------------------------------------------------------------------------
function OnEnter_Sector_Event_Ascenseur(id)

		if(_bOnEnter_Sector_Event_Ascenseur==0)then
			if(id==_idChar_HANG)then
				Freeze(_idChar_HANG,true)
				Freeze(_idChar_RES_CAMP_00_16,true)				
				Freeze(_idChar_RES_CAMP_00_17,true)
				Freeze(_idChar_RES_CAMP_00_1,true)
				Freeze(_idChar_RES_CAMP_00_22,true)
				Freeze(_idChar_RES_CAMP_00_23,true)
			_bOnEnter_Sector_Event_Ascenseur=1
		end
	end
end
----------------------------------------------------------------------
function OnEnter_Sector_Event_Tente_1_heliport(id)


	if(_bOnEnter_Sector_Event_Tente_1_heliport==0)then
		if(id==_idChar_RES_CAMP_00_19)then
			Freeze(_idChar_RES_CAMP_00_19,true)
		end	
		if(id==_idChar_RES_CAMP_00_1)then
			Freeze(_idChar_RES_CAMP_00_1,true)
		_bOnEnter_Sector_Event_Tente_1_heliport=1
		end
	end
end
-----------------------------------------------------------------------
function Renforts()

		if not IsAlive(_idChar_RES_CAMP_00_3)and(_bPlayerInControl_Right==true)then
				Freeze(_idChar_RES_CAMP_00_1,false)
				SetVarValue(_idChar_RES_CAMP_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_Middle_03"))
		end
		if not IsAlive(_idChar_RES_CAMP_00_15)and(_bPlayerInControl_Right==true)then
				Freeze(_idChar_RES_CAMP_00_16,false)
				SetVarValue(_idChar_RES_CAMP_00_16,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_Middle_01"))
		end
		if not IsAlive(_idChar_RES_CAMP_00_18)and(_bPlayerInControl_Right==true)then
				Freeze(_idChar_RES_CAMP_00_17,false)
				SetVarValue(_idChar_RES_CAMP_00_17,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_Middle_02"))
		end
end
-------------------------------------------------------------------------
