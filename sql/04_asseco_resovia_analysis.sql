USE TauronLigaAnalysis;
GO
/*
    Asseco Resovia Rzeszów Analysis
    Season: 2025/2026
*/

-- 1. Asseco Resovia squad
SELECT
    player_name,
    position,
    height_cm,
    weight_kg,
    attack_reach_cm
FROM dbo.players
WHERE team = 'Asseco Resovia Rzeszów';


-- 2. Number of players by position
SELECT
    position,
    COUNT(*) AS player_count
FROM dbo.players
WHERE team = 'Asseco Resovia Rzeszów'
GROUP BY position
ORDER BY player_count DESC;


-- 3. Number of matches played by Asseco Resovia
SELECT
    COUNT(*) AS matches_played
FROM dbo.matches
WHERE home_team = 'Asseco Resovia Rzeszów'
   OR away_team = 'Asseco Resovia Rzeszów';


-- 4. Wins and losses
SELECT
    SUM(
        CASE
            WHEN home_team = 'Asseco Resovia Rzeszów'
                 AND home_sets > away_sets THEN 1
            WHEN away_team = 'Asseco Resovia Rzeszów'
                 AND away_sets > home_sets THEN 1
            ELSE 0
        END
    ) AS wins,

    SUM(
        CASE
            WHEN home_team = 'Asseco Resovia Rzeszów'
                 AND home_sets < away_sets THEN 1
            WHEN away_team = 'Asseco Resovia Rzeszów'
                 AND away_sets < home_sets THEN 1
            ELSE 0
        END
    ) AS losses
FROM dbo.matches
WHERE home_team = 'Asseco Resovia Rzeszów'
   OR away_team = 'Asseco Resovia Rzeszów';


-- 5. Home vs away record
SELECT
    CASE
        WHEN home_team = 'Asseco Resovia Rzeszów' THEN 'Home'
        ELSE 'Away'
    END AS venue,

    COUNT(*) AS matches_played,

    SUM(
        CASE
            WHEN home_team = 'Asseco Resovia Rzeszów'
                 AND home_sets > away_sets THEN 1
            WHEN away_team = 'Asseco Resovia Rzeszów'
                 AND away_sets > home_sets THEN 1
            ELSE 0
        END
    ) AS wins,

    SUM(
        CASE
            WHEN home_team = 'Asseco Resovia Rzeszów'
                 AND home_sets < away_sets THEN 1
            WHEN away_team = 'Asseco Resovia Rzeszów'
                 AND away_sets < home_sets THEN 1
            ELSE 0
        END
    ) AS losses

FROM dbo.matches
WHERE home_team = 'Asseco Resovia Rzeszów'
   OR away_team = 'Asseco Resovia Rzeszów'
GROUP BY
    CASE
        WHEN home_team = 'Asseco Resovia Rzeszów' THEN 'Home'
        ELSE 'Away'
    END;


--6. Matches played by each Asseco Resovia player 
SELECT p.player_name, COUNT(DISTINCT pms.match_id) AS matches_played
FROM dbo.players p
JOIN dbo.player_match_statistics pms ON p.player_id=pms.player_id
WHERE p.team = 'Asseco Resovia Rzeszów'
GROUP BY p.player_id, p.player_name, p.position
ORDER BY matches_played DESC;


--7. Total points by each Asseco Resovia player
SELECT p.player_name, SUM(pms.points_total) AS total_points, p.position
FROM dbo.players p
JOIN dbo.player_match_statistics pms ON p.player_id=pms.player_id
WHERE p.team = 'Asseco Resovia Rzeszów'
GROUP BY p.player_id, p.player_name, p.position
ORDER BY total_points DESC;


--8. Average points by each Asseco Resovia player
SELECT p.player_name, AVG(CAST(pms.points_total AS DECIMAL(10,2))) AS avg_points
FROM dbo.players p
JOIN dbo.player_match_statistics pms ON p.player_id = pms.player_id
WHERE p.team = 'Asseco Resovia Rzeszów'
GROUP BY p.player_id, p.player_name
ORDER BY avg_points DESC;


--9. TOP 5 best Asseco Resovia's players
SELECT TOP 5 SUM(pms.points_total) AS total_points,p.player_name
FROM dbo.players p
JOIN dbo.player_match_statistics pms ON p.player_id=pms.player_id
WHERE p.team= 'Asseco Resovia Rzeszów'
GROUP BY p.player_name
ORDER BY total_points DESC;


