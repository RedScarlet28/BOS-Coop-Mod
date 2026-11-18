function UpdateLevel_Building()
end
-----------------------
function OnEnter_Sector_Event_Gd_bat_lvl1_room2(id)
	if(_bOnEnter_Sector_Event_Gd_bat_lvl1_room2==0) then

		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Gd_bat_lvl1_room2)then
			Freeze(_idChar_UAN_GdBat_00_2,false)
			Freeze(_idChar_UAN_GdBat_00_6,false)
			SetVarValue(_idChar_UAN_GdBat_00_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_force_attk"))
			SetVarValue(_idChar_UAN_GdBat_00_6,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_force_attk"))
			--MakeCharacterSpeak(_idChar_UAN_GdBat_00_2,_idPlayer,"DIA_SPE_NIV_H_UAN_E_01",true,100,1,0.0,"",100.0)	
			_b_yetOnEnter_Sector_Event_Gd_bat_lvl1_room2=true
			_bOnEnter_Sector_Event_Gd_bat_lvl1_room2=1
		end
	end
end
---------------------------------------------------
function OnEnter_Sector_Event_Gd_bat_lvl1_room1(id)
	if(_bOnEnter_Sector_Event_Gd_bat_lvl1_room1==0) then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Gd_bat_lvl1_room1)then
			Freeze(_idChar_UAN_GdBat_00_2,false)
			SetVarValue(_idChar_UAN_GdBat_00_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_force_attk"))
			SetVarValue(_idChar_UAN_GdBat_00_6,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_force_attk"))
			_b_yetOnEnter_Sector_Event_Gd_bat_lvl1_room1=true
			_bOnEnter_Sector_Event_Gd_bat_lvl1_room1=1
		end
	end
end
---------------------------------------------------
function OnEnter_Sector_Event_Gd_bat_lvl1_stairs(id)
	if (_bOnEnter_Sector_Event_Gd_bat_lvl1_stairs==0)then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Gd_bat_lvl1_stairs)then
			Freeze(_idChar_UAN_GdBat_00_4,false)
			Freeze(_idChar_UAN_GdBat_00_5,false)
			MakeCharacterSpeak(_idChar_UAN_GdBat_00_5,_idPlayer,"DIA_SPE_NIV_H_UAN_D_01",true,100,1,0.0,"",100.0)	
			_b_yetOnEnter_Sector_Event_Gd_bat_lvl1_stairs=true
			_bOnEnter_Sector_Event_Gd_bat_lvl1_stairs=1

		end
	end
end
--------------------------------------------------
function OnEnter_Sector_Event_gd_bat_lvl1_couloir(id)
	if(_bOnEnter_Sector_Event_gd_bat_lvl1_couloir==0) then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_gd_bat_lvl1_couloir)then
			Freeze(_idChar_UAN_Gd_bat_room1_00_1,false)
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_6,false)
			Freeze(_idChar_UAN_Gd_bat_room1_00_2,false)
			--SetVarValue(_idChar_WRF_INGEN_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Goto_Waypoint_ingé3"))
			--MakeCharacterSpeak(_idChar_WRF_INGEN_00_1,"Je suis en position sur l'échaffaudage,faites vite Nolan !!",true,0)

			_b_yetOnEnter_Sector_Event_gd_bat_lvl1_couloir=true
			_bOnEnter_Sector_Event_gd_bat_lvl1_couloir=1
		end
	end
end
---------------------------------------------------
function OnEnter_Sector_Event_Gd_bat_lvl2_couloir(id)
	if (_bOnEnter_Sector_Event_Gd_bat_lvl2_couloir==0)then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Gd_bat_lvl2_couloir)then
			FreezeAll(_idGroup_UAN_Gd_bat_lvl2_room1_01,false)
			SetVarValue(_idChar_UAN_Gd_bat_lvl2_room1_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Char_UAN_Gd_bat_lvl2_room1_01_1"))
			SetVarValue(_idChar_UAN_Gd_bat_lvl2_room1_01_5,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_force_attk"))
			
			MakeCharacterSpeak(_idChar_UAN_Gd_bat_lvl2_room1_01_5,_idPlayer,"DIA_SPE_NIV_H_UAN_F_01",true,100,1,0.0,"",100.0)	
			_b_yetOnEnter_Sector_Event_Gd_bat_lvl2_couloir=true
			_bOnEnter_Sector_Event_Gd_bat_lvl2_couloir=1
		end
	end
end
-----------------------------------------------------------
function OnExit_Sector_Event_Gd_bat_lvl2_couloir(id)

	if (_bOnExit_Sector_Event_Gd_bat_lvl2_couloir==0)then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnExit_Sector_Event_Gd_bat_lvl2_couloir)then
			NewSubObjective("Obj_A_2","Obj_A_3")
			_b_yetOnExit_Sector_Event_Gd_bat_lvl2_couloir=true
			_bOnExit_Sector_Event_Gd_bat_lvl2_couloir=1
		end
	end
end

------------------------------------------------------------
function OnEnter_Sector_Event_Gd_bat_lvl2_room2(id)
	if (_bOnEnter_Sector_Event_Gd_bat_lvl2_room2==0)then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Gd_bat_lvl2_room2)then
			if(_idMerc[0]~=nil)then
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Interdit_Hack"))
			end
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_1,false)			
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_2,false)
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_3,false)
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_4,false)
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_5,false)
			_b_yetOnEnter_Sector_Event_Gd_bat_lvl2_room2=true
			_bOnEnter_Sector_Event_Gd_bat_lvl2_room2=1
		end
	end
