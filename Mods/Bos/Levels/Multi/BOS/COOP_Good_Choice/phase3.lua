function ExplosadinResist()
--	Dialogue(true,4," :::: Explosion :::: ")
	idExplosion = CreateExplosion()
	SetVarValue(idExplosion,"Position",	Vector3D(-260.271362,104.434303,1.822787))
	SetVarValue(idExplosion,"Type","Explosion_Rocket_Bombardement")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_XPL_1"), "FxState", "Fx Started")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_XPL_2"), "FxState", "Fx Started")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_XPL_3"), "FxState", "Fx Started")
	CreationTimer(true, true, false, "ActivFX_FLM",0.5)
	DisableCharCmd()
	DisableCmdMisterFive()
	CamResist1()
	CreationTimer(true, true, false, "ArriveeResistants",1)
	SetVarValue(GetDestructible_ObjectID("Destructible_Object_Mur_Resist"),"Destroyed",true)
			Teletransportation("Repere_Player1",_idPlayer)
			if (_idMerc[0] ~= nil) then
				Teletransportation("Repere_Igor1",_idMerc[0])
			end
	SetVarValue(GetSound_ClientID("Sound_Client_Alarm"),"Playing",true)
end

function ActivFX_FLM()
	SetVarValue(GetParticleFX_ClientID("ParticleFX_FLM_2"), "FxState", "Fx Started")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_FLM_3"), "FxState", "Fx Started")
end

function ArriveeResistants()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_25
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_25",3)
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_25B", 3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_25", true,100,0,"DIA_SPE_NIV_M_COMMENT_RADIO_25B")

	CreationTimer(true, true, false, "SpawnResist", 2)
	FreezeAll(GetGroupID("Grp_Resist_1"), false)
	FreezeAll(GetGroupID("Grp_Resist_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Resistants_1_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Resistants_1_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Resistants_1_3"), false)
	EnableCharacterCommand(GetCharacterID("Char_Resistants_2_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Resistants_2_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Resistants_2_3"), false)
	EnableCharacterCommand(GetCharacterID("Char_Hoshaiming"), false)
	SetGodMode(GetCharacterID("Char_Hoshaiming"), true)
end


function DIA_SPE_NIV_M_COMMENT_RADIO_25B()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_25B
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_25_B",3)
	-- CreationTimer(true, true, false, "DIA_SPE_NIV_M_COMMENT_RADIO_25C", 2)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_25_B", true,100,0,"DIA_SPE_NIV_M_COMMENT_RADIO_25C")
end

function DIA_SPE_NIV_M_COMMENT_RADIO_25C()
	-- DIA_SPE_NIV_M_COMMENT_RADIO_25C
	-- DisplaySubtitle("DIA_SPE_NIV_M_COMMENT_RADIO_25_C",3)
	SpeakerMessage("DIA_SPE_NIV_M_COMMENT_RADIO_25_C", true,100,0,"")
end

function SpawnResist()
--	FreezeAll(GetGroupID("Grp_Syndic_Soldats_06"), false)
	CreationTimer(true, true, false, "AIOL_Resist_1a", 1)
	CreationTimer(true, true, false, "SpawnSyndic_1", 4)
end

-----------------------------------------------------------

--[[ Attribution des AIOL toutes les 0.3 secondes --]]

function AIOL_Resist_1a()
	CreationTimer(true, true, false, "AIOL_Resist_1b", 0.5)
	EnableCharacterCommand(GetCharacterID("Char_Resistants_1_1"), true)
	EnableCharacterCommand(GetCharacterID("Char_Resistants_2_1"), true)
	CreationTimer(true, true, false, "FireResist_1",2.5)
	CreationTimer(true, true, false, "FireResist_1b",1.5)
end
function AIOL_Resist_1b()
	CreationTimer(true, true, false, "AIOL_Resist_1c", 0.5)
	EnableCharacterCommand(GetCharacterID("Char_Resistants_1_2"), true)
	EnableCharacterCommand(GetCharacterID("Char_Resistants_2_2"), true)	
	CreationTimer(true, true, false, "FireResist_2",1)
	CreationTimer(true, true, false, "FireResist_2b",2)
