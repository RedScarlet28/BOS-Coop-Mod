function UpdateLevel_TANK_GAMEPLAY()
end
-----------------------------------
function Tank_Fire_At_Position()

	if(_bTank_Fire_At_Position==0)then
		if(_nHealth_EXO_C==0)then
				TankFireAtPosition(_idTank_SYND_01,Vector3D(249.952179,-85.025009,167.762299)) 
				PrintDebug("TANK TIRE SUR UNE POSITION ZZZZZZZZZZZZZZZZZ")
				Freeze(_idExoskeleton_2,false)
				MiniMapTrack(_idExoskeleton_3,2,false)
				Freeze(_idChar_SYND_Exoman_02,false)
				_bTank_Fire_At_Position=1
		end
	end
end
---------------------------------

function TANK_VS_EXO()

	if(_bTANK_VS_EXO==0)then
		if(_bIn_Exo==1)then
			TankTargetEntity(_idTank_SYND_01,_idPlayer)
			PrintDebug("TANK TIRE SUR MON EXO 111111111")
			_bTankFire_Vs_Exo=true 
			_bTANK_VS_EXO=1
		end
	end
end
----------------------------------------------------------------
function OnDeath_Tank_SYND_01()


	if(_bOnDeath_Tank_SYND_01==0)then
		CreationTimer(true,true,false,"Delay_OnDeath_Tank_SYND_01",2.5)

		Freeze(_idChar_SYND_PARA_25,false)
		Freeze(_idChar_SYND_PARA_26,false)
		Freeze(_idChar_SYND_PARA_27,false)
		Freeze(_idChar_SYND_PARA_28,false)
		Freeze(_idChar_SYND_PARA_29,false)
		Freeze(_idChar_SYND_PARA_30,false)
		Freeze(_idChar_SYND_PARA_31,false)
		
		ObjectiveDoneNewObjectiveNewSubObjective("Obj_2","Obj_3","Obj_3_1")
		SetVarValue(_idObj_2_4,"Active",false)
		Freeze(_idChar_SYND_RUIN_16,false)
		Freeze(_idChar_SYND_RUIN_17,false)
		Freeze(_idChar_SYND_RUIN_18,false)
		
		_bOnDeath_Tank_SYND_01=1
	end
end

function Delay_OnDeath_Tank_SYND_01()
	_bCam_save_1=0
	SetGodMode(_idPlayer,true)
	EnableCharacterCommand(_idPlayer,false)
end

-------------------------------------------------------
function Tank_Vs_player()

	if(_bTank_Vs_player==0)then
		if(_bOnEnter_Sector_Event_Corniche_2==0)then
			--TankTargetEntity(_idTank_SYND_01,_idPlayer)
			_bTank_Vs_player=1
		end
	end
end
------------------------------------------------------
function OnWeakpointDeath_Exoskeleton_4()


	if(_bExo_Desactivating==0)then
			NewSubObjective("Obj_2_2","Obj_2_3")
			SetVarValue(_idChar_SYND_Exoman_04,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_EXIT_EXO_4"))
			SetVarValue(_idChar_RES_ENGINEER_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_REPAIR"))
			SetGodMode(_idChar_RES_ENGINEER_00_1,true)
			TankTargetEntity(_idTank_SYND_01,_idPlayer)
			PrintDebug("TANK TIRE SUR JOUEUR 222222")
			_bExo_Desactivating=1
	end
end
------------------------------------
function FIN_INGE()

	if(_bFIN_INGE==0)then
	if (_bIS_IN_EXO==true)then
			SetVarValue(_idChar_RES_ENGINEER_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_INGE_3"))
			TankTargetEntity(_idTank_SYND_01,_idPlayer)
			PrintDebug("TANK TIRE SUR MON EXO 2222222222")
			_bTANK_VS_EXO=0
		_bFIN_INGE=1
	end
	end
end

-----------------
--Je met le weak point de l'exo à une valuer acceptable kan le joueur est dedans
-------------------

function New_WeakPoint_health ()
	if (_bIS_IN_EXO ==true)then
		if (_bNew_WeakPoint_health == 0) then
			SetVarValue(_idExoskeleton_4,"Weakpoint MaxHealth",2000)
			SetVarValue(_idExoskeleton_4,"Weakpoint Health",2000)
			SetVarValue(_idExoskeleton_4,"Health",10000)
			SetVarValue(_idExoskeleton_4,"MaxHealth",10000)
			_bNew_WeakPoint_health = 1
		end
	end
end