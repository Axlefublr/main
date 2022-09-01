#Requires AutoHotkey v2.0-a ;Makes sure this script runs in v2
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
#Include <Script>

; scr_RunAsAdmin()

Fail() {
   TrayTip("Symlink creation failed")
   ExitApp()
}

if !originalPath := FileSelect("S", "C:\", "Select a file / directory to make a symlink of: ")
   Fail()

if FileGetAttrib(originalPath) ~= "D"
   isDir := " /d"
isDir := isDir ?? ""

if !symLinkDir := FileSelect("D", "C:\", "Select the directory your symlink is going to be in: ")
   Fail()

symLinkDir := RegexReplace(symLinkDir, "\\$")

input := InputBox("Type in the name of your symlink file / directory`n`nIf it's a file, remember to put the extension too!", "Symlink creator")
if !input.Value || input.Result = "Cancel"
   Fail()

symLinkPath := symLinkDir "\" input.Value
RunWait("*RunAs " A_ComSpec isDir ' /c mklink "' symLinkPath '" "' originalPath '"',, "hide")
TrayTip("Symlink successfully created!")