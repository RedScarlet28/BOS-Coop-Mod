function UpdateLevel_Game()
end
------------------------------------
function Message_1()

	RadioMessage("DIA_SPE_NIV_N_GENERAL_RADIO_14",true,100,0.0,"")
	TankTargetEntity(_idTank_SYND_01,_idChar_RES_CAMP_00_3)
end
----------------------------------------
function Message_0()

	if(_bOnEnter_Sector_Event_0==0)then
		local nNumb1 = GetRandom(1,2)
			if (nNumb1 == 1)then
				local nNumber1 = GetRandom(1,3)
					if (nNumber1 == 1) then
							MakeCharacterSpeak(_idChar_HANG,_idPlayer,"DIA_SPE_NIV_O_RESIS_A_16",false,100,2,0.0,"",100.0)
					elseif (nNumber1 == 2) then
							MakeCharacterSpeak(_idChar_HANG,_idPlayer,"DIA_SPE_NIV_I_USWE_C_02",false,100,2,0.0,"",100.0)
					elseif (nNumber1 == 2) then
							MakeCharacterSpeak(_idChar_HANG,_idPlayer,"DIA_SPE_NIV_J_USWE_A_6",false,100,2,0.0,"",100.0)
					end
			 end
	end
end
-------------------------------------------------
function OnEnter_Sector_Event_Game(id)


_idTimer_Huber_Move=GetTimerID("Timer_Huber_Move")

	if(_bOnEnter_Sector_Event_Game==0)then
		if(id==_idPlayer)then
			MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_GEN_SEE_EXOSKELETON_TEAM_B_VOICE_A_1",true,100,2,0.0,"",100.0)
			NewSubObjective("Obj_1_1","Obj_1_2")

			Freeze(_idExoskeleton_1,false)
			MiniMapTrack(_idMerc[0],2,false)	
			MiniMapTrack(_idMerc[0],4,true)
			MiniMapTrack(_idExoskeleton_1,2,true)
			Freeze(_idChar_SYND_Exoman_01,false)

			Freeze(_idExoskeleton_3,false)
			MiniMapTrack(_idExoskeleton_3,2,true)
			Freeze(_idChar_SYND_Exoman_03,false)

			Freeze(_idChar_SYND_01,false)
			Freeze(_idChar_SYND_02,false)	
			Freeze(_idChar_SYND_03,false)			
			Freeze(_idChar_SYND_04,false)
			Freeze(_idChar_SYND_05,false)

			SetVarValue(_idTimer_Huber_Move,"Active",true)

			_bOnEnter_Sector_Event_Game=1
		end
	end
end
-------------------------------------------------------------------
function OnEnter_Sector_Event_Freeze_Hang_first(id)

	if(_bPlayerInControl_Right==true)or(_bOnEnter_Sector_Event_Game==1)and(id~=_idMerc[1])then
		Freeze(id,true)
	end
end
----------------------------------------------------------------------
function OnEnter_d(id)

	if(_bOnEnter_Sector_Event_Dial_Snipers==0)then
		if(id==_idPlayer)then
			MakeCharacterSpeak(_idChar_RES_CAMP_00_3,_idPlayer,"DIA_GEN_SEE_SNIPERS_TEAM_A_VOICE_A_1",true,100,2,1.0,"",0.0)	
			_bOnEnter_Sector_Event_Dial_Snipers=1
		end
	end
end
-----------------------------------------------------------------------
function Soldier_1()

