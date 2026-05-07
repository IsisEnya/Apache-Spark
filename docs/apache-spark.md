# Apache Spark e PySpark

`Apache Spark` e o motor de processamento central deste trabalho. Ele foi responsavel por ler a fonte de dados, aplicar transformacoes, registrar visoes temporarias, executar consultas SQL e gravar os dados tanto em `Delta Lake` quanto em `Apache Iceberg`.

## O que e o Apache Spark

O Spark e uma plataforma de processamento distribuido voltada para cargas analiticas. Mesmo quando usado localmente, como neste projeto, ele preserva a mesma logica de execucao que seria utilizada em ambientes maiores.

Entre suas principais capacidades, destacam-se:

- processamento de grandes volumes de dados;
- uso de `DataFrames` e SQL;
- integracao com formatos de tabela modernos;
- execucao em notebooks e pipelines de engenharia de dados.

## Papel do PySpark neste projeto

`PySpark` e a interface Python do Spark. Foi por meio dela que o projeto:

- criou as `SparkSession`;
- leu o arquivo `data/vendas.csv`;
- converteu tipos de dados;
- criou visoes temporarias;
- executou consultas SQL;
- gravou tabelas em formatos analiticos diferentes.

Exemplo de inicializacao:

```python
from pyspark.sql import SparkSession

spark = (
    SparkSession.builder
    .appName("trabalho-spark")
    .master("local[*]")
    .getOrCreate()
)
```

## Por que usar Spark neste trabalho

O Spark foi escolhido porque permite comparar `Delta Lake` e `Apache Iceberg` sobre a mesma base, no mesmo ambiente e com comandos muito parecidos. Isso torna a demonstracao mais justa e mais facil de explicar.

## Fonte usada

O projeto utiliza o arquivo `data/vendas.csv` como camada de entrada. A partir dessa base, os dados sao preparados para que possam ser usados tanto no notebook de Delta quanto no notebook de Iceberg.

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

| Coluna | Tipo aplicado |
| --- | --- |
| `id_venda` | `BIGINT` |
| `id_cliente` | `INT` |
| `id_produto` | `INT` |
| `data_venda` | `DATE` |
| `quantidade` | `INT` |
| `preco_unitario` | `DOUBLE` |

Essas transformacoes sao importantes porque deixam os exemplos SQL mais proximos de um cenario real e evitam ambiguidade de tipos.

## Modelo relacional proposto

Embora a fonte seja um CSV unico, o trabalho foi modelado com tres entidades principais:

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

## Fluxo do Spark no projeto

O papel do Spark pode ser resumido neste encadeamento:

1. ler o CSV;
2. aplicar tipagem;
3. disponibilizar os dados para analise;
4. criar tabelas analiticas;
5. executar comandos de manutencao e consultas de evidencia.

## Vantagens do Spark para a apresentacao

- uma mesma base alimenta Delta e Iceberg;
- a mesma linguagem SQL pode ser reaproveitada;
- as diferencas de configuracao ficam evidentes;
- a execucao local cabe em uma demonstracao curta;
- o ambiente combina bem com notebooks para apresentacao.

## Observacao para Windows

Em ambientes Windows, o PySpark pode exigir `HADOOP_HOME`, `hadoop.home.dir` e acesso ao `winutils.exe`. Por isso, o projeto inclui scripts auxiliares para baixar o binario e iniciar o Jupyter com a configuracao correta.
