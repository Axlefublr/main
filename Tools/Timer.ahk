#SingleInstance Off
Persistent true
#Include <Timer>
#Include <Text>
#Include <Paths>

Timer(ReadFile(Paths.Ptf["Timer.txt"]),, true)