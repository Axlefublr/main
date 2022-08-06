﻿#Include <StrMan>
#Include <Win>

tool_KeyCodeGetter() {

	static values_hwnd := False

	if values_hwnd {
		win_MinMax(values_hwnd)
		return
	}

	g_values := Gui(, "Key code getter")
	g_values.BackColor := "171717"
	g_values.SetFont("s30 cC5C5C5", "Consolas")

	values_hwnd := g_values.hwnd

	g_values_input := g_values.Add("Edit", "background171717")

	g_values_name := g_values.Add("Text", "w400", "Key name")   
	g_values_SC   := g_values.Add("Text",, "SC code")   
	g_values_VK   := g_values.Add("Text", "x+100", "VK code")

	Destruction(*) {
		HotIfWinActive("ahk_id " values_hwnd)
		Hotkey("Escape", "Off")
		Hotkey("Enter", "Off")
		values_hwnd := False
		g_values.Destroy()

		if !used
			return
			
		Hotkey("F1", "Off")
		Hotkey("F2", "Off")
		Hotkey("F3", "Off")
		used := False
	}
	
	toClip := (what, *) => A_Clipboard := what

	static used := False
	Submit(*) {
		used := True

		input := g_values_input.value
		g_values_input.value := ""

		key_name := GetKeyName(input)
		key_SC   := GetKeySC(input)
		key_VK   := GetKeyVK(input)

		key_SC := "sc" Format("{:x}", key_SC) ;getkey sc/vk returns a base 10 value, when both of those are actually base 16. This makes absolutely no fucking sense. So, we use format to format a base 10 integer into a base 16 int for both of them
		key_VK := "vk" Format("{:x}", key_VK)

		g_values_name.Text := key_name
		g_values_SC.Text := key_SC
		g_values_VK.Text := key_VK
		
		HotIfWinActive("ahk_id " values_hwnd) ;If a hotkey to call this function is under a #HotIf, the hotkeys created in this functions will be affected by that. So, we have to specify that they should have no condition.
		Hotkey("F1", toClip.Bind(g_values_name.text), "On")      
		Hotkey("F2", toClip.Bind(g_values_SC.text),   "On")
		Hotkey("F3", toClip.Bind(g_values_VK.text),   "On")      
		
		g_values_name.OnEvent("Click", toClip.Bind(g_values_name.text))
		g_values_SC.OnEvent("Click",   toClip.Bind(g_values_SC.text))
		g_values_VK.OnEvent("Click",   toClip.Bind(g_values_VK.text))
	}
	
	HotIfWinActive("ahk_id " values_hwnd)
	Hotkey("Enter", Submit, "On")
	Hotkey("Escape", Destruction, "On")
	g_values.OnEvent("Close", Destruction)

	g_values.Show("AutoSize y0 x" A_ScreenWidth / 20 * 12.95)

}

tool_RelativeCoordGetter() {
	static var := 0
	static initX
	static initY
	if !var {
		MouseGetPos(&locX, &locY)
		ToolTip("Initial position")
		initX := locX
		initY := locY
		var := !var
		return
	}
	ToolTip()
	MouseGetPos(&loc1X, &loc1Y)

	relPosX := loc1X - initX
	relPosY := loc1Y - initY

	initX := 0
	initY := 0
	var := !var

	g_relative := Gui(, "Relative coord getter")
	g_relative.BackColor := "171717"
	g_relative.SetFont("s30 cC5C5C5", "Consolas")

	g_relative_textX := g_relative.Add("Text",, "Relative X: " relPosX)
	g_relative_textY := g_relative.Add("Text",, "Relative Y: " relPosY)

	topRightCorner := A_ScreenWidth / 20 * 14.3

	g_relative_hwnd := g_relative.hwnd

	Destruction := (*) => (
		HotIfWinActive("ahk_id " g_relative_hwnd),
		Hotkey("Escape", "Off"),
		Hotkey("F1", "Off"),
		Hotkey("F2", "Off"),
		g_relative.Destroy()
	)

	toClip(text, *) {
		static var := 0
		var++
		A_Clipboard := text
		Info("copied " text)
		if var >= 2
			Destruction()
	}

	HotIfWinActive("ahk_id " g_relative_hwnd)
	Hotkey("F1", toClip.Bind(relPosX), "On")
	Hotkey("F2", toClip.Bind(relPosY), "On")
	Hotkey("Escape", Destruction, "On")

	g_relative_textX.OnEvent("Click", toClip.Bind(relPosX))
	g_relative_textY.OnEvent("Click", toClip.Bind(relPosY)) 

	g_relative.OnEvent("Close", Destruction)

	g_relative.Show("AutoSize y0 x" topRightCorner)

}

