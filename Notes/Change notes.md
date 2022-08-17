Morse code readded because I got the desire to add a japanese character paster, meaning I might have a use of morse code too

\> instead of k for skipper because it makes more sense

\\> of markdown is now converted to \> (this makes more sense if you look at the commit message itself) - I haven't yet used quotes in my change notes, and if I need to mention the character >, I might need to escape it, which wouldn't make sense while looking at the commit message, so for now it's just removed with no further insight 

> Premature optimisation is the root of all evil

So here I used a quote, and the > part of it just gets removed just like #'s do

But if I were to \> it, it would become > in the commit message

In the last sentence, > had a backslash before it, and didn't convert to just >, because it's not at the start of the line, so I didn't *need* to escape it, meaning I also want the escape character

The md => commit msg converter now supports multiple ### as lables, I don't remember using it in my change notes, but this is such a simple change that I might as well do it