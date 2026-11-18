--[[ Création de Timer --]]

function CreationTimer(bActive, bDestOnExp, bLoop, strTrigFunc, nDuration)
	local idTimer = CreateTimer()
	SetVarValue(idTimer, "Active", bActive)
	SetVarValue(idTimer, "DestroyOnExpire", bDestOnExp)
	SetVarValue(idTimer, "Loop", bLoop)
	SetVarValue(idTimer, "TriggerFunction", strTrigFunc)
	SetVarValue(idTimer, "Duration", nDuration)
end