--10. Comparison of Asseco Resovia's players
WITH total AS (
    SELECT
        p.player_id,
        p.position,
        p.player_name,
        SUM(pms.points_total) AS total_points,
        SUM(pms.attack_total) AS total_attack_total,
        SUM(pms.attack_points) AS total_attack_points,
        SUM(pms.attack_errors) AS total_attack_errors,
        SUM(pms.attack_blocked) AS total_attack_blocked,
        SUM(pms.serve_aces) AS total_aces,
        SUM(pms.block_points) AS total_blocks
    FROM dbo.players p
    JOIN dbo.player_match_statistics pms
        ON p.player_id = pms.player_id
    WHERE p.team = 'Asseco Resovia Rzeszów'
    GROUP BY
        p.player_id,
        p.position,
        p.player_name
)

SELECT
    player_name,
    position,
    total_points,

    CAST(total_attack_points * 100.0 / NULLIF(total_attack_total, 0)
        AS DECIMAL(10,2)) AS attack_success_pct,

    CAST(
        (total_attack_points - total_attack_errors - total_attack_blocked)
        * 100.0 / NULLIF(total_attack_total, 0)
        AS DECIMAL(10,2)
    ) AS attack_efficiency_pct,

    total_aces,
    total_blocks,

    RANK() OVER (
        PARTITION BY position
        ORDER BY total_points DESC
    ) AS points_rank

FROM total
ORDER BY
    position,
    points_rank;


-- 10. Player performance comparison by position
WITH total AS
	(
		SELECT p.player_name, p.position,
				SUM(pms.points_total) AS total_points,
				SUM(pms.attack_total) AS total_attack_total,
				SUM(pms.attack_blocked) AS total_attack_blocked,
				SUM(pms.attack_points) AS total_attack_points,
				SUM(pms.attack_errors) AS total_attack_errors,
				SUM(pms.serve_aces) AS total_aces,
				SUM(pms.block_points) AS total_blocks
		FROM dbo.players p
		JOIN dbo.player_match_statistics pms ON p.player_id=pms.player_id
		WHERE p.team= 'Asseco Resovia Rzeszów'
		GROUP BY p.player_id, p.player_name, p.position
	)
SELECT player_name, position, total_points,
		CAST(total_attack_points * 100.0/NULLIF(total_attack_total,0) AS DECIMAL(10,2)) AS attack_success_pct,
		CAST((total_attack_points-total_attack_errors-total_attack_blocked)*100.0/NULLIF(total_attack_total,0) AS DECIMAL(10,2)) AS attack_efficiency_pct,
		RANK() OVER(PARTITION BY position ORDER BY total_points DESC) AS points_rank
FROM total
ORDER BY position, points_rank;


--11. Resovia vs Tauron Liga 
WITH tauron_liga AS
	(
		SELECT p.position, (SUM(pms.attack_efficiency_pct*pms.attack_total)/NULLIF(SUM(pms.attack_total),0)) AS weighted_attack_efficiency_pct_TAURON,
		(SUM(pms.reception_positive_pct*pms.reception_total)/NULLIF(SUM(pms.reception_total),0)) AS weighted_reception_positive_pct_TAURON
		FROM player_match_statistics pms
		JOIN players p ON pms.player_id=p.player_id
		WHERE p.team <> 'Asseco Resovia Rzeszów'
		GROUP BY p.position
	),
asseco_resovia AS
	(
		SELECT p.position, (SUM(pms.attack_efficiency_pct*pms.attack_total)/NULLIF(SUM(pms.attack_total),0)) AS weighted_attack_efficiency_pct_RESOVIA,
		(SUM(pms.reception_positive_pct*pms.reception_total)/NULLIF(SUM(pms.reception_total),0)) AS weighted_reception_positive_pct_RESOVIA
		FROM player_match_statistics pms
		JOIN players p ON pms.player_id=p.player_id
		WHERE p.team='Asseco Resovia Rzeszów'
		GROUP BY p.position
	)
SELECT a.position, t.weighted_attack_efficiency_pct_TAURON, t.weighted_reception_positive_pct_TAURON,
		a.weighted_attack_efficiency_pct_RESOVIA, a.weighted_reception_positive_pct_RESOVIA
FROM tauron_liga t
JOIN asseco_resovia a ON t.position=a.position
ORDER BY a.position
