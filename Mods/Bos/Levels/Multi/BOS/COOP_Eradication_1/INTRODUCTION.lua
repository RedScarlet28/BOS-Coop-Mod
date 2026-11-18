function UpdateLevel_INTRODUCTION()
end
------------------------------------------------
function CAM_1()

_idCamTransition_intro=GetCamTransitionID("CamTransition_intro")
	if(_bCAM_1==0)then

		if(_idMerc[0]~=nil)then
		EnableCharacterCommand(_idMerc[0],false)
		end
		if(_idMerc[1]~=nil)then
		EnableCharacterCommand(_idMerc[1],false)
		end	
		EnableCharacterCommand(_idPlayer,false)


		EnableCharacterCommand(_idChar_SYND_00_1,false)
		EnableCharacterCommand(_idChar_SYND_02_1,false)
		EnableCharacterCommand(_idChar_SYND_02_2,false)
		EnableCharacterCommand(_idChar_SYND_03_2,false)
		EnableCharacterCommand(_idChar_SYND_03_3,false)

			LaunchCameraTransition(_idCamTransition_intro)
			CharacterPlaySpecialAction(_idChar_SYND_00_1,"STAND COMPLETE TALK_FAR W_ALL_2HAND_LIGHT",true,false)
			ShowCinematicBlackStripes(true)
		_bCAM_1=1
	end
end
------------------------------------------------
function Cam_2()

_idCamTransition_fixe_instuct=GetCamTransitionID("CamTransition_fixe_instuct")
	MakeCharacterSpeak(_idChar_SYND_02_1,_idPlayer,"DIA_SPE_NIV_N_GENERAL_01",true,100,1,0.0,"",100)

	CharacterPlaySpecialAction(_idChar_SYND_02_1,"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)

	LaunchCameraTransition(_idCamTransition_fixe_instuct)

end
----------------------------------------------------
function Cam_3()

_idCamTransition_champ=GetCamTransitionID("CamTransition_champ")

	CharacterPlaySpecialAction(_idChar_SYND_02_1,"STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)
--	CharacterStopSpecialAction(_idChar_SYND_02_1)

	MakeCharacterSpeak(_idChar_SYND_02_1,_idPlayer,"DIA_SPE_NIV_N_GENERAL_02",true,100,1,0.0,"",100)
	LaunchCameraTransition(_idCamTransition_champ)
end
------------------------------------------------------
function Cam_4()

_idCamTransition_contre_champ=GetCamTransitionID("CamTransition_contre_champ")
	Freeze(_idChar_RES_ExoMan_00_2,false)
	CreationTimer(true,true,false,"Hit_chest",3.0)
	MakeCharacterSpeak(_idChar_SYND_02_1,_idPlayer,"DIA_SPE_NIV_N_GENERAL_03",true,100,1,0.0,"",95)
	
	LaunchCameraTransition(_idCamTransition_contre_champ)
end
------------------------------------
function Hit_chest()

CharacterPlaySpecialAction(_idChar_SYND_02_1,"STAND COMPLETE BOS HIT_CHEST W_ALL_2HAND_LIGHT",true,false)
end
-----------------------------------------------------
function Cam_5()

_idCamTransition_exo=GetCamTransitionID("CamTransition_exo")
	CharacterStopSpecialAction(_idChar_SYND_02_1)
	LaunchCameraTransition(_idCamTransition_exo)
end
---------------------------------
function END_CAM_INTRO()

		if(_idMerc[0]~=nil)then
		EnableCharacterCommand(_idMerc[0],true)
		end
		if(_idMerc[1]~=nil)then
		EnableCharacterCommand(_idMerc[1],true)
		end	
		EnableCharacterCommand(_idPlayer,true)

		EnableCharacterCommand(_idChar_SYND_00_1,true)
		EnableCharacterCommand(_idChar_SYND_02_1,true)
		EnableCharacterCommand(_idChar_SYND_02_2,true)
		EnableCharacterCommand(_idChar_SYND_03_2,true)
		EnableCharacterCommand(_idChar_SYND_03_3,true)
		
		CharacterStopSpecialAction(_idChar_SYND_00_1)
		CharacterStopSpecialAction(_idChar_SYND_02_1)
		CharacterStopSpecialAction(_idPlayer)
		ShowCinematicBlackStripes(false)
		Freeze(_idChar_RES_Ruine_00_1,false)
		
		StartMusic("Sounds//Music//BoS - Eradication theme.wav",true)
end

---------------------------------------------
--en passant dans cette boite, on installe la mise enscène de gars qui se battent contre ceux du
--remparts
function OnEnter_Sector_Event_depart(id)

	_idTimer=GetTimerID("Timer_Explosion")
	_idPasdeListe=GetInvalidEntityID()

	if(_bOnEnter_Sector_Event_depart==0)then
		if(id == _idPlayer)then
			Freeze(_idChar_RES_Coursive_00_4,false)
			TankFireAtPosition(_idTank_3,Vector3D(159.363480,-134.022858,74.294785)) 	

--on declenche les explosions tombés du ciel, crées dans Explosion.lua
				SetVarValue(_idTimer,"Active",true)
				SetVarValue(_idTimer,"Loop",true)
--On dit a l'inge d'aller aux ruines, vers son premeir point.
					if (_idMerc[0]~=nil) then
				SetVarValue(_idMerc_0,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_INGE"))
				RadioMessage("DIA_SPE_NIV_J_USWE_A_5",true,100,0.0,"")
				CharacterPlaySpecialAction(_idMerc_0,"STAND MEDHI ORDER_FOLLOW_ME W_NONE",true,false)
					end
				if (_idMerc[1]~=nil) then
				SetVarValue(_idMerc_1,"CharacterOrderList",_idPasdeListe)
				end
				NewObjectiveNewSubObjective ( "Obj_A", "Obj_A_1" )
				SetVarValue(GetObjectiveID("Obj_A_a"),"Active",true)
			_bOnEnter_Sector_Event_depart=1
		end
	end
end
---------------------------------------------------------
function Change_Ars_MERC()

		 
		if(_nBotsActifs<=13)then
				SetVarValue(_idMerc_0,"CurrentSlot","TwoHanded")
					if (_idMerc[1]~=nil) then
			 			SetVarValue(_idMerc_1,"CurrentSlot","Heavy")
					end
		else SetVarValue(_idMerc_0,"CurrentSlot","TwoHanded")
					if (_idMerc[1]~=nil) then
			 			SetVarValue(_idMerc_1,"CurrentSlot","TwoHanded")
					end
		end
end
--------------------------------------
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

----------------------------------
function MaVie()

_bAlivePlayer=IsAlive(_idPlayer)
	if(_bMaVie==0)then
		if(_bAlivePlayer==false)then
		MissionFailed("HUD_MISSION_FAILED_REASON_01")
		_bMaVie=1
		end
	end
end
---------------------------------

--dials :DIA_SPE_NIV_H_INGENIEUR_31(Damn Bastards,  they were waiting for us !)
--DIA_SPE_NIV_H_INGENIEUR_26(i'll not go anywhere while thos...)
--DIA_SPE_NIV_H_INGENIEUR_24(clean this i stay in position)
--((_bAlive_idGroup_Ruine_01~=false)or(_bAlive_idGroup_Ruine_03~=false)
																	--		or(_bAlive_idGroup_Ruine_05~=false)
															--			or(_bAlive_idGroup_Ruine_06~=false))
--
--
---