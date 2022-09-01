mkdir and rmdir in runner

function that lets you have a look at which folders are currently in your workspace, in the same order

this is useful for later removing them from there

wksp_FoldersInWorkSpace() returns an array of folders currently in the workspace

wksp_FoldersInWorkSpace_Show() shows that array in a bunch of Infos()s

wksp_FoldersInProg() shows folders in the Programming folder that *aren't* added to the workspace in Infos()s