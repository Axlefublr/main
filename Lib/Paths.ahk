;No dependencies

Class c_Paths {

	Prog           := "C:\Programming"
	Main           := "C:\Programming\Main"
	JSDir          := "C:\Programming\JS"
	SynHigh        := "C:\Programming\Ahk_v2_Syntax_Highlighting"
	Backups        := this.Main "\Backups"
	Docs           := this.Main "\Docs"
	Music          := this.Main "\Docs\Music"
	Files          := this.Main "\Files"
	Images         := this.Main "\Files\Images"
	Sounds         := this.Main "\Files\Sounds"
	Notes          := this.Main "\Notes"
	NotesTemp      := this.Main "\Notes temp"
	Test           := this.Main "\Test"
	Tools          := this.Main "\Tools"

	Pictures  := "C:\Files\Pictures"
	Editing   := this.Pictures "\Editing"
	Materials := this.Pictures "\Editing\Materials"
	Content   := this.Pictures "\Content"
	OnePiece  := this.Pictures "\Content\One Piece"
	Overlord  := this.Pictures "\Content\Overlord\Overlord 4"

	VsCodeExtensions := "C:\Users\" A_UserName "\.vscode\extensions"

	AhkPlusPlus := "C:\Users\" A_UserName "\.vscode\extensions\mark-wiemer.vscode-autohotkey-plus-plus-2.8.4"

	Ptf := Map(
		"Main", this.Main "\Backups\Main.code-workspace",

		"Discovery log", this.Main "\Docs\Music\Discovery log.txt",
		"Unfinished",    this.Main "\Docs\Music\Unfinished.txt",
		"Rappers",       this.Main "\Docs\Music\Rappers.txt",
		"Artists",       this.Main "\Docs\Music\Artists.md",
                  
		"react",              this.Main "\Files\Images\react.png",
		"Kristi",             this.Main "\Files\Images\Kristi.png",
		"switch account ytt", this.Main "\Files\Images\switch account ytt.png",
		"youtube logo",       this.Main "\Files\Images\youtube logo.png",
		"diary",              this.Main "\Files\Images\diary.png",
		"selected diary",     this.Main "\Files\Images\selected diary.png",

		"Timer.txt", this.Main "\Files\Innit\Timer.txt",

		"MethFunc", this.Main "\Lib\MethFunc.ahk",
                  
		"Keys", this.Main "\Main\Scr Keys.ahk",
						
		"Change notes", this.Main "\Notes\Change notes.md",
                  
		"Raw",         this.Main "\Notes temp\Raw.md",
		"Clean",       this.Main "\Notes temp\Clean.md",
		"Description", this.Main "\Notes temp\Description.txt",
		"Diary",       this.Main "\Notes temp\Diary.md",
		"Output",      this.Main "\Notes temp\Output.txt",

		"AhkTest",  this.Main "\Test\AhkTest.ahk",
		"AhkTest2", this.Main "\Test\1.ahk",
		"AhkTest3", this.Main "\Test\2.ahk",
		"BatTest",  this.Main "\Test\BatTest.bat",

		"Timer.ahk",       this.Main "\Tools\Timer.ahk",
		"Symlink creator", this.Main "\Tools\Symlink creator.ahk",


		"SynHigh\settings.json preset", this.SynHigh "\settings.json preset.txt",
		"SynHigh\tmLanguage",           this.SynHigh "\tmLanguage.json",
		"SynHigh\ahk snippets",         this.SynHigh "\ahk snippets.json",
		"SynHigh\configuration",        this.SynHigh "\ahk.configuration.json",
		"SynHigh\Change notes",         this.SynHigh "\Change notes.md",


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
	System32 := "C:\Windows\System32"

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

		"Sound mixer",       this.System32 "\SndVol.exe",

   )

}
Paths := c_Paths()