end
-----------------------------------------------------------
function Level_2_room2()
	if (_bLevel_2_room2==0)then
	_nRestants_idGroup_UAN_Gd_bat_lvl2_room1_01=AliveMembersCount(_idGroup_UAN_Gd_bat_lvl2_room1_01)
		if (_nRestants_idGroup_UAN_Gd_bat_lvl2_room1_01<=3)and(_nBotsActifs<=8)then
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_1,false)
			SetVarValue(_idChar_UAN_Gd_bat_lvl2_room2_02_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_Gd_bat_lvl2_room1_2"))
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_2,false)
			SetVarValue(_idChar_UAN_Gd_bat_lvl2_room2_02_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_Gd_bat_lvl2_room1_3"))
			Freeze(_idChar_UAN_Gd_bat_lvl2_room2_02_4,false)
		--	SetVarValue(_idChar_UAN_Gd_bat_lvl2_room2_02_4,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_Gd_bat_lvl2_room1_5"))
			_bLevel_2_room2=1
		end
	end
end
-----------------------------------------------------------
---Si le joueur entre dans la zone pour la 1ere fois ou que le gpe 
--de la tente 3 est réduit à 1 alors on defreeze le groupe de 3 du batiment

function OnEnter_Sector_Event_Renforts_bat(id)
	if (_bOnEnter_Sector_Event_Renforts_bat==0)then
		_nRestants_Group_UAN_C3_01=AliveMembersCount(_idGroup_UAN_C3_01)

		if((GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Renforts_bat))or(_nRestants_Group_UAN_C3_01<=1) then
			FreezeAll(_idGroup_UAN_Gd_bat_lvl1_renforts_01,false)
			_b_yetOnEnter_Sector_Event_Renforts_bat=true
			_bOnEnter_Sector_Event_Renforts_bat=1

		end
	end
end
----------------------------------------------------------

------------------------------------------------------------

---------------------------------------------------------

function OnEnter_Sector_Event_Renforts_bat2(id)
	if(_bOnEnter_Sector_Event_Renforts_bat2==0) then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Renforts_bat2)and(_b_yetOnEnter_Sector_Event_Alim_shift_B==true)then
			FreezeAll(_idGroup_UAN_Renforts_bat2,false)
			_b_yetOnEnter_Sector_Event_Renforts_bat2=true
			_bOnEnter_Sector_Event_Renforts_bat2=1

		end
	end
end
------------------------------------------------------------
















































