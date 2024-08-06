$spotify_path = scoop which Spotify

if (-not $spotify_path) {
    Write-Error "The `spotify-latest` package is not installed."
    exit 1
}

$spotify_dir = Split-Path $spotify_path
$spotify_dir_parent = Split-Path $spotify_dir

if ((Split-Path $spotify_dir_parent -leaf) -ne "spotify-latest") {
    $spotify_dir = "$(Split-Path $spotify_dir_parent)\\spotify-latest\\current"

    if (-not (Test-Path $spotify_dir)) {
        Write-Error "The `spotify-latest` package is not installed."
        exit 1
    }
}

if ((Get-FileHash -ErrorAction SilentlyContinue "$spotify_dir\dpapi.dll").Hash -ne (Get-FileHash "$PSScriptRoot\dpapi.dll").Hash) {
    $spotify_running = Get-Process -ErrorAction Ignore -Name Spotify
    Stop-Process -ErrorAction Ignore -Name Spotify | Out-Null

    Copy-Item "$PSScriptRoot\dpapi.dll" -Destination "$spotify_dir"

    if (-not (Get-Content -ErrorAction Ignore "$spotify_dir\config.ini")) { Copy-Item "$PSScriptRoot\config.ini" -Destination "$spotify_dir" }

    if ($spotify_running) { Start-Process "$spotify_path" }
}
