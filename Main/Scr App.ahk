#Include <App>
#Include <Base>
#Include <ClipSend>
#Include <Global>
#Include <Paths>
#Include <ClipSend>

;;SPOTIFY
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive("ahk_exe Spotify.exe")
!w::Spotify.Like()
!e::Spotify.LikedPlaylist()

PgDn::Spotify.SkipNext()
PgUp::Spotify.SkipPrev()

;;YOUTUBE
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive(Youtube.Studio)
:O:mmc::My ahk specific channel
:O:msc::My second channel
:O:ahk::Ahk all the way!
:O:otw::Ahk on the way?
:XO:desc::ClipSend(ReadFile(Paths.Ptf["Description"]) "`n`n")

#HotIf win_ActiveRegex(Youtube.NotWatchingVideo)
Escape::Youtube.MiniscreenClose()

#HotIf WinActive(Youtube.winTitle)
PgDn::Youtube.SkipNext()
PgUp::Youtube.SkipPrev()

Browser
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive("Google Chrome ahk_exe chrome.exe")

!1::Send("^1")
!2::Send("^2")
!3::Send("^3")
!4::Send("^4")
!5::Send("^5")
!6::Send("^6")
!7::Send("^7")
!8::Send("^8")
!9::Send("^9")
^7::PrevTab()
^8::NextTab()

!e::NewTab()

#HotIf WinActive("Google Chrome ahk_exe chrome.exe",, "Messenger")
!w::CloseTab()

;;VK
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive(VK.winTitle)
MButton::VK.Reply()

;;DISCORD
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive("ahk_exe Discord.exe")
^Space::Send("^k")

MButton::Discord.Reply()
+MButton::Discord.Reply()
^LButton::Discord.React()
!LButton::Discord.Edit()

;;VSCODE
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive(Paths.Ptf["Rappers"] " ahk_exe Code.exe")
!e:: {
   text := GetDateAndTime() " - " Spotify.RemoveDateAndTime(A_Clipboard)
   AppendFile(Paths.Ptf["Unfinished"], text)
   NextTab()
}

#HotIf WinActive("ahk_exe Code.exe")
Media_Stop & MButton::VsCode.Reload()

;;PLAYERS
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
GroupAdd("Players", "ahk_exe Spotify.exe")
GroupAdd("Players", "ahk_exe KMPlayer64.exe")
GroupAdd("Players", "WatchMoviesHD ahk_exe chrome.exe")
GroupAdd("Players", "Gogoanime ahk_exe chrome.exe")
#HotIf WinActive("ahk_group Players")
Up::Send "{Volume_Up}"
Down::Send "{Volume_Down}"

;;EDITING
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive("ahk_exe Resolve.exe")
!e::davinci_Insert()

;;DOCS
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive("ahk_group AutoHotkey_Help")
^7::Send("!n")
^8::Send("!s")
^6::Send("!c")

;;EXPLORER
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf win_ActiveRegex(Explorer.winTitleRegex)
F6::FileSystemSearch().GetInput()
#HotIf win_ActiveRegex("ahk_exe AutoHotkey64(_UIA)?\.exe|explorer\.exe")
^BackSpace::DeleteWord()

;;TERMINAL
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive("Linux ahk_exe WindowsTerminal.exe")
^BackSpace::term_DeleteWord()
:OX:fp::ClipSend(VsCode.GetLinuxPath())

;;SCREENSHOT
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#HotIf WinActive("Snip & Sketch")
XButton1 & LButton::Save()
#HotIf WinActive("ahk_exe ScreenClippingHost.exe")
WheelUp::Screenshot.Window()
WheelDown::Screenshot.Rectangle()
MButton::Screenshot.Fullscreen()
#HotIf
