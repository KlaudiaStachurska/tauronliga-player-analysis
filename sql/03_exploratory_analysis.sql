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
