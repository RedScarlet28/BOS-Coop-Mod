function UpdateLevel_Plaine_Ruines()

end
---------------------------------------------
-------------------------------------------------------------
--Conditionne le spawn des gars du premier remparts--selon vie ou mort du premier gars
function Coursive_left_1()

_bAlive_idChar_RES_Coursive_00_7=IsAlive(_idChar_RES_Coursive_00_7)
	if(_bCoursive_left_1==0)then
		if(_bAlive_idChar_RES_Coursive_00_7==false)then
			Freeze(_idChar_RES_Coursive_00_18,false)
			_bCoursive_left_1=1
		end
	end
end
---------------------------------------------------------------
--Conditionne le spawn des gars du premier remparts--selon vie ou mort du premier gars
function Coursive_left_2()
	
_bAlive_idChar_RES_Coursive_00_10=IsAlive(_idChar_RES_Coursive_00_10)
	if(_bCoursive_left_2==0)then
		if(_bAlive_idChar_RES_Coursive_00_10==false)then
			Freeze(_idChar_RES_Coursive_00_12,false)
			_bCoursive_left_2=1
		end
	end
end
--------------------------------------------------------------------
--Conditionne le spawn des gars du premier remparts--selon vie ou mort du premier gars
function Coursive_left_3()
	
_bAlive_idChar_RES_Coursive_00_8=IsAlive(_idChar_RES_Coursive_00_8)
	if(_bCoursive_left_3==0)then
		if(_bAlive_idChar_RES_Coursive_00_8==false)then
			Freeze(_idChar_RES_Coursive_00_19,false)
			_bCoursive_left_3=1
		end
	end
end
---------------------------------------------------------------------
--Conditionne le spawn des gars du deuxieme remparts--selon vie ou mort du premier gars
function Coursive_right_1()
	
_bAlive_idChar_RES_Coursive_00_1=IsAlive(_idChar_RES_Coursive_00_1)
	if(_bCoursive_right_1==0)then
		if(_bAlive_idChar_RES_Coursive_00_1==false)then
			Freeze(_idChar_RES_Coursive_00_11,false)
			_bCoursive_right_1=1
		end
	end
end
-----------------------------------------------------------
--Conditionne le comportement des gars du deuxieme remparts--selon vie ou mort du premier gars
function Coursive_right_2()
	
_bAlive_idChar_RES_Coursive_00_4=IsAlive(_idChar_RES_Coursive_00_4)
	if(_bCoursive_right_2==0)then
		if(_bAlive_idChar_RES_Coursive_00_4==false)then
			Freeze(_idChar_RES_Coursive_00_2,false)
			_bCoursive_right_2=1
		end
	end
end
------------------------------------------------
--Conditionne le comportement des gars du deuxieme remparts--selon vie ou mort du premier gars
function Coursive_right_3()
	
_bAlive_idChar_RES_Coursive_00_9=IsAlive(_idChar_RES_Coursive_00_9)
	if(_bCoursive_right_3==0)then
		if(_bAlive_idChar_RES_Coursive_00_9==false)then
			Freeze(_idChar_RES_Coursive_00_15,false)
			_bCoursive_right_3=1
		end
	end
end
-------------------------------------------------------
--Conditionne le comportement des gars du deuxieme remparts--selon vie ou mort du premier gars
function Coursive_right_4()
	
_bAlive_idChar_RES_Coursive_00_15=IsAlive(_idChar_RES_Coursive_00_15)
	if(_bCoursive_right_4==0)then
		if(_bAlive_idChar_RES_Coursive_00_15==false)then
--			Freeze(_idChar_RES_Coursive_00_20,false)
			_bCoursive_right_4=1
		end
	end
end
-----------------------------------------------------
function OnEnter_Sector_Event_RADIO_1(id)
	
		if(id == _idPlayer)then
			SetVarValue(_idTimer_rad_1,"Active",true)
		end
end
------------------------------------------
function OnStay_Sector_Event_RADIO_1(id)


	if(id==_idPlayer)then
		Freeze(_idChar_SYND_03_2,true)
		Freeze(_idChar_SYND_02_2,true)
		Freeze(_idChar_SYND_00_1,true)
		Freeze(_idChar_SYND_02_1,true)
		Freeze(_idChar_SYND_03_3,true)
		Freeze(_idChar_RES_Coursive_00_7,true)
		Freeze(_idChar_RES_Coursive_00_4,true)
		SetVarValue(_idChar_RES_ExoMan_00_2,"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_EXO_7"))
	end
