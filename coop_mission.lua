-- CoopMod: co-op layer for campaign missions hosted as multiplayer levels.
--
-- The proxy (Bos.dll) runs this file on the host, in the level's script state,
-- right before it calls the level's InitLevel. Lua 5.0 as the game ships it:
-- there is no tostring, and entity ids are userdata (compare them, never print
-- them). Output appears in coop_logs as "[lua print] [coop] ...".
--
-- 1. No cut-scenes (CoopCine_Skip = true):
--    - camera sequences (LaunchCameraTransition) are not played; the
--      sequence's CompletionCallback - the next story step - runs at once;
--    - (only with Coop_SkipDialogue, COOP_Patrol) dialogue (MakeCharacterSpeak, RadioMessage) is not spoken; its
--      callback runs at once;
--    - the black bars never show, and the host is never locked, held in a
--      pose or teleported to a staged position.
--    Callbacks run through a 0.1 s timer, after the script that started the
--    sequence has finished, as they would after a real sequence.
-- 2. Safety net: when the black bars are on, or the host's controls are
--    locked, while no camera sequence runs for CoopCine_ReleaseAfter seconds,
--    the host is released. The proxy calls Coop_Tick(camera mode) once a
--    second; camera mode 6 is a running camera sequence. (With CoopCine_Skip
--    nothing should ever hold the host.)

CoopCine_Skip = true
-- dialogue (MakeCharacterSpeak, RadioMessage) is spoken unless the level's Coop_<Level>.lua sets
-- Coop_SkipDialogue = true (COOP_Patrol); every Coop_<Level>.lua sets it on load, so it never carries over
CoopDialogue_Skip = (Coop_SkipDialogue == true)
CoopCine_ReleaseAfter = 45
CoopCine_Stripes = false
CoopCine_Locked = false
CoopCine_Idle = 0
CoopCine_LastName = "(none)"

-- run the named script function shortly, from a timer (CreationTimer: Script\globals.lua)
local function Coop_Later(callback)
	if callback ~= nil and callback ~= "" then
		CreationTimer(true, true, false, callback, 0.1)
	end
end

local function Coop_Then(callback)
	if callback ~= nil and callback ~= "" then
		return " -> " .. callback
	end
	return ""
end

local function Coop_IsHost(id)
	return _idPlayer ~= nil and id == _idPlayer
end

-- 3. Every player: Coop_Humans (set by the proxy once a second) holds the human players'
--    character names. Coop_IsHuman(id) is true for any of them; level scripts use it where
--    the campaign only checked the host.
Coop_Humans = Coop_Humans or {}
function Coop_IsHuman(id)
	if id == nil then return false end
	if Coop_IsHost(id) then return true end
	local i = 1
	while Coop_Humans[i] ~= nil do
		if GetCharacterID(Coop_Humans[i]) == id then return true end
		i = i + 1
	end
	return false
end

