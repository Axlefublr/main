# Indenting with spaces again now

Files / libraries converted:

* Global
* App
* Base
* Other
* Paths
* Press
* Script
* Sort
* StrMan
* Tools
* Win

# Reasons for the switch:

## 1: Cross-platformity

While spaces are the same size on every machine, there are some places where tabs are a specific amount of wide, which I can't control.

For example, tabs on github are fucking humongous, and if I use both spaces and tabs from time to time in one file, it will look all fucked up on github, without me knowing, and that's a maintainability issue

It's better to just use spaces everywhere to avoid that issue

## 2: Usability

Sometimes I need a bunch of spaces not as indentation, but simple formatting for some stuff

I can't use tabs because of issue #1, and also the fact that tabs would *feel* inconsistent, so I currently never use them

If I know that a tab will first paste one space and then 3 every following time, I can use tab as a way to reliably put a bunch of spaces in a place without worrying about anything

## 3: VS Code concern

I converted to tabs because vs code used to fuck around and sometimes I had to go through indentation space-by-space, rather than indent-by-indent, and didn't have to with tabs

I currently don't see this issue happenning, and hope that I won't have to in the future

## 4: Regex

While tabs are more distinct as symbols used for indentation (and are easier to regex in that sense), more often than not I have to take care of tabs by converting them into their space counterpart (because in some places, tabs will not be recognized)

And after that, I'll still end up seeing indentation as three spaces, rather than a tab

So the ease-of-regex of tabs isn't that useful in the end

Tabs would only be used for indentation, and without them, I don't even have to worry about regexing tabs, since there would be none. Still a good idea to take care of that, but unnecessary