--[[ Random sur les phrases de Huber --]]

function RandomCloitreHuberDialogues()
	local nNumb1 = GetRandom(1,3)
	if (nNumb1 == 1) then
		-- MakeCharacterSpeak(_idMerc[0],"DIA_SPE_NIV_O_HUBER_D_19",true,2)
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_19",true,98,2,0,"StopAnimHuber0",28)
--		CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
	elseif (nNumb1 == 2) then
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_20",true,98,2,0,"StopAnimHuber0",28)
--		CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
	else
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_21",true,98,2,0,"StopAnimHuber0",28)
--		CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
	end
end

--[[ Random sur les phrases de Copain --]]

function RandomHuberDialogues1()
	local nNumb2 = GetRandom(1,3)
	if (nNumb2 == 1) then
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_32",true,98,2,0,"StopAnimHuber0",28)
--		CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
	elseif (nNumb2 == 2) then
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_33",true,98,2,0,"StopAnimHuber0",28)
--		CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
	else
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_34",true,98,2,0,"StopAnimHuber0",28)
--		CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
	end
end


function StopAnimHuber0()
--	CharacterStopSpecialAction(_idMerc[0])
end