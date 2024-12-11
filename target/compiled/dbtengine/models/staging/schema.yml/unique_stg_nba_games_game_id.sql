
    
    

select
    game_id as unique_field,
    count(*) as n_records

from "nba_dev"."nba"."stg_nba_games"
where game_id is not null
group by game_id
having count(*) > 1


