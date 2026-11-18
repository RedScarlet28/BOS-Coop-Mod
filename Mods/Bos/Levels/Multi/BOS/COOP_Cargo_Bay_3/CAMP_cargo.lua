function UpdateLevel_TEST_CAMP()
end
---------------------------------------------------------------------------
--------------------------------------------------------------
--function OnEnter_Sector_Event_Check_Player(_idCharInBox)
--	if (_idCharInBox == _idPlayer) and(_nLife_Exo_UAN_1~=0)then
	--	Freeze(_idMerc[0],true)
--	end
--end
---------------------------------------------------------------------------
function OnExit_Sector_Event_Alert(id)

	if(_bOnExit_Sector_Event_Alert==0)then	
		if(id==_idPlayer)then
			FreezeAll(_idGroup_UAN_Renforts_bat2,false)
			_bOnExit_Sector_Event_Alert=1
		end
	end
end
----------------------------------------------
function OnStay_Sector_Event_Alert(id)

_idAI_Order_List_pathway_canoon=GetAI_Order_ListID("AI_Order_List_pathway_canoon")
_idAI_Order_Use_Pathway_canoon_1=GetAI_Order_Use_PathwayID("AI_Order_Use_Pathway_canoon_1")
_idAI_Order_Goto_Waypoint_tourelle=GetAI_Order_Goto_WaypointID("AI_Order_Goto_Waypoint_tourelle")

	if(_bOnStay_Sector_Event_Alert==0)then
		if ((_idChar_UAN_Entrance_00_1) == id)then
			MakeCharacterSpeak(_idChar_UAN_Entrance_00_1,_idPlayer,"DIA_SPE_NIV_H_UAN_B_01",false,100,2,0.0,"",100.0)
			Freeze(_idChar_UAN_Esplanade_00_3,false)
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_3,false)
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_7,false)
		--	Freeze(_idChar_UAN_Pass_2_00_4,false)
			SetVarValue(_idAI_Order_List_pathway_canoon,"Order",_idAI_Order_Goto_Waypoint_tourelle,2)
			SetVarValue(_idAI_Order_Use_Pathway_canoon_1,"PriorityTorso",1)
			SetVarValue(_idAI_Order_Use_Pathway_canoon_1,"PriorityLegs",1)
			_bOnStay_Sector_Event_Alert=1
		end
	end
end
-------------------------------------------
----Cette boite est dans le "tunnel" d'accès
--Le joueur déclenche le defreeze 3 ennemis
----à l'entrée dans le camp
function OnEnter_Sector_Event_Entrance_1(id)
_idAlarm=GetSound_ClientID("Sound_Client_Alarme")
	if (_bOnEnter_Sector_Event_Entrance_1==0)then
		if (GetLocalCharacterID("Player")==id)then
			--if (_idMerc[1] ~= GetInvalidEntityID())then
			--	SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_follow_player"))
			--end
			NewSubObjective("Obj_A_1","Obj_A_2")
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_3,false)
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_7,false)
			Freeze(_idChar_UAN_Esplanade_00_3,false)
			Freeze(_idChar_UAN_Entrance_00_1,false)
			Freeze(_idChar_UAN_Entrance_00_2,false)
			Freeze(_idChar_UAN_Entrance_00_3,false)
			--FreezeAll(_idGroup_UAN_C2_01,false)
			--Freeze(_idChar_UAN_C1_01_2,false)
			SetVarValue(_idAlarm,"Playing",true)

			if(_bOK==true)then
			RadioMessage("DIA_SPE_NIV_H_INGENIEUR_24",true,100,0.0,"")
			end
			_bOnEnter_Sector_Event_Entrance_1=1
		end
	end
end
---------------------------------------------------------------------------------
--cette boite defreeze 3 ennemis de la 1 ere chambrée qui sortent et se postent // l'ingénieur se poste dans le camp 
--il dit qu'il rejoindra à l'ascenseur le joueur
function OnEnter_Sector_Event_Entrance_2(id)

	if(_bOnEnter_Sector_Event_Entrance_2==0) then
		if(GetLocalCharacterID("Player")==id)and(_nBotsActifs<=6)then
				FreezeAll(_idGroup_UAN_C2_01,false)
				_bOnEnter_Sector_Event_Entrance_2=1
		end
	end
