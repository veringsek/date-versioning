Param(
    [string]$lang = 'en'
)

$STRING = 'Make a Date Version'
if ($lang -eq 'zh') {
    $STRING = '建立日期版本'
}

$main = Join-Path -Path $PSScriptRoot -ChildPath date-versioning.ps1
$main = 'pwsh -c "' + $main + '" ' + "'" + '%1' + "'"

New-Item -Force -Path 'HKCU:\Software\Classes\Directory\shell\date-versioning'
New-ItemProperty -Force -LiteralPath 'HKCU:\Software\Classes\Directory\shell\date-versioning' -Name '(Default)' -Value $STRING -PropertyType 'String'
New-Item -Force -Path 'HKCU:\Software\Classes\Directory\shell\date-versioning\command'
New-ItemProperty -Force -LiteralPath 'HKCU:\Software\Classes\Directory\shell\date-versioning\command' -Name '(Default)' -Value $main -PropertyType 'String'

New-Item -Force -Path 'HKCU:\Software\Classes\*\shell\date-versioning'
New-ItemProperty -Force -LiteralPath 'HKCU:\Software\Classes\*\shell\date-versioning' -Name '(Default)' -Value $STRING -PropertyType 'String'
New-Item -Force -Path 'HKCU:\Software\Classes\*\shell\date-versioning\command'
New-ItemProperty -Force -LiteralPath 'HKCU:\Software\Classes\*\shell\date-versioning\command' -Name '(Default)' -Value $main -PropertyType 'String'