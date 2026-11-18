function UpdateLevel_SCENE()
end
----------------------------------
----------------------------------
function Plan_Fix()

_idCamTransition_planfix=GetCamTransitionID("CamTransition_planfix")

	if(_bPlan_Fix==0)then
		--Freeze(_idChar_UAN_SCENE_00_1,false)
	--	Freeze(_idChar_UAN_SCENE_00_2,false)
	--	Freeze(_idChar_UAN_SCENE_00_3,false)
		--Freeze(_idChar_UAN_SCENE_00_4,false)
	--	Freeze(_idChar_UAN_SCENE_00_5,false)
		--Freeze(_idChar_UAN_SCENE_00_6,false)
		
		LaunchCameraTransition(_idCamTransition_planfix)
		ShowCinematicBlackStripes(true)
		CreationTimer(true, true, false,"Decal_gars_1",0.55)
		UnLockDoor(_idDoor_bos_1,true)
		UnLockDoor(_idDoor_bos_2,true)
		UnLockDoor(_idDoor_bos_3,true)
		UnLockDoor(_idDoor_bos_4,true)
		UnLockDoor(_idDoor_bos_5,true)
		UnLockDoor(_idDoor_bos_6,true)
		UnLockDoor(_idDoor_bos_7,true)
		UnLockDoor(_idDoor_bos_8,true)


		OpenDoor(_idDoor_bos_1,true)
		OpenDoor(_idDoor_bos_2,true)
		OpenDoor(_idDoor_bos_3,true)
		OpenDoor(_idDoor_bos_4,true)
		OpenDoor(_idDoor_bos_5,true)
		OpenDoor(_idDoor_bos_6,true)
		OpenDoor(_idDoor_bos_7,true)
		OpenDoor(_idDoor_bos_8,true)


		CharacterPlaySpecialAction(_idChar_UAN_SCENE_00_2,"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
		
		CharacterPlaySpecialAction(_idChar_UAN_SCENE_00_1,"STAND COMPLETE LAUGHT W_ALL_2HAND_LIGHT",true,false)

		EnableCharacterCommand(_idPlayer,false)
		EnableCharacterCommand(_idMerc[0],true)
		if(_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1],true)
		end
		_bPlan_Fix=1		
	end
end
-------------------------------
function Decal_gars_1()
		CreationTimer(true, true, false,"Order_Come",4.40)
		Freeze(_idChar_UAN_SCENE_00_3,false)
		
end
-----------------------------------
function Order_Come()