tool_FileSearch(caseSense := "Off") { ;Case sense is off by default, but may need to be changed to locale if you intend to search for files named not in English.

	search := InputBox("What file do you want to search for?:", "File Search")
	search_value := search.Value ;Just a rename so the InStr in the loop doesn't have to access a property and instead just checks a variable's value
	if search.Result = "Cancel" || !search_value ;code doesn't continue to run if you cancel the inputbox or don't type in anything
		return

	folder := DirSelect("C:", 6, "What folder do you want to search?:") ;"6" makes it so you can type in / paste in the path to the folder you want to choose
	if !folder {
		MsgBox("You didn't select a valid folder") ;if you fucked up the pasting of the folder (or just pressed cancel or picked nothing)
		return
	}

	if folder = "C:\"
		folder := "C:"

	if search_value ~= "[а-яА-Я]" && caseSense != "Locale" ;If your search request you just did contains russian, caseSense for the search in InStr() is automatically made to Locale, so it actually *is* case insensitive. Likely the same case for other languages with different writing systems and doesn't matter for stuff like spanish and french (just a baseless hunch)
		caseSense := "Locale"

	guiWidth := 750
	guiHeight := 350

	g_found := Gui("AlwaysOnTop +Resize", "These files match your search:")
	g_found.SetFont("s10", "Consolas")
	g_found.Add("Text",, "Right click on a result to copy its full path. Double click to open it in explorer.")
	g_found_list := g_found.Add("ListView", "W" guiWidth - 25 " H" guiHeight - 45 " Count50", ["File", "Folder", "Directory"]) ;Count50 -- we're not losing much by allocating more memory than needed, and on the other hand we improve the performance by a lot by doing so

	g_found_list.Opt("-Redraw") ;improves performance rather than keeping on adding rows and redrawing for each one of them

	ToolTip("Search in progress", 0, 0) ;to remove the worry of "did I really start the search?"
	
	Loop Files folder . "\*.*", "FDR" { 
		/*
			"But ternary is faster!" -- No, suprisingly enough, it's not. An if with no else is faster than ternary with : "" (which you *have to* have in v2) ((better to cum in the sink than to sink in the cum))

			Because of how compiling logic works, if the first condition on the left of the && is false, everything to the right will not even be evaluated (looked at), so instead of nesting two ifs we can use the AND statement without losing any speed.
			The trend continues with the later || -- the slowest to check file will be a *file* with no extension, then a folder, then a file, then something that didn't match
		*/
		if InStr(A_LoopFileName, search_value, caseSense) {
			if InStr(A_LoopFileAttrib, "D")
				g_found_list.Add(,, A_LoopFileName, A_LoopFileDir)
			else if A_LoopFileExt
				g_found_list.Add(, A_LoopFileName,, A_LoopFileDir)
		}
	}

	ToolTip()
	
	g_found_list.Opt("+Redraw")
	g_found_list.ModifyCol() ;it makes the columns fit the data -- @rbstrachan 
	
	g_found_list.OnEvent("DoubleClick", ShowInFolder)
	g_found_list.OnEvent("ContextMenu", CopyFull_path.Bind(0)) ;Funniest shit I've ever seen: all the other parameters of CopyFull_path are automatically passed into the function and the *only* parameter you have to set yourself is Y. Seriously, you don't need to specify X and Y, *just* Y. *Y* does it work like that???

	g_found.Show("W" guiWidth " H" guiHeight)
	g_found.OnEvent("Size", AutoResize) ;When you resize the gui window, the new size gets passed into AutoResize, that takes care of the list that's inside the gui
	g_found.OnEvent("Close", (*) => g_found.Destroy()) ;You can pass an asterisk instead of the parameters that are expected to be here, regardless of whether you use them 

	AutoResize(g_found, minMax, width, height) { ;The parameters listed here are automatically passed by the OnEvent and you have to list them regardless of whether you're gonna use them
		g_found_list.Move(,, width - 25, height - 45) 
		/*
		When you resize the main gui, the listview also gets resize to have the same borders as usual. 
		So, on resize, the onevent passes *what* you resized and the width and height that's now the current one. 
		Then you can use that width and height to also resize the listview in relation to the gui
		*/
	}

	CopyFull_path(g_found, g_found_list, Item, IsRightClick, X, Y) { ;Same goes for these parameters. The only one you have to pass is Y, for whatever reason
		if !(Item && IsRightClick) ;If you didn't right click on the row with the mouse, don't continue running the function
			return

		A_Clipboard := GetFull_path(Item) 
	} ;i.e. => when you right click on a row, the full path gets copied to your clipboard

	ShowInFolder(g_found_list, RowNumber) {
		try Run("explorer.exe /select," GetFull_path(RowNumber)) ;By passing select, we achieve the cool highlighting thing when the file / folder gets opened. (You can pass command line parameters into the run function)
	}

	GetFull_path(rowInfo) { 
		/*
		The OnEvent passes which row we interacted with automatically
		So we read the text that's on the row
		And concoct it to become the full path
		This is much better performance-wise than adding all the full paths to an array while adding the listviews (in the loop) and accessing it here. 
		Arguably more readable too
		*/
		file := g_found_list.GetText(rowInfo, 1) 
		dir  := g_found_list.GetText(rowInfo, 2)
		path := g_found_list.GetText(rowInfo, 3)

		return path "\" file dir ;no explanation required, it's just logic -- @rbstrachan 
	}
}

