function UpdateLevel_Camp()

end
-------------------------------------------------------------


------------------------------------------------------------
function OnEnter_Sector_Event_Camp_1(id)

	if(_bOnEnter_Sector_Event_Camp_1==0)then
		if(id == _idPlayer)then
			RadioMessage("DIA_SPE_NIV_N_GENERAL_RADIO_13",true,100,0.0,"") 
			Freeze(_idChar_RES_Camp_00_1,false)
			Freeze(_idChar_RES_Camp_00_2,false)
			Freeze(_idChar_RES_Camp_00_3,false)
			Freeze(_idChar_RES_Camp_00_4,false)
			Freeze(_idChar_RES_Camp_00_5,false)
			_bOnEnter_Sector_Event_Camp_1=1
		end
	end
end
------------------------------------------------------------
function First_renforts()

_bAliveChar_RES_Camp_00_5=IsAlive(_idChar_RES_Camp_00_5)
_bAliveChar_RES_Camp_00_13=IsAlive(_idChar_RES_Camp_00_13)
_bAliveChar_RES_Camp_00_14=IsAlive(_idChar_RES_Camp_00_14)


	if(_bAliveChar_RES_Camp_00_5==false)then
		Freeze(_idChar_RES_Camp_00_6,false)
	end
	if(_bAliveChar_RES_Camp_00_13==false)then
		Freeze(_idChar_RES_Camp_00_7,false)
	end
	if(_bAliveChar_RES_Camp_00_14==false)then
		Freeze(_idChar_RES_Camp_00_8,false)
	end
end
-----------------------------------------------------------
------------------------------------------------------------
function OnEnter_Sector_Event_Camp_2(id)

	if(_bOnEnter_Sector_Event_Camp_2==0)then
		if(id == _idPlayer)then
	Freeze(_idChar_RES_Camp_00_6,false)
	Freeze(_idChar_RES_Camp_00_7,false)
	Freeze(_idChar_RES_Camp_00_8,false)

		_bOnEnter_Sector_Event_Camp_2=1
		end
	end
end
-------------------------------------------------------------------------------------------------
function OnExit_Sector_Event_Camp_2(id)

	if(_bOnExit_Sector_Event_Camp_2==0)then
		if(id == _idPlayer)then
	Freeze(_idChar_RES_HANGAR_00_9,false)
	Freeze(_idChar_RES_HANGAR_00_10,false)
	Freeze(_idChar_RES_HANGAR_00_13,false)

		_bOnExit_Sector_Event_Camp_2=1
		end
	end
end
------------------------------------------------------------
function OnEnter_Sector_Event_Camp_3(id)

	if(_bOnEnter_Sector_Event_Camp_3==0)then
		if(id == _idPlayer)then
			Freeze(_idChar_RES_Camp_00_11,false)
			Freeze(_idChar_RES_Camp_00_15,false)
			Freeze(_idChar_RES_Camp_00_16,false)
			SetVarValue(_idChar_RES_ExoMan_00_2,"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_EXO_6"))
			_bOnEnter_Sector_Event_Camp_3=1
		end
	end
end
------------------------------------------------------------
function OnExit_Sector_Event_Camp_3(id)

	if(_bOnExit_Sector_Event_Camp_3==0)then
		if(id==_idPlayer)then
	Freeze(_idChar_RES_HANGAR_00_2,false)
	Freeze(_idChar_RES_HANGAR_00_12,false)
	Freeze(_idChar_RES_HANGAR_00_14,false)
	Freeze(_idChar_RES_HANGAR_00_11,false)
			_bOnExit_Sector_Event_Camp_3=1
		end
	end
end
---------------------------------------------------------
function Renforts_camp_1()

