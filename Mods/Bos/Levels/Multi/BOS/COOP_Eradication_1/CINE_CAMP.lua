function UpdateLevel_CINE_CAMP()
end
----------------------------------------------------------------
--------------------------------------------------------------------
function Cam_camp()

_idCam_Camp=GetCamTransitionID("CamTransition_camp")

_idTimer_HANGARCAM=GetTimerID("Timer_HANGARCAM")
		if(_bCam_camp==0)then
			if(_bOnEnter_Sector_Event_CORNICHE==1)then
				Freeze(_idChar_RES_ExoMan_00_1,false)
				Freeze(_idChar_RES_ExoMan_00_2,false)
				SetVarValue(_idTimer_HANGARCAM,"Active",true)
				EnableCharacterCommand(_idChar_RES_Coursive_00_22,false)
				EnableCharacterCommand(_idChar_RES_Coursive_00_23,false)
				EnableCharacterCommand(_idChar_RES_Camp_00_9,false)		
				EnableCharacterCommand(_idChar_RES_Camp_00_12,false)
			_bCam_camp=1
			end
		end
end
-----------------------
function TIMER_CAM_CAMP()
_idCam_Camp=GetCamTransitionID("CamTransition_camp")
			ShowCinematicBlackStripes(true)
			LaunchCameraTransition(_idCam_Camp)

		Teletransportation("Char_Repere_CineCamp1",_idPlayer)			

		if (_idMerc[1] ~= nil) then 
			Teletransportation("Char_Repere_CineCamp2",_idMerc[1])	
			EnableCharacterCommand(_idMerc[1],false)	
		end
		if (_idMerc[0] ~= nil) then
			Teletransportation("Char_Repere_CineCamp3",_idMerc[0])
			EnableCharacterCommand(_idMerc[0],false)		
		end
			
			Freeze(_idChar_RES_SCENE_00_1,false)
			Freeze(_idChar_RES_SCENE_00_2,false)
			Freeze(_idChar_RES_SCENE_00_3,false)
			Freeze(_idChar_RES_SCENE_00_4,false)
			Freeze(_idChar_RES_SCENE_00_5,false)
			Freeze(_idChar_RES_SCENE_00_6,false)
			Freeze(_idChar_RES_SCENE_00_7,false)
			Freeze(_idChar_RES_SCENE_00_8,false)
			Freeze(_idChar_RES_SCENE_00_9,false)
			Freeze(_idChar_RES_SCENE_00_10,false)
			Freeze(_idChar_RES_SCENE_00_11,false)
			Freeze(_idChar_RES_SCENE_00_12,false)
			
			Freeze(_idChar_RES_HANGAR_00_1,true)
			Freeze(_idChar_RES_HANGAR_00_2,true)
			Freeze(_idChar_RES_HANGAR_00_3,true)
			Freeze(_idChar_RES_HANGAR_00_4,true)
			Freeze(_idChar_RES_HANGAR_00_5,true)
			Freeze(_idChar_RES_HANGAR_00_6,true)
			Freeze(_idChar_RES_HANGAR_00_7,true)
			Freeze(_idChar_RES_HANGAR_00_8,true)
			Freeze(_idChar_RES_Camp_00_5,true)
			Freeze(_idChar_RES_Camp_00_10,true)	
			Freeze(_idChar_RES_Camp_00_11,true)
			Freeze(_idChar_RES_Camp_01_1,true)
			Freeze(_idChar_RES_Camp_01_2,true)
			Freeze(_idChar_RES_Camp_01_3,true)
			Freeze(_idChar_RES_Camp_01_4,true)

		Freeze(_idChar_SYND_00_1,true)
		Freeze(_idChar_SYND_02_1,true)
		Freeze(_idChar_SYND_02_2,true)
		Freeze(_idChar_SYND_03_2,true)
		Freeze(_idChar_SYND_03_3,true)

				EnableCharacterCommand(_idPlayer,false)
				EnableCharacterCommand(_idChar_RES_Camp_00_5,false)
				EnableCharacterCommand(_idChar_RES_Camp_00_10,false)
				EnableCharacterCommand(_idChar_RES_Camp_00_11,false)
				EnableCharacterCommand(_idChar_RES_Camp_01_1,false)
				EnableCharacterCommand(_idChar_RES_Camp_01_2,false)
				EnableCharacterCommand(_idChar_RES_Camp_01_3,false)
				EnableCharacterCommand(_idChar_RES_Camp_01_4,false)
