#Include <Main>

Googler(searchRequest) {
	searchRequest := StrReplace(searchRequest, "+", "%2B")
	searchRequest := StrReplace(searchRequest, " ", "+")
	RunLink("https://www.google.com/search?q=" searchRequest)
}

AnimeDownload(which) {

	path := StrTitle(which)
	path := StrReplace(path, " ", "")
	path := Paths.%path%

	link := Links.Links[which]

	static NextEpisode := 0

	AllFiles := []
	Loop Files path "\*.mp4" {
		RegexMatch(A_LoopFileName, "\d+", &temp)
		AllFiles.Push(temp[0])
	}

	if !AllFiles.Length 
		NextEpisode := 1
	else {
		AllFiles := InsertionSort(AllFiles) ;Usually the files are sorted already, but this is just to make sure
		NextEpisode := AllFiles[-1] + 1
	}

	RunLink(link NextEpisode)

	PasteAndIncr := (*) => (
		ClipSend(NextEpisode), 
		NextEpisode++, 
		Send("{Enter}")
	)

	Destruction := (*) => (
		HotIfWinActive("Save As ahk_exe chrome.exe"),
		Hotkey("Tab", "Off"),
		HotIfWinActive("Google Chrome ahk_exe chrome.exe"),
		Hotkey("Tab", "Off"),
		HotIfWinActive(),
		HotIf(),
		Hotkey("Escape", "Off"),
		NextEpisode := 0,
		Info("Anime downloader disabled")
	)
		

	HotIfWinActive("Save As ahk_exe chrome.exe")
	Hotkey("Tab", PasteAndIncr, "On")
	HotIfWinActive("Google Chrome ahk_exe chrome.exe")
	Hotkey("Tab", (*) => CloseTab(), "On")
	HotIfWinActive()
	HotIf()
	Hotkey("Escape", Destruction, "On")
	
}

MainApps() {

	chrome   := {winTitle: "Google Chrome ahk_exe chrome.exe",    exe: Paths.Apps["Google Chrome"]}
	discord  := {winTitle: "Discord ahk_exe Discord.exe",         exe: Paths.Apps["Discord"]}
	telegram := {winTitle: "Telegram ahk_exe Telegram.exe",       exe: Paths.Apps["Telegram"]}
	vscode   := {winTitle: "Visual Studio Code ahk_exe Code.exe", exe: Paths.Apps["VS Code"]}
	spotify  := {winTitle: "ahk_exe Spotify.exe",                 exe: Paths.Apps["Spotify"]}
	ahkdocs  := {winTitle: "AutoHotkey v2 Help",                  exe: Paths.Apps["Ahk v2 docs"]}
	
	index := 0
	index += win_Run(chrome.winTitle, chrome.exe)
	index += win_Run(discord.winTitle, discord.exe)
	index += win_Run(telegram.winTitle, telegram.exe)
	index += win_Run(vscode.winTitle, vscode.exe)
	index += win_Run(spotify.winTitle, spotify.exe)
	index += win_Run(ahkdocs.winTitle, ahkdocs.exe)
	if !index
		Info("All apps are already active")
}

Symbol(unicodeName, endChar?) {
	if IsObject(unicodeName) {
		toSend := ""
		for key, value in unicodeName 
			toSend .= Chr(Char.Unicodes[value])
	}
	else
		toSend := Chr(Char.Unicodes[unicodeName])

	Send(toSend (endChar ?? ""))
}

CloseButForSure() {
	WinActive("ahk_exe Spotify.exe") ? spotify_Close() : win_Close()
	Switch {
		Case WinActive("ahk_exe gimp-2.10.exe"):
			closeWindow := "Quit GIMP ahk_exe gimp-2.10.exe"
			if !WinWait(closeWindow,, 60)
				return
			win_Activate(closeWindow)
			Send("{Left}{Enter}")
	}
}

RadNum() {
	return Random(1000000, 9999999)
}
