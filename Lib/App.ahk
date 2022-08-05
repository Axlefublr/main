#Include <Main>

chrome_CopyLink() {
	Send("^l"), KeyWait(A_ThisHotkey_Formatted(), "U"), Copy()
}

chrome_CloseAllTabs() {
	Send "+!w"
}




spotify_Like() {
	Send("+!b")
}

spotify_Shuffle() {
	Send("^s")
}

spotify_SkipNext() {
	Send("^{Right}")
}

spotify_SkipPrev() {
	Send("^{Left}")
}

spotify_LikedPlaylist() {
	Send("+!s")
}

spotify_Close() {
	Send("^+q")
}

spotify_Discovery() {
	static isStarted := False
	static var := 0

	if isStarted {
		Destruction()
		return
	}

	onRightClick(*) {
		ControlClick_Here("ahk_exe Spotify.exe", "R")
		var++
		g_added_text.Text := var
		if var >= 15 {
			Destruction()
		}
	}

	Destruction(*) {
		HotIfWinActive("ahk_exe Spotify.exe")
		Hotkey("RButton", "Off")
		Hotkey("Escape", "Off")
		g_added.Destroy()
		var := 0
		isStarted := False
	}

	static g_added
	g_added := Gui("AlwaysOnTop -caption")
	g_added.backColor := "171717"
	g_added.SetFont("s50 cC5C5C5", "Consolas")
	g_added_text := g_added.Add("Text", "W200 X0 Y60 Center", "0")
	g_added.Show("W200 H200 X0 Y0 NA")

	HotIfWinActive("ahk_exe Spotify.exe")
	Hotkey("RButton", onRightClick.Bind(), "On")
	Hotkey("Escape", Destruction.Bind(), "On")
	g_added.OnEvent("Close", Destruction.Bind())
	g_added_text.OnEvent("Click", (*) => var := g_added_text.Text := g_added_text.Text - 1)
	g_added_text.OnEvent("DoubleClick", Destruction.Bind())

	isStarted := True
}

spotify_GetCurrSong() {
	currSong := WinGetTitle("ahk_exe Spotify.exe")
	if currSong = "Spotify Free"
		return False
	return currSong
}

spotify_NewDiscovery() {
	currSong := spotify_GetCurrSong()
	if !currSong {
		Traytip("No track is playing")
		return
	}
	artistName := RegexReplace(currSong, " - .*", "")
	AppendFile(Paths.Ptf["Discovery log"], GetDateAndTime() " - " artistName "`n")
	TrayTip(artistName " just discovered! 🌎")
}

spotify_NewRapper(name) {
	isTouched := ReadFile(Paths.Ptf["Unfinished"])
	isTouched .= ReadFile(Paths.Ptf["Rappers"])
	isTouched := RegexReplace(isTouched, " - .*", "")
	if Instr(isTouched, name) {
		TrayTip("You've already started listening to this rapper")
		return
	}
	AppendFile(Paths.Ptf["Rappers"], name "`n")
	TrayTip("New rapper to discover! 📃")
}

spotify_SendTrackToKristi() {
	currSong := spotify_GetCurrSong()
	if !currSong {
		TrayTip("No track is playing")
		return
	}
	win_RunAct("Telegram", Paths.Apps["Telegram"])
	telegram_Channel("кристина")
	WaitUntilImage(Paths.Ptf["Kristi"])
	ClipSend(currSong)
	Send("{Enter}")
}

spotify_Context() {
	ControlClick("X22 Y1015", "ahk_exe Spotify.exe",, "R")
	Send("{Up 2}")
}

spotify_FavRapper_Auto() {
	currSong := spotify_GetCurrSong()
	if !currSong {
		Traytip("No track is playing")
		return
	}
	currArtist := RegexReplace(currSong, " -.*")
	spotify_FavRapper_Manual(currArtist)
}

