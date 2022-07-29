#Requires AutoHotkey v2.0-a ;Makes sure this script runs in v2
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
SetWorkingDir A_ScriptDir "\..\" ;Ensures a consistent A_WorkingDir.
#Include <Bin>
#Include <Global>
#Include <Script>
#Include <Sort>

arr := GenerateShuffledArray(1000)
prevNow := A_TickCount
arr := BubbleSort(arr)
nowNow := A_TickCount - prevNow
Out("Bubble sort took " nowNow "ms")
Out("`n" ArrToStr(arr))
scr_BeepUnSuspend()