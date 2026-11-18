function UpdateLevel_AVANT_CAMP()
end
------------------------------------------------------
function OnEnter_Sector_Event_middle_corniche(id)

	if(_bOnEnter_Sector_Event_middle_corniche==0)then
		if(id == _idPlayer)then			
			Freeze(_idChar_RES_Coursive_00_1,true)
			Freeze(_idChar_RES_Coursive_00_2,true)
			Freeze(_idChar_RES_Coursive_00_7,true)
			Freeze(_idChar_RES_Coursive_00_8,true)
			Freeze(_idChar_RES_Coursive_00_10,true)
			Freeze(_idChar_RES_Coursive_00_11,true)
			Freeze(_idChar_RES_Coursive_00_12,true)
			Freeze(_idChar_RES_Coursive_00_13,true)
			Freeze(_idChar_RES_Coursive_00_15,true)
			Freeze(_idChar_RES_Coursive_00_18,true)
			Freeze(_idChar_RES_Coursive_00_19,true)
				FreezeAll(_idGroup_SYND_01,true)
				FreezeAll(_idGroup_SYND_02,true)
				FreezeAll(_idGroup_SYND_03,true)
				FreezeAll(_idGroup_SYND_04,true)
				FreezeAll(_idGroup_SYND_05,true)
			---------
			
			Freeze(_idChar_SYND_00_3,false)
			Freeze(_idChar_SYND_00_5,false)
			Freeze(_idChar_SYND_00_6,false)
			Freeze(_idChar_SYND_00_7,false)
			Freeze(_idChar_SYND_00_8,false)
		--	SetVarValue(_idChar_RES_ExoMan_00_1,"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_fire_on_stone_1"))
			_bOnEnter_Sector_Event_middle_corniche=1
			end
	end
end
---------------------------------------------------------------
function OnExit_Sector_Event_middle_corniche(id)

	if(_bOnExit_Sector_Event_middle_corniche==0)then
		if(id == _idPlayer)then
			Freeze(_idChar_RES_Coursive_00_22,false)
			Freeze(_idChar_RES_Coursive_00_23,false)
			_bOnExit_Sector_Event_middle_corniche=1
		end
	end
end
----------------------------------------------------------------
function OnEnter_Sector_Event_illusion_bataille(id)

	if(_bOnEnter_Sector_Event_illusion_bataille==0)then
		if(id == _idPlayer)then
			Freeze(_idChar_RES_Coursive_00_9,false)
			
			_bOnEnter_Sector_Event_illusion_bataille=1
		end
	end
end
-----------------------------------------------------------------
function OnEnter_Sector_Event_CORNICHE(id)
	if(_bOnEnter_Sector_Event_CORNICHE==0)then
		if(id == _idPlayer)then
		_bOnEnter_Sector_Event_CORNICHE=1
		StartMusic("Sounds//Music//Bos - South theme.wav",true)
		end
	end
end
------------------------------------------
function OnExit_Sector_Event_CORNICHE(id)
	if(_bOnExit_Sector_Event_CORNICHE==0)then
		if(id == _idPlayer)then
			Freeze(_idChar_RES_Camp_00_9,false)
			MakeCharacterSpeak(_idChar_RES_Camp_00_9,_idPlayer,"DIA_SPE_NIV_N_SYNDI_A_01",true,95,2,0.0,"",95)
		_bOnExit_Sector_Event_CORNICHE=1
		end
	end
end
------------------------------------------
function OnEnter_Sector_Event_CORNICHE_1(id)

		if(id == _idPlayer)then
			FreezeAll(_idGroup_BATAILLE,true)
			Freeze(_idChar_RES_Camp_00_12,false)
			CharacterPlaySpecialAction(_idChar_RES_Camp_00_12,"STAND MEDHI ORDER_FOLLOW_ME W_NONE",true,false)
			CreationTimer(true,true,false,"stop_appel",3.0)
		end
