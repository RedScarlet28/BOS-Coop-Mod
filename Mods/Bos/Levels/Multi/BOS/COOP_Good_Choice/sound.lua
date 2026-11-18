
function Crowd_B_1()
	SetVarValue(GetSound_ClientID("Sound_Client_Crowd_B_1"), "Playing", false)
	SetVarValue(GetSound_ClientID("Sound_Client_Crowd_B_1"), "Playing", true)
	_nTimer = GetRandom(15,35)
--	_nTimer = (_nTimer * 10)
	SetVarValue(GetTimerID("Timer_Crowd_B_1"), "Duration", _nTimer)
end

function Crowd_B_2()
	SetVarValue(GetSound_ClientID("Sound_Client_Crowd_B_2"), "Playing", false)
	SetVarValue(GetSound_ClientID("Sound_Client_Crowd_B_2"), "Playing", true)
	_nTimer = GetRandom(15,35)
--	_nTimer = (_nTimer * 10)
	SetVarValue(GetTimerID("Timer_Crowd_B_2"), "Duration", _nTimer)
end



function Crowd2()
	SetVarValue(GetSound_ClientID("Sound_Client_Crowd3"), "Playing", true)
end

function Crowd4()
--	SetVarValue(GetSound_ClientID("Sound_Client_Crowd4"), "Playing", true)
end

function Crowd5()
	--SetVarValue(GetSound_ClientID("Sound_Client_Crowd5"), "Playing", true)
end


function VolumeSounds ()
	if (_bTestPlayerExterieur == true) then
		SetVarValue(GetSound_ClientID("Sound_Client_Crowd1"),"Volume",1.0)
		SetVarValue(GetSound_ClientID("Sound_Client_Crowd3"),"Volume",1.0)
		SetVarValue(GetSound_ClientID("Sound_Client_Crowd_B_1"),"Volume",0.5)
		SetVarValue(GetSound_ClientID("Sound_Client_Crowd_B_2"),"Volume",1.0)
		SetVarValue(GetSound_ClientID("Sound_Client_Wind"),"Volume",0.4)
	else
		SetVarValue(GetSound_ClientID("Sound_Client_Crowd1"),"Volume",0.3)
		SetVarValue(GetSound_ClientID("Sound_Client_Crowd3"),"Volume",0.3)
		SetVarValue(GetSound_ClientID("Sound_Client_Crowd_B_1"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_Crowd_B_2"),"Volume",0.3)
		SetVarValue(GetSound_ClientID("Sound_Client_Wind"),"Volume",0.25)
	end
end