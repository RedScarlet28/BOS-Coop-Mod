function UpdateLevel_Heliport()
end
------------------------------------------------------------------------
--on refreeze tous ceux qui sont avant cette boite
function OnEnter_Sector_Event_heliport_intro(id)
	if(_bOnEnter_Sector_Event_heliport_intro==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_heliport_intro)then
			Freeze(_idChar_RES_HELPORT_1,false)
			Freeze(_idChar_RES_HELPORT_2,false)
			Freeze(_idChar_RES_HELPORT_55,false)
			Freeze(_idChar_RES_SNIPER_2,false)
			Freeze(_idChar_RES_SNIPER_4,false)
			---------------------------------------------
			Freeze(_idChar_RES_1FLOOR_1,true)
			Freeze(_idChar_RES_1FLOOR_2,true)
			Freeze(_idChar_RES_1FLOOR_8,true)
			Freeze(_idChar_RES_1FLOOR_7,true)
			Freeze(_idChar_RES_1FLOOR_12,true)
			Freeze(_idChar_RES_1FLOOR_25,true)
			Freeze(_idChar_RES_1FLOOR_27,true)
			Freeze(_idChar_RES_Snip_00_1,true)
			Freeze(_idChar_RES_1FLOOR_3,true)
			Freeze(_idChar_RES_1FLOOR_11,true)
			Freeze(_idChar_RES_RDC_01_15,true)
			Freeze(_idChar_RES_1FLOOR_18,true)
			Freeze(_idChar_RES_RDC_01_5,true)
			Freeze(_idChar_RES_Snip_00_5,true)
			Freeze(_idChar_RES_Snip_00_4,true)
			Freeze(_idChar_RES_RDC_01_4,true)
			Freeze(_idChar_RES_Snip_00_3,true)
			Freeze(_idChar_RES_RDC_01_13,true)
			Freeze(_idChar_RES_RDC_01_18,true)
			Freeze(_idChar_RES_RDC_01_3,true)
			Freeze(_idChar_RES_RDC_01_11,true)
			Freeze(_idChar_RES_RDC_01_1,true)
			Freeze(_idChar_RES_RDC_01_8,true)
			Freeze(_idChar_RES_RDC_01_7,true)
			Freeze(_idChar_RES_RDC_01_14,true)
			Freeze(_idChar_RES_Snip_00_2,true)
			Freeze(_idChar_RES_RDC_01_15,true)
			Freeze(_idChar_RES_1FLOOR_19,true)
			Freeze(_idChar_RES_1FLOOR_20,true)
			Freeze(_idChar_RES_1FLOOR_21,true)
			Freeze(_idChar_RES_1FLOOR_22,true)
--affiche dialogue
			MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_N_INGENIEUR_A_09",true,100,2,0.0,"",0)
			_byetOnEnter_Sector_Event_heliport_intro=true
			_bOnEnter_Sector_Event_heliport_intro=1
		end
	end
end
----------------------------------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_heliport_start(id)
	if(_bOnEnter_Sector_Event_heliport_start==0)then
		
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_heliport_start)then
				Freeze(_idChar_RES_HELPORT_13,false)
				Freeze(_idChar_RES_HELPORT_55,false)
			Freeze(_idChar_RES_SNIPER_1,false)		
			Freeze(_idChar_RES_SNIPER_3,false)
			_byetOnEnter_Sector_Event_heliport_start=true
			_bOnEnter_Sector_Event_heliport_start=1
		end
	end
end
-------------------------------------------
function OnExit_Sector_Event_heliport_start(id)


	if(_bOnExit_Sector_Event_heliport_start==0)then		
		if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_RES_SNIPER_1,false)		
			Freeze(_idChar_RES_SNIPER_3,false)
			_bOnExit_Sector_Event_heliport_start=1
		end
	end
end
---------------------------------------------------------------------------------------
--boite et script qui permet de faire apparaitre les alliés puisqu'il ne peuvent pas tomber du balcon.
--function OnEnter_Sector_Event_allie_go_hel(id)