-- Coop_AllowMove: a level script may move the host (e.g. into a champion's arena) while it is true.
Coop_AllowMove = false

local Coop_GetCamTransitionID = GetCamTransitionID
function GetCamTransitionID(name)
	CoopCine_LastName = name
	return Coop_GetCamTransitionID(name)
end

local Coop_LaunchCameraTransition = LaunchCameraTransition
function LaunchCameraTransition(id)
	if CoopCine_Skip then
		local callback = GetVarValue(id, "CompletionCallback")
		PrintDebug("[coop] skipped camera sequence " .. CoopCine_LastName .. Coop_Then(callback))
		Coop_Later(callback)
		return
	end
	PrintDebug("[coop] camera sequence " .. CoopCine_LastName)
	CoopCine_Idle = 0
	return Coop_LaunchCameraTransition(id)
end

local Coop_ShowCinematicBlackStripes = ShowCinematicBlackStripes
function ShowCinematicBlackStripes(on)
	if CoopCine_Skip then
		CoopCine_Stripes = false
		return
	end
	if on then
		PrintDebug("[coop] black stripes on (last camera sequence " .. CoopCine_LastName .. ")")
	else
		PrintDebug("[coop] black stripes off")
	end
	CoopCine_Stripes = on
	CoopCine_Idle = 0
	return Coop_ShowCinematicBlackStripes(on)
end

local Coop_EnableCharacterCommand = EnableCharacterCommand
function EnableCharacterCommand(id, on)
	if Coop_IsHost(id) then
		if CoopCine_Skip and not on then
			return
		end
		if on then
			PrintDebug("[coop] host controls back")
		else
			PrintDebug("[coop] host controls locked (last camera sequence " .. CoopCine_LastName .. ")")
		end
		CoopCine_Locked = not on
		CoopCine_Idle = 0
	end
	return Coop_EnableCharacterCommand(id, on)
end

local Coop_MakeCharacterSpeak = MakeCharacterSpeak
function MakeCharacterSpeak(who, to, line, a, priority, b, c, callback, chance)
	if CoopDialogue_Skip then
		-- only lines the story waits on are logged (ambient chatter would flood the log)
		if callback ~= nil and callback ~= "" then
			PrintDebug("[coop] skipped dialogue " .. line .. Coop_Then(callback))
		end
		Coop_Later(callback)
		return
	end
	return Coop_MakeCharacterSpeak(who, to, line, a, priority, b, c, callback, chance)
end

local Coop_RadioMessage = RadioMessage
function RadioMessage(line, a, priority, b, callback)
	if CoopDialogue_Skip then
		PrintDebug("[coop] skipped radio message " .. line .. Coop_Then(callback))
		Coop_Later(callback)
		return
	end
	return Coop_RadioMessage(line, a, priority, b, callback)
end

-- the host is never held in a cut-scene pose or moved to a staged position
local Coop_CharacterPlaySpecialAction = CharacterPlaySpecialAction
function CharacterPlaySpecialAction(id, action, a, b)
	if CoopCine_Skip and Coop_IsHost(id) then
		return
	end
	return Coop_CharacterPlaySpecialAction(id, action, a, b)
end

local Coop_Teletransportation = Teletransportation
function Teletransportation(marker, id)
	if CoopCine_Skip and not Coop_AllowMove and Coop_IsHost(id) then
		return
	end
	return Coop_Teletransportation(marker, id)
end

local Coop_TeleportCharacter = TeleportCharacter
function TeleportCharacter(id, position, rotation)
	if CoopCine_Skip and not Coop_AllowMove and Coop_IsHost(id) then
		return
	end
	return Coop_TeleportCharacter(id, position, rotation)
end

local Coop_SetVarValue = SetVarValue
function SetVarValue(id, var, value)
	if CoopCine_Skip and not Coop_AllowMove and (var == "Position" or var == "Rotation") and Coop_IsHost(id) then
		return
	end
	return Coop_SetVarValue(id, var, value)
end

-- Move the host to the first marker (where the campaign moves the player into a locked area).
-- 0.65b: the other players are never moved. A teleport reaches a client only through a resync,
-- which leaves the client's own character half-moved (frozen camera, a resync every ~4 s); they
-- walk in themselves, and the set-up leaves the doors open for them (CloseDoor/LockDoor below).
function Coop_TeleportHumans(markers)
	if _idPlayer ~= nil then
		Coop_Teletransportation(markers[1], _idPlayer)
		PrintDebug("[coop] moved the host to " .. markers[1] .. " (other players are not teleported - they walk in)")
	end
end

-- during a champion set-up (Coop_AllowMove) the arena doors are not closed or locked, so players
-- who were not teleported can still get in
local Coop_CloseDoor = CloseDoor
function CloseDoor(id, a, b)
	if Coop_AllowMove then PrintDebug("[coop] set-up: door left open for the other players") return end
	return Coop_CloseDoor(id, a, b)
end
local Coop_LockDoor = LockDoor
function LockDoor(id, a, b)
	if Coop_AllowMove then return end
	return Coop_LockDoor(id, a, b)
end

-- 3b. Champion fights (BOS) in the generated Coop_<Level>.lua files (make_coop_level.py), the
--     COOP_Patrol_2 rules for any level: set-up may move the host and brings the other players
--     along, combat runs once, the win runs once - also when the champion dies, which the engine
--     never reports in MP - and lost / time-out are ignored once the fight is won.
Coop_BOSState = {}
local function Coop_BOS(a)
	if Coop_BOSState[a + 1] == nil then Coop_BOSState[a + 1] = { combat = false, done = false } end
	return Coop_BOSState[a + 1]
end
-- 3c. Several champions at once (/champions 1-3, proxy 0.61): a level's scene has every champion of
--     an arena (Char_Champion_<arena>_<n>) and solo activates only the chosen one. The extras are
--     brought next to it and let loose when the combat starts, and the fight is won when all are dead.
Coop_ChampionCount = Coop_ChampionCount or 1
Coop_BOSExtras = {}
local function Coop_ValidID(id) return id ~= nil and id ~= GetInvalidEntityID() end
function Coop_BOS_Candidates(a)
	local main = GetChampionFromArea(a)
	local out, n, k = {}, 0, 0
	while k <= 6 do
		local id = GetCharacterID("Char_Champion_" .. a .. "_" .. k)
		if Coop_ValidID(id) and id ~= main and IsAlive(id) then n = n + 1 out[n] = id end
		k = k + 1
	end
	return out, n
end
function Coop_BOS_StartExtras(a)
	Coop_BOSExtras[a + 1] = {}
	if Coop_ChampionCount == nil or Coop_ChampionCount <= 1 then return end
	local main = GetChampionFromArea(a)
	if not Coop_ValidID(main) then return end
	local list, n = Coop_BOS_Candidates(a)
	local p = GetVarValue(main, "Position")
	local r = GetVarValue(main, "Rotation")
	-- spread sideways: across the line from the champion to the arena's player marker (the arena's
	-- long axis), 2 m to the left, then 2 m to the right; no marker -> along x. No math library: Newton sqrt.
	local sx, sy = 1.0, 0.0
	local mk = GetCharacterID("Char_Champion_" .. a .. "_Repere_Player")
	if Coop_ValidID(mk) then
		local q = GetVarValue(mk, "Position")
		local dx, dy = q:GetX() - p:GetX(), q:GetY() - p:GetY()
		local d2 = dx * dx + dy * dy
		if d2 > 1.0 then
			local d, k = d2, 0
			while k < 20 do d = 0.5 * (d + d2 / d) k = k + 1 end
			sx, sy = -dy / d, dx / d
		end
	end
	local i, used = 1, 0
	while i <= n and used < Coop_ChampionCount - 1 do
		local id = list[i]
		used = used + 1
		local side = 2.0
		if used == 2 then side = -2.0 end
		Coop_TeleportCharacter(id, p + Vector3D(sx * side, sy * side, 0.5), r)
		Freeze(id, false)
		EnableCharacterCommand(id, true)
		EnableCharacterFire(id, true)
		Coop_BOSExtras[a + 1][used] = id
		i = i + 1
	end
	PrintDebug("[coop] champion fight " .. a .. ": " .. (used + 1) .. " champion(s) at once (" .. n .. " extra in this arena)")
