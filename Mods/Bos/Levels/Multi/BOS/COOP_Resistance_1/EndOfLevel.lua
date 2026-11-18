--[[ Fin Loading --]]
function UpdateLevel_ENDofLEVEL()

end
-----------------------------------------------------------------
function OnEnter_Sector_Event_End_Of_Level(id)

	if(_bOnEnter_Sector_Event_End_Of_Level==0)then
		if (id == _idPlayer) then
			if(_bNo_EXO==1)and(_bExo_Desactivating==1)and(_bIn_Exo==1)and(_bOnDeath_Tank_SYND_01==1)and(_bIs_Saved==1)then
						EndOfLevel()
					_bOnEnter_Sector_Event_End_Of_Level=1
			end
		end
	end
end
---------------------------------------------------------------------
function Is_Saved()

	if(_bIs_Saved==0)then
		if not(IsAlive(_idChar_SYND_RUIN_16))and not(IsAlive(_idChar_SYND_RUIN_17))and not(IsAlive(_idChar_SYND_RUIN_18))then
		
			ObjectiveDoneNewObjectiveNewSubObjective ("Obj_3","Obj_4","Obj_4_1" )
			if(_idMerc[0]~=nil)then
			EnableCharacterCommand(_idMerc[0],true)
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Ascenseur"))
			end
		_bIs_Saved=1
	end
	end
end
----------------------------------------------------------------------

