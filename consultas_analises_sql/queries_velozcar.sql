CREATE SCHEMA velozcar;

USE velozcar;

/* modelo_logico_concessionaria: */

CREATE TABLE cliente (
    id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    email_cliente VARCHAR(255) NOT NULL,
    telefone_cliente CHAR(11) NOT NULL,
    data_cadastro DATETIME NOT NULL,
    sexo_cliente VARCHAR(5) NOT NULL, CHECK (sexo_cliente IN ('M', 'F', 'Outro')),
    status VARCHAR(10) NOT NULL, CHECK (status IN ('Ativo', 'Inativo')),
    cpf_cliente CHAR(11) NOT NULL,
    fk_endereco_id_endereco INT,
    UNIQUE (email_cliente, cpf_cliente)
);

CREATE TABLE funcionario (
    id_funcionario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_funcionario VARCHAR(255) NOT NULL,
    email_funcionario VARCHAR(255) NOT NULL,
    telefone_funcionario CHAR(11),
    cpf_funcionario CHAR(11),
    data_admissao DATE NOT NULL,
    sexo_funcionario VARCHAR(5) NOT NULL, CHECK (sexo_funcionario IN ('M', 'F', 'Outro')),
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    UNIQUE (email_funcionario, cpf_funcionario)
);

CREATE TABLE veiculo (
    id_veiculo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(30) NOT NULL,
    cor VARCHAR(20) NOT NULL,
    ano_fabricacao INT NOT NULL,
    valor_diaria DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL, CHECK (status IN ('Disponível', 'Alugado', 'Em manutenção'))
);

CREATE TABLE aluguel (
    data_fim DATETIME NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL, CHECK (status IN ('Reservado', 'Ativo', 'Concluído', 'Cancelado')),
    data_inicio DATETIME NOT NULL,
    id_aluguel INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_cliente_id_cliente INT,
    fk_veiculo_id_veiculo INT,
    fk_funcionario_id_funcionario INT
);

CREATE TABLE manutencao (
    id_manutencao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    prioridade VARCHAR(20) NOT NULL, CHECK (prioridade IN ('Baixa', 'Média', 'Alta')),
    descricao VARCHAR(255),
    custo DECIMAL(10,2) NOT NULL,
    data_manutencao DATETIME NOT NULL,
    tipo_servico VARCHAR(20) NOT NULL, CHECK (tipo_servico IN ('Preventiva', 'Corretiva', 'Urgente')),
    status VARCHAR(20) NOT NULL, CHECK (status IN ('Pendente', 'Em andamento', 'Concluída', 'Cancelada')),
    fk_veiculo_id_veiculo INT
);

CREATE TABLE pagamento (
    id_pagamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    comprovante VARCHAR(255),
    status VARCHAR(20) NOT NULL, CHECK (status IN ('Pendente', 'Concluído', 'Cancelado')),
    forma_pagamento VARCHAR(20) NOT NULL, CHECK (forma_pagamento IN ('Cartão', 'Pix', 'Boleto')),
    data_pagamento DATETIME,
    valor_pagamento DECIMAL(10,2) NOT NULL,
    data_vencimento DATE NOT NULL,
    fk_aluguel_id_aluguel INT
);

CREATE TABLE endereco (
    id_endereco INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(30) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    complemento VARCHAR(30),
    estado CHAR(2) NOT NULL,
    cep CHAR(8) NOT NULL
);

CREATE TABLE funcionario_manutencao (
    funcao VARCHAR(50) NOT NULL,
    horas_trabalhadas INT NOT NULL,
    fk_funcionario_id_funcionario INT,
    fk_manutencao_id_manutencao INT,
    PRIMARY KEY (fk_funcionario_id_funcionario, fk_manutencao_id_manutencao)
);
 
ALTER TABLE cliente ADD CONSTRAINT FK_cliente_2
    FOREIGN KEY (fk_endereco_id_endereco)
    REFERENCES endereco (id_endereco)
    ON DELETE CASCADE;
 
