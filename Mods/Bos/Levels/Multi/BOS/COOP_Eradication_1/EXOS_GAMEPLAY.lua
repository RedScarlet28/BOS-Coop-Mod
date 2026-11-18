function UpdateLevel_EXOS_GAMEPLAY()
end
------------------------------------------------------
function OnEnter_Sector_Event_HELIPORT(id)


		if(_bOnEnter_Sector_Event_HELIPORT==0)then
			if(id==_idPlayer)then
			FreezeAll(_idGroup_Galerie_01,false)
			FreezeAll(_idGroup_Galerie_02,false)
			
			_bOnEnter_Sector_Event_HELIPORT=1
		end
	end
end
------------------------------------------------------
function Exo_Colline_Recharge()

	if(_bObjectif_1==0)and(IsEntityInBox(_idChar_RES_ExoMan_00_2,"Sector_Event_use_exo"))and(_nLife_Exo_UAN_3<=2000)then
		SetVarValue(_idChar_RES_ExoMan_00_2,"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_use_pathway_recharge"))
		
	end
end
--------------------------------------------------------------
function OnEnter_Sector_Event_recharge(id)
	
	if(_bOnEnter_Sector_Event_recharge==0)then
	if(id==_idChar_RES_ExoMan_00_2)and(_bObjectif_1==0)then
		SetVarValue(_idExoskeleton_Hangar_3,"Health",5000)
		_bOnEnter_Sector_Event_recharge=1
	end
end
end
----------------------------------------------------------------
function EXO_Vs_PLAYER()

	if(_bEXO_Vs_PLAYER==0)then
		if(_nLife_Exo_UAN_3<=5000)then
			SetVarValue(_idChar_RES_ExoMan_00_2,"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_force_target"))
			_bEXO_Vs_PLAYER=1
		end
	end
end
--------------------------------------------------------------
-----------------------------------------
function MORT_EXO_3()


	if(_bMORT_EXO_3==0)then
		if((_nLife_Exo_UAN_3==0)or(_nLife_Exo_UAN_5==0))and(_bOnEnter_Sector_Event_Check_point==1)then
			NewSubObjective("Obj_B_1", "Obj_B_2")
			FreezeAll(_idGroup_Galerie_01,false)
			--FreezeAll(_idGroup_Galerie_02,false)
			_bMORT_EXO_3=1
		end
	end
end
-----------------------------------------
----------------------------------------
--ATTENTION : AU cas où plus tard tu veux mettre un exo dehors sur la plaine
--prevois de foutre en condition à la 2eme ligne, la variable qui annonce si j'étais dans le camp ou pas..
--(BIEN SUR >> au cas où l'exo de dehors est buté)

function MORT_EXO_5()

	if(_bMORT_EXO_5==0)then

		_nWPExo3 = GetVarValue(_idExoskeleton_Hangar_3,"Weakpoint Health")
		_nWPExo5 = GetVarValue(_idExoskeleton_Hangar_5,"Weakpoint Health")

		if((_nLife_Exo_UAN_3==0)and(_nLife_Exo_UAN_5==0))then
			ObjectiveDoneNewObjectiveNewSubObjective("Obj_B","Obj_C","Obj_C_1")
			MiniMapTrack(_idExoskeleton_Hangar_3,2,false)
			MiniMapTrack(_idExoskeleton_Hangar_5,2,false)
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_PRE_HACK"))
			RadioMessage("DIA_SPE_NIV_J_USWE_A_5",true,90,1,"")
			_bEnd=true
			_bMORT_EXO_5=1
		end

		if((_nLife_Exo_UAN_3==0)and(_nWPExo5 == 0))then
			ObjectiveDoneNewObjectiveNewSubObjective("Obj_B","Obj_C","Obj_C_1")
			MiniMapTrack(_idExoskeleton_Hangar_3,2,false)
			MiniMapTrack(_idExoskeleton_Hangar_5,2,false)
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_PRE_HACK"))
			RadioMessage("DIA_SPE_NIV_J_USWE_A_5",true,90,1,"")
			_bEnd=true
			_bMORT_EXO_5=1
		end

		if((_nLife_Exo_UAN_5==0)and(_nWPExo3 == 0))then
			ObjectiveDoneNewObjectiveNewSubObjective("Obj_B","Obj_C","Obj_C_1")
			MiniMapTrack(_idExoskeleton_Hangar_3,2,false)
			MiniMapTrack(_idExoskeleton_Hangar_5,2,false)
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_PRE_HACK"))
			RadioMessage("DIA_SPE_NIV_J_USWE_A_5",true,90,1,"")
			_bEnd=true
			_bMORT_EXO_5=1
		end

		if((_nWPExo5 == 0)and(_nWPExo3 == 0))then
			ObjectiveDoneNewObjectiveNewSubObjective("Obj_B","Obj_C","Obj_C_1")
			MiniMapTrack(_idExoskeleton_Hangar_3,2,false)
			MiniMapTrack(_idExoskeleton_Hangar_5,2,false)
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_PRE_HACK"))
			RadioMessage("DIA_SPE_NIV_J_USWE_A_5",true,90,1,"")
			_bEnd=true
			_bMORT_EXO_5=1
		end

		if ((_nWPExo3 == 0) and (_bCtrlWPExo3 == false)) then
			MiniMapTrack(_idExoskeleton_Hangar_3,2,false)
			_bCtrlWPExo3 = true
		end

		if ((_nWPExo5 == 0) and (_bCtrlWPExo5 == false)) then
			MiniMapTrack(_idExoskeleton_Hangar_5,2,false)
			_bCtrlWPExo5 = true
		end


	end
end
---------------
function Releve_Exo()

	if(_bReleve==0)then
		if(_nLife_Exo_UAN_3==0)then
			SetVarValue(_idChar_RES_ExoMan_00_1,"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_EXO_6b"))
			MiniMapTrack(_idExoskeleton_Hangar_3,2,false)
		_bReleve=1
		end
	end
end
----------------
function OnExit_Sector_Event_Hangar_exo(id)

	if(_bOnExit_Sector_Event_Hangar_exo==0)then
		if(id == _idPlayer)then
			FreezeAll(_idGroup_Galerie_01,false)
			_bOnExit_Sector_Event_Hangar_exo=1
		end
	end
end












































