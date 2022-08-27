﻿#Include <Main>

;CHROME~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

chrome_CopyLink() => (
		Send("^l"),
		KeyWait(A_ThisHotkey_Formatted(), "U"),
		Copy()
	)

chrome_CloseAllTabs := Send.Bind("+!w")

;SPOTIFY~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

spotify_Like := Send.Bind("+!b")

spotify_Shuffle := Send.Bind("^s")

spotify_SkipNext := Send.Bind("^{Right}")

spotify_SkipPrev := Send.Bind("^{Left}")

spotify_LikedPlaylist := Send.Bind("+!s")

spotify_Close := Send.Bind("^+q")

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
	g_added.SetFont("s50 c0xC5C5C5", "Consolas")
	g_added_text := g_added.Add("Text", "W200 X0 Y60 Center", "0")
	g_added.Show("W200 H200 X0 Y0 NA")

	HotIfWinActive("ahk_exe Spotify.exe")
	Hotkey("RButton", onRightClick.Bind(), "On")
	Hotkey("Escape", Destruction.Bind(), "On")
	g_added.OnEvent("Close", Destruction.Bind())
	g_added_text.OnEvent("Click", (*) => var := g_added_text.Text := g_added_text.Text - 1)	;We update the number we *see* with the one just lower than it, and also update the amount of tracks until destruction (var)
	g_added_text.OnEvent("DoubleClick", Destruction.Bind())

	isStarted := True
}

spotify_GetCurrSong() {
	currSong := WinGetTitle("ahk_exe Spotify.exe")
	if currSong = "Spotify Free"
		return False
	return currSong
}

spotify_GetCurrSong_ToClip() => A_Clipboard := spotify_GetCurrSong()

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

spotify_Context() => (
		ControlClick("X22 Y1015", "ahk_exe Spotify.exe", , "R"),
		Send("{Up 2}")
	)

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

;YOUTUBE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

youtube_SkipNext := Send.Bind("+n")

youtube_SkipPrev := Send.Bind("+p")

youtube_Seek(direction) {
	Switch direction {
		Case "right": Send("l")
		Case "left": Send("j")
	}
}

youtube_Fullscreen() => (LanguageEng(), Send("f"))

youtube_Miniscreen() => (LanguageEng(), Send("i"))

youtube_MiniscreenClose := ControlClick.Bind("X1858 Y665")

youtube_ChannelSwitch() => (
		ControlClick("X1823 Y133"),
		WaitUntilImage(Paths.Ptf["switch account ytt"]),
		ControlClick("X1524 Y400")
	)

youtube_ToYouTube() => (
		ControlClick("X1865 Y130"),
		WaitClick(Paths.Ptf["youtube logo"])
	)

youtube_isWatchingVid() => WinActive(" - YouTube ahk_exe chrome.exe")
	&& !WinActive("Watch later ahk_exe chrome.exe")
	&& !WinActive("Subscriptions ahk_exe chrome.exe")

youtube_isNotWatchingVid() => WinActive("Watch later ahk_exe chrome.exe")
	|| WinActive("Subscriptions ahk_exe chrome.exe")
	|| (WinActive("YouTube ahk_exe chrome.exe")
		&& !WinActive(" - YouTube"))

;VK~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vk_Notifications := ControlClick.Bind("X788 Y126")

vk_Voice := ControlClick.Bind("X1757 Y1014")

vk_Scroll := ControlClick.Bind("X1750 Y903")

;TELEGRAM~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

telegram_Voice := ClickThenGoBack_Event.Bind("1452 1052")

telegram_Scroll := ControlClick.Bind("X1434 Y964")

telegram_Channel(channelToFind) => (
		ControlClick("X456 Y74"),
		Send(channelToFind),
		Send("{Enter}")
	)

telegram_Diary() {
	diary := ReadFile(Paths.Ptf["Diary"])
	WriteFile(Paths.Ptf["Diary"])
	win_RunAct("Telegram ahk_exe Telegram.exe", Paths.Apps["Telegram"])
	telegram_Channel("Diary")
	ClipSend(diary)
	Send("{Enter}")
}

;DISCORD~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

discord_Emoji := Send.Bind("^e")

discord_Gif := Send.Bind("^g")

discord_Reply := CtrlClick

discord_React() {
	ImageSearch(&reactX, &reactY, 1730, 88, 1820, 995, Paths.Ptf["react"])
	try ControlClick("X" reactX " Y" reactY, "ahk_exe Discord.exe")
}

discord_DeleteMessage := Send.Bind("{Delete Down}{Click}{Delete Up}")

vscode_IndentRight := Send.Bind("^!{Right}")

vscode_IndentLeft := Send.Bind("^!{Left}")

vscode_Comment := Send.Bind("#{End}")

vscode_RunCurrentFile := Send.Bind("+!o")

vscode_KillTerminal := Send.Bind("^!o")

vscode_Debug := Send.Bind("^+9")

