+!l:: {
	prevWin := WinGetID("A")

	g_terminal := Gui("AlwaysOnTop -caption")
	g_terminal.backColor := "171717"
	g_terminal.SetFont("S16 q5 c0xC5C5C5", "Consolas")
	g_terminal_edit := g_terminal.Add("Edit", "lowercase background171717 -E0x200 Center x10 W377 h45")
	g_terminal.Show("W400 H50 y20")

	val := ""

	Destruction(*) => (
		WinActivate(prevWin),
		g_terminal.Destroy(), 
		Hotkey("Escape", "Off"),
		Hotkey("Enter", "Off")
	)

	ValueIs(*) => (
		val := g_terminal_edit.Value,
		Destruction()
	)

	Hotkey("Enter", ValueIs, "On")
	Hotkey("Escape", Destruction, "On")

	WinWaitClose(g_terminal.Hwnd)

	if !val
		return

	static runner_commands := Map(

		;APPS
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		"ahk v1 docs",     () => win_RunAct("AutoHotkey Help", Paths.Apps["Ahk v1 docs"]),
		"sort algos",      Run.Bind(Paths.Apps["Sort algos"]),
		"shell menu view", Run.Bind(Paths.Apps["Shell Menu View"]),
		"symlink",         Run.Bind(Paths.Ptf["Symlink creator"]),

		;FOLDERS
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		"extensions", () => win_RunAct_Folders(Paths.VsCodeExtensions),
		"ahk++",      () => win_RunAct_Folders(Paths.AhkPlusPlus),

		;FILES
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		"package",    Run.Bind(Paths.Ptf["Ahk++\package"]),
		"tmlanguage", Run.Bind(Paths.Ptf["Ahk++\tmLanguage"]),
		"snippets",   Run.Bind(Paths.Ptf["Ahk++\ahk snippets"]),
		"eva dark",   Run.Bind(Paths.Ptf["Eva\Dark"]),

		;ANIME
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		"one piece download", () => AnimeDownload("one piece"),
		"baki download",      () => AnimeDownload("baki"),
		"overlord down",      () => AnimeDownload("overlord"),

		;VIDEO MAKING
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		"clean text", () => vscode_CleanText(),
		"edit",       () => video_EditLastScreenshot(),
		"video up",   () => vscode_VideoUp(),
		'dupl',       () => video_DuplicateScreenshot(),

		"format table to array", () => str_FormatTableToArray(),
		"remove comments",       () => str_RemoveComments(),
		"convert to json",       () => str_ConvertToJson(),
		"main",                  () => vscode_WorkSpace("Main"),
		"kristi",                () => spotify_SendTrackToKristi(),
		"apps",                  () => MainApps(),
		"ahk++ update",          () => vscode_AhkPlusPlusUpdate(),
		"js tut",                () => vscode_JsTutorial(),
		"str len",               () => Infos(StrLen(str_GetSelection())),
		"radnum",                () => ClipSend(RadNum(), ""),
		"fs",                    () => tool_FileSearch(),


		;GITHUB
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		"gitlink", () => ClipSend(git_Link(),, False),
		"gitopen", () => RunLink(git_Link()),

		;Github nicknames
		"github micha", () => ClipSend("@Micha-ohne-el"),
		"github reiwa", () => ClipSend("@rbstrachan"),

		;Commit repos
		"com main",    () => git_CommitRepo(Paths.Ptf["Change notes"], Paths.Main, False),
		"psh main",    () => git_CommitRepo(Paths.Ptf["Change notes"], Paths.Main),

		"com synhigh", () => git_CommitRepo(Paths.Ptf["SynHigh\Change notes"], Paths.SynHigh, False),
		"psh synhigh", () => git_CommitRepo(Paths.Ptf["SynHigh\Change notes"], Paths.SynHigh),

	)

	try 
		runner_commands[val].Call()
	catch any {
		RegexMatch(val, "^(p|o|g|s|r|t|a|e) (.+)", &result)
		try {
			Switch result[1] {
				Case "p":ClipSend(Links.Links[result[2]],, False)
				Case "o":RunLink(Links.Links[result[2]])
				Case "g":Googler(result[2])
				Case "s":SoundPlay(Paths.Sounds "\" result[2] ".mp3")
				Case "r":spotify_NewRapper(result[2])
				Case "t":WriteFile(Paths.Ptf["Timer.txt"], result[2]), Run(Paths.Ptf["Timer.ahk"])
				Case "a":spotify_FavRapper_Manual(result[2])
				Case "e":Infos(Eval(result[2]))
			}
		}
	}
}
