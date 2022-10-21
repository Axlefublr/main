#Include <Win>
#Include <Win-full>
#Include <Global>
#Include <Links>
#Include <Info>
#Include <Press>
#Include <Paths>

#MaxThreadsBuffer true

#m::RunLink(Links["gmail"])
#sc33::RunLink(Links["ghm"])
#sc34::RunLink(Links["regex"])

#n::win_App("Monkeytype ahk_exe chrome.exe", Paths.Apps["Monkeytype"])

<!r::win_App("ahk_group Terminal",                  Paths.Apps["Terminal"])
<!s::win_App("ahk_exe Spotify.exe",                 Paths.Apps["Spotify"])
<!x::win_App("AutoHotkey v2 Help",                  Paths.Apps["Ahk v2 docs"])
<!a::win_App("Visual Studio Code ahk_exe Code.exe", Paths.Apps["VS Code"])
<!c::win_App("Google Chrome ahk_exe chrome.exe",    Paths.Apps["Google Chrome"])
<!q::win_App("Discord ahk_exe Discord.exe",         Paths.Apps["Discord"])
<!t::win_App("Telegram ahk_exe Telegram.exe",       Paths.Apps["Telegram"])
<!z::win_App("OBS ahk_exe obs64.exe",               Paths.Apps["OBS"],,, Paths.OBSFolder)

<!d::win_App_Folders("C:\", "Min")

<!v::win_App_Folders(Paths.Pictures, "Min")

<!Escape::GroupDeactivate("Main")

#MaxThreadsBuffer false