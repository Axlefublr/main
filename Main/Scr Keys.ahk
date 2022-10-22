;;DIRECTIVES
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Requires AutoHotkey v2.0-a
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
#WinActivateForce ;Forces windows to be activated, skipping the gentle method
#InputLevel 5 ;Makes sure hotkeys can't activate themselves (effectively $ on every hotkey)
#HotIf ;At the start to autoresolve "this hotkey already exists" conflicts
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's
CoordMode "Pixel", "Client" ;Because controlclick also uses client
SetControlDelay -1 ;Even faster controlclick
KeyHistory 0
SetWorkingDir A_ScriptDir "\..\" ;Ensures a consistent A_WorkingDir.
A_MaxHotkeysPerInterval := 1000 ;Removes the limitation of 35 hotkeys per second

;;INCLUDES
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Include <All>

#SuspendExempt true
ScrollLock::scr_Reload()
+ScrollLock::scr_Suspend()
#ScrollLock::SystemReboot()
#Pause::SystemPowerDown()
Pause::scr_Test()
!Pause::scr_ExitTest()
#SuspendExempt false

#Include Scr Groups.ahk
#Include Scr Runner.ahk
#Include Scr App.ahk
#Include Scr Mouse.ahk
#Include Scr Win.ahk

;;SPECIAL
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;Alt + number sends the Unicode for a specific Symbol, making that work anywhere. These hotkeys only work in windows that are messengers
;🥺😋🤯😼😎😩🤤👉👈
#y::Symbol("pleading")
#u::Symbol("yum")
#i::Symbol("exploding head")
#o::Symbol("smirk cat")
#p::Symbol("sunglasses")
#sc1a::Symbol("weary")
#sc1b::Symbol("drooling")
#sc2b::Symbol(["finger right", "finger left"])
;😭🧐😳🤨🤔—💀
#6::Symbol("sob")
#7::Symbol("face with monocle")
#8::Symbol("flushed")
#9::Symbol("face with raised eyebrow")
#0::Symbol("thinking")
#-::Symbol("long dash", " ")
#=::Symbol("skull")
;😨😈💜🙄🤝🤷🤓
#F5::Symbol("fearful")
#F6::Symbol("smiling imp")
#F7::Symbol("purple heart")
#F8::Symbol("rolling eyes")
#F9::Symbol("handshake")
#F10::Symbol("shrug")
#F11::Symbol("nerd")

;;REMAPPED IN VSCODE
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#InputLevel 6
#HotIf !WinActive("Visual Studio Code ahk_exe Code.exe")
!Insert::Cut()
^j::Find()

#HotIf

;;BASE HOTKEYS
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+^BackSpace::Send("^{Delete}")
#j::SelectAll()
#h::Paste()
#Insert::WinPaste()
#vkde::Copy()
+!Left::
#^j::Undo()
+!Right::
#^k::Redo()
!BackSpace::Delete

;;FULL REMAPS
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Space::return
AppsKey::RCtrl

Launch_Media::Launch_App1 ;F1
Media_Play_Pause::Launch_App2 ;F2
; Media_Stop::return ;F3
Media_Prev::return ;F4
Media_Next::return ;F5
Volume_Mute::return ;F6
; Volume_Up::return ;F7
; Volume_Down::return ;F8
Launch_App1::return ;F9
Launch_Mail::return ;F10
; Launch_App2::return ;F11
Browser_Home::return ;F12

NumpadMult::return
NumpadDiv::return
NumpadEnter::return

;;FUNCTIONAL
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<+Escape::WindowsClock()
#Escape::Infos(GetWeather())

CapsLock::
RAlt::
Launch_App2::SomeLockHint("CapsLock")  
!CapsLock::
!RAlt::
!Launch_App2::CloseButActually()
+CapsLock::
+RAlt::
+Launch_App2::Counter()  

PrintScreen::ScreenSnip()
#PrintScreen::screenshot_Fullscreen_Edit()

+!f::tool_CoordGetter()
+!g::tool_WindowGetter()
+!v::tool_RelativeCoordGetter()
^+s::Snake(20, 50, 1.7)
#d::HoverScreenshot()
#f::Hider(0x171717)

;;MOVING
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Up::win_Maximize()
#Down::win_RestoreDown()
#Right::win_RestoreLeftRight("right")
#Left::win_RestoreLeftRight("left")

!j::Send("{Down}")
!k::Send("{Up}")
!h::Send("{Left}")
!l::Send("{Right}")

^!h::Send("^{Left}")
^!l::Send("^{Right}")

#!Up::
#!k::Send("{WheelUp}")
#!Down::
#!j::Send("{WheelDown}")
#!Right::
#!l::Send("{WheelRight}")
#!Left::
#!h::Send("{WheelLeft}")

>^Home::Volume_Up
>^End::Volume_Down
>^Insert::Volume_Mute
>^Delete::Media_Play_Pause
>^PgUp::Media_Prev
>^Pgdn::Media_Next

;;NUMLOCK
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NumpadDown::scr_Reload()
!NumpadDown::scr_HardReload()
+NumpadDown::scr_Suspend()
#NumpadDown::SystemReboot()

NumpadPgDn::scr_Test()
!NumpadPgDn::scr_ExitTest()

NumpadLeft::Delete
NumpadClear::End
NumpadRight::PgDn
NumpadUp::Home
NumpadPgUp::PgUp

NumpadHome:: {
   if press_Hold()
      SelectAll()
}
#NumpadHome::WinPaste()
!NumpadHome::Cut()
^NumpadHome::Copy()
+NumpadHome::Paste()

NumpadIns & NumpadUp::Volume_Up
NumpadIns & NumpadClear::Volume_Down
NumpadIns & NumpadHome::Volume_Mute
NumpadIns & NumpadLeft::Media_Play_Pause
NumpadIns & NumpadPgUp::Media_Prev
NumpadIns & NumpadRight::Media_Next

NumLock::SomeLockHint("NumLock")

NumpadAdd::WheelUp
NumpadSub::WheelDown
+NumpadAdd::WheelLeft
+NumpadSub::WheelRight

Numpad0::0
Numpad1::1
Numpad2::2
Numpad3::3
Numpad4::4
Numpad5::5
Numpad6::6
Numpad7::7
Numpad8::8
Numpad9::9

#InputLevel 5
Info(A_AhkPath.Replace(Paths.AutoHotkey "\"))