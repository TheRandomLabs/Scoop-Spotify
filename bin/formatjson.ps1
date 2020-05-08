if (!$env:SCOOP_HOME) { $env:SCOOP_HOME = Resolve-Path(Split-Path(Split-Path(scoop which scoop))) }
$formatjson = "$env:SCOOP_HOME\bin\formatjson.ps1"
$dir = "$psscriptroot\..\bucket"
Invoke-Expression -Command "& '$formatjson' -dir '$dir' $($args | ForEach-Object { "$_ " })"
