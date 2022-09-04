#HotIf !WinExist("ahk_group Game")
;Steam
<!g::win_App("ahk_exe steam.exe", Paths.Apps["Steam"], , "Steam - News")

#HotIf !WinActive("ahk_group Game")

;Links
#m::RunLink(Linker("gmail"))
#sc28::RunLink(Linker("weather"))
#sc33::RunLink(Linker("github"))
#sc34::RunLink(Linker("regex"))

;Monkeytype
#n::win_App("Monkeytype ahk_exe chrome.exe", Paths.Apps["Monkeytype"])

;Media
<!r::win_App("ahk_exe WindowsTerminal.exe", Paths.Apps["Terminal"])

;Spotify
<!s::win_App("ahk_exe Spotify.exe", Paths.Apps["Spotify"])

;Autohotkey v2 help file
<!x::win_App("AutoHotkey v2 Help", Paths.Apps["Ahk v2 docs"])

;Visual studio code
<!a::win_App("Visual Studio Code ahk_exe Code.exe", Paths.Apps["VS Code"])

;Chrome
<!c::win_App("Google Chrome ahk_exe chrome.exe", Paths.Apps["Google Chrome"])

;Discord
<!q::win_App("Discord ahk_exe Discord.exe", Paths.Apps["Discord"])

;Telegram
<!t::win_App("Telegram ahk_exe Telegram.exe", Paths.Apps["Telegram"])

#MaxThreadsBuffer true
;Explorer
<!d:: {
	if press_Hold() {
		Run("explorer.exe C:\")
		WinWait("C:\ ahk_exe explorer.exe")
		win_Activate("C:\ ahk_exe explorer.exe")
	} else
		win_App_Folders("C:\", "Min")
}

;Pictures
<!v::win_App_Folders(Paths.Pictures, "Min")

;Content
<!z::win_App_Folders(Paths.Content, "Max")

;Editing
<!b::win_App_Folders(Paths.Editing, "Min")
#MaxThreadsBuffer false

;A bunch of apps I want to be able to activate easily
<!f:: {
	GroupAdd("MinMax", "ahk_exe FL64.exe")
	GroupAdd("MinMax", "ahk_exe Resolve.exe")
	GroupAdd("MinMax", "GIMP ahk_exe gimp-2.10.exe")
	GroupAdd("MinMax", "Monkeytype ahk_exe chrome.exe")
	GroupAdd("MinMax", "ahk_exe wps.exe")

	try WinActivateBottom("ahk_group MinMax")
}

#HotIf WinExist("ahk_group Game")
<!g::win_MinMax("ahk_group Game")

#HotIf


#Include <Win>