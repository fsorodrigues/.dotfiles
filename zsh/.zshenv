# setting PATH uniqueness to keep path clean
typeset -u path

CLEAN_PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib
WIN_APP_DATA="/mnt/c/Users/felippe.rodrigues/AppData"
WIN_PGM_FILES="/mnt/c/Program Files"
WIN_WINDOWS="/mnt/c/WINDOWS"
WIN_SYS32="$WIN_WINDOWS/System32"
WIN_PATH="$WIN_PGM_FILES/Alacritty/:$WIN_SYS32:$WIN_WINDOWS:$WIN_SYS32/Wbem:$WIN_SYS32/WindowsPowerShell/v1.0/:$WIN_SYS32/OpenSSH/:$WIN_PGM_FILES/WindowsPowerShell/Scripts:$WIN_PGM_FILES/dotnet/:/mnt/c/Program Files (x86)/NVIDIA Corporation/PhysX/Common:$WIN_PGM_FILES/Docker/Docker/resources/bin:$WIN_PGM_FILES/PuTTY/:$WIN_APP_DATA/Microsoft/WindowsApps:$WIN_APP_DATA/Programs/Microsoft VS Code/bin:$WIN_APP_DATA/PowerToys/DSCModules/"
export PATH=$CLEAN_PATH:$WIN_PATH

. "$HOME/.cargo/env"
