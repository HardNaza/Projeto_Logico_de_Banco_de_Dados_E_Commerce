-- CRIAÇÃO DO BANCO DE DADOS

CREATE SCHEMA IF NOT EXISTS e_commerce;
USE e_commerce ;

-- CRIAÇÃO DA TABELA ADDRESS

CREATE TABLE IF NOT EXISTS e_commerce.address (
  idaddress INT NOT NULL AUTO_INCREMENT,
  road VARCHAR(45) NOT NULL,
  cep VARCHAR(45) NOT NULL,
  neighborhood VARCHAR(45) NOT NULL,
  number VARCHAR(45) NOT NULL,
  city VARCHAR(45) NOT NULL,
  state VARCHAR(45) NOT NULL,
  PRIMARY KEY (idaddress)
);

-- CRIAÇÃO DA TABELA INDIVIDUAL_CUSTOMER

CREATE TABLE IF NOT EXISTS e_commerce.individual_customer (
  idindividual_customer INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(10) NOT NULL,
  middle_name VARCHAR(3) NULL,
  last_name VARCHAR(20) NOT NULL COMMENT 'Adicionar constraint de unicidade para (nome completo)\nunique ( Nome, M, Sobrenome )',
  CPF CHAR(11) NOT NULL,
  date_of_birth DATE NOT NULL,
  phone VARCHAR(15) NOT NULL,
  address_idaddress INT NOT NULL,
  PRIMARY KEY (idindividual_customer, address_idaddress),
  UNIQUE INDEX Identificação_UNIQUE (CPF ASC) VISIBLE,
  INDEX fk_individual_customer_address1_idx (address_idaddress ASC) VISIBLE,
  CONSTRAINT fk_individual_customer_address1
    FOREIGN KEY (address_idaddress)
    REFERENCES e_commerce.address (idaddress)
);

-- CRIAÇÃO DA TABELA CREDIT_DEBIT_PAYMENT

CREATE TABLE IF NOT EXISTS e_commerce.credit_debit_payment (
  idcredit_debit_payment INT NOT NULL AUTO_INCREMENT,
  cardholder_name INT NOT NULL,
  card_number INT NOT NULL,
  expiration_date DATE NOT NULL,
  security_code INT NOT NULL,
  PRIMARY KEY (idcredit_debit_payment),
  UNIQUE INDEX card_number_UNIQUE (card_number ASC) VISIBLE
);

-- CRIAÇÃO DA TABELA PAYMENT_MONEY

CREATE TABLE IF NOT EXISTS e_commerce.payment_money (
  idpayment_money INT NOT NULL AUTO_INCREMENT,
  amount_received VARCHAR(45) NOT NULL,
  change_value VARCHAR(45) NOT NULL,
  PRIMARY KEY (idpayment_money)
);

-- CRIAÇÃO DA TABELA DELIVERY

CREATE TABLE IF NOT EXISTS e_commerce.delivery (
  iddelivery INT NOT NULL AUTO_INCREMENT,
  delivery_code VARCHAR(45) NOT NULL,
  status ENUM('Em Processamento', 'Recebido', 'Em entrega') NOT NULL DEFAULT 'Em Processamento',
  PRIMARY KEY (iddelivery),
  UNIQUE INDEX delivery_code_UNIQUE (delivery_code ASC) VISIBLE
);

-- CRIAÇÃO DA TABELA DEPARTMENT

CREATE TABLE IF NOT EXISTS e_commerce.Department (
  idDepartment INT NOT NULL,
  Department_name VARCHAR(30) NOT NULL,
  Description VARCHAR(50) NULL,
  number_of_employees INT NOT NULL,
  PRIMARY KEY (idDepartment)
);

-- CRIAÇÃO DA TABELA SELLER

CREATE TABLE IF NOT EXISTS e_commerce.seller (
  idseller INT NOT NULL AUTO_INCREMENT,
  seller_name VARCHAR(45) NOT NULL,
  cpf CHAR(11) NOT NULL,
  registration INT NOT NULL,
  hiring_date DATE NOT NULL,
  function VARCHAR(25) NOT NULL,
  salary FLOAT NOT NULL,
  Department_idDepartment INT NOT NULL,
  PRIMARY KEY (idseller, Department_idDepartment),
  UNIQUE INDEX cpf_UNIQUE (cpf ASC) VISIBLE,
  UNIQUE INDEX registration_UNIQUE (registration ASC) VISIBLE,
  INDEX fk_seller_Department1_idx (Department_idDepartment ASC) VISIBLE,
  CONSTRAINT fk_seller_Department1 FOREIGN KEY (Department_idDepartment) REFERENCES e_commerce.Department (idDepartment)
);

-- CRIAÇÃO DA TABELA ORDER