_bAlive_idChar_RES_Camp_00_1=IsAlive(_idChar_RES_Camp_00_1)
_bAlive_idChar_RES_Camp_00_2=IsAlive(_idChar_RES_Camp_00_2)
_bAlive_idChar_RES_Camp_00_6=IsAlive(_idChar_RES_Camp_00_6)
_bAlive_idChar_RES_Camp_00_15=IsAlive(_idChar_RES_Camp_00_15)
_bAlive_idChar_RES_Camp_00_16=IsAlive(_idChar_RES_Camp_00_16)

	if(_bRenforts_camp_1==0)then
		if((_bAlive_idChar_RES_Camp_00_15==false)and(_bAlive_idChar_RES_Camp_00_16==false))then
			Freeze(_idChar_RES_Camp_00_7,false)
			elseif(_bRenforts_camp_1==0)then
				if(_bAlive_idChar_RES_Camp_00_1==false)or(_bAlive_idChar_RES_Camp_00_2==false)then
					Freeze(_idChar_RES_Camp_00_8,false)
					SetVarValue(_idChar_RES_Camp_00_8,"Position",Vector3D(-164.402679,-406.121216,35.739975))
				_bRenforts_camp_1=1
				end	
		end
	end
end
-----------------------------------------------------------
function Renforts_Galerie_1()

_bAlive_idChar_RES_HANGAR_00_11=IsAlive(_idChar_RES_HANGAR_00_11)
_bAlive_idChar_RES_HANGAR_00_12=IsAlive(_idChar_RES_HANGAR_00_12)
_bAlive_idChar_RES_HANGAR_00_13=IsAlive(_idChar_RES_HANGAR_00_13)
_bAlive_idChar_RES_HANGAR_00_14=IsAlive(_idChar_RES_HANGAR_00_14)
_bAlive_idGroup_Galerie_01=IsAlive(_idGroup_Galerie_01)

	if(_bRenforts_Galerie_1==0)then
		if(_bAlive_idGroup_Galerie_01==false)then
			Freeze(_idChar_RES_HANGAR_00_11,false)
			Freeze(_idChar_RES_HANGAR_00_12,false)
			Freeze(_idChar_RES_HANGAR_00_13,false)
			Freeze(_idChar_RES_HANGAR_00_14,false)
			_bRenforts_Galerie_1=1
		end
	end
end
---------------------------------------------------------
function Renforts_Galerie_2()
_bAlive_idChar_RES_HANGAR_00_11=IsAlive(_idChar_RES_HANGAR_00_11)
_bAlive_idChar_RES_HANGAR_00_12=IsAlive(_idChar_RES_HANGAR_00_12)
_bAlive_idChar_RES_HANGAR_00_13=IsAlive(_idChar_RES_HANGAR_00_13)
_bAlive_idChar_RES_HANGAR_00_14=IsAlive(_idChar_RES_HANGAR_00_14)

_bAlive_idGroup_Galerie_01=IsAlive(_idGroup_Galerie_01)
	if(_bRenforts_Galerie_2==0)then
		if(_bAlive_idGroup_Galerie_01==false)and((_bAlive_idChar_RES_HANGAR_00_11==false)or(_bAlive_idChar_RES_HANGAR_00_12==false)
								or(_bAlive_idChar_RES_HANGAR_00_13==false)or(_bAlive_idChar_RES_HANGAR_00_14==false))then
			Freeze(_idChar_RES_HANGAR_00_9,false)
			Freeze(_idChar_RES_HANGAR_00_10,false)
			_bRenforts_Galerie_2=1
		end
	end
end
----------------------------------------------------------
function Exo_1_Come()

_bAlive_idChar_RES_HANGAR_00_9=IsAlive(_idChar_RES_HANGAR_00_9)
_bAlive_idChar_RES_HANGAR_00_10=IsAlive(_idChar_RES_HANGAR_00_10)
	if(_bExo_1_Come==0)then
		if((_bAlive_idChar_RES_HANGAR_00_9==false)and(_bAlive_idChar_RES_HANGAR_00_10==false))then
			EnableCharacterCommand(_idChar_RES_ExoMan_00_2,true)
			_bExo_1_Come=1
		end
	end
