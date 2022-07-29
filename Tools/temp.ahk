#Requires AutoHotkey v2.0-a
#SingleInstance Off
#Include <Tools>
hwnd := Info(min(5, 1))
WinWaitClose(hwnd)
ExitApp()