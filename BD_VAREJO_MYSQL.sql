DROP TABLE IF EXISTS clientes_antigos;
DROP TABLE IF EXISTS prd_vestuarios;
DROP TABLE IF EXISTS logins;
DROP TABLE IF EXISTS prd_eletros;
DROP TABLE IF EXISTS prd_alimentos;
DROP TABLE IF EXISTS funcionarios_cargos;
DROP TABLE IF EXISTS cargos;
DROP TABLE IF EXISTS vendas;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS funcionarios;
DROP TABLE IF EXISTS lojas;
DROP TABLE IF EXISTS log;
DROP TABLE IF EXISTS compras;
DROP TABLE IF EXISTS fornecedores;
DROP TABLE IF EXISTS enderecos;
DROP TABLE IF EXISTS cidades;
DROP TABLE IF EXISTS uf;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS categorias;


CREATE TABLE uf
(
    sigla_uf    VARCHAR(2)   NOT NULL PRIMARY KEY,
    nome_estado VARCHAR(255) NOT NULL
);


CREATE TABLE cidades
(
    cod_cidade  INT AUTO_INCREMENT PRIMARY KEY,
    sigla_uf    VARCHAR(2)   NOT NULL,
    nome_cidade VARCHAR(255) NOT NULL
);


CREATE TABLE enderecos
(
    cod_endereco     INT AUTO_INCREMENT PRIMARY KEY,
    sigla_uf         VARCHAR(2)   NOT NULL,
    cod_cidade       INT          NOT NULL,
    nome_rua         VARCHAR(255) NOT NULL,
    numero_rua       VARCHAR(10)  NOT NULL,
    complemento      VARCHAR(255) NULL,
    ponto_referencia VARCHAR(255) NULL,
    bairro           VARCHAR(255) NOT NULL,
    CEP              VARCHAR(15)  NOT NULL
);


CREATE TABLE lojas
(
    cod_loja           INT AUTO_INCREMENT PRIMARY KEY,
    cod_endereco       INT         NULL,
    matriz             INT         NULL,
    cnpj_loja          VARCHAR(20) NOT NULL,
    inscricao_estadual VARCHAR(20) NULL
);


CREATE TABLE funcionarios_cargos
(
    matricula           INT         NOT NULL,
    cod_cargo           INT         NOT NULL,
    valor_cargo         FLOAT       NOT NULL,
    perc_comissao_cargo FLOAT       NOT NULL,
    data_promocao       VARCHAR(10) NOT NULL,
    PRIMARY KEY (matricula, cod_cargo)
);


CREATE TABLE funcionarios
(
    matricula        INT AUTO_INCREMENT PRIMARY KEY,
    cod_loja         INT          NOT NULL,
    cod_endereco     INT          NOT NULL,
    nome_completo    VARCHAR(255) NOT NULL,
    data_nascimento  VARCHAR(10)  NOT NULL,
    CPF              VARCHAR(17)  NOT NULL,
    RG               VARCHAR(15)  NOT NULL,
    status           VARCHAR(20)  NOT NULL,
    data_contratacao VARCHAR(10)  NOT NULL,
    data_demissao    VARCHAR(10)  NULL
);

CREATE TABLE cargos
(
    cod_cargo  INT AUTO_INCREMENT PRIMARY KEY,
    nome_cargo VARCHAR(255) NOT NULL
);


CREATE TABLE vendas
(
    cod_venda      INT AUTO_INCREMENT,
    cpf            BIGINT      NOT NULL,
    cod_produto    INT         NOT NULL,
    matricula      INT         NOT NULL,
    data           VARCHAR(10) NOT NULL,
    quantidade     INT         NOT NULL,
    valor_unitario FLOAT       NOT NULL,
    PRIMARY KEY (cod_venda, cpf, cod_produto, matricula)
);



CREATE TABLE clientes
(
    cpf              BIGINT       NOT NULL PRIMARY KEY,
    nome             VARCHAR(255) NOT NULL,
    fone_residencial VARCHAR(255) NOT NULL,
    fone_celular     VARCHAR(255) NULL
);


CREATE TABLE clientes_antigos
(
    cpf  BIGINT NOT NULL PRIMARY KEY,
    nome VARCHAR(255) DEFAULT NULL
);


CREATE TABLE logins
(
    logins        VARCHAR(255) NOT NULL PRIMARY KEY,
    cpf           BIGINT       NOT NULL,
    senha         VARCHAR(255) NOT NULL,
    data_cadastro VARCHAR(10)  NULL
);


CREATE TABLE compras
(
    cod_compra     INT AUTO_INCREMENT,
    cod_produto    INT         NOT NULL,
    cod_fornecedor INT         NOT NULL,
    data           VARCHAR(10) NULL,
    quantidade     INT         NULL,
    valor_unitario FLOAT       NULL,
    PRIMARY KEY (cod_compra, cod_produto, cod_fornecedor)
);


