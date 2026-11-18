function UpdateLevel_PARACHUTING()
end
--------------------------------------------------------------
function OBJ_SUITE()
	_bAliveGroup_UAN_PARA_01=IsAlive(_idGroup_UAN_PARA_01)
	_bAliveGroup_UAN_PARA_02=IsAlive(_idGroup_UAN_PARA_02)
	_bAliveGroup_UAN_PARA_03=IsAlive(_idGroup_UAN_PARA_03)

	if(_bOBJ_SUITE==0)then
		if((_bAliveGroup_UAN_PARA_01==false)
		and(_bAliveGroup_UAN_PARA_02==false)
		and(_bAliveGroup_UAN_PARA_03==false))then
		--	NewSubObjective("Obj_B_1","Obj_B_2")
			_bOBJ_SUITE=1
		end
	end
end
------------------------------------------------
--defreeze des paras.
function Alerte_Para_1()

_bFreezidGroup_UAN_PARA_01=IsFrozen(_idGroup_UAN_PARA_01)
	if(_bAlerte_Para_1==0)then
		if(_bFreezidGroup_UAN_PARA_01==false)then
			SetVarValue(_idSound_Client_helico,"Playing",true)
			MakeCharacterSpeak(_idChar_WRF_barricades_Reserve_3,_idPlayer,"DIA_SPE_NIV_L_USWE_D_02",true,100,2,0.0,"",100)
			StopMusic()
			StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav",false)
			_bAlerte_Para_1=1
		end
	end
end
--------------------------------------------------
--defreeze des paras.
function Alerte_Para_2()

_bFreezidGroup_UAN_PARA_02=IsFrozen(_idGroup_UAN_PARA_02)
	if(_bAlerte_Para_2==0)then
		if(_bFreezidGroup_UAN_PARA_02==false)then
			MakeCharacterSpeak(_idChar_WRF_barricades_Reserve_3,_idPlayer,"DIA_SPE_NIV_L_USWE_F_02",true,100,2,0.0,"",100)
			_bAlerte_Para_2=1
		end
	end
end
----------------------------------------------------
--function Alerte_Para_3()

--_bFreezidGroup_UAN_PARA_03=IsFrozen(_idGroup_UAN_PARA_03)
--	if(_bAlerte_Para_3==0)then
--		if(_bFreezidGroup_UAN_PARA_03==false)then
	--		DisplaySubtitle("Attention !! Ils sont sur le toit de l'église",0,4)
	--		_bAlerte_Para_3=1
--		end
--	end
--end
------------------------------------------
function Paras()

_idTimer_Para_2=GetTimerID("Timer_Para_2")

	if(_bParas==0)then
		if(_bExplo_ok==true)then
			--FreezeAll(_idGroup_UAN_PARA_03,false)
			FreezeAll(_idGroup_UAN_PARA_01,false)
			SetVarValue(_idSound_Client_helico,"Playing",true)
			SetVarValue(_idTimer_Para_2,"Active",true)
		--	ObjectiveDoneNewObjectiveNewSubObjective("Obj_A","Obj_B","Obj_B_1")
			_byetShowObj_Para=true
			_bParas=1
		end
	end
end
-------------------------------------------
--des paras sot moins nombreux >> on en defreeze d'autres.
function Renforts_Paras_1()

_idTimer_Para_3=GetTimerID("Timer_Para_3")

	if(_bRenforts_Paras_1==0)then
		FreezeAll(_idGroup_UAN_PARA_01,false)
		SetVarValue(_idSound_Client_helico,"Playing",true)
		SetVarValue(_idTimer_Para_3,"Active",true)
		if not(_byetShowObj_Para)then
		--	ObjectiveDoneNewObjectiveNewSubObjective("Obj_A","Obj_B","Obj_B_1")
		end
		_byetShowObj_Para=true
			_bRenforts_Paras_1=1
	end
end
-------------------------------------------
function Renforts_Paras_2()

	if(_bRenforts_Paras_2==0)then
		FreezeAll(_idGroup_UAN_PARA_02,false)
		SetVarValue(_idSound_Client_helico,"Playing",true)
		_bRenforts_Paras_2=1
	end
end



























































































