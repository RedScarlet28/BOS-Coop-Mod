-- CoopMod dedicated-server test: does FreezeAll(group, false) unfreeze the members in MP?
function CharacterPlaySpecialAction() end
function CharacterStopSpecialAction() end
function MakeCharacterSpeak() end
function LaunchCameraTransition() end
function ShowCinematicBlackStripes() end
function StartMusic() end
function StopMusic() end
function SoundPrecache() end
function UpdateLevel() end

function Test_F(name)
	local v = GetVarValue(GetCharacterID(name), "Freeze")
	if v == true then return name .. "=frozen" end
	if v == false then return name .. "=free" end
	return name .. "=?"
end

function Test_Report(when)
	local g = GetVarValue(_idGrp_WRF_Camp_1_3, "Freeze")
	local gs = "?"
	if g == true then gs = "frozen" elseif g == false then gs = "free" end
	PrintDebug("[test] " .. when .. ": group " .. gs .. "; " .. Test_F("Char_WRF_Camp_1_Solberg") .. " " ..
		Test_F("Char_WRF_Camp_1_Caporal") .. " " .. Test_F("Char_WRF_Camp_1_03_3") .. " " .. Test_F("Char_WRF_Camp_1_03_2"))
end

function Test_Later()
	Test_Report("2 s after FreezeAll")
end

function OnMissionBegins()
	_idMerc = {}
	Test_Report("before FreezeAll")
	FreezeAll(_idGrp_WRF_Camp_1_3, false)
	Test_Report("right after FreezeAll(group, false)")
	CreationTimer(true, true, false, "Test_Later", 2.0)
end
