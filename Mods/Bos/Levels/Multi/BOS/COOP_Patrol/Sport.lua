function InitLevel_Sport()

	_idChar_WRF_Camp_1_06_1=GetCharacterID("Char_WRF_Camp_1_06_1")
	_idChar_WRF_Camp_1_06_2=GetCharacterID("Char_WRF_Camp_1_06_2")
	_idChar_WRF_Camp_1_06_3=GetCharacterID("Char_WRF_Camp_1_06_3")
	_idChar_WRF_Camp_1_06_4=GetCharacterID("Char_WRF_Camp_1_06_4")
	_idChar_WRF_Camp_1_06_5=GetCharacterID("Char_WRF_Camp_1_06_5")
	_idChar_WRF_Camp_1_06_6=GetCharacterID("Char_WRF_Camp_1_06_6")
	_idChar_WRF_Camp_1_07_1=GetCharacterID("Char_WRF_Camp_1_07_1")

	_bOnEnter_SE_Camp_1_Sport_2 = 0
	_bOnEnter_SE_Camp_1_Sport_3 = 0
	_bCineSport = 0


	Sport_Chief ()

end


function UpdateLevel_Sport()
--	TestOnEnter_SE_Camp_1_Sport_2()
end


function OnEnter_SE_Camp_1_Sport (_idSE_Camp_1_Sport)
	if (_idSE_Camp_1_Sport ==_idPlayer) and (_bCtrlSE_Intro_Expl == false) then
		FreezeAll(GetGroupID("Grp_UAN_Camp_1_6"),false)
	end
end

function OnExit_SE_Camp_1_Sport (_idSE_Camp_1_Sport)
	if (_idSE_Camp_1_Sport ==_idPlayer) then
	--	FreezeAll(GetGroupID("Grp_UAN_Camp_1_6"),true)
	end
end



function Sport_Chief ()
	if (_bCtrlSE_Intro_Expl == false) and (_bCineSport == 0)then
		_nAnimationSport = GetRandom(1,7)
		if (_nAnimationSport == 1) then
			_StringAnimation = "STAND COMPLETE MILITARY_SALUT W_ALL_2HAND_LIGHT"
		elseif (_nAnimationSport == 2) then
			_StringAnimation = "STAND COMPLETE BOS HELLO_JUDOKA W_ALL_2HAND_LIGHT"
		elseif (_nAnimationSport == 3) then
			_StringAnimation = "STAND COMPLETE STRETCH_ITSELF W_NONE"
		elseif (_nAnimationSport == 4) then
			_StringAnimation = "STAND COMPLETE STRETCH_ITSELF W_ALL_2HAND"
		elseif (_nAnimationSport == 5) then
			_StringAnimation = "STAND COMPLETE LEG_REVIVE W_NONE"
		else
			_StringAnimation = "STAND COMPLETE BOS STRETCHING W_ALL_2HAND_LIGHT"
		end




		CharacterPlaySpecialAction(_idChar_WRF_Camp_1_07_1,_StringAnimation,false,false)
		CreationTimer(true, true, false, "Sport_01",GetFloatRandom(0.3,1.5))
		CreationTimer(true, true, false, "Sport_02",GetFloatRandom(0.3,1.5))
		CreationTimer(true, true, false, "Sport_03",GetFloatRandom(0.3,1.5))
		CreationTimer(true, true, false, "Sport_04",GetFloatRandom(0.3,1.5))
		CreationTimer(true, true, false, "Sport_05",GetFloatRandom(0.3,1.5))
		CreationTimer(true, true, false, "Sport_06",GetFloatRandom(0.3,1.5))


		CreationTimer(true, true, false, "Sport_Chief",GetFloatRandom(3.0,4.5))
		CreationTimer(true, true, false, "Speak_Chief",GetFloatRandom(0.5,1.5))
		CreationTimer(true, true, false, "Speak_Soldier",GetFloatRandom(1.6,2.0))
	end
end

