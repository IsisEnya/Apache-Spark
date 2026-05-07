$ProjectRoot = Split-Path -Parent $PSScriptRoot
$BinDir = Join-Path $ProjectRoot "windows-hadoop\\bin"

New-Item -ItemType Directory -Force -Path $BinDir | Out-Null

$Downloads = @(
    @{
        Url = "https://raw.githubusercontent.com/cdarlint/winutils/master/hadoop-3.3.6/bin/winutils.exe"
        OutFile = (Join-Path $BinDir "winutils.exe")
    },
    @{
        Url = "https://raw.githubusercontent.com/cdarlint/winutils/master/hadoop-3.3.6/bin/hadoop.dll"
        OutFile = (Join-Path $BinDir "hadoop.dll")
    }
)

foreach ($Item in $Downloads) {
    Write-Host "Baixando $($Item.Url)..."
    Invoke-WebRequest -Uri $Item.Url -OutFile $Item.OutFile
}

Write-Host "Arquivos baixados em $BinDir"
