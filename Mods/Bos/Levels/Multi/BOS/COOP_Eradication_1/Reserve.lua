function UpdateLevel_Reserve()
end

-------------------------------------
--function OnStay_Sector_Event_Reserve(idReserve)
--	if (id == idReserve)then 
--	SetVarValue(idReserve,"Team","NONE")
--	end
--end
--------------------------------------
--Lancement de la caméra du début de la cinématique--Le joueur ne controle plus le perso
function CAM()

_idcamera_intro=GetCamTransitionID("CamTransition_intro")

	if(_bCam==0)then
ShowCinematicBlackStripes(true)
LaunchCameraTransition(_idcamera_intro)
EnableCharacterCommand(_idPlayer,false)
		_bCam=1
	--	_bCam_intro_fin=true
	end
end
--------------------------------------
--Plan fixe de la cinématique--Dialogue
function CAM_fix()

_idCamTransition_fixe_instuct=GetCamTransitionID("CamTransition_fixe_instuct")

LaunchCameraTransition(_idCamTransition_fixe_instuct)
MakeCharacterSpeak(_idChar_SYND_00_1,_idPlayer,"DIA_SPE_NIV_N_GENERAL_01",true,100,1,0.0,"",100)

end

-------------------------

-------------------------------------------
--Lancement de la caméra Champ--Dialogue
function Cam_champ()

_idCamTransition_champ=GetCamTransitionID("CamTransition_champ")

	LaunchCameraTransition(_idCamTransition_champ)
	MakeCharacterSpeak(_idChar_SYND_00_1,_idPlayer,"DIA_SPE_NIV_N_GENERAL_02",true,100,1,0.0,"",100)
	
end
--------------------------------------
--Lancement de la caméra Contre-Champ--
function Cam_contre_champ()

_idCamTransition_contre_champ=GetCamTransitionID("CamTransition_contre_champ")

	LaunchCameraTransition(_idCamTransition_contre_champ)
	MakeCharacterSpeak(_idChar_SYND_00_1,_idPlayer,"DIA_SPE_NIV_N_GENERAL_03",true,100,1,0.0,"",100)
	Freeze(_idChar_RES_ExoMan_00_2,false)
end
-------------------------------------------------------------
--Caméra travelling sur les gars qui courent

function Cam_1()

_idCamTransition_1=GetCamTransitionID("CamTransition_1")
	
	LaunchCameraTransition(_idCamTransition_1)
--Les troupes alliés au joueur,se voient attribuer des ordres, et des characIA
	SetVarValue(_idChar_SYND_02_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_2"))
	SetVarValue(_idChar_SYND_02_1,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))
		
	SetVarValue(_idChar_SYND_02_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_3"))
	SetVarValue(_idChar_SYND_02_2,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))

	SetVarValue(_idChar_SYND_02_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_1bis"))
	SetVarValue(_idChar_SYND_02_3,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))

	SetVarValue(_idChar_SYND_02_4,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_4"))
	SetVarValue(_idChar_SYND_02_4,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))

	SetVarValue(_idChar_SYND_03_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_2bis"))
	SetVarValue(_idChar_SYND_03_1,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))

	SetVarValue(_idChar_SYND_03_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_3"))
	SetVarValue(_idChar_SYND_03_2,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))

	SetVarValue(_idChar_SYND_03_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_1"))
	SetVarValue(_idChar_SYND_03_3,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))

	SetVarValue(_idChar_SYND_03_4,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_4"))
	SetVarValue(_idChar_SYND_03_4,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))	
	--On freeze ceux qui sont hors champ,
	FreezeAll(_idGroup_SYND_01,true)
	FreezeAll(_idGroup_SYND_04,true)
	FreezeAll(_idGroup_SYND_05,true)
	--Freeze(_idChar_SYND_00_1,true)
	--on defreeze les deux ars du premier rempart
	Freeze(_idChar_RES_Coursive_00_2,true)
	Freeze(_idChar_RES_Coursive_00_10,false)
	--Ces deux gars se voient attribués une character IA d'élite pour pouvoir tuer le gars qui s'arrete
