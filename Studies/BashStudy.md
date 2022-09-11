## Changning permissions for a file

`chmod +x -r +w filepath`

## Variables

`name="value"`

`$name`

## Reading the output of a command as a variable

`name=$(read)` Instead of reading a variable, we're reading the output of a command

You don't have to assign it to a variable, you can do it inline too

`echo "you are $(whoami), currently in the $(pwd) directory"` => you are axlefublr, currently in the /home/axlefublr directory

## Processing user input

`read variable` Meaning, "read into variable"

## Passing parameters to a script

Pass parameters after the path just like in bat

When accessing, use `$1`, `$2`, etc, just like bat

## If statements and comparison

```bash
if [ $name == "Sergey" ]; then
   echo your name is $name
else
   echo your name is not $name
fi
```

There *have* to be `[]` with spaces between them

## Who am I?

`whoami` to get the current user echoed

## Print working directory

`pwd`

## Get current full date

`date`

## Find lines in a file that contain a certain text

`grep -i "to search for" file.txt`

## See how big a file is

`du -h file.txt`

## Change the owner of a file

`chown diff-user file.txt`

## See what commands you've executed

`history`

`!\d` to execute the command by number in the history you got

`HISTTIMEFORMAT="%Y-%m-%d %T "` That's how you enable the time for the history command

Doesn't work in zsh ^

## Go back to the directory you were just in (not necessarily the upper dir)

`cd -`

## Resetting your shell

`reset`

## Stashing a directory

```sh
pushd /Programming
popd
```

## Background / foreground for terminal apps

`^z` to go back to the terminal

`fg` to go forward to the app

## System info program

`htop`

## Run previous command as admin

`sudo !!` where !! refers to the last command done

## Recent commands

`^r` to pop into search

Keep pressing it to go through the available search results

## cmatrix

## Chaining commands

`;` works like a try statement: will execute all commands even if any of them fail

`git add .; git commit -m "first commit"; git push` - all that in a single line, and it does its thing by itself

This way you can easily set up a few commands that might take a while and not have to wait for all of them individually, just all of them together

`&&` is that, but won't execute the following commands if one fails

## Tailing files / watching the end of a file in real time

`tail -f file.txt`

## Truncating a file / deleting the contents of a file

`truncate -s size-int file.txt`

## Copying last command's argument

Press `esc .` to paste the last command's argument at the cursor's position