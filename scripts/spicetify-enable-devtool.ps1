[CmdletBinding()]
param (
    [Switch]$quiet = $false
)

$spotify_running = Get-Process -ErrorAction Ignore -Name Spotify
Stop-Process -ErrorAction Ignore -Name Spotify

# restore should be run separately because if there is no backup, it will error and exit
if ($quiet) {
    & "$PSScriptRoot\spicetify.exe" restore --quiet --no-restart
    & "$PSScriptRoot\spicetify.exe" backup apply disable-devtool --quiet --no-restart
} else {
    & "$PSScriptRoot\spicetify.exe" restore --no-restart
    & "$PSScriptRoot\spicetify.exe" backup apply disable-devtool --no-restart
}

if (Get-Command "blockthespot" -ErrorAction Ignore) { blockthespot }
if ($spotify_running) { Start-Process "$(& `"$PSScriptRoot\get-spotify-path.ps1`")" }
