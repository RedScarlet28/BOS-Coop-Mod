--[[ Random sur les phrases liées à la mort d'un ennemi --]]

function RandomSpeakerDialogues1()
	local nNumb1 = GetRandom(1,2)
	if (nNumb1 == 1) and (_bTestMortBot == true) then
		local nNumber1 = GetRandom(1,10)
		if (nNumber1 == 1) then
			-- DIA_SPE_NIV_M_COMMENT_RADIO_26
--			Dialogue(true,3,"Très beau coup !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_26",0)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_26", true, 99, 0,"")

		elseif (nNumber1 == 2) then
			-- DIA_SPE_NIV_M_COMMENT_RADIO_27
--			Dialogue(true,3,"On peut applaudir !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_27",0)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_27", true, 99, 0,"")
		elseif (nNumber1 == 3) then
			-- DIA_SPE_NIV_M_COMMENT_RADIO_28
--			Dialogue(true,3,"Pas mal !")	
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_28",0)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_28", true, 99, 0,"")
		elseif (nNumber1 == 4) then
			-- DIA_SPE_NIV_M_COMMENT_RADIO_29
--			Dialogue(true,3,"Bien joué !")	
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_29",0)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_29", true, 99, 0,"")
		elseif (nNumber1 == 5) then
			-- DIA_SPE_NIV_M_COMMENT_RADIO_30
--			Dialogue(true,3,"Très beau combat !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_30",0)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_30", true, 99, 0,"")
		elseif (nNumber1 == 6) then
			-- DIA_SPE_NIV_M_COMMENT_RADIO_31
--			Dialogue(true,3,"C'est un véritable plaisir pour nos yeux !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_31",0)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_31", true, 99, 0,"")
		elseif (nNumber1 == 7) then
			-- DIA_SPE_NIV_M_COMMENT_RADIO_32
--			Dialogue(true,3,"Bravo !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_32",0)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_32", true, 99, 0,"")
		elseif (nNumber1 == 8) then
			-- DIA_SPE_NIV_M_COMMENT_RADIO_33
--			Dialogue(true,3,"Ah ! Un mort par ici !")	
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_33",0)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_33", true, 99, 0,"")
		elseif (nNumber1 == 9) then
			-- DIA_SPE_NIV_M_COMMENT_RADIO_34
--			Dialogue(true,3,"Un nouveau mort là-bas !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_34",0)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_34", true, 99, 0,"")
		else
		-- DIA_SPE_NIV_M_COMMENT_RADIO_35
--		Dialogue(true,3,"Ca saigne dans l'arène !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_35",0)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_35", true, 99, 0,"")
		end
		_bTestMortBot = false
	else
		_bTestMortBot = false
	end
end

--[[ Initialisation des tableaux utilisés dans TestMortBot() --]]

vie1 = {}
vie2 = {}
vie3 = {}
vie4 = {}
vie5 = {}
vie6 = {}
vie7 = {}
vie8 = {}
vie9 = {}
vie10 = {}
vie11 = {}
BotMort1 = {}
BotMort2 = {}
BotMort3 = {}
BotMort4 = {}
BotMort5 = {}
BotMort6 = {}
BotMort7 = {}
BotMort8 = {}
BotMort9 = {}
BotMort10 = {}
BotMort11 = {}

