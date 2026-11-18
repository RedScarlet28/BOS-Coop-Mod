function UpdateLevel_Warehouse()

end
-----------------------------------------------
--SCRIPT PROVISOIRE EN ATTENDANT LES PORTES
--quand le joueur s'approche du deuxieme hangar, on lui dit que la grille est fermé
function OnEnter_Sector_Event_Grille_Closed(id)
	if(_bOnEnter_Sector_Event_Grille_Closed==0)and not(_byetOnEnter_Sector_Event_Grille_Closed)and not(_b_yet_OnStay_Sector_Event_Catch_explosives)and(_bOnEnter_Sector_Event_Sortie_explo_ok==0)then
		if (GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_UAN_Entrepot_00_8,false)
			Freeze(_idChar_UAN_Entrepot_00_4,false)
			if(_idChar_WRF_01_1~=nil)then
			--MakeCharacterSpeak(_idChar_WRF_01_1,_idPlayer,"DIA_SPE_NIV_G_WRF_C_01",true,100,2,0.0,"",100) 
			RadioMessage("DIA_SPE_NIV_G_WRF_C_01",true,100,0.0,"")
			end
		_byetOnEnter_Sector_Event_Grille_Closed=true                   
		_bOnEnter_Sector_Event_Grille_Closed=1
		end
	end
end
-----------------------------------------------
--SCRIPT PROVISOIRE EN ATTENDANT LES PORTES
--on teste par où il est passé pour savoir si il peut prendre les explosifs
function OnEnter_Sector_Event_securit_grilleclosed(id)
	if(_bOnEnter_Sector_Event_securit_grilleclosed==0)then
		if (GetLocalCharacterID("Player")==id)then
			_btriche=true
		_bOnEnter_Sector_Event_securit_grilleclosed=1
		end
	end
end
-------------------------------------------------------
function Picked() 
_bOnStay_Sector_Event_Catch_explosives=0
end
-------------------------------------------------------
--Prise d'explosifs validée
function OnStay_Sector_Event_Catch_explosives(id)

_idObj_A_2=GetObjectiveID("Obj_A_2")

	if(_bOnStay_Sector_Event_Catch_explosives==0) then
		if(GetLocalCharacterID("Player")==id)and not(_b_yet_OnStay_Sector_Event_Catch_explosives)then
			RadioMessage("DIA_SPE_NIV_G_GENERAL_RADIO_03",true,100,0.0,"")
			ObjectiveDoneNewObjectiveNewSubObjective ("Obj_A","Obj_B","Obj_B_1" )
			MiniMapTrack(_idObj_A_2, 2,false)
			_b_yet_OnStay_Sector_Event_Catch_explosives=true
			_bOnStay_Sector_Event_Catch_explosives=1
		end 
	end
end
--------------------------------------------------------

--------------------------------------------------------

----------------------------------------------------
--defreeeze ennemis, ordre aux alliés
function OnEnter_Sector_Event_Entree_Warehouse(id)
	if(_bOnEnter_Sector_Event_Entree_Warehouse==0) then
		if (GetLocalCharacterID("Player")==id)and not(_b_yet_OnEnter_Sector_Event_Entree_Warehouse)then
			Freeze(_idChar_UAN_Warehouse_00_1,false)
			Freeze(_idChar_UAN_Warehouse_00_2,false)
			SetVarValue(_idGrp_WRF_01,"GroupAIOrderList",GetAI_Order_ListID("AI_Order_List_go_waypoint_warehouse_1"))
			_b_yet_OnEnter_Sector_Event_Entree_Warehouse=true
			_bOnEnter_Sector_Event_Entree_Warehouse=1
		end
	end
end
------------------------------------------------------
--defreeeze ennemis, ordre auwx alliés