end
function AIOL_Resist_1c()
--	CreationTimer(true, true, false, "AIOL_Resist_1d",5)
	EnableCharacterCommand(GetCharacterID("Char_Resistants_1_3"), true)
	EnableCharacterCommand(GetCharacterID("Char_Resistants_2_3"), true)
	CreationTimer(true, true, false, "FireResist_3",2)
	CreationTimer(true, true, false, "FireResist_3b",2.5)
end

function FireResist_1()
	SetVarValue(GetCharacterID("Char_Resistants_1_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Resist_1_1b"))
end
function FireResist_1b()
	SetVarValue(GetCharacterID("Char_Resistants_2_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Resist_2_1b"))
end

function FireResist_2()
	SetVarValue(GetCharacterID("Char_Resistants_1_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Resist_1_2b"))
end
function FireResist_2b()
	SetVarValue(GetCharacterID("Char_Resistants_2_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Resist_2_2b"))
end

function FireResist_3()
	SetVarValue(GetCharacterID("Char_Resistants_1_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Resist_1_3b"))
end
function FireResist_3b()
	SetVarValue(GetCharacterID("Char_Resistants_2_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Resist_2_3b"))
end

function SpawnSyndic_1()
	FreezeAll(GetGroupID("Grp_Syndic_Soldats_05"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_05_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_05_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_05_3"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_05_4"), false)
end

function AIOL_Syndic()
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_05_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Syndic_1b"))
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_05_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Syndic_2b"))
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_05_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Syndic_3b"))
	SetVarValue(GetCharacterID("Char_Syndic_Soldats_05_4"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Syndic_4b"))
end
------------------------------------------------------------

--[[ Attribution des AIOL toutes les 0.3 secondes --]]

function AIOL_Syndic_1a()
	CreationTimer(true, true, false, "AIOL_Syndic_1b", 0.5)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_05_1"), true)
end
function AIOL_Syndic_1b()
	CreationTimer(true, true, false, "AIOL_Syndic_1c", 0.5)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_05_2"), true)
end
function AIOL_Syndic_1c()
	CreationTimer(true, true, false, "AIOL_Syndic_1d",0.5)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_05_3"), true)
end
function AIOL_Syndic_1d()
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Soldats_05_4"), true)
end

function SpawnHangShaiming()
	CreationTimer(true, true, false, "DIA_SPE_NIV_M_SHAIMING_01",1)
	CamResist4()
end

function DIA_SPE_NIV_M_SHAIMING_01()
	-- DIA_SPE_NIV_M_SHAIMING_01
--	Dialogue(true,4,"Nolan suivez moi vite, nous n'avons ps beaucoup de temps ! Vite vite! Dépêchez vous !")
	-- DisplaySubtitle("DIA_SPE_NIV_M_SHAIMING_01",3)
	MakeCharacterSpeak(GetCharacterID("Char_Hoshaiming"),_idPlayer,"DIA_SPE_NIV_M_SHAIMING_01",true,100,2,2,"Win",100)

--	CreationTimer(true, true, false, "DIA_SPE_NIV_M_SHAIMING_02", 12)
--	Dialogue(true,4,":::: Objectif :::: \nRejoignez Hang Shaiming avant la fin du compte à rebour !")
--	CreationTimer(true, true, false, "TestGameOver", 30)
end
--[[
function DIA_SPE_NIV_M_SHAIMING_02()
		-- DIA_SPE_NIV_M_SHAIMING_02
--		Dialogue(true,4,"Vite ! Dépêchez vous ! Bougez-vous !")
	DisplaySubtitle("DIA_SPE_NIV_M_SHAIMING_02",3)
end
--]]

--[[ Nolan suit Hoshaiming --]]
--[[ 
function OnEnter_Sector_Event_ExplosedWall(id)
	if (id == _idPlayer and _bTestSortiePlayer == false) and (_bCtrlMortBoucher == true) then
		-- yo
		Dialogue(true,10,":::: MISSION ACCOMPLIE ::::")
		_bTestSortiePlayer = true
		_bTestGameOver = false
		EndOfLevel()
	end
end

function TestGameOver()
	if (_bTestGameOver == true) then
		Dialogue(true,4,":::: Game Over ::::")
	end
end
--]]

function Win()
	MissionSucceed()
	ShowCinematicBlackStripes(false)
	SetGodMode(_idPlayer,false)
end