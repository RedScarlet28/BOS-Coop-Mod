--[[ Testent si le joueur approche d'un sniper en position et change son arsenal et ses ordres pour lui permettre de se battre en combat rapproché --]]

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_01_1 :::: ---------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_01_1(id)
if ((id == GetCharacterID("Char_Syndic_Snipers_01_1")) and (_bCtrlCharAI_Sniper_01_1 == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_1"), "CharacterAI", GetCharacter_AIID("Char_AI_Syndic_Snipers_02"))
		_bCtrlCharAI_Sniper_01_1 = true
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_01_1b :::: --------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_01_1b(id)
	if ((id == _idPlayer) and (_bVieSniper_01_1 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_01_1a"))
	end
end

function OnExit_Sector_Event_Sniper_01_1b(id)
	if ((id == _idPlayer) and (_bVieSniper_01_1 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_01_1"))
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_01_2 :::: ---------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_01_2(id)
	if ((id == GetCharacterID("Char_Syndic_Snipers_01_2")) and (_bCtrlCharAI_Sniper_01_2 == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_2"), "CharacterAI", GetCharacter_AIID("Char_AI_Syndic_Snipers_02"))
		_bCtrlCharAI_Sniper_01_2 = true
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_01_2b :::: --------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_01_2b(id)
	if ((id == _idPlayer) and (_bVieSniper_01_2 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_01_2b"))
	end
end

function OnExit_Sector_Event_Sniper_01_2b(id)
	if ((id == _idPlayer) and (_bVieSniper_01_2 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_01_2"))
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_01_5 :::: ---------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_01_5(id)
	if ((id == GetCharacterID("Char_Syndic_Snipers_01_3")) and (_bCtrlCharAI_Sniper_01_3 == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_3"), "CharacterAI", GetCharacter_AIID("Char_AI_Syndic_Snipers_02"))
		_bCtrlCharAI_Sniper_01_3 = true
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_01_5b :::: --------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_01_5b(id)
	if ((id == _idPlayer) and (_bVieSniper_01_3 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_01_3a"))
	end
end

function OnExit_Sector_Event_Sniper_01_5b(id)
	if ((id == _idPlayer) and (_bVieSniper_01_3 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_01_3"))
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_01_4 :::: ---------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_01_4(id)
	if ((id == GetCharacterID("Char_Syndic_Snipers_01_4")) and (_bCtrlCharAI_Sniper_01_4 == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_4"), "CharacterAI", GetCharacter_AIID("Char_AI_Syndic_Snipers_02"))
		_bCtrlCharAI_Sniper_01_4 = true
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_01_4b :::: --------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_01_4b(id)
	if ((id == _idPlayer) and (_bVieSniper_01_4 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_4"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_01_4a"))
	end
end

function OnExit_Sector_Event_Sniper_01_4b(id)
	if ((id == _idPlayer) and (_bVieSniper_01_4 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_01_4"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_01_4"))
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_02_1 :::: ---------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_02_1(id)
	if ((id == GetCharacterID("Char_Syndic_Snipers_02_1")) and (_bCtrlCharAI_Sniper_02_1 == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_1"), "CharacterAI", GetCharacter_AIID("Char_AI_Syndic_Snipers_02"))
		_bCtrlCharAI_Sniper_02_1 = true
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_02_1b :::: --------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_02_1b(id)
	if ((id == _idPlayer) and (_bVieSniper_02_1 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_02_1a"))
	end
end

function OnExit_Sector_Event_Sniper_02_1b(id)
	if ((id == _idPlayer) and (_bVieSniper_02_1 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_02_1"))
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_02_2 :::: ---------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_02_2(id)
	if ((id == GetCharacterID("Char_Syndic_Snipers_02_2")) and (_bCtrlCharAI_Sniper_02_2 == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_2"), "CharacterAI", GetCharacter_AIID("Char_AI_Syndic_Snipers_02"))
		_bCtrlCharAI_Sniper_02_2 = true
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_02_2b :::: --------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_02_2b(id)
	if ((id == _idPlayer) and (_bVieSniper_02_2 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_02_2a"))
	end
end

function OnExit_Sector_Event_Sniper_02_2b(id)
	if ((id == _idPlayer) and (_bVieSniper_02_2 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_02_2"))
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_02_5 :::: ---------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_02_5(id)
	if ((id == GetCharacterID("Char_Syndic_Snipers_02_3")) and (_bCtrlCharAI_Sniper_02_3 == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_3"), "CharacterAI", GetCharacter_AIID("Char_AI_Syndic_Snipers_02"))
		_bCtrlCharAI_Sniper_02_3 = true
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_02_5b :::: --------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_02_5b(id)
	if ((id == _idPlayer) and (_bVieSniper_02_3 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_02_3a"))
	end
end

function OnExit_Sector_Event_Sniper_02_5b(id)
	if ((id == _idPlayer) and (_bVieSniper_02_3 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_02_3"))
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_02_4 :::: ---------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_02_4(id)
	if ((id == GetCharacterID("Char_Syndic_Snipers_02_4")) and (_bCtrlCharAI_Sniper_02_4 == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_4"), "CharacterAI", GetCharacter_AIID("Char_AI_Syndic_Snipers_02"))
		_bCtrlCharAI_Sniper_02_4 = true
	end
end

-----------------------------------------------------------------
-- :::: Sector_Event_Sniper_02_4b :::: --------------------------
-----------------------------------------------------------------

function OnEnter_Sector_Event_Sniper_02_4b(id)
	if ((id == _idPlayer) and (_bVieSniper_02_4 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_4"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_02_4a"))
	end
end

function OnExit_Sector_Event_Sniper_02_4b(id)
	if ((id == _idPlayer) and (_bVieSniper_02_4 == true) and (_bCtrlSniperBoxPlayer == false)) then
		SetVarValue(GetCharacterID("Char_Syndic_Snipers_02_4"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Sniper_02_4"))
	end
end

--[[ Teste si les snipers sont en vie --]]

function TestVieSnipers()

	VieSniper_01_1 = GetHealth (GetCharacterID("Char_Syndic_Snipers_01_1"))
	if (VieSniper_01_1 == 0) then
		_bVieSniper_01_1 = false
	end
	VieSniper_01_2 = GetHealth (GetCharacterID("Char_Syndic_Snipers_01_2"))
	if (VieSniper_01_2 == 0) then
		_bVieSniper_01_2 = false
	end
	VieSniper_01_3 = GetHealth (GetCharacterID("Char_Syndic_Snipers_01_3"))
	if (VieSniper_01_3 == 0) then
		_bVieSniper_01_3 = false
	end
	VieSniper_01_4 = GetHealth (GetCharacterID("Char_Syndic_Snipers_01_4"))
	if (VieSniper_01_4 == 0) then
		_bVieSniper_01_42 = false
	end

	VieSniper_02_1 = GetHealth (GetCharacterID("Char_Syndic_Snipers_02_1"))
	if (VieSniper_02_1 == 0) then
		_bVieSniper_02_1 = false
	end
	VieSniper_02_2 = GetHealth (GetCharacterID("Char_Syndic_Snipers_02_2"))
	if (VieSniper_02_2 == 0) then
		_bVieSniper_02_2 = false
	end
	VieSniper_02_3 = GetHealth (GetCharacterID("Char_Syndic_Snipers_02_3"))
	if (VieSniper_02_3 == 0) then
		_bVieSniper_02_3 = false
	end
	VieSniper_02_4 = GetHealth (GetCharacterID("Char_Syndic_Snipers_02_4"))
	if (VieSniper_02_4 == 0) then
		_bVieSniper_02_4 = false
	end
end