end
function Coop_BOS_ExtrasAlive(a)
	local t = Coop_BOSExtras[a + 1]
	if t == nil then return 0 end
	local i, n = 1, 0
	while t[i] ~= nil do if IsAlive(t[i]) then n = n + 1 end i = i + 1 end
	return n
end
function Coop_BOS_FreezeExtras(a)
	local t = Coop_BOSExtras[a + 1]
	if t == nil then return end
	local i = 1
	while t[i] ~= nil do if IsAlive(t[i]) then Freeze(t[i], true) end i = i + 1 end
end

function Coop_BOS_Setup(a)
	Coop_BOSState[a + 1] = { combat = false, done = false }
	PrintDebug("[coop] champion fight " .. a .. ": set-up (players are brought into the arena)")
end
function Coop_BOS_Combat(a)
	local s = Coop_BOS(a)
	if s.combat or s.done then return false end
	s.combat = true
	PrintDebug("[coop] champion fight " .. a .. ": combat")
	Coop_BOS_StartExtras(a)    -- no pcall in the game's Lua
	Coop_BOS_Unhunt(a)
	return true
end
-- 3d. (0.67c) Log only: during a fight, every 5 s, whom each champion shoots at and how far each
--     player is from the nearest champion. (0.67b turned the champions' PrioritizeHunter off - the
--     wrong cause: they attacked both players before 0.65b; removed.)
function Coop_BOS_ChampionList(a)
	local out, n = {}, 0
	local main = GetChampionFromArea(a)
	if Coop_ValidID(main) then n = n + 1 out[n] = main end
	local t = Coop_BOSExtras[a + 1]
	if t ~= nil then
		local i = 1
		while t[i] ~= nil do n = n + 1 out[n] = t[i] i = i + 1 end
	end
	return out, n
