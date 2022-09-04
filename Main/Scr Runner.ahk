+!l:: {
   prevWin := WinGetID("A")

   g_terminal := Gui("AlwaysOnTop -caption")
   g_terminal.backColor := "171717"
   g_terminal.SetFont("S16 q5 c0xC5C5C5", "Consolas")
   g_terminal_edit := g_terminal.Add("Edit", "background171717 -E0x200 Center x10 W377 h45")
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

      ;Main
      "format table to array", () => str_FormatTableToArray(),
      "remove comments",       () => str_RemoveComments(),
      "convert to json",       () => str_ConvertToJson(),
      "str len",               () => Infos(StrLen(str_GetSelection())),
      "radnum",                () => ClipSend(RadNum(), ""),
      "fs",                    () => tool_FileSearch(),
      "startup",               () => tool_StartupRun(),
      "shows",                 () => Show_GetShows(),

      ;Apps
      "ahk v1 docs",     () => win_RunAct("AutoHotkey Help", Paths.Apps["Ahk v1 docs"]),
      "slack",           () => win_RunAct("Slack ahk_exe slack.exe", Paths.Apps["Slack"]),
      "shell menu view", Run.Bind(Paths.Apps["Shell Menu View"]),
      "symlink",         Run.Bind(Paths.Ptf["Symlink creator"]),
      "sm",              Run.Bind(Paths.Apps["Sound mixer"]),
      "gimp",    () => win_RunAct("Thumbnail preset.xcf-1.0", Paths.Ptf["Thumbnail preset"], , "About GIMP ahk_exe gimp-2.10.exe"),
      "fl",      () => win_RunAct("ahk_exe FL64.exe", Paths.Ptf["FL preset"]),
      "davinci", () => win_RunAct("Project Manager", Paths.Apps["Davinci Resolve"]),
      "cmd",     () => win_RunAct("ahk_exe WindowsTerminal.exe", Paths.Apps["Terminal"]),
      "cmad",    Run.Bind('*RunAs "' Paths.Apps["Terminal"] '"',, "Max"),

      ;Win
      "apps",       () => MainApps(),
      "close apps", () => CloseMainApps(),
      "rel",        () => scr_Reload(),

      ;Folders
      "extensions", () => win_RunAct_Folders(Paths.VsCodeExtensions),
      "prog",       () => win_RunAct_Folders(Paths.Prog),

      ;Files
      "package",    Run.Bind(Paths.Ptf["Ahk++\package"]),
      "config",     Run.Bind(Paths.Ptf["Ahk++\configuration"]),
      "tmlanguage", Run.Bind(Paths.Ptf["Ahk++\tmlanguage"]),

      ;Video production
      "clean text", () => vscode_CleanText(),
      "edit",       () => video_EditScreenshot(),
      "video up",   () => vscode_VideoUp(),
      "dupl",       () => video_DuplicateScreenshot(),

      ;Music
      "track",  () => spotify_GetCurrSong_ToClip(),
      "kristi", () => spotify_SendTrackToKristi(),

      ;Github
      ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      "wk in",  () => wksp_FoldersInWorkSpace_Show(),
      "wk out", () => wksp_FoldersInProg(),
      "main",   () => vscode_WorkSpace("Main"),

      "gitlink", () => ClipSend(git_Link(), "", false),
      "gitopen", () => RunLink(git_Link()),

      ;Github nicknames
      "github micha", () => ClipSend("@Micha-ohne-el"),
      "github reiwa", () => ClipSend("@rbstrachan"),

      ;Commit repos
      "com main", () => git_CommitRepo(Paths.Ptf["Change notes"], Paths.Main, false),
      "psh main", () => git_CommitRepo(Paths.Ptf["Change notes"], Paths.Main),
      ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   )

   try runner_commands[val].Call()
   catch any {
      RegexMatch(val, "^(p|o|c|g|s|r|t|a|e|i|>|show|link|ep|delow|counter|wd|dw|fr|wka|wkr|cmd) (.+)", &result)
      static runner_regex := Map(
         "p", (input) => ClipSend(Linker(input)),
         "o", (input) => RunLink(Linker(input)),
         "c", (input) => (A_Clipboard := Linker(input), Info("Copied: " A_Clipboard)),
         "g", (input) => Googler(input),
         "s", (input) => SoundPlay(Paths.Sounds "\" input ".mp3"),
         "r", (input) => spotify_NewRapper(input),
         "t", (input) => (WriteFile(Paths.Ptf["Timer.txt"], input), Run(Paths.Ptf["Timer.ahk"])),
         "a", (input) => spotify_FavRapper_Manual(input),
         "e", (input) => Infos(Round(Eval(input), 3)),
         "i", (input) => Infos(input),
         ">", (input) => Skipper(input),
         "show",  (input) => Show_Run(input),
         "link",  (input) => Show_SetLink(input),
         "ep",    (input) => Show_SetEpisode(input),
         "delow", (input) => Show_DeleteShow(input),
         "counter", (input) => Counter(input),
         "dw", (input) => GetWeekDay(input),
         "wd", (input) => GetDayFromWeekDay(input),
         "fr", (input) => (DirDelete(Paths.Prog "\" input, true), Info(input " deleted")),
         "wka", (input) => wksp_AddFolderToWorkspace(input),
         "wkr", (input) => wksp_RemoveFolderFromWorkSpace(input),
         "cmd", (input) => RunSpec_StringWrapper(input),
      )
      try runner_regex[result[1]].Call(result[2])
   }
}