end
-------------------------------------------------------------
----En entrant dans cette boite,le joueur déclenche le défreeze 
----du gars sur le toit
function OnEnter_Sector_Event_Entrance_3(id)

	if(_bOnEnter_Sector_Event_Entrance_3==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_Entrance_3)then
			Freeze(_idChar_UAN_Esplanade_00_4,false)
			Freeze(_idChar_UAN_GdBat_00_3,false)
			Freeze(_idChar_UAN_GdBat_00_6,false)
			if((GetLocalCharacterID("Player")==id)and(_bAlive_idGroup_UAN_Renforts_bat2==false)and(_nBotsActifs<=7))then
				Freeze(_idChar_UAN_Entrance_00_18,false)
				Freeze(_idChar_UAN_Entrance_00_19,false)
			end
			_byetOnEnter_Sector_Event_Entrance_3=true
			_bOnEnter_Sector_Event_Entrance_3=1
		end
	end
end
----------------------------------------------------------------
function OnExit_Sector_Event_Entrance_3(id)

	if(_bOnExit_Sector_Event_Entrance_3==0)then
		if(GetLocalCharacterID("Player")==id)and(_nBotsActifs<=6)then
			Freeze(_idChar_UAN_Entrance_00_13,false)
			Freeze(_idChar_UAN_Entrance_00_14,false)
			Freeze(_idChar_UAN_Entrance_00_16,false)
			_bOnExit_Sector_Event_Entrance_3=1
		end
	end
end
--------------------------------------------------------------
function OnEnter_Sector_Event_BARAQUE(id)

	if(_bOnEnter_Sector_Event_BARAQUE==0)then
		if(GetLocalCharacterID("Player")==id)then
		FreezeAll(_idGroup_UAN_Gd_bat_lvl1_renforts_01,false)
		_bOnEnter_Sector_Event_BARAQUE=1	
		end
	end
end
--------------------------------------------------------------
function OnEnter_Sector_Event_BARAQUE1(id)

	if(_bOnEnter_Sector_Event_BARAQUE1==0)then
		if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_UAN_C1_01_1,false)
			--Freeze(_idChar_UAN_C1_01_2,false)
			Freeze(_idChar_UAN_C1_01_3,false)
			MakeCharacterSpeak(_idChar_UAN_C1_01_3,_idPlayer,"DIA_SPE_NIV_H_UAN_B_01",true,100,2,0.5,"",100.0)	
		_bOnEnter_Sector_Event_BARAQUE1=1	
		end
	end
end
--------------------------------------------------------------------------





-----------------------------------------------------------
----En entrant dans cette boite,le joueur déclenche le défreeze 
----du groupe dans la tente 2 + 2 gars à la fenetre du batiment.

function OnEnter_Sector_Event_Load_C2(id)

_bAlive_idChar_UAN_C1_01_2=IsAlive(_idChar_UAN_C1_01_2)

	if (_bOnEnter_Sector_Event_Load_C2==0)then
		if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_UAN_Entrance_00_18,false)
			Freeze(_idChar_UAN_Entrance_00_19,false)
			_bOnEnter_Sector_Event_Load_C2=1
		end
	end
end
---------------------------------------------------------------------
--defreeze les gars de la tente au fond de la cour
function OnEnter_Sector_Event_C3(id)

_bAlive_idChar_UAN_Esplanade_00_1=IsAlive(_idChar_UAN_Esplanade_00_1)

	if(_bOnEnter_Sector_Event_C3==0) then
		if(GetLocalCharacterID("Player")==id)then
			FreezeAll(_idGroup_UAN_C1_02,false)
			Freeze(_idChar_UAN_Esplanade_00_1,false)
			_bOnEnter_Sector_Event_C3=1
		end
	end
end
---------------------------------------------------------------------
function NEW_function_2()

		if(_bNEW_function_2==0)then
			if(_bOnEnter_Sector_Event_C3==1)and(_nBotsActifs<=4)then
				Freeze(_idChar_UAN_Gd_bat_room1_00_1,false)
				Freeze(_idChar_UAN_GdBat_00_1,false)
				Freeze(_idChar_UAN_GdBat_00_2,false)
				_bNEW_function_2=1
			end
	end
end
-----------------------------------------------------------------------
function NEW_function_1()

	if(_bNEW_function_1==0)then
		if(_bAlive_idGroup_UAN_Renforts_bat2==false)and not(_byetOnEnter_Sector_Event_Entrance_3)and(_nBotsActifs<=4)then
			FreezeAll(_idGroup_UAN_C3_01,false)
			_bNEW_function_1=1
		end
	end
