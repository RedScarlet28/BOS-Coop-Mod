--[[ Teste si on affiche un dialogue ou pas  --]]

function Appel_Dialogue(_bActif,_nDuree,_strTxt)
	if _bActif then
		if not _bStart then
			_nTps0 = GetTime()
			_bStart = true
		end
		_nTps = GetTime()
		if (_nTps - _nTps0) < _nDuree then
	 		PrintDebug(_strTxt)
		end
		if (_nTps - _nTps0) >= _nDuree then
			_bStart = false
			_bDepart = false
		end
	end
end



--[[ Initialise les variables destinées à recevoir les paramètres de la fonction Dialogue --]]

function Dialogue(_bInit_Depart,_nInit_Time,_strInit_Text)
	_bDepart = _bInit_Depart
	_nTime = _nInit_Time
	_strText = _strInit_Text
end