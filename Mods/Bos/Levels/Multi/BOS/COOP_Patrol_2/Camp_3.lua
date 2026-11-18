function InitLevel_Camp_3()

	_bCtrlAliveChampion_0 = false
	_bBeginCombat=false
	_bPlayerBoSPasse = false
	_bBoSEnCours = false
	_bChampion_03_Reload = false
	_CrtActiveDesactiveMagneticSHield = false
	_bSpeedGrenade = false
	_bCtrlSE_Camp_3_BOS1 = false
	_bCtrlSE_Camp_3_BOS2 = false
	
end

function UpdateLevel_Camp_3()

		BoSfuite()
--		TestMortChampion()
		DeclencheBoS()
		ActiveDesactiveMagneticSHield()
		TestPositionPlayerBoS()
end


-------------------------------------------------------------
-- :::: CHAMPION ::::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

--[[ Défrise le Champion qd le Player entre dans l'event box --]]

function OnEnter_SE_Camp_3_F_01(_idSE_Camp_3_F_01)

	-- Si le player entre dans l'Event_Box et que le Champion n'est pas déjà défrisé
	if (_idSE_Camp_3_F_01==_idPlayer) and not _bChampion_defreeze then


	end
end

function DeclencheBoS()
	_bDoorBoSOpened = IsDoorOpened(GetDoorID("Door_BoS"))
	if ((_bDoorBoSOpened == true) and (_bPlayerBoSPasse == false)) then
				-- Si un Champion a bien été sélectionné
				if (_idChampion_0 ~= nil) then 

					if (_idChampion_0 == GetCharacterID("Char_Champion_0_2")) then
						ShowCinematicBlackStripes(true)
						LaunchCameraTransition(GetCamTransitionID("CamTransition_BoS_Passerelle"))
						EnableCharacterCommand(_idChampion_0, true)	
					else
								-- Lance la séquence d'introduction du B.O.S
							LaunchBOS(0,"SetUp_BoS","WarmUpBOS", "CombatBOS", "BOS_End", "BOS_Lost","BOS_TimeOut")
							g_bBoSEnCours = true
					end
				end

				_bPlayerBoSPasse = true
		end

end

function LanceBoSPasserelle()
	-- Lance la séquence d'introduction du B.O.S
	LaunchBOS(0,"SetUp_BoS","WarmUpBOS", "CombatBOS", "BOS_End", "BOS_Lost","BOS_TimeOut")
	g_bBoSEnCours = true
	SetVarValue(_idChampion_0,"CharacterAI",GetCharacter_AIID("Patrol_Char_AI_Champion_0_2"))
--	EnableCharacterCommand(_idChampion_0,false)	
	Teletransportation("Repere_BoS_Passerelle",_idChampion_0)
	ShowCinematicBlackStripes(false)
end

function SetUp_BoS()

							-- Déclare que le Champion est défrisé
							_bChampion_defreeze = true

					CloseDoor(GetDoorID("Door_BoS"))
					LockDoor(GetDoorID("Door_BoS"))
					LockDoor(GetDoorID("Door_Mordor_1"))

					-- Télétransportation des Mercs en zone "sécurisée"
					Teletransportation("Char_Champion_0_Repere_Player",_idPlayer)

					EnableCharacterFire(_idPlayer, false)


				-- Si le 1er membre de la liste correspond à une entité valide (donc s'il reste 1 mercenaire en vie au moins)
				if (_idMerc[0] ~= nil) then 

							-- Télétransportation des Mercs en zone "sécurisée"
							Teletransportation("Char_Champion_0_Repere_Merc1",_idMerc[0])

							-- Disable les cmd du Merc[0]
							EnableCharacterCommand(_idMerc[0], false)

							-- Crée un Forbid Target pour que le Champion ne tire pas sur le Merc[0]
							_idFT_0 = CreateAI_Order_Forbid_Target()
							SetVarValue(_idFT_0,"Target",_idMerc[0])
							SetVarValue(_idFT_0,"PriorityTorso",100)

				end

				-- Si le 2ème membre de la liste correspond à une entité valide (donc si les 2 mercenaires sont en vie)
				if (_idMerc[1] ~= nil) then 

							-- Télétransportation des Mercs en zone "sécurisée"
							Teletransportation("Char_Champion_0_Repere_Merc2",_idMerc[1])

							-- Disable les cmd du Merc 1
							EnableCharacterCommand(_idMerc[1], false)

							-- Crée un Forbid Target pour que le Champion ne tire pas sur le mercenaire
							_idFT_1 = CreateAI_Order_Forbid_Target()
							SetVarValue(_idFT_1,"Target",_idMerc[1])
							SetVarValue(_idFT_1,"PriorityTorso",100)

				end
end

function WarmUpBOS()
--	if (_idChampion_0 == GetCharacterID("Char_Champion_0_2")) then
	--	SetVarValue(_idChampion_0, "CharacterOrderList", GetAI_Order_ListID("AIOL_Champion_02_WarmUp"))
		EnableCharacterCommand(_idChampion_0, false)
		_bBoSEnCours = true
--	end
end

function CombatBOS()

--		MakeCharacterSpeak(_idChampion_0,_idPlayer,"DIA_SPE_BOS_01_HELLO",true,110,2,1,"",100)
		_bBeginCombat = true
		

	if (_idChampion_0 == GetCharacterID("Char_Champion_0_2")) then
		SetVarValue(_idChampion_0, "CharacterOrderList", GetAI_Order_ListID("AIOL_Champion_02_Combat"))
		CreationTimer(true, true, false, "RandomThrowGrenade",20)
	end

	if (_idChampion_0 == GetCharacterID("Char_Champion_0_1")) then
		SetVarValue(_idChampion_0, "CharacterOrderList", GetAI_Order_ListID("AIOL_Champion_01_Combat"))
	end

	if (_idChampion_0 == GetCharacterID("Char_Champion_0_3")) then
--		SetVarValue(_idChampion_0, "CharacterOrderList", GetAI_Order_ListID("AIOL_Champion_01_Combat"))
	end

		EnableCharacterCommand(_idChampion_0, true)
		SetGodMode(_idChampion_0, false)
		EnableCharacterFire(_idPlayer, true)
end


function OnEnter_SE_BoS_Passerelle(id)
	if (id == _idPlayer) then
		-- Défrise le Champion sélectionné
		Freeze(_idChampion_0, false)
		EnableCharacterCommand(_idChampion_0, false)
		UnLockDoor(GetDoorID("Door_BoS"))
		SetGodMode(_idChampion_0, true)
	end
end


function BOS_End()
	SetVarValue(GetTV_Camera_ClientID("TV_Camera_Client-18"),"TrackedCharacter",_idPlayer)
	g_bBoSEnCours = false
	_bCtrl_SE_Mordor_Cine_1 = false
	OpenDoor(GetDoorID("Door_BoS"))
	UnLockDoor(GetDoorID("Door_BoS"))
	UnLockDoor(GetDoorID("Door_Mordor_1"))
	_bBoSEnCours = false
	_bSpeedGrenade = false

	if (_idMerc[0] ~= nil) then 

					-- Enable les cmd du Merc 0
				EnableCharacterCommand(_idMerc[0], true)

		end
		if (_idMerc[1] ~= nil) then 

				-- Enable les cmd du Merc 1
				EnableCharacterCommand(_idMerc[1], true)
		end

		-- Enable les cmd des bots avoisinants
		if IsAlive(_idChar_UAN_Camp_2_05_1) then
					EnableCharacterCommand(_idChar_UAN_Camp_2_05_1, true)
		end
		if IsAlive(_idChar_UAN_Camp_2_05_2) then
					EnableCharacterCommand(_idChar_UAN_Camp_2_05_2, true)
		end
		if IsAlive(_idChar_UAN_Camp_2_06_1) then
					EnableCharacterCommand(_idChar_UAN_Camp_2_06_1, true)
		end
		if IsAlive(_idChar_UAN_Camp_2_06_2) then
					EnableCharacterCommand(_idChar_UAN_Camp_2_06_2, true)
		end
		if IsAlive(_idChar_UAN_Camp_2_06_3) then
					EnableCharacterCommand(_idChar_UAN_Camp_2_06_3, true)
		end
end

function BOS_Lost()
	MissionFailed ("HUD_MISSION_FAILED_REASON_01")
end


function BOS_TimeOut()
	SetVarValue(GetTV_Camera_ClientID("TV_Camera_Client-18"),"TrackedCharacter",_idPlayer)
	Freeze(_idChampion_0, true)
end



function ActiveDesactiveMagneticSHield()
--_idChampion_0 == GetCharacterID("Char_Champion_0_3")
--[[
	if (_idChampion_0 == GetCharacterID("Char_Champion_0_3")) then

		_bChampion_03_Reload = GetIsReloading(_idChampion_0)

		if ((_bChampion_03_Reload == true) and (_bBoSEnCours == true)) then
			SetVarValue(GetPlug_MagneticShieldID("Plug_MShield_Champion_0_3"),"Active", false)
			_CrtActiveDesactiveMagneticSHield = false
		end

		if ((_bChampion_03_Reload == false) and (_bBoSEnCours == true) and (_CrtActiveDesactiveMagneticSHield == false)) then
			SetVarValue(GetPlug_MagneticShieldID("Plug_MShield_Champion_0_3"),"Active", true)
			_CrtActiveDesactiveMagneticSHield = true
		end
	end
--]]
end

function RandomThrowGrenade()
	if (_bSpeedGrenade == true) then
		SetVarValue(GetCharacter_AIID("Patrol_Char_AI_Champion_0_2"),"ThrowGrenadeRetryTime",0)
		_bSpeedGrenade = false
		if (_bBoSEnCours == true) then
			CreationTimer(true, true, false, "RandomThrowGrenade",20)
		end
	else
		SetVarValue(GetCharacter_AIID("Patrol_Char_AI_Champion_0_2"),"ThrowGrenadeRetryTime",-1)
		_bSpeedGrenade = true
		if (_bBoSEnCours == true) then
			CreationTimer(true, true, false, "RandomThrowGrenade",8)
		end
	end
end

function OnEnter_SE_Camp_3_BOS_OUT(id)
	if (id == _idPlayer) then
		_bPlayerBoS_OUT = true

	end
end

function OnEnter_SE_Camp_3_BOS_IN(id)
	if (id == _idPlayer) then
		_bPlayerBoS_OUT = false
	end
end

function TestPositionPlayerBoS()
	if ((_bPlayerBoS_OUT == true) and (_bCtrlSE_Camp_3_BOS1 == false)) then
		if (_idChampion_0 == GetCharacterID("Char_Champion_0_2")) then
	--		SetVarValue(_idChampion_0, "CharacterOrderList",GetAI_Order_ListID("AIOL_Champion_02_Combatb"))

		end
		if (_idChampion_0 == GetCharacterID("Char_Champion_0_1")) then
			SetVarValue(_idChampion_0, "CharacterOrderList",GetAI_Order_ListID("AIOL_BoS_FA"))
		end
		if (_idChampion_0 == GetCharacterID("Char_Champion_0_3")) then
	--		SetVarValue(_idChampion_0, "CharacterOrderList",GetAI_Order_ListID("AIOL_BoS_FA"))
		end
		_bCtrlSE_Camp_3_BOS1 = true
		_bCtrlSE_Camp_3_BOS2 = false
	end

	if ((_bPlayerBoS_OUT == false) and (_bCtrlSE_Camp_3_BOS2 == false)) then
		if (_idChampion_0 == GetCharacterID("Char_Champion_0_2")) then
	--		SetVarValue(_idChampion_0, "CharacterOrderList",GetAI_Order_ListID("AIOL_Champion_02_Combat"))
		end
		_bCtrlSE_Camp_3_BOS2 = true
		_bCtrlSE_Camp_3_BOS1 = false
	end
end
-------------------------------------------------------------
-------------------------------------------------------------





--------------------- Fonctions d'expiration d'ordres ------------------

function ExpLimit_Zone_Char_Chp_Camp_3()
		if GetArmorGlobalHPPct(_idChampion_0)<=20 then 
				return true
		end
		return false
end


function ExpForbid_Zone_Char_Chp_Camp_3(_idCharZone)

		if (_idCharZone==_idChampion_0) and ((GetArmorGlobalHPPct(_idChampion_0)<=50 or GetArmorPartHPPct(_idChampion_0,"Body")<=30) or (BetIsInCombat() and BetTimeLeftInPhase() <= 20.0)) then
				_bFuiteBoS=true
				return true
		end

		if (_idChampion_0 ~= nil) and not IsFrozen(_idChampion_0) and not IsAlive(_idChampion_0) then
				return true
		end	
	
		return false

end



function ExpWarningBOS()
		if _bBeginCombat then 
				return true
		end
		return false
end

--------------------- Fonctions diverses -------------------------------


function BoSfuite()

		if 	_bFuiteBoS and not _bFuiteBOSEnd then
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_Chp_Camp_3_2"),"PriorityLegs", 40)
--				DisplaySubtitle("Viens donc un peu par là...",2,2)
				--MakeCharacterSpeak(_idChampion_0,_idPlayer,"DIA_SPE_NIV_D_BOS_A_01",true,120,2,1,"",100)
				_bFuiteBOSEnd=true
		end

end



function Mordor_1()

		LaunchCameraTransition(GetCamTransitionID("CamTransition-63"))

end



function Mordor_2()

		LaunchCameraTransition(GetCamTransitionID("CamTransition-64"))

end



function Mordor_3()

		LaunchCameraTransition(GetCamTransitionID("CamTransition-65"))

end



function Mordor_4()

	--	ReleaseEntity(GetVolumeGlow_ClientID("VolumeGlow_Mordor"))
		LaunchCameraTransition(GetCamTransitionID("CamTransition-67"))
	--	ShowCinematicBlackStripes(true)
end

function OffBlackStripesMordor()
		
end

function Mordor_5()

		ExplosionCamp_4_Cin()
		LaunchCameraTransition(GetCamTransitionID("CamTransition-66"))

end



function Mordor_6()
--[[
		SetVarValue(GetCharacterID("Char_WRF_Camp_4_1"),"Health",5)
		--ExplosionCamp_4()

		-- Si le 1er membre de la liste correspond à une entité valide (donc s'il reste 1 mercenaire en vie au moins)
		if (_idMerc[0] ~= nil) and IsAlive(_idMerc[0]) and not IsFrozen(_idMerc[0]) then 
				MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_D_MERCE_B_02",true,120,1,2,"",100)
		elseif (_idMerc[1] ~= nil) and IsAlive(_idMerc[1]) and not IsFrozen(_idMerc[1]) then 
				MakeCharacterSpeak(_idMerc[1],_idPlayer,"DIA_SPE_NIV_D_MERCE_B_02",true,120,1,2,"",100)
		end
--]]
		LaunchCameraTransition(GetCamTransitionID("CamTransition-68"))

end


function Mordor_7()
--[[
		EnableCharacterCommand(_idPlayer,true)
		if (_idMerc[0] ~= nil) then 
				EnableCharacterCommand(_idMerc[0],true)
		end
		if (_idMerc[1] ~= nil) then 
				EnableCharacterCommand(_idMerc[1],true)
		end
		SetVarValue(GetTimerID("Timer_Camp_4_Welcome"),"Active",true)

-- Fin du GodMode pour les bots de l'intro. -
		SetGodMode(_idChar_WRF_Camp_4_01_2,false)

		SetGodMode(_idChar_UAN_Camp_4_01_1,false)
		SetGodMode(_idChar_UAN_Camp_4_01_2,false)
		SetGodMode(_idChar_UAN_Camp_4_01_5,false)
		SetGodMode(_idChar_UAN_Camp_4_01_7,false)
		SetGodMode(_idChar_UAN_Camp_4_01_8,false)
---------------------------------------------
--]]
	
	EnableCharacterCommand(_idPlayer,true)
	NewSubObjective("Obj_C_1","Obj_C_2")
	ShowCinematicBlackStripes(false)
end



function Accueil()

		if IsAlive(_idChar_UAN_Camp_4_01_5) and not IsFrozen(_idChar_UAN_Camp_4_01_5) then
				MakeCharacterSpeak(_idChar_UAN_Camp_4_01_5,GetInvalidEntityID(),"DIA_SPE_NIV_D_UAN_A_02",true,130,2,2,"",100)
		end
		_bRevers=true


end


function WarningBOS()

		--EnableCharacterCommand(_idChampion_0,false)

end


