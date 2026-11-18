function UpdateLevel_Boss()

end
--------------------------------------------------------------------------------------------------------
--------------------------::CONDITIONS DE DECLENCHEMENT DU BET + TIMER::----------------------------------------
function Boss()

_idTimer_launch=GetTimerID("Timer_launch")
_n_restants_idGroup_UAN_Warehouse_01=AliveMembersCount(_idGroup_UAN_Warehouse_01)

	if(_bBoss==0) then

		if(_n_restants_idGroup_UAN_Warehouse_01==0)and(_b_yet_OnStay_Sector_Event_Catch_explosives==true)then
			-----------------------
			-----------------------
			if (_idMerc[0] ~= nil)then
				EnableCharacterCommand(_idMerc[0],false)
			end

			if(_idMerc[1] ~= nil) then
				EnableCharacterCommand(_idMerc[1],false)
			end
			-----------------------
			-----------------------
			EnableCharacterCommand(_idChar_WRF_01_1,false)
			EnableCharacterCommand(_idChar_WRF_01_2,false)

			EnableCharacterCommand(_idChar_UAN_Renforts_warehouse_02_1,false)
			EnableCharacterCommand(_idChar_UAN_Warehouse_00_4,false)

			SetVarValue(_idTimer_launch,"Active",true)
		_bCombat=true
		_bBoss=1
		end
	end
end
--------------------------------------------------------------------------------------------------------
--------------------------::DECLENCHEMENT DU BET::----------------------------------------
function Launch()

_idMShield_Champion_0_2=GetPlug_MagneticShieldID("MShield_Champion_0_2")

	if(_bLaunch==0)then

			LaunchBOS(0,"OnSetup","OnWarmup","Combat_BOSS","Win","Loose","Time_Out")
			g_bBoSEnCours = true	
			CreationTimer(true, true, false, "ActiveShield_BoS_0",1.5)
	if (_idMerc[0] ~= nil) then 
		Freeze(_idMerc[0],true)
	end
	if (_idMerc[1] ~= nil) then 
		Freeze(_idMerc[1],true)
	end
			-----
			-----AU CAS OU...
		Freeze(_idChar_UAN_Entrepot_00_1,true)	
		Freeze(_idChar_UAN_Entrepot_00_2,true)	
		--Freeze(_idChar_UAN_Entrepot_00_3,true)	
		Freeze(_idChar_UAN_Entrepot_00_4,true)	
		Freeze(_idChar_UAN_Entrepot_00_5,true)	
		Freeze(_idChar_UAN_Entrepot_00_6,true)	
		Freeze(_idChar_UAN_Entrepot_00_7,true)	
		Freeze(_idChar_UAN_Entrepot_00_8,true)	
		Freeze(_idChar_UAN_Entrepot_00_9,true)	
		Freeze(_idChar_UAN_Entrepot_00_10,true)	
		Freeze(_idChar_UAN_Entrepot_00_11,true)	
		Freeze(_idChar_UAN_Entrepot_00_12,true)	
		Freeze(_idChar_UAN_Entrepot_00_13,true)	
		Freeze(_idChar_UAN_Entrepot_00_14,true)	
		Freeze(_idChar_UAN_Entrepot_00_15,true)	
		Freeze(_idChar_UAN_Entrepot_00_16,true)	

		Freeze(_idChar_UAN_Renforts_warehouse_02_1,true)
		Freeze(_idChar_UAN_Renforts_warehouse_02_2,true)
		Freeze(_idChar_UAN_Renforts_warehouse_02_3,true)
		Freeze(_idChar_UAN_Renforts_warehouse_02_4,true)

		Freeze(_idChar_UAN_Warehouse_00_1,true)
		Freeze(_idChar_UAN_Warehouse_00_2,true)


		Freeze(_idChar_UAN_Warehouse_01_1,true)
		Freeze(_idChar_UAN_Warehouse_01_2,true)
		Freeze(_idChar_UAN_Warehouse_01_5,true)

			_bLaunch=1
	end
end
-----------------------------------------------------------------------------------------
--------------------------------::ON SETUP::---------------------------------------------
function OnSetup()
_idTV_Camera_Client_champion=GetTV_Camera_ClientID("TV_Camera_Client_champion")