--	if(_bOnEnter_Sector_Event_allie_go_hel==0)then
	--	if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_allie_go_hel)then
		--	SetVarValue(_idChar_SYND_allie_01_1,"Position",Vector3D(1611.883423,301.236450,243.516068))
		--  SetVarValue(_idChar_SYND_allie_01_2,"Position",Vector3D(1603.843994,301.162445,243.656357))
		--	SetVarValue(_idChar_SYND_allie_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_follow_player"))
		--	SetVarValue(_idChar_SYND_allie_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_follow_player"))
		--	SetVarValue(_idMerc[0],"Position",Vector3D(1605.081665,286.152283,243.499695))
		--	if(_idMerc[1]~=nil)then
		--	SetVarValue(_idMerc[1],"Position",Vector3D(1612.092407,291.920135,243.512436))
		--	end
	--		_byetOnEnter_Sector_Event_allie_go_hel=true
	--		_bOnEnter_Sector_Event_allie_go_hel=1
	--		end
--	end
--end
---------------------------------------------------------------------------------------
--defreeze un ennemi a la mort d'un des 2 premiers
function Renforts_start()
	if(_bRenforts_start==0)then

	_bAliveChar_RES_HELPORT_1=IsAlive(_idChar_RES_HELPORT_1)
	_bAliveChar_RES_HELPORT_2=IsAlive(_idChar_RES_HELPORT_2)
	
		if(_bAliveChar_RES_HELPORT_1==false)or(_bAliveChar_RES_HELPORT_2==false)then
		Freeze(_idChar_RES_HELPORT_13,false)
		Freeze(_idChar_RES_HELPORT_10,false)
		_bRenforts_start=1
		end
	end
end
------------------------------------------------------------------------------------------
----defreeze des ennemis
function Renforts_maison_1()
	if(_bRenforts_maison_1==0)then
		_bAliveChar_RES_HELPORT_53=IsAlive(_idChar_RES_HELPORT_53)
		if(_bAliveChar_RES_HELPORT_53==false)then
			Freeze(_idChar_RES_HELPORT_55,false)
			_bRenforts_maison_1=1
		end
	end
end
-----------------------------------------------------------------------------
--defreeze des ennemis
function Renforts_Start2()
	if(_bRenforts_Start2==0)then
	
	_bAliveChar_RES_HELPORT_10=IsAlive(_idChar_RES_HELPORT_10)
		if(_bAliveChar_RES_HELPORT_10==false)then
			FreezeAll(_idGroup_HELIPORT_Maison_2_02,false)
			_bRenforts_Start2=1
		end
	end
end

--------------------------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_heliport_start1(id)
	if(_bOnEnter_Sector_Event_heliport_start1==0)then

		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_heliport_start1)then
			Freeze(_idChar_RES_HELPORT_48,false)
			Freeze(_idChar_RES_HELPORT_10,false)
			Freeze(_idChar_RES_HELPORT_11,false)
			Freeze(_idChar_RES_HELPORT_55,false)
			FreezeAll(_idGroup_HELIPORT_Maison_2_02,false)
			_byetOnEnter_Sector_Event_heliport_start1=true
			_bOnEnter_Sector_Event_heliport_start1=1

		end
	end
end
---------------------------------------------------------------------------------

----------------------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_HELI_2(id)
	if(_bOnEnter_Sector_Event_HELI_2==0)then

		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_HELI_2)then
			Freeze(_idChar_RES_HELPORT_53,false)
			Freeze(_idChar_RES_HELPORT_58,false)
			Freeze(_idChar_RES_HELPORT_6,false)
			Freeze(_idChar_RES_HELPORT_22,false)
			Freeze(_idChar_RES_HELPORT_25,false)
			Freeze(_idChar_RES_HELPORT_27,false)
			Freeze(_idChar_RES_HELPORT_28,false)
			Freeze(_idChar_RES_HELPORT_30,false)
			Freeze(_idChar_RES_HELPORT_46,false)
			_byetOnEnter_Sector_Event_HELI_2=true
			_bOnEnter_Sector_Event_HELI_2=1
		end
	end
