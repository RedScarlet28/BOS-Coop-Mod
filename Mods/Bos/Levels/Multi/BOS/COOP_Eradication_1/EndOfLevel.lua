--[[ Fin Loading --]]

function OnEnter_Sector_Event_End_Of_Level(id)

_idTimer_fin_nivo=GetTimerID("Timer_fin_nivo")

	if (id == _idPlayer)and(_bEnd==true)then
		SetVarValue(_idTimer_fin_nivo,"Active",true)
	end
end



----------------------------------------
function FinDeNiveau()

	if(_bFinDeNiveau==0)then
	EndOfLevel()
		_bFinDeNiveau=1
	end
end
-----------------------------------
--function ENDofDEMO()

--	if(_bENDofDEMO==0)then
	--	if IsEntityInBox(_idPlayer,"Sector_Event_illusion_bataille")then
		--		Mission_End_Demo ()			
	--		_bENDofDEMO=1
--		end
	--end
--end


