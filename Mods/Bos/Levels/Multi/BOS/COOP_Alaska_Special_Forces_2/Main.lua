--
function InitLevel()
	
	CheckInitLevel_special_forces_2()
-------------------------------------------------------------
-- :::::::: CHAMPIONS :::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

-- Champion_Edouardo_Heartbreaker ->	Char_Champion_0_1
-- Champion_Chan_Wan_Hang		    	->	Char_Champion_0_2
-- Champion_Le_Professeur					->	Char_Champion_0_3


		-- Récupère l'ID du Champion actif pour la zone 0
		_idChampion_0 = GetChampionFromArea(0)
	--	SetVarValue(_idChampion_0,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Char_Chp_Camp_3"))

		-- Récupère le nom du Champion actif pour la zone 0
		_sNomChampion_0 = GetVarValue(_idChampion_0, "Name")

		-- Assigne un description de Champion à Nolan		
		AssignChampionToPlayer( "Champion_Nolan_Patrol" )

-------------------------------------------------------------
-- :::: MERCENAIRES :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
	-- Récupère les ID des Mercs actifs et leur colle une AIOL
	_idMerc={};
	number = GetMercenaryCount(); 
	number = number - 1;
	for i=0,number,1 do
		_idMerc[i] = GetMercenary(i); 
	end

-------------------------------------------------------------
-- :::: SoundPrecache :::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
	SoundPrecache()

-------------------------------------------------------------
-- :::: InitLevelPhase1 :::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

	InitScriptVariable()

	ActiveTrackingMercs()
	DesactiveTrackingMercs()

	InitLevel_Street_phase_1()
	InitLevel_Parking()
	
	
-------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires ::::::: --
-------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	
end


--
function UpdateLevel()

-------------------------------------------------------------
-- :::: updateLevelPhase1 :::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

	GlobalPlayerIsDead()
	UpdateLevel_Street_phase_1()
	UpdateLevel_Parking()
	UpdateLevel_FX_CARS()
end


-- 
function InitScriptVariable()
	_idPlayer = GetCharacterID("Player")
	_bCAR_1 = 0
	_bCAR_2 = 0
	_bCAR_3 = 0
	_bCAR_4 = 0
	_bCAR_5 = 0
	_bCAR_6 = 0
	_bCAR_7 = 0
	_bTRUCK_1 = 0
	_bTRUCK_2 = 0
	_bTRUCK_3 = 0
	_bTRUCK_4 = 0
end









------------------------------------------------------------
------------------------------------------------------------

-- ::: Précache des dial. ::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function SoundPrecache()

	
end