tool_Clock() {

	static clock_hwnd

	if IsSet(clock_hwnd) && WinExist(clock_hwnd) {
		win_MinMax(clock_hwnd)
		return
	}
	
	;Get the time variables
	clock_Time   := FormatTime(, " HH:mm:ss")
	, clock_Week := FormatTime(, "dddd")
	, clock_Date := FormatTime(, "d MMMM")

	;Create the gui
	g_Clock := Gui(, "Clock")
	g_Clock.BackColor := "171717"

	clock_hwnd := g_Clock.hwnd

	;Add text
	g_Clock.SetFont("S40 cC5C5C5", "Consolas")
	g_Clock_Time := g_Clock.Add("Text", "w237 y-20", clock_Time) 

	g_Clock.SetFont("S30")
	g_Clock_Week := g_Clock.Add("Text", "w237 y+35 Center", clock_Week)

	g_Clock.SetFont("S26")
	g_Clock_Date := g_Clock.Add("Text", "w237 Center", clock_Date)
	
	;The func obj is separate because we'll need to disable the timer outside of it
	timeCheck := () => (
		g_Clock_Time.Text := FormatTime(, " HH:mm:ss"),
		g_Clock_Week.Text := FormatTime(, "dddd"),
		g_Clock_Date.Text := FormatTime(, "d MMMM")
	)

	;Change the time text every half a second for better accuracy
	SetTimer(timeCheck, 500)

	;Takes care of all the trash
	Destruction := (*) => ( ;the * takes care of the required parameters for hotkey and onevent
		SetTimer(timeCheck, 0), ;Since it references a function object, it can be outside of the settimer's thread
		HotIfWinActive("ahk_id " clock_hwnd),
		Hotkey("Escape", "Off"),
		g_Clock.Destroy()
	)

	HotIfWinActive("ahk_id " clock_hwnd)
	Hotkey("Escape", Destruction, "On")
	g_Clock.OnEvent("Close", Destruction)

	g_Clock.Show("W350 H320 y0 x" A_ScreenWidth / 20 * 15.3)

}

