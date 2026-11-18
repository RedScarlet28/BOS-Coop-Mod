function UpdateLevel_Boss()
end
----------------------------------
----------------------------------
function Boss()

_idTimer_Launch=GetTimerID("Timer_Launch")

	if(_bBoss==0)then
		if((_bGroupBaraques_1_Mort==true)and(_bGroupBaraques_2_Mort==true))then
			_bBetLancer=true
			SetVarValue(_idTimer_Launch,"Active",true)

			if(_idChampion_0==_idChar_Champion_0_1)then
			Teletransportation("Char_REPERE1",_idChampion_0)
			end

			if(_idChampion_0==_idChar_Champion_0_2)then
			Teletransportation("Char_REPERE1",_idChampion_0)
			end

			if(_idChampion_0==_idChar_Champion_0_3)then
			Teletransportation("Char_REPERE2",_idChampion_0)
			end

			EnableCharacterCommand(_idChar_UAN_BARAQUES_03_1,false)
			EnableCharacterCommand(_idChar_UAN_BARAQUES_03_2,false)	
			EnableCharacterCommand(_idMerc[0],false)
			if(_idMerc[1] ~= nil) then
			EnableCharacterCommand(_idMerc[1],false)
			end
		_bCombat=true
		_bBoss=1
		end
	end
end
--------------------------------------------------
function OnEnter_Sector_Event_SECURE_LAUNCH_BOS(id)

	if(id==_idPlayer)then
			if(id == GetLocalCharacterID("Player"))and((_bAliveChar_UAN_BARAQUES_01_1==true)or
			(_bAliveChar_UAN_BARAQUES_01_2==true)or																		
			(_bAliveChar_UAN_BARAQUES_01_3==true)or
			(_bAliveChar_UAN_BARAQUES_01_4==true)or
			(_bAliveChar_UAN_BARAQUES_02_1==true)or
			(_bAliveChar_UAN_BARAQUES_02_2==true)or																	
			(_bAliveChar_UAN_BARAQUES_02_3==true)or
			(_bAliveChar_UAN_BARAQUES_02_4==true)or
			(_bAliveChar_UAN_BARAQUES_03_1==true)or																	
			(_bAliveChar_UAN_BARAQUES_03_2==true)or
			(_bAliveChar_UAN_BARAQUES_03_3==true))and(_bLaunch~=1)then

--			Freeze(_idChar_UAN_GALERIE_00_1,false)	
---			Freeze(_idChar_UAN_GALERIE_00_2,false)
--			Freeze(_idChar_UAN_GALERIE_00_3,false)
--			Freeze(_idChar_UAN_GALERIE_00_4,false)
			RadioMessage("DIA_SPE_NIV_H_INGENIEUR_26",true,100,0.0,"")
		_byetOnEnter_Sector_Event_SECURE_LAUNCH_BOS=true
		end
	end
end
---------------------------------------------------
function Launch()

	LaunchBOS(0,"OnSetup","Disable_Merc","Combat_BOSS","Won","Loose","TimeOut")
	--MiniMapTrack(_idChampion_0,5,true)
	if(_idMerc[1]~=nil)then
	Freeze(_idMerc[1],true)
	end
	if(_idMerc[0]~=nil)then
	Freeze(_idMerc[0],true)
	end
	_bLaunch=1
	g_bBoSEnCours = true
