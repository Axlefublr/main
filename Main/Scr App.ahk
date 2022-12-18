#Include <App>
#Include <Base>
#Include <ClipSend>
#Include <Global>
#Include <Paths>
#Include <ClipSend>

;;SPOTIFY
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive(Spotify.exeTitle)
!w::Spotify.Like()
!e::Spotify.LikedPlaylist()

PgDn::Spotify.SkipNext()
PgUp::Spotify.SkipPrev()

;;YOUTUBE
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive(Youtube.Studio)
:O:msc::My second channel!
:O:mmc::My main channel!
:O:ahk::Ahk all the way!
:XO:desc::ClipSend(ReadFile(Paths.Ptf["Description"]) "`n`n")

#HotIf Win({winTitle: Youtube.NotWatchingVideo}).ActiveRegex()
Escape::Youtube.MiniscreenClose()

#HotIf WinActive(Youtube.winTitle)
PgDn::Youtube.SkipNext()
PgUp::Youtube.SkipPrev()

;;BROWSER
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive(Browser.winTitle)

!1::Send("^1")
!2::Send("^2")
!3::Send("^3")
!4::Send("^4")
!5::Send("^5")
!6::Send("^6")
!7::Send("^7")
!8::Send("^8")
!9::Send("^9")
!sc33::PrevTab()
!sc34::NextTab()

!e::NewTab()

#HotIf WinActive(Browser.winTitle,, VK.winTitle)
!w::CloseTab()

;;VK
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive(VK.winTitle)
MButton::VK.Reply()

;;VSCODE
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive(Paths.Ptf["Rappers"] " ahk_exe Code.exe")
!e:: {
   text := GetDateAndTime() " - " Spotify.RemoveDateAndTime(A_Clipboard)
   AppendFile(Paths.Ptf["Unfinished"], text)
   NextTab()
}

#HotIf WinActive(VsCode.winTitle)
Media_Stop & MButton::VsCode.Reload()

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
