# Delta Lake

`Delta Lake` adiciona recursos de confiabilidade sobre arquivos em data lake, como transacoes ACID, historico de versoes e operacoes de atualizacao e exclusao com semantica transacional.

## Configuracao usada no projeto

No notebook de Delta, a sessao Spark e configurada com a extensao oficial do Delta e com o catalogo Delta para o `spark_catalog`.

```python
from delta import configure_spark_with_delta_pip
from pyspark.sql import SparkSession

builder = (
    SparkSession.builder
    .appName("delta-lake-demo")
    .master("local[*]")
    .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension")
    .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")
)

spark = configure_spark_with_delta_pip(builder).getOrCreate()
```

## Tabela usada

O notebook cria uma tabela Delta no diretorio local `warehouse/delta/vendas_delta`. Depois disso, os dados do CSV sao inseridos nessa estrutura.

## Exemplo de INSERT

```sql
INSERT INTO delta.`C:/caminho/do/projeto/warehouse/delta/vendas_delta`
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
UPDATE delta.`C:/caminho/do/projeto/warehouse/delta/vendas_delta`
SET status_pagamento = 'estornado', quantidade = 3
WHERE id_venda = 1003;
```

## Exemplo de DELETE

```sql
DELETE FROM delta.`C:/caminho/do/projeto/warehouse/delta/vendas_delta`
WHERE id_venda = 1008;
```

## Evidencias apresentadas

Depois das operacoes, o notebook mostra:

- o estado inicial da tabela;
- o registro inserido;
- o registro atualizado;
- o registro removido;
- o historico da tabela com `DESCRIBE HISTORY`.

## Pontos fortes do Delta Lake

- transacoes ACID sobre arquivos;
- comandos `UPDATE` e `DELETE` de forma nativa;
- historico de operacoes;
- boa integracao com o ecossistema Spark.
