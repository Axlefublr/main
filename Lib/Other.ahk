Googler(searchRequest) {
   searchRequest := StrReplace(searchRequest, "+", "%2B")
   searchRequest := StrReplace(searchRequest, " ", "+")
   RunLink("https://www.google.com/search?q=" searchRequest)
}

MainApps() {

   chrome := { winTitle: "Google Chrome ahk_exe chrome.exe", exe: Paths.Apps["Google Chrome"] },
      discord := { winTitle: "Discord ahk_exe Discord.exe", exe: Paths.Apps["Discord"] },
      telegram := { winTitle: "Telegram ahk_exe Telegram.exe", exe: Paths.Apps["Telegram"] },
      vscode := { winTitle: "Visual Studio Code ahk_exe Code.exe", exe: Paths.Apps["VS Code"] },
      spotify := { winTitle: "ahk_exe Spotify.exe", exe: Paths.Apps["Spotify"] },
      ahkdocs := { winTitle: "AutoHotkey v2 Help", exe: Paths.Apps["Ahk v2 docs"] },

      apps := [chrome, discord, telegram, vscode, spotify, ahkdocs]

   index := 0
   for key, value in apps {
      index += win_Run(value.winTitle, value.exe)
   }

   if !index
      Info("All apps are already active")
}

CloseMainApps() {
   GroupAdd("MainApps", "ahk_exe chrome.exe", , "Google Chrome")
   GroupAdd("MainApps", "Discord ahk_exe Discord.exe")
   GroupAdd("MainApps", "Telegram ahk_exe Telegram.exe")
   GroupAdd("MainApps", "Visual Studio Code ahk_exe Code.exe")
   GroupAdd("MainApps", "ahk_exe Spotify.exe")
   GroupAdd("MainApps", "ahk_group AutoHotkey_Help")
   GroupAdd("MainApps", "C:\ ahk_exe explorer.exe")
   WinClose("ahk_group MainApps")
}

CloseButForSure() {
   Switch {
      Case WinActive("ahk_exe Spotify.exe"): spotify_Close()
      Case WinActive("ahk_exe steam.exe"):
         win_Close()
         ProcessClose("steam.exe")
      Case WinActive("ahk_exe gimp-2.10.exe"):
         win_Close()
         closeWindow := "Quit GIMP ahk_exe gimp-2.10.exe"
         if !WinWait(closeWindow, , 60)
            return
         win_Activate(closeWindow)
         Send("{Left}{Enter}")
      Case WinActive("DaVinci Resolve ahk_exe Resolve.exe"):
         win_Close()
         closeWindow := "Message ahk_exe Resolve.exe"
         if !WinWait(closeWindow, , 60)
            return
         win_Activate(closeWindow)
         Send("{Left 2}{Enter}")
      Default: win_Close()
   }
}

RadNum() => Random(1000000, 9999999)

GetRandomCommitMessage() {
   five_random_words := " "
   Loop 5 {
      five_random_words .= GetRandomWord("english") " "
   }

   return A_Now five_random_words
}

Skipper(time) => (
   time := Round(Eval(time) / 5),
   Send("{Right " time "}")
)

GetWeekDay(day) {
   static ONE_MONTH := 100000000
   if StrLen(day) = 1
      day := "0" day	;We need the leading zero in the YYYYMMDDHH24MISS format if it's a single digit
   date := A_YYYY A_MM day "112233"	;Everything after the day doesn't matter, since we're getting the weekday, 112233 for easy visibility
   if A_DD > day
      date += ONE_MONTH	;Because I don't need to know what *was* the weekday of a passed day, I'll almost always want to know of the day yet to come
   Info(FormatTime(date, "dddd"))
}

;Pass a weekday (string) to get its date (string). Shows the day with no month in an Info(). Both Mon and Monday work. If you input a non-existant weekday, will stop executing after checking the next 7 days, and will say there's an error in an Info()
GetDayFromWeekDay(weekDay) {
   date := A_Now
   i := 0
   Loop {
      i++
      date := DateAdd(date, 1, "Day")
      if i > 7 {
         Info("No such weekday!")
         return
      }
      if FormatTime(date, "dddd") = weekDay
         || FormatTime(date, "ddd") = weekDay
         break
   }
   Info(FormatTime(date, "d"))
}