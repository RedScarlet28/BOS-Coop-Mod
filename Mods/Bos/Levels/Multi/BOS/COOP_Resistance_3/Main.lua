--
function InitLevel()
	CheckInitLevel_resistance_3()

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
-- :::: AMIS ::::::::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
--[[
	_idChar_Ami_1 = GetCharacterID("Char_Ami_1")
	_idChar_Ami_2 = GetCharacterID("Char_Ami_2")
	if (g_bEradication2Played == true) then
		if (g_bAliveChar_Ami_1 == true) then
			Freeze(_idChar_Ami_1, false)
			SetVarValue(_idChar_Ami_1,"HelmetHitPoints",g_nArmorHelmetChar_Ami_1)
			SetVarValue(_idChar_Ami_1,"BodyHitPoints",g_nArmorBodyChar_Ami_1)
			SetVarValue(_idChar_Ami_1,"LegsHitPoints",g_nArmorLegsChar_Ami_1)
			SetVarValue(_idChar_Ami_1,"BodyModel",g_strBodyModelChar_Ami_1)
			SetVarValue(_idChar_Ami_1,"HeadModel",g_strHeadModelChar_Ami_1)
			SetVarValue(_idChar_Ami_1,"EyeModel",g_strEyeModelChar_Ami_1)
			SetVarValue(_idChar_Ami_1,"Voice",g_strVoiceChar_Ami_1)
		end
		if (g_bAliveChar_Ami_2 == true) then
			Freeze(_idChar_Ami_2, false)
			SetVarValue(_idChar_Ami_2,"HelmetHitPoints",g_nArmorHelmetChar_Ami_1)
			SetVarValue(_idChar_Ami_2,"BodyHitPoints",g_nArmorBodyChar_Ami_1)
			SetVarValue(_idChar_Ami_2,"LegsHitPoints",g_nArmorLegsChar_Ami_1)
			SetVarValue(_idChar_Ami_2,"BodyModel",g_strBodyModelChar_Ami_1)
			SetVarValue(_idChar_Ami_2,"HeadModel",g_strHeadModelChar_Ami_1)
			SetVarValue(_idChar_Ami_2,"EyeModel",g_strEyeModelChar_Ami_1)
			SetVarValue(_idChar_Ami_2,"Voice",g_strVoiceChar_Ami_1)
		end
	else
		Freeze(_idChar_Ami_1, false)
		Freeze(_idChar_Ami_2, false)
	end
--]]
-------------------------------------------------------------
-- :::: SoundPrecache :::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
	SoundPrecache()

-------------------------------------------------------------
-- :::: InitLevelPhase1 :::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
	InitLevelPhase1()

	InitScriptVariable()

	ActiveTrackingMercs()
	DesactiveTrackingMercs()

	InitLevelMonastery()
	InitLevelRoof()
	
		
-------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires ::::::: --
-------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()

	_bCtrlBaldingFightEnCours = false

--to see end cine
--CreationTimer(true, true, false,"CINE_End",3)
	
end


--
function UpdateLevel()

-------------------------------------------------------------
-- :::: updateLevelPhase1 :::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
	UpdateLevelPhase1()
--	GlobalIngenieurIsDead()
	GlobalPlayerIsDead()
	UpdateLevelMonastery()
	UpdateLevelRoof()

	if (_bCtrlBaldingFightEnCours == true) then
		Champion_Stop_Turning_Reloading(GetCharacterID("Char_Max_Balding_Roof"),"AIOL_FA_Player")
	end
end


-- 
function InitScriptVariable()
	_idPlayer = GetCharacterID("Player")
	_nBombPlayer = 1
	nBombardement = 50
	_bOkPluieFolle = true
end









------------------------------------------------------------
------------------------------------------------------------

-- ::: Précache des dial. ::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function SoundPrecache()

	PrecacheSentence("DIA_SPE_NIV_N_INGENIEUR_B_08")
	PrecacheSentence("DIA_SPE_NIV_N_INGENIEUR_B_07")
	PrecacheSentence("DIA_SPE_NIV_N_INGENIEUR_B_04")
	PrecacheSentence("DIA_SPE_NIV_N_RESIS_01")
	PrecacheSentence("DIA_SPE_NIV_N_SHAIMING_01")
	PrecacheSentence("DIA_SPE_NIV_N_RESIS_04")
	PrecacheSentence("DIA_SPE_NIV_N_SYND_A_01")
	PrecacheSentence("DIA_SPE_NIV_N_INGENIEUR_B_06")
	PrecacheSentence("DIA_SPE_NIV_N_INGENIEUR_B_05")
	
end