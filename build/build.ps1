<# param(
    #Enter your parameters here
)
#>

$file = Join-Path $PSScriptRoot 'default.ps1'
Invoke-psake -buildFile $file -properties @{
    SourceDir  = $PSScriptRoot
}