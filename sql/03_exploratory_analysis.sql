--Exploratory Data Analysis
--TAURON Liga 2025/2026

--Number of players by position
SELECT position, COUNT(*) AS player_count
FROM dbo.players
GROUP BY position
ORDER BY player_count DESC

-- Number of players by team
SELECT
    team,
    COUNT(*) AS player_count
FROM dbo.players
GROUP BY team
ORDER BY player_count DESC;

-- Top 10 scorers
SELECT TOP 10
    p.player_name,
    p.position,
    p.team,
    SUM(s.points_total) AS total_points
FROM dbo.players AS p
JOIN dbo.player_match_statistics AS s
    ON p.player_id = s.player_id
GROUP BY
    p.player_name,
    p.position,
    p.team
ORDER BY total_points DESC;

-- Top 10 players by number of aces
SELECT TOP 10
    p.player_name,
    p.position,
    p.team,
    SUM(s.serve_aces) AS total_aces
FROM dbo.players AS p
JOIN dbo.player_match_statistics AS s
    ON p.player_id = s.player_id
GROUP BY
    p.player_name,
    p.position,
    p.team
ORDER BY total_aces DESC;

-- Top 10 blockers
SELECT TOP 10
    p.player_name,
    p.position,
    p.team,
    SUM(s.block_points) AS total_blocks
FROM dbo.players AS p
JOIN dbo.player_match_statistics AS s
    ON p.player_id = s.player_id
GROUP BY
    p.player_name,
    p.position,
    p.team
ORDER BY total_blocks DESC;

-- Number of players by position
SELECT
    position,
    COUNT(*) AS player_count
FROM dbo.players
GROUP BY position
ORDER BY player_count DESC;


-- Number of players by team
SELECT
    team,
    COUNT(*) AS player_count
FROM dbo.players
GROUP BY team
ORDER BY player_count DESC;


-- Number of teams
SELECT
    COUNT(DISTINCT team) AS team_count
FROM dbo.players;


-- Players with match statistics
SELECT
    COUNT(DISTINCT player_id) AS players_with_statistics
FROM dbo.player_match_statistics;


-- Number of unique matches
SELECT
    COUNT(DISTINCT match_id) AS match_count
FROM dbo.player_match_statistics;


-- Average physical attributes by position
SELECT
    position,
    AVG(CAST(height_cm AS DECIMAL(10,2))) AS avg_height,
    AVG(CAST(weight_kg AS DECIMAL(10,2))) AS avg_weight,
    AVG(CAST(attack_reach_cm AS DECIMAL(10,2))) AS avg_attack_reach
FROM dbo.players
GROUP BY position;