function Renforts_warehouse()
	if(_bRenforts_warehouse==0) then
			_n_Health_idChar_UAN_Warehouse_00_1=IsAlive(_idChar_UAN_Warehouse_00_1)
			_n_Health_idChar_UAN_Warehouse_00_2=IsAlive(_idChar_UAN_Warehouse_00_2)
		if (_n_Health_idChar_UAN_Warehouse_00_1==false)or(_n_Health_idChar_UAN_Warehouse_00_2==false)then
			Freeze(_idChar_UAN_Renforts_warehouse_02_2,false)
			Freeze(_idChar_UAN_Renforts_warehouse_02_4,false)
			SetVarValue(_idChar_WRF_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_WRF_follow_player"))
			SetVarValue(_idChar_WRF_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_WRF_follow_player"))
			_bRenforts_warehouse=1
		end
	end
end
---------------------------------------------------------------------
function OnEnter_Sector_Event_zone_interdite_entrepot(id)

	if(_bOnEnter_Sector_Event_zone_interdite_entrepot==0)then
		if(GetLocalCharacterID("Player")==id)and(_bOnStay_Sector_Event_Catch_explosives==1)then
			StartMusic("Sounds//Music//BoS - Twilight theme.wav",true)
			Freeze(_idChar_UAN_Renforts_warehouse_02_1,false)
			Freeze(_idChar_UAN_Renforts_warehouse_02_3,false)
			FreezeAll(_idGroup_UAN_Warehouse_01,false)
		_bOnEnter_Sector_Event_zone_interdite_entrepot=1
		end
	end
end
-----------------------------------------------------------------------------
function OnEnter_Sector_Event_securit_not_triche(id)

	if(_bOnEnter_Sector_Event_securit_not_triche==0)then
		if(id==_idPlayer)then
		SetVarValue(_idChar_UAN_Entrepot_00_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_force_attak"))
			_bOnEnter_Sector_Event_securit_not_triche=1
		end
	end
end
-----------------------------------------------------------------------
--defreeeze ennemis
function OnEnter_Sector_Event_Sortie_explo_ok(id)

_idDoor_62=GetDoorID("Door_62")
_idDoor_63=GetDoorID("Door_63")

	if (_bOnEnter_Sector_Event_Sortie_explo_ok==0)then
		if(GetLocalCharacterID("Player")==id)and(_b_yet_OnStay_Sector_Event_Catch_explosives==true)then
			Freeze(_idChar_UAN_Renforts_warehouse_02_1,false)
			Freeze(_idChar_UAN_Renforts_warehouse_02_3,false)
			UnLockDoor(_idDoor_62)
			UnLockDoor(_idDoor_63)
			FreezeAll(_idGroup_UAN_Warehouse_01,false)
		_bOnEnter_Sector_Event_Sortie_explo_ok=1
		end
	end
end
---------------------------------------------------
---------------------------------------------------
--defreeeze ennemis
function OnEnter_Sector_Event_Escalier_entrepot(id)
	if(_bOnEnter_Sector_Event_Escalier_entrepot==0) then
		if (GetLocalCharacterID("Player")==id) then
			Freeze(_idChar_UAN_Entrepot_00_4,false)
			Freeze(_idChar_UAN_Entrepot_00_5,false)		
			Freeze(_idChar_UAN_Entrepot_00_7,false)
			--Freeze(_idChar_UAN_Entrepot_00_10,false)
			Freeze(_idChar_UAN_Entrepot_00_13,false)
			--Freeze(_idChar_UAN_Entrepot_00_6,false)
			_bIs_in=true
			_bOnEnter_Sector_Event_Escalier_entrepot=1	
			else _bIs_in=false
		end
	end
end
------------------------------------------------------------------
--defreeeze ennemis
function OnEnter_Sector_Event_1_FLOOR(id)

_idObj_A_1=GetObjectiveID("Obj_A_1")

	if(_bOnEnter_Sector_Event_1_FLOOR==0)then
		if(GetLocalCharacterID("Player")==id) then
			Freeze(_idChar_UAN_Entrepot_00_14,false)
			NewSubObjective("Obj_A_1", "Obj_A_2")
			MiniMapTrack(_idObj_A_1,2,false)
			_bOnEnter_Sector_Event_1_FLOOR=1
		end
	end
end
-------------------------------------------------
-- defreeeze ennemis
function Entrpot()

_bAlive_idChar_UAN_Entrepot_00_14=IsAlive(_idChar_UAN_Entrepot_00_14)
	if(_bEntrpot==0) then
		if(_bAlive_idChar_UAN_Entrepot_00_14==false)then
			Freeze(_idChar_UAN_Entrepot_00_15,false)
			--Freeze(_idChar_UAN_Entrepot_00_16,false)
		elseif (_bIs_in==true)then 
			Freeze(_idChar_UAN_Entrepot_00_15,false)
			--Freeze(_idChar_UAN_Entrepot_00_16,false)
		_bEntrpot=1
		end
	end
end
---------------------------------------------------------------
--defreeeze ennemis
function OnEnter_Sector_Event_Warehouse_middle(id)
	if (_bOnEnter_Sector_Event_Warehouse_middle==0)then
		if(GetLocalCharacterID("Player")==id)then
		Freeze(_idChar_UAN_Entrepot_00_1,false)
		Freeze(_idChar_UAN_Entrepot_00_2,false)
		Freeze(_idChar_UAN_Entrepot_00_11,false)
		Freeze(_idChar_UAN_Entrepot_00_12,false)
		--Freeze(_idChar_UAN_Palissade_00_1,false)
		_bOnEnter_Sector_Event_Warehouse_middle=1
		end
	end
end
---------------------------------------------------------------------
--defreeeze ennemis
function OnEnter_Sector_Event_Peloton(id)


	if(_bOnEnter_Sector_Event_Peloton==0) then
		if (GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_UAN_Peloton_00_1,false)
			Freeze(_idChar_UAN_Peloton_00_2,false)
			RadioMessage("DIA_SPE_NIV_G_GENERAL_RADIO_02",true,100,0.0,"")
			_bOnEnter_Sector_Event_Peloton=1
		end
	end
end
------------------------------------------------------------------------
--defreeeze ennemis
function OnEnter_Sector_Event_cour_warehouse(id)
	if(_bOnEnter_Sector_Event_cour_warehouse==0) then
		if (GetLocalCharacterID("Player")==id) then
			Freeze(_idChar_UAN_Entrepot_00_4,false)
			Freeze(_idChar_UAN_Entrepot_00_5,false)		
			Freeze(_idChar_UAN_Entrepot_00_7,false)
			--Freeze(_idChar_UAN_Entrepot_00_10,false)
		_bOnEnter_Sector_Event_cour_warehouse=1	
		end
	end
end
------------------------------------------------------------------------

--------------------------------------------------------------------------------
--FIN DU NIVEAU
function OnEnter_Sector_Event_endoflevel(id)
	if(_bOnEnter_Sector_Event_endoflevel==0)then
		

		if(GetLocalCharacterID("Player")==id)then
			EndOfLevel()
			_bOnEnter_Sector_Event_endoflevel=1
		end
	end
end
-----------------------------------------------------------------------------------
--defreeeze ennemis
function OnEnter_Sector_Event_pass(id)

	if(_bOnEnter_Sector_Event_pass==0)then
		if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_UAN_Entrepot_00_8,false)
			Freeze(_idChar_UAN_Entrepot_00_9,false)
			_bOnEnter_Sector_Event_pass=1
		end
	end
end
---------------------------------------------------------------------------------------------

