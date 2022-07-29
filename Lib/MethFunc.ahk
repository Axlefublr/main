MsgBox(text?, title?, options?) {

}

HotIfWinActive(winTitle?, winText?) {
}

HotIfWinNotActive(winTitle?, winText?) {
	
}

HotIfWinExist(winTitle?, winText?) {

}

HotIfWinNotExist(winTitle?, winText?) {

}

ControlSend(keys, ctrl?, winTitle?, winText?, excludeTitle?, excludeText?) {

}

ControlClick(ctrlOrPos?, winTitle?, winText?, whichButton?, clicks?, option?, excludeTitle?, excludeText?) {

}

MouseGetPos(outX?, outY?, outWin?, outCtrl?, flag?) {

}

MouseMove(x, y, speed?, relative?) {

}

WinActive(winTitle?, winText?, excludeTitle?, excludeText?) {

}

WinExist(winTitle?, winText?, excludeTitle?, excludeText?) {

}

InputBox(prompt?, title?, option?, default?) {

}

WinGetProcessPath(winTitle?, winText?, excludeTitle?, excludeText?) {

}

WinGetTitle(winTitle?, winText?, excludeTitle?, excludeText?) {

}

FormatTime(ymdh?, format?) {

}

SetTimer(function?, period?, priority?) {

}

ClipWait(timeout?, waitForAnyData?) {

}

GroupAdd(groupName, winTitle?, winText?, excludeTitle?, excludeText?) {

}

WinActivate(winTitle?, winText?, excludeTitle?, excludeText?) {

}

WinWait(winTitle?, winText?, timeout?, excludeTitle?, excludeText?) {

}

ClipboardAll(data?, size?) {

}

CoordMode(targetType, relativeTo?) {
	
}

Run(target, workingDir?, options?, outPID?) {

}

SoundPlay(fileName, wait?) {

}

WinClose(winTitle?, winText?, secsToWait?, excludeTitle?, excludeText?) {

}

StrReplace(haystack, needle, replaceText?, caseSense?, outCount?, limit?) {

}

PostMessage(msg, wParam?, lParam?, ctrl?, winTitle?, winText?, excludeTitle?, excludeText?) {

}

WinGetID(winTitle?, winText?, excludeTitle?, excludeText?) {

}

Mod(dividend, divisor) {

}

WinMinimize(winTitle?, winText?, excludeTitle?, excludeText?) {

}

Gui(options, title?, eventObj?) {

}

FileSelect(options?, workDir_file?, title?, filter?) {
	/*
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		Options
		Type: String or Integer
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		If omitted, it will default to zero, which is the same as having none of the options below.

		Otherwise, it can be a number or one of the letters listed below, optionally followed by a number. For example, "M", 1 and "M1" are all valid (but not equivalent).

		D: Select Folder (Directory). Specify the letter D to allow the user to select a folder rather than a file. The dialog has most of the same features as when selecting a file, but does not support filters (Filter must be omitted or blank).

		M: Multi-select. Specify the letter M to allow the user to select more than one file via shift-click, control-click, or other means. In this case, the return value is an Array instead of a string. To extract the individual files, see the example at the bottom of this page.

		S: Save dialog. Specify the letter S to cause the dialog to always contain a Save button instead of an Open button.

		The following numbers can be used. To put more than one of them into effect, add them up. For example, to use 1 and 2, specify the number 3.

		1: File Must Exist
		2: Path Must Exist
		8: Prompt to Create New File
		16: Prompt to Overwrite File
		32: Shortcuts (.lnk files) are selected as-is rather than being resolved to their targets. This option also prevents navigation into a folder via a folder shortcut.

		As the "Prompt to Overwrite" option is supported only by the Save dialog, specifying that option without the "Prompt to Create" option also puts the "S" option into effect. Similarly, the "Prompt to Create" option has no effect when the "S" option is present. Specifying the number 24 enables whichever type of prompt is supported by the dialog.

		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		RootDir\Filename
		Type: String
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		If present, this parameter contains one or both of the following:

		RootDir: The root (starting) directory, which is assumed to be a subfolder in A_WorkingDir if an absolute path is not specified. If omitted or blank, the starting directory will be a default that might depend on the OS version (it will likely be the directory most recently selected by the user during a prior use of FileSelect).

		Filename: The default filename to initially show in the dialog's edit field. Only the naked filename (with no path) will be shown. To ensure that the dialog is properly shown, ensure that no illegal characters are present (such as /<|:").

		Examples:
		"C:\My Pictures\Default Image Name.gif"  ; Both RootDir and Filename are present.
		"C:\My Pictures"  ; Only RootDir is present.
		"My Pictures"  ; Only RootDir is present, and it's relative to the current working directory.
		"My File"  ; Only Filename is present (but if "My File" exists as a folder, it is assumed to be RootDir).

		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		Title
		Type: String
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		The title of the file-selection window. If omitted or blank, it will default to "Select File - " A_ScriptName (i.e. the name of the current script), unless the "D" option is present, in which case the word "File" is replaced with "Folder".
		Filter
		Type: String

		Indicates which types of files are shown by the dialog.

		Example: Documents (*.txt)
		Example: Audio (*.wav; *.mp2; *.mp3)

		If omitted, the filter defaults to All Files (*.*).

		Otherwise, the filter uses the indicated string but also provides an option for All Files (*.*) in the dialog's "files of type" drop-down list. To include more than one file extension in the filter, separate them with semicolons as illustrated in the example above.

		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		Return Value
		Type: String or Array
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		If multi-select is not in effect, this function returns the full path and name of the single file or folder chosen by the user, or an empty string if the user cancels the dialog.

		If the M option (multi-select) is in effect, this function returns an array of items, where each item is the full path and name of a single file. The example at the bottom of this page demonstrates how to extract the files one by one. If the user cancels the dialog, the array is empty (has zero items).

	*/
}

