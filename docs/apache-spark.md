# Apache Spark e PySpark

`Apache Spark` e um motor distribuido de processamento de dados. Ele foi criado para executar cargas analiticas com alta performance, suportando transformacoes em grande escala, SQL, streaming e machine learning.

## Por que usar Spark neste trabalho

Neste projeto, o Spark foi usado porque ele:

- integra bem com `Delta Lake` e `Apache Iceberg`;
- permite trabalhar com SQL e DataFrames;
- simplifica testes locais em modo `local[*]`;
- facilita a demonstracao em sala com notebooks.

## Papel do PySpark

`PySpark` e a API Python do Apache Spark. Ele permite criar `SparkSession`, carregar arquivos, transformar colunas, executar consultas SQL e escrever tabelas.

Exemplo de inicio de sessao:

```python
from pyspark.sql import SparkSession

spark = (
    SparkSession.builder
    .appName("trabalho-spark")
    .master("local[*]")
    .getOrCreate()
)
```

## Fonte usada

O arquivo `data/vendas.csv` funciona como camada de entrada. Depois da leitura, a base pode ser reutilizada tanto no notebook de Delta Lake quanto no notebook de Iceberg.

Exemplo de leitura:

```python
df = (
    spark.read
    .option("header", True)
    .csv("data/vendas.csv")
)
```

## Transformacoes aplicadas

Antes de gravar os dados em tabelas analiticas, o projeto padroniza os tipos das colunas:

- `id_venda` como `BIGINT`;
- `id_cliente` e `id_produto` como `INT`;
- `data_venda` como `DATE`;
- `quantidade` como `INT`;
- `preco_unitario` como `DOUBLE`.

Essas conversoes evitam ambiguidades e deixam os exemplos SQL mais proximos de um ambiente real.

## Modelo relacional proposto

O trabalho parte de um CSV unico, mas o modelo de negocio foi descrito com tres tabelas:

```sql
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome_cliente STRING,
    cidade STRING
);

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome_produto STRING,
    categoria STRING,
    preco_unitario DOUBLE
);

CREATE TABLE vendas (
    id_venda BIGINT PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    data_venda DATE,
    quantidade INT,
    preco_unitario DOUBLE,
    status_pagamento STRING
);
```

## Vantagens do Spark para a apresentacao

- uma mesma base alimenta Delta e Iceberg;
- a mesma linguagem SQL pode ser reaproveitada;
- as diferencas de configuracao ficam evidentes;
- a execucao local cabe em uma demonstracao curta.

## Observacao para Windows

Em ambientes Windows, o PySpark pode exigir `HADOOP_HOME` com `winutils.exe`. Por isso, o projeto reserva a pasta local `windows-hadoop/bin/` e inclui um script PowerShell para iniciar o Jupyter com essa configuracao quando o arquivo estiver presente.