end
------------------------
function Exo_2_Come()
	if(_bExo_2_Come==0)then
	EnableCharacterCommand(_idChar_RES_ExoMan_00_1,true)
	_nBombardement=0
	SetVarValue(_idChar_RES_ExoMan_00_1,"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_EXO_6b"))
	RadioMessage("DIA_SPE_NIV_N_GENERAL_RADIO_15",true,100,0.0,"")
				--SetVarValue(_idExoskeleton_Hangar_3,"Health",2000)
				--SetVarValue(_idExoskeleton_Hangar_3,"Weakpoint Health",1000)

				--SetVarValue(_idExoskeleton_Hangar_5,"Health",2000)
			--SetVarValue(_idExoskeleton_Hangar_5,"Weakpoint Health",1000)
		_bExo_2_Come=1
	end
end
-----------------------
function Heliport()

_bAlive_idGroup_Galerie_01=IsAlive(_idGroup_Galerie_01)

--_idTimer_exo_2=GetTimerID("Timer_exo_2")
	if(_bHeliport==0)then
		if(_bAlive_idGroup_Galerie_01==false)then
			FreezeAll(_idGroup_Galerie_02,false)
			
	--		SetVarValue(_idTimer_exo_2,"Active",true)
			_bHeliport=1
		end
	end
end
------------------------------------------

------------------------------
function OnEnter_Sector_Event_CAM_INGE(id)


	if(_bOnEnter_Sector_Event_CAM_INGE==0)then
		if(id==_idPlayer)and(_nLife_Exo_UAN_3==0)and(_nLife_Exo_UAN_5==0)then
			--	SetGodMode(_idMerc[0],true)
				EnableCharacterCommand(_idMerc[0],true)
					UnLockDoor(_idDoor_Hack)
					OpenDoor(_idDoor_Hack)
				SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_HACK"))

			Freeze(_idChar_RES_Coursive_00_9,true)
			Freeze(_idChar_RES_Coursive_00_2,true)
			Freeze(_idChar_RES_Coursive_00_20,true)
			Freeze(_idChar_RES_Coursive_00_4,true)
			Freeze(_idChar_RES_Coursive_00_11,true)
			Freeze(_idChar_RES_Coursive_00_13,true)
			Freeze(_idChar_RES_Coursive_00_15,true)

				--RadioMessage("DIA_SPE_NIV_E_INGENIEUR_05",true,90,2,"")
			_bOnEnter_Sector_Event_CAM_INGE=1
		end

		if(id==_idPlayer)and(_nWPExo5 == 0)and(_nLife_Exo_UAN_3==0)then
			--	SetGodMode(_idMerc[0],true)
				EnableCharacterCommand(_idMerc[0],true)
					UnLockDoor(_idDoor_Hack)
					OpenDoor(_idDoor_Hack)
				SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_HACK"))

			Freeze(_idChar_RES_Coursive_00_9,true)
			Freeze(_idChar_RES_Coursive_00_2,true)
			Freeze(_idChar_RES_Coursive_00_20,true)
			Freeze(_idChar_RES_Coursive_00_4,true)
			Freeze(_idChar_RES_Coursive_00_11,true)
			Freeze(_idChar_RES_Coursive_00_13,true)
			Freeze(_idChar_RES_Coursive_00_15,true)

				--RadioMessage("DIA_SPE_NIV_E_INGENIEUR_05",true,90,2,"")
			_bOnEnter_Sector_Event_CAM_INGE=1
		end

		if(id==_idPlayer)and(_nLife_Exo_UAN_5==0)and(_nWPExo3 == 0)then
			--	SetGodMode(_idMerc[0],true)
				EnableCharacterCommand(_idMerc[0],true)
					UnLockDoor(_idDoor_Hack)
					OpenDoor(_idDoor_Hack)
				SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_HACK"))

			Freeze(_idChar_RES_Coursive_00_9,true)
			Freeze(_idChar_RES_Coursive_00_2,true)
			Freeze(_idChar_RES_Coursive_00_20,true)
			Freeze(_idChar_RES_Coursive_00_4,true)
			Freeze(_idChar_RES_Coursive_00_11,true)
			Freeze(_idChar_RES_Coursive_00_13,true)
			Freeze(_idChar_RES_Coursive_00_15,true)

				--RadioMessage("DIA_SPE_NIV_E_INGENIEUR_05",true,90,2,"")
			_bOnEnter_Sector_Event_CAM_INGE=1
		end

		if(id==_idPlayer)and(_nWPExo5 == 0)and(_nWPExo3 == 0)then
			--	SetGodMode(_idMerc[0],true)
				EnableCharacterCommand(_idMerc[0],true)
					UnLockDoor(_idDoor_Hack)
					OpenDoor(_idDoor_Hack)
				SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_HACK"))

			Freeze(_idChar_RES_Coursive_00_9,true)
			Freeze(_idChar_RES_Coursive_00_2,true)
			Freeze(_idChar_RES_Coursive_00_20,true)
			Freeze(_idChar_RES_Coursive_00_4,true)
			Freeze(_idChar_RES_Coursive_00_11,true)
			Freeze(_idChar_RES_Coursive_00_13,true)
			Freeze(_idChar_RES_Coursive_00_15,true)

				--RadioMessage("DIA_SPE_NIV_E_INGENIEUR_05",true,90,2,"")
			_bOnEnter_Sector_Event_CAM_INGE=1
		end
	end