end
-------------------------------------------------------------------------------
function Cam_inter()
_idCam_inter=GetCamTransitionID("CamTransition_camp_inter")

	LaunchCameraTransition(_idCam_inter)
	Freeze(_idChar_RES_SCENE_00_11,false)
end
----------------------------------------------------
function Cam_Hangar()

_idCam_hangar=GetCamTransitionID("CamTransition_hangar")
		Freeze(_idChar_RES_HANGAR_00_1,false)
		Freeze(_idChar_RES_HANGAR_00_2,false)
		Freeze(_idChar_RES_HANGAR_00_3,false)
		Freeze(_idChar_RES_HANGAR_00_4,false)
		Freeze(_idChar_RES_HANGAR_00_5,false)
		Freeze(_idChar_RES_HANGAR_00_6,false)
		Freeze(_idChar_RES_HANGAR_00_7,false)
		Freeze(_idChar_RES_HANGAR_00_8,false)
		Freeze(_idChar_RES_HANGAR_00_14,false)
		Freeze(_idChar_RES_Camp_00_1,true)
			Freeze(_idChar_RES_Camp_00_2,true)
			Freeze(_idChar_RES_Camp_00_3,true)
			Freeze(_idChar_RES_Camp_00_4,true)
			Freeze(_idChar_RES_Camp_00_6,true)
			Freeze(_idChar_RES_Camp_00_7,true)
			Freeze(_idChar_RES_Camp_00_8,true)
			Freeze(_idChar_RES_Camp_00_14,true)
			Freeze(_idChar_RES_Camp_00_13,true)

			Freeze(_idChar_RES_SCENE_00_1,true)
			Freeze(_idChar_RES_SCENE_00_2,true)
			Freeze(_idChar_RES_SCENE_00_3,true)
			Freeze(_idChar_RES_SCENE_00_4,true)
			Freeze(_idChar_RES_SCENE_00_5,true)
			Freeze(_idChar_RES_SCENE_00_6,true)
			Freeze(_idChar_RES_SCENE_00_7,true)
			Freeze(_idChar_RES_SCENE_00_8,true)
			Freeze(_idChar_RES_SCENE_00_9,true)
			Freeze(_idChar_RES_SCENE_00_10,true)
			Freeze(_idChar_RES_SCENE_00_11,true)
			Freeze(_idChar_RES_SCENE_00_12,true)


		EnableCharacterCommand(_idChar_RES_Camp_00_8,false)
		LaunchCameraTransition(_idCam_hangar)
		RadioMessage("DIA_SPE_NIV_N_RESIS_A_01",true,100,0.0,"")
end
------------------------------------------------------------
function Cam_Hangar_Fix()

