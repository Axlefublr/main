#Include <App>
#Include <Base>
#Include <ClipSend>
#Include <Global>
#Include <Paths>
#Include <ClipSend>

;;VSCODE
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive(Paths.Ptf["Rappers"] " ahk_exe Code.exe")
!e:: {
   text := GetDateTime() " - " Spotify.RemoveDateAndTime(A_Clipboard)
   AppendFile(Paths.Ptf["Unfinished"], text)
   NextTab()
}

#HotIf WinActive(VsCode.winTitle)
Media_Stop & MButton::VsCode.Reload()

XButton1 & WheelUp::VsCode.Redo()
XButton1 & WheelDown::VsCode.Undo()

;;PLAYERS
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf Win({winTitles: [
   Spotify.exeTitle,
   Player.winTitle,
   "WatchMoviesHD " Browser.exeTitle,
   "Gogoanime " Browser.exeTitle
]}).AreActive()
Up::Send "{Volume_Up}"
Down::Send "{Volume_Down}"

;;EDITING
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive(Davinci.winTitle)
!e::Davinci.Insert()

;;DOCS
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive("ahk_group AutoHotkey_Help")
!sc33::Send("!n")
!sc34::Send("!s")

;;EXPLORER
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf Win({winTitle: Explorer.winTitleRegex}).ActiveRegex()
F6::FileSystemSearch().GetInput()
#HotIf Win({winTitle: "ahk_exe AutoHotkey64(_UIA)?\.exe|explorer\.exe"}).ActiveRegex()
^BackSpace::DeleteWord()

;;TERMINAL
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive(Terminal.winTitle)
^BackSpace::Terminal.DeleteWord()

;;SCREENSHOT
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive(Screenshot.saveTitle)
XButton1 & LButton::Save()
#HotIf WinActive(Screenshot.winTitle)
WheelUp::Screenshot.Window()
WheelDown::Screenshot.Rectangle()
MButton::Screenshot.Fullscreen()
#HotIf
