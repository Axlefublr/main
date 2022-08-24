#Include <Main>

Googler(searchRequest) {
	searchRequest := StrReplace(searchRequest, "+", "%2B")
	searchRequest := StrReplace(searchRequest, " ", "+")
	RunLink("https://www.google.com/search?q=" searchRequest)
}

MainApps() {

	chrome   := {winTitle: "Google Chrome ahk_exe chrome.exe",    exe: Paths.Apps["Google Chrome"]},
	discord  := {winTitle: "Discord ahk_exe Discord.exe",         exe: Paths.Apps["Discord"]},
	telegram := {winTitle: "Telegram ahk_exe Telegram.exe",       exe: Paths.Apps["Telegram"]},
	vscode   := {winTitle: "Visual Studio Code ahk_exe Code.exe", exe: Paths.Apps["VS Code"]},
	spotify  := {winTitle: "ahk_exe Spotify.exe",                 exe: Paths.Apps["Spotify"]},
	ahkdocs  := {winTitle: "AutoHotkey v2 Help",                  exe: Paths.Apps["Ahk v2 docs"]},
	
	apps := [chrome, discord, telegram, vscode, spotify, ahkdocs]
	
	index := 0
	for key, value in apps {
		index += win_Run(value.winTitle, value.exe)
	}
	
	if !index 
		Info("All apps are already active")
}

CloseMainApps() {
	GroupAdd("MainApps", "ahk_exe chrome.exe",, "Google Chrome")
	GroupAdd("MainApps", "Discord ahk_exe Discord.exe")
	GroupAdd("MainApps", "Telegram ahk_exe Telegram.exe")
	GroupAdd("MainApps", "Visual Studio Code ahk_exe Code.exe")
	GroupAdd("MainApps", "ahk_exe Spotify.exe")
	GroupAdd("MainApps", "ahk_group AutoHotkey_Help")
	GroupAdd("MainApps", "C:\ ahk_exe explorer.exe")
	WinClose("ahk_group MainApps")
}

CloseButForSure() {
	Switch {
		Case WinActive("ahk_exe Spotify.exe"):spotify_Close()
		Case WinActive("ahk_exe steam.exe"):
			win_Close()
			ProcessClose("steam.exe")
		Case WinActive("ahk_exe gimp-2.10.exe"):
			win_Close()
			closeWindow := "Quit GIMP ahk_exe gimp-2.10.exe"
			if !WinWait(closeWindow,, 60)
				return
			win_Activate(closeWindow)
			Send("{Left}{Enter}")
		Case WinActive("DaVinci Resolve ahk_exe Resolve.exe"):
			win_Close()
			closeWindow := "Message ahk_exe Resolve.exe"
			if !WinWait(closeWindow,, 60)
				return
			win_Activate(closeWindow)
			Send("{Left 2}{Enter}")
		Default:win_Close()
	}
}

RadNum() {
	return Random(1000000, 9999999)
}

GetRandomCommitMessage() {
	five_random_words := " "
	Loop 5 
		five_random_words .= GetRandomWord("english") " "

	return A_Now five_random_words
}

Skipper(time) {
	time := Round(Eval(time) / 5)
	Send("{Right " time "}")
}

Counter(startingNum, singleKey := "Tab") {

	_SendNum(*) {
		static num := startingNum
		Send(num++)
	}

	_DeleteBothHotkeys := (*) => (
		Hotkey(singleKey, "Off")
		Hotkey("+" singleKey, "Off")
	)

	Hotkey(singleKey, _SendNum, "On")
	Hotkey("+" singleKey, _DeleteBothHotkeys, "On")
}