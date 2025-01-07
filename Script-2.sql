SELECT 
    r.year,
    d.driverRef AS driver_name,
    d.nationality,
    ds.points,
    ds.position
FROM driver_standings ds
JOIN drivers d ON ds.driverId = d.driverId
JOIN races r ON ds.raceId = r.raceId
WHERE ds.position = 1  -- Apenas os campeões
ORDER BY r.year;

-- Melhor Circuito para um Piloto Específico (Lewis Hamilton, Max Verstappen, Charles Leclerc)

SELECT c.name AS circuit_name, 
	COUNT(*) AS wins
FROM results as r
JOIN races as ra ON r.raceId = ra.raceId  -- Associar as races para pegar circuitId
JOIN circuits as c ON ra.circuitId = c.circuitId  -- Associar o circuito
JOIN drivers as d ON r.driverId = d.driverId  -- Associar o piloto
WHERE r.positionOrder = 1 AND d.driverRef = 'hamilton'  -- Vitórias do Hamilton
GROUP BY c.name
ORDER BY wins DESC
LIMIT 5;

SELECT c.name AS circuit_name, 
	COUNT(*) AS wins
FROM results as r
JOIN races as ra ON r.raceId = ra.raceId  -- Associar as races para pegar circuitId
JOIN circuits as c ON ra.circuitId = c.circuitId  -- Associar o circuito
JOIN drivers as d ON r.driverId = d.driverId  -- Associar o piloto
WHERE r.positionOrder = 1 AND d.driverRef = 'max_verstappen'  -- Vitórias do Verstappen
GROUP BY c.name
ORDER BY wins DESC
LIMIT 5;

SELECT c.name AS circuit_name, COUNT(*) AS wins
FROM results as r
JOIN races as ra ON r.raceId = ra.raceId  -- Associar as races para pegar circuitId
JOIN circuits as c ON ra.circuitId = c.circuitId  -- Associar o circuito
JOIN drivers as d ON r.driverId = d.driverId  -- Associar o piloto
WHERE r.positionOrder = 1 AND d.driverRef = 'leclerc'  -- Vitórias do Leclerc
GROUP BY c.name
ORDER BY wins DESC
LIMIT 5;

-- Melhores Construtores por Década 

SELECT 
    c.name AS constructor_name,
    COUNT(r.positionOrder) AS wins,
    (ra.year / 10) * 10 AS decade
FROM results r
JOIN constructors c ON r.constructorId = c.constructorId  -- Associar construtores
JOIN races ra ON r.raceId = ra.raceId  -- Associar corridas com o ano
WHERE r.positionOrder = 1  -- Apenas vitórias
GROUP BY c.name, decade
ORDER BY decade, wins DESC