_nHealth_Char_SYND_01=GetHealth(_idChar_SYND_01)
_nHealth_Char_SYND_02=GetHealth(_idChar_SYND_02)
_nHealth_Char_SYND_03=GetHealth(_idChar_SYND_03)
_nHealth_Char_SYND_04=GetHealth(_idChar_SYND_04)
_nHealth_Char_SYND_05=GetHealth(_idChar_SYND_05)

	if not IsAlive(_idChar_SYND_01)and not IsAlive(_idChar_SYND_02)and(_bOnEnter_Sector_Event_BOYAU==0)and(_bOnEnter_Sector_Event_RUIN_01==0)then
		Freeze(_idChar_SYND_06,false)
	end

	if (not IsAlive(_idChar_SYND_03)and not IsAlive(_idChar_SYND_04))and(_bOnEnter_Sector_Event_BOYAU==0)and(_bOnEnter_Sector_Event_RUIN_01==0)then
		Freeze(_idChar_SYND_08,false)
	end

	if not(IsAlive(_idChar_SYND_06))and(_bOnEnter_Sector_Event_BOYAU==0)and(_bOnEnter_Sector_Event_RUIN_01==0)then
		Freeze(_idChar_SYND_07,false)
	end

	if not(IsAlive(_idChar_SYND_08))and(_bOnEnter_Sector_Event_BOYAU==0)and(_bOnEnter_Sector_Event_RUIN_01==0)then
		Freeze(_idChar_SYND_09,false)
	end
			
		if (not IsAlive(_idChar_SYND_PARA_01)or not IsAlive(_idChar_SYND_02)or not IsAlive(_idChar_SYND_03))and(_bOnEnter_Sector_Event_BOYAU==0)and(_nBotActive<=8)then
			Freeze(_idChar_SYND_PARA_04,false)
			--Freeze(_idChar_SYND_PARA_05,false)
			Freeze(_idChar_SYND_PARA_06,false)
		end
	
end
------------------------------------------------------------------
--function OnEnter_Sector_Event_LEFT(id)

--	if(id==_idPlayer)then
	--		Freeze(_idChar_RES_CAMP_00_2,false)
--			Freeze(_idChar_RES_CAMP_00_4,false)
	--		Freeze(_idChar_RES_CAMP_00_24,false)
	--		Freeze(_idChar_RES_CAMP_00_18,false)
--	_bIs_In_Left_box=true
--	end
--end
-------------------------------------------------------------------
--function OnExit_Sector_Event_LEFT(id)


--	if(id==_idPlayer)then
--			Freeze(_idChar_RES_CAMP_00_2,true)
--			Freeze(_idChar_RES_CAMP_00_4,true)
--			Freeze(_idChar_RES_CAMP_00_24,true)
--			Freeze(_idChar_RES_CAMP_00_18,true)
--	end
--end
-----------------------------------------------------------------

------------------------------------------------------------------
function EXOS_Vs_Player()

_nHealth_EXO_A=GetVarValue(GetExoskeletonID("Exoskeleton_1"),"Health")
_nHealth_EXO_B=GetVarValue(GetExoskeletonID("Exoskeleton_2"),"Health")
_nHealth_EXO_C=GetVarValue(GetExoskeletonID("Exoskeleton_3"),"Health")

_idAI_Order_List_EXO_A=GetAI_Order_ListID("AI_Order_List_EXO_A")
_idAI_Order_List_EXO_B=GetAI_Order_ListID("AI_Order_List_EXO_B")
_idAI_Order_List_EXO_C=GetAI_Order_ListID("AI_Order_List_EXO_C")


	if(_nHealth_EXO_A<=1000)then
		SetVarValue(_idAI_Order_List_EXO_A,"Order",GetInvalidEntityID(),3)
	end

	if(_nHealth_EXO_A==0)then
		MiniMapTrack(_idExoskeleton_1,2,false)
		if(_nBotActive<=8)then
		Freeze(_idChar_SYND_PARA_07,false)
		Freeze(_idChar_SYND_PARA_08,false)
		end
	end
	
		if(_nHealth_EXO_B<=1500)then
			SetVarValue(_idAI_Order_List_EXO_B,"Order",GetInvalidEntityID(),3)
		end

		if(_nHealth_EXO_B==0)and(_nBotActive<=8)then
			MiniMapTrack(_idExoskeleton_2,2,false)
			Freeze(_idChar_SYND_PARA_09,false)
			Freeze(_idChar_SYND_PARA_10,false)
		end

			if(_nHealth_EXO_C<=1500)then
				SetVarValue(_idAI_Order_List_EXO_C,"Order",GetInvalidEntityID(),3)
			end
			if(_nHealth_EXO_C==0)and(_nBotActive<=8)then
				Freeze(_idChar_SYND_PARA_11,false)
				Freeze(_idChar_SYND_PARA_12,false)
			end	