ALTER TABLE aluguel ADD CONSTRAINT FK_aluguel_2
    FOREIGN KEY (fk_cliente_id_cliente)
    REFERENCES cliente (id_cliente)
    ON DELETE CASCADE;
 
ALTER TABLE aluguel ADD CONSTRAINT FK_aluguel_3
    FOREIGN KEY (fk_veiculo_id_veiculo)
    REFERENCES veiculo (id_veiculo)
    ON DELETE CASCADE;
 
ALTER TABLE aluguel ADD CONSTRAINT FK_aluguel_4
    FOREIGN KEY (fk_funcionario_id_funcionario)
    REFERENCES funcionario (id_funcionario)
    ON DELETE CASCADE;
 
ALTER TABLE manutencao ADD CONSTRAINT FK_manutencao_2
    FOREIGN KEY (fk_veiculo_id_veiculo)
    REFERENCES veiculo (id_veiculo)
    ON DELETE CASCADE;
 
ALTER TABLE pagamento ADD CONSTRAINT FK_pagamento_2
    FOREIGN KEY (fk_aluguel_id_aluguel)
    REFERENCES aluguel (id_aluguel)
    ON DELETE CASCADE;
 
ALTER TABLE funcionario_manutencao ADD CONSTRAINT FK_funcionario_manutencao_2
    FOREIGN KEY (fk_funcionario_id_funcionario)
    REFERENCES funcionario (id_funcionario)
    ON DELETE RESTRICT;
 
ALTER TABLE funcionario_manutencao ADD CONSTRAINT FK_funcionario_manutencao_3
    FOREIGN KEY (fk_manutencao_id_manutencao)
    REFERENCES manutencao (id_manutencao)
    ON DELETE RESTRICT;
    
INSERT INTO endereco (logradouro, numero, bairro, cidade, complemento, estado, cep) VALUES
('Rua das Acácias', '120', 'Centro', 'João Pessoa', 'Apto 101', 'PB', '58010001'),
('Av. Epitácio Pessoa', '450', 'Tambaú', 'João Pessoa', NULL, 'PB', '58039000'),
('Rua Bancário Sérgio Guerra', '89', 'Bancários', 'João Pessoa', NULL, 'PB', '58051000'),
('Rua Severino Nicolau de Melo', '300', 'José Américo', 'João Pessoa', 'Casa', 'PB', '58074060'),
('Rua Comerciante Alfredo Ferreira', '55', 'Mangabeira', 'João Pessoa', NULL, 'PB', '58055020'),
('Rua Maria Rosa Padilha', '210', 'Bessa', 'João Pessoa', NULL, 'PB', '58035000'),
('Rua Pedro II', '780', 'Centro', 'Campina Grande', NULL, 'PB', '58400000'),
('Rua João Suassuna', '95', 'Liberdade', 'Campina Grande', NULL, 'PB', '58414000'),
('Av. Floriano Peixoto', '1020', 'Centro', 'Santa Rita', NULL, 'PB', '58300020'),
('Rua São Pedro', '45', 'Popular', 'Cabedelo', 'Bloco B', 'PB', '58100010');

INSERT INTO cliente
(nome_cliente, email_cliente, telefone_cliente, data_cadastro, sexo_cliente, status, cpf_cliente, fk_endereco_id_endereco)
VALUES
('João Silva', 'joao.silva@email.com', '83981112211', '2024-01-15', 'M', 'Ativo', '12345678901', 1),
('Maria Souza', 'maria.souza@email.com', '83982223322', '2024-02-10', 'F', 'Ativo', '12345678902', 2),
('Carlos Pereira', 'carlos.p@email.com', '83983334433', '2024-03-05', 'M', 'Inativo', '12345678903', 3),
('Ana Oliveira', 'ana.oliveira@email.com', '83984445544', '2024-04-20', 'F', 'Ativo', '12345678904', 4),
('Pedro Santos', 'pedro.santos@email.com', '83985556655', '2024-05-11', 'M', 'Ativo', '12345678905', 5),
('Juliana Lima', 'juliana.lima@email.com', '83986667766', '2024-06-08', 'F', 'Ativo', '12345678906', 6),
('Rafael Costa', 'rafael.costa@email.com', '83987778877', '2024-07-17', 'M', 'Inativo', '12345678907', 7),
('Fernanda Alves', 'fernanda.alves@email.com', '83988889988', '2024-08-02', 'F', 'Ativo', '12345678908', 8),
('Lucas Rocha', 'lucas.rocha@email.com', '83989990011', '2024-09-14', 'M', 'Ativo', '12345678909', 9),
('Patrícia Gomes', 'patricia.gomes@email.com', '83990001122', '2024-10-03', 'F', 'Ativo', '12345678910', 10);

