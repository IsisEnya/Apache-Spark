# Contextualizacao do trabalho

Este projeto foi desenvolvido para demonstrar o uso do `Apache Spark` com duas tecnologias de tabelas analiticas: `Delta Lake` e `Apache Iceberg`. A ideia central foi montar um ambiente simples, reproduzivel e facil de apresentar em laboratorio.

## Objetivos

- criar um ambiente unico com `PySpark` e `JupyterLab`;
- explicar o papel do `Apache Spark` no processamento de dados;
- demonstrar operacoes em tabelas `Delta Lake`;
- demonstrar operacoes em tabelas `Apache Iceberg`;
- organizar a entrega com `README` e `MKDocs`.

## Cenario de negocio

O dominio escolhido foi o de uma loja varejista. A base possui informacoes de clientes, produtos e vendas. A partir de um arquivo CSV unico, o projeto deriva as entidades do modelo relacional e usa a tabela de vendas para demonstrar operacoes de escrita e manutencao de dados.

## Fonte de dados

A fonte foi criada especificamente para fins didaticos e esta no arquivo `data/vendas.csv`. Ela contem:

- identificadores de venda, cliente e produto;
- cidade do cliente;
- data da venda;
- quantidade;
- preco unitario;
- status de pagamento.

## Modelo ER

![Modelo ER](assets/modelo-er.svg)

## Entidades derivadas

- `clientes`: dados cadastrais dos compradores;
- `produtos`: catalogo de itens vendidos;
- `vendas`: fato transacional que relaciona cliente e produto.

## Notebooks do projeto

- `01_contexto_modelagem.ipynb`: apresenta a fonte, a modelagem e o DDL.
- `02_delta_lake.ipynb`: implementa o fluxo em Delta Lake.
- `03_apache_iceberg.ipynb`: implementa o fluxo em Apache Iceberg.

## Resultado esperado

Ao final da execucao, o projeto evidencia que `Delta Lake` e `Apache Iceberg` resolvem problemas semelhantes dentro do ecossistema Spark, mas com abordagens diferentes para metadados, catalogacao, compatibilidade e evolucao de tabelas.
