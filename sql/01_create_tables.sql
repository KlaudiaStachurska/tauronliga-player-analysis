CREATE TABLE players (
    player_id INT PRIMARY KEY,
    player_name NVARCHAR(150) NOT NULL,
    team NVARCHAR(150) NOT NULL,
    position NVARCHAR(50) NOT NULL,
    birth_date DATE,
    height_cm INT,
    weight_kg INT,
    attack_reach_cm INT,
    season NVARCHAR(20) NOT NULL,
    profile_url NVARCHAR(500)
  );

CREATE TABLE player_match_statistics (
    player_id INT NOT NULL,
    match_id INT NOT NULL,

    player_name NVARCHAR(150) NOT NULL,
    team NVARCHAR(150) NOT NULL,

    [match] NVATCHAR(150) NOT NULL,
    home_team NVARCHAR(150),
    away_team NVARCHAR(150),

    SET INT,
    points_total INT,
    break_points INT,
    points_balance INT,

    serve_total INT,
    serve_errors INT,
    serve_aces INT,
    serve_effiviency_pct DECIMAL(6,2),

    reception_total INT,
    reception_errors INT,
    reception_positive_pct DECIMAL(6,2)
    reception_perfect_pct DECIMAL(6,2)


    attack_total INT,
    attack_errors INT,
    attack_blocked INT,
    attack_points INT,
    attack_success_pct DECIMAL(6,2),
    attack_efficiency_pct DECIMAL(6,2),

    block_points INT,
    block_touches INT,

    defence INT,
    assists INT,

    season NVARCHAR(20) NOT NULL,

    match_url NVARCHAR(500),
    source_url NVARCHAR(500)

  CONSTRAINT PK_player_match_statistics
    PRIMARY KEY (player_id, match_id),

  CONSTRAINT FK_player_match_statistics_players
    FOREIGN KEY (player_id)
    REFERENCES players(player_id)
);
  