function Speak_Chief()
	_nSpeakChief = GetRandom(1,6)
	if (_nSpeakChief == 1) and (_nSpeakChiefSecurity ~= 1) then
		MakeCharacterSpeak(_idChar_WRF_Camp_1_07_1,_idChar_WRF_Camp_1_06_2,"DIA_SPE_NIV_I_USWE_A_02",false,110,2,1,"",95)	
	elseif (_nSpeakChief == 2) and (_nSpeakChiefSecurity ~= 2) then
		MakeCharacterSpeak(_idChar_WRF_Camp_1_07_1,_idChar_WRF_Camp_1_06_2,"DIA_SPE_NIV_I_USWE_D_03",false,110,2,1,"",95)	
	elseif (_nSpeakChief == 3) and (_nSpeakChiefSecurity ~= 3) then
		MakeCharacterSpeak(_idChar_WRF_Camp_1_07_1,_idChar_WRF_Camp_1_06_2,"DIA_SPE_NIV_I_USWE_C_02",false,110,2,1,"",95)	
	elseif (_nSpeakChief == 4) and (_nSpeakChiefSecurity ~= 4) then
		MakeCharacterSpeak(_idChar_WRF_Camp_1_07_1,_idChar_WRF_Camp_1_06_2,"DIA_SPE_NIV_I_USWE_C_01",false,110,2,1,"",95)	
	else
		return
	end
	_nSpeakChiefSecurity = _nSpeakChief
end


function Speak_Soldier()
	if (_nSpeakChief <= 4)then
		_nSpeakSoldier = GetRandom(1,10)
		if (_nSpeakSoldier == 1) and (_nSpeakSoldierSecurity ~= 1) then
			MakeCharacterSpeak(_idChar_WRF_Camp_1_06_1,_idChar_WRF_Camp_1_07_1,"DIA_SPE_NIV_O_RESIS_E_01",false,110,2,1,"",95)	
		elseif (_nSpeakSoldier == 2) and (_nSpeakSoldierSecurity ~= 2) then
			MakeCharacterSpeak(_idChar_WRF_Camp_1_06_2,_idChar_WRF_Camp_1_07_1,"DIA_SPE_NIV_O_RESIS_F_01",false,110,2,1,"",95)	
		elseif (_nSpeakSoldier == 3) and (_nSpeakSoldierSecurity ~= 3) then
			MakeCharacterSpeak(_idChar_WRF_Camp_1_06_3,_idChar_WRF_Camp_1_07_1,"DIA_SPE_NIV_O_RESIS_E_01",false,110,2,1,"",95)	
		elseif (_nSpeakSoldier == 4) and (_nSpeakSoldierSecurity ~= 4) then
			MakeCharacterSpeak(_idChar_WRF_Camp_1_06_4,_idChar_WRF_Camp_1_07_1,"DIA_SPE_NIV_O_RESIS_F_01",false,110,2,1,"",95)	
		elseif (_nSpeakSoldier == 5) and (_nSpeakSoldierSecurity ~= 5) then
			MakeCharacterSpeak(_idChar_WRF_Camp_1_06_5,_idChar_WRF_Camp_1_07_1,"DIA_SPE_NIV_O_RESIS_E_01",false,110,2,1,"",95)	
		elseif (_nSpeakSoldier == 6) and (_nSpeakSoldierSecurity ~= 6) then
			MakeCharacterSpeak(_idChar_WRF_Camp_1_06_6,_idChar_WRF_Camp_1_07_1,"DIA_SPE_NIV_O_RESIS_F_01",false,110,2,1,"",95)	
		else
			return
		end
		_nSpeakSoldierSecurity = _nSpeakSoldier
	end
end



function Sport_01 ()
	CharacterPlaySpecialAction(_idChar_WRF_Camp_1_06_1,_StringAnimation,false,false)
end
function Sport_02 ()
	CharacterPlaySpecialAction(_idChar_WRF_Camp_1_06_2,_StringAnimation,false,false)
end
function Sport_03 ()
	CharacterPlaySpecialAction(_idChar_WRF_Camp_1_06_3,_StringAnimation,false,false)
end
function Sport_04 ()
	CharacterPlaySpecialAction(_idChar_WRF_Camp_1_06_4,_StringAnimation,false,false)
end
function Sport_05 ()
	CharacterPlaySpecialAction(_idChar_WRF_Camp_1_06_5,_StringAnimation,false,false)
