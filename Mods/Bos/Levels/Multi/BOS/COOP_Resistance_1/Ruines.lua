function UpdateLevel_Ruines()
end
-----------------------------------------------
function OnEnter_Sector_Event_Debut_Corniche(id)

_idTimer_Tank_vs_Player=GetTimerID("Timer_Tank_vs_Player")
_idCamTransition_TANK=GetCamTransitionID("CamTransition_TANK")

	if(_bOnEnter_Sector_Event_Debut_Corniche==0)then
		if(id==_idPlayer)then
			LaunchCameraTransition(_idCamTransition_TANK,true)
			ShowCinematicBlackStripes(true)

			Freeze(_idChar_SYND_Exoman_04,false)
			Freeze(_idExoskeleton_4,false)

		--	Freeze(_idChar_SYND_Exoman_02,false)
		--	Freeze(_idExoskeleton_2,false)
			Freeze(_idChar_SYND_RUIN_01,false)
			Freeze(_idChar_SYND_RUIN_02,false)
			Freeze(_idChar_SYND_RUIN_03,false)
			
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

			--Freeze(_idChar_SYND_PARA_07,true)
			--Freeze(_idChar_SYND_PARA_08,true)
			--Freeze(_idChar_SYND_PARA_09,true)
			--Freeze(_idChar_SYND_PARA_11,true)
			Freeze(_idChar_SYND_PARA_13,true)



			Freeze(_idChar_RES_CAMP_00_2,true)
			--Freeze(_idChar_RES_CAMP_00_4,true)
			Freeze(_idChar_RES_CAMP_00_3,true)
			Freeze(_idChar_RES_CAMP_00_18,true)
			Freeze(_idChar_RES_CAMP_00_1,true)
			Freeze(_idChar_RES_CAMP_00_19,true)
			Freeze(_idChar_RES_CAMP_00_17,true)
			Freeze(_idChar_RES_CAMP_00_15,true)

--			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_LEFT_01"))
			SetVarValue(_idTimer_Tank_vs_Player,"Active",true)
			StartMusic("Sounds//Music//BoS - Resistance theme.wav",true)
			TankFireAtPosition(_idTank_SYND_01,Vector3D(277.240417,-48.163826,147.693115)) 
			PrintDebug("TANK TIRE SUR UNE POSITION xxxxxxxxxxxx")
			_bOnEnter_Sector_Event_Debut_Corniche=1
		end
	end
end
-----------------------------------------------

-------------------------------
function End_Cam_Tank()

	if(_idMerc[1]~=nil)then
	MakeCharacterSpeak(_idMerc[1],_idPlayer,"DIA_GEN_DO_RETREAT_TEAM_A_VOICE_B_1",false,100,2,0.0,"",100.0)
	end
	
	ShowCinematicBlackStripes(false)

end
------------------------------------------------
function OnEnter_Sector_Event_Corniche_SECOURS(id)

	if(_bOnEnter_Sector_Event_Corniche_SECOURS==0)then
		if(id==_idPlayer)then
			Freeze(_idChar_SYND_RUIN_04,false)
			Freeze(_idChar_SYND_RUIN_06,false)
			Freeze(_idChar_SYND_RUIN_07,false)

				Freeze(_idChar_RES_CAMP_00_2,true)
				Freeze(_idChar_RES_CAMP_00_4,true)
				Freeze(_idChar_RES_CAMP_00_24,true)
				Freeze(_idChar_RES_CAMP_00_3,true)
				Freeze(_idChar_RES_CAMP_00_18,true)
		_bOnEnter_Sector_Event_Corniche_SECOURS=1
		end
	end
end
-----------------------------------------------------
function OnEnter_Sector_Event_Corniche_2(id)

	if(_bOnEnter_Sector_Event_Corniche_2==0)then
		if(id==_idPlayer)then 	
			--Freeze(_idChar_SYND_RUIN_04,false)
			Freeze(_idChar_SYND_RUIN_05,false)
			Freeze(_idChar_SYND_RUIN_10,false)
	--		SetVarValue(_idSound_Client_Ambiance_03,"Volume",0.7) 
			_bOnEnter_Sector_Event_Corniche_2=1
		end
	end