INSERT INTO funcionario
(nome_funcionario, email_funcionario, telefone_funcionario, cpf_funcionario, data_admissao, sexo_funcionario, cargo, salario)
VALUES
('Marcos Andrade', 'marcos.andrade@velozcar.com', '83991112211', '98765432101', '2022-01-10', 'M', 'Atendente', 2200.00),
('Camila Nunes', 'camila.nunes@velozcar.com', '83992223322', '98765432102', '2022-03-15', 'F', 'Atendente', 2200.00),
('Roberto Lima', 'roberto.lima@velozcar.com', '83993334433', '98765432103', '2021-11-08', 'M', 'Gerente', 4500.00),
('Patrícia Moura', 'patricia.moura@velozcar.com', '83994445544', '98765432104', '2023-02-20', 'F', 'Mecânico', 3200.00),
('André Barbosa', 'andre.barbosa@velozcar.com', '83995556655', '98765432105', '2023-04-01', 'M', 'Mecânico', 3200.00),
('Larissa Freitas', 'larissa.freitas@velozcar.com', '83996667766', '98765432106', '2022-07-12', 'F', 'Atendente', 2300.00),
('Tiago Fernandes', 'tiago.fernandes@velozcar.com', '83997778877', '98765432107', '2024-01-05', 'M', 'Atendente', 2100.00),
('Helena Duarte', 'helena.duarte@velozcar.com', '83998889988', '98765432108', '2021-09-25', 'F', 'Gerente', 4700.00),
('Bruno Medeiros', 'bruno.medeiros@velozcar.com', '83999990011', '98765432109', '2023-06-18', 'M', 'Mecânico', 3300.00),
('Aline Castro', 'aline.castro@velozcar.com', '83990001122', '98765432110', '2024-02-14', 'F', 'Atendente', 2150.00);

INSERT INTO veiculo
(placa, modelo, cor, ano_fabricacao, valor_diaria, categoria, status)
VALUES
('ABC1234', 'Gol', 'Branco', 2020, 100.00, 'Hatch', 'Disponível'),
('DEF5678', 'Onix', 'Preto', 2021, 120.00, 'Hatch', 'Alugado'),
('GHI9012', 'HB20S', 'Prata', 2022, 135.00, 'Sedan', 'Disponível'),
('JKL3456', 'Corolla', 'Branco', 2023, 220.00, 'Sedan', 'Alugado'),
('MNO7890', 'Civic', 'Cinza', 2022, 210.00, 'Sedan', 'Em manutenção'),
('PQR1234', 'Uno', 'Vermelho', 2019, 85.00, 'Hatch', 'Disponível'),
('STU5678', 'Ka', 'Azul', 2020, 95.00, 'Hatch', 'Disponível'),
('VWX9012', 'Tracker', 'Branco', 2023, 260.00, 'SUV', 'Alugado'),
('YZA3456', 'Compass', 'Preto', 2022, 300.00, 'SUV', 'Disponível'),
('BCD7890', 'Renegade', 'Cinza', 2021, 230.00, 'SUV', 'Em manutenção');

