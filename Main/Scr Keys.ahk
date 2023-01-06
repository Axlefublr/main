#Include <Loaders\Directives\Script>

#SuspendExempt true
#!y::scr_Suspend()
#!u::scr_Reload()
#!i::scr_Test()
#!o::scr_ExitTest()
#ScrollLock::SystemReboot()
#Pause::SystemPowerDown()
#SuspendExempt false

#Include Scr Groups.ahk
#Include Scr Runner.ahk
#Include <Loaders\Scr>
#Include Scr Win.ahk

;;SPECIAL
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#InputLevel 6

#HotIf !WinActive(VsCode.winTitle)
!Insert::Cut()
^j::Find()

^!h::Send("^{Left}")
^!l::Send("^{Right}")

!j::Send("{Down}")
!k::Send("{Up}")
!h::Send("{Left}")
!l::Send("{Right}")

#^sc33::Undo()
#^sc34::Redo()
#HotIf

;;BASE HOTKEYS
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+^BackSpace::Send("^{Delete}")
#j::SelectAll()
#h::Paste()
#k::Copy()
#sc28::Cut()
Insert:: {
   if press_Hold()
      SelectAll()
}
#Insert::WinPaste()
!BackSpace::Delete
!Tab::Send("^!{Tab}")

;;FULL REMAPS
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Space::return
AppsKey::RCtrl

; Launch_Media::return     ; F1
Media_Play_Pause::return ; F2
; Media_Stop::return       ; F3
Media_Prev::return       ; F4
Media_Next::return       ; F5
Volume_Mute::return      ; F6
; Volume_Up::return        ; F7
; Volume_Down::return      ; F8
Launch_App1::return      ; F9
Launch_Mail::return      ; F10
Launch_App2::return      ; F11
Browser_Home::return     ; F12

NumpadMult::return
NumpadDiv::return
NumpadEnter::return

;;FUNCTIONAL
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Escape::Infos(GetWeather()), RemindDate()

CapsLock::SomeLockHint("CapsLock")
+CapsLock::Win.Minimize()
!CapsLock::CloseButActually()

PrintScreen::Screenshot.Start()
#PrintScreen::Screenshot.FullScreenOut()

Pause::Counter.Increment()
+Pause::Counter.Send(), Counter.Increment()
!Pause::Counter.Decrement()
+!Pause::Counter.Reset()
^CtrlBreak::Counter.Show()

ScrollLock::Stopwatch.Start(), Info("Timer started")
!ScrollLock::Infos(Stopwatch.CurrTime)

+!f::CoordGetter()
+!g::WindowGetter()
+!v::tool_RelativeCoordGetter()
#f:: {
   gHover := HoverScreenshot()
   gHover.picturePath := Paths.Ptf["Femboy"]
   gHover.Show()
}
#b::InternetSearch("Google").TriggerSearch()
Launch_Media::SoundPlay(Paths.Ptf["vine boom"])
#^sc1A::Brightness.ChangeBrightnessRelative(-10)
#^sc1B::Brightness.ChangeBrightnessRelative(10)
#!p::ClipSend(ReadFile(Paths.Ptf["Input"])), WriteFile(Paths.Ptf["Input"])
#!m::WriteFile(Paths.Ptf["Input"], A_Clipboard)

;;MOVING
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Up::Win.Maximize()
#Down::Win.RestoreDown()
#Right::Win({direction: "right"}).RestoreLeftRight()
#Left::Win({direction: "left"}).RestoreLeftRight()

#!k::Send("{WheelUp}")
#!j::Send("{WheelDown}")
#!l::Send("{PgDn}")
#!h::Send("{PgUp}")

#^h::Win.RestoreLeftRight("left")
#^l::Win.RestoreLeftRight("right")
#^k::Win.Maximize()
#^j::Win.RestoreDown()

>^Home::Volume_Up
>^End::Volume_Down
>^Insert::Volume_Mute
>^Delete::Media_Play_Pause
>^PgUp::Media_Prev
>^Pgdn::Media_Next

;;NUMLOCK
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*NumpadIns::return
*NumpadEnd::return
*NumpadDown::return
*NumpadPgDn::return
*NumpadLeft::return
*NumpadClear::return
*NumpadRight::return
*NumpadHome::return
*NumpadUp::return
*NumpadPgUp::return
*NumpadDel::return
*NumpadDiv::return
*NumpadMult::return
*NumpadAdd::return
*NumpadSub::return
*NumpadEnter::return

NumLock::SomeLockHint("NumLock")

#InputLevel 5

Info(A_AhkPath.Replace(AutoHotkey.path "\"))
RemindDate()
