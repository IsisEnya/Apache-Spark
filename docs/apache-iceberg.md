# Apache Iceberg

`Apache Iceberg` e um formato de tabela aberto voltado para grandes volumes de dados analiticos. Ele organiza metadados de forma robusta, facilita evolucao de schema e particionamento e oferece controle por snapshots.

## Configuracao usada no projeto

No notebook de Iceberg, o Spark recebe o runtime oficial e um catalogo local do tipo `hadoop`, apontando para `warehouse/iceberg`.

```python
from pyspark.sql import SparkSession

spark = (
    SparkSession.builder
    .appName("iceberg-demo")
    .master("local[*]")
    .config(
        "spark.jars.packages",
        "org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.10.1",
    )
    .config(
        "spark.sql.extensions",
        "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions",
    )
    .config("spark.sql.catalog.local", "org.apache.iceberg.spark.SparkCatalog")
    .config("spark.sql.catalog.local.type", "hadoop")
    .config("spark.sql.catalog.local.warehouse", "warehouse/iceberg")
    .getOrCreate()
)
```

## Catalogo e tabela

O projeto cria o namespace `local.loja` e a tabela `local.loja.vendas_iceberg`. Em seguida, carrega os dados vindos do CSV.

## Exemplo de INSERT

```sql
INSERT INTO local.loja.vendas_iceberg
VALUES (
    1011,
    6,
    'Marcos Lima',
    'Criciuma',
    106,
    'Mouse Gamer',
    'Perifericos',
    DATE '2026-03-11',
    2,
    180.00,
    'pago'
);
```

## Exemplo de UPDATE

```sql
UPDATE local.loja.vendas_iceberg
SET status_pagamento = 'em_analise'
WHERE id_venda = 1004;
```

## Exemplo de DELETE

```sql
DELETE FROM local.loja.vendas_iceberg
WHERE id_venda = 1008;
```

## Evidencias apresentadas

No final do notebook, sao mostrados:

- a tabela antes das alteracoes;
- o registro inserido;
- o resultado do `UPDATE`;
- a ausencia do registro removido;
- a tabela de metadados `snapshots`.

## Pontos fortes do Apache Iceberg

- forte controle de metadados;
- suporte a snapshots e time travel;
- catalogacao flexivel;
- evolucao de schema e particionamento mais organizada.
