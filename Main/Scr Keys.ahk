#Requires AutoHotkey v2.0-a
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
#WinActivateForce ;Forces windows to be activated, skipping the gentle method
#Hotstring EndChars `t ;Decides the characters that can finish a hotstring
#InputLevel 5 ;Makes sure hotkeys can't activate themselves (effectively $ on every hotkey)
#HotIf ;At the start to autoresolve "this hotkey already exists" conflicts
CoordMode "Mouse", "Screen"	;Uses the coordinates of the screen rather than of the window's
CoordMode "Pixel", "Client"	;Because controlclick also uses client
SetControlDelay -1	;Even faster controlclick
KeyHistory 0
SetScrollLockState "AlwaysOff"
SetWorkingDir A_ScriptDir "\..\"	;Ensures a consistent A_WorkingDir.
A_MaxHotkeysPerInterval := 1000	;Removes the limitation of 35 hotkeys per second

;INCLUDES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;Libraries
#Include <All>

;Script parts
#Include Scr Runner.ahk
#Include Scr App.ahk
#Include Scr Mouse.ahk
#Include Scr Win.ahk

;Script hotkeys
#SuspendExempt true
ScrollLock::scr_Reload()
!ScrollLock::scr_HardReload()
+ScrollLock::scr_Suspend()
#ScrollLock::SystemReboot()
#Pause::SystemPowerDown()
Pause::scr_Test()
#SuspendExempt false

;GROUPS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
GroupAdd("Game", "ahk_exe EtG.exe")
, GroupAdd("Game", "ahk_exe isaac-ng.exe")
, GroupAdd("Game", "ahk_exe nuclearthrone.exe")
, GroupAdd("Game", "Minecraft ahk_exe javaw.exe")
, GroupAdd("Game", "ahk_exe METAL GEAR RISING REVENGEANCE.exe")
, GroupAdd("Game", "ahk_exe Chair Simulator.exe")
, GroupAdd("Game", "ahk_exe dontstarve_steam.exe")

, GroupAdd("Game_M", "ahk_exe EtG.exe")
, GroupAdd("Game_M", "ahk_exe isaac-ng.exe")
, GroupAdd("Game_M", "ahk_exe nuclearthrone.exe")
, GroupAdd("Game_M", "ahk_exe METAL GEAR RISING REVENGEANCE.exe")

, GroupAdd("Media", "Photos ahk_exe ApplicationFrameHost.exe")
, GroupAdd("Media", "ahk_exe KMPlayer64.exe")

, GroupAdd("AutoHotkey_Help", "AutoHotkey Help")
, GroupAdd("AutoHotkey_Help", "AutoHotkey v2 Help")

;SPECIAL~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:XB0*?:uclanr::Send("{BackSpace 6}" GetRandomWord("english"))
:XB0*?:ilandh::Send("{BackSpace 6}" GetRandomWord("russian"))

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
;😨😈💜
#F5::Symbol("fearful")
#F6::Symbol("smiling imp")
#F7::Symbol("purple heart")
#F8::Symbol("rolling eyes")

;MAIN~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!Escape::CloseButForSure()
+CapsLock::Cis()

RAlt::LAlt
AppsKey::LCtrl

#HotIf !WinActive("ahk_exe Code.exe")
^Space::Send("{Down}")
^+Space::Send("{Up}")

!End::DeleteInDirection("right")
!Home::DeleteInDirection("left")

+!Left::Undo()
+!Right::Redo()

+Delete::DeleteLine()

!Insert::Cut()

PrintScreen::ScreenSnip()
#HotIf

#Up::win_Maximize()
#Down::win_RestoreDown()
#Right::win_RestoreLeftRight("right")
#Left::win_RestoreLeftRight("left")

#^Up::Send "{WheelUp}"
#^Down::Send "{WheelDown}"
#^Right::Send "{WheelRight}"
#^Left::Send "{WheelLeft}"

Insert:: {
	if press_Hold()
		SelectAll()
}
#Insert::WinPaste()

;Media hotkeys
>^Home::Volume_Up
>^End::Volume_Down
>^Insert::Volume_Mute
>^Delete::Media_Play_Pause
>^PgUp::Media_Prev
>^Pgdn::Media_Next

;REMAP~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NumpadDown::scr_Reload()
!NumpadDown::scr_HardReload()
+NumpadDown::scr_Suspend()
#NumpadDown::SystemReboot()

NumpadPgDn::scr_Test()
!NumpadPgDn::Send "!{Pause}"

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

NumLock::tool_SomeLockHint("NumLock")

NumpadAdd::WheelUp
NumpadSub::WheelDown

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

Launch_Media::return	;F1
; Media_Play_Pause::return ;F2
; Media_Stop::return ;F3
Media_Prev::return	;F4

Media_Next::return	;F5

Volume_Mute::return	;F6
; Volume_Up::return ;F7
; Volume_Down::return ;F8
Launch_App1::return	;F9

Launch_Mail::return	;F10

Launch_App2::return	;F11

Browser_Home::return	;F12

NumpadMult::return
NumpadDiv::return
NumpadEnter::return

#HotIf WinActive("Minecraft ahk_group Game")
<+f::F3

#HotIf WinActive("ahk_exe METAL GEAR RISING REVENGEANCE.exe")
CapsLock::Enter
XButton2::Ctrl

;Makes sure the side mouse buttons work as intended ingame, despite their remapping outside of game
#HotIf WinActive("ahk_group Game_M")
XButton1::u
XButton2::y

#HotIf WinActive("ahk_group Game")
Media_Stop::i
CapsLock::o

#HotIf !WinActive("ahk_group Game")
CapsLock::tool_SomeLockHint("CapsLock")
#HotIf 

;TOOLS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+!f::tool_CoordGetter()
+!g::tool_WindowGetter()
+!t::tool_Clock()
+!v::tool_RelativeCoordGetter()
^+s::Snake(20, 50, 1.7)
+!k::tool_KeyCodeGetter()

Info("Script reloaded")