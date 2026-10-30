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