_idCam_hangar_fix=GetCamTransitionID("CamTransition_hangar_fix")
	
		LaunchCameraTransition(_idCam_hangar_fix)
		EnableCharacterCommand(_idChar_RES_Camp_00_8,false)
		CharacterPlaySpecialAction(_idChar_RES_Camp_00_8,"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
		MakeCharacterSpeak(_idChar_RES_HANGAR_00_8,_idChar_RES_HANGAR_00_6,"DIA_SPE_NIV_N_RESIS_A_02",true,100,2,0.0,"",100)
		Freeze(_idChar_RES_HANGAR_00_1,false)
		Freeze(_idChar_RES_HANGAR_00_2,true)
		Freeze(_idChar_RES_HANGAR_00_3,true)
		Freeze(_idChar_RES_HANGAR_00_4,true)
		Freeze(_idChar_RES_HANGAR_00_5,true)
		Freeze(_idChar_RES_HANGAR_00_6,true)
		Freeze(_idChar_RES_HANGAR_00_7,true)
		Freeze(_idChar_RES_HANGAR_00_14,true)
end
-----------------
function EndCam_HANGAR_FIX()

--		CharacterStopSpecialAction(_idChar_RES_Camp_00_8)
	--	SetVarValue(_idChar_RES_Camp_00_8,"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		ShowCinematicBlackStripes(true)

end
----------------------------------------------------------

------------------------------------------------------------------
function End_Cam()

	ShowCinematicBlackStripes(false)

	FreezeAll(_idGroup_CAMP_01,false)

	EnableCharacterCommand(_idChar_RES_Coursive_00_22,true)
	EnableCharacterCommand(_idChar_RES_Coursive_00_23,true)
	EnableCharacterCommand(_idChar_RES_Camp_00_9,true)			
	EnableCharacterCommand(_idChar_RES_Camp_00_12,true)	
	
	EnableCharacterCommand(_idPlayer,true)
	EnableCharacterCommand(_idChar_RES_Camp_00_5,true)
	EnableCharacterCommand(_idChar_RES_Camp_00_10,true)
	EnableCharacterCommand(_idChar_RES_Camp_00_11,true)
	EnableCharacterCommand(_idChar_RES_Camp_01_1,true)
	EnableCharacterCommand(_idChar_RES_Camp_01_2,true)
	EnableCharacterCommand(_idChar_RES_Camp_01_3,true)
	EnableCharacterCommand(_idChar_RES_Camp_01_4,true)
	
		----
	Freeze(_idChar_RES_Camp_00_1,true)
	Freeze(_idChar_RES_Camp_00_2,true)
	Freeze(_idChar_RES_Camp_00_3,true)
	Freeze(_idChar_RES_Camp_00_4,true)
	Freeze(_idChar_RES_Camp_00_6,true)
	Freeze(_idChar_RES_Camp_00_7,true)
	Freeze(_idChar_RES_Camp_00_13,true)
	Freeze(_idChar_RES_Camp_00_8,true)
	Freeze(_idChar_RES_Camp_00_14,true)
		----
	Freeze(_idChar_RES_HANGAR_00_1,true)
	Freeze(_idChar_RES_HANGAR_00_2,true)
	Freeze(_idChar_RES_HANGAR_00_3,true)
	Freeze(_idChar_RES_HANGAR_00_4,true)
	Freeze(_idChar_RES_HANGAR_00_5,true)
	Freeze(_idChar_RES_HANGAR_00_6,true)
	Freeze(_idChar_RES_HANGAR_00_7,true)
	Freeze(_idChar_RES_HANGAR_00_8,true)

	-----

	Freeze(_idChar_RES_Camp_00_8,true)

	Freeze(_idChar_RES_Coursive_00_1,true)
	Freeze(_idChar_RES_Coursive_00_7,true)

	-----
	FreezeAll(_idGroup_BATAILLE,true)
	FreezeAll(_idGroup_SYND_01,true)
	FreezeAll(_idGroup_SYND_02,true)
	FreezeAll(_idGroup_SYND_03,true)
	FreezeAll(_idGroup_SYND_04,true)
	FreezeAll(_idGroup_SYND_05,true)

			ObjectiveDoneNewObjectiveNewSubObjective("Obj_A","Obj_B","Obj_B_1")

			Freeze(_idExoskeleton_Hangar_3,false)
			Freeze(_idExoskeleton_Hangar_5,false)	
			MiniMapTrack(_idExoskeleton_Hangar_3,2,true)
			MiniMapTrack(_idExoskeleton_Hangar_5,2,true) 

		if (_idMerc[1] ~= nil) then 
			EnableCharacterCommand(_idMerc[1],true)	
		end
		if (_idMerc[0] ~= nil) then
			EnableCharacterCommand(_idMerc[0],true)		
		end

end