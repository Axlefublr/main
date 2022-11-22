#Include <Win>
#Include <Global>
#Include <Links>
#Include <Tools\Info>
#Include <Press>
#Include <Paths>

#MaxThreadsBuffer true

#m::RunLink(Links["gmail"])
#sc33::RunLink(Links["ghm"])
#sc34::RunLink(Links["regex"])

#n::Win({
   winTitle: "Monkeytype " Browser.exeTitle, 
   exePath: Paths.Apps["Monkeytype"]
}).App()

<!r::Win({
   winTitle: "ahk_group Terminal",    
   exePath: Paths.Apps["Terminal"]
}).App()
<!s::Win({
   winTitle: Spotify.winTitle,        
   exePath: Paths.Apps["Spotify"]
}).App()
<!x::Win({
   winTitle: "AutoHotkey v2 Help",    
   exePath: Paths.Apps["Ahk v2 docs"]
}).App()
<!a::Win({
   winTitle: VsCode.winTitle,         
   exePath: Paths.Apps["VS Code"]
}).App()
<!c::Win({
   winTitle: Browser.winTitle,        
   exePath: Paths.Apps["Google Chrome"]
}).App()
<!q::Win({
   winTitle: Discord.winTitle,        
   exePath: Paths.Apps["Discord"],
   exception: Discord.exception
}).App()
<!t::Win({
   winTitle: Telegram.winTitle,       
   exePath: Paths.Apps["Telegram"]
}).App()
<!z::Win({
   winTitle: "OBS ahk_exe obs64.exe", 
   exePath: Paths.Apps["OBS"], 
   startIn: Paths.OBSFolder
}).App()

<!d::Win({winTitle: "C:\", runOpt: "Min"}).App_Folders()

<!v::Win({winTitle: Paths.Pictures, runOpt: "Min"}).App_Folders()

<!Escape::GroupDeactivate("Main")

#MaxThreadsBuffer false