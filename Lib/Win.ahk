;No dependencies

win_Close(winTitle := "A") {
	try PostMessage("0x0010",,,, winTitle)
}

win_RestoreDown(winTitle := "A") {
	try PostMessage("0x112", "0xF120",,, winTitle)
}

win_Maximize(winTitle := "A") {
	try PostMessage("0x112", "0xF030",,, winTitle)
}

win_Minimize(winTitle := "A") {
	try PostMessage("0x112", "0xF020",,, winTitle)
}

win_Activate(winTitle) {
	WinActivate(winTitle)
	WinWaitActive(winTitle)
}

win_MinMax(winTitle) {
	if !WinExist(winTitle) 
		return False

	if WinActive(winTitle) 
		win_Minimize(winTitle)
	else 
		win_Activate(winTitle)
	return True
}

win_Run(winTitle, exePath, runOpt?, winTitleAdditional?) {
	if WinExist(winTitle) 
		return 0
	Run(exePath,, runOpt ?? "Max")
	WinWait(winTitle,, 120)
	if winTitleAdditional ?? False {
		WinWait(winTitleAdditional,, 60)
		win_Close(winTitleAdditional)
	}
	return 1
}

win_RunAct(winTitle, exePath, runOpt?, winTitleAdditional?) {
	win_Run(winTitle, exePath, runOpt?, winTitleAdditional?)
	win_Activate(winTitle)
} 

win_RunAct_Folders(folderPath, runOpt?) {
	winTitle := folderPath " ahk_exe explorer.exe"
	win_RunAct(winTitle, folderPath, runOpt ?? "Min")
}

win_App(winTitle, exePath, runOpt?, winTitleAdditional?) {
	if win_MinMax(winTitle)
		return 
	win_RunAct(winTitle, exePath, runOpt?, winTitleAdditional?)
}

win_App_Folders(folderPath, runOpt?) {
	winTitle := folderPath " ahk_exe explorer.exe"
	win_App(winTitle, folderPath, runOpt?)
}

win_CloseOnceInactive(winTitle, closedAfter := 5) {
	WinWaitNotActive(winTitle)
	SetTimer(() => win_Close(winTitle), -closedAfter*1000)
}

win_AutoCloseFolder(folderPath) {
	winTitle := folderPath " ahk_exe explorer.exe"
	win_RunAct(winTitle, folderPath, "Min")
	win_CloseOnceInactive(winTitle)
}

win_RestoreLeftRight(direction, winTitle := "A") {

	_WinMove() {
		Switch direction {
			Case "right":direction := 960
			Case "left": direction := 0
		}
		WinMove(direction, 0, 960, 1079, winTitle)
	}

	_WinMoveWhenMin() {
		if WinGetMinMax(winTitle)
			return
		_WinMove(), SetTimer(, 0)
	}

	if !WinGetMinMax(winTitle) {
		_WinMove()
		return
	}

	win_RestoreDown(winTitle) ;Unmaximize it
	SetTimer(_WinMoveWhenMin, 20)

}
