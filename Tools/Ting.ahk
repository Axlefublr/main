#Include <Directives\Base>
#Include <Paths>
#Include <Tools\Info>

SoundPlay(Paths.Ptf["ting"])
inst := Infos("Timer ran out!")
WinWaitClose(inst.hwnd)
ExitApp()