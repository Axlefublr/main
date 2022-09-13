For the extension, it's important to have the #include in the file for "go to definition" to work. If the include is going to happen anyway through the main script, but isn't present in this current file, there's a high chance that the command won't work

For this reason, I'm making Includes that are far more elaboratory than they were before

The decision to make file includes rather than standard library might be overreacting, but first I'll complete it this way, test it, then go back to standard and see if it works the same way

The only pretty annoying thing would be the fact that the libraries would get doubled when I work on them. I go to definition and I'm in the standard library folder. I open a file and I'll discern which is *not* the standard library (adding on to the annoyance)

Maybe it will actually be better to have file includes, this way it's consistently one file per file

Or a different solution: adding the standard library to the workspace and working with it from there, git and all. That also works, might be the way I end up taking.

Only annoyance with that is that the repo name will be different from the folder name, but that's *okay* I **think**