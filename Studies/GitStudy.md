## This makes an alias for a command

```
git config --global alias.aliasName "command"
```

## This is how you change the message of the last commit (amend)

```
git commit --amend -m "new commit message"
```

## To add files you forgot to to your last commit and recommit it

```
git add .
```

```
git commit --amend --no-edit
```

No edit means you don't want to change the commit message

## This will push your local code, overwriting the one on your remote repo

```
git push origin main --force
```

Use `--force-with-lease` to only push if there are no conflicts

## This undoes the commit

```
git revert commitLogNumber
```

## Undo your changes

```
git stash
```

## Pop them back

```
git stash pop
```

## Stash with reference

```
git stash save name
git stash list
git stash apply indexNumber
```

## To change the name of your main branch

```
git branch -m oldName newName
```

## To change the name of current branch

`git branch -M newName`

## To merge your different branch commits into the main branch

```
git rebase --interactive
```

Then you have the option to squash some commits using squash instead of pick

Fixup -- if you don't want the commit messages to be squashed

Matter of fact, you can use either --fixup of --squash while commiting in the first place

Then you rebase using

```
git rebase -i --autosquash
```

## To restore code to the state of the remote repo

```
git fetch origin
git reset --hard origin/main
```

## If you checked out to a branch and want to go back to it, use

```
git checkout -
```

## Change your email

```
git config --global user.email some_other_address
```

## Track a file's commits

```
git lop -p file
```

## Remove tracking of a file

```
git rm --cached
```

## Uninitialize git

```
rm -rf .git
```

## Unstage stages files

```
git reset .
git reset file
```

> you can multiline the commit message

## New branch

```
git checkout -b branch-name
```

The b flag creates the branch

## Merge when on the master branch

```
git merge branch-name
```

You first have to checkout to the main branch

## Squashing

```
git merge branch-name --squash
```

Squashes the multiple commits on the side branch into one commit, as to not clutter up main

## Pushing the pull request

```
git push origin branch-name
```

## How to not have to put in your credentials all the time:

```
git config --global credential.helper store
```

## Change the default branch name
```
git config --global init.defaultBranch main
```

## Sync the credential manager

`git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe"`

