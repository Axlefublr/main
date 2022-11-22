#Include <Win>
#Include <Global>
#Include <Links>
#Include <Tools\Info>
#Include <Press>
#Include <Paths>

#MaxThreadsBuffer true

#m::RunLink(Links["gmail"])
#sc33::RunLink(Links["ghm"])
#sc34::RunLink(Links["regex"])

#n:: {
   static winObj := Win({
      winTitle: "Monkeytype " Browser.exeTitle,
      exePath: Paths.Apps["Monkeytype"]
   })
   winObj.App()
}

<!r:: {
   static winObj := Win({
      winTitle: "ahk_group Terminal",
      exePath: Paths.Apps["Terminal"]
   })
   winObj.App()
}
<!s:: {
   static winObj := Win({
      winTitle: Spotify.winTitle,
      exePath: Paths.Apps["Spotify"]
   })
   winObj.App()
}
<!x:: {
   static winObj := Win({
      winTitle: "AutoHotkey v2 Help",
      exePath: Paths.Apps["Ahk v2 docs"]
   })
   winObj.App()
}
<!a:: {
   static winObj := Win({
      winTitle: VsCode.winTitle,
      exePath: Paths.Apps["VS Code"]
   })
   winObj.App()
}
<!c:: {
   static winObj := Win({
      winTitle: Browser.winTitle,
      exePath: Paths.Apps["Google Chrome"]
   })
   winObj.App()
}
<!q:: {
   static winObj := Win({
      winTitle: Discord.winTitle,
      exePath: Paths.Apps["Discord"],
      exception: Discord.exception
   })
   winObj.App()
}
<!t:: {
   static winObj := Win({
      winTitle: Telegram.winTitle,
      exePath: Paths.Apps["Telegram"]
   })
   winObj.App()
}
<!z:: {
   static winObj := Win({
      winTitle: "OBS ahk_exe obs64.exe",
      exePath: Paths.Apps["OBS"],
      startIn: Paths.OBSFolder
   })
   winObj.App()
}

<!d:: {
   static winObj := Win({exePath: "C:\", runOpt: "Min"})
   winObj.App_Folders()
}

<!v::{
   static winObj := Win({exePath: Paths.Pictures, runOpt: "Min"})
   winObj.App_Folders()
}

<!Escape::GroupDeactivate("Main")

#MaxThreadsBuffer false