CREATE TABLE IF NOT EXISTS e_commerce.order (
  idorder INT NOT NULL AUTO_INCREMENT,
  status_order ENUM('Recebido', 'Em andamento', 'Em processamento') NOT NULL DEFAULT 'Em processamento',
  description VARCHAR(45) NULL,
  freight FLOAT NOT NULL,
  quantity_of_orders INT NOT NULL,
  credit_debit_payment_idcredit_debit_payment INT NOT NULL,
  payment_money_idpayment_money INT NOT NULL,
  delivery_iddelivery INT NOT NULL,
  seller_idseller INT NOT NULL,
  PRIMARY KEY (idorder, credit_debit_payment_idcredit_debit_payment, payment_money_idpayment_money, delivery_iddelivery, seller_idseller),
  INDEX fk_order_credit_debit_payment1_idx (credit_debit_payment_idcredit_debit_payment ASC) VISIBLE,
  INDEX fk_order_payment_money1_idx (payment_money_idpayment_money ASC) VISIBLE,
  INDEX fk_order_delivery1_idx (delivery_iddelivery ASC) VISIBLE,
  INDEX fk_order_seller1_idx (seller_idseller ASC) VISIBLE,
  CONSTRAINT fk_order_credit_debit_payment1 FOREIGN KEY (credit_debit_payment_idcredit_debit_payment) REFERENCES e_commerce.credit_debit_payment (idcredit_debit_payment),
  CONSTRAINT fk_order_payment_money1 FOREIGN KEY (payment_money_idpayment_money) REFERENCES e_commerce.payment_money (idpayment_money),
  CONSTRAINT fk_order_delivery1 FOREIGN KEY (delivery_iddelivery) REFERENCES e_commerce.delivery (iddelivery),
  CONSTRAINT fk_order_seller1 FOREIGN KEY (seller_idseller) REFERENCES e_commerce.seller (idseller)
);

-- CRIAÇÃO DA TABELA PRODUCT

CREATE TABLE IF NOT EXISTS e_commerce.product (
  idproduct INT NOT NULL AUTO_INCREMENT,
  category VARCHAR(45) NOT NULL,
  description VARCHAR(45) NOT NULL,
  price VARCHAR(45) NOT NULL,
  PRIMARY KEY (idproduct)
);

-- CRIAÇÃO DA TABELA SUPPLIER

CREATE TABLE IF NOT EXISTS e_commerce.supplier (
  idsupplier INT NOT NULL,
  corporate_name VARCHAR(45) NULL,
  CNPJ CHAR(15) NOT NULL,
  phone VARCHAR(45) NULL,
  address_idaddress INT NOT NULL,
  PRIMARY KEY (idsupplier, address_idaddress),
  UNIQUE INDEX CNPJ_UNIQUE (CNPJ ASC) VISIBLE,
  INDEX fk_supplier_address1_idx (address_idaddress ASC) VISIBLE,
  CONSTRAINT fk_supplier_address1 FOREIGN KEY (address_idaddress) REFERENCES e_commerce.address (idaddress)
);

-- CRIAÇÃO DA TABELA PRODUCT_SUPPLIER

CREATE TABLE IF NOT EXISTS e_commerce.product_supplier (
  Fornecedor_idFornecedor INT NOT NULL,
  amount INT NULL,
  product_idproduct INT NOT NULL,
  PRIMARY KEY (Fornecedor_idFornecedor, product_idproduct),
  INDEX fk_Fornecedor_has_Produto_Fornecedor_idx (Fornecedor_idFornecedor ASC) VISIBLE,
  INDEX fk_product_supplier_product1_idx (product_idproduct ASC) VISIBLE,
  CONSTRAINT fk_Fornecedor_has_Produto_Fornecedor FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES e_commerce.supplier (idsupplier),
  CONSTRAINT fk_product_supplier_product1 FOREIGN KEY (product_idproduct) REFERENCES e_commerce.product (idproduct)
);

-- CRIAÇÃO DA TABELA DEPOSIT

CREATE TABLE IF NOT EXISTS e_commerce.deposit (
  iddeposit INT NOT NULL,
  amount INT NOT NULL,
  address_idaddress INT NOT NULL,
  PRIMARY KEY (iddeposit, address_idaddress),
  INDEX fk_deposit_address1_idx (address_idaddress ASC) VISIBLE,
  CONSTRAINT fk_deposit_address1 FOREIGN KEY (address_idaddress) REFERENCES e_commerce.address (idaddress)
);

-- CRIAÇÃO DA TABELA PRODUCT_DEPOSIT

