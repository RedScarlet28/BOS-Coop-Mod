function UpdateLevel_Tunnel()
end
--------------------------------------------------------
--LES DIALOGUES UTILISES------------------------------
----------------------------------------------
-----------------------------------------------------------
function Cam_intro()
_idCam_intro=GetCamTransitionID("CamTransition_62")

	if(_bCam_intro==0)then
		EnableCharacterCommand(_idPlayer,false)
		LaunchCameraTransition(_idCam_intro)
		ShowCinematicBlackStripes(true)
		Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_5,true)

		UnLockDoor(_idDoor_bos_1,true)
		UnLockDoor(_idDoor_bos_2,true)
		UnLockDoor(_idDoor_bos_3,true)

		OpenDoor(_idDoor_bos_1,true)
		OpenDoor(_idDoor_bos_2,true)
		OpenDoor(_idDoor_bos_3,true)

		_bCam_intro=1
	end
end
----------------------------------------------------------
function InterCam()
_idInter_cam=GetCamTransitionID("CamTransition_61")
		LaunchCameraTransition(_idInter_cam)
end
-----------------------------------------------------------
function Cam_1()
_idCam_1=GetCamTransitionID("CamTransition_63")
		LaunchCameraTransition(_idCam_1)
		
end
----------------------------------------------------------
function Cam_2()

_idCam_2=GetCamTransitionID("CamTransition_60")
		LaunchCameraTransition(_idCam_2)
		Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_5,true)
		Freeze(_idChar_UAN_Pass_2_00_4,true)
		Freeze(_idChar_UAN_EXOMAN_00_1,false)
		Freeze(_idChar_UAN_Entrance_00_11,false)
		Freeze(_idCharacter_test,false)
end
-----------------------------------------------------------
function Cam_3()

_idCam_3=GetCamTransitionID("CamTransition_59")
		LaunchCameraTransition(_idCam_3)
	Freeze(_idCharacter_test,false)
end
---------------------------------------
function Cam_4()

_idCam_4=GetCamTransitionID("CamTransition_58")
		LaunchCameraTransition(_idCam_4)
end
--------------------------------------
function Cam_5()

_idCam_5=GetCamTransitionID("CamTransition_57")
		LaunchCameraTransition(_idCam_5)

end
----------------------------------
function EndCam()

--	SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Dialogue_intro"))
	if(_idMerc[0] ~= nil)then
	MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_H_INGENIEUR_09",true,100,1,2,"",100.0)
	end
	ShowCinematicBlackStripes(false)
	EnableCharacterCommand(_idPlayer,true)
end
-----------------------------
function OnEnter_Sector_Event_TUNNEL_1(id)

	if(_bOnEnter_Sector_Event_TUNNEL_1==0)then
		if(id == GetLocalCharacterID("Player"))then
			Freeze(_idChar_UAN_Entrance_00_20,true)
			Freeze(_idChar_UAN_Esplanade_01_1,true)
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_5,true)
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_3,true)
			Freeze(_idChar_UAN_Entrance_00_11,true)
			Freeze(_idChar_UAN_Pass_2_00_4,true)
			--Freeze(_idChar_UAN_Mirador_A_00_2,true)
			--Freeze(_idChar_UAN_Mirador_B_00_2,true)
			--Freeze(_idChar_UAN_Mirador_C_00_2,true)
		

			SetFollowMercenaryMinDistPeace(2)
			SetFollowMercenaryMaxDistPeace(4)
			SetFollowMercenaryMinDistCombat(2)
			SetFollowMercenaryMaxDistCombat(5)

			Freeze(_idExoOut,true)
			SetVarValue(_idExoOut,"Position",Vector3D(-281.307404,-645.215027,-21.557636))
			SetVarValue(_idChar_UAN_EXOMAN_00_1,"CharacterOrderList",_idPasdeListe)
			SetVarValue(_idChar_UAN_EXOMAN_00_1,"ExoskeletonAI",GetExoskeleton_AIID("Exoskeleton_AI_UAN"))
			SetVarValue(_idChar_UAN_EXOMAN_00_1,"ExoskeletonOrderList",_idPasdeListe)
			
		_bOnEnter_Sector_Event_TUNNEL_1=1
		end
	end
end
-------------------------------------------------
--function Objectif_Debut()