spotify_FavRapper_Manual(artistName) {
	artists := ReadFile(Paths.Ptf["Artists"])
	artists := RegexReplace(artists, "1\. ")
	if InStr(artists, artistName) {
		TrayTip(artistName " is already added 😨")
		return
	}
	AppendFile(Paths.Ptf["Artists"], "1. " artistName "`n")
	TrayTip(artistName " is now your favorite! 🥰")
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
youtube_SkipNext() {
	Send "+n"
}

youtube_SkipPrev() {
	Send "+p"
}

youtube_Seek(direction) {
	Switch direction {
		Case "right":Send("l")
		Case "left":Send("j")
	}
}

youtube_Fullscreen() {
	LanguageEng(), Send("f")
}

youtube_Miniscreen() {
	LanguageEng(), Send("i")
}

youtube_MiniscreenClose() {
	ControlClick "X1858 Y665"
}

youtube_ChannelSwitch() {
	ControlClick("X1823 Y133")
	WaitUntilImage(Paths.Ptf["switch account ytt"])
	ControlClick("X1524 Y400")
}

youtube_ToYouTube() {
	ControlClick("X1865 Y130")
	WaitClick(Paths.Ptf["youtube logo"])
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vk_Notifications() {
	ControlClick "X788 Y126"
}

vk_Voice() {
	ControlClick "X1757 Y1014"
}

vk_Scroll() {
	ControlClick "X1750 Y903"
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
telegram_Voice() {
	ClickThenGoBack_Event("1452 1052")
}

telegram_Scroll() {
	ControlClick "X1434 Y964"
}

telegram_Channel(channelToFind, waitForChannel?) {
	ControlClick("X456 Y74")
	Send(channelToFind "{Down}")
	if waitForChannel
		WaitUntilImage(waitForChannel)
	Send("{Enter}")
}

telegram_Diary() {
	diary := ReadFile(Paths.Ptf["Diary"])
	WriteFile(Paths.Ptf["Diary"])
	win_RunAct("Telegram ahk_exe Telegram.exe", Paths.Apps["Telegram"])
	telegram_Channel("Diary", Paths.Ptf["selected diary"])
	WaitUntilImage(Paths.Ptf["diary"])
	ClipSend(diary)
	Send("{Enter}")
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
discord_Emoji() {
	Send "^e"
}

discord_Gif() {
	Send "^g"
}

discord_Reply() {
	CtrlClick()
}

discord_React() {
	ImageSearch(&reactX, &reactY, 1730, 88, 1820, 995, Paths.Ptf["react"])
	try ControlClick("X" reactX " Y" reactY, "ahk_exe Discord.exe")
}

discord_DeleteMessage() {
	Send "{Delete Down}{Click}{Delete Up}"
}




vscode_IndentRight() {
	Send "^!{Right}"
}

vscode_IndentLeft() {
	Send "^!{Left}"
}

vscode_Comment() {
	Send "#{End}"
}

vscode_RunCurrentFile() {
	Send "+!o"
}

vscode_KillTerminal() {
	Send "^!o"
}

vscode_Debug() {
	Send "^+9"
}

vscode_CloseAllTabs() {
	Send "+!w"
}

vscode_DeleteLine() {
	Send "+{Delete}"
}

vscode_Reload() {
	Send "+!y"
}

vscode_FoldCodeBlock() {
	Send("{Click}^l")
}

vscode_CloseTab() {
	Send("!w")
}

vscode_CursorBack() {
	Send("!{PgUp}")
}

vscode_CursorForward() {
	Send("!{PgDn}")
}

vscode_GetCurrentFileFullPath(keepClip := True) {
	if keepClip
		prevClip := ClipboardAll()
	A_Clipboard := ""
	Send("^+k")
	ClipWait(3, 1)
	fileFullPath := A_Clipboard
	if keepClip
		A_Clipboard := prevClip
	return fileFullPath
}

vscode_ToEndOfCurrFile() {
	selection := str_GetSelection()
	Filee := {}
	Filee.Path := vscode_GetCurrentFileFullPath()
	Filee.Textt := ReadFile(Filee.Path)
	Filee.Textt := StrReplace(Filee.Textt, selection, "")
	Filee.Textt .= selection
	WriteFile(Filee.Path, Filee.Textt)
}

vscode_ToEndOfOthrFile(otherFilePath) {
	selection := str_GetSelection()
	Filee := {}
	Filee.Path := vscode_GetCurrentFileFullPath()
	Filee.Textt := ReadFile(Filee.Path)
	Filee.Textt := StrReplace(Filee.Textt, selection, "")
	WriteFile(Filee.Path, Filee.Textt)
	AppendFile(otherFilePath, selection)
}

vscode_WorkSpace(wkspName) {
	vscode_CloseAllTabs()
	win_Close("ahk_exe Code.exe")
	Run(Paths.Ptf[wkspName],, "Max")
}

vscode_toCommitMessage(changeNotes_rawFile) {
	if !changeNotes_rawFile
		return ""
	changeNotes := RegexReplace(changeNotes_rawFile, "\r?\n\r?\n", "`; ")
	changeNotes := RegexReplace(changeNotes, "\r?\n", " ") ;we gotta remove all the newlines so we don't accidentally send a bunch of enters to the console

	changeNotes := RegexReplace(changeNotes, '"', "'")
	changeNotes := RegexReplace(changeNotes, '^\* ')
	changeNotes := RegexReplace(changeNotes, '\*{1,2}')

	return changeNotes
}

vscode_CleanText() {
	clean := ReadFile(Paths.Ptf["Raw"])
	clean := StrReplace(clean, "`r`n", "`n") ;making it easy for regex to work its magic by removing returns
	clean := RegexReplace(clean, "m)^\* .*\n(\n)?") ;removing bullets and their additional newlines

	RegexMatch(clean, "s)---\n(.*)", &description_regexed) ;Getting the description that's manually written

	clean := RegexReplace(clean, "s)---\n.*") ;deleting the description part of the script
	clean := RegexReplace(clean, "\n{3,}") ;removing spammed newlines
	clean := RegexReplace(clean, "m) *$") ;removing leading spaces
	clean := RegexReplace(clean, "(?<!\.)\n{2}(?=[^A-Z])", " ") ;appending continuing lines that start with a lowercase letter. if the previous line ended in a period, it's ignored

	clean_compact := StrReplace(clean, "`n`n", "`n")

	if !description_regexed
		description_manual := ''
	else
		description_manual := description_regexed[1]

	description := "
	(


		Learn about autohotkey v2 in the documentation: https://lexikos.github.io/v2/docs/AutoHotkey.htm
		IDE used in the video: https://code.visualstudio.com/

		My github:
		https://github.com/Axlefublr/Personal

		Catch me on the ahk discord server as Axlefublr:
		https://discord.com/invite/Aat7KHmG7v

		The video script:

	)" clean_compact

	WriteFile(Paths.Ptf["Clean"], clean)
	WriteFile(Paths.Ptf["Description"], description)
	Info("Text cleaned")
}

vscode_AhkPlusPlusUpdate() {
	tmLanguage := ReadFile(Paths.Ptf["SynHigh\tmLanguage"])
	WriteFile(Paths.Ptf["Ahk++\tmLanguage"], tmLanguage)

	configuration := ReadFile(Paths.Ptf["SynHigh\configuration"])
	WriteFile(Paths.Ptf["Ahk++\configuration"], configuration)

	ahkSnippets := ReadFile(Paths.Ptf["SynHigh\ahk snippets"])
	WriteFile(Paths.Ptf["Ahk++\ahk snippets"], ahkSnippets)

	package := ReadFile(Paths.Ptf["Ahk++\package"])
	package := StrReplace(package
	, "C:\\Program Files\\Autohotkey\\AutoHotkeyU64.exe"
	, "C:\\Program Files\\Autohotkey\\v2\\AutoHotkey64_UIA.exe"
	)
	package := StrReplace(package
	, "C:/Program Files/AutoHotkey/AutoHotkeyU64.exe"
	, "C:/Program Files/AutoHotkey/v2/AutoHotkey64_UIA.exe"
	)
	package := StrReplace(package
	, "C:/Program Files/AutoHotkey/AutoHotkey.chm"
	, "C:/Program Files/AutoHotkey/v2/AutoHotkey.chm"
	)
	WriteFile(Paths.Ptf["Ahk++\package"], package)

	vscode_Reload()
}

vscode_VideoUp() {
	files := [
		Paths.Ptf["Raw"],
		Paths.Ptf["Clean"],
		Paths.Ptf["Description"],
		Paths.Ptf["1"],
		Paths.Ptf["2"]
	]
	for key, value in files {
		WriteFile(value)
	}
	FileDelete(Paths.Materials "\*.*")
}

vscode_JsTutorial() {
	WriteFile(Paths.Ptf["index.js"])
	WriteFile(Paths.Ptf["styles.css"])
	WriteFile(Paths.Ptf["index.html"], "
	(
		<!DOCTYPE html>
		<html>
			<head>
				<meta charset="utf-8" />
				<meta http-equiv="X-UA-Compatible" content="IE=edge" />
				<title>Page Title</title>
				<meta name="viewport" content="width=device-width, initial-scale=1" />
				<link rel="stylesheet" type="text/css" media="screen" href="css.css" />
			</head>
			<body>

				#

				<script src="jsm.js"></script>
			</body>
		</html>
	)")

}




git_MovingCompany() {

	FileCopy(
		Paths.Ptf["Ahk++\tmLanguage"],
		Paths.Ptf["SynHigh\tmLanguage"], 1
	)
	FileCopy(
		Paths.Ptf["Ahk++\configuration"],
		Paths.Ptf["SynHigh\configuration"], 1
	)
	FileCopy(
		Paths.Ptf["Ahk++\ahk snippets"],
		Paths.Ptf["SynHigh\ahk snippets"], 1
	)
}

git_CommitRepo(changeNote_file, repo_path, andPush := True) {
	git_MovingCompany()

	commitMessage := vscode_toCommitMessage(ReadFile(changeNote_file))

	program := [
		'cd "' repo_path '"',
		'git add .',
		'git commit -m "' commitMessage '"',
	]

	if andPush 
		program.Push("git push")

	RunSpec(program,, True)
	WriteFile(changeNote_file)
}

git_Link() {
	static programming_path := Paths.Prog

	shouldContinue := False

	g_selectType := Gui()
	g_selectType.BackColor := "171717"
	g_selectType.SetFont("s20 cC5C5C5", "Consolas")

	selectType_hwnd := g_selectType.hwnd

	g_selectType_prompt := g_selectType.Add("Text",, "What do you want to get the link of?")

	g_selectType.SetFont("s15")

	Destruction := (*) => (
		HotIfWinActive("ahk_id " selectType_hwnd),
		Hotkey("Escape", "Off"),
		g_selectType.Destroy()
	)

	static selection_type := "File"
	SelectType := (type_to_select, *) => (
		selection_type := type_to_select,
		shouldContinue := True,
		Destruction()
	)

	g_selectType_file := g_selectType.Add("Button", "Default background171717", "File")
	.OnEvent("Click", SelectType.Bind("file"))
	g_selectType_folder := g_selectType.Add("Button", "x+m background171717", "Folder")
	.OnEvent("Click", SelectType.Bind("folder"))

	HotIfWinActive("ahk_id " selectType_hwnd)
	Hotkey("Escape", Destruction)

	g_selectType.OnEvent("Close", Destruction)
	g_selectType.Show("AutoSize")

	WinWaitClose(selectType_hwnd)

	if !shouldContinue
		return

	if selection_type = "File" {
		flag := "S"
		blobbie := "/blob/main/"
	}
	else if selection_type = "Folder" {
		flag := "D"
		blobbie := "/tree/main/"
	}

	selected_path := FileSelect(flag, programming_path, "Select a " selection_type " to get the github link of: ")

	if !selected_path
		return

	relative_path := StrReplace(selected_path, programming_path "\") ;C:\Programming\Main\Lib\Win.ahk => Main\Lib\Win.ahk

	RegexMatch(relative_path, "(\w+)\\(.*)", &match_split)
	project_folder := match_split[1]
	project_file := StrReplace(match_split[2], " ", "%20")

	account := "https://github.com/Axlefublr/"

	link := StrReplace(account project_folder blobbie project_file, "\", "/")

	return link
}

;PLAYER~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

player_SkipOpening() {
	Send "{F12 8}"
}

;VIDEO~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

video_EditLastScreenshot() {
	d_Path_Name := Map()

	Loop Files Paths.Materials "\*.png" {
		RegexMatch(A_LoopFileName, "^\d+", &IntPartOfFileName)
		d_Path_Name.Set(A_LoopFileFullPath, IntPartOfFileName[0])
	}

	highestFileNum := 0

	for key, value in d_Path_Name {
		if value > highestFileNum {
			highestFileNum := value
			latestFilePath := key
		}
	}

	RunWith(Paths.Apps["Gimp"], latestFilePath)
}

video_DuplicateScreenshot() {
	file_path := FileSelect('s', Paths.Materials, 'Choose a screenshot to duplicate')

	SplitPath(file_path, &file_fullname)
	file_name := RegexReplace(file_fullname, '\d+')

	screenshot_numbers := []
	Loop Files Paths.Materials "\*.png" {
		RegexMatch(A_LoopFileName, '\d+', &currentFile_number)
		screenshot_numbers.Push(currentFile_number[0])
	}
	screenshot_numbers := InsertionSort(screenshot_numbers)

	nextNumber := screenshot_numbers[-1] + 1

	newFile_path := Paths.Materials "\" nextNumber file_name

	FileCopy(file_path, newFile_path, 1)
	win_RunAct_Folders(Paths.Materials)
}

;DAVINCI~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

davinci_Insert() {
	ControlClick("X79 Y151", "ahk_exe Resolve.exe",, "R")
	Send("{Down 2}{Enter}")
	WinWaitActive("New Timeline Properties")
	Send("{Enter}")
}




screenshot_Rectangle() {
	ClickThenGoBack("839 6")
}

screenshot_Window() {
	ClickThenGoBack("959 6")
}

screenshot_Fullscreen() {
	ClickThenGoBack("1019 6")
}




explorer_Rename() {
	Send "{F2}"
}