param (
    [Parameter(Mandatory=$true)]
    [string]$SourceDirectory,
    
    [Parameter(Mandatory=$true)]
    [string]$DestinationDirectory
)

$fileList = Get-ChildItem -Recurse -File -LiteralPath $SourceDirectory

$totalFiles = $fileList.Count
$currentFile = 0

# Check if the destination directory exists, and create it if necessary
if (-not (Test-Path -Path $DestinationDirectory)) {
    New-Item -ItemType Directory -Path $DestinationDirectory | Out-Null
}

foreach ($file in $fileList) {
    $currentFile++
    $progressPercentage = [Math]::Round(($currentFile / $totalFiles) * 100, 2)

    Write-Progress -Activity "Moving Files" -Status "Progress: $progressPercentage% ($currentFile/$totalFiles)" -PercentComplete $progressPercentage

    if (-not $file.PSIsContainer) {
        Move-Item -Path $file.FullName -Destination $DestinationDirectory -Force
    }
}

# Delete the source directory and all its contents
Remove-Item -Path $SourceDirectory -Recurse -Force

Write-Progress -Activity "Moving Files" -Status "Completed" -Completed
