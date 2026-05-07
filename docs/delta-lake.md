# Delta Lake

`Delta Lake` foi utilizado neste projeto como exemplo de tabela analitica com forte integracao ao ecossistema Spark. Seu principal destaque na demonstracao foi a capacidade de manter operacoes transacionais e historico de alteracoes sobre arquivos em data lake.

## O que o Delta Lake adiciona

Ao usar Delta Lake, o projeto passa a contar com:

- transacoes ACID sobre arquivos;
- suporte nativo a `INSERT`, `UPDATE` e `DELETE`;
- historico de versoes da tabela;
- maior confiabilidade em operacoes de escrita.

## Configuracao usada no projeto

No notebook de Delta, a `SparkSession` recebe a extensao oficial do Delta e o catalogo apropriado para o `spark_catalog`.

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

## Estrutura usada na demonstracao

O notebook cria uma tabela Delta no diretorio local `warehouse/delta/vendas_delta`. A tabela e inicializada com os dados da base de vendas, e depois recebe comandos de manutencao diretamente em SQL.

## Fluxo executado no notebook

1. leitura do arquivo CSV;
2. conversao dos tipos das colunas;
3. criacao da tabela Delta;
4. insercao de um novo registro;
5. atualizacao de um registro existente;
6. exclusao de um registro;
7. consulta ao historico da tabela.

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
- a ausencia do registro removido;
- o historico da tabela com `DESCRIBE HISTORY`.

## Por que isso e importante

No contexto do trabalho, essas evidencias demonstram que o Delta Lake nao funciona apenas como armazenamento de dados, mas como uma camada transacional capaz de registrar alteracoes e facilitar auditoria.

## Pontos fortes observados

| Aspecto | Evidencia no projeto |
| --- | --- |
| Escrita transacional | `INSERT`, `UPDATE` e `DELETE` executados com SQL |
| Historico | `DESCRIBE HISTORY` |
| Integracao com Spark | Configuracao direta na `SparkSession` |
| Facilidade de demonstracao | Fluxo curto e claro em notebook |

## Sintese

No trabalho, o Delta Lake se destacou como a opcao mais direta para demonstrar manutencao transacional de dados e historico de operacoes dentro do Apache Spark.
