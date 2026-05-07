# Trabalho de Pesquisa com Apache Spark, Delta Lake e Apache Iceberg

Este projeto foi organizado para atender ao enunciado da disciplina de Arquitetura de Dados. A proposta demonstra, em um unico ambiente `PySpark + JupyterLab`, como criar e manipular tabelas com `Delta Lake` e `Apache Iceberg`, incluindo exemplos de `INSERT`, `UPDATE`, `DELETE` e consultas de verificacao.

## Objetivo do trabalho

O trabalho entrega:

- ambiente unico com `PySpark` e `JupyterLab`;
- um notebook para contextualizacao e modelagem;
- um notebook com implementacao em `Delta Lake`;
- um notebook com implementacao em `Apache Iceberg`;
- `README.md` com reproducao passo a passo;
- documentacao em `MKDocs`;
- estrutura pronta para publicacao com `mkdocs gh-deploy`.

## Cenario escolhido

O projeto usa um cenario simples de vendas de loja. A fonte de dados esta em [data/vendas.csv](data/vendas.csv) e representa vendas com informacoes de cliente, produto, quantidade, preco e status de pagamento.

Esse cenario foi escolhido porque facilita:

- explicar o modelo relacional;
- derivar as entidades `clientes`, `produtos` e `vendas`;
- demonstrar comandos `INSERT`, `UPDATE` e `DELETE`;
- apresentar o trabalho em poucos minutos sem perder clareza.

## Estrutura do projeto

```text
Apache-Spark/
|-- README.md
|-- pyproject.toml
|-- uv.lock
|-- .gitignore
|-- data/
|   `-- vendas.csv
|-- docs/
|   |-- index.md
|   |-- apache-spark.md
|   |-- delta-lake.md
|   |-- apache-iceberg.md
|   `-- assets/
|       `-- modelo-er.svg
|-- notebooks/
|   |-- 01_contexto_modelagem.ipynb
|   |-- 02_delta_lake.ipynb
|   `-- 03_apache_iceberg.ipynb
`-- warehouse/
    |-- delta/
    `-- iceberg/
```

## Requisitos

Antes de executar o projeto, tenha instalado:

- `Python 3.11` ou superior;
- `Java 17` recomendado para o ecossistema Spark/Delta;
- `Git`;
- acesso a internet para baixar os pacotes Maven do Spark na primeira execucao.

### Observacao importante para Windows

Em Windows, o `PySpark` normalmente precisa de `HADOOP_HOME` configurado com o arquivo `winutils.exe`. Para evitar depender de uma configuracao global da maquina, este projeto ja reserva a pasta local `windows-hadoop/bin/`.

Se voce estiver em Windows, coloque o arquivo abaixo neste caminho:

```text
windows-hadoop/bin/winutils.exe
```

Para automatizar esse passo nesta maquina, use:

```powershell
.\scripts\baixar_winutils.ps1
```

Depois disso, use o script abaixo para iniciar o Jupyter com as variaveis locais configuradas:

```powershell
.\scripts\iniciar_jupyter.ps1
```

Se o comando `uv` ainda nao existir na sua maquina, instale com:

```powershell
python -m pip install --user uv
```

## Como reproduzir o ambiente

### 1. Clonar o repositorio

```powershell
git clone <URL_DO_REPOSITORIO>
cd Apache-Spark
```

### 2. Sincronizar as dependencias

Este projeto usa `UV` como gerenciador de ambiente e dependencias.

```powershell
python -m uv sync
```

O comando acima cria a pasta `.venv/` e instala exatamente as versoes travadas em `uv.lock`.

### 3. Abrir o JupyterLab

```powershell
python -m uv run jupyter lab
```

No Windows, prefira este comando:

```powershell
.\scripts\iniciar_jupyter.ps1
```

Depois de abrir o JupyterLab, execute os notebooks nesta ordem:

1. [notebooks/01_contexto_modelagem.ipynb](notebooks/01_contexto_modelagem.ipynb)
2. [notebooks/02_delta_lake.ipynb](notebooks/02_delta_lake.ipynb)
3. [notebooks/03_apache_iceberg.ipynb](notebooks/03_apache_iceberg.ipynb)

