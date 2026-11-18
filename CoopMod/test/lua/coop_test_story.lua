-- CoopMod dedicated-server test (COOP_Patrol): the story runs with no cut-scenes,
-- no dialogue and no NPC waits. The intro must reach the first objective by
-- itself; later story points are triggered as if the player walked into them.

-- the dedicated server has no animations and no HUD
function CharacterPlaySpecialAction() end
function CharacterStopSpecialAction() end
function UpdateLevel() end
function ShowNewObjective() end
function ShowNewSubObjective() end
function ShowObjectiveDone() end
function ActiveTrackingMercs() end
function DesactiveTrackingMercs() end
function EndOfPatrol_1() PrintDebug("[test] EndOfPatrol_1 -> EndOfLevel() would run now") end

function Test_B(v)
	if v == nil then return "nil" end
	if v == true then return "true" end
	if v == false then return "false" end
	return "value " .. v
end

local Test_Objective_0_1_Active = Objective_0_1_Active
function Objective_0_1_Active()
	PrintDebug("[test] intro finished: Objective_0_1_Active (first objective)")
	Test_Objective_0_1_Active()
end

Test_N = 0
function Test_Step()
	Test_N = Test_N + 1
	if Test_N == 1 then
		PrintDebug("[test] step 1: player arrives at the General (SE_Camp_1_S_02) after the save station")
		_bObj0_4 = true
		OnEnter_SE_Camp_1_S_02(_idPlayer)
	elseif Test_N == 2 then
		PrintDebug("[test] -> _bSE_Camp_1_S_02=" .. Test_B(_bSE_Camp_1_S_02) .. " _bGenDial=" .. Test_B(_bGenDial) .. " _bObj1_1=" .. Test_B(_bObj1_1))
		PrintDebug("[test] step 2: player arrives at the Caporal (SE_Camp_1_S_03)")
		OnEnter_SE_Camp_1_S_03(_idPlayer)
	elseif Test_N == 3 then
		PrintDebug("[test] -> _bSE_Cap=" .. Test_B(_bSE_Cap) .. " _bGoAccesNord=" .. Test_B(_bGoAccesNord))
		PrintDebug("[test] step 3: player arrives at the north access (SE_Intro_Expl)")
		OnEnter_SE_Intro_Expl(_idPlayer)
	elseif Test_N == 4 then
		PrintDebug("[test] -> _bCtrlSE_Intro_Expl=" .. Test_B(_bCtrlSE_Intro_Expl) .. " _bAssaultScene=" .. Test_B(_bAssaultScene))
		PrintDebug("[test] step 4: explosives picked up, player at the end (SE_EoL)")
		_bDejaRecup = true
		OnStay_SE_EoL(_idPlayer)
	else
		PrintDebug("[test] -> _bEndPatrol1=" .. Test_B(_bEndPatrol1))
		return
	end
	CreationTimer(true, true, false, "Test_Step", 6.0)
end

local Test_OnMissionBegins = OnMissionBegins
function OnMissionBegins()
	Test_OnMissionBegins()
	CreationTimer(true, true, false, "Test_Step", 12.0)
end
