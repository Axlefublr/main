#Include <Base>
#Include <App>
#Include <Press>
#Include <Global>
#Include <Script>
#Include <Win>
#Include <Other>
#Include <Tools>
#Include <Image>

#MaxThreadsBuffer true
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Media_Stop & XButton1:: {
   MouseGetPos &sectionX, &sectionY
   right         := (sectionX > 1368)
   , left        := (sectionX < 568)
   , down        := (sectionY > 747)
   , up          := (sectionY < 347)
   , deffault    := !right && !left && !down && !up
   || WinActive("Skillfactory " Browser.exeTitle)
   || WinActive("Gogoanime " Browser.exeTitle)
   Switch {
      Case deffault:Cut()
      Case WinActive(Youtube.winTitle):Youtube.StudioSwitch()
      Case WinActive(Discord.winTitle):Discord.Emoji()
      Case WinActive(VsCode.winTitle):
      Switch {
         Case right:VsCode.IndentRight()
         Case left:VsCode.IndentLeft()
         Case up:VsCode.DeleteLine()
         Case down:VsCode.Comment()
      }
   }
}

Media_Stop & XButton2:: {
   MouseGetPos &sectionX, &sectionY
   right         := (sectionX > 1368)
   , left        := (sectionX < 568)
   , down        := (sectionY > 747)
   , up          := (sectionY < 347)
   , deffault    := !right && !left && !down && !up
   Switch {
      Case deffault:WinPaste()
      Case up:Send("{Browser_Forward}")
      Case down:Send("{Browser_Back}")
      Case WinActive(Youtube.Studio):Youtube.ToYouTube()
      Case WinActive(Youtube.winTitle):Youtube.ChannelSwitch()
      Case WinActive("GitHub " Browser.exeTitle):GitHub.Profile()
      Case WinActive(VK.winTitle):VK.Voice()
      Case WinActive(Telegram.winTitle):Telegram.Voice()
      Case WinActive(Discord.winTitle):Discord.Gif()
   }
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SCROLL_VERTICALLY := true
#c::global SCROLL_VERTICALLY := !SCROLL_VERTICALLY

#HotIf SCROLL_VERTICALLY
#WheelUp::WheelLeft
#WheelDown::WheelRight
#HotIf !SCROLL_VERTICALLY
WheelUp::WheelLeft
WheelDown::WheelRight
#WheelUp::WheelUp
#WheelDown::WheelDown
#HotIf

XButton2 & XButton1::Escape
XButton1 & XButton2::Media_Play_Pause

XButton1 & WheelUp::Redo()
XButton1 & WheelDown::Undo()

XButton2 & WheelUp::ifTopLeft_Sugar(Send.Bind("{Volume_Up}"), TransAndProud.Bind(20))
XButton2 & WheelDown::ifTopLeft_Sugar(Send.Bind("{Volume_Down}"), TransAndProud.Bind(-20))

XButton1 & LButton::press_Hold_Sugar(Send.Bind("{BackSpace}"), SelectAll)
XButton1 & RButton::Delete

XButton2 & RButton::PrintScreen
XButton2 & LButton::Enter

XButton2 & MButton::Screenshot.FullScreenOut()
XButton1 & MButton::HoverScreenshot()

#!LButton::Hider(false)
#LButton::Hider()

Media_Stop & RButton::scr_Reload()
Media_Stop & MButton::F5
Media_Stop & LButton::Screenshot.Start()

XButton1 & Media_Stop::scr_Test()
XButton2 & Media_Stop::scr_ExitTest()
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Media_Stop:: {
   MouseGetPos &sectionX, &sectionY
   right         := (sectionX > 1368)
   , left        := (sectionX < 568)
   , down        := (sectionY > 747)
   , up          := (sectionY < 347)
   , topRight    := ((sectionX > 1707) && (sectionY < 233))
   , topLeft     := ((sectionX < 252) && (sectionY < 229))
   , bottomLeft  := ((sectionX < 263) && (sectionY > 849))
   , bottomRight := ((sectionX > 1673) && (sectionY > 839))
   
   Switch {
      Case topRight:GroupDeactivate("Main")
      Case bottomRight:
         static telegramObj := Win({
            winTitle: Telegram.winTitle,
            exePath: Paths.Apps["Telegram"]
         })
         telegramObj.App()
      Case right:
         static discordObj := Win({
            winTitle: Discord.winTitle,
            exePath: Paths.Apps["Discord"],
            exception: Discord.exception
         })
         discordObj.App()
      Case topLeft:
         static terminalObj := Win({
            winTitle: "ahk_group Terminal",
            exePath: Paths.Apps["Terminal"]
         })
         terminalObj.App()
      Case bottomLeft:
         static obsObj := Win({
            winTitle: "OBS ahk_exe obs64.exe",
            exePath: Paths.Apps["OBS"],
            startIn: Paths.OBSFolder
         })
         obsObj.App()
      Case left:
         static vscodeObj := Win({
            winTitle: VsCode.winTitle,
            exePath: Paths.Apps["VS Code"]
         })
         vscodeObj.App()
      Case down:
         static spotifyObj := Win({
            winTitle: Spotify.winTitle,
            exePath: Paths.Apps["Spotify"]
         })
         spotifyObj.App()
      Case up:
         static browserObj := Win({
            winTitle: Browser.winTitle,
            exePath: Paths.Apps["Google Chrome"]
         })
         browserObj.App()
      Default:AltTab()
   }
   
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
XButton2:: {
   MouseGetPos &sectionX, &sectionY
   right  := (sectionX > 1368)
   , left := (sectionX < 568)
   , down := (sectionY > 747)
   , up   := (sectionY < 347)
   Switch {
      Case right:Send("{Media_Next}")
      Case left:Send("{Media_Prev}")
      Case down:CloseButActually()
      Case up:Win().Minimize()
      Default:Paste()
   }
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
XButton1:: {
   MouseGetPos &sectionX, &sectionY
   right         := (sectionX > 1368)
   , left        := (sectionX < 568)
   , down        := (sectionY > 747)
   , up          := (sectionY < 347)
   , topRight    := ((sectionX > 1707) && (sectionY < 233))
   , topLeft     := ((sectionX < 252) && (sectionY < 229))
   , bottomLeft  := ((sectionX < 263) && (sectionY > 849))
   , bottomRight := ((sectionX > 1673) && (sectionY > 839))
   , deffault    := !right && !left && !down && !up
   Switch {
      Case deffault:Copy()
      Case WinActive(Browser.winTitle):
      Switch {
         Case right:   NextTab()
         Case left:    PrevTab()
         Case up:      RestoreTab()
         Case WinActive(VK.winTitle):VK.Scroll()
         Case down:    CloseTab()
      }
      Case WinActive(VsCode.winTitle) || WinActive("ahk_group Terminal"):
      Switch {
         Case bottomRight:scr_Reload()
         Case right:      NextTab()
         Case bottomLeft: scr_Test()
         Case left:       PrevTab()
         Case down:       VsCode.CloseTab()
         Case up:         RestoreTab()
      }
      Case WinActive(Spotify.winTitle):
      Switch {
         Case topRight:   Spotify.NewDiscovery()
         Case bottomRight:Spotify.Discovery()
         Case topLeft:    Spotify.Context()
         Case bottomLeft: Spotify.FavRapper_Auto()
         Case up:         Spotify.Like()
         Case down:       Spotify.Shuffle()
      }
      Case WinActive(Telegram.winTitle) && down:Telegram.Scroll()
      Case WinActive(Discord.winTitle) && down:Send("{Esc}")
   }
}
#MaxThreadsBuffer false