--[[ Attribution d'une valeur aux clés des tableaux utilisés dans TestMortBot() --]]

BotMort1[1] = false
BotMort1[2] = false
BotMort1[3] = false
BotMort1[4] = false
BotMort1[5] = false

BotMort2[1] = false
BotMort2[2] = false
BotMort2[3] = false

BotMort3[1] = false
BotMort3[2] = false
BotMort3[3] = false

BotMort4[1] = false
BotMort4[2] = false
BotMort4[3] = false

BotMort5[1] = false
BotMort5[2] = false
BotMort5[3] = false

BotMort6[1] = false
BotMort6[2] = false
BotMort6[3] = false

BotMort7[1] = false
BotMort7[2] = false
BotMort7[3] = false
BotMort7[4] = false
BotMort7[5] = false

BotMort8[1] = false
BotMort8[2] = false
BotMort8[3] = false
BotMort8[4] = false
BotMort8[5] = false

BotMort9[1] = false
BotMort9[2] = false
BotMort9[3] = false

BotMort10[1] = false
BotMort10[2] = false
BotMort10[3] = false

BotMort11[1] = false
BotMort11[2] = false
BotMort11[3] = false

NbBotGrpVivants = {}
vieGrp1 = {}
vieGrp2 = {}
vieGrp3 = {}
vieGrp4 = {}
machin = {}
GrpMort1 = {}
GrpMort1[1] = false
GrpMort1[2] = false
GrpMort1[3] = false
GrpMort1[4] = false

GrpMort2 = {}
GrpMort2[1] = false
GrpMort2[2] = false

GrpMort3 = {}
GrpMort3[1] = false
GrpMort3[2] = false

GrpMort4 = {}
GrpMort4[1] = false
GrpMort4[2] = false
GrpMort4[3] = false

--[[ Teste si chaque Bot est encore en vie et si non, lance la fonction qui joue les dialogues aléatoirement --]]

function TestMortBot()
	for i=1,4,1 do
		vie1[i] = GetHealth(GetCharacterID("Char_Syndic_Soldats_01_" .. i))
		if (vie1[i] == 0) and (_bVieSyndic_Soldats_01 == true) then
			_bTestMortBot = true
			if (BotMort1[i] == false) then
				--[[ Random sur les dialogues liés à la mort des Bots ennemis --]]
				RandomSpeakerDialogues1()
				BotMort1[i] = true
			end
		end
	end
	for i=1,3,1 do
		vie2[i] = GetHealth(GetCharacterID("Char_Syndic_Soldats_02_" .. i))
		if (vie2[i] == 0) and (_bVieSyndic_Soldats_02 == true) then
			_bTestMortBot = true
			if (BotMort2[i] == false) then
				--[[ Random sur les dialogues liés à la mort des Bots ennemis --]]
				RandomSpeakerDialogues1()
				BotMort2[i] = true
			end
		end
	end
	for i=1,3,1 do
		vie3[i] = GetHealth(GetCharacterID("Char_Syndic_Soldats_03_" .. i))
		if (vie3[i] == 0) and (_bVieSyndic_Soldats_03 == true) then
			_bTestMortBot = true
			if (BotMort3[i] == false) then
				--[[ Random sur les dialogues liés à la mort des Bots ennemis --]]
				RandomSpeakerDialogues1()
				BotMort3[i] = true
			end
		end
	end
	for i=1,3,1 do
		vieGrp1[i] = IsAlive(GetGroupID("Grp_Syndic_Soldats_0" .. i))
		if (vieGrp1[i] == false) then
			_bTestVieGrp = true
			if (GrpMort1[i] == false) then
				--[[ Random sur les dialogues liés à la mort des Bots ennemis --]]
				RandomSpeakerDialogues2()
				GrpMort1[i] = true
			end
		end
	end
	for i=1,3,1 do
		vie5[i] = GetHealth(GetCharacterID("Char_Syndic_Para_01_" .. i))
		if (vie5[i] == 0) and (_bVieSyndic_Para_01 == true) then
			_bTestMortBot = true
			if (BotMort5[i] == false) then
				--[[ Random sur les dialogues liés à la mort des Bots ennemis --]]
				RandomSpeakerDialogues1()
				BotMort5[i] = true
			end
		end
	end
	for i=1,3,1 do
		vie6[i] = GetHealth(GetCharacterID("Char_Syndic_Para_01_" .. i))
		if (vie6[i] == 0) and (_bVieSyndic_Para_02 == true) then
			_bTestMortBot = true
			if (BotMort6[i] == false) then
				--[[ Random sur les dialogues liés à la mort des Bots ennemis --]]
				RandomSpeakerDialogues1()
				BotMort6[i] = true
			end
		end
	end
	for i=1,2,1 do
		vieGrp2[i] = IsAlive(GetGroupID("Grp_Syndic_Para_0" .. i))
		if (vieGrp2[i] == false) then
			_bTestVieGrp = true
			if (GrpMort2[i] == false) then
				--[[ Random sur les dialogues liés à la mort des Bots ennemis --]]
				RandomSpeakerDialogues2()
				GrpMort2[i] = true
			end
		end
	end
	for i=1,4,1 do
		vie7[i] = GetHealth(GetCharacterID("Char_Syndic_Snipers_01_" .. i))
		if (vie7[i] == 0) and (_bVieSyndic_Soldats_07 == true) then
			_bTestMortBot = true
			if (BotMort7[i] == false) then
				--[[ Random sur les dialogues liés à la mort des Bots ennemis --]]
				RandomSpeakerDialogues1()
				BotMort7[i] = true
			end
		end
	end
	for i=1,4,1 do
		vie8[i] = GetHealth(GetCharacterID("Char_Syndic_Snipers_02_" .. i))
		if (vie8[i] == 0) and (_bVieSyndic_Soldats_08 == true) then
			_bTestMortBot = true
			if (BotMort8[i] == false) then
				--[[ Random sur les dialogues liés à la mort des Bots ennemis --]]
				RandomSpeakerDialogues1()
				BotMort8[i] = true
			end
		end
	end
	for i=1,2,1 do
		vieGrp3[i] = IsAlive(GetGroupID("Grp_Syndic_Snipers_0" .. i))
		if (vieGrp3[i] == false) then
			_bTestVieGrp = true
			if (GrpMort3[i] == false) then
				--[[ Random sur les dialogues liés à la mort des Bots ennemis --]]
				RandomSpeakerDialogues2()
				GrpMort3[i] = true
			end
		end
	end
	for i=1,3,1 do
		vie9[i] = GetHealth(GetCharacterID("Char_Syndic_Kenyans_01_" .. i))
		if (vie9[i] == 0) and (_bVieSyndic_Soldats_09 == true) then
			_bTestMortBot = true
			if (BotMort9[i] == false) then
				--[[ Random sur les dialogues liés à la mort des Bots ennemis --]]
				RandomSpeakerDialogues1()
				BotMort9[i] = true
			end
		end
	end
	for i=1,3,1 do
		vie10[i] = GetHealth(GetCharacterID("Char_Syndic_Kenyans_02_" .. i))
		if (vie10[i] == 0) and (_bVieSyndic_Soldats_10 == true) then
			_bTestMortBot = true
			if (BotMort10[i] == false) then
				--[[ Random sur les dialogues liés à la mort des Bots ennemis --]]
				RandomSpeakerDialogues1()
				BotMort10[i] = true
			end
		end
	end
	for i=1,3,1 do
		vie11[i] = GetHealth(GetCharacterID("Char_Syndic_Kenyans_03_" .. i))
		if (vie11[i] == 0) and (_bVieSyndic_Soldats_11 == true) then
			_bTestMortBot = true
			if (BotMort11[i] == false) then
				--[[ Random sur les dialogues liés à la mort des Bots ennemis --]]
				RandomSpeakerDialogues1()
				BotMort11[i] = true
			end
		end
	end
	for i=1,3,1 do
		vieGrp4[i] = IsAlive(GetGroupID("Grp_Syndic_Kenyans_0" .. i))
		if (vieGrp4[i] == false) then
			_bTestVieGrp = true
			if (GrpMort4[i] == false) then
				--[[ Random sur les dialogues liés à la mort des Bots ennemis --]]
				RandomSpeakerDialogues2()
				GrpMort4[i] = true
			end
		end
	end
end

--[[ Random sur les phrases liées à la mort des membres d'un groupe --]]

function RandomSpeakerDialogues2()
	local nNumb2 = GetRandom(1,2)
	if (nNumb2 == 1) and (_bTestVieGrp == true) then
		local nNumber2 = GetRandom(1,2)
		if (nNumber2 == 1) then
			-- DIA_SPE_NIV_M_COMMENT_RADIO_36
--			Dialogue(true,3,"Quelle tuerie !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_36",1)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_36", true, 99, 0,"")
		else
			-- DIA_SPE_NIV_M_COMMENT_RADIO_37
--			Dialogue(true,3,"C'est un véritable massacre !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_37",1)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_37", true, 99, 0,"")
		end
			_bTestVieGrp = false
	end
end

--[[ Phrase liée à la présence d'au moins 3 ennemis blessés --]]

TestHurt1 = {}
TestHurt2 = {}
TestHurt3 = {}
TestHurt4 = {}
TestHurt5 = {}
TestHurt6 = {}
TestHurt7 = {}
TestHurt8 = {}
TestHurt9 = {}
TestHurt10 = {}
TestHurt11 = {}

TestHurt1b = {}
TestHurt1b[1] = false
TestHurt1b[2] = false
TestHurt1b[3] = false
TestHurt1b[4] = false
TestHurt1b[5] = false

TestHurt2b = {}
TestHurt2b[1] = false
TestHurt2b[2] = false
TestHurt2b[3] = false

TestHurt3b = {}
TestHurt3b[1] = false
TestHurt3b[2] = false
TestHurt3b[3] = false

TestHurt4b = {}
TestHurt4b[1] = false
TestHurt4b[2] = false
TestHurt4b[3] = false

TestHurt5b = {}
TestHurt5b[1] = false
TestHurt5b[2] = false
TestHurt5b[3] = false

TestHurt6b = {}
TestHurt6b[1] = false
TestHurt6b[2] = false
TestHurt6b[3] = false

TestHurt7b = {}
TestHurt7b[1] = false
TestHurt7b[2] = false
TestHurt7b[3] = false
TestHurt7b[4] = false
TestHurt7b[5] = false

TestHurt8b = {}
TestHurt8b[1] = false
TestHurt8b[2] = false
TestHurt8b[3] = false
TestHurt8b[4] = false
TestHurt8b[5] = false

TestHurt9b = {}
TestHurt9b[1] = false
TestHurt9b[2] = false
TestHurt9b[3] = false

TestHurt10b = {}
TestHurt10b[1] = false
TestHurt10b[2] = false
TestHurt10b[3] = false

TestHurt11b = {}
TestHurt11b[1] = false
TestHurt11b[2] = false
TestHurt11b[3] = false


function HurtTest()
	for i=1,4,1 do
		TestHurt1[i] = GetHealthPct(GetCharacterID("Char_Syndic_Soldats_01_" .. i))
		if (TestHurt1[i] <= 75) and (TestHurt1[i] >= 1) and (TestHurt1b[i] == false) then
			_nNbHurtSoldiers = _nNbHurtSoldiers + 1
			TestHurt1b[i] = true
		end
	end
	for i=1,3,1 do
		TestHurt2[i] = GetHealthPct(GetCharacterID("Char_Syndic_Soldats_02_" .. i))
		if (TestHurt2[i] <= 75) and (TestHurt2[i] >= 1) and (TestHurt2b[i] == false) then
			_nNbHurtSoldiers = _nNbHurtSoldiers + 1
			TestHurt2b[i] = true
		end
	end
	for i=1,3,1 do
		TestHurt3[i] = GetHealthPct(GetCharacterID("Char_Syndic_Soldats_03_" .. i))
		if (TestHurt3[i] <= 75) and (TestHurt3[i] >= 1) and (TestHurt3b[i] == false) then
			_nNbHurtSoldiers = _nNbHurtSoldiers + 1
			TestHurt3b[i] = true
		end
	end
	for i=1,3,1 do
		TestHurt5[i] = GetHealthPct(GetCharacterID("Char_Syndic_Para_01_" .. i))
		if (TestHurt5[i] <= 75) and (TestHurt5[i] >= 1) and (TestHurt5b[i] == false) then
			_nNbHurtSoldiers = _nNbHurtSoldiers + 1
			TestHurt5b[i] = true
		end
	end
	for i=1,3,1 do
		TestHurt6[i] = GetHealthPct(GetCharacterID("Char_Syndic_Para_02_" .. i))
		if (TestHurt6[i] <= 75) and (TestHurt6[i] >= 1) and (TestHurt6b[i] == false) then
			_nNbHurtSoldiers = _nNbHurtSoldiers + 1
			TestHurt6b[i] = true
		end
	end
	for i=1,4,1 do
		TestHurt7[i] = GetHealthPct(GetCharacterID("Char_Syndic_Snipers_01_" .. i))
		if (TestHurt7[i] <= 75) and (TestHurt7[i] >= 1) and (TestHurt7b[i] == false) then
			_nNbHurtSoldiers = _nNbHurtSoldiers + 1
			TestHurt7b[i] = true
		end
	end
	for i=1,4,1 do
		TestHurt8[i] = GetHealthPct(GetCharacterID("Char_Syndic_Snipers_02_" .. i))
		if (TestHurt8[i] <= 75) and (TestHurt8[i] >= 1) and (TestHurt8b[i] == false) then
			_nNbHurtSoldiers = _nNbHurtSoldiers + 1
			TestHurt8b[i] = true
		end
	end
	for i=1,3,1 do
		TestHurt9[i] = GetHealthPct(GetCharacterID("Char_Syndic_Kenyans_01_" .. i))
		if (TestHurt9[i] <= 75) and (TestHurt9[i] >= 1) and (TestHurt9b[i] == false) then
			_nNbHurtSoldiers = _nNbHurtSoldiers + 1
			TestHurt9b[i] = true
		end
	end
	for i=1,3,1 do
		TestHurt10[i] = GetHealthPct(GetCharacterID("Char_Syndic_Kenyans_02_" .. i))
		if (TestHurt10[i] <= 75) and (TestHurt10[i] >= 1) and (TestHurt10b[i] == false) then
			_nNbHurtSoldiers = _nNbHurtSoldiers + 1
			TestHurt10b[i] = true
		end
	end
	for i=1,3,1 do
		TestHurt11[i] = GetHealthPct(GetCharacterID("Char_Syndic_Kenyans_03_" .. i))
		if (TestHurt11[i] <= 75) and (TestHurt11[i] >= 1) and (TestHurt11b[i] == false) then
			_nNbHurtSoldiers = _nNbHurtSoldiers + 1
			TestHurt11b[i] = true
		end
	end
	if (_nNbHurtSoldiers >= 3) and (_bActiveHurtTest == true) then
		-- DIA_SPE_NIV_M_COMMENT_RADIO_38
--		Dialogue(true,3,"Je vois de nombreux blessés !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_38",1)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_38", true, 99, 0,"")
		_bActiveHurtTest = false
		_nNbHurtSoldiers = 0
		CreationTimer(true, true, false, "ActiveHurtTest", 10)
	end
end

function ActiveHurtTest()
	_bActiveHurtTest = true
end

--[[ Random sur les phrases liées à l'absence de Nolan ds l'arène --]]

function RandomSpeakerDialogues3()
	local nNumb1 = GetRandom(1,2)
	if (nNumb1 == 1) and (_bCtrlSpeakDial3 == true) and (_bCtrlSpeakDial3_2 == true) then
		local nNumber1 = GetRandom(1,3)
		if (nNumber1 == 1) then
			-- DIA_SPE_NIV_M_COMMENT_RADIO_39
--			Dialogue(true,3,"La foule acclame Nolan, mais le Champion semble la dédaigner !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_39",2)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_39", true, 99, 0,"")
		elseif (nNumber1 == 2) then
			-- DIA_SPE_NIV_M_COMMENT_RADIO_40
--			Dialogue(true,3,"Que fait donc Nolan ? Le public le réclame !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_40",2)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_40", true, 99, 0,"")
		elseif (nNumber1 == 3) then
			-- DIA_SPE_NIV_M_COMMENT_RADIO_41
--			Dialogue(true,3,"Montrez-vous Nolan ! Seriez-vous timide quand vient votre heure de gloire ?")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_41",2)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_41", true, 99, 0,"")
		else
			-- DIA_SPE_NIV_M_COMMENT_RADIO_42
--			Dialogue(true,3,"Nolan ! Nolan ! Nolan !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_42",2)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_42", true, 99, 0,"")
		end
		_bCtrlSpeakDial3 = false
	else
		_bCtrlSpeakDial3 = false
	end
end