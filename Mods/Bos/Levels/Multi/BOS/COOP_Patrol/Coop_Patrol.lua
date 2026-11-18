-- CoopMod: COOP_Patrol story triggers without waits - "go there, and it happens".
--
-- Loaded after the mission scripts (Level.def), so these replace the campaign
-- versions. The co-op layer (coop_mission.lua in the game folder) already skips
-- every camera sequence and line of dialogue; this file removes the places where
-- the story waited for an NPC to walk somewhere before it went on.
-- Lua 5.0, as the game ships it.

-- After the save station (objective "go to the General"): the General's scene
-- started only once General Solberg had walked into SE_Camp_1_S_02 behind the
-- player. Now it runs as soon as the player arrives.
local Coop_OnEnter_SE_Camp_1_S_02 = OnEnter_SE_Camp_1_S_02
function OnEnter_SE_Camp_1_S_02(id)
	Coop_OnEnter_SE_Camp_1_S_02(id)
	if id == _idPlayer and _bSE_Camp_1_S_02 and not _bGenDial then
		PrintDebug("[coop] General Solberg's briefing starts (no wait for him to walk up)")
		Coop_OnEnter_SE_Camp_1_S_02(_idChar_WRF_Solberg_Camp_1)
	end
end

-- North access: the attack on the camp (gate explosion, first wave) started when
-- the Caporal leading the player reached SE_Intro_Expl. Now the player reaching
-- it starts it too, and if neither has after 60 s, it starts anyway.
local Coop_OnEnter_SE_Intro_Expl = OnEnter_SE_Intro_Expl
function OnEnter_SE_Intro_Expl(id)
	if id == _idPlayer and _bGoAccesNord then
		id = GetCharacterID("Char_WRF_Camp_1_01_3")
	end
	Coop_OnEnter_SE_Intro_Expl(id)
end

local Coop_GoAccesNord = GoAccesNord
function GoAccesNord()
	local first = not _bGoAccesNord
	Coop_GoAccesNord()
	if first then
		CreationTimer(true, true, false, "Coop_StartAssault", 60.0)
	end
end

function Coop_StartAssault()
	if not _bCtrlSE_Intro_Expl then
		PrintDebug("[coop] the attack on the camp starts (60 s after the Caporal set off)")
		OnEnter_SE_Intro_Expl(GetCharacterID("Char_WRF_Camp_1_01_3"))
	end
end

-- End of the patrol: the level ended only if soldier Char_WRF_Trench_2_04_1 was
-- also standing in SE_Trench_2_S_02. Now the player alone ends it (with the
-- explosives picked up, as before).
function OnStay_SE_EoL(id)
	if id ~= _idPlayer then
		return
	end
	if _bDejaRecup and not _bEndPatrol1 then
		if IsAlive(_idChar_WRF_Trench_2_04_1) then
			_nHelmetCharWRF41 = GetVarValue(_idChar_WRF_Trench_2_04_1, "HelmetHitPoints")
			_nBodyCharWRF41 = GetVarValue(_idChar_WRF_Trench_2_04_1, "BodyHitPoints")
			_nLegsCharWRF41 = GetVarValue(_idChar_WRF_Trench_2_04_1, "LegsHitPoints")
			_nShieldCharWRF41 = GetVarValue(_idChar_WRF_Trench_2_04_1, "ShieldHitPoints")
		end
		PrintDebug("[coop] end of the patrol reached")
		SetVarValue(_idTimer_Trench_2_EoF, "Active", true)
		_bEndPatrol1 = true
	end
end

-- UpdateLevel waits for InitLevel (coop_mission.lua sets Coop_LevelReady right before it)
Coop_Orig = Coop_Orig or {}
Coop_LevelReady = false
if UpdateLevel ~= nil then Coop_Orig.UpdateLevel = UpdateLevel
	function UpdateLevel(a1, a2, a3) if Coop_LevelReady then return Coop_Orig.UpdateLevel(a1, a2, a3) end end end

-- dialogue: COOP_Patrol keeps it skipped (coop_mission.lua)
Coop_SkipDialogue = true
