#HotIf !WinActive("ahk_group Game")
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
XButton1 & Media_Stop:: {
	Switch {
		Case youtube_isNotWatchingVid():youtube_Miniscreen()
		Case youtube_isWatchingVid()
		, WinActive("WatchMoviesHD"):youtube_Fullscreen()
		Case WinActive("Messenger ahk_exe chrome.exe"):vk_Notifications()
		Case WinActive("ahk_exe Discord.exe"):discord_Emoji()
	}
}

XButton2 & Media_Stop:: {
	Switch {
		Case WinActive("Channel content - YouTube Studio"):youtube_ToYouTube()
		Case WinActive("YouTube"):youtube_ChannelSwitch()
		Case WinActive("Messenger ahk_exe chrome.exe"):vk_Voice()
		Case WinActive("ahk_exe Telegram.exe"):telegram_Voice()
		Case WinActive("ahk_exe Discord.exe"): discord_Gif()
	}
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Media_Stop & XButton1::press_Hold_Sugar(Copy, Cut)
Media_Stop & XButton2::press_Hold_Sugar(Paste, WinPaste)

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
	, topRight    := ((sectionX > 1707) && (sectionY < 233))
	, topLeft     := ((sectionX < 252) && (sectionY < 229))
	, bottomLeft  := ((sectionX < 263) && (sectionY > 849))
	, bottomRight := ((sectionX > 1673) && (sectionY > 839))
	Switch {
		Case topRight:   win_Maximize()
		Case bottomRight:win_App("Telegram ahk_exe Telegram.exe", Paths.Apps["Telegram"])
		Case right:      win_App("Discord ahk_exe Discord.exe", Paths.Apps["Discord"])
		Case topLeft:    win_RestoreDown()
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
	right      := (sectionX > 1368)
	, left     := (sectionX < 568)
	, down     := (sectionY > 747)
	, up       := (sectionY < 347)
	, topRight := ((sectionX > 1707) && (sectionY < 233))
	Switch {
		Case right:
			Switch {
				Case youtube_isWatchingVid():youtube_SkipNext()
				Case WinActive("ahk_exe Spotify"):spotify_SkipNext()
				Default:Send("{Media_Next}")
			}
		Case left:
			Switch {
				Case youtube_isWatchingVid():youtube_SkipPrev()
				Case WinActive("ahk_exe Spotify"):spotify_SkipPrev()
				Default:Send("{Media_Prev}")
			}
		Case down
		&& WinActive("ahk_exe Spotify.exe"):spotify_Close()
		Case down:                          CloseButForSure()
		Case up:                            win_Minimize()
		Case WinActive("ahk_exe Code.exe"): vscode_DeleteLine()
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
	Switch {
		Case WinActive("Google Chrome"):
			Switch {
				Case topRight:RestoreTab()
				Case right:   NextTab()
				Case left:    PrevTab()
				Case up:      NewTab()
				Case down
				&& WinActive("Messenger ahk_exe chrome.exe"):vk_Scroll()
				Case down:    CloseTab()
			}
		Case WinActive("ahk_exe Code.exe"):
			Switch {
				Default:         vscode_Comment()
				Case topRight:   vscode_IndentRight()
				Case bottomRight:scr_Reload()
				Case right:      NextTab()
				Case topLeft:    vscode_IndentLeft()
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
		Case WinActive("ahk_exe Discord.exe") && down: Send("{Esc}")
		Case WinActive("ahk_exe Telegram.exe") && down:telegram_Scroll()
	}
}

#HotIf