end
--------------------------------------------------------------------------
function No_EXO()


	if(_bNo_EXO==0)then
		if((_nHealth_EXO_A==0)and(_nHealth_EXO_B==0)and(_nHealth_EXO_C==0))then
			---Freeze(_idChar_SYND_Exoman_04,false)
			---Freeze(_idExoskeleton_4,false)
			---MiniMapTrack(_idExoskeleton_4,2,true)

			Freeze(_idChar_SYND_PARA_01,false)
			Freeze(_idChar_SYND_PARA_02,false)
			Freeze(_idChar_SYND_PARA_03,false)
			MiniMapTrack(_idExoskeleton_2,2,false)
			MiniMapTrack(_idExoskeleton_3,2,false)
			MiniMapTrack(_idExoskeleton_1,2,false)
		_bNo_EXO=1
		end
	end
end
-----------------------------------------------------------------
--function OnEnter_Sector_Event_Whole_Plaine(id)

--	if IsEntityInBox(_idPlayer,"Sector_Event_BOYAU")then
--		Freeze(id,true)
--		DisplaySubtitle("on est plus là",2,5)
--		Freeze(_idExoskeleton_1,true)
--		Freeze(_idExoskeleton_2,true)
--		Freeze(_idExoskeleton_3,true)	
--	end
--end
-----------------------------------------------------------------
--function OnStay_Sector_Event_Whole_Plaine(id)

--	if not IsEntityInBox(_idPlayer,"Sector_Event_BOYAU")then
--		Freeze(id,false)
--		DisplaySubtitle("on est là",2,5)
--		Freeze(_idExoskeleton_1,false)
--		Freeze(_idExoskeleton_2,false)
--		Freeze(_idExoskeleton_3,false)	
--	end
--	if IsEntityInBox(_idPlayer,"Sector_Event_BOYAU")then
	--	Freeze(id,true)
	--	DisplaySubtitle("on est plus là",2,5)
--		Freeze(_idExoskeleton_1,true)
--		Freeze(_idExoskeleton_2,true)
	--	Freeze(_idExoskeleton_3,true)	
--	end
--end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function OnEnter_Sector_Event_BOYAU(id)
	if(_bOnEnter_Sector_Event_BOYAU==0)then
		if(id==_idPlayer)then
	
		Freeze(_idChar_SYND_Exoman_01,true)
		Freeze(_idChar_SYND_Exoman_02,true)
		Freeze(_idChar_SYND_Exoman_03,true)

		Freeze(_idChar_SYND_01,true)
		Freeze(_idChar_SYND_02,true)
		Freeze(_idChar_SYND_03,true)
		Freeze(_idChar_SYND_04,true)
		Freeze(_idChar_SYND_05,true)
		Freeze(_idChar_SYND_06,true)
		Freeze(_idChar_SYND_07,true)
		Freeze(_idChar_SYND_08,true)
		Freeze(_idChar_SYND_09,true)
		Freeze(_idChar_SYND_10,true)
		Freeze(_idChar_SYND_11,true)
		Freeze(_idChar_SYND_12,true)
		Freeze(_idChar_SYND_13,true)

		Freeze(_idChar_SYND_PARA_01,true)
		Freeze(_idChar_SYND_PARA_02,true)
		Freeze(_idChar_SYND_PARA_03,true)
		Freeze(_idChar_SYND_PARA_04,true)
		Freeze(_idChar_SYND_PARA_05,true)
		Freeze(_idChar_SYND_PARA_06,true)
		--Freeze(_idChar_SYND_PARA_07,true)
		--Freeze(_idChar_SYND_PARA_08,true)
	--	Freeze(_idChar_SYND_PARA_09,true)
		--Freeze(_idChar_SYND_PARA_10,true)
		--Freeze(_idChar_SYND_PARA_11,true)
	---	Freeze(_idChar_SYND_PARA_12,true)
		Freeze(_idChar_SYND_PARA_13,true)
		Freeze(_idChar_SYND_PARA_14,true)
		Freeze(_idChar_SYND_PARA_15,true)
		Freeze(_idChar_SYND_PARA_16,true)
		Freeze(_idChar_SYND_PARA_17,true)
		Freeze(_idChar_SYND_PARA_18,true)

		_bOnEnter_Sector_Event_BOYAU=1
		end
	end
