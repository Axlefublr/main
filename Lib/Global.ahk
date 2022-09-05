ClickThenGoBack(coordinates) {
   MouseGetPos(&initX, &initY)
   Click(coordinates)
   MouseMove(initX, initY)
}

;Clicks as an event for extra fucky things
ClickThenGoBack_Event(coordinates) {
   MouseGetPos(&initX, &initY)
   SendEvent("{Click " coordinates "}")
   MouseMove(initX, initY)
}

;A faster send. Sending stuff can take too long, but if you copy and paste it, it's much faster. Retains your clipboard as well
ClipSend(toSend, endChar := " ", isClipReverted := true, untilRevert := 100) {
   /*
      Because there's no way to know whether an application has received the input we sent it with ^v
      We revert the clipboard after a certain time (untilRevert)

      If we reverted the clipboard immidiately, we'd end up sending not "toSend", but the previous clipboard instead, because we didn't give the application enough time to process the action.

      This time depends on the app, discord seems to be one of the slowest ones (don't break TOS guys), but a safe time for untilRevert seems to be 50ms. This time might be lower or higher on your machine, configure as needed
    */
   if isClipReverted
      prevClip := ClipboardAll()	;We keep the previous clipboard

   A_Clipboard := ""	;We free the clipboard...
   A_Clipboard := toSend endChar	;Now the clipboard is what we want to send + and ending character. I often need a space after so I add a space by default, you can change what it is in the second parameter
   ClipWait(1)	;...so we can make sure we filled the clipboard with what we want before we send it
   Send("{ctrl down}v{ctrl up}")	;We send it. Not ^v because this variant is more consistent

   if isClipReverted
      SetTimer(() => A_Clipboard := prevClip, -untilRevert)	;We revert the clipboard in 50ms. This doesn't occupy the thread, so the clipsend itself doesn't take 50ms, only the revert of the clipboard does.
}

RunLink(link) => (
   Run(link),
   WinWait("Google Chrome ahk_exe chrome.exe"),
   WinActivate("Google Chrome ahk_exe chrome.exe")
)

WaitUntilImage(imageFile, coordObj?) {
   var := 0
   if !IsSet(coordObj) {
      coordObj := {
         x1: 0,
         y1: 0,
         x2: A_ScreenWidth,
         y2: A_ScreenHeight,
      }
   }
   While !var {
      var := ImageSearch(&imgX, &imgY, coordObj.x1, coordObj.y1, coordObj.x2, coordObj.y2, imageFile)
   }
   return [imgX, imgY]
}

WaitClick(imageFile) => (
   coords := WaitUntilImage(imageFile),
   ControlClick("X" coords[1] " Y" coords[2], "A")
)

TransAndProud(whatCrement) {
   howTrans := WinGetTransparent("A")

   if !howTrans
      howTrans := 255

   etgServer := howTrans + whatCrement

   Switch {
      Case etgServer >= 255: etgServer := "Off"
      Case etgServer <= 1: etgServer := 1
   }

   try WinSetTransparent(etgServer, "A")
}

Cis() {
   try WinSetTransparent(255, "A")
}

GetTooltipIndex() {
   static tooltipIndex := 0
   tooltipIndex++
   if tooltipIndex >= 20
      tooltipIndex := 1
   return tooltipIndex
}

ToolPeek(text, timeout := 1, x := "", y := "") {
   tooltipIndex := GetTooltipIndex()
   if !x && !y
      MouseGetPos(&x, &y)
   ToolTip(text, x, y, tooltipIndex)
   SetTimer(ToolTip.Bind(, , , tooltipIndex), -timeout * 1000)
}

ToolStay(text, winTitle?, x := 0, y := 0) {
   static tooltipsAtOneTime := 0
   tooltipIndex := GetTooltipIndex()
   winTitle := winTitle ?? WinGetID("A")

   if !x && !y {
      y := tooltipsAtOneTime * 25
   }

   ToolTip(text, x, y, tooltipIndex)

   tooltipsAtOneTime++

   _winTitle_NotActive() {
      if WinActive(winTitle)
         return

      ToolTip(, , , tooltipIndex)
      SetTimer(, 0)
      tooltipsAtOneTime--
   }

   SetTimer(_winTitle_NotActive, 100)
   /*
      We can't use WinWaitNotActive here because it occupies the thread, blocking the next toolstay that might come while still using the first one. If we check the winTitle activity with a settimer, we can use as many ToolStays as we want and they will all disappear once the window is inactive.
    */
}

RunWith(with, runFile) => Run(with ' "' runFile '"')

