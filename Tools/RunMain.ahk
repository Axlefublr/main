#Requires AutoHotkey v2.0-a
#SingleInstance Force
#Include <Paths>
#Include <Win>
#Include <App\Discord>
#Include <App\Spotify>
#Include <App\Terminal>
#Include <App\Browser>
#Include <App\VsCode>
Run(Paths.Ptf["Keys"])

Discord.winObj.RunAct()
Spotify.winObj.RunAct()
Terminal.winObj.RunAct()
Browser.winObj.RunAct()
VsCode.winObj.RunAct()