create type  films_type  as
(
	film text,
	votes int,
	rating decimal(5,2),
	filmid int
)
;
create table actors  
( 
	actorid  		serial constraint pk_actors primary key,
	films  			films_type[],
	quality_class   varchar,
	is_active 		boolean
)