end
-------------------------------------------------------------------------------------
--function OnEnter_Sector_Event_Stair(id)


--	if(_bOnEnter_Sector_Event_Stair==0)then
	--		if(GetLocalCharacterID("Player")==id)then
				
		--		Freeze(_idChar_UAN_Esplanade_01_2,false)
		--		Freeze(_idChar_UAN_Gd_bat_lvl2_room1_01_1,false)
		--		Freeze(_idChar_UAN_Gd_bat_lvl2_room1_01_5,false)
		--		_byetOnEnter_Sector_Event_Stair=true	
		--	end
			--else _bOnEnter_Sector_Event_Stair=0
			--if((GetLocalCharacterID("Player")==id)and(_nLife_Exo_UAN_1>0)and(_byetOnEnter_Sector_Event_Stair==true))then	
			--		RadioMessage("DIA_SPE_NIV_H_INGENIEUR_26",true,100,0.0,"")
			--		SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Use_Pathway_inge_1"))
			--	_byetOnEnter_Sector_Event_Stair=true
		--	end
			--	if((GetLocalCharacterID("Player")==id)and(_nLife_Exo_UAN_1==0)and not(_binge))then 
			--		RadioMessage("DIA_SPE_NIV_H_INGENIEUR_27",true,100,0.0,"")			
			--		SetVarValue(_idMerc[0],"CharacterOrderList",_idPasdeListe)
			--		Freeze(_idMerc[0],false)
					
				--	SetMercenaryFollow(_idMerc[0],true)
				--	MiniMapTrack(_idObj_A_1,2,false)
				--	_binge=true
				--	_byetOnEnter_Sector_Event_Stair=true
				--	_bOnEnter_Sector_Event_Stair=1
			--	end
--	end
--end
--------------------------------------------------------------------------------
--Quand "Char_UAN_Gd_bat_lvl2_room1_01_4" et"Char_UAN_Gd_bat_lvl2_room1_01_2" et "Char_UAN_Gd_bat_lvl2_room2_02_4"
--sont morts il va hacker:

function Go_Hack()

_nVie_idChar_UAN_Gd_bat_lvl2_room2_02_4=GetHealth(_idChar_UAN_Gd_bat_lvl2_room2_02_4)

	if(_bGo_Hack==0)then
		if(_nVie_idChar_UAN_Gd_bat_lvl2_room2_02_4==0)then
			if(_idMerc[0]~=nil)then	
				SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_HACK_SYSTEM"))
				_bGo_Hack=1
			end
		end	
	end
end
-----------------------------------------------------------------------------
--Quand l'ingénieur rentre dans la zone de hack il fait deux waypoint : 
--un pour chaque terminal a pirater, on joue le son de hack
function OnEnter_Sector_Event_hack_1(id)

_idSound_Hack=GetSound_ClientID("Sound_Client_hack")

	if(_bOnEnter_Sector_Event_hack_1==0)then
		if(id==_idMerc[0])then
			SetVarValue(_idSound_Hack,"Playing",true)
			_bOnEnter_Sector_Event_hack_1=1
		end
	end
end

function OnExit_Sector_Event_hack_1(id)

_idSound_Hack=GetSound_ClientID("Sound_Client_hack")
_idGlow_Client_A=GetGlow_ClientID("Glow_Client_A")

	if(_bOnExit_Sector_Event_hack_1==0)then
		if(id==_idMerc[0])then
			SetVarValue(_idSound_Hack,"Playing",false)
			SetVarValue(_idGlow_Client_A,"Color",Color(0,1,0))
			_bOnExit_Sector_Event_hack_1=1
		end
	end
end
-------
function OnEnter_Sector_Event_hack_2(id)

_idSound_Hack=GetSound_ClientID("Sound_Client_hack")

	if(_bOnEnter_Sector_Event_hack_2==0)then
		if(id==_idMerc[0])then
			SetVarValue(_idSound_Hack,"Playing",true)
			_bOnEnter_Sector_Event_hack_2=1
		end
	end
end

function OnExit_Sector_Event_hack_2(id)

