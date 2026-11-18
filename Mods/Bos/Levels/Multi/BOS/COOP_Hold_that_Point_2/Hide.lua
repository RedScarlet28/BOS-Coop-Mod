--
function InitLevel_Hide()
	InitScriptVariable_Hide()


--	_idPara_Hide_1													= GetCharacterID("Char_UAN_Camp1_00_1")
	--_idExo_05															= GetExoskeletonID("Exo_05")

end

--
function InitScriptVariable_Hide()
	_bVisitedHouse							= false
	_bDialogueExo								= false
	_nSpawnHide 								= 0
	_nRenfortAllie							= 1
	_bDefreeze_Grp_UAN_Tank_01	= 0
	_bObj_B_2										= 0
end


function UpdateLevel_Hide()
	Calcul_Defreeze_Hide ()
	Defreeze_Grp_UAN_Tank_01 ()
end


function Calcul_Defreeze_Hide ()

	_nBotGlobalActifs = GetTotalActiveCharacterCount()

	_nBotWRFActifs = 5
	if (_idMerc[1] ~= nil) then
		if not IsAlive (_idMerc[1])then
			_nBotWRFActifs = 	_nBotWRFActifs - 1
		end
	end
	if not IsAlive (GetCharacterID("Char_WRF_Corridor_2_2"))then
		_nBotWRFActifs = 	_nBotWRFActifs - 1
	end
	if not IsAlive (GetCharacterID("Char_WRF_Corridor_1_2"))then
		_nBotWRFActifs = 	_nBotWRFActifs - 1
	end

	_nBotUANActifs = (_nBotGlobalActifs - _nBotWRFActifs)

	Defreeze_Hide ()	
end


function Defreeze_Hide ()
	if (_bExitFromCorridor == true)
	and (not IsEntityInBox(_idPlayer,"Sector_Hangar_Global" ))
	and (not IsEntityInBox(_idPlayer,"Sector_Heliport_Global" ))then
		if ((_nSpawnHide == 0) and (_nBotUANActifs <= 6) and not IsEntityInBox(_idPlayer,"Sector_Hide_1" )) then				
			FreezeAll(GetGroupID("Grp_UAN_Hide_1"),false)
			_nSpawnHide = 1
			return
		end
		if ((_nSpawnHide == 1) and (_nBotUANActifs <= 6) and not IsEntityInBox(_idPlayer,"Sector_Hide_2" )) then
			FreezeAll(GetGroupID("Grp_UAN_Hide_2"),false)
			_nSpawnHide = 2
			return
		end
		if ((_nSpawnHide == 2) and (_nBotUANActifs <= 6) and not IsEntityInBox(_idPlayer,"Sector_Heliport_Global" )) then
			FreezeAll(GetGroupID("Grp_UAN_Hide_3"),false)
			_nSpawnHide = 3
			return
		end
		if ((_nSpawnHide == 3) and (_nBotUANActifs <= 6) and not IsEntityInBox(_idPlayer,"Sector_Hide_2" )) then
			FreezeAll(GetGroupID("Grp_UAN_Hide_4"),false)
			_nSpawnHide = 4
			return
		end
		if ((_nSpawnHide == 4) and (_nBotUANActifs <= 6) and not IsEntityInBox(_idPlayer,"Sector_Hide_1" )) then
			FreezeAll(GetGroupID("Grp_UAN_Hide_5"),false)
			_nSpawnHide = 5
			return
		end
		if ((_nSpawnHide == 5) and (_nBotUANActifs <= 5) and not IsEntityInBox(_idPlayer,"Sector_Hide_1" )) then
			FreezeAll(GetGroupID("Grp_UAN_Hide_6"),false)
			_nSpawnHide = 6
			return
		end
		if ((_nSpawnHide == 6) and (_nBotUANActifs <= 4) and not IsEntityInBox(_idPlayer,"Sector_Hide_1" )) then
			FreezeAll(GetGroupID("Grp_UAN_Hide_7"),false)
			_nSpawnHide = 7
			return
		end
		if ((_nSpawnHide == 7) and (_nBotUANActifs <= 5)) then
			HideSuite()
			_nSpawnHide = 8
			return
		end
	end
