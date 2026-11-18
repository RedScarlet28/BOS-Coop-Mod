-- CoopMod dedicated-server test: a cut-scene that turns the black stripes on
-- and never ends; the co-op layer (coop_mission.lua) must release after 45 s.
function ShowCinematicBlackStripes(on) if on then PrintDebug("[test] native stripes on") else PrintDebug("[test] native stripes off") end end
function EnableCharacterCommand(id, on) if on then PrintDebug("[test] native controls on") else PrintDebug("[test] native controls off") end end
function CharacterStopSpecialAction() end
function UpdateLevel() end
function OnMissionBegins()
	PrintDebug("[test] holding the host: stripes on, controls off, no camera sequence")
	ShowCinematicBlackStripes(true)
	EnableCharacterCommand(_idPlayer, false)
end
