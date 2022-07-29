#Requires AutoHotkey v2.0-a ;Makes sure this script runs in v2
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
#WinActivateForce ;Forces windows to be activated, skipping the gentle method
#Hotstring EndChars `t ;Decides the characters that can finish a hotstring
#InputLevel 5 ;Makes sure hotkeys can't activate themselves (effectively $ on every hotkey)
#HotIf ;At the start to autoresolve "this hotkey already exists" conflicts
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's
CoordMode "Pixel", "Client" ;Because controlclick also uses client
SetControlDelay -1 ;Even faster controlclick
A_MaxHotkeysPerInterval := 1000 ;Removes the limitation of 35 hotkeys per second
SetWorkingDir A_ScriptDir "\..\" ;Ensures a consistent A_WorkingDir.
#Include <All>




#InputLevel
!Pause::ExitApp() 