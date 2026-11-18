function UpdateLevel_OUTSIDE()
end
----------------------------------
----------------------------------
function OnEnter_Sector_Event_OUTSIDE_1(id)

	if(_bOnEnter_Sector_Event_OUTSIDE_1==0)then
		if(id == GetLocalCharacterID("Player"))then
			FreezeAll(_idGroup_ENTRANCE_02,false)
		_bOnEnter_Sector_Event_OUTSIDE_1=1
		end
	end
end
------------------------------------
function OnExit_Sector_Event_OUTSIDE_1(id)

	if(_bOnExit_Sector_Event_OUTSIDE_1==0)then
		if(id == GetLocalCharacterID("Player"))then

			_bOnExit_Sector_Event_OUTSIDE_1=1
		end
	end
end
----------------------------------
function OnEnter_Sector_Event_TUNNEL_TANK(id)


	if(_bOnEnter_Sector_Event_TUNNEL_TANK==0)then
		if(id == GetLocalCharacterID("Player"))then
			TankTargetEntity(_idTank_2,_idPlayer)
			_bOnEnter_Sector_Event_TUNNEL_TANK=1
		end
	end
end
-----------------------------------
function Remplacements()

_bAlive_idChar_UAN_ENTRANCE_01_1=IsAlive(_idChar_UAN_ENTRANCE_01_1)
_bAlive_idChar_UAN_ENTRANCE_01_2=IsAlive(_idChar_UAN_ENTRANCE_01_2)
_bAlive_idChar_UAN_ENTRANCE_01_3=IsAlive(_idChar_UAN_ENTRANCE_01_3)
_bAlive_idChar_UAN_ENTRANCE_01_4=IsAlive(_idChar_UAN_ENTRANCE_01_4)

		if((_bAlive_idChar_UAN_ENTRANCE_01_1==false)and(_bAlive_idChar_UAN_ENTRANCE_01_3==false))then
				Freeze(_idChar_UAN_HOUSE_02_1,false)
				Freeze(_idChar_UAN_HOUSE_02_2,false)
		end
			if(_bAlive_idChar_UAN_ENTRANCE_01_2==false)and(_bAlive_idChar_UAN_ENTRANCE_01_4==false) then
				Freeze(_idChar_UAN_HOUSE_02_3,false)
				Freeze(_idChar_UAN_HOUSE_02_4,false)
			end
	
end
------------------------------------------------
function OnEnter_Sector_Event_MIRADOR(id)

	if(_bOnEnter_Sector_Event_MIRADOR==0)then
		if(id == GetLocalCharacterID("Player"))then
			FreezeAll(_idGroup_HOUSE_00,false)
			--FreezeAll(_idGroup_HOUSE_05,false)
			_bOnEnter_Sector_Event_MIRADOR=1
		end
	end
end
-------------------------------------------------------
function OnEnter_Sector_Event_USINE(id)
	
	if(_bOnEnter_Sector_Event_USINE==0)then
		if(id == GetLocalCharacterID("Player"))then
			Freeze(_idChar_UAN_SCENE_00_1,true)
			Freeze(_idChar_UAN_SCENE_00_2,true)
			Freeze(_idChar_UAN_SCENE_00_3,true)
			Freeze(_idChar_UAN_SCENE_00_4,true)
			Freeze(_idChar_UAN_SCENE_00_5,true)
			Freeze(_idChar_UAN_SCENE_00_6,true)
		_bOnEnter_Sector_Event_USINE=1
		_bOnExit_Sector_Event_USINE=0
		end
	end
end
------------------------------------------------
function OnExit_Sector_Event_USINE(id)
	
	if(_bOnExit_Sector_Event_USINE==0)then
		if(id == GetLocalCharacterID("Player"))then
			Freeze(_idChar_UAN_SCENE_00_1,false)
			Freeze(_idChar_UAN_SCENE_00_2,false)
		--	Freeze(_idChar_UAN_SCENE_00_3,false)
		--	Freeze(_idChar_UAN_SCENE_00_4,false)
			Freeze(_idChar_UAN_SCENE_00_5,false)
			Freeze(_idChar_UAN_SCENE_00_6,false)
		_bOnEnter_Sector_Event_USINE=0
		_bOnExit_Sector_Event_USINE=1
		end
	end