CREATE TABLE IF NOT EXISTS e_commerce.product_deposit (
  location INT NULL,
  product_idproduct INT NOT NULL,
  deposit_iddeposit INT NOT NULL,
  PRIMARY KEY (product_idproduct, deposit_iddeposit),
  INDEX fk_product_deposit_product1_idx (product_idproduct ASC) VISIBLE,
  INDEX fk_product_deposit_deposit1_idx (deposit_iddeposit ASC) VISIBLE,
  CONSTRAINT fk_product_deposit_product1 FOREIGN KEY (product_idproduct) REFERENCES e_commerce.product (idproduct),
  CONSTRAINT fk_product_deposit_deposit1 FOREIGN KEY (deposit_iddeposit) REFERENCES e_commerce.deposit (iddeposit)
);

-- CRIAÇÃO DA TABELA PRODUCT_ORDER

CREATE TABLE IF NOT EXISTS e_commerce.product_order (
  order_idorder INT NOT NULL,
  product_idproduct INT NOT NULL,
  amount VARCHAR(45) NOT NULL,
  status ENUM('disponível', 'sem estoque') NOT NULL DEFAULT 'diponvível',
  PRIMARY KEY (order_idorder, product_idproduct),
  INDEX fk_product_order_order1_idx (order_idorder ASC) VISIBLE,
  INDEX fk_product_order_product1_idx (product_idproduct ASC) VISIBLE,
  CONSTRAINT fk_product_order_order1 FOREIGN KEY (order_idorder) REFERENCES e_commerce.order (idorder),
  CONSTRAINT fk_product_order_product1 FOREIGN KEY (product_idproduct) REFERENCES e_commerce.product (idproduct)
);

-- CRIAÇÃO DA TABELA THIRD_PARTY_SELLER

CREATE TABLE IF NOT EXISTS e_commerce.third_party_seller (
  idthird_party_seller INT NOT NULL AUTO_INCREMENT,
  corporate_name VARCHAR(45) NOT NULL COMMENT 'constrain',
  fantasy_name VARCHAR(45) NULL,
  CNPJ CHAR(15) NULL,
  CPF CHAR(11) NULL,
  address_idaddress INT NOT NULL,
  PRIMARY KEY (idthird_party_seller, address_idaddress),
  UNIQUE INDEX Razão Social_UNIQUE (corporate_name ASC) VISIBLE,
  UNIQUE INDEX CNPJ_UNIQUE (CNPJ ASC) VISIBLE,
  UNIQUE INDEX CPF_UNIQUE (CPF ASC) VISIBLE,
  INDEX fk_third_party_seller_address1_idx (address_idaddress ASC) VISIBLE,
  CONSTRAINT fk_third_party_seller_address1 FOREIGN KEY (address_idaddress) REFERENCES e_commerce.address (idaddress)
);

-- CRIAÇÃO DA TABELA PRODUCT_SELLER

CREATE TABLE IF NOT EXISTS e_commerce.product_seller (
  amount INT NULL,
  product_idproduct INT NOT NULL,
  third_party_seller_idthird_party_seller INT NOT NULL,
  PRIMARY KEY (product_idproduct, third_party_seller_idthird_party_seller),
  INDEX fk_product_seller_product1_idx (product_idproduct ASC) VISIBLE,
  INDEX fk_product_seller_third_party_seller1_idx (third_party_seller_idthird_party_seller ASC) VISIBLE,
  CONSTRAINT fk_product_seller_product1 FOREIGN KEY (product_idproduct) REFERENCES e_commerce.product (idproduct),
  CONSTRAINT fk_product_seller_third_party_seller1 FOREIGN KEY (third_party_seller_idthird_party_seller) REFERENCES e_commerce.third_party_seller (idthird_party_seller)
);

-- CRIAÇÃO DA TABELA CUSTOMER_LEGAL_PERSON

CREATE TABLE IF NOT EXISTS e_commerce.customer_legal_person (
  idcustomer_legal_person INT NOT NULL AUTO_INCREMENT,
  corporate_name VARCHAR(35) NOT NULL,
  cnpj CHAR(14) NOT NULL,
  state_registration CHAR(15) NOT NULL,
  phone CHAR(15) NOT NULL,
  field_of_activity VARCHAR(35) NULL,
  foundation_date DATE NOT NULL,
  address_idaddress INT NOT NULL,
  PRIMARY KEY (idcustomer_legal_person, address_idaddress),
  UNIQUE INDEX cnpj_UNIQUE (cnpj ASC) VISIBLE,
  UNIQUE INDEX state_registration_UNIQUE (state_registration ASC) VISIBLE,
  INDEX fk_customer_legal_person_address1_idx (address_idaddress ASC) VISIBLE,
  CONSTRAINT fk_customer_legal_person_address1 FOREIGN KEY (address_idaddress) REFERENCES e_commerce.address (idaddress)
);

##############################################
###### CRIAÇÃO DAS QUERYS PARA CONSULTAS #####
##############################################

--------------------------------------------
-- RECUPERAÇÕES SIMPLES COM SELECT STATEMENT
--------------------------------------------
1 - Recuperação de todos os clientes individuais:
SELECT * FROM e_commerce.individual_customer;