end
------------------------------------------------------------------------------------
function OnExit_Sector_Event_BOYAU(id)

	if(_bOnExit_Sector_Event_BOYAU==0)then
	if(id==_idPlayer)then
		Freeze(_idChar_SYND_01,true)
		Freeze(_idChar_SYND_02,true)
		Freeze(_idChar_SYND_03,true)
		Freeze(_idChar_SYND_04,true)
		Freeze(_idChar_SYND_05,true)
		Freeze(_idChar_SYND_06,true)
		Freeze(_idChar_SYND_07,true)
		Freeze(_idChar_SYND_08,true)
		Freeze(_idChar_SYND_09,true)
		Freeze(_idChar_SYND_10,true)
		Freeze(_idChar_SYND_11,true)
		Freeze(_idChar_SYND_12,true)
		Freeze(_idChar_SYND_13,true)	

		Freeze(_idChar_SYND_PARA_01,true)
		Freeze(_idChar_SYND_PARA_02,true)
		Freeze(_idChar_SYND_PARA_03,true)
		Freeze(_idChar_SYND_PARA_04,true)
		Freeze(_idChar_SYND_PARA_05,true)
		Freeze(_idChar_SYND_PARA_06,true)
		--Freeze(_idChar_SYND_PARA_07,true)
		--Freeze(_idChar_SYND_PARA_08,true)
		--Freeze(_idChar_SYND_PARA_09,true)
		--Freeze(_idChar_SYND_PARA_10,true)
		--Freeze(_idChar_SYND_PARA_11,true)
		--Freeze(_idChar_SYND_PARA_12,true)
		Freeze(_idChar_SYND_PARA_13,true)
		Freeze(_idChar_SYND_PARA_14,true)
		Freeze(_idChar_SYND_PARA_15,true)
		Freeze(_idChar_SYND_PARA_16,true)
		Freeze(_idChar_SYND_PARA_17,true)
		Freeze(_idChar_SYND_PARA_18,true)
		_bOnEnter_Sector_Event_BOYAU=0
		_bOnExit_Sector_Event_BOYAU=1
	end
	end
end
------------------------------------------------------------------------------------
--::-- We have located an Exo oddly left by the syndicate… reach it and wreck 
--those tanks!Take the passage at the end of the wall!

function Go_Steal_Exo()
_idTimer_Steal=GetTimerID("Timer_Steal")

	if(_bGo_Steal_Exo==0)then
		if(_bNo_EXO==1)then
			ObjectiveDoneNewObjectiveNewSubObjective("Obj_1","Obj_2","Obj_2_1")
			MiniMapTrack(_idMerc[0],2,true)
			SetVarValue(_idTimer_Steal,"Active",true)
			_bGo_Steal_Exo=1
		end
	end
end
-----------------------------------------------

------------------------------------------------
function In_Exo()

