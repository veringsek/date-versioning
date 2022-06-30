$target = $args[0]
$parent = Split-Path $target -Parent -Resolve
$name = Split-Path $target -LeafBase
$extension = Split-Path $target -Extension
$now = Get-Date
$year = $now.Year - 1911
$month = $now.month.ToString().PadLeft(2, "0")
$day = $now.day.ToString().PadLeft(2, "0")
$newname = "$name - $year-$month-$day"
$versions = Get-ChildItem $parent | Where-Object {
    $_.Name -match "^$newname(_\d+(_.+)?)?$extension$"
} | ForEach-Object {
    $version = $_.BaseName -replace '^.+ - \d\d\d-\d\d-\d\d(_(\d+))?(_.+)?$','$2'
    return $version -as [int]
}
$newversion = 0
if ($versions.Length -gt 0) {
    $latest = ($versions | Measure-Object -Maximum).Maximum
    $newversion = $latest + 1
}
$destination = "$($newname)_$newversion$extension"
if ($newversion -eq 0) {
    $destination = "$newname$extension"
}
$destination = Join-Path -Path $parent -ChildPath $destination
if (Test-Path -Path $target -PathType Container) {
    Copy-Item -Recurse -Path $target -Destination $destination
} elseif (Test-Path -Path $target -PathType Leaf) {
    Copy-Item -Path $target -Destination $destination
} else {
    Write-Error -Message "Item not exists." -ErrorAction Stop
}