USE donaton;


-- Insertando datos en la tabla donador
INSERT INTO donaton.donador (nombre, email, status_donador) VALUES
('Juan Pérez', 'juan.perez@email.com', 'PUBLICA'),
('María García', 'maria.garcia@email.com', 'ANONIMO'),
('Carlos López', 'carlos.lopez@email.com', 'PUBLICA'),
('Ana Martínez', 'ana.martinez@email.com', 'PUBLICA'),
('Roberto Sánchez', 'roberto.sanchez@email.com', 'ANONIMO');

-- Insertando datos en la tabla categoria_donacion
INSERT INTO donaton.categoria_donacion (descripcion, tipo) VALUES
('Alimentos no perecederos', 'Alimentación'),
('Ropa de invierno', 'Vestimenta'),
('Útiles escolares', 'Educación'),
('Artículos de higiene', 'Salud'),
('Juguetes', 'Recreación');

-- Insertando datos en la tabla centro_recepcion
INSERT INTO donaton.centro_recepcion (ubicacion, encargado) VALUES
('Av. Principal 123', 'Pedro Ramírez'),
('Calle Central 456', 'Laura Torres'),
('Plaza Mayor 789', 'Miguel Ángel Ruiz'),
('Av. Libertad 321', 'Carmen Vega'),
('Paseo del Sol 654', 'Daniel Morales');

-- Insertando datos en la tabla voluntario
INSERT INTO donaton.voluntario (nombre, fecha_nacimiento) VALUES
('Luis González', '1990-05-15'),
('Patricia Flores', '1988-09-22'),
('Fernando Castro', '1995-03-10'),
('Alejandra Díaz', '1992-11-30'),
('Ricardo Mendoza', '1985-07-25');

-- Insertando datos en la tabla categoria_voluntario
INSERT INTO donaton.categoria_voluntario (descripcion_tareas) VALUES
('Clasificación de donaciones'),
('Distribución de alimentos'),
('Apoyo en eventos especiales'),
('Atención a beneficiarios'),
('Logística y transporte');

-- Insertando datos en la tabla beneficiario
INSERT INTO donaton.beneficiario (direccion, nombre_encargado, fecha_creacion) VALUES
('Calle 1 #123', 'José Martínez', '2024-01-15'),
('Av. Principal 456', 'María Rodríguez', '2024-02-01'),
('Plaza Central 789', 'Roberto García', '2024-02-15'),
('Paseo Norte 321', 'Ana López', '2024-03-01'),
('Calle Sur 654', 'Carolina Torres', '2024-03-15');


-- Insertando datos en la tabla donacion
INSERT INTO donacion (id_donador, id_categoria_donacion, id_centro_recepcion, cantidad, detalles, fecha_termino_donacion) VALUES
(1, 2, 3, 500.00, 'Donación de ropa de invierno', '2024-06-30'),
(2, 1, 1, 1000.00, 'Alimentos no perecederos', '2024-05-15'),
(3, 4, 2, 300.00, 'Artículos de higiene personal', '2024-07-01'),
(4, 3, 4, 750.00, 'Útiles escolares para primaria', '2024-08-15'),
(5, 5, 5, 250.00, 'Juguetes educativos', '2024-06-15'),
(1, 1, 2, 800.00, 'Alimentos para comedor comunitario', '2024-05-30'),
(2, 3, 3, 450.00, 'Material escolar', '2024-07-15'),
(3, 2, 1, 600.00, 'Ropa para niños', '2024-06-01'),
(4, 5, 5, 350.00, 'Juguetes para navidad', '2024-12-24'),
(5, 4, 4, 900.00, 'Kit de higiene familiar', '2024-08-01');

-- Insertando datos en la tabla centro_recepcion_beneficiario
INSERT INTO centro_recepcion_beneficiario (id_beneficiario, id_centro_recepcion, voluntario, fecha_entrega) VALUES
(1, 3, 2, '2024-04-15'),
(2, 1, 4, '2024-04-16'),
(3, 2, 1, '2024-04-17'),
(4, 5, 3, '2024-04-18'),
(5, 4, 5, '2024-04-19'),
(1, 2, 3, '2024-04-20'),
(2, 3, 1, '2024-04-21'),
(3, 4, 2, '2024-04-22'),
(4, 1, 5, '2024-04-23'),
(5, 5, 4, '2024-04-24');

-- Insertando datos en la tabla centro_recepcion_voluntario
INSERT INTO centro_recepcion_voluntario (id_centro_recepcion, id_voluntario, fecha_inicio_voluntario, fecha_fin_voluntario) VALUES
(1, 3, '2024-01-01', '2024-06-30'),
(2, 4, '2024-01-15', '2024-07-15'),
(3, 1, '2024-02-01', '2024-08-01'),
(4, 5, '2024-02-15', '2024-08-15'),
(5, 2, '2024-03-01', '2024-09-01'),
(1, 5, '2024-03-15', '2024-09-15'),
(2, 3, '2024-04-01', '2024-10-01'),
(3, 4, '2024-04-15', '2024-10-15'),
(4, 1, '2024-05-01', '2024-11-01'),
(5, 2, '2024-05-15', '2024-11-15');

-- Insertando datos en la tabla voluntario_categoria 
INSERT INTO voluntario_categoria (id_categoria_, id_beneficiario) VALUES
(1, 3),
(2, 1),
(3, 2),
(4, 5),
(5, 4),
(1, 2),
(2, 3),
(3, 1),
(4, 4),
(5, 5);