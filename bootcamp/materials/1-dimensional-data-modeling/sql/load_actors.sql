
-- create index actorfilms_iyear_iactorid  on public.actor_films (year, cast(substring(actorid,3,7) as int))


with yearbounds as (
    select minyear, maxyear from
        (select
            (select min(year) from actor_films)  as minyear,
            (select max(year) from actor_films) as maxyear
        ) x
	),
	years as (
		select generate_series(minyear,maxyear) as theyear
		from yearbounds
	)
,
	actorfilmyears as (
		select 
			cast(substring(af.actorid,3,7) as int) as iactorid,
			af.year as iyear,
			af.film,
			af.votes,
			af.rating,
			cast(substring(af.filmid,3,7) as int) as ifilmid
			
		from actor_films af  
	)  
	
select 
	iyear,
	iactorid,
	ARRAY_AGG(
		ROW(
					film,
					votes,
					rating,
					ifilmid
				)::films_type
		)
 AS films		
	
from actorfilmyears
GROUP BY iyear, iactorid  
ORDER BY iyear, iactorid;
