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

## See what commands you've execute

`history`