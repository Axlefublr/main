#Include <Directives\Base>
#Include <Tools\Info>
#Include <Scr\SoundPlayer>
#Include <Extensions\Array>

main() {
	SoundPlayer.Storage["ting"].Play()
	if A_Args.Length {
		message := A_Args.ToString(" ")
	} else {
		message := "Timer ran out!"
	}
	inst := Infos(message)
	WinWaitClose(inst.hwnd)
	ExitApp()
}

main()