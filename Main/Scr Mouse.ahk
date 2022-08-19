#HotIf !WinActive("ahk_group Game")
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Media_Stop & XButton1:: {
	MouseGetPos &sectionX, &sectionY
	right         := (sectionX > 1368)
	, left        := (sectionX < 568)
	, down        := (sectionY > 747)
	, up          := (sectionY < 347)
	, deffault    := !right && !left && !down && !up
	Switch {
		Case deffault:Cut()
		Case WinActive("Visual Studio Code ahk_exe Code.exe"):
			Switch {
				Case right:vscode_IndentRight()
				Case left:vscode_IndentLeft()
				Case up:vscode_DeleteLine()
				Case down:vscode_Comment()
			}
		Case WinActive("Discord ahk_exe Discord.exe"):discord_Emoji()
		Case WinActive("YouTube ahk_exe chrome.exe"):
			if right
				youtube_Fullscreen()
			else if left
				youtube_Miniscreen()
	}
}

Media_Stop & XButton2:: {
	MouseGetPos &sectionX, &sectionY
	right         := (sectionX > 1368)
	, left        := (sectionX < 568)
	, down        := (sectionY > 747)
	, up          := (sectionY < 347)
	, deffault    := !right && !left && !down && !up
	Switch {
		Case deffault:WinPaste()
		Case WinActive("YouTube Studio"):youtube_ToYouTube()
		Case WinActive("YouTube"):youtube_ChannelSwitch()
		Case WinActive("Messenger ahk_exe chrome.exe"):vk_Voice()
		Case WinActive("ahk_exe Telegram.exe"):telegram_Voice()
		Case WinActive("ahk_exe Discord.exe"):discord_Gif()
	}
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
XButton2 & XButton1::Escape
XButton1 & XButton2::Media_Play_Pause

CapsLock & WheelUp::WheelLeft
CapsLock & WheelDown::WheelRight

CapsLock & XButton2::Browser_Forward
CapsLock & XButton1::Browser_Back

CapsLock & Media_Stop::ScreenSnip()

XButton1 & WheelUp::Redo()
XButton1 & WheelDown::Undo()

XButton2 & WheelUp::ifTopLeft_Sugar(Send.Bind("{Volume_Up}"), TransAndProud.Bind(20))
XButton2 & WheelDown::ifTopLeft_Sugar(Send.Bind("{Volume_Down}"), TransAndProud.Bind(-20))

XButton1 & LButton::press_Hold_Sugar(Send.Bind("{BackSpace}"), SelectAll)
XButton1 & RButton::Delete

XButton2 & RButton::PrintScreen
XButton2 & LButton::Enter

Media_Stop & RButton::Send "!{Pause}"
Media_Stop & MButton::F5
Media_Stop & LButton::scr_Reload()

XButton1 & Media_Stop::return
XButton2 & Media_Stop::return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Media_Stop:: {
	MouseGetPos &sectionX, &sectionY
	right         := (sectionX > 1368)
	, left        := (sectionX < 568)
	, down        := (sectionY > 747)
	, up          := (sectionY < 347)
	; , topRight    := ((sectionX > 1707) && (sectionY < 233))
	; , topLeft     := ((sectionX < 252) && (sectionY < 229))
	, bottomLeft  := ((sectionX < 263) && (sectionY > 849))
	, bottomRight := ((sectionX > 1673) && (sectionY > 839))
	Switch {
		Case bottomRight:win_App("Telegram ahk_exe Telegram.exe", Paths.Apps["Telegram"])
		Case right:      win_App("Discord ahk_exe Discord.exe", Paths.Apps["Discord"])
		Case bottomLeft: win_App("AutoHotkey v2 Help", Paths.Apps["Ahk v2 docs"])
		Case left:       win_App("Visual Studio Code ahk_exe Code.exe", Paths.Apps["VS Code"])
		Case down:       win_App("ahk_exe Spotify.exe", Paths.Apps["Spotify"])
		Case up:         win_App("Google Chrome ahk_exe chrome.exe", Paths.Apps["Google Chrome"])
		Default:         AltTab()
	}
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
XButton2:: {
	MouseGetPos &sectionX, &sectionY
	right  := (sectionX > 1368)
	, left := (sectionX < 568)
	, down := (sectionY > 747)
	, up   := (sectionY < 347)
	Switch {
		Case right:Send("{Media_Next}")
		Case left:Send("{Media_Prev}")
		Case down:CloseButForSure()
		Case up:win_Minimize()
		Default:Paste()
	}
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
XButton1:: {
	MouseGetPos &sectionX, &sectionY
	right         := (sectionX > 1368)
	, left        := (sectionX < 568)
	, down        := (sectionY > 747)
	, up          := (sectionY < 347)
	, topRight    := ((sectionX > 1707) && (sectionY < 233))
	, topLeft     := ((sectionX < 252) && (sectionY < 229))
	, bottomLeft  := ((sectionX < 263) && (sectionY > 849))
	, bottomRight := ((sectionX > 1673) && (sectionY > 839))
	, deffault    := !right && !left && !down && !up
	Switch {
		Case deffault:Copy()
		Case WinActive("Google Chrome"):
			Switch {
				Case right:   NextTab()
				Case left:    PrevTab()
				Case up:      RestoreTab()
				Case WinActive("Messenger ahk_exe chrome.exe"):vk_Scroll()
				Case down:    CloseTab()
			}
		Case WinActive("ahk_exe Code.exe"):
			Switch {
				Case bottomRight:scr_Reload()
				Case right:      NextTab()
				Case bottomLeft: scr_Test()
				Case left:       PrevTab()
				Case down:       vscode_CloseTab()
				Case up:         RestoreTab()
			}
		Case WinActive("ahk_exe Spotify.exe"):
			Switch {
				Case topRight:   spotify_NewDiscovery()
				Case bottomRight:spotify_Discovery()
				Case topLeft:    spotify_Context()
				Case bottomLeft: spotify_FavRapper_Auto()
				Case up:         spotify_Like()
				Case down:       spotify_Shuffle()
			}
		Case WinActive("ahk_exe Telegram.exe") && down:telegram_Scroll()
	}
}

#HotIf