end
-------------------------------------------------------------------------------
function OnSetup() 
	
		if (_idChampion_0 ~= nil) then 
			Freeze(_idChampion_0,false)		
		end

	EnableCharacterCommand(_idChampion_0,false)
	SetGodMode(_idChampion_0,true)
	SetGodMode(_idPlayer,true)

	if _idChampion_0 == (GetCharacterID("Char_Champion_0_3"))then
		Teletransportation("Char_REPERE4",_idPlayer)	
	else
		Teletransportation("Char_REPERE",_idPlayer)	
	end

		if(_idChampion_0==_idChar_Champion_0_1)then
			SetVarValue(_idChampion_0,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_champion_1"))	
		end
		if(_idChampion_0==_idChar_Champion_0_2)then
			SetVarValue(_idChampion_0,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_champion_2"))	
		end
		if(_idChampion_0==_idChar_Champion_0_3)then
			SetVarValue(_idChampion_0,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_champion_3"))	
		end

		LockDoor(_idDoor_bos_1,true)
		LockDoor(_idDoor_bos_2,true)
		LockDoor(_idDoor_bos_3,true)
		LockDoor(_idDoor_bos_4,true)
		LockDoor(_idDoor_bos_5,true)
		LockDoor(_idDoor_bos_6,true)
		LockDoor(_idDoor_bos_7,true)
		LockDoor(_idDoor_bos_8,true)

		CloseDoor(_idDoor_bos_1,true)
		CloseDoor(_idDoor_bos_2,true)
		CloseDoor(_idDoor_bos_3,true)
		CloseDoor(_idDoor_bos_4,true)
		CloseDoor(_idDoor_bos_5,true)
		CloseDoor(_idDoor_bos_6,true)
		CloseDoor(_idDoor_bos_7,true)
		CloseDoor(_idDoor_bos_8,true)
	
end
-----------------------------------------------------------------------------
function Disable_Merc()

_idTV_CAM_1_Champion=GetTV_Camera_ClientID("TV_Camera_Client-17")


	if(_bDisable_Merc==0)then
		if(_bCombat==true)then

			EnableCharacterFire(_idPlayer,false)
			SetGodMode(_idPlayer,true)
			------------------------------------
			if(_idChampion_0 ~= nil)then
				EnableCharacterFire(_idChampion_0,false)
				SetGodMode(_idChampion_0,true)
				SetVarValue(_idTV_CAM_1_Champion,"TrackedCharacter",_idChampion_0)
			end
			------------------------------------
			Freeze(_idChar_SYNDICATE_1,false)
			Freeze(_idChar_SYNDICATE_2,false)
			Freeze(_idChar_SYNDICATE_3,false)
			Freeze(_idChar_SYNDICATE_4,false)
			-----------------------------------------------
			EnableCharacterCommand(_idChar_UAN_BARAQUES_03_1,false)
			EnableCharacterCommand(_idChar_UAN_BARAQUES_03_2,false)	

			EnableCharacterCommand(_idMerc[0],false)
			SetVarValue(_idMerc[0],"CharacterOrderList",_idPasDeListe)
			Freeze(_idMerc[0],true)
			if(_idMerc[1] ~= nil) then
				EnableCharacterCommand(_idMerc[1],false)
				SetVarValue(_idMerc[1],"CharacterOrderList",_idPasDeListe)
				Freeze(_idMerc[1],true)
			end
		_bDisable_Merc=1
		end
	end
end
------------------------------------
function Loose()

			EnableCharacterCommand(_idChampion_0,true)
			EnableCharacterCommand(_idChar_UAN_BARAQUES_03_1,true)
			EnableCharacterCommand(_idChar_UAN_BARAQUES_03_2,true)	
			EnableCharacterCommand(_idMerc[0],true)
			SetVarValue(_idMerc[1],"CharacterOrderList",_idPasDeListe)
			if(_idMerc[1] ~= nil) then
			EnableCharacterCommand(_idMerc[1],true)
			SetVarValue(_idMerc[1],"CharacterOrderList",_idPasDeListe)
			end
			DefreezePostBos()
			StartMusic("Sounds//Music//Bos - South theme.wav",true)
			g_bBoSEnCours = false
end
------------------------------------
function Won()

			Freeze(_idChar_SYNDICATE_1,true)
			Freeze(_idChar_SYNDICATE_2,true)
			Freeze(_idChar_SYNDICATE_3,true)
			Freeze(_idChar_SYNDICATE_4,true)

			SetGodMode(_idChar_SYNDICATE_1,true)
			SetGodMode(_idChar_SYNDICATE_2,true)
			SetGodMode(_idChar_SYNDICATE_3,true)
			SetGodMode(_idChar_SYNDICATE_4,true)

				if(_idMerc[1]~=nil)then
					Freeze(_idMerc[1],false)
				end
					if(_idMerc[0]~=nil)then
						Freeze(_idMerc[0],false)
					end
		
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


			EnableCharacterCommand(_idChar_UAN_BARAQUES_03_1,true)
			EnableCharacterCommand(_idChar_UAN_BARAQUES_03_2,true)	
			EnableCharacterCommand(_idMerc[0],true)
			SetVarValue(_idMerc[0],"CharacterOrderList",_idPasDeListe)
			RadioMessage("DIA_SPE_NIV_N_INGENIEUR_A_04",true,100,0.0,"")
			if(_idMerc[1] ~= nil) then
				EnableCharacterCommand(_idMerc[1],true)
				SetVarValue(_idMerc[1],"CharacterOrderList",_idPasDeListe)			
			end
			DefreezePostBos()
			StartMusic("Sounds//Music//Bos - South theme.wav",true)
			g_bBoSEnCours = false
end
----------------------------------------------------------------------------
function TimeOut()

		if(_idMerc[1]~=nil)then
					Freeze(_idMerc[1],false)
				end
					if(_idMerc[0]~=nil)then
						Freeze(_idMerc[0],false)
					end
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
	
			Freeze(_idChar_SYNDICATE_1,true)
			Freeze(_idChar_SYNDICATE_2,true)
			Freeze(_idChar_SYNDICATE_3,true)
			Freeze(_idChar_SYNDICATE_4,true)

			Freeze(_idChampion_0,true)
			EnableCharacterCommand(_idChar_UAN_BARAQUES_03_1,true)
			EnableCharacterCommand(_idChar_UAN_BARAQUES_03_2,true)	
			EnableCharacterCommand(_idMerc[0],true)
			SetVarValue(_idMerc[0],"CharacterOrderList",_idPasDeListe)
			RadioMessage("DIA_SPE_NIV_N_INGENIEUR_A_04",true,100,0.0,"")
			if(_idMerc[1] ~= nil) then
				EnableCharacterCommand(_idMerc[1],true)
				SetVarValue(_idMerc[1],"CharacterOrderList",_idPasDeListe)
			end
			DefreezePostBos()
			StartMusic("Sounds//Music//Bos - South theme.wav",true)
			g_bBoSEnCours = false
end
----------------------------------------------------------------------------
function Combat_BOSS()

			EnableCharacterFire(_idPlayer,true)
			EnableCharacterFire(_idChampion_0,true)
			EnableCharacterCommand(_idPlayer,true)
			EnableCharacterCommand(_idChampion_0,true)
			SetGodMode(_idChampion_0,false)
			SetGodMode(_idPlayer,false)
			EnableCharacterCommand(_idChar_UAN_BARAQUES_03_1,false)
			EnableCharacterCommand(_idChar_UAN_BARAQUES_03_2,false)
			EnableCharacterCommand(_idMerc[0],false)
			SetVarValue(_idMerc[0],"CharacterOrderList",_idPasDeListe)
			if(_idMerc[1] ~= nil) then
			EnableCharacterCommand(_idMerc[1],false)
			SetVarValue(_idMerc[1],"CharacterOrderList",_idPasDeListe)	
			end
			_bCombat=true
end
----------------------------------------------------------------------
function Mort_Boss()

_bAlive_idChampion_0=IsAlive(_idChampion_0)

	if(_bMort_Boss==0)then
		if(_bAlive_idChampion_0==false)then
					
					EnableCharacterCommand(_idMerc[0],true)
					SetVarValue(_idMerc[0],"CharacterOrderList",_idPasDeListe)
					SetMercenaryFollow(_idMerc[0],true)			
				
				if(_idMerc[1] ~= nil) then
					EnableCharacterCommand(_idMerc[1],true)
					SetVarValue(_idMerc[1],"CharacterOrderList",_idPasDeListe)
				end
			_bMort_Boss=1
		end
	end
end
-------------------------------------------------------------------------



function DefreezePostBos()
		Freeze(_idChar_UAN_BARAQUES_01_1,false)
		Freeze(_idChar_UAN_BARAQUES_01_2,false)
		Freeze(_idChar_UAN_BARAQUES_01_3,false)
		Freeze(_idChar_UAN_BARAQUES_01_4,false)
		Freeze(_idChar_UAN_BARAQUES_02_1,false)
		Freeze(_idChar_UAN_BARAQUES_02_2,false)
		Freeze(_idChar_UAN_BARAQUES_02_3,false)
		Freeze(_idChar_UAN_BARAQUES_02_4,false)
		Freeze(_idChar_UAN_BARAQUES_03_1,false)
		Freeze(_idChar_UAN_BARAQUES_03_2,false)
		Freeze(_idChar_UAN_BARAQUES_03_3,false)
end