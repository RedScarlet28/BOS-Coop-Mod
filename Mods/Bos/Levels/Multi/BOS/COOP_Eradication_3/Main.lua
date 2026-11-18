--
function InitLevel()
	CheckInitLevel_eradication_3()

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
	_idChar_Ami_1 = GetCharacterID("Char_Ami_1")
	_idChar_Ami_2 = GetCharacterID("Char_Ami_2")
	_bIngeMustNotDie = true

	SetVarValue(GetAI_Order_Forbid_TargetID("AIOFT_Inge"),"Target",_idMerc[0])

--[[
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


	StartMusic("Sounds//Music//BoS - Eradication theme.wav", true)
	--CreationTimer(true, true, false,"CINE_End",1.0)
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

-------------------------------------------------------------
-- :::: InitLevelMonastery ::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
	InitLevelMonastery()

-------------------------------------------------------------
-- :::: InitLevelRoof :::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
	InitLevelRoof()

-------------------------------------------------------------
-- :::: Debug :::::::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

	
-------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires ::::::: --
-------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	
end


--
function UpdateLevel()

-------------------------------------------------------------
-- :::: UpdateLevelPhase1 :::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
	UpdateLevelPhase1()
	if (_bIngeMustNotDie == true) then
		GlobalIngenieurIsDead()
	end
	GlobalPlayerIsDead()

-------------------------------------------------------------
-- :::: UpdateLevelMonastery ::::::::::::::::::::::::::::: --
-------------------------------------------------------------
	UpdateLevelMonastery()

-------------------------------------------------------------
-- :::: UpdateLevelRoof :::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
	UpdateLevelRoof()

-------------------------------------------------------------
-- :::: Debug :::::::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
	_nBotActive=GetTotalActiveCharacterCount()
	_nBotAlive=GetTotalAliveCharacterCount()
		PrintDebug("Bots actifs: ".._nBotActive)
		PrintDebug("Bots vivants: ".._nBotAlive)
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
	PrecacheSentence("DIA_SPE_BOS_SHAIMING_COMBAT_BAD_6")
	PrecacheSentence("DIA_SPE_BOS_SHAIMING_COMBAT_BAD_5")
	PrecacheSentence("DIA_CINE2_A_NOLAN_01")
	PrecacheSentence("DIA_CINE2_A_BALDING_01")
	PrecacheSentence("DIA_CINE2_A_NOLAN_02")
	PrecacheSentence("DIA_CINE2_A_BALDING_02")
	PrecacheSentence("DIA_CINE2_A_BALDING_03")
	PrecacheSentence("DIA_CINE2_A_BALDING_04")
	PrecacheSentence("DIA_CINE2_A_BALDING_05")
	PrecacheSentence("DIA_CINE2_A_BALDING_06")
	PrecacheSentence("DIA_CINE2_B_NOLAN_02")
	PrecacheSentence("DIA_CINE2_A_BALDING_07")
	PrecacheSentence("DIA_CINE2_A_BALDING_08")
	PrecacheSentence("DIA_CINE2_A_BALDING_09")
	PrecacheSentence("DIA_CINE2_A_BALDING_10")
end