vscode_CloseAllTabs := Send.Bind("+!w")

vscode_DeleteLine := Send.Bind("+{Delete}")

vscode_Reload := Send.Bind("+!y")

vscode_FoldCodeBlock := Send.Bind("{Click}^l")

vscode_CloseTab := Send.Bind("!w")

vscode_CursorBack := Send.Bind("!{PgUp}")

vscode_CursorForward := Send.Bind("!{PgDn}")

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
	file_Path := vscode_GetCurrentFileFullPath()
	file_Text := ReadFile(file_Path)
	file_Text := StrReplace(file_Text, selection, "")
	file_Text .= selection
	WriteFile(file_Path, file_Text)
}

vscode_ToEndOfOthrFile(otherFilePath) {
	selection := str_GetSelection()
	file_Path := vscode_GetCurrentFileFullPath()
	file_Text := ReadFile(file_Path)
	file_Text := StrReplace(file_Text, selection, "")
	WriteFile(file_Path, file_Text)
	AppendFile(otherFilePath, selection)
}

vscode_WorkSpace(wkspName) {
	vscode_CloseAllTabs()
	win_Close("ahk_exe Code.exe")
	Run(Paths.Ptf[wkspName], , "Max")
}

vscode_toCommitMessage(changeNotes_rawFile) {
	if !changeNotes_rawFile
		return ""

	/*
		Making it easy to work with regex
		Why I'm not using ^ and $ and instead am using workarounds: I get the text as a string, and even though it has newlines and the like, it's still considered to only have one start of the line
		I know going step by step is inefficient, but this improves mantainability and stability, since if I take care of things one at a time, I won't be able to miss anything. It's so fast that I can't notice anyway. I'd rather be able to change things more easily
	 */

	changeNotes := StrReplace(changeNotes_rawFile, "`t", " ")	;Replacing tabs with spaces
	changeNotes := StrReplace(changeNotes, "`r`n", "`n")	;Removing the annoying \r (returns), to not have to care about them in the regex
	changeNotes := RegexReplace(changeNotes, " *\n", "`n")	;Removing all trailing whitespace
	changeNotes := RegexReplace(changeNotes, " {2,}", " ")	;Only one space instead of potentially many (inline)
	changeNotes := RegexReplace(changeNotes, "\n{3,}", "`n`n")	;Only two newlines instead of potentially many

	changeNotes := RegexReplace(changeNotes, "\n#+ ", "`n")	;I can use the # character as normal, unless it's at the start and with a space, meaning is a md label
	changeNotes := RegexReplace(changeNotes, "\n>+ ", "`n")
	changeNotes := RegexReplace(changeNotes, "^#+ ")	;The first label won't have a newline before it and it is also the beginning of the text, so that's why we can use ^
	changeNotes := RegexReplace(changeNotes, "^>+ ")

	changeNotes := StrReplace(changeNotes, ":`n* ", ": ")	;When a line ends with :, it's a marker for a list
	changeNotes := StrReplace(changeNotes, "`n* ", ", ")	;All the following items in the list will have commas between them, even if I forget a :, there will just be commas between all of them

	changeNotes := RegexReplace(changeNotes, "(?<![.:])\n\n", ". ")	;Double newlines are connected by a dot
	changeNotes := StrReplace(changeNotes, "`n`n", " ")	;If I added the dot myself, we just replace those two newlines with a space
	changeNotes := StrReplace(changeNotes, "`n", " ")	;On the off-chance I missed something, or something broke

	changeNotes := StrReplace(changeNotes, '"', "'")	;double quotes are not allowed in cmd, or rather they will cause trouble

	return changeNotes
}

vscode_CleanText() {
	clean := ReadFile(Paths.Ptf["Raw"])
	clean := StrReplace(clean, "`r`n", "`n")	;making it easy for regex to work its magic by removing returns
	clean := RegexReplace(clean, "m)^\* .*\n(\n)?")	;removing bullets and their additional newlines

	RegexMatch(clean, "s)---\n(.*)", &description_regexed)	;Getting the description that's manually written

	clean := RegexReplace(clean, "s)---\n.*")	;deleting the description part of the script
	clean := RegexReplace(clean, "\n{3,}")	;removing spammed newlines
	clean := RegexReplace(clean, "m) *$")	;removing leading spaces
	clean := RegexReplace(clean, "(?<!\.)\n{2}(?=[^A-Z])", " ")	;appending continuing lines that start with a lowercase letter. if the previous line ended in a period, it's ignored

	clean_compact := StrReplace(clean, "`n`n", "`n")

	if !description_regexed
		description_manual := ''
	else
		description_manual := description_regexed[1]

	description := description_manual "`n`n" "
	(
		Learn about autohotkey v2 in the documentation: https://lexikos.github.io/v2/docs/AutoHotkey.htm
		IDE used in the video: https://code.visualstudio.com/

		My github:
		https://github.com/Axlefublr/Personal

		Catch me on the ahk discord server as Axlefublr:
		https://discord.com/invite/Aat7KHmG7v

		The video script:
	)" "`n`n" clean_compact

	WriteFile(Paths.Ptf["Clean"], clean)
	WriteFile(Paths.Ptf["Description"], description)
	Info("Text cleaned")
}