end
function Sport_06 ()
	CharacterPlaySpecialAction(_idChar_WRF_Camp_1_06_6,_StringAnimation,false,false)
end


---------------------
----------------------

function OnEnter_SE_Camp_1_Sport_2 (_idSE_Camp_1_Sport_2)
	if (_idSE_Camp_1_Sport_2 ==_idChar_WRF_Camp_1_07_1) and (_bOnEnter_SE_Camp_1_Sport_2 == 0) then
		CreationTimer(true, true, false, "CineSport",1.5)
		_bCineSport = 1
		_bOnEnter_SE_Camp_1_Sport_2	= 1
	end
end


--function TestOnEnter_SE_Camp_1_Sport_2 ()
--	if (GetVarValue(_idChar_WRF_Camp_1_07_1,"Position") < 15)
--	and (_bOnEnter_SE_Camp_1_Sport_2 == 0) then
--		CreationTimer(true, true, false, "CineSport",1.5)
--		_bCineSport = 1
--		_bOnEnter_SE_Camp_1_Sport_2	= 1
--	end
--end



function CineSport()
	
		if (_idMerc[0] ~= nil) then 
				EnableCharacterCommand(_idMerc[0],false)
				Teletransportation("Character_Teleport4",_idMerc[0])
		end
		if (_idMerc[1] ~= nil) then 
				EnableCharacterCommand(_idMerc[1],false)
				Teletransportation("Character_Teleport5",_idMerc[1])
		end
		
		
		Teletransportation("Character_Teleport10",_idPlayer)
		Teletransportation("Character_Teleport11",_idChar_WRF_Camp_1_07_1)
		EnableCharacterCommand(_idPlayer,false)
		CharacterPlaySpecialAction(_idPlayer,"STAND COMPLETE WAIT W_NONE COOL",true,false)
		CharacterStopSpecialAction(_idChar_WRF_Camp_1_07_1)
		SetVarValue(_idChar_WRF_Camp_1_07_1,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Spe_Sport_01"))
		ShowCinematicBlackStripes(true)
		LaunchCameraTransition(GetCamTransitionID("CamTransition_Sport_A"))
end


function CineSport_End()
		ShowCinematicBlackStripes(false)
		if (_idMerc[0] ~= nil) then 
				EnableCharacterCommand(_idMerc[0],true)
		end
		if (_idMerc[1] ~= nil) then 
				EnableCharacterCommand(_idMerc[1],true)
		end
		EnableCharacterCommand(_idPlayer,true)
		CharacterStopSpecialAction(_idPlayer)
		CreationTimer(true, true, false, "CineSport_Reprise",13.0)	
end

function CineSport_Reprise()
	_bCineSport = 0
	Sport_Chief ()
end

function OnEnter_SE_Camp_1_Sport_3 (_idSE_Camp_1_Sport_3)
	if (_idSE_Camp_1_Sport_3 ==_idChar_WRF_Camp_1_07_1)
	and (_bOnEnter_SE_Camp_1_Sport_2 == 1) 
	and (_bOnEnter_SE_Camp_1_Sport_3 == 0) then
		CreationTimer(true, true, false, "CineSport_Anim_0",2.0)	
		_bOnEnter_SE_Camp_1_Sport_3	= 1
	end
end


function CineSport_Anim_0()
	MakeCharacterSpeak(_idChar_WRF_Camp_1_07_1,_idPlayer,"DIA_SPE_NIV_I_MERCE_A_01",true,120,2,1,"",95)	
	CreationTimer(true, true, false, "CineSport_Anim_1",2.5)	
end


function CineSport_Anim_1()
	CharacterPlaySpecialAction(_idChar_WRF_Camp_1_07_1,"STAND COMPLETE BOS NECK_CUT_QUICKLY W_ALL_2HAND_LIGHT",false,false)	
	CreationTimer(true, true, false, "CineSport_Anim_2",1.5)	
	CreationTimer(true, true, false, "CineSport_Anim_3",3.5)
end


function CineSport_Anim_2()
	SetVarValue(GetSound_ClientID("Sound_Client_Sport_Tuer"),"Playing",true)
end

function CineSport_Anim_3()
	SetVarValue(_idChar_WRF_Camp_1_07_1,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Spe_Sport_02"))
end
	
