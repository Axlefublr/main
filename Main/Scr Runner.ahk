#Include <App>
#Include <ClipSend>
#Include <Links>
#Include <String>
#Include <Win>
#Include <Paths>
#Include <Char>
#Include <String-full>
#Include <Tools>
#Include <Script>
#Include <Global>
#Include <Other>
#Include <Get>
#Include <Channel>
#Include <Tools\CleanInputBox>
#Include <App\Slack>

+!l:: {
   if !input := CleanInputBox().WaitForInput() {
      return false
   }

   static runner_commands := Map(
   
      ;Main
      "format table to array", () => ClipSend(str_FormatTableToArray(), ""),
      "remove comments",       () => str_RemoveLineComments(),
      "convert to json",       () => ClipSend(str_ConvertToJsonSnippet(str_GetSelection()), ""),

      "update",  () => GitHub.UpdateAhkLibraries(),
      "str len", () => Infos(str_GetSelection().Length),
      "startup", () => tool_StartupRun(),
      "shows",   () => Shows().GetList(),
      "rel",     () => Reload(),
      "track",   () => ClipSend(Spotify.GetCurrSong()),
      "kb",      () => KeyCodeGetter(),
      "eat",     () => EatingLogger(),
      "dt",      () => ClipSend(GetDateAndTime(), , false),

      ;Apps
      "sm",      Run.Bind(Paths.Apps["Sound mixer"]),
      "apps",    MainApps,
      "v1 docs", () => Autohotkey.Docs.v1.RunAct(),
      "davinci", () => Davinci.projectWinObj.RunAct(),
      "slack",   () => Slack.winObj.RunAct(),
      "steam",   () => Steam.winObj.RunAct(),
      "vpn",     () => VPN.winObj.RunAct(),
      "fl",      () => FL.winObj.RunAct(),
      "ds4",     () => DS4.winObj.RunAct(),
      "gi",      () => Gimp.winObj.RunAct(),
      
      ;Folders
      "ext",   () => Explorer.WinObj.VsCodeExtensions.RunAct_Folders(),
      "prog",  () => Explorer.WinObj.Prog.RunAct_Folders(),
      "saved", () => Explorer.WinObj.SavedScreenshots.RunAct_Folders(),
      "gim",   () => Explorer.WinObj.VideoTools.RunAct_Folders(),
      "main",  () => VsCode.WorkSpace("Main"),

      ;Video production
      "clean",    () => VsCode.CleanText(ReadFile(A_Clipboard)),
      "edit",     () => Video.EditScreenshot(),
      "video up", () => VsCode.VideoUp(),
      "dupl",     () => Video.DuplicateScreenshot(),
      "setup",    () => Davinci.Setup(),
      "cut",      () => LosslessCut.winObj.RunAct(),

   )

   try runner_commands[input].Call()
   catch Any {
      RegexMatch(input, "^(p|o|s|r|t|a|ev|i|show|link|ep|delow|counter|gl|go|install|chrs|dd|down|drop|disc|sy|ts|evp|cp) (.+)", &result)
      static runner_regex := Map(

         "p",       (input) => ClipSend(Links[input], , false),
         "o",       (input) => RunLink(Links[input]),
         "cp",      (input) => A_Clipboard := input,
         "s",       (input) => SoundPlay(Paths.Sounds "\" input ".mp3"),
         "r",       (input) => Spotify.NewRapper(input),
         "t",       (input) => (WriteFile(Paths.Ptf["Timer.txt"], input), Run(Paths.Ptf["Timer.ahk"])),
         "ts",      (input) => Timer(input, false),
         "a",       (input) => Spotify.FavRapper_Manual(input),
         "ev",      (input) => Infos(Calculator(input)),
         "evp",     (input) => ClipSend(Calculator(input)),
         "i",       (input) => Infos(input),
         "show",    (input) => Shows().Run(input),
         "down",    (input) => Shows().Run(input, "downloaded"),
         "link",    (input) => Shows().SetLink(input),
         "ep",      (input) => Shows().SetEpisode(input),
         "dd",      (input) => Shows().SetDownloaded(input),
         "delow",   (input) => Shows().DeleteShow(input),
         "drop",    (input) => Shows().DeleteShow(input, true),
         "counter", (input) => Info(Counter.num := input),
         "gl",      (input) => ClipSend(Git.Link(input), "", false),
         "go",      (input) => RunLink(Git.Link(input)),
         "install", (input) => Git.InstallAhkLibrary(input),
         "chrs",    (input) => ClipSend(GetStringOfRandChars(input)),
         "disc",    (input) => Spotify.NewDiscovery_Manual(input),
         "sy",      (input) => Symbol(input),

      )
      try runner_regex[result[1]].Call(result[2])
   }
}

#Hotstring EndChars `t

#sc35:: {
   input := CleanInputBox().WaitForInput()
   if !input {
      return
   }
   static DynamicHotstrings := Map(

      "radnum", () => RadNum(),
      "date",   () => GetDate(),
      "time",   () => GetTime(),
      "datetime", () => GetDateAndTime(),
      "uclanr", () => GetRandomWord("english") " ",
      "ilandh", () => GetRandomWord("russian") " ",

   )
   static StaticHotstrings := Map(

      "gh",    Links["gh"],
      "ghm",   Links["ghm"],
      "micha", "Micha-ohne-el",
      "reiwa", "rbstrachan",
      "me",    "Axlefublr",

   )
   try {
      output := DynamicHotstrings[input].Call()
   } catch Any {
      try output := StaticHotstrings[input]
      catch Any {
         return
      }
   }
   ClipSend(output)
}