## O que cada notebook faz

### 01_contexto_modelagem.ipynb

- apresenta o problema de negocio;
- carrega o arquivo CSV;
- deriva as entidades `clientes`, `produtos` e `vendas`;
- mostra o modelo ER;
- registra um exemplo de DDL para as tabelas.

### 02_delta_lake.ipynb

- cria uma `SparkSession` configurada para `Delta Lake`;
- inicializa uma tabela Delta local;
- carrega os dados da fonte;
- demonstra `INSERT`, `UPDATE` e `DELETE`;
- consulta o historico da tabela.

### 03_apache_iceberg.ipynb

- cria uma `SparkSession` com extensoes do `Apache Iceberg`;
- configura um catalogo local do tipo `hadoop`;
- cria uma tabela Iceberg;
- demonstra `INSERT`, `UPDATE` e `DELETE`;
- consulta os `snapshots` da tabela.

## Como servir a documentacao localmente

```powershell
python -m uv run mkdocs serve
```

Depois disso, abra a URL exibida no terminal, normalmente `http://127.0.0.1:8000`.

## Como publicar no GitHub Pages

Antes do deploy, envie o projeto para um repositorio publico no GitHub e configure o remote `origin`.

```powershell
git add .
git commit -m "Entrega inicial do trabalho Spark Delta Iceberg"
git branch -M main
git remote add origin <URL_DO_REPOSITORIO>
git push -u origin main
python -m uv run mkdocs gh-deploy
```

O comando `mkdocs gh-deploy` cria ou atualiza a branch `gh-pages`, que pode ser publicada no GitHub Pages.

## Script auxiliar para Windows

O arquivo [scripts/iniciar_jupyter.ps1](scripts/iniciar_jupyter.ps1) tenta usar automaticamente um `winutils.exe` local em `windows-hadoop/bin/`. Isso ajuda a reduzir problemas de ambiente durante a apresentacao.

Quando o arquivo estiver presente, o script configura:

- `HADOOP_HOME`
- `hadoop.home.dir`
- `PATH` com `windows-hadoop/bin`

O arquivo [scripts/baixar_winutils.ps1](scripts/baixar_winutils.ps1) baixa `winutils.exe` e `hadoop.dll` para uso local no Windows. Ele usa um repositório comunitario, por isso os binarios estao ignorados no Git e nao precisam ser publicados no repositório do trabalho.

## Validacao rapida do projeto

Se voce quiser conferir se o projeto continua funcionando antes da apresentacao, execute:

```powershell
.\scripts\validar_projeto.ps1
```

Esse script:

- configura o ambiente Windows para o Spark;
- executa os 3 notebooks em modo automatizado;
- reconstrói o site do `MKDocs`.

## Dependencias principais

As principais dependencias usadas neste projeto sao:

- `pyspark==3.5.7`
- `delta-spark==3.3.2`
- `jupyterlab==4.4.3`
- `mkdocs==1.6.1`
- `mkdocs-material==9.6.14`

Para `Apache Iceberg`, o notebook usa o runtime oficial:

```text
org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.10.1
```

## Roteiro de apresentacao em 10 minutos

Uma forma simples de apresentar o projeto:

1. mostrar a estrutura do repositorio;
2. explicar rapidamente o cenario de vendas e o modelo ER;
3. abrir o notebook de Delta Lake e executar as celulas de `INSERT`, `UPDATE` e `DELETE`;
4. abrir o notebook de Iceberg e repetir o fluxo;
5. abrir o `MKDocs` publicado e mostrar as quatro paginas.

## Referencias tecnicas

- [Delta Lake - matriz de compatibilidade](https://docs.delta.io/releases/)
- [Delta Lake - quick start](https://docs.delta.io/quick-start/)
- [Apache Iceberg - Spark getting started](https://iceberg.apache.org/docs/latest/docs/spark-getting-started/)
- [Apache Iceberg - Spark writes](https://iceberg.apache.org/docs/1.8.0/spark-writes/)
