#Include <Base>
#Include <App>
#Include <Press>
#Include <Global>
#Include <Script>
#Include <Win>
#Include <Win-full>
#Include <Other>
#Include <Tools>
#Include <Image>

#MaxThreadsBuffer true
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
	, fullScreenable := WinActive("YouTube ahk_exe chrome.exe")
	|| WinActive("Skillfactory ahk_exe chrome.exe")
	|| WinActive("Gogoanime ahk_exe chrome.exe")
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
		Case up:Send("{Browser_Forward}")
		Case down:Send("{Browser_Back}")
		Case WinActive("YouTube Studio"):youtube_ToYouTube()
		Case WinActive("YouTube"):youtube_ChannelSwitch()
		Case WinActive("GitHub ahk_exe chrome.exe"):github_Profile()
		Case WinActive("Messenger ahk_exe chrome.exe"):vk_Voice()
		Case WinActive("ahk_exe Telegram.exe"):telegram_Voice()
		Case WinActive("ahk_exe Discord.exe"):discord_Gif()
	}
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SCROLL_VERTICALLY := true
#c::global SCROLL_VERTICALLY := !SCROLL_VERTICALLY

#HotIf SCROLL_VERTICALLY
#WheelUp::WheelLeft
#WheelDown::WheelRight
#HotIf !SCROLL_VERTICALLY
WheelUp::WheelLeft
WheelDown::WheelRight
#WheelUp::WheelUp
#WheelDown::WheelDown
#HotIf

XButton2 & XButton1::Escape
XButton1 & XButton2::Media_Play_Pause

XButton1 & WheelUp::Redo()
XButton1 & WheelDown::Undo()

XButton2 & WheelUp::ifTopLeft_Sugar(Send.Bind("{Volume_Up}"), TransAndProud.Bind(20))
XButton2 & WheelDown::ifTopLeft_Sugar(Send.Bind("{Volume_Down}"), TransAndProud.Bind(-20))

XButton1 & LButton::press_Hold_Sugar(Send.Bind("{BackSpace}"), SelectAll)
XButton1 & RButton::Delete

XButton2 & RButton::PrintScreen
XButton2 & LButton::Enter

XButton2 & MButton::screenshot_Fullscreen_Edit()
XButton1 & MButton::HoverScreenshot()

#!LButton::Hider(false)
#LButton::Hider()

Media_Stop & RButton::scr_Reload()
Media_Stop & MButton::F5
Media_Stop & LButton::ScreenSnip()

XButton1 & Media_Stop::scr_Test()
XButton2 & Media_Stop::scr_ExitTest()
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
		Case topRight:   GroupDeactivate("Main")
		Case bottomRight:win_App("Telegram ahk_exe Telegram.exe",       Paths.Apps["Telegram"])
		Case right:      win_App("Discord ahk_exe Discord.exe",         Paths.Apps["Discord"],,, "Updater")
		Case topLeft:    win_App("ahk_group Terminal",                  Paths.Apps["Terminal"])
		Case bottomLeft: win_App("AutoHotkey v2 Help",                  Paths.Apps["Ahk v2 docs"])
		Case left:       win_App("Visual Studio Code ahk_exe Code.exe", Paths.Apps["VS Code"])
		Case down:       win_App("ahk_exe Spotify.exe",                 Paths.Apps["Spotify"])
		Case up:         win_App("Google Chrome ahk_exe chrome.exe",    Paths.Apps["Google Chrome"])
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
		Case down:CloseButActually()
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
		Case WinActive("ahk_exe Code.exe") || WinActive("ahk_group Terminal"):
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
		Case WinActive("Telegram ahk_exe Telegram.exe") && down:telegram_Scroll()
		Case WinActive("Discord ahk_exe Discord.exe") && down:Send("{Esc}")
	}
}
#MaxThreadsBuffer false
