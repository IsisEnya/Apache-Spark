# Roteiro de apresentacao

Este arquivo serve como cola rapida para a demonstracao do projeto ao professor.

## Explicacao curta do projeto

Este projeto mostra como o `Apache Spark`, via `PySpark`, consegue trabalhar com dois formatos de tabela para data lake:

- `Delta Lake`
- `Apache Iceberg`

A ideia foi usar a mesma fonte de dados e o mesmo cenario de negocio para comparar como cada tecnologia permite fazer `INSERT`, `UPDATE`, `DELETE` e consultas de validacao.

## Cenario usado

Escolhemos um cenario de loja varejista com um arquivo CSV de vendas. A partir dele, explicamos tres entidades:

- `clientes`
- `produtos`
- `vendas`

Isso facilita mostrar um modelo relacional simples e, ao mesmo tempo, manter o projeto pequeno o bastante para uma apresentacao de 10 minutos.

## Estrutura que vale mostrar primeiro

Ao abrir o repositorio, mostre:

- `README.md`: explica como reproduzir o ambiente;
- `notebooks/`: contem a parte pratica do trabalho;
- `docs/`: contem a documentacao do MKDocs;
- `data/vendas.csv`: contem a base usada nos exemplos.

## Ordem sugerida da apresentacao

### 1. Contextualizacao

Fale algo como:

> O projeto foi montado em um unico ambiente PySpark com JupyterLab. A mesma base de vendas foi usada para demonstrar como o Delta Lake e o Apache Iceberg funcionam dentro do Spark.

### 2. Notebook 01 - Contexto e modelagem

Pontos para explicar:

- carregamos o CSV original;
- tipamos as colunas corretamente;
- derivamos as tabelas `clientes`, `produtos` e `vendas`;
- mostramos o modelo ER e um DDL equivalente.

Fala curta sugerida:

> Aqui eu contextualizo a fonte de dados e mostro que, mesmo partindo de um CSV unico, e possivel representar um modelo relacional coerente para o dominio de vendas.

### 3. Notebook 02 - Delta Lake

Pontos para explicar:

- o Spark recebe a extensao do Delta Lake;
- a tabela Delta e criada no diretorio local `warehouse/delta`;
- usamos a mesma base para criar a tabela inicial;
- demonstramos `INSERT`, `UPDATE` e `DELETE`;
- consultamos o historico com `DESCRIBE HISTORY`.

Fala curta sugerida:

> No Delta Lake, o ponto forte aqui e a operacao transacional com historico. Depois de inserir, atualizar e remover registros, eu consigo mostrar o historico das alteracoes feitas na tabela.

### 4. Notebook 03 - Apache Iceberg

Pontos para explicar:

- o Spark recebe o runtime do Iceberg;
- configuramos um catalogo local do tipo `hadoop`;
- criamos a tabela `local.loja.vendas_iceberg`;
- repetimos `INSERT`, `UPDATE` e `DELETE`;
- consultamos os `snapshots` gerados.

Fala curta sugerida:

> No Iceberg, a logica de manutencao da tabela continua parecida, mas a organizacao gira muito em torno de catalogo e snapshots. Por isso, no final eu mostro os snapshots como evidencia das operacoes.

### 5. MKDocs

Mostre o site gerado e diga:

> O README foi usado como guia de reproducao do ambiente, enquanto o MKDocs foi usado como documentacao explicativa do trabalho, com paginas separadas para contextualizacao, Spark, Delta Lake e Iceberg.

## Como explicar cada tecnologia

### Apache Spark

Explicacao simples:

> O Spark e o motor de processamento. Ele le o CSV, aplica transformacoes, executa SQL e grava os dados nos formatos Delta e Iceberg.

### Delta Lake

Explicacao simples:

> O Delta Lake adiciona recursos transacionais sobre arquivos em data lake, como ACID, update, delete e historico de versoes.

### Apache Iceberg

Explicacao simples:

> O Iceberg tambem e um formato de tabela para analise, mas com foco forte em catalogacao, snapshots, evolucao de schema e interoperabilidade.

## Diferenca entre README e MKDocs

Se o professor perguntar isso, responda:

> O README serve para reproducao tecnica do projeto: instalar dependencias, abrir o Jupyter e publicar a documentacao. O MKDocs serve para explicar o trabalho de forma navegavel, separando o conteudo conceitual por paginas.

## Perguntas que podem aparecer

### Por que usar o mesmo CSV para Delta e Iceberg?

Resposta:

> Para manter a comparacao justa. Assim, a diferenca observada vem da tecnologia de tabela, e nao da fonte de dados.

### Por que esse cenario de vendas?

Resposta:

> Porque ele e simples, tem relacionamento entre entidades e permite demonstrar insert, update e delete com clareza.

### Onde esta a evidencia das operacoes?

Resposta:

> No Delta, a evidencia aparece nas consultas finais e no `DESCRIBE HISTORY`. No Iceberg, aparece nas consultas finais e na tabela de metadados `snapshots`.

### Qual foi a principal dificuldade tecnica?

Resposta:

> Como o projeto foi rodado em Windows, foi preciso ajustar o ambiente local do Spark com `HADOOP_HOME`, `hadoop.home.dir` e `PATH` para o `winutils.exe`.

## Comandos para a apresentacao

### Abrir o Jupyter

```powershell
.\scripts\iniciar_jupyter.ps1
```

### Validar tudo antes

```powershell
.\scripts\validar_projeto.ps1
```

### Servir a documentacao

```powershell
python -m uv run mkdocs serve
```
