﻿#Include <Main>

;Reloads the script
scr_Reload() {
	Run(A_ScriptFullPath)
}

;Hard reloads the script: exits the script and then runs it, instead of just running over itself like _scr_Reload does.
scr_HardReload() {

	_onExit(ExitReason, ExitCode) {
		if ExitReason = "Exit" {
			Run(A_ScriptFullPath)
		}
	}

	ExitApp()
}

;Suspends or unsuspends the script
scr_Suspend() {
	if A_IsSuspended {
		Suspend(False)
		Info("Script unsuspended")
	}
	else {
		Suspend(True)
		Info("Script suspended")
	}
}

scr_RunAsAdmin() {
	if !A_IsAdmin {
		RunLike("RunAs", A_ScriptFullPath)
		; Run('*RunAs "' A_ScriptFullPath '"')
		Sleep(10000) 
		;Even though we just ran a new instance of the same script that's currently running, it might still partly reach the following line, here we make sure nothing even tries to happen before we properly rerun the current script as admin. This sleep doesn't actually introduce any delay, it's purely for smoothness.
	}
}

scr_Test() {
	Run(Paths.Ptf["AhkTest"])
}

;Alternative to outputdebug
Out(put := "", endChar := "`n", overwrite := False) {
	filePath := Paths.Ptf["Output"]
	static wasRan := False
	if !wasRan || overwrite 
		WriteFile(filePath, put endChar), wasRan := True
	else
		AppendFile(filePath, put endChar)
}

scr_HighPriority() {
	ProcessSetPriority("H", WinGetPID("A"))
}