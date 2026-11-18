-- CoopMod: COOP_Patrol_2 adjustments for the co-op session (loaded after the mission scripts).
-- Lua 5.0, as the game ships it. The co-op layer (coop_mission.lua in the game folder) skips
-- camera sequences and dialogue and provides Coop_IsHuman / Coop_TeleportHumans / Coop_AllowMove.
--
-- Champion fight (BOS): the champion is Master Loa (Debug.lua: Debug_GetSelectedChampions; the
-- proxy runs the solo "level without a mission" BOS setup, so GetChampionFromArea(0) returns
-- Char_Champion_0_3). The fight starts when Door_BoS opens (DeclencheBoS, Camp_3.lua); SetUp_BoS
-- closes and locks the arena doors and moves the player in. In co-op every player is moved in,
-- the host too (the co-op layer otherwise never moves the host), so nobody is locked out.

local Coop2_SetUp_BoS = SetUp_BoS
function SetUp_BoS()
	PrintDebug("[coop] champion fight: set-up (arena doors close, players move in)")
	Coop2_InCombat = false
	Coop2_BosEndDone = false
	Coop_AllowMove = true
	Coop2_SetUp_BoS()
	if Coop_TeleportHumans then
		Coop_TeleportHumans({ "Char_Champion_0_Repere_Player", "Char_Champion_0_Repere_Merc1", "Char_Champion_0_Repere_Merc2" })
	end
	Coop_AllowMove = false
end

local Coop2_WarmUpBOS = WarmUpBOS
function WarmUpBOS()
	PrintDebug("[coop] champion fight: warm-up")
	Coop2_WarmUpBOS()
end

local Coop2_CombatBOS = CombatBOS
function CombatBOS()
	if Coop2_InCombat then return end	-- the engine announced combat twice in the 0.43 run
	PrintDebug("[coop] champion fight: combat")
	Coop2_InCombat = true
	Coop2_CombatBOS()
	if Coop_BOS_StartExtras then Coop_BOS_StartExtras(0) end	-- /champions 2-3: Loa's rivals join in
end

local Coop2_BOS_End = BOS_End
function BOS_End()
	if Coop2_BosEndDone then return end
	Coop2_BosEndDone = true
	Coop2_InCombat = false
	if Coop_BOS_FreezeExtras then Coop_BOS_FreezeExtras(0) end
	PrintDebug("[coop] champion fight won: the arena doors open")
	Coop2_BOS_End()
end

-- In co-op the engine never ends the fight when the champion dies (its win sequence is solo-only
-- code: 0.41-0.43 runs, Loa down but BOS_End never called, doors locked, story stuck). Coop_Tick
-- (once a second on the host) checks it here and ends the fight the solo way.
function Coop_LevelTick()
	if Coop2_InCombat and not Coop2_BosEndDone and _idChampion_0 ~= nil and not IsAlive(_idChampion_0)
	   and (Coop_BOS_ExtrasAlive == nil or Coop_BOS_ExtrasAlive(0) == 0) then
		PrintDebug("[coop] the champion is dead - ending the fight (BOS_End)")
		BOS_End()
	end
end

local Coop2_BOS_Lost = BOS_Lost
function BOS_Lost()
	if Coop2_BosEndDone then PrintDebug("[coop] BOS_Lost after the fight was won - ignored") return end
	PrintDebug("[coop] champion fight lost: mission failed (the level restarts)")
	Coop2_BOS_Lost()
end

local Coop2_BOS_TimeOut = BOS_TimeOut
function BOS_TimeOut()
	if Coop2_BosEndDone then PrintDebug("[coop] BOS_TimeOut after the fight was won - ignored") return end
	PrintDebug("[coop] champion fight: time out")
	if Coop_BOS_FreezeExtras then Coop_BOS_FreezeExtras(0) end
	Coop2_BOS_TimeOut()
end

-- the walkway into the arena unlocked the door only for the host; any player opens it now
local Coop2_OnEnter_SE_BoS_Passerelle = OnEnter_SE_BoS_Passerelle
function OnEnter_SE_BoS_Passerelle(id)
	if Coop_IsHuman and Coop_IsHuman(id) and id ~= _idPlayer then
		PrintDebug("[coop] a player reached the arena walkway")
		id = _idPlayer
	end
	Coop2_OnEnter_SE_BoS_Passerelle(id)
end

-- UpdateLevel waits for InitLevel (coop_mission.lua sets Coop_LevelReady right before it)
Coop_Orig = Coop_Orig or {}
Coop_LevelReady = false
if UpdateLevel ~= nil then Coop_Orig.UpdateLevel = UpdateLevel
	function UpdateLevel(a1, a2, a3) if Coop_LevelReady then return Coop_Orig.UpdateLevel(a1, a2, a3) end end end

-- dialogue is spoken in this level (coop_mission.lua)
Coop_SkipDialogue = false
