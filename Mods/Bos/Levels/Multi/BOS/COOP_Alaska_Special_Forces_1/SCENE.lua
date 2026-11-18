function UpdateLevel_Scene()
end
---------------------------------------
function Cam_intro()

_idCam_intro=GetCamTransitionID("CamTransition_intro")

	if(_bCam_intro==0)then
		LaunchCameraTransition(_idCam_intro)
		ShowCinematicBlackStripes(true)
			EnableCharacterCommand(_idPlayer,false)
			Freeze(_idChar_WRF_01_1,true)
			Freeze(_idChar_WRF_01_2,true)
		if(_idMerc[0]~=nil)then
			Freeze(_idMerc[0],true)
		end
		if(_idMerc[1]~=nil)then
			Freeze(_idMerc[1],true)
		end
		
		Freeze(_idChar_UAN_Entrepot_00_7,false)
		Freeze(_idChar_UAN_Entrepot_00_8,false)
--		Freeze(_idChar_UAN_Entrepot_00_9,false)
		Freeze(_idChar_UAN_Entrepot_00_16,false)
		

		_bCam_intro=1
	end
end
--------------------------------------
function Cam_1()

_idCam_1=GetCamTransitionID("CamTransition_1")

			LaunchCameraTransition(_idCam_1)
			EnableCharacterCommand(_idChar_SCENE_00_3,true)
			EnableCharacterCommand(_idChar_SCENE_00_4,true)
			EnableCharacterCommand(_idChar_SCENE_00_5,true)
			EnableCharacterCommand(_idChar_SCENE_00_6,true)
			
			SetVarValue(_idParticleFX_Client_1023,"Link To Camera",false)
end
----------------------------------------
function Cam_2()
_idCam_2=GetCamTransitionID("CamTransition_2")
	
		LaunchCameraTransition(_idCam_2)
		Freeze(_idChar_UAN_Entrepot_00_7,true)
		Freeze(_idChar_UAN_Entrepot_00_8,true)
		Freeze(_idChar_UAN_Entrepot_00_9,true)
		Freeze(_idChar_UAN_Entrepot_00_16,true)
		
		SetVarValue(_idParticleFX_Client_1023,"Link To Camera",true)
	
		Freeze(_idChar_SCENE_00_3,false)
		Freeze(_idChar_SCENE_00_4,false)
		Freeze(_idChar_SCENE_00_5,false)
		Freeze(_idChar_SCENE_00_6,false)
		Freeze(_idChar_UAN_Place_00_1,false)
	 	Freeze(_idChar_UAN_Place_00_6,false)

		Freeze(_idChar_SCENE_00_1,false)
		Freeze(_idChar_SCENE_00_2,false)

end
----------------------------------------
function Cam_3()

_idCam_3=GetCamTransitionID("CamTransition_3")
	
	LaunchCameraTransition(_idCam_3)


	
end
-----------------------------------
function Cam_4()

_idCam_4=GetCamTransitionID("CamTransition_4")
	
	LaunchCameraTransition(_idCam_4)
	Freeze(_idChar_WRF_01_1,false)
	Freeze(_idChar_WRF_01_2,false)
		if(_idMerc[0]~=nil)then
			Freeze(_idMerc[0],false)
		end
		if(_idMerc[1]~=nil)then
			Freeze(_idMerc[1],false)
		end
end
---------------------------------
function Cam_5()

_idCam_5=GetCamTransitionID("CamTransition_5")
	
	LaunchCameraTransition(_idCam_5)
	
	Freeze(_idPlayer,false)	
	if(_idMerc[0]~=nil)then
	SetVarValue(_idMerc[0],"Position",Vector3D(-378.907013,-414.460480,147.468170))
	end
	SetVarValue(_idChar_WRF_01_1,"Position",Vector3D(-303.139282,-414.460480,107.961609))
	SetVarValue(_idChar_WRF_01_2,"Position",Vector3D(-333.088837,-414.460480,108.885986))

end
----------------------------------
function EndCam()

_idTimer_Obj=GetTimerID("Timer_Obj")

			RadioMessage("DIA_SPE_NIV_G_GENERAL_RADIO_01",true,100,0.0,"")
			SetVarValue(_idTimer_Obj,"Active",true)
			ShowCinematicBlackStripes(false)
			EnableCharacterCommand(_idPlayer,true)
		Freeze(_idChar_SCENE_00_1,true)
		Freeze(_idChar_SCENE_00_2,true)
		Freeze(_idChar_SCENE_00_3,true)
		Freeze(_idChar_SCENE_00_4,true)
		Freeze(_idChar_SCENE_00_5,true)
		Freeze(_idChar_SCENE_00_6,true)
		Freeze(_idChar_UAN_Place_00_1,true)
	 	Freeze(_idChar_UAN_Place_00_6,true)
			
	Objectif_Principal_1()

end