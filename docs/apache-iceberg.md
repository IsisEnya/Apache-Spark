# Apache Iceberg

`Apache Iceberg` foi utilizado no projeto como segunda tecnologia de tabela analitica, permitindo comparar sua abordagem com a do Delta Lake. Seu principal destaque na demonstracao foi o uso de catalogo e metadados baseados em snapshots.

## O que o Apache Iceberg oferece

O Iceberg e um formato de tabela aberto voltado para ambientes analiticos. No contexto do trabalho, ele se destacou por oferecer:

- organizacao robusta de metadados;
- uso de catalogo para gerenciamento das tabelas;
- suporte a snapshots;
- operacoes de manutencao com SQL;
- base solida para evolucao de schema e interoperabilidade.

## Configuracao usada no projeto

No notebook de Iceberg, o Spark recebe o runtime oficial e um catalogo local do tipo `hadoop`.

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

## Catalogo e tabela utilizados

O projeto cria o namespace `local.loja` e a tabela `local.loja.vendas_iceberg`. A partir disso, a mesma base de vendas usada no Delta e gravada em formato Iceberg.

## Fluxo executado no notebook

1. leitura do CSV;
2. padronizacao dos tipos das colunas;
3. criacao do namespace e da tabela Iceberg;
4. insercao de um novo registro;
5. atualizacao de um registro existente;
6. exclusao de um registro;
7. consulta aos `snapshots` da tabela.

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

## Por que isso e importante

Enquanto o Delta destaca o historico operacional da tabela, o Iceberg evidencia como os snapshots e o catalogo organizam o estado dos dados ao longo do tempo. Isso ajuda a mostrar que a tecnologia nao se limita ao armazenamento, mas tambem ao gerenciamento estruturado do conjunto de dados.

## Pontos fortes observados

| Aspecto | Evidencia no projeto |
| --- | --- |
| Catalogacao | Uso de `local.loja.vendas_iceberg` |
| Metadados | Consulta aos `snapshots` |
| Manutencao de dados | `INSERT`, `UPDATE` e `DELETE` com SQL |
| Clareza da arquitetura | Separacao entre namespace, tabela e warehouse |

## Sintese

No trabalho, o Apache Iceberg se destacou como uma alternativa moderna e aberta para gerenciamento de tabelas analiticas, com enfase em snapshots, catalogacao e organizacao de metadados.