end
---------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_HELI_3(id)
	if(_bOnEnter_Sector_Event_HELI_3==0)then

		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_HELI_3)then
			Freeze(_idChar_RES_HELPORT_15,false)
			Freeze(_idChar_RES_HELPORT_16,false)
			Freeze(_idChar_RES_HELPORT_24,false)
			
			_byetOnEnter_Sector_Event_HELI_3=true
			_bOnEnter_Sector_Event_HELI_3=1
		end
	end
end
--------------------------------------------------------------------
--defreeze un ennemis à la mort d'autres
function Renforts_Heli()
	if(_bRenforts_Heli==0)then
_bAlive_idChar_RES_HELPORT_22=IsAlive(_idChar_RES_HELPORT_22)
_bAlive_idChar_RES_HELPORT_25=IsAlive(_idChar_RES_HELPORT_25)
_bAlive_idChar_RES_HELPORT_27=IsAlive(_idChar_RES_HELPORT_27)
_bAlive_idChar_RES_HELPORT_28=IsAlive(_idChar_RES_HELPORT_28)
		if(_byetOnEnter_Sector_Event_HELI_3==true)and((_bAlive_idChar_RES_HELPORT_22==false)and(_bAlive_idChar_RES_HELPORT_25==false))
		and(_bAlive_idChar_RES_HELPORT_27==false)or(_bAlive_idChar_RES_HELPORT_28==false) then
			Freeze(_idChar_RES_HELPORT_18,false)
			_bRenforts_Heli=1
		end
	end
end
--------------------------------------------------------
--FUNCTION PROVISOIRE declenche l'arrivée par hélicoptère du nouvel ingénieur.

function OnEnter_Sector_Event_porte_maison_3(id)

_idSound_Client_helico=GetSound_ClientID("Sound_Client_helico")

	if(_bOnEnter_Sector_Event_porte_maison_3==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_porte_maison_3)then
			--SetVarValue(_idSound_Client_helico,"Playing",true)
		--	Freeze(_idChar_SYND_allie_01_1,false)
		--	Freeze(_idChar_SYND_allie_01_2,false)
			_byetOnEnter_Sector_Event_porte_maison_3=true
			_bOnEnter_Sector_Event_porte_maison_3=1
		end	
	end
end
-------------------------------------------------------------------------------------------------
--defreeze des ennemis
function Renforts_maison_3()
	if(_bRenforts_maison_3==0)then
			_bAlive_idChar_RES_HELPORT_18=IsAlive(_idChar_RES_HELPORT_18)
				if(_bAlive_idChar_RES_HELPORT_18==false)then
					 Freeze(_idChar_RES_HELPORT_34,false)
				 --  Freeze(_idChar_RES_HELPORT_35,false)
			_bRenforts_maison_3=1
				end
	end
end
------------------------------------------------------------------
--affiche dialogue
function OnEnter_Sector_Event_embuscade(id)
	if (_bOnEnter_Sector_Event_embuscade==0)then
		if (_idChar_RES_HELPORT_46==id)then
			MakeCharacterSpeak(_idChar_RES_HELPORT_46,_idPlayer,"DIA_SPE_NIV_N_RESIS_B_01",false,100,2,0.0,"",100)
			_bOnEnter_Sector_Event_embuscade=1
		end
	end
end
----------------------------------------------------------------------------------------
--defreeze des ennemis
--ingénieur fait mine d'hacker la porte
function OnEnter_Sector_Event_Heliport_porte(id)


	if(_bOnEnter_Sector_Event_Heliport_porte==0)then
		
		if(GetLocalCharacterID("Player")==id)and(_bHacking==true)then
			Freeze(_idChar_RES_COURT_3,false)
			Freeze(_idChar_RES_COURT_7,false)
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_HACK"))
			MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_N_INGENIEUR_B_10",true,95,2,0.0,"",95)		
			_bOnEnter_Sector_Event_Heliport_porte=1
		end
	end