end
-------------------------------------------
function 	OnExit_Sector_Event_RADIO_1(id)

	if(id==_idPlayer)then
		Freeze(_idChar_SYND_03_2,false)
		Freeze(_idChar_SYND_02_2,false)
		Freeze(_idChar_SYND_02_1,false)
		Freeze(_idChar_SYND_03_3,false)
	end
end
-------------------------------------------
function OnEnter_Sector_Event_RADIO_2(id)	

			if(id == _idPlayer)then
			SetVarValue(_idTimer_rad_2,"Active",true)
			SetVarValue(_idChar_RES_ExoMan_00_2,"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_force_target"))
			end

end
--------------------------------------------
function Message_Hurry()

RadioMessage("DIA_SPE_NIV_N_GENERAL_RADIO_14",true,100,0.0,"")

end
----------------------------
function Message_StopDiversion()

RadioMessage("DIA_SPE_NIV_N_GENERAL_RADIO_17",true,100,0.0,"")

end
---------------------------------------------
--Explosion si je penetre vers le premier rocher face au premier rempart 
function OnStay_Sector_Event_limit_zone_1(id)

	if(_bOnStay_Sector_Event_limit_zone_1==0)then
		if(id == _idPlayer)then		
			_idExplo_1=CreateExplosion()
			_idExplo_2=CreateExplosion()

			SetVarValue(_idExplo_1,"Type","Explosion_Rocket_Bombardement")
			SetVarValue(_idExplo_1,"Position",Vector3D(646,-680,37))

			SetVarValue(_idExplo_2,"Type","Explosion_Rocket_Bombardement")
			SetVarValue(_idExplo_2,"Position",Vector3D(647,-629,36))
		_bOnStay_Sector_Event_limit_zone_1=1
		end
	end
end
-------------------------------------------
function OnEnter_Sector_Event_etage_ruine(id)

	if(_bOnEnter_Sector_Event_etage_ruine==0)then
		if(id==_idPlayer)and(_nBotsActifs<=8)then
			Freeze(_idChar_SYND_00_3,false)
			Freeze(_idChar_SYND_00_5,false)
			Freeze(_idChar_SYND_00_6,false)
			Freeze(_idChar_SYND_00_7,false)
			Freeze(_idChar_SYND_00_8,false)
			FreezeAll(_idGroup_Ruine_01,false)
			FreezeAll(_idGroup_Ruine_08,false)
		_bOnEnter_Sector_Event_etage_ruine=1
		end
	end
end
---------------------------------------------
--------------------------------------------
function OnEnter_Sector_Event_RUINE_1(id)

	if(_bOnEnter_Sector_Event_RUINE_1==0)then
		if(id == _idPlayer)then	
			FreezeAll(_idGroup_Ruine_03,false)
			Freeze(_idChar_RES_Ruine_00_2,false)

			Freeze(_idChar_SYND_00_1,true)
			Freeze(_idChar_SYND_03_3,true)
			Freeze(_idChar_RES_Coursive_00_7,true)
			Freeze(_idChar_RES_Coursive_00_4,true)
			Freeze(_idChar_RES_Coursive_00_1,true)
			_bOnEnter_Sector_Event_RUINE_1=1
		end
	end
end
---------------------------------------------
function Suite_ruines_1()

_bAlive_idGroup_Ruine_03=IsAlive(_idGroup_Ruine_03)

	if(_bSuite_RUINES_1==0)then
		if(_bAlive_idGroup_Ruine_03==false)then
			FreezeAll(_idGroup_Ruine_01,false)
			FreezeAll(_idGroup_Ruine_06,false)
		_bSuite_RUINES_1=1
		end
	end
end
--------------------------------------------
function OnEnter_Sector_Event_RUINE_2(id)

	if(_bOnEnter_Sector_Event_RUINE_2==0)then
		if(id == _idPlayer)then	
			FreezeAll(_idGroup_Ruine_01,false)
			FreezeAll(_idGroup_Ruine_06,false)
				SetVarValue(_idChar_RES_ExoMan_00_2,"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_force_target"))
			_bOnEnter_Sector_Event_RUINE_2=1
		end
	end
end

----------------------------------------------
function Suite_ruines_2()

