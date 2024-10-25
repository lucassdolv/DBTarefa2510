CREATE DATABASE rosaplane;

USE rosaplane;

CREATE TABLE destinos(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nomeDestino VARCHAR(60),
    pais VARCHAR (30),
    descricao VARCHAR (100)
);
CREATE TABLE pacotes(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    idDestino INT,
    nomePacote VARCHAR (60),
    preco DECIMAL(10, 2),
    dataInicio DATE,
    dataTermino DATE,
    
    FOREIGN KEY (idDestino) REFERENCES destinos(id)
);
CREATE TABLE  clientes(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nomeCliente VARCHAR (60),
    email VARCHAR(60),
    telefone VARCHAR(30),
    endereco VARCHAR(100)
);
CREATE TABLE reservas(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    idCliente INT,
    idPacote INT,
    dataReserva DATE,
    numeroPessoas INT,
    statusReserva VARCHAR(30),
    
    FOREIGN KEY (idCliente) REFERENCES clientes(id),
    FOREIGN KEY (idPacote) REFERENCES pacotes(id)
);

INSERT INTO destinos (nomeDestino, pais, descricao)
VALUES
('Praia do Forte', 'Brasil', 'Lugar paradisíaco com belas praias e piscinas naturais.'),
('Machu Picchu', 'Peru', 'Cidade histórica com uma das sete maravilhas do mundo.'),
('Paris', 'França', 'Cidade Luz, famosa pela Torre Eiffel e cultura rica.');

INSERT INTO pacotes (idDestino, nomePacote, preco, dataInicio, dataTermino)
VALUES
(1, 'Férias na Praia do Forte', 2000.00, '2024-12-10', '2024-12-20'),
(2, 'Aventura em Machu Picchu', 3500.00, '2025-03-01', '2025-03-10'),
(3, 'Romance em Paris', 5000.00, '2024-11-01', '2024-11-15');

INSERT INTO clientes (nomeCliente, email, telefone, endereco)
VALUES
('Carlos Silva', 'carlos@gmail.com', '+55 11 99999-9999', 'Av. Paulista, São Paulo, SP, Brasil'),
('Ana Pereira', 'ana_p@gmail.com', '+55 21 98888-8888', 'Rua das Laranjeiras, Rio de Janeiro, RJ, Brasil'),
('Mariana Oliveira', 'mariana_o@hotmail.com', '+33 6 1234-5678', 'Rue de Rivoli, Paris, França');

INSERT INTO reservas (idCliente, idPacote, dataReserva, numeroPessoas, statusReserva)
VALUES
(1, 1, '2024-11-01', 2, 'confirmada'),
(2, 2, '2025-01-15', 1, 'pendente'),
(3, 3, '2024-10-25', 2, 'cancelada');

CREATE VIEW view_destinos_pacotes AS
SELECT des.nomeDestino, des.pais, pac.nomePacote, pac.preco, pac.dataInicio, pac.dataTermino
FROM destinos AS des INNER JOIN pacotes AS pac ON des.id = pac.idDestino;

SELECT * FROM view_destinos_pacotes;
    
SELECT cli.nomeCliente, cli.email, res.dataReserva, pac.nomePacote
FROM reservas AS res
INNER JOIN clientes AS cli ON res.idCliente = cli.id
INNER JOIN pacotes AS pac ON res.idPacote = pac.id WHERE res.statusReserva = 'confirmada';

CREATE VIEW view_clientes_pendentes AS
SELECT cli.nomeCliente, cli.email 
FROM reservas AS res INNER JOIN clientes AS cli ON res.idCliente = cli.id WHERE res.statusReserva = 'pendente';

SELECT * FROM view_clientes_pendentes;


