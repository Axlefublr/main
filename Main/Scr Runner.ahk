#Include <App>
#Include <ClipSend>
#Include <Links>
#Include <String>
#Include <Win>
#Include <Paths>

#Hotstring EndChars `t

;Pasting random values
:X:radnum::Send(RadNum())
:X:uclanr::Send(GetRandomWord("english"))
:X:ilandh::Send(GetRandomWord("russian"))

;Terminal completions
:X:gh::ClipSend(Linker("gh"))
:X:ghm::ClipSend(Linker("ghm"))

;Github nicknames
::micha::Micha-ohne-el
::reiwa::rbstrachan

+!l:: {
   g_terminal := Gui("AlwaysOnTop -caption")
   g_terminal.backColor := "171717"
   g_terminal.SetFont("S16 q5 c0xC5C5C5", "Consolas")
   g_terminal_edit := g_terminal.Add("Edit", "background171717 -E0x200 Center x10 W377 h45")

   gui_hwnd := g_terminal.Hwnd

   Destruction(thisHotkey, shouldContinue := false) {
      WinMinimize(gui_hwnd)
      if shouldContinue
         _Runner_Enclose(g_terminal_edit.Value)
      g_terminal.Destroy()
      HotIfWinactive("ahk_id " gui_hwnd)
      Hotkey("Escape", "Off")
      Hotkey("Enter", "Off")
   }

   HotIfWinactive("ahk_id " gui_hwnd)
   Hotkey("Enter", Destruction.Bind(, true), "On")
   Hotkey("Escape", Destruction, "On")

   g_terminal.Show("W400 H50 y20")

   _Runner_Enclose(val) {

      if !val
         return

      static runner_commands := Map(

         ;Main
         "format table to array", () => ClipSend(str_FormatTableToArray(), ""),
         "remove comments",       () => str_RemoveLineComments(),
         "convert to json",       () => ClipSend(str_ConvertToJsonSnippet(str_GetSelection()), ""),
         "str len", () => Infos(str_GetSelection().Length),
         "fs",      () => tool_FileSearch(),
         "startup", () => tool_StartupRun(),
         "shows",   () => Show_GetShows(),
         "rel",     () => scr_Reload(),

         ;Apps
         "sm", Run.Bind(Paths.Apps["Sound mixer"]),
         "ahk v1 docs", () => win_RunAct("AutoHotkey Help", Paths.Apps["Ahk v1 docs"]),
         "davinci", () => win_RunAct("Project Manager", Paths.Apps["Davinci Resolve"]),
         "slack",   () => win_RunAct("Slack ahk_exe slack.exe", Paths.Apps["Slack"]),
         "steam",   () => win_RunAct("ahk_exe steam.exe", Paths.Apps["Steam"], , "Steam - News"),
         "gimp",    () => win_RunAct("Thumbnail preset.xcf-1.0", Paths.Ptf["Thumbnail preset"], , "About GIMP ahk_exe gimp-2.10.exe"),
         "gimp2",   () => win_RunAct("Thumbnail preset down.xcf-1.0", Paths.Ptf["Thumbnail preset down"]),
         "vpn", () => win_RunAct("Proton VPN ahk_exe ProtonVPN.exe", Paths.Apps["VPN"]),
         "fl",  () => win_RunAct("ahk_exe FL64.exe", Paths.Ptf["FL preset"]),
         "ds4", () => win_RunAct("DS4Windows ahk_exe DS4Windows.exe", Paths.Apps["DS4 Windows"]),
         "obs", () => win_RunAct("OBS ahk_exe obs64.exe", Paths.Apps["OBS"],,, Paths.OBSFolder),
         "apps", MainApps,

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
         "track",  () => ClipSend(spotify_GetCurrSong()),
         "kristi", () => spotify_SendTrackToKristi(),

         ;Workspace
         "main",   () => vscode_WorkSpace("Main"),

      )

      try runner_commands[val].Call()
      catch Any {
         RegexMatch(val, "^(p|o|c|g|s|r|t|a|e|i|>|show|link|ep|delow|counter|wd|dw|fr|wka|wkr|gitlink|gitopen|install) (.+)", &result)
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
            "gitlink", (input) => ClipSend(git_Link(input), ""),
            "gitopen", (input) => RunLink(git_Link(input)),
            "install", (input) => git_InstallAhkLibrary(input),
         )
         try runner_regex[result[1]].Call(result[2])
      }
   }
}