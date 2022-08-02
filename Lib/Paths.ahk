;No dependencies

Class c_Paths {

	Prog           := "C:\Programming"
	PersDir        := "C:\Programming\Main"
	OthrDir        := "C:\Programming\Extra"
	JSDir          := "C:\Programming\JS"
	Backups        := this.PersDir "\Backups"
	Docs           := this.PersDir "\Docs"
	Music          := this.PersDir "\Docs\Music"
	Files          := this.PersDir "\Files"
	Images         := this.PersDir "\Files\Images"
	Sounds         := this.PersDir "\Files\Sounds"
	Notes          := this.PersDir "\Notes"
	NotesTemp      := this.PersDir "\Notes temp"
	Test           := this.PersDir "\Test"
	Tools          := this.PersDir "\Tools"

	Pictures  := "C:\Files\Pictures"
	Editing   := this.Pictures "\Editing"
	Materials := this.Pictures "\Editing\Materials"
	Content   := this.Pictures "\Content"
	OnePiece  := this.Pictures "\Content\One Piece"
	Overlord  := this.Pictures "\Content\Overlord\Overlord 4"

	VsCodeExtensions := "C:\Users\" A_UserName "\.vscode\extensions"

	AhkPlusPlus := "C:\Users\" A_UserName "\.vscode\extensions\mark-wiemer.vscode-autohotkey-plus-plus-2.8.4"

	Ptf := Map(
		"Both",                             this.PersDir "\Backups\Both.code-workspace",
		"Main",                             this.PersDir "\Backups\Main.code-workspace",

		"tmLanguage",                       this.PersDir "\Backups\Ahk++\ahk.tmLanguage.json",
		"configuration",                    this.PersDir "\Backups\Ahk++\ahk.configuration.json", 
		"ahk snippets",                     this.PersDir "\Backups\Ahk++\ahk snippets.json",
                  
		"Discovery log",                    this.PersDir "\Docs\Music\Discovery log.txt",
		"Unfinished",                       this.PersDir "\Docs\Music\Unfinished.txt",
		"Rappers",                          this.PersDir "\Docs\Music\Rappers.txt",
		"Artists",                          this.PersDir "\Docs\Music\Artists.md",
                  
		"react",                            this.PersDir "\Files\Images\react.png",
		"Kristi",                           this.PersDir "\Files\Images\Kristi.png",
		"switch account ytt",               this.PersDir "\Files\Images\switch account ytt.png",
		"switch account ytm",               this.PersDir "\Files\Images\switch account ytm.png",
		"youtube logo",                     this.PersDir "\Files\Images\youtube logo.png",
		"diary",                            this.PersDir "\Files\Images\diary.png",

		"Timer.txt",                        this.PersDir "\Files\Innit\Timer.txt",

		"MethFunc",                         this.PersDir "\Lib\MethFunc.ahk",
                  
		"Keys",                             this.PersDir "\Main\Scr Keys.ahk",
						
		"Change notes",                     this.PersDir "\Notes\Change notes.md",
                  
		"Raw",                              this.PersDir "\Notes temp\Raw.md",
		"Clean",                            this.PersDir "\Notes temp\Clean.md",
		"Description",                      this.PersDir "\Notes temp\Description.txt",
		"Diary",                            this.PersDir "\Notes temp\Diary.md",
		"Output",                           this.PersDir "\Notes temp\Output.txt",

		"AhkTest",                          this.PersDir "\Test\AhkTest.ahk",
		"BatTest",                          this.PersDir "\Test\BatTest.bat",
		"1",                                this.PersDir "\Test\1.ahk",
		"2",                                this.PersDir "\Test\2.ahk",

		"Commit both directories",          this.PersDir "\Tools\Commit both directories",
		"Commit and push both directories", this.PersDir "\Tools\Commit and push both directories.bat",
		"Timer.ahk",                        this.PersDir "\Tools\Timer.ahk",
		"Symlink creator",                  this.PersDir "\Tools\Symlink creator.ahk",
		"temp",                             this.PersDir "\Tools\temp.ahk",


		"Other\synHigh settingsJson preset", this.OthrDir "\Public libraries\Ahk code coloring\synHigh settingsJson preset.txt",
		"Other\tmLanguage",                  this.OthrDir "\Public libraries\Ahk code coloring\tmLanguage.json",
		"Other\ahk snippets",                this.OthrDir "\Files\ahk.jsonc",


		"index.js",   this.JSDir "\jsm.js",
		"index.html", this.JSDir "\htt.html",
		"styles.css", this.JSDir "\css.css",



	 	"FL preset",        this.Pictures "\Editing\Tools\FL preset.flp",
		"Thumbnail preset", this.Pictures "\Editing\Tools\Thumbnail preset.xcf",



		"VsCode\settings",      A_AppData "\Code\User\settings.json",
		"VsCode\ahk snippets",  A_AppData "\Code\User\snippets\ahk.json",
		"VsCode\keybindings",   A_AppData "\Code\User\keybindings.json",

		"Ahk++\tmLanguage",    this.AhkPlusPlus "\syntaxes\ahk.tmLanguage.json",
		"Ahk++\package",       this.AhkPlusPlus "\package.json",
		"Ahk++\configuration", this.AhkPlusPlus "\ahk.configuration.json",
		"Ahk++\ahk snippets",  this.AhkPlusPlus "\snippets\ahk.json",

		"Eva\Dark",            this.VsCodeExtensions "\fisheva.eva-theme-1.8.7\themes\Eva-Dark.json",

	)
	
	LocalAppData := "C:\Users\" A_UserName "\AppData\Local"

   Apps := Map(
      "Ahk v1 docs",       A_ProgramFiles "\AutoHotkey\AutoHotkey.chm",
      "Ahk v2 docs",       A_ProgramFiles "\AutoHotkey\v2\AutoHotkey.chm",
      "Ahk compiler",      A_ProgramFiles "\AutoHotkey\Compiler\Ahk2Exe.exe",

		"Debug log",         A_ProgramFiles "\Debug view\Dbgview.exe",
		"Sort algos",        A_ProgramFiles "\Sort Algos\ArrayV-5.0.jar",
		"Shell Menu View",   A_ProgramFiles "\Shell Menu View\shmnview.exe",

      "Google Chrome",     A_ProgramFiles "\Google\Chrome\Application\chrome.exe",
		"Monkeytype",        A_ProgramFiles "\Google\Chrome\Application\chrome_proxy.exe --profile-directory=Default --app-id=picebhhlijnlefeleilfbanaghjlkkna",

      "Spotify",           A_AppData "\Spotify\Spotify.exe",
      "Telegram",          A_AppData "\Telegram Desktop\Telegram.exe",

      "Gimp",              "C:\Programs\GIMP 2\bin\gimp-2.10.exe",
      "Davinci Resolve",   "C:\Programs\Davinci Resolve\Resolve.exe",
      "FL",                "C:\Programs\FL Studio 20\FL64.exe",
      "Steam",             "C:\Programs\Steam\steam.exe",

      "Viber",             this.LocalAppData "\Viber\Viber.exe",
      "VS Code",           this.LocalAppData "\Programs\Microsoft VS Code\Code.exe",
      "Todoist",           this.LocalAppData "\Programs\todoist\Todoist.exe",
      "WPS",               this.LocalAppData "\Kingsoft\WPS Office\ksolaunch.exe",
      "Discord",           this.LocalAppData "\Discord\app-1.0.9005\Discord.exe",

   )

}
Paths := c_Paths()

Class c_Wintitles {

	youtube_isWatchingVid => (
		WinActive(" - YouTube ahk_exe chrome.exe") 
		&& !WinActive("Watch later ahk_exe chrome.exe") 
		&& !WinActive("Subscriptions ahk_exe chrome.exe")
	)

	youtube_isNotWatchingVid => (
		WinActive("Watch later ahk_exe chrome.exe")
		|| WinActive("Subscriptions ahk_exe chrome.exe")
		|| (WinActive("YouTube ahk_exe chrome.exe") && !WinActive(" - YouTube"))
	)

}
Wintitles := c_Wintitles()