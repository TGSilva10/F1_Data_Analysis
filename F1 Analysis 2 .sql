-- Campeão com Maior Número de Poles

SELECT d.driverRef AS driver_name, COUNT(*) AS pole_positions
FROM qualifying q
JOIN drivers d ON q.driverId = d.driverId
WHERE q.position = 1  -- Pole position
GROUP BY d.driverRef
ORDER BY pole_positions DESC
LIMIT 1;  -- Campeão com o maior número de poles

-- Comparação de Construtores por Décadas

SELECT 
    c.name AS constructor_name,
    COUNT(r.positionOrder) AS wins,
    (ra.year / 10) * 10 AS decade
FROM results r
JOIN constructors c ON r.constructorId = c.constructorId
JOIN races ra ON r.raceId = ra.raceId
WHERE r.positionOrder = 1  -- Apenas vitórias
GROUP BY c.name, decade
ORDER BY decade, wins DESC;

-- Melhor Desempenho em Circuitos Europeus vs Não-Europeus

SELECT 
    CASE WHEN c.country IN ('Italy', 'Germany', 'France', 'Spain', 'United Kingdom', 'Netherlands', 'Belgium', 'Hungary') 
         THEN 'Europe'
         ELSE 'Non-Europe' 
    END AS region,
    COUNT(r.positionOrder) AS wins
FROM results r
JOIN races ra ON r.raceId = ra.raceId
JOIN circuits c ON ra.circuitId = c.circuitId
WHERE r.positionOrder = 1  -- Apenas vitórias
GROUP BY region;


-- Análise de Desempenho ao Longo do Tempo


-- Para os pilotos 

SELECT 
    d.driverRef AS driver_name,
    ra.year,
    COUNT(r.positionOrder) AS wins
FROM results r
JOIN drivers d ON r.driverId = d.driverId
JOIN races ra ON r.raceId = ra.raceId
WHERE r.positionOrder = 1  -- Apenas vitórias
GROUP BY d.driverRef, ra.year
ORDER BY d.driverRef, ra.year;

-- Para os construtores

SELECT 
    c.name AS constructor_name,
    ra.year,
    COUNT(r.positionOrder) AS wins
FROM results r
JOIN constructors c ON r.constructorId = c.constructorId
JOIN races ra ON r.raceId = ra.raceId
WHERE r.positionOrder = 1  -- Apenas vitórias
GROUP BY c.name, ra.year
ORDER BY c.name, ra.year;


