function UpdateLevel_Objectives()
end
--------------------------------------
--=== VALIDATION DE L'OBJECTIF 1===--
----------------------------------------
function Objectif_Principal_1()



	if(_bObjectif_Principal_1==0)then
		if(_bObjective_ok_1_01==true)and(_bObjective_ok_1_02==true)and(_bObjective_ok_1_03==true)and(_bOnEnter_Sector_Event_SafePlace==1)then
	--	SetVarValue(_idObjective_Principal_1,"Completed",true)
		ObjectiveDoneNewObjectiveNewSubObjective ("Obj_A","Obj_B","Obj_B_1" )
		
		_bObjectif_Principal_1=1
		end
	end
end
---------------------------------------

----------------------------------------------
--------------------------------------
--=== VALIDATION Du SOUS OBJECTIF 1 ===--
------------------------------------------
function Objective_1_01()

_bStateofEngineer=GetMercenaryIsFollowing(_idMerc[0])		
_idObj_A_1=GetObjectiveID("Obj_A_1")

	if(_bObjective_1_01==0)then
		if(_nLife_Exo_UAN_1==0)then
		--	NewSubObjective ("Obj_A_1","Obj_A_2")
			--RadioMessage("DIA_SPE_NIV_H_INGENIEUR_27",true,100,0.0,"")
		--	Freeze(_idMerc[0],false)			
		--	SetVarValue(_idMerc[0],"CharacterOrderList",_idPasdeListe)
		--	_bStateofEngineer=1
		--	MiniMapTrack(_idObj_A_1,2,false)
			_bObjective_ok_1_01=true
			_bObjective_1_01=1
		end
	end
end
--------------------------------------
--=== VALIDATION Du SOUS OBJECTIF 2 ===--
------------------------------------------

--_bOnEnter_Sector_Event_bombing_zone=1
function Objective_1_02()
_idObj_A_2=GetObjectiveID("Obj_A_2")

	if(_bObjective_1_02==0)then
		if(_bOnEnter_Sector_Event_bombing_zone==1)then
		--	NewSubObjective ("Obj_A_2","Obj_A_3")
			MiniMapTrack(_idObj_A_2,2,false)
			_bObjective_ok_1_02=true
			_bObjective_1_02=1
		end
	end
end
--------------------------------------
--=== VALIDATION Du SOUS OBJECTIF 3 ===--
------------------------------------------
function Objective_1_03()

_idObj_A_3=GetObjectiveID("Obj_A_3")


	if(_bObjective_1_03==0)then
		if(_bOnEnter_Sector_Event_SafePlace==1)then
		--	SetVarValue(_idObjective_1_03,"Completed",true)
		--	ObjectiveDoneNewObjectiveNewSubObjective ( "Obj_A", "Obj_B", "Obj_B_1" )
			MiniMapTrack(_idObj_A_3,2,false)
			_bObjective_ok_1_03=true
			_bObjective_1_03=1
		end
	end
end
-----------------------------------------------------
--=== VALIDATION DE L'OBJECTIF 2===--
------------------------------------------------------
function Objectif_Principal_2()

	if(_bObjectif_Principal_2==0)then
		if(_bObjective_ok_2_01==true)and(_bObjective_ok_2_02==true)and(_bWin==1)then
		--SetVarValue(_idObjective_Principal_2,"Completed",true)
	--DisplayObjective("HUD_OBJ_DONE",_idObjective_Principal_2,1,5)
		EndOfLevel()
		_bObjectif_Principal_2=1
		end
	end
end
------------------------------------
function Objective_2_01()

_idObj_B_1=GetObjectiveID("Obj_B_1")

	if(_bObjective_2_01==0)then
		if(_byetOnEnter_Sector_Event_BOS==true)then
			--SetVarValue(_idObjective_2_01,"Completed",true)
			NewSubObjective ("Obj_B_1", "Obj_B_2")
			MiniMapTrack(_idObj_B_1,2,false)
			_bObjective_ok_2_01=true
			_bObjective_2_01=1
		end
	end
end
-------------------------------------
function Objective_2_02()

	if(_bObjective_2_02==0)then
		if(_bWin==1)then
			--SetVarValue(_idObjective_2_02,"Completed",true)
			--ObjectiveDoneNewObjectiveNewSubObjective ( "Obj_B", "Obj_B_1", "Obj_B_2" )
			_bObjective_ok_2_02=true
			_bObjective_2_02=1
		end
	end
end
-----------------------------------
function PRE_ENDofDEMO()


	if(_bPRE_ENDofDEMO==0)and(_bObj_Hack_ok==1)then
--		CreationTimer(true,true,false,"ENDofDEMO",3.0)		
		_bPRE_ENDofDEMO=1
	end
end
----------------------------------
function ENDofDEMO()

		Mission_End_Demo ()
end