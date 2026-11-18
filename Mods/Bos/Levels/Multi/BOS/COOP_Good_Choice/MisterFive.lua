--[[ Teste si Mister Five est blessé ou mort et exécute les dialogues du speaker --]]

function MisterFive()
	if (_idMerc[0] ~= nil) then 
	_nVieMisterFive = GetHealthPct(_idMerc[0])
	 if (_nVieMisterFive <= 75) and (_bCtrlMortMisterFive == false) and (_bCtrlPassageMisterFive == false) then
		-- DIA_SPE_NIV_M_COMMENT_RADIO_61
--		Dialogue(true,2,"Ah je crois voir que Mister Five est blessé !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_61",1)	
	-- CreationTimer(true, true, false, "CtrlVieMisterFive",3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_61", true, 100, 2,"CtrlVieMisterFive")
		_bCtrlPassageMisterFive = true
	elseif (_bCtrlVieMisterFive == true) and (_nVieMisterFive == 0) then
		-- DIA_SPE_NIV_M_COMMENT_RADIO_61
--		Dialogue(true,3,"Mister five est à terre ! Nolan se retrouve seul ! Attention Nolan est seul désormais !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_62",2)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_62", true, 100, 0,"")
		_bCtrlMortMisterFive = true
		_bCtrlVieMisterFive = false
	SetVarValue(GetObjectiveID("Obj_W1"),"Active", false)
	SetVarValue(GetObjectiveID("Obj_W2"),"Active", true)
	end
	end
end

--[[ Initialise la variable de ctrl de la vie de Mister Five à true (ce ki permet de savoir ke le dialogue est fini et qu'on peut lancer le suivant --]]

function CtrlVieMisterFive()
	_bCtrlVieMisterFive = true
end

--[[ Disable les Cmd de MisterFive pdt les cinématiques s'il n'est pas mort --]]

function DisableCmdMisterFive()
	if (_idMerc[0] ~= nil) then 
		EnableCharacterCommand(_idMerc[0], false)
	end
end

--[[ Enable les Cmd de MisterFive après les cinématiques s'il n'est pas mort --]]

function EnableCmdMisterFive()
	if (_idMerc[0] ~= nil) then 
		EnableCharacterCommand(_idMerc[0], true)
	end
end