end
-------------------------------------

----------------------------------------
function BackInge()

_idDoor_Portal=GetDoorID("Door-55")

_idDoor_1=GetDoorID("Door-54")
_idDoor_2=GetDoorID("Door-56")
_idDoor_3=GetDoorID("Door-59")


	
	if(_bBackInge==0)then
	SetVarValue(_idMerc_0,"CharacterOrderList",_idPasdeListe)
	SetGodMode(_idMerc[0],false)
	UnLockDoor(_idDoor_Portal,false)
	OpenDoor(_idDoor_Portal,true)
	UnLockDoor(_idDoor_1,false)
	OpenDoor(_idDoor_1,true)
	UnLockDoor(_idDoor_2,false)
	OpenDoor(_idDoor_2,true)
	UnLockDoor(_idDoor_3,false)
	OpenDoor(_idDoor_3,true)



	Freeze(_idChar_SYND_04_3,false)	
	Freeze(_idChar_SYND_05_1,false)
	Freeze(_idChar_SYND_05_2,false)
	Freeze(_idChar_SYND_05_3,false)
	Freeze(_idChar_SYND_05_4,false)
		_bBackInge=1
	end
end
-----------------------------------------
function Releve_Exo_1()

	if(_bReleve_1==0)then

		if(_nLife_Exo_UAN_5==0)then
			MiniMapTrack(_idExoskeleton_Hangar_5,2,false)
		_bReleve_1=1
		end

		if(_nWPExo5 == 0)then
			MiniMapTrack(_idExoskeleton_Hangar_5,2,false)
		_bReleve_1=1
		end

	end
end
-----------------------------------------
function Obj_C()

_idTimer_backinge=GetTimerID("Timer_backinge")
_idGLOW_ROUGE=GetGlow_ClientID("Glow_Client_127")
_idGLOW_ROUGE_porte=GetGlow_ClientID("Glow_Client_128")
_idObj_C_1=GetObjectiveID("Obj_C_1")


	if(_bObj_C==0)then
		if(_bHACK_ok==true)then

			SetVarValue(_idGLOW_ROUGE,"Color",Color(0,1,0))
			SetVarValue(_idGLOW_ROUGE_porte,"Color",Color(0,1,0))
		
			ObjectiveDoneNewObjectiveNewSubObjective("Obj_C","Obj_D","Obj_D_1")

			TankCancelAttack(_idTank_3)
			SetVarValue(_idTimer_backinge,"Active",true)

			StartMusic("Sounds//Music//BoS - BoS - Eradication theme.wav",true)
			
			_bObj_C=1
		end
	end