end
function Coop_Round(x)
	local r = 0
	while r + 100 <= x do r = r + 100 end
	while r + 10 <= x do r = r + 10 end
	while r + 1 <= x do r = r + 1 end
	return r
end
function Coop_BOS_Unhunt(a)
	local list, n = Coop_BOS_ChampionList(a)
	Coop_BOSWatchArena = a
	Coop_BOSWatchCount = 0
	PrintDebug("[coop] champion fight " .. a .. ": " .. n .. " champion(s) in the fight")
end
-- every 5 s of a fight: whom each champion is shooting at (log only)
function Coop_BOS_WatchTargets()
	local a = Coop_BOSWatchArena
	if a == nil then return end
	local s = Coop_BOS(a)
	if not s.combat or s.done then Coop_BOSWatchArena = nil return end
	Coop_BOSWatchCount = Coop_BOSWatchCount + 1
	if Coop_BOSWatchCount < 5 then return end
	Coop_BOSWatchCount = 0
	local list, n = Coop_BOS_ChampionList(a)
	local i, line = 1, ""
	while i <= n do
		local w = "dead"
		if IsAlive(list[i]) then
			local t = GetCharacterCurrentTarget(list[i])
			if not Coop_ValidID(t) then w = "nobody"
			elseif Coop_IsHost(t) then w = "host"
			elseif Coop_IsHuman(t) then w = "other player"
			else w = "an NPC" end
		end
		line = line .. " " .. i .. ":" .. w
		i = i + 1
	end
	-- distance of each player to the nearest living champion (whole metres, Newton sqrt)
	local function far(id)
		if not Coop_ValidID(id) or not IsAlive(id) then return "dead" end
		local p = GetVarValue(id, "Position")
		local k, best = 1, -1
		while k <= n do
			if IsAlive(list[k]) then
				local q = GetVarValue(list[k], "Position")
				local dx, dy, dz = q:GetX() - p:GetX(), q:GetY() - p:GetY(), q:GetZ() - p:GetZ()
				local d2 = dx * dx + dy * dy + dz * dz
				if best < 0 or d2 < best then best = d2 end
			end
			k = k + 1
		end
		if best < 0 then return "-" end
		local d, j = best + 1, 0
		while j < 25 do d = 0.5 * (d + best / d) j = j + 1 end
		return Coop_Round(d) .. " m"
	end
	line = line .. " | host " .. far(_idPlayer)
	local h = 1
	while Coop_Humans[h] ~= nil do
		local id = GetCharacterID(Coop_Humans[h])
		if id ~= _idPlayer then line = line .. ", " .. Coop_Humans[h] .. " " .. far(id) end
		h = h + 1
	end
	PrintDebug("[coop] champion fight " .. a .. " targets:" .. line)
end
function Coop_BOS_Won(a)
	local s = Coop_BOS(a)
	if s.done then return false end
	local main = GetChampionFromArea(a)
	if s.combat and Coop_BOS_ExtrasAlive(a) > 0 and Coop_ValidID(main) and not IsAlive(main) then
		if not s.waitlog then PrintDebug("[coop] champion fight " .. a .. ": " .. Coop_BOS_ExtrasAlive(a) .. " champion(s) still standing") end
		s.waitlog = true
		return false
	end
	s.done = true
	s.combat = false
	Coop_BOS_FreezeExtras(a)
	PrintDebug("[coop] champion fight " .. a .. ": won")
	return true