FileCreateShortcut(target, linkFile, workDir?, args?, description?, iconFile?, shortcutKey?, iconNum?, runState?) {

}

SubStr(str, startPos, length?) {

}

SplitPath(path, outFileName?, outDir?, outExt?, outNameNoExt?, outDrive?) {

}

SoundBeep(frequency?, duration?) {

}

InStr(haystack, needle, caseSense?, startPos?, occurence?) {

}

Trim(str, omitChars?) {

}

WinWaitActive(winTitle?, winText?, timeout?, excludeTitle?, excludeText?) {

}

WinWaitNotActive(winTitle?, winText?, timeout?, excludeTitle?, excludeText?) {

}

OnExit(funcObj, addRemove?) {

}

RegexMatch(haystack, needleRegex, outVar?, startPos?) {

}

StrSplit(str, delimiters?, omitChars?, maxParts?) {

}

FileOpen(fileName, flags, encoding?) {

}

PixelGetColor(x, y, mode?) {

}

PixelSearch(outX, outY, x1, y1, x2, y2, colorID, variation?) {

}

WinGetProcessName(winTitle?, winText?, excludeTitle?, excludeText?) {

}

FileCopy(sourcePattern, destPattern, overwrite?) {

}

Hotkey(keyName, action?, options?) {

}

ImageSearch(outX, outY, x1, y1, x2, y2, imageFile) {

}

WinSetTransparent(N?, winTitle?, winText?, excludeTitle?, excludeText?) {

}

RegexReplace(haystack, needleRegex, replacement?, outCount?, limit?, startPos?) {

}

ToolTip(text?, x?, y?, whichToolTip?) {

}

Format(formatStr, values?) {

}

GetKeyState(keyName, mode?) {

}

SetCapsLockState(state?) {

}

DllCall(function, type?, arg?, returnType?) {

}

WinGetPID(winTitle?, winText?, excludeTitle?, excludeText?) {

}

TrayTip(text?, title?, options?) {

}

DirSelect(workDir?, options?, prompt?) {

}

WinGetMinMax(winTitle?, winText?, excludeTitle?, excludeText?) {

}

Add(ctrlType, options?, text?) {

}

OnEvent(eventName, callback, addRemove?) {

}

Seek(distance, origin?) {

}

GetText(rowNum, columnNum?) {

}

InsertAt(index, value?) {

}

WinWaitClose(winTitle?, winText?, timeout?, excludeTitle?, excludeText?) {

}

