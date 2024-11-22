USE donaton;



-- Monto total de donaciones (tendencia mensual)
CREATE VIEW donaton.vw_donaciones_por_periodo AS
SELECT 
    DATE_FORMAT(fecha_donacion, '%Y-%m') as periodo,
    COUNT(1) as total_donaciones,
    SUM(cantidad) as monto_total,
    AVG(cantidad) as promedio_donacion
FROM donaton.donacion
GROUP BY
    DATE_FORMAT(fecha_donacion, '%Y-%m');



-- Top 5 categorías más donadas

CREATE VIEW donaton.vw_donaciones_por_categoria AS
SELECT 
    cd.tipo,
    cd.descripcion,
    COUNT(1) as cantidad_donaciones,
    SUM(d.cantidad) as monto_total,
    COUNT(DISTINCT d.id_donador) as donadores_unicos
FROM donaton.categoria_donacion cd -- menos registros
LEFT JOIN donaton.donacion d  -- muchos mas registros
    USING(id_categoria_donacion)
GROUP BY 
    cd.id_categoria_donacion
    ;




