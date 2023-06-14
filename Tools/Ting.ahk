#Include <Directives\Base>
#Include <Tools\Info>
#Include <Scr\SoundPlayer>
#Include <Extensions\Array>

main() {
	SoundPlayer.Storage["ting"].Play()
	if A_Args.Length {
		message := ": " A_Args.ToString(" ")
	} else {
		message := ""
	}
	inst := Infos("Timer ran out!" message)
	WinWaitClose(inst.hwnd)
	ExitApp()
}

main()