--	NewObjectiveNewSubObjective("Obj_A","Obj_A_1")
--	SetVarValue(GetObjectiveID("Obj_A_a"),"Active",true)
--end

-----------------------------------------------
function OnExit_Sector_Event_TUNNEL_1(id)

	if(_bOnExit_Sector_Event_TUNNEL_1==0)then
		if(id == GetLocalCharacterID("Player"))then
			if(_idMerc[0] ~= nil)then
			SetVarValue(_idMerc[0],"CharacterOrderList",_idPasdeListe)
			end
		Freeze(_idCharacter_test,false)
		_bOnExit_Sector_Event_TUNNEL_1=1
		end
	end
end
-----------------------------------------------
function OnEnter_Sector_Event_TUNNEL_2(id)

	if(_bOnEnter_Sector_Event_TUNNEL_2==0)then
		if(id == GetLocalCharacterID("Player"))and not(_byetOnEnter_Sector_Event_TUNNEL_2)then
		
			Freeze(_idChar_UAN_Entrance_00_7,false)
			Freeze(_idChar_UAN_Entrance_00_4,false)
			Freeze(_idChar_UAN_Entrance_00_5,false)
			Freeze(_idChar_UAN_Entrance_00_21,false)
			Freeze(_idChar_UAN_Entrance_00_22,false)
				CharacterPlaySpecialAction(_idChar_UAN_Entrance_00_22,"STAND MEDHI ORDER_THIS_WAY W_NONE",true,false)
				CreationTimer(true,true,false,"Stop_Tunnel_anim_02",8.0)

			Freeze(_idChar_UAN_Entrance_00_24,false)
		_byetOnEnter_Sector_Event_TUNNEL_2=true
		_bOnEnter_Sector_Event_TUNNEL_2=1
		end
	end
end
--------------------------------------------------
function Stop_Tunnel_anim_02()

CharacterStopSpecialAction(_idChar_UAN_Entrance_00_22)