_bAlive_idGroup_Ruine_02=IsAlive(_idGroup_Ruine_02)

	if(_bSuite_RUINES_2==0)then
		if(_bAlive_idGroup_Ruine_06==false)then
			FreezeAll(_idGroup_Ruine_05,false)
		_bSuite_RUINES_2=1
		end
	end
end
--------------------------------------------
function OnEnter_Sector_Event_RUINE_3(id)

	if(_bOnEnter_Sector_Event_RUINE_3==0)then
		if(id == _idPlayer)then	
			SetVarValue(_idChar_RES_ExoMan_00_2,"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_Char_RES_ExoMan_00_2"))
			FreezeAll(_idGroup_Ruine_05,false)
		end
		if IsEntityInBox(_idChar_RES_Ruine_01_3,"Sector_Event_middle_corniche")then
			Freeze(_idChar_RES_Ruine_01_3,true)
		_bOnEnter_Sector_Event_RUINE_3=0
		end
		if IsEntityInBox(_idChar_RES_Ruine_01_1,"Sector_Event_middle_corniche")then
			Freeze(_idChar_RES_Ruine_01_1,true)
			_bOnEnter_Sector_Event_RUINE_3=0
		end
			_bOnEnter_Sector_Event_RUINE_3=1		
	end
end
--------------------------------------------
function OnEnter_Sector_Event_RUINE_5(id)

	if(_bOnEnter_Sector_Event_RUINE_5==0)then
		if(id == _idPlayer)then	
			FreezeAll(_idGroup_Ruine_07,false)
			_bOnEnter_Sector_Event_RUINE_5=1
		end
		--if(id == _idPlayer)and(_nBotsActifs<=8)then	
		--	FreezeAll(_idGroup_Ruine_04,false)
		--end
			--_bOnEnter_Sector_Event_RUINE_5=1
	end
end
----------------------------------------
function OnExit_Sector_Event_RUINE_5(id)

	if(_bOnExit_Sector_Event_RUINE_5==0)then
		if(id == _idPlayer)then	
			FreezeAll(_idGroup_Ruine_06,false)
			_bOnExit_Sector_Event_RUINE_5=1
		end
	end
end
------------------------------------------
function Objectif_1()

_bAlive_idGroup_Ruine_01=IsAlive(_idGroup_Ruine_01)
_bAlive_idGroup_Ruine_02=IsAlive(_idGroup_Ruine_02)
_bAlive_idGroup_Ruine_03=IsAlive(_idGroup_Ruine_03)
_bAlive_idGroup_Ruine_05=IsAlive(_idGroup_Ruine_05)
_bAlive_idGroup_Ruine_06=IsAlive(_idGroup_Ruine_06)
_bAlive_idGroup_Ruine_07=IsAlive(_idGroup_Ruine_07)
--_bAlive_idGroup_Ruine_08=IsAlive(_idGroup_Ruine_08)
_idObj_A_1=GetObjectiveID("Obj_A_1")

	if(_bObjectif_1==0)then
		if((_bAlive_idGroup_Ruine_01==false)and(_bAlive_idGroup_Ruine_03==false)
																				and(_bAlive_idGroup_Ruine_05==false)
																				and(_bAlive_idGroup_Ruine_06==false)
																				and(_bAlive_idGroup_Ruine_07==false))then
--																				and(_bAlive_idGroup_Ruine_08==false))then
				if (_idMerc[0]~=nil) then
				SetVarValue(_idMerc_0,"CharacterOrderList",_idPasdeListe)
				end
			SetVarValue(_idTimer_dial_inge_1,"Active",false)
			SetVarValue(_idTimer_dial_inge_2,"Active",false)
			SetVarValue(_idTimer_dial_inge_1,"Loop",false)
			SetVarValue(_idTimer_dial_inge_2,"Loop",false)
				SetVarValue(_idChar_RES_ExoMan_00_2,"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_force_target"))
			NewSubObjective("Obj_A_1","Obj_A_3")
			SetVarValue(_idTimer_dial_inge_1,"Loop",false)			
			_bobjA1=true
			_bObjectif_1=1
		end
	end
end
----------------------------------------------------------------
function OnEnter_Sector_Event_groupe_ruine_08(id)

	if(_bOnEnter_Sector_Event_groupe_ruine_08==0)then
		if(id==_idPlayer)and(_bSuite_RUINES_1~=1)then
			FreezeAll(_idGroup_Ruine_08,false)
		_bOnEnter_Sector_Event_groupe_ruine_08=1
		end
	end
end














