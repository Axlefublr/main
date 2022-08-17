The regex switch in runner is now a map

Can't make it static, because the input is always different

Everything is an arrow function rather than bind because that hides errors, the other way of doing this would be putting a try everywhere, which would be more inefficient than just wrapping everything in a function

Instead of having to go through every possible regex until it's true, the time is spent on creating the map instead. 

With how many entries I already have, this now makes more sense to do