2 - Recuperação de todos os produtos disponíveis:
SELECT * FROM e_commerce.product;

3 - Recuperação de todos os vendedores:
SELECT * FROM e_commerce.seller;

------------------------------
-- FILTROS COM WHERE STATEMENT
------------------------------
1 - Recuperação de todos os clientes individuais que nasceram antes de uma determinada data:
SELECT * FROM e_commerce.individual_customer WHERE date_of_birth < '2000-01-01';

2 - Recuperação de todos os produtos com preço acima de um determinado valor:
SELECT * FROM e_commerce.product WHERE price > '50.00';

3 - Recuperação de todos os pedidos com status "Recebido":
SELECT * FROM e_commerce.order WHERE status_order = 'Recebido';

-------------------------------------------------
-- CRIE EXPRESSÕES PARA GERAR ATRIBUTOS DERIVADOS
-------------------------------------------------
1 - Criação de um atributo derivado que conta o número total de clientes individuais:
SELECT COUNT(*) AS total_individual_customers FROM e_commerce.individual_customer;

2 - Criação de um atributo derivado que calcula a média de salários dos vendedores:
SELECT AVG(salary) AS average_salary FROM e_commerce.seller;

3 - Criação de um atributo derivado que calcula o valor total recebido em pagamentos em dinheiro:
SELECT SUM(amount_received) AS total_cash_payments FROM e_commerce.payment_money;

-------------------------------------------
-- DEFINA ORDENAÇÕES DOS DADOS COM ORDER BY
-------------------------------------------
1 - Ordenação dos clientes individuais por ordem alfabética do nome completo:
SELECT * FROM e_commerce.individual_customer ORDER BY CONCAT(first_name, ' ', middle_name, ' ', last_name) ASC;

2 - Ordenação dos produtos por preço em ordem decrescente:
SELECT * FROM e_commerce.product ORDER BY price DESC;

3 - Ordenação dos pedidos por status e data de recebimento:
SELECT * FROM e_commerce.order ORDER BY status ASC, received_date DESC;

-----------------------------------------------------
-- CONDIÇÕES DE FILTROS AOS GRUPOS – HAVING STATEMENT
-----------------------------------------------------
1 - Filtro de clientes individuais com mais de 3 pedidos:
SELECT ic.idindividual_customer, COUNT(o.idorder) AS num_orders
FROM e_commerce.individual_customer ic
JOIN e_commerce.order o ON ic.idindividual_customer = o.customer_id
GROUP BY ic.idindividual_customer
HAVING COUNT(o.idorder) > 3;

2 - Filtro de produtos com quantidade em estoque inferior a 10:
SELECT p.idproduct, SUM(pd.amount) AS total_amount
FROM e_commerce.product p
JOIN e_commerce.product_deposit pd ON p.idproduct = pd.product_idproduct
GROUP BY p.idproduct
HAVING SUM(pd.amount) < 10;

3 - Filtro de fornecedores com mais de 2 produtos disponíveis:
SELECT s.idsupplier, COUNT(ps.product_idproduct) AS num_products
FROM e_commerce.supplier s
JOIN e_commerce.product_supplier ps ON s.idsupplier = ps.Fornecedor_idFornecedor
JOIN e_commerce.product p ON ps.product_idproduct = p.idproduct
WHERE ps.status = 'disponível'
GROUP BY s.idsupplier
HAVING COUNT(ps.product_idproduct) > 2;

-----------------------------------------------------------------------------------
-- CRIE JUNÇÕES ENTRE TABELAS PARA FORNECER UMA PERSPECTIVA MAIS COMPLEXA DOS DADOS
-----------------------------------------------------------------------------------
1 - Junção entre as tabelas "order" e "individual_customer" para obter informações sobre os pedidos e os clientes individuais:
SELECT o.idorder, ic.first_name, ic.last_name, o.status_order
FROM e_commerce.order o
JOIN e_commerce.individual_customer ic ON o.customer_id = ic.idindividual_customer;

2 - Junção entre as tabelas "product" e "product_supplier" para obter informações sobre os produtos e os fornecedores:
SELECT p.idproduct, p.category, ps.amount, s.corporate_name
FROM e_commerce.product p
JOIN e_commerce.product_supplier ps ON p.idproduct = ps.product_idproduct
JOIN e_commerce.supplier s ON ps.Fornecedor_idFornecedor = s.idsupplier;

3 - Junção entre as tabelas "order", "product_order" e "product" para obter informações sobre os pedidos, os produtos e as quantidades:
SELECT o.idorder, p.description, po.amount
FROM e_commerce.order o
JOIN e_commerce.product_order po ON o.idorder = po.order_idorder
JOIN e_commerce.product p ON po.product_idproduct = p.idproduct;