INSERT INTO aluguel
(data_fim, valor_total, status, data_inicio, fk_cliente_id_cliente, fk_veiculo_id_veiculo, fk_funcionario_id_funcionario)
VALUES
('2025-01-20 10:00:00', 500.00, 'Concluído', '2025-01-15 10:00:00', 1, 1, 1),
('2025-02-18 09:30:00', 360.00, 'Concluído', '2025-02-15 09:30:00', 2, 2, 2),
('2025-03-12 14:00:00', 540.00, 'Concluído', '2025-03-08 14:00:00', 3, 3, 6),
('2025-04-10 08:00:00', 660.00, 'Concluído', '2025-04-07 08:00:00', 4, 4, 7),
('2025-05-14 16:00:00', 420.00, 'Cancelado', '2025-05-12 16:00:00', 5, 5, 1),
('2025-06-06 11:00:00', 255.00, 'Concluído', '2025-06-03 11:00:00', 6, 6, 2),
('2025-07-09 13:30:00', 380.00, 'Concluído', '2025-07-05 13:30:00', 7, 7, 10),
('2025-08-20 15:00:00', 1300.00, 'Ativo', '2025-08-15 15:00:00', 8, 8, 6),
('2025-09-05 09:00:00', 900.00, 'Concluído', '2025-09-02 09:00:00', 9, 9, 7),
('2025-10-18 17:00:00', 690.00, 'Reservado', '2025-10-15 17:00:00', 10, 10, 1);

INSERT INTO pagamento
(comprovante, status, forma_pagamento, data_pagamento, valor_pagamento, data_vencimento, fk_aluguel_id_aluguel)
VALUES
('comp001', 'Concluído', 'Pix', '2025-01-15 09:50:00', 500.00, '2025-01-20', 1),
('comp002', 'Concluído', 'Cartão', '2025-02-15 09:10:00', 360.00, '2025-02-18', 2),
('comp003', 'Concluído', 'Boleto', '2025-03-09 10:00:00', 540.00, '2025-03-12', 3),
('comp004', 'Concluído', 'Pix', '2025-04-07 08:10:00', 660.00, '2025-04-10', 4),
('comp005', 'Cancelado', 'Cartão', NULL, 420.00, '2025-05-14', 5),
('comp006', 'Concluído', 'Boleto', '2025-06-03 12:00:00', 255.00, '2025-06-06', 6),
('comp007', 'Concluído', 'Pix', '2025-07-05 14:00:00', 380.00, '2025-07-09', 7),
('comp008', 'Pendente', 'Cartão', NULL, 1300.00, '2025-08-20', 8),
('comp009', 'Concluído', 'Boleto', '2025-09-02 10:30:00', 900.00, '2025-09-05', 9),
('comp010', 'Pendente', 'Pix', NULL, 690.00, '2025-10-18', 10);

INSERT INTO manutencao
(prioridade, descricao, custo, data_manutencao, tipo_servico, status, fk_veiculo_id_veiculo)
VALUES
('Baixa', 'Troca de óleo e filtro', 150.00, '2025-01-22 08:00:00', 'Preventiva', 'Concluída', 1),
('Média', 'Revisão de freios', 280.00, '2025-02-25 09:30:00', 'Corretiva', 'Concluída', 2),
('Alta', 'Problema no motor', 1200.00, '2025-03-18 13:00:00', 'Urgente', 'Em andamento', 3),
('Baixa', 'Alinhamento e balanceamento', 120.00, '2025-04-11 10:00:00', 'Preventiva', 'Concluída', 4),
('Alta', 'Troca da suspensão', 850.00, '2025-05-20 14:30:00', 'Corretiva', 'Pendente', 5),
('Média', 'Pane elétrica', 600.00, '2025-06-08 15:00:00', 'Urgente', 'Em andamento', 6),
('Baixa', 'Troca de pneus', 400.00, '2025-07-10 11:20:00', 'Preventiva', 'Concluída', 7),
('Média', 'Troca de embreagem', 950.00, '2025-08-22 16:00:00', 'Corretiva', 'Em andamento', 8),
('Alta', 'Superaquecimento do motor', 1100.00, '2025-09-07 09:15:00', 'Urgente', 'Pendente', 9),
('Baixa', 'Revisão geral', 300.00, '2025-10-20 08:45:00', 'Preventiva', 'Concluída', 10);