Teletransportation("Char_REPERE",_idPlayer)

			if (_idChampion_0 ~= nil)then 
				SetVarValue(_idTV_Camera_Client_champion,"Active",true)
				SetVarValue(_idTV_Camera_Client_champion,"TrackedCharacter",_idChampion_0)
				Freeze(_idChampion_0,false)
				--PauseMusic()
			end
			EnableCharacterCommand(_idChampion_0,false)
			EnableCharacterFire(_idPlayer,false)
			SetGodMode(_idChampion_0,true)
			SetVarValue(_idMShield_Champion_0_2,"Active",true)	
			Freeze(_idChar_SYNDICAT_1,false)
			Freeze(_idChar_SYNDICAT_2,false)
			SetGodMode(_idChar_SYNDICAT_1,true)
			SetGodMode(_idChar_SYNDICAT_2,true)
				
end
----------------------------------------------------------------------------------
--------------------------------::ON WARM UP::--------------------------------------
function OnWarmup()

_idTV_Camera_Client_champion=GetTV_Camera_ClientID("TV_Camera_Client_champion")

--	if(_bDisable_Merc==0)then
		if(_bCombat==true)then
			
			------
			if (_idMerc[0] ~= nil)then
		--	Freeze(_idMerc[0],true)
			SetVarValue(_idMerc[0],"Position",Vector3D(195.973022,-31.825388,19.566864))
			end
			--------
			if(_idMerc[1] ~= nil) then
		--	Freeze(_idMerc[1],true)
			SetVarValue(_idMerc[1],"Position",Vector3D(210.953613,-16.835560,18.969757))
			end
			-----------
			Freeze(_idChar_SYNDICAT_1,false)
			Freeze(_idChar_SYNDICAT_2,false)
			SetGodMode(_idChar_SYNDICAT_1,true)
			SetGodMode(_idChar_SYNDICAT_2,true)

			Freeze(_idChar_WRF_01_1,true)
			SetVarValue(_idChar_WRF_01_1,"Position",Vector3D(172.696808,25.411419,20.122532))

			Freeze(_idChar_WRF_01_2,true)
			SetVarValue(_idChar_WRF_01_2,"Position",Vector3D(174.810104,28.980215,20.068176))

			EnableCharacterCommand(_idChampion_0,false)
			EnableCharacterFire(_idChampion_0,false)
		end
end

function ActiveShield_BoS_0()
	if (_idChampion_0 == GetCharacterID("Char_Champion_0_1")) then
--		SetVarValue(GetPlug_MagneticShieldID("Plug_MagneticShield_Champion_0_1"),"Active", true)
	end
	if (_idChampion_0 == GetCharacterID("Char_Champion_0_2")) then
		SetVarValue(GetPlug_MagneticShieldID("Plug_MagneticShield_Champion_0_2"),"Active", true)
	end
	if (_idChampion_0 == GetCharacterID("Char_Champion_0_3")) then
		SetVarValue(GetPlug_MagneticShieldID("Plug_MagneticShield_Champion_0_3"),"Active", true)
	end
end

------------------------------------
--------------------------------------
function Loose()
	MissionFailed ("HUD_MISSION_FAILED_REASON_01")
	if(_bLoose==0)then
		if(_idChampion_0 ~= nil)then
		_bLoose=1
		end
	end
end
------------------------------------
----------------------------------------------------------------------------
function Combat_BOSS()

--_idMagnetic_Shield_1=GetPlug_MagneticShieldID("Plug_MagneticShield-31")
--_idMagnetic_Shield_2=GetPlug_MagneticShieldID("Plug_MagneticShield-32")
--_idMagnetic_Shield_3=GetPlug_MagneticShieldID("Plug_MagneticShield-33")


				EnableCharacterFire(_idPlayer,true)
				EnableCharacterFire(_idChampion_0,true)
		_idFT_0 = CreateAI_Order_Forbid_Target()
							if (_idMerc[0] ~= nil)then
							SetVarValue(_idFT_0,"Target",_idMerc[0])
							SetVarValue(_idFT_0,"PriorityTorso",100)
							end
		_idFT_1 = CreateAI_Order_Forbid_Target()
							if (_idMerc[1] ~= nil)then
							SetVarValue(_idFT_1,"Target",_idMerc[1])
							SetVarValue(_idFT_1,"PriorityTorso",100)
							end
			if(_idChampion_0 ~= nil)then
				EnableCharacterCommand(_idChampion_0,true)	
				SetGodMode(_idChampion_0,false)		
			end
end
----------------------------------------------------------------------------
--FONCTION PROVISOIRE : affiche message si le duel est gagné
function Win()

	g_bBoSEnCours = false