_idTimer_TANK_VS_EXO=GetTimerID("Timer_TANK_VS_EXO")
	
	if(_bIn_Exo==0)then
		if(_bIS_IN_EXO==true)then

			SetVarValue(_idTimer_TANK_VS_EXO,"Active",true)
			NewSubObjective("Obj_2_2","Obj_2_3")
			SetVarValue(_idObj_2_4,"Active",true)
			Freeze(_idChar_RES_CAMP_00_2,false)
			SetVarValue(_idChar_RES_CAMP_00_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_pathway_grotte"))
			SetVarValue(_idChar_RES_CAMP_00_2,"Position",Vector3D(-1008.642578,315.940338,34.189487))

			
			MiniMapTrack(_idExoskeleton_4,2,false)
			MiniMapTrack(_idTank_SYND_01,2,false)

			UnLockDoor(_idDoor_Main,true)
			OpenDoor(_idDoor_Main,true)
			SetVarValue(_idDoor_Main,"Opened Time",-1)
			UnLockDoor(_idDoor_Main2,true)
			OpenDoor(_idDoor_Main2,true)
			SetVarValue(_idDoor_Main2,"Opened Time",-1)

			if(_nBotActive<=6)then
				Freeze(_idChar_SYND_PARA_19,false)
				Freeze(_idChar_SYND_PARA_20,false)
				Freeze(_idChar_SYND_PARA_21,false)
				Freeze(_idChar_SYND_PARA_22,false)
				Freeze(_idChar_SYND_PARA_23,false)
				Freeze(_idChar_SYND_PARA_24,false)
			end
			_bIn_Exo=1
		end
	end
end
--------------------------------------------------------------


----------------------------------------------------------
function OnEnter_Sector_Event_Go_Back(id)
	
	if(_bOnEnter_Sector_Event_Go_Back==0)then
		if(id==_idPlayer)and(_bOnDeath_Tank_SYND_01==1)then
				NewSubObjective("Obj_3_1","Obj_3_2")
			_bOnEnter_Sector_Event_Go_Back=1
		end
	end
end
-------------------------------------------------------------------
function Cam_save_1()

_idCam_Save_01=GetCamTransitionID("CamTransition_save_01")
	if(_bCam_save_1==0)then
	ShowCinematicBlackStripes(true)
	EnableCharacterCommand(_idPlayer,false)
	Freeze(_idChar_RES_CAMP_00_2,false)
	LaunchCameraTransition(_idCam_Save_01)
	_bCam_save_1=1
	end
end
-------------------------------------------------------------------
function Cam_save_2()

_idCam_Save_02=GetCamTransitionID("CamTransition_save_02")

	LaunchCameraTransition(_idCam_Save_02)
	MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_08",false,100,2,0.0,"",100.0)
end
-------------------------------------------------------------------
function Cam_save_3()

_idCam_Save_03=GetCamTransitionID("CamTransition_save_03")

	LaunchCameraTransition(_idCam_Save_03)
	MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_08",false,100,2,0.0,"",100.0)
end

-------------------------------------------------------------------
function Cam_save_4()

_idCam_Save_04=GetCamTransitionID("CamTransition_save_04")

	LaunchCameraTransition(_idCam_Save_04)
	RadioMessage("DIA_GEN_DO_FLAME_TEAM_A_VOICE_B_1",false,100,0.0,"")
end
-----------------------------------------------------------------
function End_cam()

		ShowCinematicBlackStripes(false)
		SetGodMode(_idPlayer,false)
		EnableCharacterCommand(_idPlayer,true)
		SetVarValue(_idParticleFX_Client_1,"FxState","Fx Started")
		SetVarValue(_idParticleFX_Client_2,"FxState","Fx Started")
		SetVarValue(_idParticleFX_Client_3,"FxState","Fx Started")
end
-------------------------------------------------------------------
function OnEnter_Sector_Event_SECURE_DEAD_MERCENARY(id)

	if((id==_idPlayer)and(_bIS_IN_EXO==false))or(id~=_idChar_SYND_Exoman_01)or(id~=_idChar_SYND_Exoman_02)or(id~=_idChar_SYND_Exoman_03)then
		DamageCharacter(id,10000)
	end
end
-------------------------------------------------------------------

--









