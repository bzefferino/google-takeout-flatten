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

    if ($file.Name -notlike "*.json") {
        Move-Item -Path $file.FullName -Destination $DestinationDirectory -Force
    }    
}

Write-Progress -Activity "Moving Files" -Status "Completed" -Completed