INSERT INTO funcionario_manutencao
(funcao, horas_trabalhadas, fk_funcionario_id_funcionario, fk_manutencao_id_manutencao)
VALUES
('Mecânico responsável', 4, 4, 1),
('Mecânico responsável', 6, 5, 2),
('Mecânico responsável', 10, 9, 3),
('Auxiliar técnico', 3, 4, 4),
('Mecânico responsável', 8, 5, 5),
('Mecânico responsável', 7, 9, 6),
('Auxiliar técnico', 5, 4, 7),
('Mecânico responsável', 9, 5, 8),
('Mecânico responsável', 11, 9, 9),
('Auxiliar técnico', 4, 4, 10);

UPDATE veiculo
SET status = 'Em manutenção'
WHERE id_veiculo IN (
    SELECT fk_veiculo_id_veiculo
    FROM manutencao
    WHERE status = 'Pendente'
);

UPDATE pagamento
SET status = 'Concluído',
    data_pagamento = NOW()
WHERE id_pagamento = 8
  AND status = 'Pendente';

-- Tabela cliente

SELECT sexo_cliente, COUNT(*) AS quantidade_clientes
FROM cliente
GROUP BY sexo_cliente;

SELECT status, COUNT(*) AS total_por_status
FROM cliente
GROUP BY status;

-- Tabela funcionário

SELECT cargo, MAX(salario) AS maior_salario
FROM funcionario
GROUP BY cargo;

SELECT sexo_funcionario, COUNT(*) AS quantidade_funcionarios
FROM funcionario
GROUP BY sexo_funcionario;

-- Tabela veículo

SELECT categoria, COUNT(*) AS total_veiculos
FROM veiculo
GROUP BY categoria;

SELECT status, MIN(valor_diaria) AS menor_diaria
FROM veiculo
GROUP BY status;

-- Tabela aluguel

SELECT fk_funcionario_id_funcionario, COUNT(*) AS total_contratos
FROM aluguel
GROUP BY fk_funcionario_id_funcionario;

SELECT status, AVG(valor_total) AS ticket_medio
FROM aluguel
GROUP BY status;

-- Tabela manutencao

SELECT prioridade, COUNT(*) AS total_ordens
FROM manutencao
GROUP BY prioridade;

SELECT tipo_servico, AVG(custo) AS custo_medio
FROM manutencao
GROUP BY tipo_servico;

-- Tabela pagamento 

SELECT forma_pagamento, COUNT(*) AS quantidade_pagamentos
FROM pagamento
GROUP BY forma_pagamento;

SELECT status, SUM(valor_pagamento) AS montante
FROM pagamento
GROUP BY status;

-- Tabela endereco

SELECT cidade, COUNT(*) AS total_enderecos
FROM endereco
GROUP BY cidade;

SELECT estado, COUNT(*) AS total_por_uf
FROM endereco
GROUP BY estado;

-- Tabela funcionario_manutencao

SELECT fk_funcionario_id_funcionario, SUM(horas_trabalhadas) AS carga_total
FROM funcionario_manutencao
GROUP BY fk_funcionario_id_funcionario;

SELECT funcao, COUNT(*) AS quantidade_registros
FROM funcionario_manutencao
GROUP BY funcao;

-- INNER JOIN

SELECT t1.nome_cliente, t2.id_aluguel, t2.status, t2.valor_total
FROM cliente t1
INNER JOIN aluguel t2
    ON t1.id_cliente = t2.fk_cliente_id_cliente;
    
-- LEFT JOIN

SELECT t1.placa, t1.modelo, t2.tipo_servico, t2.status
FROM veiculo t1
LEFT JOIN manutencao t2
    ON t1.id_veiculo = t2.fk_veiculo_id_veiculo;

-- INNER JOIN

SELECT t3.nome_funcionario, t1.forma_pagamento, t1.valor_pagamento, t2.id_aluguel
FROM pagamento t1
INNER JOIN aluguel t2
    ON t1.fk_aluguel_id_aluguel = t2.id_aluguel
INNER JOIN funcionario t3
    ON t2.fk_funcionario_id_funcionario = t3.id_funcionario;