end

function HideSuite()
	SetVarValue(GetCharacterID("Char_WRF_Corridor_2_2"),"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Follow_Player_WRF"))
	FreezeAll(GetGroupID("Grp_UAN_Heliport_3"),false)
	FreezeAll(GetGroupID("Grp_UAN_Hide_9"),false)
	StopMusic()
end

-- Defreeze du deuxième exo
function OnEnter_Sector_Hide_5(idEntrant)
	if (idEntrant==_idPlayer) then
		if (_bOnEnter_Sector_Hide_5 == 0) then
			Freeze(GetCharacterID("Char_UAN_Hide_3_5"),false)
			Freeze(GetExoskeletonID("Exo_UAN_Hide_2"),false)
			FreezeAll(GetGroupID("Grp_UAN_Hide_9"),false)
			_bOnEnter_Sector_Hide_5 = 1
		end
	end
end



-- Defreeze de gars dans le petit passage
function OnEnter_Sector_Hide_4(idEntrant)
	if (idEntrant==_idPlayer) then
		if (_bOnEnter_Sector_Hide_4 == 0) then
			FreezeAll(GetGroupID("Grp_UAN_Hide_8"),false)
			_bOnEnter_Sector_Hide_4 = 1
		end
	end
end

-- defreeze des gardes du tank
-- mise a jour objectif
function Defreeze_Grp_UAN_Tank_01 ()
	_nHealth_Tank_01 = GetVarValue(GetTankID("Tank_01"),"Health")
	if (_nHealth_Tank_01 <= 500) and ( _bDefreeze_Grp_UAN_Tank_01 == 0)then
		FreezeAll(GetGroupID("Grp_UAN_Tank_01"),false)
		_bDefreeze_Grp_UAN_Tank_01 = 1
	end
	if (_nHealth_Tank_01 <= 0) and ( _bObj_B_2 == 0) then
		CreationTimer(true, true, false, "SubObj_2_Done", 2.5)	
		_bObj_B_2 = 1
	end
end

-- Update obj, tank dead
function SubObj_2_Done ()
	NewSubObjective ("Obj_B_2","Obj_B_3")
end

-- Security tank
-- Si Nolan passe le tank devient très dangereux
function OnEnter_Sector_Hide_Tank(idEntrant)
	if (idEntrant==_idPlayer) then
		if (_nHealth_Tank_01 > 0) then
		SetVarValue(GetTankID("Tank_01"),"Rotation Speed",90)
		SetVarValue(GetTankID("Tank_01"),"Shoot Delay",0.3)
		end
	end
end


function OnEnter_Sector_Hide_Tank1(idEntrant)
	if (idEntrant==_idPlayer) then
		if (_nHealth_Tank_01 > 0) then
		SetVarValue(GetTankID("Tank_01"),"Rotation Speed",100)
		SetVarValue(GetTankID("Tank_01"),"Shoot Delay",0.15)
		end
	end
end

-- END OF LEVEL
function OnEnter_Sector_End(idEntrant)
	if (idEntrant==_idPlayer) then
		if (_bVolExo == true) then
			EndOfLevel()
		end
	end
end


--
function InDaHouse()
	SetVarValue(GetGroupID("Grp_WRF_Corridor_1"),"GroupAIOrderList",GetAI_Order_ListID("AI_Order_List_Limit_Zone_Hide_Maison_1"));
	--SetVarValue(GetGroupID("Grp_WRF_Corridor_2"),"GroupAIOrderList",GetAI_Order_ListID("AI_Order_List_Limit_Zone_Hide_Maison_1"));
	return true;
end