end
-------------------------------------
function stop_appel()

		CharacterStopSpecialAction(_idChar_RES_Camp_00_12)

end
-----------------------------------
function OnEnter_Sector_Event_freeze_defreeze_corniche(id)
	if(_bOnEnter_Sector_Event_freeze_defreeze_corniche==0)then
		if(id == _idPlayer)then
			Freeze(_idChar_RES_ExoMan_00_1,true)
			Freeze(_idChar_RES_ExoMan_00_2,true)
		_bOnExit_Sector_Event_freeze_defreeze_corniche=0
		_bOnEnter_Sector_Event_freeze_defreeze_corniche=1		
		end
	end
end
----------------------------------------------
function OnExit_Sector_Event_freeze_defreeze_corniche(id)

	if(_bOnExit_Sector_Event_freeze_defreeze_corniche==0)then
		if(id == _idPlayer)then
			Freeze(_idChar_RES_ExoMan_00_1,false)
			Freeze(_idChar_RES_ExoMan_00_2,false)
		_bOnEnter_Sector_Event_freeze_defreeze_corniche=0
		_bOnExit_Sector_Event_freeze_defreeze_corniche=1		
		end
	end
end
----------------------------------------------------
function OnExit_Sector_Event_BOYAU(id)

	if(_bOnExit_Sector_Event_BOYAU==0)then
		if(id == _idPlayer)then
		
			_bOnEnter_Sector_Event_BOYAU=0
		_bOnExit_Sector_Event_BOYAU=1
		end
	end