CREATE TABLE produtos
(
    cod_produto   INT          NOT NULL PRIMARY KEY,
    cod_categoria INT          NOT NULL,
    descricao     VARCHAR(255) NOT NULL
);


CREATE TABLE categorias
(
    cod_categoria INT AUTO_INCREMENT PRIMARY KEY,
    descricao     VARCHAR(255) NOT NULL
);


CREATE TABLE prd_alimentos
(
    cod_prd_alimentos INT AUTO_INCREMENT,
    cod_produto       INT          NOT NULL,
    detalhamento      VARCHAR(255) NOT NULL,
    unidade_medida    VARCHAR(255) NOT NULL,
    num_lote          VARCHAR(255) NULL,
    data_vencimento   VARCHAR(10)  NULL,
    valor_sugerido    FLOAT        NULL,
    PRIMARY KEY (cod_prd_alimentos, cod_produto)
);


CREATE TABLE prd_eletros
(
    cod_prd_eletro       INT AUTO_INCREMENT,
    cod_produto          INT          NOT NULL,
    detalhamento         VARCHAR(255) NOT NULL,
    tensao               VARCHAR(255) NULL,
    nivel_consumo_procel char(1)      NULL,
    valor_sugerido       FLOAT        NULL,
    PRIMARY KEY (cod_prd_eletro, cod_produto)
);


CREATE TABLE prd_vestuarios
(
    cod_prd_vestuario INT AUTO_INCREMENT,
    cod_produto       INT          NOT NULL,
    detalhamento      VARCHAR(255) NOT NULL,
    sexo              CHAR(1)      NOT NULL,
    tamanho           VARCHAR(255) NULL,
    numeracao         INT          NULL,
    valor_sugerido    FLOAT        NULL,
    PRIMARY KEY (cod_prd_vestuario, cod_produto)
);


CREATE TABLE fornecedores
(
    cod_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social   VARCHAR(255) NULL,
    nome_fantasia  VARCHAR(255) NULL,
    fone           VARCHAR(15)  NULL,
    cod_endereco   INT          NULL
);


CREATE TABLE log
(
    cod_log INT AUTO_INCREMENT PRIMARY KEY,
    objeto  VARCHAR(100) NOT NULL,
    dml     VARCHAR(25)  NOT NULL,
    data    VARCHAR(10)  NOT NULL
);


ALTER TABLE cidades
    ADD FOREIGN KEY (sigla_uf) REFERENCES uf (sigla_uf);

ALTER TABLE enderecos
    ADD FOREIGN KEY (cod_cidade) REFERENCES cidades (cod_cidade);

ALTER TABLE enderecos
    ADD FOREIGN KEY (sigla_uf) REFERENCES uf (sigla_uf);

ALTER TABLE lojas
    ADD FOREIGN KEY (cod_endereco) REFERENCES enderecos (cod_endereco);

ALTER TABLE funcionarios_cargos
    ADD FOREIGN KEY (matricula) REFERENCES funcionarios (matricula);

ALTER TABLE funcionarios_cargos
    ADD FOREIGN KEY (cod_cargo) REFERENCES cargos (cod_cargo);

ALTER TABLE funcionarios
    ADD FOREIGN KEY (cod_endereco) REFERENCES enderecos (cod_endereco);

ALTER TABLE funcionarios
    ADD FOREIGN KEY (cod_loja) REFERENCES lojas (cod_loja);

ALTER TABLE vendas
    ADD FOREIGN KEY (matricula) REFERENCES funcionarios (matricula);

ALTER TABLE vendas
    ADD FOREIGN KEY (cpf) REFERENCES clientes (cpf);

ALTER TABLE vendas
    ADD FOREIGN KEY (cod_produto) REFERENCES produtos (cod_produto);

ALTER TABLE logins
    ADD FOREIGN KEY (cpf) REFERENCES clientes (cpf);

ALTER TABLE compras
    ADD FOREIGN KEY (cod_produto) REFERENCES produtos (cod_produto);

ALTER TABLE compras
    ADD FOREIGN KEY (cod_fornecedor) REFERENCES fornecedores (cod_fornecedor);

ALTER TABLE produtos
    ADD FOREIGN KEY (cod_categoria) REFERENCES categorias (cod_categoria);

ALTER TABLE prd_alimentos
    ADD FOREIGN KEY (cod_produto) REFERENCES produtos (cod_produto);

ALTER TABLE prd_eletros
    ADD FOREIGN KEY (cod_produto) REFERENCES produtos (cod_produto);

ALTER TABLE prd_vestuarios
    ADD FOREIGN KEY (cod_produto) REFERENCES produtos (cod_produto);

ALTER TABLE fornecedores
    ADD FOREIGN KEY (cod_endereco) REFERENCES enderecos (cod_endereco);