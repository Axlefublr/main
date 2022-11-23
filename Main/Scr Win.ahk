#Include <Win>
#Include <Global>
#Include <Links>
#Include <Tools\Info>
#Include <Press>
#Include <Paths>
#Include <App\OBS>
#Include <App\Explorer>
#Include <App\Telegram>
#Include <App\Discord>
#Include <App\Browser>
#Include <App\Autohotkey>
#Include <App\VsCode>
#Include <App\Terminal>
#Include <App\Spotify>

#MaxThreadsBuffer true

#m::RunLink(Links["gmail"])
#sc33::RunLink(Links["ghm"])
#sc34::RunLink(Links["regex"])

#n::Browser.MonkeyType.winObj.App()

<!r::Terminal.winObj.App()
<!s::Spotify.winObj.App()
<!x::Autohotkey.v2.Docs.winObj.App()
<!a::VsCode.winObj.App()
<!c::Browser.winObj.App()
<!q::Discord.winObj.App()
<!t::Telegram.winObj.App()
<!z::OBS.winObj.App()

<!d::Explorer.WinObj.Volume.App_Folders()

<!v::Explorer.WinObj.Pictures.App_Folders()

<!Escape::GroupDeactivate("Main")

#MaxThreadsBuffer false