end
function Coop_BOS_IsDone(a)
	return Coop_BOS(a).done
end
function Coop_BOS_ChampionDead(a)
	local s = Coop_BOS(a)
	if not s.combat or s.done then return false end
	local c = GetChampionFromArea(a)
	if c == nil or c == GetInvalidEntityID() then return false end
	return not IsAlive(c) and Coop_BOS_ExtrasAlive(a) == 0
end
-- every other living player next to the host (after a set-up moved the host into an arena)
function Coop_BOS_BringPlayers()
	-- 0.65b: other players are not teleported into the arena (see Coop_TeleportHumans)
	PrintDebug("[coop] champion set-up: other players are not teleported - they walk in")
end

-- 4. Dying is not a mission failure in co-op: players respawn the multiplayer way (solo
--    GlobalPlayerIsDead failed the mission, and the solo failure screen loads a save).
--    A lost champion fight still fails it (BOS_Lost); the proxy then restarts the level.
function GlobalPlayerIsDead()
end

-- The engineer / Colonel Huber (mercenary 0) dying still fails the mission, as in solo - but only
-- once that mercenary exists: without him (no merc roster, e.g. the dedicated server) the solo
-- check read GetHealth(nil) and failed the mission the moment the round began.
local function Coop_Merc0Missing()
	return _idMerc == nil or _idMerc[0] == nil or _idMerc[0] == GetInvalidEntityID()
end
local Coop_GlobalIngenieurIsDead = GlobalIngenieurIsDead
function GlobalIngenieurIsDead()
	if Coop_Merc0Missing() or Coop_GlobalIngenieurIsDead == nil then return end
	return Coop_GlobalIngenieurIsDead()
end
local Coop_GlobalHuberIsDead = GlobalHuberIsDead
function GlobalHuberIsDead()
	if Coop_Merc0Missing() or Coop_GlobalHuberIsDead == nil then return end
	return Coop_GlobalHuberIsDead()
end

-- after a respawn the host has a new character: keep _idPlayer pointing at the living one
local function Coop_FollowHost()
	local id = GetLocalCharacterID()
	if id ~= nil and id ~= _idPlayer and id ~= GetInvalidEntityID() and IsAlive(id) then
		_idPlayer = id
		PrintDebug("[coop] _idPlayer follows the host's new character")
	end
end

function Coop_Tick(cameraMode)
	-- a level script can watch its own state once a second (COOP_Patrol_2: champion death)
	if Coop_LevelTick ~= nil then Coop_LevelTick() end
	if Coop_BOSWatchArena ~= nil then Coop_BOS_WatchTargets() end
	if _idPlayer ~= nil then
		Coop_FollowHost()
	end
	if cameraMode == 6 or not (CoopCine_Stripes or CoopCine_Locked) then
		CoopCine_Idle = 0
		return
	end
	CoopCine_Idle = CoopCine_Idle + 1
	if CoopCine_Idle == 15 then
		PrintDebug("[coop] the host has been held for 15 s with no camera sequence running (last " ..
			CoopCine_LastName .. ") - the script is waiting for something")
	end
	if CoopCine_Idle >= CoopCine_ReleaseAfter then
		PrintDebug("[coop] releasing the host after " .. CoopCine_ReleaseAfter .. " s (last camera sequence " ..
			CoopCine_LastName .. ")")
		CoopCine_Idle = 0
		ShowCinematicBlackStripes(false)
		if _idPlayer ~= nil then
			EnableCharacterCommand(_idPlayer, true)
			CharacterStopSpecialAction(_idPlayer)
		end
	end
end

-- the level's UpdateLevel waited for this (Coop_<Level>.lua): InitLevel runs right after this file
Coop_LevelReady = true

if CoopCine_Skip and CoopDialogue_Skip then
	PrintDebug("[coop] co-op layer loaded: cut-scenes and dialogue skipped")
elseif CoopCine_Skip then
	PrintDebug("[coop] co-op layer loaded: cut-scenes skipped, dialogue spoken")
else
	PrintDebug("[coop] co-op layer loaded: cut-scene log, release after " .. CoopCine_ReleaseAfter .. " s")
end