end
--------------------------------------------------------
function Mort_1st_Exo()

	if(_bMort_1st_Exo==0)then
		if(_nLife_Exo_UAN_TUNNEL==0)and(IsEntityInBox(_idCharacter_test,"Sector_Event_test_exo_tunnel"))then
			Freeze(_idChar_UAN_Entrance_00_4,false)
			SetVarValue(_idChar_UAN_Entrance_00_4,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_force_attk"))
			Freeze(_idChar_UAN_Entrance_00_5,false)
			SetVarValue(_idChar_UAN_Entrance_00_5,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_force_attk"))
		_bMort_1st_Exo=1
		end
	end
end
----------------------------------------------
function Tunnel()

	if(_bTunnel==0)then
		if(_bAlive_idChar_UAN_Entrance_00_4==false)or(_bAlive_idChar_UAN_Entrance_00_5==false)then
			MakeCharacterSpeak(_idChar_UAN_Entrance_00_22,_idChar_UAN_Entrance_00_24,"DIA_SPE_NIV_H_UAN_B_01",true,100,2,0.0,"",100.0)
			Freeze(_idChar_UAN_Entrance_00_6,false)
			Freeze(_idChar_UAN_Entrance_00_7,false)
			Freeze(_idChar_UAN_Entrance_00_8,false)
			Freeze(_idChar_UAN_Entrance_00_24,false)
			Freeze(_idChar_UAN_Entrance_00_25,false)
			--Freeze(_idChar_UAN_Mirador_A_00_1,false)
			--Freeze(_idChar_UAN_Mirador_B_00_1,false)
			_bTunnel=1
		end
	end
end
-------------------------------------------------------
function OnEnter_Sector_Event_TUNNEL_3(id)

	if(_bOnEnter_Sector_Event_TUNNEL_3==0)then
		if(id == GetLocalCharacterID("Player"))then
			Freeze(_idChar_UAN_Entrance_00_6,false)
			Freeze(_idChar_UAN_Entrance_00_7,false)
			Freeze(_idChar_UAN_Entrance_00_8,false)
			Freeze(_idChar_UAN_Entrance_00_24,false)
			Freeze(_idChar_UAN_Entrance_00_25,false)

				CharacterPlaySpecialAction(_idChar_UAN_Entrance_00_6,"STAND MEDHI ORDER_FOLLOW_ME W_NONE",true,false)
				CreationTimer(true,true,false,"Stop_Tunnel_anim_01",6.0)

			Freeze(_idChar_UAN_Entrance_00_9,false)
			Freeze(_idChar_UAN_Entrance_00_10,false)
			Freeze(_idChar_UAN_Entrance_00_11,false)
			Freeze(_idChar_UAN_Entrance_00_12,false)
			Freeze(_idChar_UAN_Entrance_00_25,false)

		
		--	Freeze(_idChar_UAN_Mirador_A_00_1,false)
		--	Freeze(_idChar_UAN_Mirador_B_00_1,false)
		--	Freeze(_idChar_UAN_Mirador_C_00_1,false)
		_bOnEnter_Sector_Event_TUNNEL_3=1
		end
	end
end
------------------------------------------------------------
function Stop_Tunnel_anim_01()

CharacterStopSpecialAction(_idChar_UAN_Entrance_00_6)

end
------------------------------------------------------------
function OnEnter_Sector_Event_TUNNEL_4(id)

	if(_bOnEnter_Sector_Event_TUNNEL_4==0)then
		if(id == GetLocalCharacterID("Player"))or(_bIS_IN == true)then

			FreezeAll(_idGroup_UAN_Garnison_02,false)
			Freeze(_idExoOut,false)
			Freeze(_idChar_UAN_EXOMAN_00_1,false)
			SetVarValue(_idChar_UAN_EXOMAN_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Char_UAN_EXOMAN_00_1"))
			SetVarValue(_idChar_UAN_EXOMAN_00_1,"ExoskeletonAI",GetExoskeleton_AIID("Exoskeleton_AI_UAN"))
			SetVarValue(_idChar_UAN_EXOMAN_00_1,"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_EXO_UAN"))

		--NewObjectiveNewSubObjective("Obj_A","Obj_A_1")
			RadioMessage("DIA_GEN_MERCE_STOP_VOICE_A_2",true,100,0.0,"")	
			if(_idMerc[0] ~= nil)then
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Use_Pathway_pose_inge"))
			end
			_bOnEnter_Sector_Event_TUNNEL_4=1
		end
	end
end
---------------------------------------------------------
function OnStay_Sector_Event_Hangar(id)

	if(_bOnStay_Sector_Event_Hangar==0)then
		if(id == GetLocalCharacterID("Player"))then

			_byetOnStay_Sector_Event_Hangar=true
				if(_bStop_radio==true)then
				RadioMessage("DIA_GEN_MERCE_STOP_VOICE_A_3",true,100,0.0,"")	
					_bStop_radio=false
				end
				if(_idMerc[0] ~= nil)then
					SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Use_Pathway_pose_inge"))
				end

				if (_idMerc[1] ~= nil)and(_bIS_IN == true)then 
					SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_use_exo_transport"))
					SetVarValue(_idMerc[1],"ExoskeletonAI",GetExoskeleton_AIID("Exoskeleton_AI_8"))
					_bOnStay_Sector_Event_Hangar=1
				end
		end
	end
end
--			if(_byetOnStay_Sector_Event_Hangar==true)and(_bIS_IN == true)then
	--			if (_idMerc[1] ~= nil) then 
	--				SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_use_exo_transport"))
		--			SetVarValue(_idMerc[1],"ExoskeletonAI",GetExoskeleton_AIID("Exoskeleton_AI_8"))
		--		end
		--		_bOnStay_Sector_Event_Hangar=1	
			
--end
--------------------------------------------------------
function OnEnter_Sector_Event_Test_Player_Tunnel(id)

	if(_bOnEnter_Sector_Event_Test_Player_Tunnel==0)then
		if(id==_idPlayer)and(IsAValidID(GetCharacterCurrentExoskeleton(_idPlayer)))then
			if(_idMerc[1]~=nil)then
				EnableCharacterCommand(_idMerc[1],true)
				_bOnEnter_Sector_Event_Test_Player_Tunnel=1
			end		
		end
	end
end
---------------------------------------------------------
function Go_Exo()

	if(_bGo_Exo==0)then
		if((_bAlive_idChar_UAN_Entrance_00_7==false)and(_bAlive_idChar_UAN_Entrance_00_8==false)and 
			(_bAlive_idChar_UAN_Entrance_00_9==false)and(_bAlive_idChar_UAN_Entrance_00_10==false)and 
			(_bAlive_idChar_UAN_Entrance_00_11==false)and(_bAlive_idChar_UAN_Entrance_00_12==false)and(_bOnEnter_Sector_Event_Hangar==1)and(_bIS_IN==true))then
				if (_idMerc[1] ~= nil) then 
					SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_use_exo_transport"))
					SetVarValue(_idMerc[1],"ExoskeletonAI",GetExoskeleton_AIID("Exoskeleton_AI_8"))
					SetFollowMercenaryMaxDistPeaceExo(50)
					SetFollowMercenaryMinDistPeaceExo(25)
					SetFollowMercenaryMaxDistCombatExo(50)
					SetFollowMercenaryMinDistCombatExo(25)
				_bGo_Exo=1
				end
		end
	end
end
--------------------------------------------------------
function In_Exo()
	if(_bIS_IN==true)then
		if (_idMerc[1] ~= nil) then 
				SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_use_exo_transport"))
				SetVarValue(_idMerc[1],"ExoskeletonAI",GetExoskeleton_AIID("Exoskeleton_AI_8"))
		end
	end
end
----------------------------------
function Re_Exo()

if(_bIS_IN==true)and(_bMercIS_IN ==false)then
		if (_idMerc[1] ~= nil) then 
				SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_use_exo_transport"))
				SetVarValue(_idMerc[1],"ExoskeletonAI",GetExoskeleton_AIID("Exoskeleton_AI_8"))
		end
	end
end
----------------------------------
function OnEnter_Sector_Event_exit_exo(id)

	if(_bOnEnter_Sector_Event_exit_exo==0)then
		if(id == GetLocalCharacterID("Player"))then
				SetMercenaryFollow(_idMerc[0],true)
		--	SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Use_Pathway_inge_1"))
			if (_idMerc[1] ~= nil)then 
			SetVarValue(_idMerc[1],"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_exit_exo"))
			SetMercenaryFollow(_idMerc[1],true)
			_bOut=true
			end
		end
	
			if(_bOut==true)then
				if (_idMerc[1] ~= nil)then
				SetVarValue(_idMerc[1],"CharacterOrderList",_idPasdeListe)
				SetMercenaryFollow(_idMerc[1],true)
				end
			end
		StopMusic()
		_bOnEnter_Sector_Event_exit_exo=1
	end
end
---------------
function Vie()

if(_bVie==0)then
	if (_idMerc[0]~=nil)and not IsAlive(_idMerc[0])then
		EnableCharacterCommand(_idPlayer,false)
		RadioMessage("DIA_SPE_NIV_K_GENERAL_RADIO_08",true,100,0.0,"")
		MissionFailed ("HUD_MISSION_FAILED_REASON_02")

	_bVie=1
	end
end
end
------------------
function MaVie()

_bAlivePlayer=IsAlive(_idPlayer)
	if(_bMaVie==0)then
		if(_bAlivePlayer==false)then
		MissionFailed("HUD_MISSION_FAILED_REASON_01")
		_bMaVie=1
		end
	end
end
------------------------------------------
function Merc_Sort_Exo()

	if(_bIS_IN==false)and(_byet_Use_Player_exo==true)and(_bMercIS_IN==true)then
		if (_idMerc[1] ~= nil)then 
		--	SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_use_exo_transport"))
		--	SetVarValue(_idMerc[1],"ExoskeletonAI",GetExoskeleton_AIID("Exoskeleton_AI_8"))
			
			SetVarValue(_idMerc[1],"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_exit_exo"))
			SetVarValue(_idMerc[1],"CharacterOrderList",_idPasdeListe)
			--In_Exo()
		end
	end
end
---------------------------------
function OnEnter_Sector_Event_SECURE_DEAD(id)


		if(id==_idPlayer)then
			MissionFailed("HUD_MISSION_FAILED_REASON_01")
			DamageCharacter(_idPlayer,10000)
		end

		if(id==_idMerc[1])then
			DamageCharacter(_idMerc[1],10000)
		end

		if(id==_idMerc[0])then
			EnableCharacterCommand(_idPlayer,false)
			RadioMessage("DIA_SPE_NIV_K_GENERAL_RADIO_08",true,100,0.0,"")
			DamageCharacter(_idMerc[0],10000)
			MissionFailed ("HUD_MISSION_FAILED_REASON_02")
		end

		if(id~=_idPlayer)or(id~=_idMerc[0])or(id~=_idMerc[1])then
			Freeze(id,true)
		end


end