end
----------------------------------------
function OnEnter_Sector_Event_BLINDAGE_HACK(id)

_idDoor_Hack=GetDoorID("Door-51")

	if(_bOnEnter_Sector_Event_BLINDAGE_HACK==0)then

		if(id==_idPlayer)then
--			Freeze(_idChar_RES_Coursive_00_20,false)
		end

		if(id==_idPlayer)and((_nLife_Exo_UAN_3==0)and(_nLife_Exo_UAN_5==0))then
			UnLockDoor(_idDoor_Hack)
			OpenDoor(_idDoor_Hack)
		_bOnEnter_Sector_Event_BLINDAGE_HACK=1
		end

		if(id==_idPlayer)and((_nWPExo5 == 0)and(_nWPExo3 == 0))then
			UnLockDoor(_idDoor_Hack)
			OpenDoor(_idDoor_Hack)
		_bOnEnter_Sector_Event_BLINDAGE_HACK=1
		end

		if(id==_idPlayer)and((_nLife_Exo_UAN_5==0)and(_nWPExo3 == 0))then
			UnLockDoor(_idDoor_Hack)
			OpenDoor(_idDoor_Hack)
		_bOnEnter_Sector_Event_BLINDAGE_HACK=1
		end

		if(id==_idPlayer)and((_nLife_Exo_UAN_3==0)and(_nWPExo5 == 0))then
			UnLockDoor(_idDoor_Hack)
			OpenDoor(_idDoor_Hack)
		_bOnEnter_Sector_Event_BLINDAGE_HACK=1
		end


	end
end
------------------------------------------
function OnEnter_Sector_Event_hack(id)


_idTimerHack=GetTimerID("Timer_Hack")
	if(_bOnEnter_Sector_Event_hack==0)then
		if(id==_idMerc[0])then
		SetVarValue(_idTimerHack,"Active",true)
		_bOnEnter_Sector_Event_hack=1
		end
	end
end
------------------------------------
function Play_Sound_Hack()

_idSonHack=GetSound_ClientID("Sound_Client_509")
		SetVarValue(_idSonHack,"Playing",true)
end
-------------------------------------
function PostTimer_Hack()

_idTimer_hack_ok=GetTimerID("Timer_hack_ok")

		SetVarValue(_idTimer_hack_ok,"Active",true)
end
---------------------------------------
function HACK_ok()

	_bHACK_ok=true

end
----------------------------------------
function Obj_D()
_bAlive_idGroup_Galerie_02=IsAlive(_idGroup_Galerie_02)
_idObj_D_1=GetObjectiveID("Obj_D_1")
	if(_bObj_D==0)then	
		if(_nLife_Exo_UAN_3==0)and(_nLife_Exo_UAN_5==0)and(_bAlive_idGroup_Galerie_02==false)then
			NewSubObjective("Obj_D_1","Obj_D_2")
			_bObj_D=1
		end
		if((_nWPExo5 == 0)and(_nWPExo3 == 0))and(_bAlive_idGroup_Galerie_02==false)then
			NewSubObjective("Obj_D_1","Obj_D_2")
			_bObj_D=1
		end
		if((_nWPExo5 == 0)and(_nLife_Exo_UAN_3==0))and(_bAlive_idGroup_Galerie_02==false)then
			NewSubObjective("Obj_D_1","Obj_D_2")
			_bObj_D=1
		end
		if((_nLife_Exo_UAN_5==0)and(_nWPExo3 == 0))and(_bAlive_idGroup_Galerie_02==false)then
			NewSubObjective("Obj_D_1","Obj_D_2")
			_bObj_D=1
		end
	end
end