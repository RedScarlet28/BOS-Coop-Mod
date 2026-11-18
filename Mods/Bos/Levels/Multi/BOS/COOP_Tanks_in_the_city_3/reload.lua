function InitLevelReload()
	-- Id du player
--	_idPlayer=GetCharacterID("Player");
	-- Total au départ des HP du Helmet
	_nHelmetTotalHP=GetArmorPartHP(_idPlayer,"Helmet");
	-- Total au départ des HP du Body
	_nBodyTotalHP=GetArmorPartHP(_idPlayer,"Body");
	-- Total au départ des HP des Legs
	_nLegsTotalHP=GetArmorPartHP(_idPlayer,"Legs");
	-- Total au départ des HP du Shield
	_nShieldTotalHP=GetShieldHP(_idPlayer);
end


-- Fonction pour recharger les magasins de munitions
-- Paramètres:
-- number : le nombre de munition à recharger
function ReloadAmmos(number)
	SetVarValue(_idPlayer,"OneHded_Mags",number);
	SetVarValue(_idPlayer,"TwoHded_Mags",number);
	SetVarValue(_idPlayer,"Heavy_Mags",number);
end


-- Fonction pour recharger l'armure
-- Paramètres:
function ReloadArmor()
	SetVarValue(_idPlayer,"HelmetHitPoints",_nHelmetTotalHP);
	SetVarValue(_idPlayer,"BodyHitPoints",_nBodyTotalHP);
	SetVarValue(_idPlayer,"LegsHitPoints",_nLegsTotalHP);
	SetVarValue(_idPlayer,"ShieldHitPoints",_nShieldTotalHP);
end

---------------------------------------------------------------------------

function OnEnter_Sector_Event_Reload_1(id)
	if (id == _idPlayer) then
		ReloadArmor()
	--	ReloadAmmos(number)
	end
end

function OnEnter_Sector_Event_Reload_2(id)
	if (id == _idPlayer) then
		ReloadArmor()
	--	ReloadAmmos(number)
	end
end

--[[

function OnEnter_Sector_Event_Reload_3(id)
	if (id == _idPlayer) then
		ReloadArmor()
	--	ReloadAmmos(number)
	end
end

function OnEnter_Sector_Event_Reload_4(id)
	if (id == _idPlayer) then
		ReloadArmor()
	--	ReloadAmmos(number)
	end
end

--]]