_idSound_Hack=GetSound_ClientID("Sound_Client_hack")
_idGlow_Client_B=GetGlow_ClientID("Glow_Client_B")

	if(_bOnExit_Sector_Event_hack_2==0)then
		if(id==_idMerc[0])then
			SetVarValue(_idSound_Hack,"Playing",false)
			SetVarValue(_idGlow_Client_B,"Color",Color(0,1,0))
			_bOnExit_Sector_Event_hack_2=1
			_bHack_OK=true
		end
	end
end
------------------------------------------------------------------------------
----Quand le système est piraté par l'ingénieur alors la porte est delockée.
--Cinematique 3 secondes sur la porte.
function Unlocked()

_idCamTransition_hack=GetCamTransitionID("CamTransition_hack")

	if(_bUnlocked==0)then
		if(_bHack_OK==true)then
			LaunchCameraTransition(_idCamTransition_hack)
			ShowCinematicBlackStripes(true)
			UnLockDoor(_idDoor_A,true)	
			OpenDoor(_idDoor_A,true)	
			if(_idMerc[0]~=nil) then
			SetVarValue(_idMerc[0],"CharacterOrderList",_idPasdeListe)
			end
			_bUnlocked=1
		end
	end
end
-------------------------------------------------------------------------------
--fin de la cinematique : objectif à jour 
function Obj_Hack_ok()
	if(_bObj_Hack_ok==0)then
		ShowCinematicBlackStripes(false)
		NewSubObjective("Obj_A_3","Obj_A_4")
		_bObj_Hack_ok=1
		
	end
end
---------------------------------------------------------------------------
-----LA PORTE MENANT à la DCA est bloquée,arrive devant sans avoir deloquée et tu entendra
----"DIA_SPE_NIV_N_GENERAL_RADIO_18" ---:>"It only remains this door,find the switch !"
function OnEnter_Sector_Event_Stair(id)

	if(_bOnEnter_Sector_Event_Stair==0)then
			if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_Stair)and not(_bHack_OK)then
				Freeze(_idChar_UAN_Esplanade_01_2,false)
				Freeze(_idChar_UAN_Gd_bat_lvl2_room1_01_1,false)
				Freeze(_idChar_UAN_Gd_bat_lvl2_room1_01_5,false)
				RadioMessage("DIA_SPE_NIV_N_GENERAL_RADIO_18",true,100,0.0,"")
				_byetOnEnter_Sector_Event_Stair=true	
			end
	end
end

----------------------------------------------------
function OnEnter_Sector_Event_STAGE_1(id)
_idAlarm=GetSound_ClientID("Sound_Client_Alarme")

	if(_bOnEnter_Sector_Event_STAGE_1==0)then 
		if(GetLocalCharacterID("Player")==id)and(_binge==true)then
			SetVarValue(_idAlarm,"Playing",false)
			RadioMessage("DIA_SPE_NIV_H_INGENIEUR_28",true,100,0.0,"")		
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_1,false)
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_2,false)
			--Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_5,false)
			--Freeze(_idChar_UAN_Esplanade_01_1,false)	
			_bOnEnter_Sector_Event_STAGE_1=1
		end
	end
end
-----------------------------------------------
function OnEnter_Sector_Event_STAGE_4(id)

	if(_bOnEnter_Sector_Event_STAGE_4==0)then
		if(GetLocalCharacterID("Player")==id)then	
			Freeze(_idChar_UAN_Pass_2_00_3,false)
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_5,false)
			_bOnEnter_Sector_Event_STAGE_4=1
		end
	end
end
-----------------------------------------------------------
function OnStay_Sector_Event_STAGE_4(id)

_bFrozenGroup_UAN_C1_02=AreAllFrozen(_idGroup_UAN_C1_02)

	if(_bOnStay_Sector_Event_STAGE_4==0)then
		if(GetLocalCharacterID("Player")==id)and(_bFrozenGroup_UAN_C1_02==true)then	
			FreezeAll(_idGroup_UAN_C1_02,false)
			--SetVarValue(_idChar_UAN_C1_02_1,"Position",Vector3D(-1384.973999,-495.729553,184.729523))
			--SetVarValue(_idChar_UAN_C1_02_2,"Position",Vector3D(-1553.378662,-461.296021,218.768707))
		--	SetVarValue(_idChar_UAN_C1_02_3,"Position",Vector3D(-1494.742554,-559.975220,150.630508))
			_bOnStay_Sector_Event_STAGE_4=1
		end
	end
