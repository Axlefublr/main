#Include <Directives\Base>
#Include <Paths>
#Include <Tools\Info>
#Include <Extensions\Array>

main() {
	if A_Args.Length > 0 {
		message := A_Args[1]
	} else {
		message := "Timer ran out!"
	}
	inst := Infos(message)
	if A_Args.Length < 2 {
		SoundPlay(Paths.Ptf["ting"])
		SoundPlay(Paths.Ptf["ting"])
	}
	WinWaitClose(inst.hwnd)
	ExitApp()
}

main()