$ProjectRoot = Split-Path -Parent $PSScriptRoot
$LocalHadoop = Join-Path $ProjectRoot "windows-hadoop"
$WinUtils = Join-Path $LocalHadoop "bin\\winutils.exe"

if (Test-Path $WinUtils) {
    Set-Item -Path Env:HADOOP_HOME -Value $LocalHadoop
    Set-Item -Path 'Env:hadoop.home.dir' -Value $LocalHadoop
    Set-Item -Path Env:PATH -Value "$LocalHadoop\bin;$env:PATH"
    Write-Host "HADOOP_HOME configurado para $LocalHadoop"
} else {
    Write-Warning "winutils.exe nao foi encontrado em windows-hadoop\\bin\\winutils.exe"
    Write-Warning "Se o Spark falhar no Windows, copie o winutils.exe para essa pasta e execute novamente."
}

Set-Location $ProjectRoot
python -m uv run jupyter lab
