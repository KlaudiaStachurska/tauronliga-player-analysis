--Number of players
SELECT COUNT(*) AS player_count
FROM players;

--Number of player-match records
SELECT COUNT(*) AS player_match_count
FROM player_match_statistics;

--Number of unique players with match statistics
SELECT COUNT(DISTINCT player_id) AS players_with_statistics
FROM player_match_statistics;

--Check duplicate player IDs
SELECT
  player_id
  COUNT(*) AS record_count
FROM players
GROUP BY player_id
HAVING COUNT (*) > 1;

--Check duplicate player-match combination
SELECT
  player_id
  match_id
HAVING COUNT(*) > 1;

--Check players in statistics without matching player record
SELECT DISTINCT
  s.player_id
FROM player_match_statistics AS s
LEFT JOIN players AS p
  ON s.player_id = p.player_id
WHERE p.player_id IS NULL;

USE TauronLigaAnalysis;
GO

SELECT COUNT(*) AS players_count
FROM dbo.players;

SELECT COUNT(*) AS match_statistics_count
FROM dbo.player_match_statistics;

SELECT 
	player_id,
	COUNT(*) AS record_count
FROM dbo.players
GROUP BY player_id
HAVING COUNT(*) > 1;

SELECT
	player_id,
	match_id,
	COUNT(*) AS record_count
FROM dbo.player_match_statistics
GROUP BY 
	player_id,
	match_id
HAVING COUNT(*) >1;

SELECT DISTINCT
	s.player_id
FROM dbo.player_match_statistics AS s
LEFT JOIN dbo.players AS p
	ON s.player_id=p.player_id
WHERE p.player_id IS NULL;

SELECT COUNT(DISTINCT player_id) AS players_with_statistics
FROM dbo.player_match_statistics;

SELECT
	player_id,
	player_name, 
	attack_reach_cm
FROM dbo.players
WHERE attack_reach_cm IS NULL;