RunSpec(commands, AsAdmin := false, seeCmd := false) {

   commands_converted := IsObject(commands) ? "" : commands
   AsAdmin := AsAdmin ? "*RunAs " : ""
   seeCmd := seeCmd ? "Max" : "hide"

   if IsObject(commands) {

      commands_concoct := " & "	;to run multiple lines using Run, you concoct them together using &
      for key, value in commands {

         if key = commands.Length	;if it's the last command
            commands_concoct := ""	;we don't need to append the commands together anymore

         commands_converted .= value commands_concoct
      }
   }

   RunWait(AsAdmin A_ComSpec " /c " commands_converted, , seeCmd)
}

WriteFile(whichFile, text := "") => (
   fileObj := FileOpen(whichFile, "w"),
   fileObj.Write(text),
   fileObj.Close()
)

AppendFile(whichFile, text) {
   if FileExist(whichFile)
      fileObj := FileOpen(whichFile, "a")
   else
      fileObj := FileOpen(whichFile, "w")
   fileObj.Seek(0, 2)
   fileObj.Write(text)
   fileObj.Close()
}

ReadFile(whichFile) {
   fileObj := FileOpen(whichFile, "r")
   fileObj.Seek(0, 0)
   text := fileObj.Read()
   fileObj.Close()
   return text
}

ControlClick_Here(winTitle := "A", whichButton := "L") => (
   MouseGetPos(&locX, &locY),
   ControlClick("X" locX " Y" locY, winTitle, , whichButton)
)

WaitUntilPixChange_Relative(r_RelPos, timeout := 5) {
   MouseGetPos(&locX, &locY)
   initPix := []
   endPix := []
   time := A_TickCount

   for key, value in r_RelPos {
      if !RegexMatch(value, "(-?\d+),? (-?\d+)", &init_coords)
         return false
      initPix.Push(PixelGetColor(locX + init_coords[1], locY + init_coords[2]))
   }

   Loop {
      for key, value in r_RelPos {
         if !RegexMatch(value, "(-?\d*),? (-?\d*)", &end_coords)
            return false
         endPix.Push(PixelGetColor(locX + end_coords[1], locY + end_coords[2]))
      }
      for key, value in initPix {
         if value != endPix[key]
            break 2
      }
      endPix := []
      if A_TickCount - time > timeout * 1000
         return false
   }
   return true
}

SystemReboot := Shutdown.Bind(2)

SystemPowerDown := Shutdown.Bind(1)

GetDateAndTime() => FormatTime(, "yy.MM.dd HH:mm")

GetTimeAndSec() => FormatTime(, "HH:mm:ss")

RegexInFile(filePath, regex) {
   fileText := ReadFile(filePath)
   if !IsObject(regex) {
      if !RegexMatch(fileText, regex, &match) {
         TrayTip(regex " not found in " filePath)
         return false
      }
      return match
   }
   Matches := {}
   for key, value in regex {
      if !RegexMatch(fileText, value, &match) {
         TrayTip(value " not found in " filePath)
         continue
      }
      Matches.%key% := match
   }
   return Matches
}

RegexToFile(filePath_From, filePath_To, regex) => (
   match := RegexInFile(filePath_From, regex),
   WriteFile(filePath_To, match[0])
)

async(funcObj) => SetTimer(funcObj, -1)

GetHtml(link) {
   HTTP := ComObject("WinHttp.WinHttpRequest.5.1")
   HTTP.Open("GET", link, true)
   HTTP.Send()
   try HTTP.WaitForResponse()
   catch Any {
      return ""
   }
   return HTTP.ResponseText
}

PrimDefineProp := Object().DefineProp

GetWeather() {
   if !weather_html := GetHtml(Linker("weather"))
      return "null"

   RegExMatch(weather_html, "Текущая температура (-?\d+.)", &temp_match)
   temp := temp_match[1]

   RegExMatch(weather_html, "Влажность: (\d+%)", &wetness_match)
   wetness := wetness_match[1]

   RegExMatch(weather_html, "(?i)Ясно|Пасмурно|Облачно|Дождь", &atmosphere_match)
   if atmosphere_match
      atmosphere := StrTitle(atmosphere_match[])
   else
      atmosphere := "Непонятно"

   if InStr(weather_html, "Штиль")
      wind := "Штиль"
   else {
      RegExMatch(weather_html, "Ветер: (\d+\.?\d+?)", &wind_match)
      wind := wind_match[1] "м/с"
   }

   return temp " " wind " " wetness " " atmosphere
}
