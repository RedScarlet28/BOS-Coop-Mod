function UpdateLevel_Sewer ()
	IsGridDestroyed ()
end

function OnEnter_Sector_Event_Sewer_C_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		SetVarValue(GetSound_ClientID("Sound_Client_Ambiance_Sewer"),"Playing",true)
		SetVarValue(GetSound_ClientID("Sound_Client_vent"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_02"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_03"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_04"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_05"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_06"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_07"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_08"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_09"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_10"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_11"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_12"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_13"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_14"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_15"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_16"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_17"),"Volume",0.1)

	end
end



function OnExit_Sector_Event_Sewer_C_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		SetVarValue(GetSound_ClientID("Sound_Client_Ambiance_Sewer"),"Playing",false)
		SetVarValue(GetSound_ClientID("Sound_Client_vent"),"Volume",0.3)
		SetVarValue(GetSound_ClientID("Sound_Client_War_02"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_03"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_04"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_05"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_06"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_07"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_08"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_09"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_10"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_11"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_12"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_13"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_14"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_15"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_16"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_17"),"Volume",0.8)
	end
end


function OnEnter_Sector_Event_Sewer_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Sewer_A_00 == 0) then
			FreezeAll(GetGroupID("Group_Sewer_UAN_A"),false)
			_bOnEnter_Sector_Event_Sewer_A_00 = 1
		end
	end
end

function OnEnter_Sector_Event_Sewer_A_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Sewer_A_01 == 0) then
			FreezeAll(GetGroupID("Group_Sewer_UAN_B"),false)
			CreationTimer(true, true, false, "OnEnter_Sector_Event_Sewer_A_01_Bis", 4.0)	
			_bOnEnter_Sector_Event_Sewer_A_01 = 1
		end
	end
end


function OnEnter_Sector_Event_Sewer_A_01_Bis ()
	SetVarValue(GetCharacterID("Char_Sewer_UAN_B_01"),"CharacterOrderList",GetAI_Order_ListID ("AI_O_List_Force_Attack_Player_HIGH"))
	SetVarValue(GetCharacterID("Char_Sewer_UAN_B_02"),"CharacterOrderList",GetAI_Order_ListID ("AI_O_List_Force_Attack_Player_HIGH"))
end


function Tank_Explosion ()
		if (_bTankIsDestroyed == 0) then
			CreationTimer(true, true, false, "Obj_A_Update", 3.0)
			TankExplode(GetTankID("Tank_01"))
			_bTankIsDestroyed = 1
		end
end

function Obj_A_Update ()
	NewSubObjective ( "Obj_A_1", "Obj_A_2")
	SetVarValue (GetExposive_Plant_SiteID("Exposive_Plant_Grille"),"Active",true)
end

function IsGridDestroyed ()
	if (GetVarValue(GetDestructible_ObjectID("Destructible_Object_Grille"),"Destroyed") == true) then
		if (_bIsGridDestroyed == 0)then

			
			_bIsGridDestroyed = 1
		end
	end
end

function PickUpEnd ()
	SetVarValue (GetPickUpID("PickUp_01"),"OwnerID",GetInvalidEntityID())
end



function OnEnter_Sector_Event_Sewer_B_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Sewer_B_00 == 0) then
			FreezeAll(GetGroupID("Group_Sewer_UAN_C"),false)
			StopMusic()
			_bOnEnter_Sector_Event_Sewer_B_00 = 1
		end
	end
end

