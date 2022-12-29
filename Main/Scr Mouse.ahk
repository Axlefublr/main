#Include <Base>
#Include <App>
#Include <Press>
#Include <Global>
#Include <Script>
#Include <Win>
#Include <Other>
#Include <Tools>
#Include <Image>
#Include <Press>

#MaxThreadsBuffer true

;;Singular mappings
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
XButton1 & MButton::try HoverScreenshot().SelectPath().Show()

#!LButton::Hider(false)
#LButton::Hider()

; Media_Stop & RButton::
Media_Stop & MButton::F5
Media_Stop & LButton::Screenshot.Start()

XButton2 & Media_Stop::scr_Reload()

;;App window manipulation
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Media_Stop:: {
   sections := GetSections()
   Switch {
      Case sections.topRight:    GroupDeactivate("Main")
      Case sections.bottomRight: Telegram.winObj.App()
      Case sections.right:       Discord.winObj.App()
      Case sections.topLeft:     Terminal.winObj.App()
      Case sections.bottomLeft:
         SetTitleMatchMode("Regex")
         Explorer.winObjRegex.MinMax()
      Case sections.left:        VsCode.winObj.App()
      Case sections.down:        Spotify.winObj.App()
      Case sections.up:          Browser.winObj.App()
      Default:                   AltTab()
   }

}

;;General window manipulation
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
XButton1 & Media_Stop:: {
   sections := GetSections()
   Switch {
      case sections.up:   Win.Maximize()
      case sections.down: Win.RestoreDown()
   }
}
;;Media + Window manipulation
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
XButton2:: {
   sections := GetSections()
   Switch {
      Case sections.right: Send("{Media_Next}")
      Case sections.left: Send("{Media_Prev}")
      Case sections.down:CloseButActually()
      Case sections.up:Win.Minimize()
      Default:Paste()
   }
}

;;In-app actions
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
XButton1:: {
   sections := GetSections()
   Switch {
      Case sections.middle:Copy()
      Case WinActive(Browser.winTitle):
         Switch {
            Case sections.right:         NextTab()
            Case sections.left:          PrevTab()
            Case sections.up:            RestoreTab()
            Case WinActive(VK.winTitle): VK.Scroll()
            Case sections.down:          CloseTab()
         }
      Case WinActive(VsCode.winTitle) || WinActive(Terminal.winTitle):
         Switch {
            Case sections.bottomRight:scr_Reload()
            Case sections.right:      NextTab()
            Case sections.bottomLeft: scr_Test()
            Case sections.left:       PrevTab()
            Case sections.down:       VsCode.CloseTab()
            Case sections.up:         RestoreTab()
         }
      Case WinActive(Spotify.exeTitle):
         Switch {
            Case sections.topRight:   Spotify.NewDiscovery()
            Case sections.bottomRight:Spotify.Discovery()
            Case sections.topLeft:    Spotify.Context()
            Case sections.bottomLeft: Spotify.FavRapper_Auto()
            Case sections.up:         Spotify.Like()
            Case sections.down:       Spotify.Shuffle()
         }
      Case WinActive(Telegram.winTitle) && sections.down:Telegram.Scroll()
      Case WinActive(Discord.winTitle)  && sections.down:Send("{Esc}")
   }
}

;;Additional in-app actions
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Media_Stop & XButton1:: {
   sections := GetSections()
   Switch {
      Case sections.middle:Cut()
      Case WinActive(Youtube.winTitle):Youtube.StudioSwitch()
      Case WinActive(Discord.winTitle):Discord.Emoji()
   }
}

Media_Stop & XButton2:: {
   sections := GetSections()
   Switch {
      Case sections.middle:WinPaste()
      Case sections.up:Send("{Browser_Forward}")
      Case sections.down:Send("{Browser_Back}")
      Case WinActive(Youtube.Studio):Youtube.ToYouTube()
      Case WinActive(Youtube.winTitle):Youtube.ChannelSwitch()
      Case WinActive("GitHub " Browser.exeTitle):GitHub.Profile()
      Case WinActive(VK.winTitle):VK.Voice()
      Case WinActive(Telegram.winTitle):Telegram.Voice()
      Case WinActive(Discord.winTitle):Discord.Gif()
   }
}

#MaxThreadsBuffer false
