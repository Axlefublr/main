+!l:: {
	prevWin := WinGetID('A')

	g_terminal := Gui('AlwaysOnTop -caption')
	g_terminal.backColor := '171717'
	g_terminal.SetFont('S16 q5 c0xC5C5C5', 'Consolas')
	g_terminal_edit := g_terminal.Add('Edit', 'lowercase background171717 -E0x200 Center x10 W377 h45')
	g_terminal.Show('W400 H50 y20')

	val := ''

	Destruction(*) => (
			WinActivate(prevWin),
			g_terminal.Destroy(),
			Hotkey('Escape', 'Off'),
			Hotkey('Enter', 'Off')
		)

	ValueIs(*) => (
			val := g_terminal_edit.Value,
			Destruction()
		)

	Hotkey('Enter', ValueIs, 'On')
	Hotkey('Escape', Destruction, 'On')

	WinWaitClose(g_terminal.Hwnd)

	if !val
		return

	static runner_commands := Map(

			;APPS
			;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			'ahk v1 docs', () => win_RunAct('AutoHotkey Help', Paths.Apps['Ahk v1 docs']),
			'sort algos', Run.Bind(Paths.Apps['Sort algos']),
			'shell menu view', Run.Bind(Paths.Apps['Shell Menu View']),
			'symlink', Run.Bind(Paths.Ptf['Symlink creator']),
			'sm', Run.Bind(Paths.Apps['Sound mixer']),
			'slack', () => win_RunAct("Slack ahk_exe slack.exe", Paths.Apps['Slack']),

			;FOLDERS
			;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			'extensions', () => win_RunAct_Folders(Paths.VsCodeExtensions),

			;FILES
			;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			'package', Run.Bind(Paths.Ptf['Ahk++\package']),
			'config', Run.Bind(Paths.Ptf['Ahk++\configuration']),

			;VIDEO MAKING
			;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			'clean text', () => vscode_CleanText(),
			'edit', () => video_EditScreenshot(),
			'video up', () => vscode_VideoUp(),
			'dupl', () => video_DuplicateScreenshot(),

			'format table to array', () => str_FormatTableToArray(),
			'remove comments', () => str_RemoveComments(),
			'convert to json', () => str_ConvertToJson(),
			'main', () => vscode_WorkSpace('Main'),
			'js tut', () => vscode_JsTutorial(),
			'str len', () => Infos(StrLen(str_GetSelection())),
			'radnum', () => ClipSend(RadNum(), ''),
			'fs', () => tool_FileSearch(),
			'startup', () => tool_StartupRun(),
			'shows', () => Show_GetShows(),

			;MUSIC
			;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			'track', () => spotify_GetCurrSong_ToClip(),
			'kristi', () => spotify_SendTrackToKristi(),

			;WIN
			;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			'apps', () => MainApps(),
			'close apps', () => CloseMainApps(),
			'rel', () => scr_Reload(),

			;GITHUB
			;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			'gitlink', () => ClipSend(git_Link(), "", false),
			'gitopen', () => RunLink(git_Link()),

			;Github nicknames
			'github micha', () => ClipSend('@Micha-ohne-el'),
			'github reiwa', () => ClipSend('@rbstrachan'),

			;Commit repos
			'com main', () => git_CommitRepo(Paths.Ptf['Change notes'], Paths.Main, false),
			'psh main', () => git_CommitRepo(Paths.Ptf['Change notes'], Paths.Main),

		)

	try runner_commands[val].Call()
	catch any {
		RegexMatch(val, '^(p|o|g|s|r|t|a|e|i|>|show|link|ep|delow|counter|wd|dw) (.+)', &result)
		runner_regex := Map(
			'p', () => ClipSend(Linker(result[2]), , false),
			'o', () => RunLink(Linker(result[2])),
			'g', () => Googler(result[2]),
			's', () => SoundPlay(Paths.Sounds '\' result[2] '.mp3'),
			'r', () => spotify_NewRapper(result[2]),
			't', () => (WriteFile(Paths.Ptf['Timer.txt'], result[2]), Run(Paths.Ptf['Timer.ahk'])),
			'a', () => spotify_FavRapper_Manual(result[2]),
			'e', () => Infos(Round(Eval(result[2]), 3)),
			'i', () => Infos(result[2]),
			'>', () => Skipper(result[2]),
			'show',  () => Show_Run(result[2]),
			'link',  () => Show_SetLink(result[2]),
			'ep',    () => Show_SetEpisode(result[2]),
			'delow', () => Show_DeleteShow(result[2]),
			'counter', () => Counter(result[2]),
			'dw', () => GetWeekDay(result[2]),
			'wd', () => GetDayFromWeekDay(result[2]),
		)
		try runner_regex[result[1]].Call()
	}
}