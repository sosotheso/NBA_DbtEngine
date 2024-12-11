WITH raw_games AS (
    SELECT
        -- Basic Game Information
        game_id,
        season_id,
        game_date::DATE AS game_date, -- Extract the date part
        season_type,
        
        -- Home Team Information
        team_id_home,
        team_abbreviation_home,
        team_name_home,
        matchup_home,
        wl_home AS home_win_loss,
        fgm_home AS home_field_goals_made,
        fga_home AS home_field_goals_attempted,
        fg_pct_home AS home_field_goal_percentage,
        fg3m_home AS home_three_point_made,
        fg3a_home AS home_three_point_attempted,
        fg3_pct_home AS home_three_point_percentage,
        ftm_home AS home_free_throw_made,
        fta_home AS home_free_throw_attempted,
        ft_pct_home AS home_free_throw_percentage,
        oreb_home AS home_offensive_rebounds,
        dreb_home AS home_defensive_rebounds,
        reb_home AS home_total_rebounds,
        ast_home AS home_assists,
        stl_home AS home_steals,
        blk_home AS home_blocks,
        tov_home AS home_turnovers,
        pf_home AS home_personal_fouls,
        pts_home AS home_points,
        plus_minus_home AS home_plus_minus,
        video_available_home AS home_video_available,
        
        -- Away Team Information
        team_id_away,
        team_abbreviation_away,
        team_name_away,
        matchup_away,
        wl_away AS away_win_loss,
        fgm_away AS away_field_goals_made,
        fga_away AS away_field_goals_attempted,
        fg_pct_away AS away_field_goal_percentage,
        fg3m_away AS away_three_point_made,
        fg3a_away AS away_three_point_attempted,
        fg3_pct_away AS away_three_point_percentage,
        ftm_away AS away_free_throw_made,
        fta_away AS away_free_throw_attempted,
        ft_pct_away AS away_free_throw_percentage,
        oreb_away AS away_offensive_rebounds,
        dreb_away AS away_defensive_rebounds,
        reb_away AS away_total_rebounds,
        ast_away AS away_assists,
        stl_away AS away_steals,
        blk_away AS away_blocks,
        tov_away AS away_turnovers,
        pf_away AS away_personal_fouls,
        pts_away AS away_points,
        plus_minus_away AS away_plus_minus,
        video_available_away AS away_video_available
    FROM "nba_dev"."raw_data"."nba_raw_game"
)
SELECT
    *,
    -- Derive Outcome Columns
    CASE 
        WHEN home_points > away_points THEN team_id_home
        ELSE team_id_away
    END AS winning_team_id,
    CASE 
        WHEN home_points > away_points THEN team_id_away
        ELSE team_id_home
    END AS losing_team_id,
    ABS(home_points - away_points) AS point_difference -- Calculate point difference
FROM raw_games