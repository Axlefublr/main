Safety check for wksp_AddFolderToWorkspace(): won't add a folder if it's already there

If you try to add a folder that doesn't exist, the function will not work and will say so

If you added the folder successfully, you'll get an Info() about it