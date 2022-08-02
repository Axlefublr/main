GitLink fixed: The mother of all eggs is C:\Programming, so any folder within that folder is considered a project folder

Meaning, the regex takes the name of the folder right after programming as the project folder
and the relative path of the file / folder I select

We get them into two separate variables because we need the blob/main thing (or tree/main)

Whether it's one or the other, and whether the selection screen lets me select a file or a folder is decided by a gui

Gui with two buttons: File and Folder. Depending on which I press, we'll go on one of the two paths

Since you can't return out of an outer function with a called function (I think), whether we go on after just closing the gui is decided by a variable, which gets assigned to true if you click any of the two buttons

Selection type is static, meaning that your last choice of folder vs file will be remembered (at least in theory, I'm unlikely to actually use that)

As always, you can close the gui with escape