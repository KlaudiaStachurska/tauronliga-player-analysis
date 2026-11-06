# TAURON Liga 2025/2026 — Asseco Resovia Performance Analysis

## Project Overview

This project analyzes the 2025/2026 TAURON Liga season from the perspective of **Asseco Resovia Rzeszów**.

The main goal is to use SQL and Power BI to evaluate team and player performance, compare Asseco Resovia with the rest of the league, identify strengths and weaknesses, and support data-driven match preparation.

The project is designed as a practical Data Analyst portfolio case study combining:

- data collection,
- data cleaning,
- relational database design,
- SQL analysis,
- data quality validation,
- player and team performance analysis,
- Power BI reporting.

---

## Business Case

The analysis is approached as if it were prepared for the analytics staff of **Asseco Resovia Rzeszów**.

Instead of only ranking players across the league, the project focuses on questions that could support a volleyball club in evaluating its own performance and preparing for opponents.

The analysis covers both:

- **internal performance** — how Asseco Resovia and its players perform,
- **external benchmarking** — how the club compares with other TAURON Liga teams and players.

---

## Key Questions

- How does Asseco Resovia Rzeszów perform compared with the TAURON Liga average?
- Which Asseco Resovia players are the most effective in attack, serve, and block?
- Which players perform best compared with others in the same position?
- How does Asseco Resovia perform at home compared with away matches?
- Which players are the most consistent throughout the season?
- What are Asseco Resovia's main strengths and weaknesses compared with league competitors?
- Which opposing players represent the biggest threat to Asseco Resovia?
- How can recent match and player performance support match preparation?

---

## Dataset

The dataset contains data collected from the official TAURON Liga website for the **2025/2026 season**.

### Players

The player dataset contains **226 players** and includes:

- player name,
- team,
- position,
- date of birth,
- height,
- weight,
- attack reach.

### Player Match Statistics

The match-level player statistics dataset contains **4,436 player-match records**.

Available metrics include:

- points,
- break points,
- serve attempts,
- serve errors,
- aces,
- serve efficiency,
- reception,
- reception errors,
- positive reception,
- perfect reception,
- attack attempts,
- attack errors,
- blocked attacks,
- attack points,
- attack success,
- attack efficiency,
- block points,
- block touches,
- defences,
- assists.

### Matches

The match dataset contains **208 matches** from the 2025/2026 season.

It includes:

- match ID,
- season,
- competition phase,
- round,
- match date,
- home team,
- away team,
- home sets,
- away sets,
- match URL.

---

## Database Model

The SQL Server database contains three main tables:

```text
players
   1
   |
   ∞
player_match_statistics
   ∞
   |
   1
matches
```

### `players`

One row represents one player.

Primary key:

```text
player_id
```

### `matches`

One row represents one match.

Primary key:

```text
match_id
```

### `player_match_statistics`

One row represents one player's statistics in one match.

Composite primary key:

```text
(player_id, match_id)
```

Foreign keys connect the table with:

```text
players.player_id
matches.match_id
```

---

## Data Quality

Before starting the analysis, the datasets were validated for consistency and completeness.

The main checks include:

- 226 player records,
- 4,436 player-match records,
- 208 unique matches,
- no duplicate player IDs,
- no duplicate `(player_id, match_id)` combinations,
- no duplicate match IDs,
- no player statistics without a corresponding player,
- no player statistics without a corresponding match,
- no matches without player statistics.

Additional checks were performed after data import to validate numeric columns, missing values, Polish characters, and relationships between tables.

---

## Asseco Resovia — Initial Results

Asseco Resovia played **34 matches** during the analyzed season.

Overall record:

```text
Wins:   21
Losses: 13
```

### Home Performance

```text
Matches: 17
Wins:    12
Losses:   5
```

### Away Performance

```text
Matches: 17
Wins:     9
Losses:   8
```

The initial results indicate a stronger win record at home than away.

Further analysis will investigate whether this difference is also visible in player-level performance metrics.

---

## SQL Analysis

The SQL part of the project is divided into several stages.

### Database Creation

`01_create_tables.sql`

Contains the relational database structure, primary keys, and foreign key relationships.

### Data Quality Checks

`02_data_quality_checks.sql`

Contains validation queries used to check:

- row counts,
- duplicates,
- missing relationships,
- dataset consistency.

### Exploratory Analysis

`03_exploratory_analysis.sql`

Contains initial league-level exploration, including:

- players by position,
- players by team,
- number of teams,
- players with match statistics,
- number of matches,
- average physical attributes by position.

### Asseco Resovia Analysis

`04_asseco_resovia_analysis.sql`

Contains the main club case study.

Current analysis includes:

- Asseco Resovia squad overview,
- squad composition by position,
- total matches played,
- wins and losses,
- home vs away performance,
- matches played by each player,
- total points by player,
- average points per match,
- top scorers,
- player comparison by position.

Further queries will expand the analysis into league benchmarking, player consistency, opponent analysis, and match preparation.

---

## Planned Analysis

The next stages of the project will focus on:

### Player Performance

Comparison of Asseco Resovia players using:

- total points,
- points per match,
- attack volume,
- attack success,
- attack efficiency,
- aces,
- blocks.

### Position-Based Comparison

Players will be compared with other players playing the same position.

This avoids directly comparing players with very different tactical roles.

### Resovia vs TAURON Liga

Club performance will be compared with league benchmarks to identify areas where Asseco Resovia performs above or below the league level.

### Form and Consistency

Match dates will be used to analyze:

- match-to-match performance,
- recent form,
- performance trends,
- consistency.

### Efficiency vs Volume

The analysis will distinguish between players who generate high totals because of high usage and players who maintain strong efficiency at high volume.

### Opponent Analysis

The project will identify:

- top opposing scorers,
- strongest attackers,
- dangerous servers,
- strongest blockers,
- high-volume attacking players.

### Match Preparation

The final SQL and Power BI analysis will combine recent performance and opponent statistics into a simplified pre-match analysis.

---

## Tools

- **SQL Server / T-SQL** — database creation, data validation, analysis
- **SQL Server Management Studio** — database management and SQL development
- **Python / Pandas** — data collection and preprocessing
- **Google Colab** — Python environment
- **Power BI** — planned dashboard and data visualization
- **GitHub** — project documentation and version control

---

## Project Structure

```text
tauronliga-player-analysis/
│
├── data/
│   ├── raw/
│   │   ├── players_raw.csv
│   │   ├── player_match_statistics_raw.csv
│   │   └── matches_raw.csv
│   │
│   └── processed/
│       ├── players.csv
│       ├── player_match_statistics.csv
│       └── matches.csv
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_data_quality_checks.sql
│   ├── 03_exploratory_analysis.sql
│   ├── 04_asseco_resovia_analysis.sql
│   └── README.md
│
├── powerbi/
│   └── README.md
│
├── images/
│   └── README.md
│
└── README.md
```

---

## Project Status

**In progress**

Completed:

- data collection,
- data cleaning,
- SQL Server database,
- relational data model,
- data quality checks,
- exploratory SQL analysis,
- initial Asseco Resovia team analysis.

In progress:

- detailed player performance analysis,
- position-based comparisons.

Next:

- Resovia vs league benchmarking,
- form and consistency analysis,
- opponent analysis,
- Power BI dashboard,
- final insights and recommendations.  
