function UpdateLevel_COLONEL()
end
-----------------------------------

---------------------------------------
--en se mettant face au colonel,on affiche le brief
function OnStay_Sector_Event_COLONEL(id)

	if(_bOnStay_Sector_Event_COLONEL==0) then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnStay_Sector_Event_COLONEL)then
								
			MakeCharacterSpeak(_idChar_WRF_COLONEL,_idPlayer,"DIA_SPE_NIV_L_MORIS_01",true,96,2,0.0,"SuiteColonel",96)
			SetVarValue(_idChar_WRF_COLONEL,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_military_salut"))
			--EnableCharacterCommand(_idPlayer,false)
			_byetOnStay_Sector_Event_COLONEL=true
			_bOnStay_Sector_Event_COLONEL=1
		end
	end		
end
------------------------------------------
function OnEnter_Sector_Event_COLONEL(id)	

	if(_bOnEnter_Sector_Event_COLONEL==0)then
		if(GetLocalCharacterID("Player")==id)and(_byetOnExit_Sector_Event_COLONEL==true)then		
			MakeCharacterSpeak(_idChar_WRF_COLONEL,_idPlayer,"DIA_SPE_NIV_D_GENERAL_09",true,95,2,0.0,"",95)		
			_bOnEnter_Sector_Event_COLONEL=1
		end
	end
end
--------------------------------------------
function OnExit_Sector_Event_COLONEL(id)

	if(_bOnExit_Sector_Event_COLONEL==0)then
		_byetOnExit_Sector_Event_COLONEL=true
		_bOnExit_Sector_Event_COLONEL=1
	end
end
-------------------------------------------
function SuiteColonel()

	MakeCharacterSpeak(_idChar_WRF_COLONEL,_idPlayer,"DIA_SPE_NIV_L_MORIS_01_C",true,100,2,0.0,"Show_Objective",100)
end

--------------------------------------------
function Show_Objective()

_idDoor_left=GetDoorID("Door_left")
_idDoor_middle=GetDoorID("Door_middle")
_idDoor_right=GetDoorID("Door_right")

			MiniMapTrack(_idChar_WRF_COLONEL,2,false)
			NewSubObjective ( "Obj_A_1", "Obj_A_2")			
			EnableCharacterCommand(_idPlayer,true)
			UnLockDoor(_idDoor_left,true)
			UnLockDoor(_idDoor_middle,true)
			UnLockDoor(_idDoor_right,true)
end
