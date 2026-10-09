--Exploratory Data Analysis
--TAURON Liga 2025/2026

--Number of players by position
SELECT position, COUNT(*) AS player_count
FROM dbo.players
GROUP BY position
ORDER BY player_count DESC
