
------------------------------------------------------------
------------------------------------------------------------

-- ::: Global ::::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function EnableCharCmd()
	EnableCharacterCommand(_idPlayer, true)
	SetGodMode(_idPlayer, false)
end

function DisableCharCmd()
	EnableCharacterCommand(_idPlayer, false)
	SetGodMode(_idPlayer, true)
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Sequence A ::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function CamHuber0()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Huber_0"))
end

function CamHuber1()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Huber_1"))
end

function CamHuber1b()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Huber_1b"))
end

function CamHuber2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Huber_2"))
end

function CamHuber3()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Huber_3"))
end

function TrackingCamPoint_Huber_3()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Huber_3"),_idPlayer)
end

function TrackingCamPoint_Huber_4()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Huber_4"),_idPlayer)
end




function CamHuber4()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Huber_4"))
	RadioMessage("DIA_SPE_NIV_O_RESIS_G_04",true,100,6,"ActivFX_FLM")
end

function CamHuber4b()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Huber_4b"))

end

function CamHuber5()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Huber_5"))
end

function TrackingCamPoint_Huber_5()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Huber_5"),GetCharacterID("Char_Syndic_Cloister_02_2"))
end

function TrackingCamPoint_Huber_6()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Huber_6"),GetCharacterID("Char_Syndic_Cloister_02_2"))
end

function TrackingCamPoint_Huber_7()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Huber_7"),GetCharacterID("Char_Syndic_Cloister_02_1"))
end

function TrackingCamPoint_Huber_8()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Huber_8"),GetCharacterID("Char_Syndic_Cloister_02_1"))
end

function CamHuber6()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Huber_6"))
	CharacterStopSpecialAction(GetCharacterID("Char_Syndic_Cloister_01_1"))
end
function CamHuber7()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Huber_7"))
	CharacterPlaySpecialAction(GetCharacterID("Char_Syndic_Cloister_02_1"),"STAND MEDHI ORDER_GO W_NONE",false,false)
end