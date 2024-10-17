
-- NO REQUIERE Y NO SE LE PIDE INDEXACION 
CREATE TABLE `CLASE7`.`TROOP_MASIVO` (
  `ID` int NOT NULL,
  `DESCRIPCION` varchar(100) DEFAULT NULL,
  `FECHA_INGESTA` DATE DEFAULT(CURRENT_DATE)
) ENGINE=MyISAM
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- - 

-- CENSO
-- [ciudad] 1 -- * [ciudadano] 1 --- * [censo]

DROP DATABASE IF EXISTS censo;
CREATE DATABASE censo ;
USE censo;

CREATE TABLE ciudad(
	id_ciudad INT NOT NULL AUTO_INCREMENT,
    nombre_ciudad VARCHAR(200),
    area VARCHAR(200) DEFAULT 'centro',
    PRIMARY KEY(id_ciudad)
) ENGINE=InnoDB	AUTO_INCREMENT=100 COMMENT='TABLA DE CIUDADES';

CREATE TABLE ciudadano(
	id_ciudadano INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(200),
	edad INT NOT NULL,
    id_ciudad INT,
    PRIMARY  KEY(id_ciudadano)
);

CREATE TABLE censo(
	id_censo INT NOT NULL AUTO_INCREMENT,
    fecha DATE DEFAULT (CURRENT_DATE),
    id_ciudadano INT ,
    id_ciudad INT  ,
    PRIMARY  KEY(id_censo)
);

ALTER TABLE ciudadano
	ADD CONSTRAINT fk_ciudad_ciudadano
    FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
    ON DELETE 
		-- SET NULL
        CASCADE
        
	ON UPDATE
		SET NULL 
    ;


ALTER TABLE censo
	ADD CONSTRAINT fk_censo_ciudad
    FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
    ON DELETE 
		-- SET NULL
        CASCADE
	ON UPDATE
		SET NULL 
    ;

ALTER TABLE censo
	ADD CONSTRAINT fk_censo_ciudadano
    FOREIGN KEY (id_ciudadano) REFERENCES ciudadano(id_ciudadano);



-- Insert sample data into ciudad
insert into
  ciudad (nombre_ciudad, area)
values
  ('Ciudad A', 'centro'),
  ('Ciudad B', 'norte'),
  ('Ciudad C', 'sur'),
  ('Ciudad D', 'este'),
  ('Ciudad E', 'oeste'),
  ('Ciudad F', 'centro'),
  ('Ciudad G', 'norte'),
  ('Ciudad H', 'sur'),
  ('Ciudad I', 'este'),
  ('Ciudad J', 'oeste');

-- Insert sample data into ciudadano
insert into
  ciudadano (nombre, edad, id_ciudad)
values
  ('Juan Perez', 30, 100),
  ('Maria Gomez', 25, 100),
  ('Carlos Ruiz', 40, 100),
  ('Ana Lopez', 35, 101),
  ('Luis Martinez', 28, 101),
  ('Sofia Fernandez', 32, 102),
  ('Miguel Torres', 45, 102	),
  ('Laura Sanchez', 29, 103),
  ('Jorge Ramirez', 33, 100),
  ('Elena Diaz', 27, 100);

-- Insert sample data into censo
insert into
  censo (fecha, id_ciudadano, id_ciudad)
values
  (current_date, 1, 100),
  (current_date, 2, 100),
  (current_date, 3, 100),
  (current_date, 4, 101),
  (current_date, 5, 101),
  (current_date, 6, 102),
  (current_date, 7, 102),
  (current_date, 8, 103),
  (current_date, 9, 100),
  (current_date, 10, 100);
  
  
  
  DELETE FROM ciudad
  WHERE id_ciudad = 101;
  
  UPDATE ciudad
	SET id_ciudad = 200
	WHERE id_ciudad = 101;
  

