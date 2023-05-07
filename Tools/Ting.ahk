#Include <Directives\Base>
#Include <Paths>
#Include <Tools\Info>
#Include <Scr\SoundPlayer>

SoundPlayer.Storage["ting"].Play()
inst := Infos("Timer ran out!")
WinWaitClose(inst.hwnd)
ExitApp()