#Include <Directives\Base>
#Include <Tools\Info>
#Include <Scr\SoundPlayer>
#Include <Extensions\Array>

main() {
	if A_Args.Length > 0 {
		message := A_Args[1]
	} else {
		message := "Timer ran out!"
	}
	if A_Args.Length < 2 {
		SoundPlayer.Storage["ting"].Play()
	}
	inst := Infos(message)
	WinWaitClose(inst.hwnd)
	ExitApp()
}

main()