end
-------------------------------------------------
function OnEnter_Sector_Event_OUTSIDE_2(id)

	if(_bOnEnter_Sector_Event_OUTSIDE_2==0)then
		if(id == GetLocalCharacterID("Player"))then
			--FreezeAll(_idGroup_HOUSE_01,false)
			SetVarValue(_idChar_UAN_TUNNEL_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_tunnel_poste_2"))
			SetVarValue(_idChar_UAN_TUNNEL_01_5,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_tunnel_poste_1"))
			SetVarValue(_idChar_UAN_TUNNEL_01_6,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_tunnel_poste_3"))
			--SetVarValue(_idChar_UAN_HOUSE_01_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_FORCE_ATTAK_PLAYER"))
			--SetVarValue(_idChar_UAN_HOUSE_01_4,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_FORCE_ATTAK_PLAYER"))
			SetVarValue(_idChar_UAN_HOUSE_02_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_FORCE_ATTAK_PLAYER"))
			SetVarValue(_idChar_UAN_HOUSE_02_4,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_FORCE_ATTAK_PLAYER"))
		--	FreezeAll(_idGroup_ROCHER_01,false)
			Freeze(_idChar_UAN_TANK_01_3,false)	
			_bOnEnter_Sector_Event_OUTSIDE_2=1
		end
	end
end
-----------------------------------------------
function OnExit_Sector_Event_HOUSE_1(id)

	if(_bOnExit_Sector_Event_HOUSE_1==0)then
		if(id == GetLocalCharacterID("Player"))then
			Freeze(_idChar_UAN_PLAINE_01_1,false)
			Freeze(_idChar_UAN_PLAINE_01_2,false)
		_bOnExit_Sector_Event_HOUSE_1=1
		end
	end
end
---------------------------------------------
function OnEnter_Sector_Event_TANK(id)

_idCamTransition_Tank=GetCamTransitionID("CamTransition_Tank")

	if(_bOnEnter_Sector_Event_TANK==0)then
		if(id == GetLocalCharacterID("Player"))then
			--FreezeAll(_idGroup_TANK_1,false)
			--FreezeAll(_idGroup_HOUSE_05,false)
			NewObjectiveNewSubObjective("Obj_A","Obj_A_1")
			LaunchCameraTransition(_idCamTransition_Tank)
		ShowCinematicBlackStripes(true)
			SetGodMode(_idPlayer,true)
			TankTargetEntity(_idTank_1,_idPlayer) 
			
			_bOnEnter_Sector_Event_TANK=1
		end
	end
end
------------------------------------------------
function OnExit_Sector_Event_TANK(id)
	
	if(_bOnExit_Sector_Event_TANK==0)then
		if(id == GetLocalCharacterID("Player"))then
			FreezeAll(_idGroup_ENTRANCE_03,false)
			_bOnExit_Sector_Event_TANK=1
		end
	end
end
----------------------------------------------
function Cam_tank_fix()

_idCamTransition_Tank1=GetCamTransitionID("CamTransition_Tank1")

LaunchCameraTransition(_idCamTransition_Tank1)

end
------------------------------------
function EndCam_tank()

	SetGodMode(_idPlayer,false)
	ShowCinematicBlackStripes(false)
end
-------------------------------------------
function OnEnter_Sector_Event_LIMIT_ZONE_EXO_UAN(id)
 
	if(_bOnEnter_Sector_Event_LIMIT_ZONE_EXO_UAN==0)then
		if(id == GetLocalCharacterID("Player"))then
			FreezeAll(_idGroup_PLATEFORME_1,false)
			Freeze(_idChar_UAN_WAREHOUSE_00_1,false)
			--Freeze(_idChar_UAN_WAREHOUSE_00_5,false)
			Freeze(_idChar_UAN_WAREHOUSE_00_6,false)
			Freeze(_idChar_UAN_WAREHOUSE_00_7,false)	
			Freeze(_idChar_UAN_WAREHOUSE_00_8,false)
			Freeze(_idChar_UAN_WAREHOUSE_00_9,false)
			_bOnEnter_Sector_Event_LIMIT_ZONE_EXO_UAN=1
		end
	end
end
-------------------------------------------
function VieTank()

_idObj_A_1=GetObjectiveID("Obj_A_1")
	if(_bVieTank==0)then
		if(_nLife_Tank_1==0)then
		ObjectiveDoneNewObjectiveNewSubObjective("Obj_A","Obj_B","Obj_B_1")
		MiniMapTrack(_idObj_A_1,2,false)
		StopMusic()
		_bVieTank=1
		end
	end
end

----------------------------------------------------
function Exo_Destroyed()


	if(_bExo_Destroyed==0)then	
		if(_nLife_Exo==0)and(_nLife_Tank_1>=1)then
		MissionFailed ("HUD_MISSION_FAILED_REASON_04")
		_bExo_Destroyed=1
		end
	end
end

-------------------------------------------
function Renforts_Rochers()

_bAlive_idGroup_ROCHER_01=IsAlive(_idGroup_ROCHER_01)

			if(_bAlive_idGroup_ROCHER_01==false)or((_bOnEnter_Sector_Event_TANK==1)and(_nBotsActifs<=7))then
				FreezeAll(_idGroup_ROCHER_02,false)	
			end
end
-------------------------------------------
function Rochers_3()

	if(_bRochers_3==0)then
		if(_bAlive_idGroup_ROCHER_01==false)and(_bAlive_idGroup_ROCHER_02==false)then
				FreezeAll(_idGroup_ROCHER_03,false)	
			end
	end
end
---------------------------------------------
function OnEnter_Sector_Event_CAMION(id)

	if(_bOnEnter_Sector_Event_CAMION==0)then
		if(id == GetLocalCharacterID("Player"))then
			FreezeAll(_idGroup_CAMION,false)
			_bOnEnter_Sector_Event_CAMION=1
		end
	end
end
-----------------------------------------------

----------------------------------------
function OnEnter_Sector_Event_RAMPE(id)

_bFreeze_idGroup_CAMION=AreAllFrozen(_idGroup_CAMION)

	if(_bOnEnter_Sector_Event_RAMPE==0)then
		if(id == GetLocalCharacterID("Player"))and(_bFreeze_idGroup_CAMION==true)then

			Freeze(_idChar_UAN_CAMION_01_5,true)
			Freeze(_idChar_UAN_CAMION_01_6,true)
			FreezeAll(_idGroup_CAMION,true)
			SetVarValue(_idChar_UAN_CAMION_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_follow_UAN"))
			SetVarValue(_idChar_UAN_CAMION_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_follow_UAN"))
			SetVarValue(_idChar_UAN_CAMION_01_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_follow_UAN"))
			SetVarValue(_idChar_UAN_CAMION_01_4,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_follow_UAN"))
		_bOnEnter_Sector_Event_RAMPE=1
		end
	end
end
-------------------------------------------

-------------------------------------------
function OnEnter_Sector_Event_RAMPE_B(id)


	if(_bOnEnter_Sector_Event_RAMPE_B==0)then
		if(id == GetLocalCharacterID("Player"))then
			Freeze(_idChar_UAN_WAREHOUSE_00_2,false)
			Freeze(_idChar_UAN_WAREHOUSE_00_3,false)
			Freeze(_idChar_UAN_WAREHOUSE_00_4,false)
			_bOnEnter_Sector_Event_RAMPE_B=1
		end
	end
end
---------------------------------------------
function OnEnter_Sector_Event_WAREHOUSE(id)


	if(_bOnEnter_Sector_Event_WAREHOUSE==0)then
		if(id == GetLocalCharacterID("Player"))then
			Freeze(_idChar_UAN_WAREHOUSE_00_5,false)
			SetVarValue(_idChar_UAN_WAREHOUSE_00_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_WAREHOUSE_3"))
			_bOnEnter_Sector_Event_WAREHOUSE=1
		end
	end
end
----------------------------------------------
function OnEnter_Sector_Event_CHAUDIERE_WAREHOUSE(id)
_bAliveChar_UAN_TANK_01_1=IsAlive(_idChar_UAN_TANK_01_1)

	if(_bOnEnter_Sector_Event_CHAUDIERE_WAREHOUSE==0)then
		if(id == GetLocalCharacterID("Player"))then
			SetVarValue(_idChar_UAN_WAREHOUSE_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_WAREHOUSE_7"))
			SetVarValue(_idChar_UAN_WAREHOUSE_00_6,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_WAREHOUSE_8"))
			if(_bAliveChar_UAN_TANK_01_1==true)then 
			SetVarValue(_idChar_UAN_TANK_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_WAREHOUSE_3"))
			end
		_bOnEnter_Sector_Event_CHAUDIERE_WAREHOUSE=1
		end
	end
end
------------------------------------------
function OnEnter_Sector_Event_ISinDANGER(id)

	if(_bOnEnter_Sector_Event_ISinDANGER==0)then
		if(id == GetLocalCharacterID("Player"))and not(_byetOnEnter_Sector_Event_ISinDANGER)then
			Freeze(_idChar_UAN_SCENE_00_1,false)
			Freeze(_idChar_UAN_SCENE_00_2,false)
			Freeze(_idChar_UAN_SCENE_00_3,false)
			Freeze(_idChar_UAN_SCENE_00_4,false)
			Freeze(_idChar_UAN_SCENE_00_5,false)
			Freeze(_idChar_UAN_SCENE_00_6,false)
				_byetOnEnter_Sector_Event_ISinDANGER=true

			if (_byetOnEnter_Sector_Event_ISinDANGER==true)and ((IsCharacterInDanger(_idChar_UAN_SCENE_00_1)==true)or
				(IsCharacterInDanger(_idChar_UAN_SCENE_00_2)==true)or
				(IsCharacterInDanger(_idChar_UAN_SCENE_00_3)==true)or
				(IsCharacterInDanger(_idChar_UAN_SCENE_00_4)==true)or
				(IsCharacterInDanger(_idChar_UAN_SCENE_00_5)==true)or
				(IsCharacterInDanger(_idChar_UAN_SCENE_00_6)==true))then	
				SetVarValue(_idChar_UAN_SCENE_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_BARAQUES_6"))				
				SetVarValue(_idChar_UAN_SCENE_00_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_BARAQUES_5"))	
				SetVarValue(_idChar_UAN_SCENE_00_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_BARAQUES_2"))	
				SetVarValue(_idChar_UAN_SCENE_00_4,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_BARAQUES_1"))	
				SetVarValue(_idChar_UAN_SCENE_00_5,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_BARAQUES_4"))	
				SetVarValue(_idChar_UAN_SCENE_00_6,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_BARAQUES_3"))
			_bOnEnter_Sector_Event_ISinDANGER=1
			end
		end
	end
end
------------------------------------------------------
function OnEnter_Sector_Event_MONTEE(id)

	if(_bOnEnter_Sector_Event_MONTEE==0)then
		if(id == GetLocalCharacterID("Player"))then
			--Freeze(_idChar_UAN_SCENE_00_9,false)
			--Freeze(_idChar_UAN_SCENE_00_13,false)
			--Freeze(_idChar_UAN_SCENE_00_15,false)
			--Freeze(_idChar_UAN_SCENE_00_17,false)
			Freeze(_idChar_UAN_TECHROOM_00_4,false)
		--	SetVarValue(_idChar_UAN_SCENE_00_9,"Position",Vector3D(158.029770,-63.809143,214.064194))
		--	SetVarValue(_idChar_UAN_SCENE_00_13,"Position",Vector3D(261.747742,-95.008369,213.740417))
			SetVarValue(_idChar_UAN_PLATEFORME_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_PLATEFORME_10"))
		--	SetVarValue(_idChar_UAN_SCENE_00_13,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_combatplateforme"))
		_bOnEnter_Sector_Event_MONTEE=1
		end
	end
end
------------------------------------------
-----------------------------------------
function TeleportBoss()

	if(_bTeleportBoss==0)then
		if(_idChampion_0==_idChar_Champion_0_1)or(_idChampion_0==_idChar_Champion_0_2)then
			Freeze(_idChampion_0,false)
			Teletransportation("Character_teleport_boss",_idChampion_0)
			SetVarValue(_idChampion_0,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_SCENE_03"))		
			_bTeleportBoss=1		
		end
	end
end
-----------------------------------------
function TeleportBoss_Third()

	if(_bTeleportBoss_Third==0)then
		if(_idChampion_0==_idChar_Champion_0_3)then
			Freeze(_idChampion_0,false)
			Teletransportation("Char_REPERE3",_idChampion_0)
			CharacterPlaySpecialAction(_idChampion_0,"STAND COMPLETE WAIT W_NONE COOL",true,false)
			_bTeleportBoss_Third=1
		end
	end
end

---------------------------------------------
function Cam_PreBOSS()

_idCamTransition_PREBOSS=GetCamTransitionID("CamTransition_PREBOSS")	

	if(_bCam_PreBOSS==0)then
		if(_idChampion_0==_idChar_Champion_0_1)or(_idChampion_0==_idChar_Champion_0_2)then
		LaunchCameraTransition(_idCamTransition_PREBOSS)
		SetGodMode(_idPlayer,true)
		TeleportBoss()
		end

	_bCam_PreBOSS=1
	end
end
-------------------------------------
function Cam_PreBOSS_1()

_idCamTransition_PREBOSS_3=GetCamTransitionID("CamTransition_PREBOSS_3")	

		if(_idChampion_0==_idChar_Champion_0_3)then
				LaunchCameraTransition(_idCamTransition_PREBOSS_3)
				SetGodMode(_idPlayer,true)
				TeleportBoss_Third()
		end
end
------------
function Cam_PreBOSS_1_1()

_idCamTransition_PREBOSS_4=GetCamTransitionID("CamTransition_PREBOSS_4")	

		if(_idChampion_0==_idChar_Champion_0_3)then
				LaunchCameraTransition(_idCamTransition_PREBOSS_4)
				SetGodMode(_idPlayer,true)
				TeleportBoss_Third()
		end
end

----------
-------------
function EnCAM_Preboss()

		SetGodMode(_idPlayer,false)
			if(_idChampion_0==_idChar_Champion_0_1)or(_idChampion_0==_idChar_Champion_0_2)then
			Teletransportation("Char_REPERE1",_idChampion_0)
			Freeze(_idChampion_0,true)
			end

			if(_idChampion_0==_idChar_Champion_0_3)then
			Teletransportation("Char_REPERE2",_idChampion_0)
			CharacterStopSpecialAction(_idChampion_0)
			Freeze(_idChampion_0,true)
			end
end
--------------------------------------------
function OnEnter_Sector_Event_PLATEFORME_1(id)


	if(_bOnEnter_Sector_Event_PLATEFORME_1==0)then
		if(id == GetLocalCharacterID("Player"))then
			Freeze(_idChar_UAN_BARAQUES_01_1,false)
			Freeze(_idChar_UAN_BARAQUES_01_2,false)
			Freeze(_idChar_UAN_BARAQUES_01_3,false)
			Freeze(_idChar_UAN_BARAQUES_01_4,false)
			NewSubObjective("Obj_B_1","Obj_B_2")
			
			
			----------------------------------------------------
			--Creation d'un timer qui lance le PLAN où on teleporte le boss
				if(_idChampion_0==_idChar_Champion_0_3)then
					CreationTimer(true,true,false,"Cam_PreBOSS_1",4.0)
				end
				if(_idChampion_0==_idChar_Champion_0_1)or(_idChampion_0==_idChar_Champion_0_2)then
					CreationTimer(true,true,false,"Cam_PreBOSS",4.0)
				end
			---------------------------------------------------
		--	SetVarValue(_idMerc[0],"Position",Vector3D(216.814667,6.796833,213.898758))
		--	if(_idMerc[1]~=nil) then
		--		SetVarValue(_idMerc[1],"Position",Vector3D(216.814667,26.350025,213.898758))
		--	end			

				if(id==GetLocalCharacterID("Player"))and(_byetOnExit_Sector_Event_PLATEFORME_1==true)then
				--	Freeze(_idChar_UAN_SCENE_00_13,false)
				--	Freeze(_idChar_UAN_SCENE_00_15,false)
				--	Freeze(_idChar_UAN_SCENE_00_17,false)
				end
			_bOnEnter_Sector_Event_PLATEFORME_1=1
		end
	end
end
---------------------------------------------------
function OnExit_Sector_Event_PLATEFORME_1(id)

	if(id == GetLocalCharacterID("Player"))then
		if (_byetOnExit_Sector_Event_PLATEFORME_1 == false)then
			Freeze(_idChar_UAN_SCENE_00_9,true)
			Freeze(_idChar_UAN_SCENE_00_13,true)
			Freeze(_idChar_UAN_SCENE_00_15,true)
			Freeze(_idChar_UAN_SCENE_00_17,true)
			Freeze(_idChar_UAN_BARAQUES_03_3,false)
			Freeze(_idChar_UAN_TECHROOM_00_1,false)
			SetVarValue(_idSound_Client_helico,"Playing",true)
			_byetOnExit_Sector_Event_PLATEFORME_1=true
		end
	end
end
---------------------------------------------------
function Renforts_Baraques_1()

_bAliveChar_UAN_BARAQUES_01_1=IsAlive(_idChar_UAN_BARAQUES_01_1)
_bAliveChar_UAN_BARAQUES_01_2=IsAlive(_idChar_UAN_BARAQUES_01_2)
_bAliveChar_UAN_BARAQUES_01_3=IsAlive(_idChar_UAN_BARAQUES_01_3)
_bAliveChar_UAN_BARAQUES_01_4=IsAlive(_idChar_UAN_BARAQUES_01_4)

	if(_bRenforts_Baraques_1==0)then
		if(_bAliveChar_UAN_BARAQUES_01_1==false)and
			(_bAliveChar_UAN_BARAQUES_01_2==false)and																		
			(_bAliveChar_UAN_BARAQUES_01_3==false)and
			(_bAliveChar_UAN_BARAQUES_01_4==false)then

			_bGroupBaraques_1_Mort=true

			Freeze(_idChar_UAN_BARAQUES_02_1,false)
			Freeze(_idChar_UAN_BARAQUES_02_2,false)
			Freeze(_idChar_UAN_BARAQUES_02_3,false)
			Freeze(_idChar_UAN_BARAQUES_02_4,false)		
		_bRenforts_Baraques_1=1
		end
	end
end
----------------------------------------------------
function OnEnter_Sector_Event_SECURE_SPAWN_BARAK_2(id)


	if(_bOnEnter_Sector_Event_SECURE_SPAWN_BARAK_2==0)then
		if(id == GetLocalCharacterID("Player"))then
			Freeze(_idChar_UAN_BARAQUES_02_1,false)
			Freeze(_idChar_UAN_BARAQUES_02_2,false)
			Freeze(_idChar_UAN_BARAQUES_02_3,false)
			Freeze(_idChar_UAN_BARAQUES_02_4,false)
			Freeze(_idChar_UAN_TECHROOM_00_3,true)
			_bOnEnter_Sector_Event_SECURE_SPAWN_BARAK_2=1
		end
	end
end
----------------------------------------------------
function Renforts_Baraques_2()

_bAliveChar_UAN_BARAQUES_02_1=IsAlive(_idChar_UAN_BARAQUES_02_1)
_bAliveChar_UAN_BARAQUES_02_2=IsAlive(_idChar_UAN_BARAQUES_02_2)
_bAliveChar_UAN_BARAQUES_02_3=IsAlive(_idChar_UAN_BARAQUES_02_3)
_bAliveChar_UAN_BARAQUES_02_4=IsAlive(_idChar_UAN_BARAQUES_02_4)

	if(_bRenforts_Baraques_2==0)then
		if(_bAliveChar_UAN_BARAQUES_02_1==false)and
			(_bAliveChar_UAN_BARAQUES_02_2==false)and																		
			(_bAliveChar_UAN_BARAQUES_02_3==false)and
			(_bAliveChar_UAN_BARAQUES_02_4==false)then
			
			_bGroupBaraques_2_Mort=true
			Freeze(_idChar_UAN_BARAQUES_03_1,false)
			Freeze(_idChar_UAN_BARAQUES_03_2,false)
			_bRenforts_Baraques_2=1
		end
	end
end
--------------------------------------------------
function Renforts_Baraques_3()

_bAliveChar_UAN_BARAQUES_03_1=IsAlive(_idChar_UAN_BARAQUES_03_1)
_bAliveChar_UAN_BARAQUES_03_2=IsAlive(_idChar_UAN_BARAQUES_03_2)
_bAliveChar_UAN_BARAQUES_03_3=IsAlive(_idChar_UAN_BARAQUES_03_3)

	if(_bRenforts_Baraques_3==0)then
		if(_bAliveChar_UAN_BARAQUES_03_1==false)or
			(_bAliveChar_UAN_BARAQUES_03_2==false)or																		
			(_bAliveChar_UAN_BARAQUES_03_3==false)then
			_bGroupBaraques_3_Mort=true
		_bRenforts_Baraques_3=1
		end
	end
end
----------------------------------------------------
function OBJ_CLEAN_AREA()

		if(_bOBJ_CLEAN_AREA==0)then
			if((_bGroupBaraques_1_Mort==true)and(_bGroupBaraques_2_Mort==true)and
				(_bAliveChar_UAN_BARAQUES_03_1==false)and
				(_bAliveChar_UAN_BARAQUES_03_2==false)and																		
				(_bAliveChar_UAN_BARAQUES_03_3==false))then
				NewSubObjective ("Obj_B_2","Obj_B_3")
				_bOBJ_CLEAN_AREA=1
		end	
	end
end
----------------------------------------------------
function OnEnter_Sector_Event_Plateforme_inge(id)

	if(_bOnEnter_Sector_Event_Plateforme_inge==0)then
		if(id == GetLocalCharacterID("Player"))then
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_PLATEFORME_11"))
			RadioMessage("DIA_SPE_NIV_H_INGENIEUR_24",true,100,0.0,"")
			Freeze(_idChar_UAN_TECHROOM_00_3,false)
			_bOnEnter_Sector_Event_Plateforme_inge=1
		end
	end
end
------------------------------------------------------
function OnEnter_Sector_Event_DOWNSTAIRS(id)

	if(_bOnEnter_Sector_Event_DOWNSTAIRS==0)then
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
			(_bAliveChar_UAN_BARAQUES_03_3==true))then
			
			_bOnEnter_Sector_Event_DOWNSTAIRS=1
		end
	end
end
--------------------------------------------------------------------
function OnExit_Sector_Event_DOWNSTAIRS(id)

	if(_bOnExit_Sector_Event_DOWNSTAIRS==0)then
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
			(_bAliveChar_UAN_BARAQUES_03_3==true))and(_bBetLancer~=true)then

			Freeze(_idChar_UAN_GALERIE_00_1,false)	
			Freeze(_idChar_UAN_GALERIE_00_2,false)
			Freeze(_idChar_UAN_GALERIE_00_3,false)
			Freeze(_idChar_UAN_GALERIE_00_4,false)
			RadioMessage("DIA_SPE_NIV_H_INGENIEUR_26",true,100,0.0,"")
			_bOnExit_Sector_Event_DOWNSTAIRS=1
		end
	end
end
--------------------------------------------------------------------
function OnEnter_Sector_Event_SUITE_BOSS(id)

	if(_bOnEnter_Sector_Event_SUITE_BOSS==0)then
		if((id == GetLocalCharacterID("Player"))and(_bMort_Boss==1))then
			Freeze(_idChar_UAN_TECHROOM_00_5,false)
			Freeze(_idChar_UAN_TECHROOM_00_6,false)
			Freeze(_idChar_UAN_TECHROOM_00_9,false)
			Freeze(_idChar_UAN_TECHROOM_00_10,false)
			Freeze(_idChar_UAN_TECHROOM_00_11,false)
			Freeze(_idChar_UAN_TECHROOM_00_1,false)
			--RadioMessage("DIA_SPE_NIV_H_INGENIEUR_26",true,100,0.0,"")
			SetVarValue(_idChar_UAN_TECHROOM_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_BALCON"))
			_bOnEnter_Sector_Event_SUITE_BOSS=1
		end
	end
end
------------------------------------------------------------------
function EXO_2_COME()

	if(_bEXO_2_COME==0)then
		if((_bMort_Boss==1)or(_bOnEnter_Sector_Event_SUITE_BOSS==1))then
			Freeze(_idChar_UAN_TECHROOM_00_4,false)
			_bEXO_2_COME=1
		end
	end
end
-----------------------------------------------------------------------
function OnEnter_Sector_Event_PLAINE_FIN(id)

	if(_bOnEnter_Sector_Event_PLAINE_FIN==0)then
		if(id == GetLocalCharacterID("Player"))then
			Freeze(_idChar_UAN_TECHROOM_00_2,false)
			_bOnEnter_Sector_Event_PLAINE_FIN=1
		end
	end
end
---------------------------------------------------------------------
function Door_TECHROOM()

_idDoor_TECHROOM=GetDoorID("Door_TECHROOM")

	if(_bDoor_TECHROOM==0)then
		if IsDoorOpened(_idDoor_TECHROOM)then
			Freeze(_idChar_UAN_TECHROOM_00_8,false)
			_bDoor_TECHROOM=1
		end
	end
end
---------------------------------------------
function OnEnter_Sector_Event_ENTREE_TECHROOM(id)

	if(_bOnEnter_Sector_Event_ENTREE_TECHROOM==0)then
		if(id == GetLocalCharacterID("Player")and(_bCombat==true))then
			NewSubObjective("Obj_B_3","Obj_B_4")
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_HACK"))
			_bOnEnter_Sector_Event_ENTREE_TECHROOM=1
		end
	end
end
-----------------------------------------------------------------------
function OnEnter_Sector_Event_COMMAND_TECHROOM(id)

--_idSound_Client_509=GetSound_ClientID("Sound_Client_509")
_idTimer_Command=GetTimerID("Timer_Command")

	if(_bOnEnter_Sector_Event_COMMAND_TECHROOM==0)then
		if(id == _idMerc[0])then
			RadioMessage("DIA_SPE_NIV_E_INGENIEUR_26",true,100,0.0,"")
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_HACK"))
			SetVarValue(_idTimer_Command,"Active",true)
			_bOnEnter_Sector_Event_COMMAND_TECHROOM=1
		end
	end
end
--------------------------------------------------------------------
function Joue_Son_Terminal()

			SetVarValue(_idSound_Client_509,"Playing",true)

end
---------------------------------------------------------------------
function Command_OK()
_idDynamic_Light_Client_26=GetDynamic_Light_ClientID("Dynamic_Light_Client_26")
_idDynamic_Light_Client_27=GetDynamic_Light_ClientID("Dynamic_Light_Client_27")
_idGlow_Client_127=GetGlow_ClientID("Glow_Client_127")
_idTimer_Win=GetTimerID("Timer_Win")
_idDoor_tunnel_A=GetDoorID("Door_tunnel_A")
_idDoor_tunnel_B=GetDoorID("Door_tunnel_B")

	if(_bCommand_OK==0)then
			SetVarValue(_idDynamic_Light_Client_26,"Color",Color(1,0,0))
			SetVarValue(_idDynamic_Light_Client_27,"Color",Color(1,0,0))
			SetVarValue(_idGlow_Client_127,"Color",Color(1,0,0))
			CloseDoor(_idDoor_tunnel_A)
			CloseDoor(_idDoor_tunnel_B)
			SetVarValue(_idTimer_Win,"Active",true)
		_bCommand_OK=1
	end
end
-----------------------------------------
function SUCCEED()

	if(_bSUCCEED==0)then
		
		MissionSucceed ()
		_bSUCCEED=1
	end
end
-------------------

---------------------------