tool_CoordGetter() {

	;We get all the coordinates and the pixel color at absolute coords
	CoordMode("Mouse", "Screen")
	MouseGetPos(&locScrX, &locScrY)

	CoordMode("Mouse", "Client")
	MouseGetPos(&locCliX, &locCliY)

	CoordMode("Mouse", "Window")
	MouseGetPos(&locWinX, &locWinY)

	CoordMode("Pixel", "Screen")
	pixel := PixelGetColor(locScrX, locScrY, "Alt Slow") ;Haven't used pixelgetcolor so using the slowest method for safety

	;Creation of the gui
	g_CrdGet := Gui(, "Coord Getter")
	g_CrdGet.Backcolor := "171717"
	g_CrdGet.SetFont("S30 cC5C5C5", "Consolas")

	CrdGet_hwnd := g_CrdGet.hwnd

	;Adding all the text for the gui
	g_CrdGet_CtrlFormat := g_CrdGet.Add("Text",, "X = " locScrX "`nY = " locScrY)
	g_CrdGet_Screen     := g_CrdGet.Add("Text",, "Screen")
	g_CrdGet_Client     := g_CrdGet.Add("Text", "y+15", "Client")
	g_CrdGet_Window     := g_CrdGet.Add("Text", "y+15", "Window") ;The 'word' text is visually more grouped together
	g_CrdGet_Pixel      := g_CrdGet.Add("Text", "y+35", pixel)

	;Destroys the gui as well as every previously created hotkey
	;You can also append defining arrow functions, but there has to be nothing after them (on the same line). Otherwise that next thing is considered as the second value for => to return, which is an error. To go around this, you can wrap the whole arrow definition into () and then it's all good. But at that point, what are you doing (we draw the line right below what we believe)
	FlushHotkeys := (*) => (
		HotIfWinActive("ahk_id " CrdGet_hwnd),
		Hotkey("F1", "Off"),
		Hotkey("F2", "Off"),
		Hotkey("F3", "Off"),
		Hotkey("F4", "Off"),
		Hotkey("F5", "Off"),
		Hotkey("Escape", "Off"),
		g_CrdGet.Destroy()
	)

	;This function copies the text you clicked to your clipboard and destroys the gui right after
	ToClip(text, *) => (A_Clipboard := text, FlushHotkeys())

	;Defining all the function objects that we're gonna call by hotkeys and buttons. (*) takes care of Hotkey and OnEvent requiring parameters we aren't gonna use
	;If you keep appending lines for too long, it overflows the memory and gives an error -- this is why there's no , here. Plus, harder to debug because ahk sees it as one line. The positive is that it's around 35% faster. Be careful with this tradeoff (you can remove all the ,'s at starts of lines if you want)
	ToClip_CtrlFormat := ToClip.Bind("`"X" locCliX " Y" locCliY "`"") ;You get the formatting that you can just paste into your controlclick without having to change anything
	ToClip_Screen     := ToClip.Bind(locScrX " " locScrY)
	ToClip_Client     := ToClip.Bind(locCliX " " locCliY)
	ToClip_Window     := ToClip.Bind(locWinX " " locWinY) ;Pure coords with no formatting for the other options
	ToClip_Pixel      := ToClip.Bind(pixel)

	;Press a hotkey to activate its func object
	HotIfWinActive("ahk_id " CrdGet_hwnd)
	Hotkey("F1",     ToClip_CtrlFormat, "On")
	Hotkey("F2",     ToClip_Screen,     "On")
	Hotkey("F3",     ToClip_Client,     "On")
	Hotkey("F4",     ToClip_Window,     "On")
	Hotkey("F5",     ToClip_Pixel,      "On")
	Hotkey("Escape", FlushHotkeys,      "On")

	;Click the text to activate its func object (same as with hotkeys)
	g_CrdGet_CtrlFormat.OnEvent("Click", ToClip_CtrlFormat)
	g_CrdGet_Screen.OnEvent(    "Click", ToClip_Screen)
	g_CrdGet_Client.OnEvent(    "Click", ToClip_Client)
	g_CrdGet_Window.OnEvent(    "Click", ToClip_Window)
	g_CrdGet_Pixel.OnEvent(     "Click", ToClip_Pixel)

	g_CrdGet.OnEvent("Close", FlushHotkeys) ;The gui isn't automatically destroyed when you click X by default, you'd have to do `guiObj.OnEvent("Close", (*) => guiObj.Destroy())` usually

	g_CrdGet.Show("Center H440 W300 y0 x" A_ScreenWidth / 8 * 6.3)

}

tool_WindowGetter() {

	;Getting the current window's info
	winTitle   := WinGetTitle("A")
	winExePath := WinGetProcessPath("A")
	winExe     := WinGetProcessName("A")
	winID      := WinGetID("A")
	winPID     := WinGetPID("A")

	;Gui creation
	g_WinGet := Gui(, "WindowGetter")
	g_WinGet.Backcolor := "171717"
	g_WinGet.SetFont("S20 cC5C5C5", "Consolas")

	WinGet_hwnd := g_WinGet.hwnd

	;Show the window's info
	g_WinGet_WinTitle   := g_WinGet.Add("Text", "Center", winTitle)
	g_WinGet_WinExePath := g_WinGet.Add("Text", "Center", winExePath)
	g_WinGet_WinExe     := g_WinGet.Add("Text", "Center", winExe)
	g_WinGet_WinID      := g_WinGet.Add("Text", "Center", "id: " winID)
	g_WinGet_WinPID     := g_WinGet.Add("Text", "Center", "pid: " winPID)

	;Destroys the gui as well as every previously created hotkeys
	FlushHotkeys := (*) => (
		HotIfWinActive("ahk_id " WinGet_hwnd),
		Hotkey("F1", "Off"),
		Hotkey("F2", "Off"),
		Hotkey("F3", "Off"),
		Hotkey("F4", "Off"),
		Hotkey("F5", "Off"),
		Hotkey("Escape", "Off"),
		g_WinGet.Destroy()
	)

	;This function copies the text you clicked to your clipboard and destroys the gui right after
	ToClip := (text, *) => (
		A_Clipboard := text,
		FlushHotkeys()
	)

	;Making the func objects to later call in two separate instances
	ToClip_Title := ToClip.Bind(winTitle) ;We pass the params of winSmth
	ToClip_Path  := ToClip.Bind(winExePath) ;To copy it, disable the hotkeys and destroy the gui
	ToClip_Exe   := ToClip.Bind(winExe) 
	ToClip_ID    := ToClip.Bind(winID) 
	ToClip_PID   := ToClip.Bind(winPID) 

	HotIfWinActive("ahk_id " WinGet_hwnd)
	Hotkey("F1", ToClip_Title, "On")
	Hotkey("F2", ToClip_path,  "On")
	Hotkey("F3", ToClip_Exe,   "On")
	Hotkey("F4", ToClip_ID,    "On")
	Hotkey("F5", ToClip_PID,   "On")

	Hotkey("Escape", FlushHotkeys, "On")

	g_WinGet_WinTitle.OnEvent(  "Click", ToClip_Title)
	g_WinGet_WinExePath.OnEvent("Click", ToClip_Path)
	g_WinGet_WinExe.OnEvent(    "Click", ToClip_Exe)
	g_WinGet_WinID.OnEvent(     "Click", ToClip_ID)
	g_WinGet_WinPID.OnEvent(    "Click", ToClip_PID)

	g_WinGet.OnEvent("Close", FlushHotkeys) ;Destroys the gui when you close the X button on it

	g_WinGet.Show("Center H300 W1000 y0")
}

tool_Timer(minutes, shouldExit := False) {
	endTime := A_TickCount + minutes * 60000

	_isItTime() {
		if A_TickCount < endTime
			return
		SoundBeep(700, 300), SoundBeep(800, 300), SoundBeep(900, 300)
		TrayTip("Time's up!")
		SetTimer(, 0)
		if shouldExit
			ExitApp()
	}
	
	SetTimer(_isItTime, 500)
	Info("Timer set for " minutes " minutes!")
}

;Select a file to run on startup
tool_StartupRun() {
	selectedFile := FileSelect("S", A_WorkingDir)
	SplitPath(selectedFile, &fileName)
	FileCreateShortcut(selectedFile, A_StartMenu "\Programs\Startup\" fileName ".lnk")
}

tool_SomeLockHint(whatLock) {

	newState := !GetKeyState(whatLock, "T")

	newState_Word := newState ? "On" : "Off"
	whatLock := StrTitle(whatLock)

	Set%whatLock%State(newState)
	
	g_SomeLock := Gui("AlwaysOnTop -caption")
	g_SomeLock.BackColor := "171717"
	g_SomeLock.SetFont("s20 cC5C5C5", "Consolas")
	g_SomeLock.Add("Text",, whatLock " " newState_Word)

	SetTimer(() => g_SomeLock.Destroy(), -1000)
	
	g_SomeLock.Show("W225 NA x1595 y640")
}

;Another alternative to outputdebug
Info(text, disappear := True) {
	g_Info := Gui("AlwaysOnTop -caption")
	g_Info.BackColor := "171717"
	g_Info.SetFont("s20 cC5C5C5", "Consolas")
	g_Info_Text := g_Info.Add("Text",, text)

	static infos := []
	static index := 0
	index++
	Info_hwnd := g_Info.Hwnd
	infos.Push(Info_hwnd)
	
	fullDivisions := index // 18
	if fullDivisions
		index := index - 18 * fullDivisions + 1
	yCoord := index * 60 - 60

	Destruction(*) {
		if disappear
			SetTimer(Destruction, 0)

		if infos.Length <= 1 {
			if !disappear {
				HotIfWinExist('ahk_id ' Info_hwnd)
				Hotkey("Escape", "Off")
				Hotkey("+Escape", "Off")
			}
			index := 0
		}

		if infos.Length >= 1 {
			lastGui := infos.RemoveAt(1)
			win_Close(lastGui)
		}
	}

	FullDestruction(*) {
		Loop infos.Length {
			Destruction()
		}
	}
	
	g_Info.OnEvent("Close", (*) => g_Info.Destroy())

	if !disappear {
		HotIfWinExist('ahk_id ' Info_hwnd)
		Hotkey("Escape", Destruction, "On")
		Hotkey("+Escape", FullDestruction, "On")
	}

	if disappear
		SetTimer(Destruction, -1500)

	g_Info.Show("AutoSize NA x0 y" yCoord)
	
	return Info_hwnd
}

Infos(text) => Info(text, False)

Snake(SquareSide, delay, timeout) {

	static isSlithering := False

	if isSlithering {
		Info("Press escape to disable snake first")
		return
	}

	maxSide := Min(A_ScreenWidth, A_ScreenHeight)
	if SquareSide > maxSide
		SquareSide := maxSide
	else if SquareSide <= 1
		SquareSide := 2

	timeout := timeout * 1000

	static colors := [
		"D12229", ;Red
		"F68A1E", ;Orange
		"FDE01A", ;Yellow
		"007940", ;Green
		"24408E", ;Blue
		"732982"  ;Purple
	]

	static Columns := A_ScreenWidth // SquareSide
	static Rows := A_ScreenHeight // SquareSide

	;The gui's client + the place around it it still needs
	static MarginX := A_ScreenWidth // Columns
	static MarginY := A_ScreenHeight // Rows

	;How much client you'll get from a margin
	static ClientRelativity := 0.81

	static direction := "down"

	;The actual visible margins of the gui
	static ClientMarginX := MarginX * ClientRelativity
	static ClientMarginY := MarginY * ClientRelativity

	static index
	static colorIndex

	stopped := False
	
	ChangeDirection() {
		direction := (direction = "down" ? "up" : "down")
	}

	Stop(*) => (
		startSnake.Destroy(),
		stopped := True,
		index := 0,
		colorIndex := 0
	)

	startSnake := Gui(, "Snake")
	startSnake.BackColor := "171717"

	startSnake.SetFont("s25 cC5C5C5", "Consolas")

	startSnake.Add("Text", "Center", "You can press Escape to exit the snake")

	startSnake.SetFont("s15")

	startSnake.Add("Button", "Default Center", "Start")
	.OnEvent("Click", (*) => startSnake.Destroy())
	startSnake.Add("Button", "x+m", "Cancel")
	.OnEvent("Click", Stop)

	startSnake.OnEvent("Close", Stop)

	startSnake.Show("AutoSize")
	WinWaitClose(startSnake.hwnd)

	if stopped
		return

	index := 0
	colorIndex := 0

	isSlithering := True

	SetTimer(GoSsss, delay)
	stopSlithering(*) => (
		HotIf(),
		SetTimer(GoSsss, 0),
		isSlithering := False,
		Hotkey("Escape", "Off")
	)
	HotIf()
	Hotkey("Escape", stopSlithering, "On")

	GoSsss() {

		snake := Gui("AlwaysOnTop -caption +E0x20 +ToolWindow")
		WinSetTransparent(255, snake.Hwnd)

		;An array of ID's of guis
		static aliveSnakes := []
		aliveSnakes.Push(snake.Hwnd)
		
		;An amount of guis to appear without all of them disappearing
		index++

		colorIndex++
		if colorIndex >= 7
			colorIndex := 1

		snake.Backcolor := colors[colorIndex]

		static xCoord := 0
		if index > Rows {
			index := index // Rows
			xCoord += MarginX
			if xCoord >= A_ScreenWidth - MarginX
				xCoord := 0
			ChangeDirection()
		}
		
		if direction = "down"
			yCoord := index * MarginY - MarginY
		else if direction = "up"
			yCoord := (Rows - index + 1) * MarginY - MarginY

		snake.Show("W " ClientMarginX " H" ClientMarginY " NA x" xCoord " y" yCoord)

		KillLastSnake := (*) => (
			SetTimer(KillLastSnake, 0),
			lastGui := aliveSnakes.RemoveAt(1),
			win_Close(lastGui)
		)
		snake.OnEvent("Close", (*) => snake.Destroy())
		SetTimer(KillLastSnake, -timeout)
	}

}
