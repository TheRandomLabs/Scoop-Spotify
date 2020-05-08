if (!$env:SCOOP_HOME) { $env:SCOOP_HOME = Resolve-Path(Split-Path(Split-Path(scoop which scoop))) }
$checkver = "$env:SCOOP_HOME\bin\checkver.ps1"
$dir = "$psscriptroot\..\bucket"
Invoke-Expression -Command "& '$checkver' -dir '$dir' $($args | ForEach-Object { "$_ " })"