end
---------------------------------------------------------
function Sound_Hack()

_idTimer_Hack=GetTimerID("Timer_Hack")
_idSound_hack=GetSound_ClientID("Sound_Client_hack")

	if(_bSound_Hack==0)then
		
			SetVarValue(_idTimer_Hack,"Active",true)
			SetVarValue(_idSound_hack,"Playing",true)
			_bSound_Hack=1
	end
end
----------------------------------------------------------
function Hack()

_idDoor_A2=GetDoorID("Door_A2")
	if(_bHack==0)then
			UnLockDoor(_idDoor_A2)
			OpenDoor(_idDoor_A2)
			NewSubObjective("Obj_E_4","Obj_E_5")
			_bHack=1
	end
end
-------------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_maison_2(id)

	if(_bOnEnter_Sector_Event_maison_2==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_maison_2)then
			FreezeAll(_idGroup_HELIPORT_Maison_2_02,false)
			_byetOnEnter_Sector_Event_maison_2=true
			_bOnEnter_Sector_Event_maison_2=1
		end
	end
end	
--------------------------------------------------------------------
--defreeze des ennemis
function OnExit_Sector_Event_stair(id)

if(_bOnExit_Sector_Event_stair==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnExit_Sector_Event_stair)then
			Freeze(_idChar_RES_HELPORT_39,false)
			Freeze(_idChar_RES_HELPORT_40,false)
			Freeze(_idChar_RES_SNIPER_1,false)	
			Freeze(_idChar_RES_SNIPER_2,false)	
			Freeze(_idChar_RES_SNIPER_3,false)	
			Freeze(_idChar_RES_SNIPER_4,false)
			_byetOnExit_Sector_Event_stair=true
			_bOnOnExit_Sector_Event_stair=1
		end
	end
end	
-------------------------------------------------
--defreeze des ennemis
function Renforts_bas()
	
 if(_bRenforts_bas==0)then
		if(_bOnOnExit_Sector_Event_stair==1)then
			Freeze(Char_RES_HELPORT_38,false)
			_bRenforts_bas=1
		end
	end
end
-----------------------------------------------------------------
--defreeze des ennemis
function OnExit_Sector_Event_Retour_part_1(id)

	if(_bOnExit_Sector_Event_Retour_part_1==0) then
		if(GetLocalCharacterID("Player")==id)then
				FreezeAll(_idGroup_HELIPORT_Maison_2_03,false)
			_bOnExit_Sector_Event_Retour_part_1=1
		end
	end
end
--------------------------------------------------------------------------
--defreeze des ennemis : quand l'heliport a été nettoyé sur le chemin du retour
function OnExit_Sector_Event_HELI_3(id)

	
	if(_bOnExit_Sector_Event_HELI_3==0)then
		if(id==(_idChar_RES_HELPORT_45))or(id==(_idChar_RES_HELPORT_49))or(id==(_idChar_RES_HELPORT_50))then
			FreezeAll(_idGroup_HELIPORT_Maison_2_04,false)
			_bOnExit_Sector_Event_HELI_3=1
		end
	end
end
---------------------------------------------------------------------
function OnEnter_Sector_Event_HELI_1(id)

	if(_bOnEnter_Sector_Event_HELI_1==0)then
		if(GetLocalCharacterID("Player")==id)then
			NewSubObjective("Obj_E_2","Obj_E_3")
			_bOnEnter_Sector_Event_HELI_1=1
		end
	end
end
---------------------------------
function OnExit_Sector_Event_HELI_1(id)

	if(_bOnExit_Sector_Event_HELI_1==0)then
		if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_RES_SNIPER_5,false)	
			Freeze(_idChar_RES_SNIPER_6,false)	
			Freeze(_idChar_RES_SNIPER_7,false)	
		_bOnExit_Sector_Event_HELI_1=1
		end
	end
end
----------------------------------------------------------------------











