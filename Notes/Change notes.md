# Libraries:

Libraries are now split more roughly into "yes dependencies" and "no dependencies".

Instead of being "you *can* use this if you cared about installing dependecies", I'll accept that nobody is probably going to do that.

Instead, I can just send / show the specific functions when needed and the dependent libraries are just now containers for all the stuff that fits into the theme, with near unlimited dependencies

On that note, Base.ahk: It's not worth using as a dependency for the most part, especially when it's just one function that's being used.

After all, it was a library for abstractions to use straight away.

Say you want to remap some mouse button to be alt tab or copy, instead of just using send with the key, you specify the Base.ahk function to make it more readable and nicer-looking.

When used in a *library*, that decision kinda switches: an abstraction this simple makes things more difficult to work with, because now not only do you have to look for the copy function to see what it does in the new context, but also you have to download a whole library for that one function.

That said, a decision to only define the function if it's not defined already is a good idea, if it wasn't used literally only twice.         

Not worth it at this scale.

# File => commit message conversion:

Completely reprogrammed.

Now the approach taken is taking everything one step at a time, to increase maintainability

You used to have to (or at least should) account for multiples of spaces, tabs, newlines and returns 

Now all of them are taken care of before any of the other conversions, meaning each individual regex is simpler and easier to work with in the future for if I want to add or change something