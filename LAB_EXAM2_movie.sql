-- ACTOR(Act_id, Act_Name, Act_Gender) 
-- DIRECTOR(Dir_id, Dir_Name, Dir_Phone) 
-- MOVIES(Mov_id, Mov_Title, Mov_Year, Mov_Lang, Dir_id) 
-- MOVIE_CAST(Act_id, Mov_id, Role) 
-- RATING(Mov_id, Rev_Stars) 

-- create database moviedb;
-- use moviedb;


--  drop table rating;
--  drop table movie_cast;
--  drop table movies;
--  drop table director;
--  drop table actor;
 
create table actor(a_id int,a_name varchar(10),a_gen varchar(1),primary key(a_id));
create table director(d_id int,d_name varchar(10),d_phone int,primary key(d_id));
create table movies(m_id int,m_name varchar(10),m_year int,m_lang varchar(10),d_id int,primary key(m_id),foreign key(d_id) references director(d_id));
create table movie_cast(m_id int,a_id int,role varchar(10),foreign key(m_id) references movies(m_id),foreign key(a_id) references actor(a_id));
create table rating(m_id int,r_star int,foreign key(m_id) references movies(m_id));


insert into actor values
(1,"SRK","M"),
(2,"ranbir","M"),
(3,"ranveer","M"),
(4,"katrina","F"),
(5,"anushka","F"),
(6,"Deepika","F");

insert into director values
(1,"bhansali",3565),
(2,"A kashyap",5783),
(3,"Hirani",5642),
(4,"KJo",2345),
(5,"F akhtar",6754),
(6,"N manjule",7653);

insert into movies values
-- (1,"sairat",2018,"marathi",6),
-- (2,"padmaavat",2018,"Hindi",1),
-- (3,"ZNMD",2015,"Hindi",5),
-- (4,"jaggajasos",2017,"Hindi",2),
-- (5,"PK",2017,"Hindi",3);
(7,"DDLJ","1999","Hindi",3);
insert into movies values
(6,"sairat2",2018,"marathi",6);

insert into movie_cast values
-- (1,1,"malelead"),
-- (2,2,"brother"),
-- (3,2,"villian"),
-- (4,2,"femalelead"),
-- (5,3,"villian"),
-- (3,1,"father");
(7,1,"Lead"),
(7,3,"Villian");
insert into rating values
(1,4),
(2,3),
(3,5),
(1,3),
(2,5),
(3,2);


-- 1. List the titles of all movies directed by ‘Hitchcock’.  
select * from director d,movies m 
where d.d_id=m.d_id
and d.d_name="N manjule";
-- 2. Find the movie names where one or more actors acted in two or more movies. 
select distinct * from movies m,movie_cast mc 
where  m.m_id=mc.m_id
and mc.a_id in(
				select a_id from movie_cast 
                group by a_id
                having count(m_id)>=2
                );
				
-- 3. List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN operation).  
select * from (actor a inner join movie_cast mc on mc.a_id=a.a_id)inner join movies m on m.m_id=mc.m_id 
		where m.m_year<2000
        and exists(select * from actor a1,movie_cast mc1,movies m1
							where a1.a_id=mc1.a_id
                            and m1.m_id=mc1.m_id
                            and m1.m_year>2015
                            and a.a_id=a1.a_id)
-- 4. Find the title of movies and number of stars for each movie that has at least one rating and find the highest number of stars that movie received. Sort the result by movie title.
  select m.m_name ,max(r.r_star) from movies m,rating r
									where m.m_id=r.m_id
                                    group by m.m_id
                                    order by(m.m_name);
-- 5. Update rating of all movies directed by ‘Steven Spielberg’ to 5. 
update rating set r_star=5 
				where m_id in(
					select m.m_id from movies m,director d 
									where d.d_id=m.m_id
                                    and d_name="Hirani"
                );
select * from rating;

