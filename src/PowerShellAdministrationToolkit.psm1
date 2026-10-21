$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

Get-ChildItem -Path (Join-Path $scriptRoot 'Private') -Filter '*.ps1' -Recurse -ErrorAction SilentlyContinue | Sort-Object FullName | ForEach-Object {
    . $_.FullName
}

Get-ChildItem -Path (Join-Path $scriptRoot 'Public') -Filter '*.ps1' -Recurse -ErrorAction SilentlyContinue | Sort-Object FullName | ForEach-Object {
    . $_.FullName
}

$exportedFunctions = @()
$exportedFunctions += Get-ChildItem -Path (Join-Path $scriptRoot 'Public') -Filter '*.ps1' -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
    [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
}

if ($exportedFunctions.Count -gt 0) {
    Export-ModuleMember -Function $exportedFunctions
}
