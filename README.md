# E-commerce Database Project

Este projeto é um exemplo de um banco de dados para um sistema de e-commerce. Ele foi desenvolvido como parte de um exercício para demonstrar o design e a estrutura de um banco de dados relacional.

## Estrutura do Banco de Dados

O banco de dados consiste em várias tabelas que representam diferentes entidades e suas relações. Aqui está uma visão geral das tabelas utilizadas:

- **individual_customer**: Armazena informações sobre clientes individuais, como ID, nome, sobrenome e endereço.
- **company_customer**: Armazena informações sobre clientes corporativos, como ID, nome da empresa e endereço.
- **supplier**: Armazena informações sobre fornecedores, como ID e nome corporativo.
- **product**: Armazena informações sobre produtos, como ID, descrição e categoria.
- **order**: Armazena informações sobre os pedidos, como ID, data e status.
- **product_order**: Armazena a relação entre os pedidos e os produtos, contendo as quantidades de cada produto em um pedido.
- **product_supplier**: Armazena a relação entre os produtos e os fornecedores, contendo as informações sobre a quantidade fornecida por cada fornecedor.

## Consultas e Operações

O projeto inclui consultas e operações de exemplo que podem ser executadas no banco de dados. Aqui estão alguns exemplos:

- **Recuperações**: Consultas utilizando o comando SELECT e a cláusula WHERE para recuperar informações específicas dos clientes, produtos e pedidos.
- **Atributos Derivados**: Expressões que criam atributos derivados com base nos dados existentes, como o cálculo do total de uma compra ou a contagem de produtos em estoque.
- **Ordenação**: Expressões que utilizam o comando ORDER BY para ordenar os resultados por determinado critério, como o nome do cliente ou a data do pedido.
- **Junções**: Expressões que realizam junções entre as tabelas para fornecer uma perspectiva mais complexa dos dados, como a combinação de informações sobre pedidos, produtos e clientes.

## Como Usar

1. Certifique-se de ter um sistema de gerenciamento de banco de dados relacional instalado (por exemplo, MySQL, PostgreSQL).
2. Importe o arquivo SQL do projeto para criar o banco de dados e as tabelas.
3. Execute as consultas e operações de exemplo para explorar os dados e obter insights.