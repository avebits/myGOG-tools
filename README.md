# myGOG-tools for Windows

Script tool to aid in downloading/backup and installing GOG's games. Run as Administrator.

The first part work in conjuction with Kalanyr's excellent gogrepo script with options. Needs https://github.com/Kalanyr/gogrepoc

The second part is to temporarily set a different temp/tmp on another partition/harddrive if C: doesn't have enough space for the bigger games, it then revert to the old temp/tmp path. Works with any application.

Look for, and change these to your likings:

::  user configs

set "gogpy=f:\gogrepoc.py"

set "gogdir=f:\gog\"

set "NEW_TEMP=d:\Temp"

set "NEW_TMP=d:\Temp"

set "INITIAL_DIR=%USERPROFILE%\Downloads" :: 
