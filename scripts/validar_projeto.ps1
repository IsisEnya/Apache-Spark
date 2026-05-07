$ProjectRoot = Split-Path -Parent $PSScriptRoot
$LocalHadoop = Join-Path $ProjectRoot "windows-hadoop"
$WinUtils = Join-Path $LocalHadoop "bin\\winutils.exe"

if (-not (Test-Path $WinUtils)) {
    Write-Error "winutils.exe nao encontrado em windows-hadoop\\bin\\winutils.exe"
    exit 1
}

Set-Item -Path Env:HADOOP_HOME -Value $LocalHadoop
Set-Item -Path 'Env:hadoop.home.dir' -Value $LocalHadoop
Set-Item -Path Env:PATH -Value "$LocalHadoop\bin;$env:PATH"

Set-Location $ProjectRoot

Write-Host "Executando notebook 01..."
python -m uv run jupyter nbconvert --to notebook --execute notebooks\01_contexto_modelagem.ipynb --output 01_contexto_modelagem.executed.ipynb --output-dir notebooks --ExecutePreprocessor.timeout=600

Write-Host "Executando notebook 02..."
python -m uv run jupyter nbconvert --to notebook --execute notebooks\02_delta_lake.ipynb --output 02_delta_lake.executed.ipynb --output-dir notebooks --ExecutePreprocessor.timeout=600

Write-Host "Executando notebook 03..."
python -m uv run jupyter nbconvert --to notebook --execute notebooks\03_apache_iceberg.ipynb --output 03_apache_iceberg.executed.ipynb --output-dir notebooks --ExecutePreprocessor.timeout=600

Write-Host "Gerando site do MKDocs..."
python -m uv run mkdocs build

Write-Host "Validacao concluida."
