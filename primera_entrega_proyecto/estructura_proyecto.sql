DROP DATABASE IF EXISTS donaton;
CREATE DATABASE donaton; 
USE donaton;

CREATE TABLE    donador(
    id_donador INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(200) UNIQUE ,
    status_donador ENUM("ANONIMO","PUBLICA")
);

CREATE TABLE    categoria_donacion(
    id_categoria_donacion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(200),
    tipo VARCHAR(200)
);

CREATE TABLE    centro_recepcion(
    id_centro_recepcion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ubicacion VARCHAR(200) UNIQUE NOT NULL,
    encargado VARCHAR(200) NOT NULL
);

CREATE TABLE    voluntario(
    id_voluntario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    fecha_nacimiento DATE
);

CREATE TABLE    categoria_voluntario(
    id_categoria_voluntario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descripcion_tareas VARCHAR(200)
);



CREATE TABLE    beneficiario(
    id_beneficiario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(200),
    nombre_encargado VARCHAR(200),
    fecha_creacion DATE
);

-- TABLAS CON FK

CREATE TABLE    donacion(
    id_donacion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_donador INT,
    id_categoria_donacion INT,
    id_centro_recepcion INT ,
    cantidad DECIMAL(10,2),
    detalles VARCHAR(200),
    fecha_donacion DATETIME DEFAULT (CURRENT_TIMESTAMP),
    fechar_termino_donacion DATE
);



CREATE TABLE    centro_recepcion_beneficiario(
    id_centro_recepcion_beneficiario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_beneficiario INT,
    id_centro_recepcion INT ,
    voluntario INT,
    fecha_entrega DATE
    
);





CREATE TABLE    centro_recepcion_voluntario(
    id_centro_recepcion_voluntario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_centro_recepcion INT,
    id_voluntario INT,
    fecha_inicio_voluntario DATE,
    fecha_fin_voluntario DATE

);




CREATE TABLE    voluntario_categoria(
    id_voluntario_categoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_categoria_ INT,
    id_beneficiario INT 
);

-- REFERENCIAS


ALTER TABLE
    donacion 
    ADD  CONSTRAINT fk_constraint_id_donador
    FOREIGN KEY
    (id_donador) REFERENCES donador(id_donador);

ALTER TABLE
    donacion 
    ADD  CONSTRAINT fk_constraint_id_categoria_donacion
    FOREIGN KEY
    (id_categoria_donacion) REFERENCES categoria_donacion(id_categoria_donacion);

ALTER TABLE
    donacion 
    ADD  CONSTRAINT fk_constraint_id_centro_recepcion
    FOREIGN KEY
    (id_centro_recepcion) REFERENCES centro_recepcion(id_centro_recepcion);

ALTER TABLE centro_recepcion_beneficiario
    ADD CONSTRAINT fk_const_id_beneficiario
    FOREIGN KEY(id_beneficiario) REFERENCES beneficiario(id_beneficiario);
    

ALTER TABLE centro_recepcion_beneficiario
    ADD CONSTRAINT fk_const_id_centro_recepcion
    FOREIGN KEY(id_centro_recepcion) REFERENCES centro_recepcion(id_centro_recepcion);


ALTER TABLE centro_recepcion_voluntario ADD CONSTRAINT fk_c_id_centro_recepcion
FOREIGN KEY (id_centro_recepcion) REFERENCES centro_recepcion(id_centro_recepcion);

ALTER TABLE centro_recepcion_voluntario ADD CONSTRAINT fk_c_id_voluntario
FOREIGN KEY (id_voluntario) REFERENCES voluntario(id_voluntario);

ALTER TABLE voluntario_categoria
    ADD CONSTRAINT fk_const_id_categoria_
    FOREIGN KEY (id_categoria_) REFERENCES categoria_voluntario(id_categoria_voluntario);

ALTER TABLE voluntario_categoria
    ADD CONSTRAINT fk_const_id_beneficiario_categoria
    FOREIGN KEY (id_beneficiario) REFERENCES beneficiario(id_beneficiario);
