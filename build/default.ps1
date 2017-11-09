
[string]$TestFile = '.\Test-Pester.xml'
[string]$ModuleName = (Get-ChildItem -Directory).Name

Import-Module psake

Properties {
    $SourceDir = $SourceDir
}

task default -depends Test

task Test -depends Clean {
    $testResults = Invoke-Pester -Script @{Path = "$SourceDir\$ModuleName\tests\$ModuleName.tests.ps1"} -OutputFile $TestFile -OutputFormat NUnitXml -PassThru
    if ($testResults.FailedCount -gt 0) {
        Write-Host "##vso[task.logissue type=error;] Tests failed, build cannot continue"
        Write-Host "##vso[task.complete result=Failed;]"
        Write-Error "Tests failed, build cannot continue"
    }
}

task Clean {
    if (Test-Path $TestFile) { Remove-Item $TestFile}
}