end
-----------------------------------------------------
function OnEnter_Sector_Event_Corniche_3(id)

	if(_bOnEnter_Sector_Event_Corniche_3==0)then
		if(id==_idPlayer)then 	
		--Freeze(_idChar_SYND_RUIN_06,false)
	--	Freeze(_idChar_SYND_RUIN_07,false)
			--Freeze(_idChar_SYND_RUIN_09,false)
			Freeze(_idChar_SYND_PARA_07,true)
			Freeze(_idChar_SYND_PARA_08,true)
			--Freeze(_idChar_SYND_PARA_09,true)
			--Freeze(_idChar_SYND_PARA_11,true)
			Freeze(_idChar_SYND_PARA_13,true)
			SetVarValue(_idChar_RES_ENGINEER_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_INGE_2"))
			RadioMessage("DIA_SPE_NIV_N_RESIS_06",true,100,0.0,"")
			---SetVarValue(_idSound_Client_Ambiance_03,"Volume",1)
	--	TankTargetEntity(_idTank_SYND_01,_idPlayer) 
			_bOnEnter_Sector_Event_Corniche_3=1
		end
	end
end
----------------------------------------------------
function Tests_Renforts()

	if not IsAlive(_idChar_SYND_RUIN_01)and not IsAlive(_idChar_SYND_RUIN_02)and(_nBotActive<=10)then
	--		Freeze(_idChar_SYND_RUIN_04,false)
			Freeze(_idChar_SYND_RUIN_05,false)
	end

		if not IsAlive(_idChar_SYND_RUIN_03)and(_nBotActive<=8)then
			Freeze(_idChar_SYND_RUIN_06,false)
			Freeze(_idChar_SYND_RUIN_07,false)
		end

		if not IsAlive(_idChar_SYND_RUIN_10)and(_nBotActive<=10)then
			Freeze(_idChar_SYND_RUIN_08,false)
		end
end
----------------------------------------------------
function OnStay_Sector_Event_WHOLE_RUINE(id)

	if(id==_idPlayer)and(_nBotActive<=8)then
			Freeze(_idChar_SYND_PARA_13,false)
		--	Freeze(_idChar_SYND_PARA_14,false)
			Freeze(_idChar_SYND_PARA_17,false)
	end
end
------------------------------------------------------
function OnEnter_Sector_Event_RUIN_01(id)

	if(_bOnEnter_Sector_Event_RUIN_01==0)then
		if(id==_idPlayer)and(_nBotActive<=10)then
			--Freeze(_idChar_SYND_RUIN_11,false)
			Freeze(_idChar_SYND_RUIN_14,false)
			SetVarValue(_idChar_RES_ENGINEER_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_INGE_3"))
				RadioMessage("DIA_SPE_NIV_H_INGENIEUR_21",true,100,0.0,"")
			_bOnEnter_Sector_Event_RUIN_01=1
		end
	end
end
----------------------------------------------------
function OnEnter_Sector_Event_RUIN_02(id)

	if(_bOnEnter_Sector_Event_RUIN_02==0)then
		if(id==_idPlayer)and(_nBotActive<=8)then
			Freeze(_idChar_SYND_RUIN_12,false)
		--	Freeze(_idChar_SYND_RUIN_13,false)
			_bOnEnter_Sector_Event_RUIN_02=1
		end
	end
end
----------------------------------------------------
function OnEnter_Sector_Event_RUIN_03(id)

	if(_bOnEnter_Sector_Event_RUIN_03==0)then
		if(id==_idPlayer)and(_nBotActive<=8)then
		--	Freeze(_idChar_SYND_PARA_13,false)
			Freeze(_idChar_SYND_PARA_14,false)
			--Freeze(_idChar_SYND_PARA_17,false)
			_bOnEnter_Sector_Event_RUIN_03=1
		end
	end
end
------------------------------------------------------
function OnEnter_Sector_Event_RUIN_04(id)

	if(_bOnEnter_Sector_Event_RUIN_04==0)then
		if(id==_idPlayer)and(_nBotActive<=8)then
			Freeze(_idChar_SYND_PARA_15,false)
--		Freeze(_idChar_SYND_PARA_16,false)
			Freeze(_idChar_SYND_PARA_18,false)
			StartMusic("Sounds//Music//Bos - South theme.wav",true)
			_bOnEnter_Sector_Event_RUIN_04=1
		end
	end
end

-------------------------------------------------------------------

































































































