SetVarValue(_idChar_UAN_SCENE_00_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_SCENE_04"))
end
---------------------------------
function Cam_2()
_idCamTransition_Cam2=GetCamTransitionID("CamTransition_Cam2")
	FreezeAll(_idGroup_PLATEFORME_1,false)
	FreezeAll(_idGroup_PLATEFORME_2,false)
	
	LaunchCameraTransition(_idCamTransition_Cam2)
	
end
----------------------------------
function Cam_3()

_idCamTransition_Cam3=GetCamTransitionID("CamTransition_Cam3")

	LaunchCameraTransition(_idCamTransition_Cam3)

	Freeze(_idChar_UAN_SCENE_00_1,true)
	CharacterStopSpecialAction(_idChar_UAN_SCENE_00_1)

	Freeze(_idChar_UAN_SCENE_00_2,true)
	CharacterStopSpecialAction(_idChar_UAN_SCENE_00_2)	

	Freeze(_idChar_UAN_SCENE_00_3,true)
	Freeze(_idChar_UAN_SCENE_00_4,true)
	Freeze(_idChar_UAN_SCENE_00_5,true)
	Freeze(_idChar_UAN_SCENE_00_6,true)
	Freeze(_idChar_UAN_TECHROOM_00_1,false)

end
---------------------------------
function Cam_4()
_idCamTransition_Cam4=GetCamTransitionID("CamTransition_Cam4")
--_idSound_Client_509=GetSound_ClientID("Sound_Client_509")
_idDynamic_Light_Client_26=GetDynamic_Light_ClientID("Dynamic_Light_Client_26")
_idTimer_change_color=GetTimerID("Timer_change_color")

	LaunchCameraTransition(_idCamTransition_Cam4)

--		Freeze(_idChar_UAN_SCENE_00_1,false)
--		Freeze(_idChar_UAN_SCENE_00_10,false)
--		Freeze(_idChar_UAN_SCENE_00_11,false)
--		Freeze(_idChar_UAN_SCENE_00_12,false)
--		Freeze(_idChar_UAN_SCENE_00_14,false)

	FreezeAll(_idGroup_PLATEFORME_1,true)
	FreezeAll(_idGroup_PLATEFORME_2,true)

	SetVarValue(_idChar_UAN_TECHROOM_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_scene_hack"))
	SetVarValue(_idTimer_change_color,"Active",true)

end
---------------------------------
function Change_color_command()

_idDynamic_Light_Client_26=GetDynamic_Light_ClientID("Dynamic_Light_Client_26")
	if(_bChange_color==0)then
	SetVarValue(_idDynamic_Light_Client_26,"Color",Color(0,1,0))
--	SetVarValue(_idSound_Client_509,"Playing",false)
	_bChange_color=1
	end
end
------------------------------------
function Cam_4x()
_idCamTransition_Cam4x=GetCamTransitionID("CamTransition_Cam4x")

LaunchCameraTransition(_idCamTransition_Cam4x)

end
---------------------------------
function Cam_4x1()
_idCamTransition_Cam4x1=GetCamTransitionID("CamTransition_Cam4x1")

LaunchCameraTransition(_idCamTransition_Cam4x1)

end
-----------------------------------
function Cam_4a()

_idCamTransition_Cam4a=GetCamTransitionID("CamTransition_Cam4a")
_idTimer_change_Door=GetTimerID("Timer_change_Door")
	FreezeAll(_idGroup_PATROUILLE_B,false)
	LaunchCameraTransition(_idCamTransition_Cam4a)

	SetVarValue(_idTimer_change_Door,"Active",true)
end
-------------------------------
function Change_color_DOOR()

_idDynamic_Light_Client_27=GetDynamic_Light_ClientID("Dynamic_Light_Client_27")
_idGlow_Client_127=GetGlow_ClientID("Glow_Client_127")
_idDoor_tunnel_A=GetDoorID("Door_tunnel_A")
_idDoor_tunnel_B=GetDoorID("Door_tunnel_B")
	if(_bChange_Door==0)then
	SetVarValue(_idDynamic_Light_Client_27,"Color",Color(0,1,0))
	SetVarValue(_idGlow_Client_127,"Color",Color(0,1,0))

	OpenDoor(_idDoor_tunnel_A)
	OpenDoor(_idDoor_tunnel_B)
	--	Freeze(_idChar_UAN_SCENE_00_10,false)
		Freeze(_idChar_UAN_SCENE_00_11,false)
		Freeze(_idChar_UAN_SCENE_00_12,false)
		Freeze(_idChar_UAN_SCENE_00_14,false)
	_bChange_Door=1
	end
end
---------------------------------------
function Cam_4a1()

_idCamTransition_Cam4a1=GetCamTransitionID("CamTransition_Cam4a1")

	LaunchCameraTransition(_idCamTransition_Cam4a1)

end
---------------------------------------
function Cam_5()
_idCamTransition_Cam5=GetCamTransitionID("CamTransition_Cam5")

	LaunchCameraTransition(_idCamTransition_Cam5)

	Freeze(_idChar_UAN_TECHROOM_00_1,true)
	Freeze(_idChar_UAN_SCENE_00_1,true)
		Freeze(_idChar_UAN_SCENE_00_10,true)
		Freeze(_idChar_UAN_SCENE_00_11,true)
		Freeze(_idChar_UAN_SCENE_00_12,true)
		Freeze(_idChar_UAN_SCENE_00_14,true)
end
----------------------------------
function EndCam()

_idTimer_Obj=GetTimerID("Timer_Obj")

		FreezeAll(_idGroup_PATROUILLE_B,true)
		EnableCharacterCommand(_idPlayer,true)
			Freeze(_idChar_UAN_SCENE_00_10,true)
		Freeze(_idChar_UAN_SCENE_00_11,true)
		Freeze(_idChar_UAN_SCENE_00_12,true)
		Freeze(_idChar_UAN_SCENE_00_14,true)
		ShowCinematicBlackStripes(false)
		EnableCharacterCommand(_idMerc[0],true)
		if(_idMerc[1] ~= nil) then
			EnableCharacterCommand(_idMerc[1],true)
		end
		SetVarValue(_idTimer_Obj,"Active",true)
		RadioMessage("DIA_SPE_NIV_K_INGENIEUR_09",true,100,2,"")
end
---------------------------------
function Intro_Obj()

	if(_bIntro_Obj==0)then
			NewObjectiveNewSubObjective("Obj_A","Obj_A_1")
			FreezeAll(_idGroup_TUNNEL_04,false)
		_bIntro_Obj=1
	end
end
----------------------------------