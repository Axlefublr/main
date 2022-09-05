DarkMode(guiObj) {
   guiObj.BackColor := "171717"
   guiObj.SetFont("s20 cC5C5C5", "Consolas")
   return guiObj
}
Gui.Prototype.DefineProp("DarkMode", {Call: DarkMode})