--devant la camera 1
	SetVarValue(_idChar_RES_Coursive_00_2,"CharacterAI",GetCharacter_AIID("Character_AI_elite"))
	SetVarValue(_idChar_RES_Coursive_00_10,"CharacterAI",GetCharacter_AIID("Character_AI_elite"))
	SetVarValue(_idChar_SYND_02_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_go_wp_arret"))
--on baisse les valeur de vie et enleve le casque du gars qui doit mourir
	SetVarValue(_idChar_SYND_02_2,"HelmetHitPoints",0)
	SetVarValue(_idChar_SYND_02_2,"Health",5)
	
end
----------------------------------------------------
----Lancement de la caméra 2 sur l'exo
function Cam_2()

_idCamTransition_2=GetCamTransitionID("CamTransition_2")
	SetVarValue(_idPlayer,"Rotation",Vector3D(-1.527610,1.679998,0.043186))
	LaunchCameraTransition(_idCamTransition_2)
	EnableCharacterCommand(_idPlayer,true)
	ShowCinematicBlackStripes(false)
	SetVarValue(_idChar_SYND_02_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_2"))
	SetVarValue(_idChar_SYND_02_1,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))
		
	SetVarValue(_idChar_SYND_02_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_1"))
	SetVarValue(_idChar_SYND_02_2,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))

	SetVarValue(_idChar_SYND_02_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_1bis"))
	SetVarValue(_idChar_SYND_02_3,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))

	SetVarValue(_idChar_SYND_02_4,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_4"))
	SetVarValue(_idChar_SYND_02_4,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))

	SetVarValue(_idChar_SYND_03_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_2bis"))
	SetVarValue(_idChar_SYND_03_1,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))

	SetVarValue(_idChar_SYND_03_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_3"))
	SetVarValue(_idChar_SYND_03_2,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))

	SetVarValue(_idChar_SYND_03_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_1"))
	SetVarValue(_idChar_SYND_03_3,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))

	SetVarValue(_idChar_SYND_03_4,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_4"))
	SetVarValue(_idChar_SYND_03_4,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))	
--On freeze les persos dont on  pas besoin 
	Freeze(_idChar_SYND_02_4,true)
--	Freeze(_idChar_RES_Coursive_00_10,true)
	Freeze(_idChar_RES_Coursive_00_1,true)
	Freeze(_idChar_SYND_03_4,true)
	Freeze(_idChar_SYND_04_1,true)
	Freeze(_idChar_SYND_04_2,true)
	Freeze(_idChar_SYND_04_3,true)
	Freeze(_idChar_SYND_05_1,true)
	Freeze(_idChar_SYND_05_3,true)
	Freeze(_idChar_SYND_05_4,true)
	Freeze(_idChar_SYND_01_1,true)
	Freeze(_idChar_SYND_01_2,true)
	Freeze(_idChar_SYND_01_3,true)
	Freeze(_idChar_SYND_01_4,true)
	Freeze(_idChar_SYND_00_1,true)
	Freeze(_idChar_SYND_00_2,true)
	FreezeAll(_idGroup_SYND_01,true)
	FreezeAll(_idGroup_SYND_04,true)
	FreezeAll(_idGroup_SYND_05,true)
	SetVarValue(_idChar_SYND_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_1"))
	SetVarValue(_idChar_SYND_00_1,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))
end
--------------------------------------------------------
--Lancement de la caméra 3 sur la plaine travelling_On réattribue des charcIA normaux 
--aux gars du remparts
function Cam_3()

_idCamTransition_3=GetCamTransitionID("CamTransition_3")

	LaunchCameraTransition(_idCamTransition_3)
	SetVarValue(_idChar_RES_Coursive_00_2,"CharacterAI",GetCharacter_AIID("Character_AI_RES"))
	SetVarValue(_idChar_RES_Coursive_00_10,"CharacterAI",GetCharacter_AIID("Character_AI_RES"))
	SetVarValue(_idChar_RES_Coursive_00_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_vide"))
	SetVarValue(_idChar_RES_Coursive_00_10,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_vide"))
end
----------------------------------------------
----Lancement de la caméra 4--
function Cam_4()

_idCamTransition_4=GetCamTransitionID("CamTransition_4")
SetVarValue(_idPlayer,"Rotation",Vector3D(-1.527610,1.679998,0.043186))
	LaunchCameraTransition(_idCamTransition_4)
--Le joueur reprend la main sur son perso
	
	EnableCharacterCommand(_idPlayer,true)

--On freeze les persos dont on  pas besoin 
	Freeze(_idChar_SYND_02_4,true)
--	Freeze(_idChar_RES_Coursive_00_10,true)
	Freeze(_idChar_RES_Coursive_00_1,true)
	Freeze(_idChar_SYND_03_4,true)
	Freeze(_idChar_SYND_04_1,true)
	Freeze(_idChar_SYND_04_2,true)
	Freeze(_idChar_SYND_04_3,true)
	Freeze(_idChar_SYND_05_1,true)
	Freeze(_idChar_SYND_05_3,true)
	Freeze(_idChar_SYND_05_4,true)
	Freeze(_idChar_SYND_01_1,true)
	Freeze(_idChar_SYND_01_2,true)
	Freeze(_idChar_SYND_01_3,true)
	Freeze(_idChar_SYND_01_4,true)
	Freeze(_idChar_SYND_00_1,true)
	Freeze(_idChar_SYND_00_2,true)
	SetVarValue(_idChar_SYND_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_1"))
	SetVarValue(_idChar_SYND_00_1,"CharacterAI",GetCharacter_AIID("Character_AI_SYND"))
end
---------------------------------------------
--en passant dans cette boite, on installe la mise enscène de gars qui se battent contre ceux du
--remparts
function OnEnter_Sector_Event_depart(id)

	_idTimer=GetTimerID("Timer_Explosion")
	_idPasdeListe=GetInvalidEntityID()

	if(_bOnEnter_Sector_Event_depart==0)then
		if(id == GetLocalCharacterID("player"))then
			Freeze(_idChar_RES_Coursive_00_10,true)
			--Freeze(_idChar_RES_ExoMan_00_1,false)
			TankFireAtPosition(_idTank_3,Vector3D(159.363480,-134.022858,74.294785)) 	
			SetVarValue(_idChar_SYND_00_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_go_wp_6"))
			SetVarValue(_idChar_SYND_00_2,"CharacterAI",GetCharacter_AIID("Character_AI_SYND1"))

			SetVarValue(_idChar_SYND_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_4"))
			SetVarValue(_idChar_SYND_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_1bis"))
			SetVarValue(_idChar_SYND_01_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_3"))
			SetVarValue(_idChar_SYND_01_4,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_limitzone_2bis"))

--on declenche les explosions tombés du ciel, crées dans Explosion.lua
				SetVarValue(_idTimer,"Active",true)
				SetVarValue(_idTimer,"Loop",true)
					if (_idMerc[1]~=nil) then
				SetVarValue(_idMerc_1,"CharacterOrderList",_idPasdeListe)
					end	
				SetVarValue(_idMerc_0,"CharacterOrderList",_idPasdeListe)
				NewObjectiveNewSubObjective ( "Obj_A", "Obj_A_1" )
				SetVarValue(GetObjectiveID("Obj_A_a"),"Active",true)
				--EnableCharacterCommand(_idChar_RES_ExoMan_00_2,false)
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
-----------------------------------------
------------------
function MaVie()

_bAlivePlayer=IsAlive(_idPlayer)
	if(_bMaVie==0)then
		if(_bAlivePlayer==false)then
		MissionFailed ("HUD_MISSION_FAILED_REASON_01")
		_bMaVie=1
		end
	end
end


