#Include <Directives\Base>
#SingleInstance Off

#Include <Tools\Timer>
#Include <Abstractions\Text>
#Include <Paths>

Timer(ReadFile(Paths.Ptf["time-agent"]), true).Start()