_idDoor_End_G=GetDoorID("Door_End_G")
_idDoor_End_D=GetDoorID("Door_End_D")
			
			Freeze(_idChar_SYNDICAT_1,true)
			Freeze(_idChar_SYNDICAT_2,true)

			StartMusic("Sounds//Music//BoS - Twilight theme.wav",true)

			_bOnEnter_Sector_Event_endoflevel=0
			UnLockDoor(_idDoor_End_G,false)			
			UnLockDoor(_idDoor_End_D,false)
			
			--	OpenDoor(_idDoor_bos_1,true)
			--	OpenDoor(_idDoor_bos_2,true)

			OpenDoor(_idDoor_End_G,true)
			OpenDoor(_idDoor_End_D,true)
			SetVarValue(_idDoor_End_G,"Opened Time",-1)
			SetVarValue(_idDoor_End_D,"Opened Time",-1)
			Freeze(_idChar_UAN_Warehouse_00_3,false)

			----MERCENAIRES----
			if (_idMerc[0] ~= nil)then
			Freeze(_idMerc[0],false)
			SetVarValue(_idMerc[0],"Position",Vector3D(195.973022,-31.825388,19.566864))
			EnableCharacterCommand(_idMerc[0],true)
			SetVarValue(_idMerc[0],"CharacterOrderList",_idPasdeListe)
			end

			if(_idMerc[1] ~= nil) then
			Freeze(_idMerc[1],false)
			EnableCharacterCommand(_idMerc[1],true)
			SetVarValue(_idMerc[1],"CharacterOrderList",_idPasdeListe)
			SetVarValue(_idMerc[1],"Position",Vector3D(210.953613,-16.835560,18.969757))
			end
			--------------------
			-----ALLIES--------
			Freeze(_idChar_WRF_01_1,false)
			SetVarValue(_idChar_WRF_01_1,"Position",Vector3D(172.696808,25.411419,20.122532))
			EnableCharacterCommand(_idChar_WRF_01_1,true)
			SetVarValue(_idChar_WRF_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_WRF_follow_player"))

			Freeze(_idChar_WRF_01_2,false)
			SetVarValue(_idChar_WRF_01_2,"Position",Vector3D(174.810104,28.980215,20.068176))
			EnableCharacterCommand(_idChar_WRF_01_2,true)
			SetVarValue(_idChar_WRF_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_WRF_follow_player"))
			--------------------
end
--------------------------------------------------------------------------------
function Time_Out()

	g_bBoSEnCours = false

_idDoor_End_G=GetDoorID("Door_End_G")
_idDoor_End_D=GetDoorID("Door_End_D")

			Freeze(_idChar_SYNDICAT_1,true)
			Freeze(_idChar_SYNDICAT_2,true)
			StartMusic("Sounds//Music//BoS - Twilight theme.wav",true)

			if (_idChampion_0 ~= nil)then
				Freeze(_idChampion_0,true)
			end	
			_bOnEnter_Sector_Event_endoflevel=0
			UnLockDoor(_idDoor_End_G,false)			
			UnLockDoor(_idDoor_End_D,false)
				
		--	OpenDoor(_idDoor_bos_1,true)
	--		OpenDoor(_idDoor_bos_2,true)

			OpenDoor(_idDoor_End_G,true)
			OpenDoor(_idDoor_End_D,true)
			SetVarValue(_idDoor_End_G,"Opened Time",-1)
			SetVarValue(_idDoor_End_D,"Opened Time",-1)
			Freeze(_idChar_UAN_Warehouse_00_3,false)

			if (_idMerc[0] ~= nil)then
			Freeze(_idMerc[0],false)
			SetVarValue(_idMerc[0],"Position",Vector3D(195.973022,-31.825388,19.566864))
			EnableCharacterCommand(_idMerc[0],true)
			SetVarValue(_idMerc[0],"CharacterOrderList",_idPasdeListe)
			end

			if(_idMerc[1] ~= nil) then
			Freeze(_idMerc[1],false)
			EnableCharacterCommand(_idMerc[1],true)
			SetVarValue(_idMerc[1],"CharacterOrderList",_idPasdeListe)
			SetVarValue(_idMerc[1],"Position",Vector3D(210.953613,-16.835560,18.969757))
			end
			
			Freeze(_idChar_WRF_01_1,false)
			SetVarValue(_idChar_WRF_01_1,"Position",Vector3D(172.696808,25.411419,20.122532))
			EnableCharacterCommand(_idChar_WRF_01_1,true)
			SetVarValue(_idChar_WRF_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_WRF_follow_player"))

			Freeze(_idChar_WRF_01_2,false)
			SetVarValue(_idChar_WRF_01_2,"Position",Vector3D(174.810104,28.980215,20.068176))
			EnableCharacterCommand(_idChar_WRF_01_2,true)
			SetVarValue(_idChar_WRF_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_WRF_follow_player"))
end





















































































