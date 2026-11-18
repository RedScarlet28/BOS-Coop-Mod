function UpdateLevel_Start3 ()
	if(_bObjectif_1_done == 0)then
		Nolan_Near_Antenna()
		IsAntennaDestoyed()
	end
end

-- Un groupe est defreezés et part vers Nolan et la rue
function OnEnter_Sector_Event_Start3_B_01(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
			if (_bOnEnter_Sector_Event_Start3_B_01 == 0) then
				if (_bObjectif_1_done == 0)then	
					FreezeAll(GetGroupID("Group_UAN_Start3_03"), false)
					_bOnEnter_Sector_Event_Start3_B_01 = 1
				end			
			end
	end
end



-- Un groupe est defreezés et part vers Nolan et la rue
function OnEnter_Sector_Event_Start3_A_01(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
			if (_bOnEnter_Sector_Event_Start3_A_01 == 0) then
				if (_bObjectif_1_done == 0)then	
					FreezeAll(GetGroupID("Group_UAN_Start3_02"), false)
					_bOnEnter_Sector_Event_Start3_A_01 = 1	
				end		
			end
	end
end



-- boite d'event
function OnEnter_Sector_Event_Start3_A_00(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
			if (_bOnEnter_Sector_Event_Start3_A_00 == 0) then
					_bOnEnter_Sector_Event_Start3_A_00 = 1			
			end
	end
end

-- defreeze d'un UAN et dun WRF pour mini-scène
function OnEnter_Sector_Event_Start3_A_02(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
			if (_bOnEnter_Sector_Event_Start3_A_02 == 0) then
				if (_bObjectif_1_done == 0)then	
					Freeze(GetCharacterID("Char_WRF_Start3_00_2"), false)
					Freeze(GetCharacterID("Char_UAN_Start3_00_1"), false)
					_bOnEnter_Sector_Event_Start3_A_02 = 1	
				end		
			end
	end
end


-- des soldats quittent leur crouch
function ExpirationChar_UAN_Start3_03_1_Crouching(idCharacter)
    if ((idCharacter == GetCharacterID("Char_UAN_Start3_03_1")))then 
			if (_bOnEnter_Sector_Event_Start3_A_00 == 1 )then
        return true
			end
    end
    return false
end

function ExpirationChar_UAN_Start3_03_2_Crouching(idCharacter)
    if ((idCharacter == GetCharacterID("Char_UAN_Start3_03_2")))then 
			if (_bOnEnter_Sector_Event_Start3_A_00 == 1 )then
        return true
			end
    end
    return false
end

function ExpirationChar_UAN_Start3_03_3_Crouching(idCharacter)
    if ((idCharacter == GetCharacterID("Char_UAN_Start3_03_3")))then 
			if (_bOnEnter_Sector_Event_Start3_B_02 == 1 )then
        return true
			end
    end
    return false
end

-- Les snipers à une fenetre sont defrrezés
-- un allié est defreezé devant la fenetre des snipers
-- soldat UAN et WRf dans une rue au loin défreezé pour mini scène
function OnEnter_Sector_Event_Start3_B_02(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
			if (_bOnEnter_Sector_Event_Start3_B_02 == 0) then
				if (_bObjectif_1_done == 0)then	
					FreezeAll(GetGroupID("Group_UAN_Start3_01"), false)
					Freeze(GetCharacterID("Char_WRF_Start3_00_1"), false)
					FreezeAll(GetGroupID("Group_UAN_Start3_05"), false)
					Freeze(GetCharacterID("Char_WRF_Start3_00_3"), false)		
					_bOnEnter_Sector_Event_Start3_B_02 = 1			
				end
			end
	end
end

-- defreeze groupe de l'antenne
function OnEnter_Sector_Event_Start3_C_01(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
			if (_bOnEnter_Sector_Event_Start3_C_01 == 0) then
				if (_bObjectif_1_done == 0)then
					FreezeAll(GetGroupID("Group_UAN_Start3_04"), false)	
					_bOnEnter_Sector_Event_Start3_C_01 = 1	
				end		
			end
	end
end


-- Si le joueur est aller trop vite, les UAN le poursuient
function OnEnter_Sector_Event_Start_B_06(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Start_B_06 == 0) then
			SetVarValue(GetCharacterID("Char_UAN_Start3_03_3"),"CharacterOrderList",GetAI_Order_ListID ("AI_O_List_Force_Attack_Player"))			
			SetVarValue(GetCharacterID("Char_UAN_Start3_01_1"),"CharacterOrderList",GetAI_Order_ListID ("AI_O_List_Force_Attack_Player"))			
			_bOnEnter_Sector_Event_Start_B_06 = 1
		end
	end
end



----------------------
-- OBJECTIF 1 DONE----
----------------------
--Nolan est près de l'objectif
function Nolan_Near_Antenna()
	if(_bNolan_Near_Antenna == 0)then
		if(_bObjectif_1_done == 0)then
			if ( AliveMembersCount(GetGroupID("Group_UAN_Start3_04")) <= 0 ) then
					RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_04", true, 110, 0,"")
				_bNolan_Near_Antenna = 1		
			end
		end
	end
end


function IsAntennaDestoyed()
	_bIsDestroyedAntenna = GetVarValue(GetDestructible_ObjectID("Destructible_Object_Ante_01"),"Destroyed")
	
	if(_bIsDestroyedAntenna == true)then
		if(_bObjectif_1_done == 0)then
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Feu"),"FxState","Fx Started")
			CameraShake(1.2,1.5,1.5,1.5)
			Refreeze_A ()
			SetVarValue(GetTimerID("Timer_City1_A_00"),"Active",true)		
			SetVarValue(GetTimerID("Timer_Start3_A_00"),"Active",true)
			UnLockDoor(GetDoorID("Door_02"))
			UnLockDoor(GetDoorID("Door_17"))
			OpenDoor(GetDoorID("Door_17"))
			_bObjectif_1_done = 1

			rCountDown = 200
 			idTimerCountDown_2 = CreateTimer()
 			SetVarValue(idTimerCountDown_2, "Active", true)
			SetVarValue(idTimerCountDown_2, "DestroyOnExpire", false)
 			SetVarValue(idTimerCountDown_2, "Loop", true)
			SetVarValue(idTimerCountDown_2, "TriggerFunction", "CountDown_2")
			SetVarValue(idTimerCountDown_2, "Duration", 1.0)
		end
	end	
end


function PickUpEnd ()
	SetVarValue (GetPickUpID("PickUp_01"),"OwnerID",GetInvalidEntityID())
end

-- MINUTEUR
function CountDown_2()
	if (_bObjectif_1_done == 1) 
	and (_bDefreeze_Defreeze_BOS == 0) 
	and (GetHealth(_idPlayer)> 0) then
 		rCountDown = rCountDown - 1
		if (rCountDown > 30)then
			Display_CountDown(rCountDown)
			elseif ( rCountDown == -1 ) then
 		 	ReleaseEntity(idTimerCountDown_2)
		else
			Display_CountDown_red(rCountDown)
			SetVarValue(GetSound_ClientID("Sound_CountDown"), "Playing", true)
		end
	end
end


-- NEW OBJECTIVE
function New_Obj_B ()
	ObjectiveDoneNewObjectiveNewSubObjective ( "Obj_A", "Obj_B", "Obj_B_1" )
	SetVarValue ( GetObjectiveID ("Obj_B_a"),"Active", true )
end

-- je refreeze pleins de persos au cas ou ils sont encore là pour passer à la suite du scénar
function Refreeze_A ()
	FreezeAll(GetGroupID("Group_UAN_Start_01"), true)
	FreezeAll(GetGroupID("Group_WRF_Start_00"), true)
	FreezeAll(GetGroupID("Group_UAN_Start_00"), true)
	FreezeAll(GetGroupID("Group_UAN_Start_02"), true)
	FreezeAll(GetGroupID("Group_UAN_Start_03"), true)
	FreezeAll(GetGroupID("Group_UAN_Start_04"), true)
	FreezeAll(GetGroupID("Group_UAN_Start_05"), true)
	FreezeAll(GetGroupID("Group_WRF_Start_01"), true)
	FreezeAll(GetGroupID("Group_UAN_Start2_01"), true)
	FreezeAll(GetGroupID("Group_UAN_Start2_02"), true)
	FreezeAll(GetGroupID("Group_UAN_Start2_03"), true)
	FreezeAll(GetGroupID("Group_UAN_Start2_04"), true)
	FreezeAll(GetGroupID("Group_UAN_Start2_05"), true)
	FreezeAll(GetGroupID("Group_UAN_Start3_03"), true)
	FreezeAll(GetGroupID("Group_UAN_Start3_05"), true)
	FreezeAll(GetGroupID("Group_WRF_Start2_02"), true)
	FreezeAll(GetGroupID("Group_UAN_Start2_06"), true)
	Freeze(GetCharacterID("Char_WRF_Start3_00_1"), true)
	Freeze(GetCharacterID("Char_WRF_Start3_00_2"), true)
	Freeze(GetCharacterID("Char_WRF_Start2_01_1"), true)
	Freeze(GetCharacterID("Char_WRF_Start3_00_3"), true)	
end
