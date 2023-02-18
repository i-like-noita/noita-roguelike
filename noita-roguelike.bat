@echo off

:: DO NOT RUN THIS IF YOU HAVE NOT MADE A BACKUP OF YOUR SAVE. I AM NOT RESPONSIBLE IF YOU LOSE DATA





:: Set some variables
set "noita_exe=noita.exe"
set "install_dir="
set "steam_dir=C:\Program Files (x86)\Steam\"

:: Check if Steam is installed
if exist "%steam_dir%" (
    set "install_dir=%steam_dir%"
)

:: If Steam is not installed, sorry. You can fix it, I promise
if not defined install_dir (
    echo Error: Steam installation directory not found.
    pause
    goto :EOF
)

:: Default locations for Noita save files. Hopefully this works for you
set "save_dir=%appdata%\..\LocalLow\Nolla_Games_Noita\save00"
set "bak_dir=%appdata%\..\LocalLow\Nolla_Games_Noita\save00_bak"
set "warning=%save_dir%\persistent\flags\secret_warning"

:: Warn the user to make a backup
if not exist "%warning%" (
    echo CLOSE THE WINDOW IF YOU HAVE NOT MADE A BACKUP OF YOUR SAVE
    pause
    echo CONTINUING TO EXECUTE THIS FILE == YOU AGREE I AM NOT RESPONSIBLE FOR YOUR LOSS OF DATA
    pause
    echo SERIOUSLY LAST WARNING, THIS WILL DELETE YOUR CURRENT SAVE FILE
    pause
)

:: If we never made a backup, make a backup
if not exist "%bak_dir%" (
    echo Renaming %save_dir% to save00_bak...
    ren "%save_dir%" "save00_bak"
)

:: Since we *SHOULD* be backed up now, delete the save directory
echo Deleting %save_dir%...
rmdir /s /q "%save_dir%"

:: Restore crown and amulet cosmetics
echo Creating persistent flags for crown and amulet...
mkdir "%save_dir%\persistent\flags"
echo why are you looking here > "%save_dir%\persistent\flags\secret_hat"
echo why are you looking here > "%save_dir%\persistent\flags\secret_amulet"
:: echo why are you looking here > "%save_dir%\persistent\flags\secret_gem"
:: you haven't actually obtained this yet, but if you must, remove ":: " from the last line
echo why are you looking here > "%save_dir%\persistent\flags\secret_warning"

:: Launch Noita through Steam
echo Starting Noita...
start "" "%install_dir%\steam.exe" -applaunch 881100
echo Done!
