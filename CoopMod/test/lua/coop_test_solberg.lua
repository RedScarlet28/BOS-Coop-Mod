-- CoopMod dedicated-server experiment (COOP_Patrol): after the player enters
-- SE_Camp_1_S_02 (the cut-scene after the save station), General Solberg must
-- walk into that box to end it. Does he, in a multiplayer session?
-- Run by the proxy (test_lua) right before InitLevel.

-- presentation-only calls: the dedicated server has no animations, sound or camera
function CharacterPlaySpecialAction() end
function CharacterStopSpecialAction() end
function MakeCharacterSpeak() end
function LaunchCameraTransition() end
function ShowCinematicBlackStripes() end
function StartMusic() end
function StopMusic() end
function DisplayTips() end
function RadioMessage() end
function DisplaySubtitle() end
function SoundPrecache() end
-- per-frame mission logic needs a local player; not needed here
function UpdateLevel() end

Test_T = 0
Test_Exp1 = 0
Test_Exp2 = 0
-- his orders' ScriptedExpiration functions: called by the AI while the order is active
function ExpGen_Player()
	Test_Exp1 = Test_Exp1 + 1
	return _bSE_Camp_1_S_02 == true
end
function ExpGen_Player2()
	Test_Exp2 = Test_Exp2 + 1
	return _bEndSpeakGen == true
end

-- this Lua has no tostring
function Test_B(v)
	if v == nil then return "nil" end
	if v == true then return "true" end
	if v == false then return "false" end
	return "value " .. v
end

function OnMissionBegins()
	PrintDebug("[test] OnMissionBegins (test version)")
	_idMerc = {}
	-- what the intro (Debut_3) does for his group
	FreezeAll(_idGrp_WRF_Camp_1_3, false)
	Test_Tick()
end

function OnEnter_SE_Camp_1_S_02(id)
	local who = "another entity"
	if id == _idChar_WRF_Solberg_Camp_1 then who = "Solberg" end
	PrintDebug("[test] t=" .. Test_T .. " OnEnter_SE_Camp_1_S_02 by " .. who)
end

function Test_Trigger()
	PrintDebug("[test] t=" .. Test_T .. " player branch of OnEnter_SE_Camp_1_S_02: _bSE_Camp_1_S_02 = true")
	_bObj0_4 = true
	_bSE_Camp_1_S_02 = true
end

function Test_Tick()
	local p = GetVarValue(_idChar_WRF_Solberg_Camp_1, "Position")
	PrintDebug("[test] t=" .. Test_T .. " Solberg at " .. p:GetX() .. ", " .. p:GetY() ..
		" in S_02=" .. Test_B(IsEntityInBox(_idChar_WRF_Solberg_Camp_1, "SE_Camp_1_S_02")) ..
		" frozen=" .. Test_B(GetVarValue(_idChar_WRF_Solberg_Camp_1, "Freeze")) ..
		" ExpGen_Player calls=" .. Test_Exp1 .. " ExpGen_Player2 calls=" .. Test_Exp2)
	if Test_T == 30 then Test_Trigger() end
	Test_T = Test_T + 2
	if Test_T <= 100 then CreationTimer(true, true, false, "Test_Tick", 2.0) end
end

PrintDebug("[test] coop_test_solberg.lua loaded")