end
--------------------------------------------------
function OnEnter_Sector_Event_BOYAU(id)

	if(_bOnEnter_Sector_Event_BOYAU==0)then
		if(id == _idPlayer)then
			SetVarValue(_idChar_RES_Camp_00_9,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_go_wp_BOYAU_3"))
			SetVarValue(_idChar_RES_Camp_00_12,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_go_wp_BOYAU_4"))	
			Freeze(_idChar_RES_ExoMan_00_1,true)
			Freeze(_idChar_RES_ExoMan_00_2,true)
			_bOnExit_Sector_Event_BOYAU=0
		_bOnEnter_Sector_Event_BOYAU=1
		end
	end
end
--------------------------------------------------
function OnEnter_Sector_Event_Check_point(id)

_bAliveChar_RES_Camp_00_9=IsAlive(_idChar_RES_Camp_00_9)
_bAliveChar_RES_Camp_00_12=IsAlive(_idChar_RES_Camp_00_12)
--_idObj_A_2=GetObjectiveID("Obj_A_2")
	if(_bOnEnter_Sector_Event_Check_point==0)then
		if(id == _idPlayer)and
				(_bAliveChar_RES_Camp_00_9==false)or
				(_bAliveChar_RES_Camp_00_12==false)then
				
				FreezeAll(_idGroup_SYND_01,true)
				FreezeAll(_idGroup_SYND_02,true)
				FreezeAll(_idGroup_SYND_03,true)
				FreezeAll(_idGroup_SYND_04,true)
				FreezeAll(_idGroup_SYND_05,true)
			RadioMessage("DIA_SPE_NIV_N_GENERAL_RADIO_12",true,100,0.0,"")
		--	NewSubObjective ("Obj_A_2","Obj_A_3")
			_bOnEnter_Sector_Event_Check_point=1
		end
	end
end
---------------------------------------------------------------
function OnExit_Sector_Event_fin_Boyau(id)

	EnableCharacterCommand(_idPlayer,true)
	EnableCharacterCommand(_idChar_RES_Camp_00_5,true)
	EnableCharacterCommand(_idChar_RES_Camp_00_10,true)
	EnableCharacterCommand(_idChar_RES_Camp_00_11,true)
	EnableCharacterCommand(_idChar_RES_Camp_01_1,true)
	EnableCharacterCommand(_idChar_RES_Camp_01_2,true)
	EnableCharacterCommand(_idChar_RES_Camp_01_3,true)
	EnableCharacterCommand(_idChar_RES_Camp_01_4,true)

		if(id == _idPlayer)then
			Freeze(_idChar_RES_Camp_00_6,false)
			Freeze(_idChar_RES_Camp_00_7,false)
			Freeze(_idChar_RES_Camp_00_13,false)
			Freeze(_idChar_RES_ExoMan_00_1,false)
			Freeze(_idChar_RES_ExoMan_00_2,false)	
			Freeze(_idChar_RES_HANGAR_00_1,false)
				SetVarValue(_idChar_RES_Camp_00_6,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_CAMP_8"))
				SetVarValue(_idChar_RES_Camp_00_7,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_CAMP_2"))
				SetVarValue(_idChar_RES_Camp_00_13,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_CAMP_9"))
			----
			Freeze(_idChar_RES_HANGAR_00_1,true)
			Freeze(_idChar_RES_HANGAR_00_2,true)
			Freeze(_idChar_RES_HANGAR_00_3,true)
			Freeze(_idChar_RES_HANGAR_00_4,true)
			Freeze(_idChar_RES_HANGAR_00_5,true)
			Freeze(_idChar_RES_HANGAR_00_6,true)
			Freeze(_idChar_RES_HANGAR_00_7,true)
			Freeze(_idChar_RES_HANGAR_00_8,true)

			Freeze(_idChar_RES_Camp_00_1,true)
			Freeze(_idChar_RES_Camp_00_2,true)
			Freeze(_idChar_RES_Camp_00_3,true)
			Freeze(_idChar_RES_Camp_00_4,true)
		--Freeze(_idChar_RES_Camp_00_6,true)
		--Freeze(_idChar_RES_Camp_00_7,true)
			Freeze(_idChar_RES_Camp_00_8,true)
		--Freeze(_idChar_RES_Camp_00_13,true)
			Freeze(_idChar_RES_Camp_00_14,true)
			-----
			FreezeAll(_idGroup_BATAILLE,true)
			FreezeAll(_idGroup_SYND_01,true)
			FreezeAll(_idGroup_SYND_02,true)
			FreezeAll(_idGroup_SYND_03,true)
			FreezeAll(_idGroup_SYND_04,true)
			FreezeAll(_idGroup_SYND_05,true)
		end
end
------------------------------------------------------------------------
-------------------------------------------------------------
function OnEnter_Sector_Event_fin_Boyau(id)

	if(_bOnEnter_Sector_Event_fin_Boyau==0)then
		if(id == _idPlayer)then
			Freeze(_idChar_RES_Camp_00_10,false)
			Freeze(_idChar_RES_Camp_00_14,false)
			Freeze(_idChar_RES_Camp_00_13,false)
			Freeze(_idChar_RES_Camp_00_5,false)
			Freeze(_idChar_RES_Coursive_00_9,true)
		--	Freeze(_idChar_RES_HANGAR_00_1,true)
		--	Freeze(_idChar_RES_HANGAR_00_2,true)
		--	Freeze(_idChar_RES_HANGAR_00_3,true)
		--	Freeze(_idChar_RES_HANGAR_00_4,true)
		--	Freeze(_idChar_RES_HANGAR_00_5,true)
		--	Freeze(_idChar_RES_HANGAR_00_6,true)
		--	Freeze(_idChar_RES_HANGAR_00_7,true)
		--	Freeze(_idChar_RES_HANGAR_00_8,true)
		--	Freeze(_idChar_RES_Camp_00_1,true)
		--	Freeze(_idChar_RES_Camp_00_2,true)
		--	Freeze(_idChar_RES_Camp_00_3,true)
		--	Freeze(_idChar_RES_Camp_00_4,true)
		--	Freeze(_idChar_RES_Camp_00_13,true)
			FreezeAll(_idGroup_BATAILLE,true)
		--	FreezeAll(_idGroup_SYND_01,true)
		--	FreezeAll(_idGroup_SYND_02,true)
		--	FreezeAll(_idGroup_SYND_03,true)
		---	FreezeAll(_idGroup_SYND_04,true)
		--	FreezeAll(_idGroup_SYND_05,true)
		
			_bOnEnter_Sector_Event_fin_Boyau=1
		end
	end
end
----------------------------------------------------------
function OnEnter_Sector_Event_Entree_boyau(id)

	if(_bOnEnter_Sector_Event_Entree_boyau==0)then
		if(id ==( _idChar_RES_Camp_00_9)and(_idChar_RES_Camp_00_12))then
			FreezeAll(_idGroup_CAMP_01,false)
			MakeCharacterSpeak(_idChar_RES_Camp_00_5,_idPlayer,"DIA_SPE_NIV_N_SYNDI_B_01",true,95,2,0.0,"",95)
			Freeze(_idChar_RES_ExoMan_00_1,false)
			Freeze(_idChar_RES_ExoMan_00_2,false)
			Freeze(_idChar_RES_Ruine_00_1,true)
			Freeze(_idChar_RES_Ruine_00_2,true)
			Freeze(_idExoskeleton_Hangar_3,false)
			Freeze(_idExoskeleton_Hangar_5,false)	
		_bOnEnter_Sector_Event_Entree_boyau=1
		end
	end
end
---------------------------------------------------------------

function OnEnter_Sector_Event_CHECK(id)
--[[
	if(_bOnEnter_Sector_Event_CHECK==0)then
		if(id==_idPlayer)and(_nLife_Exo_UAN_3>=0)and(_nLife_Exo_UAN_5>=0)and(_bOnEnter_Sector_Event_CHECK1~=1)then
			ObjectiveDoneNewObjectiveNewSubObjective("Obj_A","Obj_B","Obj_B_1")
			_bOnEnter_Sector_Event_CHECK=1
		end	
		if(id==_idPlayer)and(_nWPExo3>=0)and(_nLife_Exo_UAN_5>=0)and(_bOnEnter_Sector_Event_CHECK1~=1)then
			ObjectiveDoneNewObjectiveNewSubObjective("Obj_A","Obj_B","Obj_B_1")
			_bOnEnter_Sector_Event_CHECK=1
		end	
		if(id==_idPlayer)and(_nWPExo5>=0)and(_nLife_Exo_UAN_3>=0)and(_bOnEnter_Sector_Event_CHECK1~=1)then
			ObjectiveDoneNewObjectiveNewSubObjective("Obj_A","Obj_B","Obj_B_1")
			_bOnEnter_Sector_Event_CHECK=1
		end
		if(id==_idPlayer)and(_nWPExo5>=0)and(_nWPExo3>=0)and(_bOnEnter_Sector_Event_CHECK1~=1)then
			ObjectiveDoneNewObjectiveNewSubObjective("Obj_A","Obj_B","Obj_B_1")
			_bOnEnter_Sector_Event_CHECK=1
		end	
	end  	

	if(_bOnEnter_Sector_Event_CHECK1==0)then
		if(id==_idPlayer)and((_nLife_Exo_UAN_3==0)or(_nLife_Exo_UAN_5==0))and(_bOnEnter_Sector_Event_CHECK~=1)then
			ObjectiveDoneNewObjectiveNewSubObjective ("Obj_A","Obj_B","Obj_B_2")
			_bOnEnter_Sector_Event_CHECK1=1
		end		
	end

	if(_bOnEnter_Sector_Event_CHECK2==0)then
		if(id==_idPlayer)then
			Freeze(_idExoskeleton_Hangar_3,false)
			Freeze(_idExoskeleton_Hangar_5,false)	
			MiniMapTrack(_idExoskeleton_Hangar_3,2,true)
			MiniMapTrack(_idExoskeleton_Hangar_5,2,true) 
			_bOnEnter_Sector_Event_CHECK2=1
		end	
	end
--]]
end



 		

































































