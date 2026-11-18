function Tutorial_Tips_1()
	DisplayTips ("GUI_TIPS_SOLO_NIV_A_01")
	-- Tutorial_Tips("GUI_TIPS_SOLO_NIV_A_01",7)
	CreationTimer(true, true, false, "Test_Tutorial_Tips_1b",3)
end

function Test_Tutorial_Tips_1b()
	if (_bPlayerPasse_SE_Camp_1_Test_Tips == true) then
		Tutorial_Tips_1b()
	end
end

function Tutorial_Tips_1b()
	DisplayTips ("GUI_TIPS_SOLO_NIV_A_08")
	-- Tutorial_Tips("GUI_TIPS_SOLO_NIV_A_08",7)
end

function Tutorial_Tips_2()
	DisplayTips ("GUI_TIPS_SOLO_NIV_A_02")
	-- Tutorial_Tips("GUI_TIPS_SOLO_NIV_A_02",7)
end

function Tutorial_Tips_3()
	DisplayTips ("GUI_TIPS_SOLO_NIV_A_07")
	-- Tutorial_Tips("GUI_TIPS_SOLO_NIV_A_07",7)
end

function Tutorial_Tips_4()
	DisplayTips ("GUI_TIPS_SOLO_GEN_12")
	-- Tutorial_Tips("GUI_TIPS_SOLO_GEN_12",7)
end

function TIPSMERCS()
	DisplayTips ("GUI_TIPS_SOLO_NIV_A_23")
end