function UpdateLevel_REMPARTS()
end
--------------------------------------------------
--Quand le joueur reste dans le remparts de droite, on FREEZE ceux qui sont a gauche

function OnStay_Sector_Event_Control_Player_Right(id)

if(_bOnStay_Sector_Event_Control_Player_Right==0)then
	if(id==_idPlayer)then
		if IsEntityInBox(_idChar_RES_CAMP_00_2,"Sector_Event_LEFT")then
		Freeze(_idChar_RES_CAMP_00_2,true)
		end
		if IsEntityInBox(_idChar_RES_CAMP_00_4,"Sector_Event_LEFT")then
		Freeze(_idChar_RES_CAMP_00_4,true)
		end
		if IsEntityInBox(_idChar_RES_CAMP_00_24,"Sector_Event_LEFT")then
		Freeze(_idChar_RES_CAMP_00_24,true)
		end
		if IsEntityInBox(_idChar_RES_CAMP_00_1,"Sector_Event_LEFT")then
		Freeze(_idChar_RES_CAMP_00_1,true)
		end
		if IsEntityInBox(_idChar_RES_CAMP_00_15,"Sector_Event_LEFT")then
		Freeze(_idChar_RES_CAMP_00_15,true)
		end		
		if IsEntityInBox(_idChar_RES_CAMP_00_18,"Sector_Event_LEFT")then
		Freeze(_idChar_RES_CAMP_00_18,true)
		end	
		_bOnStay_Sector_Event_Control_Player_Right=1
		_bOnExit_Sector_Event_Control_Player_Right=0
		_bPlayerInControl_Right=true
	end
end
end
--------------------------------------------------
function OnExit_Sector_Event_Control_Player_Right(id)

if(_bOnExit_Sector_Event_Control_Player_Right==0)then
	if(id==_idPlayer)then
			
		_bOnExit_Sector_Event_Control_Player_Right=1
		_bOnStay_Sector_Event_Control_Player_Right=0
		_bPlayerInControl_Right=false
	end
end
end
--------------------------------------------------
--On DEFREEZE CEUX DE GAUCHE, QUAND le joueur est devant la porte du REMPART dE GAUCHE que celle ci est 
--fermée et que les mecs dedans sont froid

function OnEnter_Sector_Event_DEF_WEST(id)


	if(_bOnEnter_Sector_Event_DEF_WEST==0)then
		if(id==_idPlayer)then
					Freeze(_idChar_RES_CAMP_00_2,true)
					Freeze(_idChar_RES_CAMP_00_18,false)
					Freeze(_idChar_RES_CAMP_00_1,false)
					Freeze(_idChar_RES_CAMP_00_4,false)
					Freeze(_idChar_RES_CAMP_00_24,false)
			_bOnEnter_Sector_Event_DEF_WEST=1
			_bOnExit_Sector_Event_DEF_WEST=0
		end
	end
end
-------------------------------------------------
--ON REFREEZE ceux de gauche, quand le joueur est sorti de la porte du rempart de gauche

function OnExit_Sector_Event_DEF_WEST(id)

	if(_bOnExit_Sector_Event_DEF_WEST==0)then
		if(id==_idPlayer)then
			Freeze(_idChar_RES_CAMP_00_2,false)
			Freeze(_idChar_RES_CAMP_00_18,false)
			Freeze(_idChar_RES_CAMP_00_1,false)
			if IsEntityInBox(_idChar_RES_CAMP_00_2,"Sector_Event_LEFT")then
				Freeze(_idChar_RES_CAMP_00_2,true)
			end
			if IsEntityInBox(_idChar_RES_CAMP_00_4,"Sector_Event_LEFT")then
				Freeze(_idChar_RES_CAMP_00_4,true)
			end
			if IsEntityInBox(_idChar_RES_CAMP_00_24,"Sector_Event_LEFT")then
					Freeze(_idChar_RES_CAMP_00_24,true)
			end
						_bOnEnter_Sector_Event_DEF_WEST=0
			_bOnExit_Sector_Event_DEF_WEST=1
		end
	end
end

----------------------------------------------------------------------
--Si le joueur est dans les remparts ou sur la colline alors HANG et ses gardes passent derrier la tente pour etre freezés
function Freeze_Hang()
	if(_bFreeze_Hang==0)then
		if(_bWasHang==true)and((_bPlayerInControl_Right==true)or(_bOnEnter_Sector_Event_Game==1))then
				SetVarValue(_idChar_RES_CAMP_00_16,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_freeze_tente"))
				SetVarValue(_idChar_RES_CAMP_00_17,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_freeze_tente"))
				SetVarValue(_idChar_RES_CAMP_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_freeze_tente"))
				SetVarValue(_idChar_RES_CAMP_00_22,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_freeze_tente"))
				SetVarValue(_idChar_RES_CAMP_00_23,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_freeze_tente"))
				SetVarValue(_idChar_HANG,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_freeze_tente"))
				_bFreeze_Hang=1
		end
	end
end