end
-----------------------------------------------------------
function OnEnter_Sector_Event_STAGE_6(id)

	if(_bOnEnter_Sector_Event_STAGE_6==0)then
		if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_UAN_Pass_1_00_1,false)
			Freeze(_idChar_UAN_Pass_2_00_2,false)
			Freeze(_idChar_UAN_Pass_2_00_5,false)
			Freeze(_idChar_UAN_Pass_2_00_6,false)
			_bOnEnter_Sector_Event_STAGE_6=1
		end
	end
end
-----------------------------------------------------------
function Sortie_Renforts_Chambre_A()

	if(_bSortie_Renforts_Chambre_A==0)then
		if(_bAlive_idChar_UAN_Entrance_00_1==false)or(_bAlive_idChar_UAN_Entrance_00_2==false)then
			Freeze(_idChar_UAN_Gd_bat_lvl1_renforts_01_1,false)
			Freeze(_idChar_UAN_C1_01_2,false)
		_bSortie_Renforts_Chambre_A=1
		end
	end
end
---------------------------------------------------------
function OnEnter_Sector_Event_CHAMBRE_A(id)


	if(_bOnEnter_Sector_Event_CHAMBRE_A==0)then	
		if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_UAN_Esplanade_00_3,false)
			_bOnEnter_Sector_Event_CHAMBRE_A=1
		end
	end
end
--------------------------------------------------------------------
function OnEnter_Sector_Event_CHAMBRE_B(id)


	if(_bOnEnter_Sector_Event_CHAMBRE_B==0)then	
		if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_UAN_Esplanade_00_3,false)
			_bOnEnter_Sector_Event_CHAMBRE_B=1
		end
	end
end
----------------------------------------------
----Si le joueur prend l'allée qui mène au camion
----il defreeze un groupe 3 individu 1 derrière le camion ,2 derriere resevoir

function OnEnter_Sector_Event_Allee_Camion(id)

	if (_bOnEnter_Sector_Event_Allee_Camion==0)then
		if(GetLocalCharacterID("Player")==id)then
			FreezeAll(_idGroup_UAN_C3_01,false)
			Freeze(_idChar_UAN_Esplanade_00_3,false)
			Freeze(_idChar_UAN_Entrance_00_17,false)
			FreezeAll(_idGroup_UAN_C2_01,true)
			_bOnEnter_Sector_Event_Allee_Camion=1
		end
	end
end
-----------------------------------------------------------------------------
----------------------------------------------------------
function OnStay_Sector_Event_PLACE(id)

	if(_bOnStay_Sector_Event_PLACE==0)then
		if((GetLocalCharacterID("Player")==id)and(_nBotsActifs<=5))then
				FreezeAll(_idGroup_TURTLE,false)
			_bOnStay_Sector_Event_PLACE=1
		end
	end
end
----------------------
function OnEnter_Sector_Event_BUILDING(id)

	if(GetLocalCharacterID("Player")==id)then
			FreezeAll(_idGroup_UAN_C1_02,true)
			FreezeAll(_idGroup_UAN_C2_01,true)
			FreezeAll(_idGroup_UAN_C3_01,true)
			Freeze(_idChar_UAN_Esplanade_00_1,true)
			Freeze(_idChar_UAN_Entrance_00_13,true)
			Freeze(_idChar_UAN_Entrance_00_14,true)
			Freeze(_idChar_UAN_Entrance_00_16,true)
			Freeze(_idChar_UAN_Entrance_00_17,true)
			Freeze(_idChar_UAN_Gd_bat_lvl1_renforts_01_1,true)	
	end
end
----------------------------------------------------
function OnExit_Sector_Event_BUILDING(id)

	if(_bOnExit_Sector_Event_BUILDING==0)then
		if(GetLocalCharacterID("Player")==id)then
			FreezeAll(_idGroup_UAN_C3_01,false)
			Freeze(_idChar_UAN_GdBat_00_4,false)
			Freeze(_idChar_UAN_Entrance_00_13,true)
			Freeze(_idChar_UAN_Entrance_00_16,true)	
			_bOnExit_Sector_Event_BUILDING=1
		end
	end
end
-------------------
function DCA_EXPOLO()


IsDestroyedDCA=GetVarValue(_idDestructible_Object_31,"Destroyed")

	if(_bDCA_EXPOLO==0)then
		if(IsDestroyedDCA==true)then
		--	SetVarValue(_idTimer_ENDOFDEMO,"Active",true)
			_bDCA_EXPOLO=1
		end
	end
end
--------------------

----------------