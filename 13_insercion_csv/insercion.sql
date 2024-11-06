USE donaton;

-- parametro que debe usar la parte grafica -> terminal tanto desde servidor como de interfaz -> cliente
--
--
--
--
--

SET GLOBAL local_infile = 'ON';

LOAD DATA LOCAL INFILE
  "donaton_donador_full.csv"
  INTO TABLE donaton.donador
  FIELDS TERMINATED BY ','
  -- ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (nombre,email,status_donador)
  ;



SELECT *
FROM donaton.donador;


