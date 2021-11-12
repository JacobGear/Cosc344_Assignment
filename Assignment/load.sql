drop table organisation;
drop table character_planet;
drop table planet;
drop table super_identity_costume;
drop table costume;
drop table super_identity_power;
drop table super_identity;
drop table super_power;
drop table character_played;
drop table works_for;
drop table contracted_to;
drop table directs;
drop table director;
drop table stars;
drop table movie;
drop table actor;
drop table character;
drop table studio_location;
drop table studio;

create table organisation(
	name varchar2(50) primary key,
	goal varchar2(100),
	rival_organisation varchar2(50) constraint rival_cnst references organisation(name) disable
);
insert into organisation values('Avengers', 'Use their powers to defend the earth', 'Thanos');
insert into organisation values('Thanos', 'Save universes resources', 'Avengers');
alter table organisation enable constraint rival_cnst;

create table planet(
       name varchar2(50) primary key,
       planet_size varchar2(50),
       location varchar2(50)
);
insert into planet values('Earth', '6,361km', 'Milky Way');
insert into planet values('Asgard', null, 'Milky Way');
insert into planet values('Jotunheim', null, 'Milky Way');

create table character(
       name varchar2(50) primary key,
       sex varchar2(10),
       alignment varchar2(20)
);
insert into character values('Thor Odinson', 'Male', 'Good');
insert into character values('Loki Laufeyson', 'Male', 'Neutral');
insert into character values('Anthony Edward Stark', 'Male', 'Good');

create table character_planet(
       planet_name varchar2(50) constraint planet_cnst references planet(name),
       character_name varchar2(50) constraint char_name_cnst references character(name),
       primary key(planet_name, character_name)
);
insert into character_planet values('Asgard', 'Thor Odinson');
insert into character_planet values('Earth', 'Anthony Edward Stark');
insert into character_planet values('Jotunheim', 'Loki Laufeyson');

create table super_power(
       power_type varchar2(50) primary key,
       power_ranking int
);
insert into super_power values('Superhuman Strength', 8);
insert into super_power values('Shape-Shifting', 9);
insert into super_power values('Super Smart', 10);

create table super_identity(
       name varchar2(50) primary key,
       character_name varchar2(50) constraint char_name2_cnst references character(name)
);
insert into super_identity values('Thor', 'Thor Odinson');
insert into super_identity values('Loki', 'Loki Laufeyson');
insert into super_identity values('Iron Man', 'Anthony Edward Stark');

create table super_identity_power(
       super_identity_name varchar2(50) constraint super_name_cnst references super_identity(name),
       ipower_type varchar2(50) constraint super_power_cnst references super_power(power_type),
       primary key(super_identity_name, ipower_type)
);
insert into super_identity_power values('Thor', 'Superhuman Strength');
insert into super_identity_power values('Loki', 'Superhuman Strength');
insert into super_identity_power values('Loki', 'Shape-Shifting');
insert into super_identity_power values('Iron Man', 'Super Smart');

create table costume(
       design varchar2(50) primary key,
       material varchar2(50),
       colours varchar2(50)
);
insert into costume values('Overcoat', 'Leather', 'Dark Green and Black');
insert into costume values('Iron suit', 'Heavy Metal', 'Red and Orange');
insert into costume values('Jarngreipr', 'Metal', 'Black');

create table super_identity_costume(
       costume_design varchar2(50) constraint costume_cnst references costume(design),
       super_identity_name varchar2(50) constraint identity_cnst references super_identity(name),
       primary key(costume_design, super_identity_name)
);
insert into super_identity_costume values('Overcoat', 'Loki');
insert into super_identity_costume values('Iron suit', 'Iron Man');
insert into super_identity_costume values('Jarngreipr', 'Thor');

create table actor(
       employee_id char(9) primary key,
       name varchar2(50) not null,
       address varchar2(50) not null,
       birth_date date not null,
       sex varchar2(10),
       salary number(8) not null       
);
insert into actor values('123456789', 'Chris Hemsworth', 'Byron Bay', to_date('1983/08/11', 'yyyy/mm/dd'),
       'Male', 2000000);
insert into actor values('987654321', 'Robert Downey Jr.', 'New York City', to_date('1965/04/04', 'yyyy/mm/dd'),
       'Male', 4000000);
insert into actor values('789456123', 'Tom Hiddleston', 'Westminster', to_date('1981/02/09', 'yyyy/mm/dd'),
       'Male', 1000000);

create table character_played(
       actor_id char(9) constraint id_csnt references actor(employee_id),
       character_name varchar2(50) constraint played_name references character(name),
       primary key(actor_id, character_name)
);
insert into character_played values('123456789', 'Thor Odinson');
insert into character_played values('987654321', 'Anthony Edward Stark');
insert into character_played values('789456123', 'Loki Laufeyson');

create table studio(
       name varchar2(50) primary key     
);
insert into studio values('Marvel Studios');
insert into studio values('Sony Pictures Entertainment');
insert into studio values('20th Century Fox');

create table studio_location(
       studio_name varchar2(50) constraint studio_cnst references studio(name),
       location varchar2(50),
       primary key(studio_name, location)
);
insert into studio_location values('20th Century Fox', 'Los Angeles');
insert into studio_location values('Marvel Studios', 'New York');
insert into studio_location values('Sony Pictures Entertainment', 'Washington Boulevard');

create table movie(
       title varchar2(50) primary key,
       release_date date,
       rating int,
       budget int,
       income int,
       studio_name varchar2(50) constraint studio2_cnst references studio(name)
);
insert into movie values('Thor: The Dark World', to_date('2013/09/22','yyyy/mm/dd'), 7, 170000000, 645000000,
       'Marvel Studios');
insert into movie values('Iron Man 2', to_date('2010/04/29','yyyy/mm/dd'), 7, 200000000, 624000000,
       'Marvel Studios');

create table stars(
       movie_title varchar2(50) constraint title_cnst references movie(title),
       character_names varchar2(50) constraint chars_cnst references character(name),
       primary key(movie_title, character_names)
);
insert into stars values('Thor: The Dark World', 'Loki Laufeyson');
insert into stars values('Thor: The Dark World', 'Thor Odinson');
insert into stars values('Iron Man 2', 'Anthony Edward Stark');

create table director(
       employee_id char(9) primary key,
       name varchar2(50) not null
);
insert into director values('741852963', 'Jon Favreau');
insert into director values('963852741', 'Alan Taylor');

create table directs(
       director_id char(9) constraint dir_id_cnst references director(employee_id),
       movie_title constraint movie_title_cnst references movie(title),
       primary key(director_id, movie_title)
);
insert into directs values('741852963', 'Iron Man 2');
insert into directs values('963852741', 'Thor: The Dark World');

create table works_for(
       director_id char(9) constraint dir_id2_cnst references director(employee_id),
       studio_name varchar2(50) constraint studio_id_cnst references studio(name),
       primary key(director_id, studio_name)
);
insert into works_for values('741852963', 'Marvel Studios');
insert into works_for values('963852741', 'Marvel Studios');

create table contracted_to(
       actor_id char(9) constraint actor_cnst references actor(employee_id),
       studio_name varchar2(50) constraint studio_id2_cnst references studio(name),
       primary key(actor_id, studio_name)
);
insert into contracted_to values('123456789', 'Marvel Studios');
insert into contracted_to values('987654321', 'Marvel Studios');
insert into contracted_to values('789456123', 'Marvel Studios');