vscode_VideoUp() {
	files := [
		Paths.Ptf["Raw"],
		Paths.Ptf["Clean"],
		Paths.Ptf["Description"],
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
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

git_CommitRepo(changeNote_file, repo_path, andPush := True) {

	commitMessage := vscode_toCommitMessage(ReadFile(changeNote_file))

	program := [
			'cd "' repo_path '"',
			'git add .',
			'git commit -m "' commitMessage '"',
		]

	if andPush {
		program.Push("pause")
		program.Push("git push")
	}

	RunSpec(program, , andPush)
	WriteFile(changeNote_file)
	Out(commitMessage)
}

git_Link() {
	static programming_path := Paths.Prog

	shouldContinue := False

	g_selectType := Gui()
	g_selectType.BackColor := "171717"
	g_selectType.SetFont("s20 cC5C5C5", "Consolas")

	selectType_hwnd := g_selectType.hwnd

	g_selectType_prompt := g_selectType.Add("Text", , "What do you want to get the link of?")

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
	} else if selection_type = "Folder" {
		flag := "D"
		blobbie := "/tree/main/"
	}

	selected_path := FileSelect(flag, programming_path, "Select a " selection_type " to get the github link of: ")

	if !selected_path
		return

	relative_path := StrReplace(selected_path, programming_path "\")	;C:\Programming\Main\Lib\Win.ahk => Main\Lib\Win.ahk

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

player_SkipOpening := Send.Bind("{F12 8}")

;SHOW~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Show_GetLink(whichShow) {
	shows := Yaml(Paths.Ptf['Shows'])
	try currShowObj := shows[whichShow]
	catch any {
		Info('Show "' whichShow "`" doesn't exist yet!")
		return ""
	}
	try currShow_link := currShowObj['link']
	catch any {
		Info('Show "' whichShow "`" doesn't have a link")
		return ""
	}
	try currShow_episode := currShowObj['episode']
	catch any {
		shows[whichShow]['episode'] := 0
		currShow_episode := 0
		WriteFile(Paths.Ptf['Shows'], Yaml(shows))
	}
	return currShow_link currShow_episode + 1
}

Show_Run(whichShow) {
	try Run(Show_GetLink(whichShow))
	catch any {
		Info("There's something wrong with the link itself")
		return
	}
	win_Activate("Google Chrome ahk_exe chrome.exe")
}

Show_SetLink(show_and_link) {
	show_and_link := RegexReplace(show_and_link, " {2,}", " ")
	RegexMatch(show_and_link, "(.+) (https:\/\/[^ ]+)", &show_and_link_match)
	if !show_and_link_match {
		Info("You either forgot the link or the show name")
		return
	}

	show := show_and_link_match[1]
	link := show_and_link_match[2]

	showsJson := Yaml(Paths.Ptf['Shows'])

	try showsJson[show]	;Creating the object for the show, if it doesn't already exist
	catch any {
		Info('New object created for "' show '"')
		showsJson[show] := { episode: 0, link: "" }
	}

	showsJson[show].link := link	;We're going to set the link regardless

	WriteFile(Paths.Ptf['Shows'], Yaml(showsJson))
	Info('Set the link for the show "' show '"')
}

Show_SetEpisode(show_and_episode) {
	show_and_episode := RegexReplace(show_and_episode, " {2,}", " ")
	RegexMatch(show_and_episode, "(.+) (\d+)", &show_and_episode_match)

	show := show_and_episode_match[1]
	episode := show_and_episode_match[2]

	showsJson := Yaml(Paths.Ptf['Shows'])

	try showsJson[show]	;Creating the object for the show, if it doesn't already exist
	catch any {
		Info('New object created for "' show '"')
		showsJson[show] := { episode: 0, link: "" }
	}

	showsJson[show]["episode"] := episode

	WriteFile(Paths.Ptf['Shows'], Yaml(showsJson))
	Info('Set episode ' episode ' for the show "' show '"')
}

;VIDEO~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

video_EditScreenshot() {
	selectedFile := FileSelect("S", Paths.Materials, "Select a file to edit in gimp")
	if !selectedFile
		return

	RunWith(Paths.Apps["Gimp"], selectedFile)
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
	ControlClick("X79 Y151", "ahk_exe Resolve.exe", , "R")
	Send("{Down 2}{Enter}")
	WinWaitActive("New Timeline Properties")
	Send("{Enter}")
}

screenshot_Rectangle := ClickThenGoBack.Bind("839 6")

screenshot_Window := ClickThenGoBack.Bind("959 6")

screenshot_Fullscreen := ClickThenGoBack.Bind("1019 6")

explorer_Rename := Send.Bind("{F2}")