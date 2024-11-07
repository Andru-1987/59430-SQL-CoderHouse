DROP DATABASE IF EXISTS integridad;
CREATE DATABASE integridad ;
USE integridad;

CREATE TABLE pais(
    id_pais INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE ciudad(
    id_ciudad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    id_pais INT
);

CREATE TABLE ciudadano(
    id_ciudadano INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    email    VARCHAR(100) UNIQUE,
    id_ciudad INT  ,
    CONSTRAINT solo_email CHECK (email LIKE '%@email%'),
    CONSTRAINT solo_upper CHECK (nombre REGEXP '^[A-Z \d\W]+$')
);

CREATE TABLE ciudadano_doc(
	id_doc INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    num_doc VARCHAR(25),
    id_ciudadano INT ,
    FOREIGN KEY (id_ciudadano) REFERENCES ciudadano(id_ciudadano)
		ON DELETE CASCADE
        ON UPDATE SET NULL
);

ALTER TABLE
    ciudad
    ADD CONSTRAINT fk_ciudad_pais
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
    ON UPDATE 
		-- SET NULL
        CASCADE
        
	ON DELETE
		CASCADE
    ;

ALTER TABLE
    ciudadano
    ADD CONSTRAINT fk_ciudadano_pais
    FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
    ON DELETE 
		-- SET NULL
        CASCADE
    ;



-- Insertar países
INSERT INTO pais (nombre) VALUES 
('España'),
('Francia'),
('Italia'),
('Alemania'),
('Portugal');

-- Insertar ciudades (2 ciudades por país)
INSERT INTO ciudad (nombre, id_pais) VALUES 
-- España
('Madrid', 1),
('Barcelona', 1),
-- Francia
('París', 2),
('Lyon', 2),
-- Italia
('Roma', 3),
('Milán', 3),
-- Alemania
('Berlín', 4),
('Múnich', 4),
-- Portugal
('Lisboa', 5),
('Oporto', 5);

-- Insertar ciudadanos (10 por país, distribuidos en sus ciudades)
INSERT INTO ciudadano (nombre, email, id_ciudad) VALUES 
-- España - Madrid
-- ('Ana García', 'ana.garcia@email.com', 1),
-- ('Carlos Martínez', 'carlos.martinez@email.com', 1),
-- ('Elena Rodríguez', 'elena.rodriguez@email.com', 1),
-- ('David López', 'david.lopez@email.com', 1),
-- ('María Sánchez', 'maria.sanchez@email.com', 1),
-- España - Barcelona
('Pablo Torres', 'pablo.torres@email.com', 2),
('Laura Navarro', 'laura.navarro@email.com', 2),
('Jorge Ruiz', 'jorge.ruiz@email.com', 2),
('Carmen Molina', 'carmen.molina@email.com', 2),
('Roberto Jiménez', 'roberto.jimenez@email.com', 2),

-- Francia - París
('Sophie Martin', 'sophie.martin@email.com', 3),
('Pierre Dubois', 'pierre.dubois@email.com', 3),
('Marie Laurent', 'marie.laurent@email.com', 3),
('Jean Bernard', 'jean.bernard@email.com', 3),
('Claire Dupont', 'claire.dupont@email.com', 3),
-- Francia - Lyon
('Lucas Petit', 'lucas.petit@email.com', 4),
('Emma Rousseau', 'emma.rousseau@email.com', 4),
('Thomas Moreau', 'thomas.moreau@email.com', 4),
('Julie Leroy', 'julie.leroy@email.com', 4),
('Antoine Girard', 'antoine.girard@email.com', 4),

-- Italia - Roma
('Marco Rossi', 'marco.rossi@email.com', 5),
('Giulia Conti', 'giulia.conti@email.com', 5),
('Alessandro Ferrari', 'alessandro.ferrari@email.com', 5),
('Sofia Romano', 'sofia.romano@email.com', 5),
('Lorenzo Marino', 'lorenzo.marino@email.com', 5),
-- Italia - Milán
('Valentina Greco', 'valentina.greco@email.com', 6),
('Francesco Russo', 'francesco.russo@email.com', 6),
('Chiara Costa', 'chiara.costa@email.com', 6),
('Andrea Ricci', 'andrea.ricci@email.com', 6),
('Isabella Santos', 'isabella.santos@email.com', 6),

-- Alemania - Berlín
('Hans Schmidt', 'hans.schmidt@email.com', 7),
('Anna Weber', 'anna.weber@email.com', 7),
('Michael Wagner', 'michael.wagner@email.com', 7),
('Julia Fischer', 'julia.fischer@email.com', 7),
('Thomas Becker', 'thomas.becker@email.com', 7),
-- Alemania - Múnich
('Lisa Müller', 'lisa.mueller@email.com', 8),
('Klaus Hoffmann', 'klaus.hoffmann@email.com', 8),
('Sarah Koch', 'sarah.koch@email.com', 8),
('Martin Wolf', 'martin.wolf@email.com', 8),
('Eva Schulz', 'eva.schulz@email.com', 8),

-- Portugal - Lisboa
('João Silva', 'joao.silva@email.com', 9),
('Maria Santos', 'maria.santos@email.com', 9),
('António Ferreira', 'antonio.ferreira@email.com', 9),
('Ana Oliveira', 'ana.oliveira@email.com', 9),
('Manuel Costa', 'manuel.costa@email.com', 9),
-- Portugal - Oporto
('Sofia Pereira', 'sofia.pereira@email.com', 10),
('Pedro Carvalho', 'pedro.carvalho@email.com', 10),
('Beatriz Rodrigues', 'beatriz.rodrigues@email.com', 10),
('Ricardo Almeida', 'ricardo.almeida@email.com', 10),
('Catarina Sousa', 'catarina.sousa@email.com', 10);

SELECT *
FROM integridad.ciudadano;



UPDATE integridad.ciudadano
	SET email = REPLACE(email, 'ana.garcia@mail.com','carlos.martinez@email.com')
    WHERE id_ciudadano = 1;


SELECT
	*
FROM  information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'ciudadano';

SELECT * 
FROM information_schema.table_constraints
WHERE TABLE_NAME = 'ciudadano';


SELECT * FROM integridad.pais;
SELECT * FROM integridad.ciudad;
SELECT * FROM integridad.ciudadano;

UPDATE integridad.pais
	SET nombre = 'Pirulo'
    WHERE id_pais = 4;

UPDATE integridad.pais
	SET id_pais = 40
    WHERE id_pais = 4;
    
UPDATE integridad.ciudad
	SET id_pais = 40
    WHERE id_ciudad = 8;   
    
SET SQL_SAFE_UPDATES = FALSE;

DELETE FROM integridad.pais
;

TRUNCATE TABLE integridad.pais;


-- triggers
