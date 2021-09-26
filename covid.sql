/*Creating a table and importing the data*/

create table cov (continent varchar,location varchar,date date,total_cases int,new_cases int,total_deaths int,new_deaths int,population int,
				   gdp_per_capita float,hospital_beds_per_thousand float,life_expectancy float);
				   
copy cov from 'C:\Program Files\PostgreSQL\11\data\data_copy\nc3.csv' delimiter ',' csv header;				   
				   
select * from cov order by location,continent;



/*Checking for duplicate*/
select count(*) from cov;
select distinct count(*) from cov;



/*Breakdown of data where continent = Asia*/
select continent,location,date,new_cases,new_deaths,population,sum(new_cases) over(partition by continent) from cov where continent = 'Asia' order by new_cases desc;

select continent,location,date,new_cases,new_deaths,population,sum(new_deaths) over(partition by continent) from cov where continent = 'Asia' order by new_deaths desc;



/*Breakdown of data where continent = Africa*/
select continent,location,date,new_cases,new_deaths,population,sum(new_cases) over(partition by continent) from cov where continent = 'Africa' order by new_cases desc;

select continent,location,date,new_cases,new_deaths,population,sum(new_deaths) over(partition by continent) from cov where continent = 'Africa' order by new_deaths desc;



/*Breakdown of data where continent = Europe*/
select continent,location,date,new_cases,new_deaths,population,sum(new_cases) over(partition by continent) from cov where continent = 'Europe' order by new_cases desc;

select continent,location,date,new_cases,new_deaths,population,sum(new_deaths) over(partition by continent) from cov where continent = 'Europe' order by new_deaths desc;



/*Breakdown of data where continent = North America*/
select continent,location,date,new_cases,new_deaths,population,sum(new_cases) over(partition by continent) from cov where continent = 'North America' order by new_cases desc;

select continent,location,date,new_cases,new_deaths,population,sum(new_deaths) over(partition by continent) from cov where continent = 'North America' order by new_deaths desc;



/*Breakdown of data where continent = South America*/
select continent,location,date,new_cases,new_deaths,population,sum(new_cases) over(partition by continent) from cov where continent = 'South America' order by new_cases desc;

select continent,location,date,new_cases,new_deaths,population,sum(new_deaths) over(partition by continent) from cov where continent = 'South America' order by new_deaths desc;



/*Breakdown of data where continent = Oceania*/
select continent,location,date,new_cases,new_deaths,population,sum(new_cases) over(partition by continent) from cov where continent = 'Oceania' order by new_cases desc;

select continent,location,date,new_cases,new_deaths,population,sum(new_deaths) over(partition by continent) from cov where continent ='Oceania' order by new_deaths desc;



/*Percentage of the population for each country infested by covid across continent(Spread Rate)*/

            --AFRICA
select location, sum(new_cases) as CaseCount,max(population) as population, (sum(new_cases)/max(population)::numeric)*100 as SpreadRate from cov where continent = 'Africa' group by location order by SpreadRate desc,CaseCount;

             --EUROPE
select location, sum(new_cases) as CaseCount,max(population) as population, (sum(new_cases)/max(population)::numeric)*100 as SpreadRate from cov where continent = 'Europe' group by location order by SpreadRate desc,CaseCount;
         
            --NORTH AMERICA
select location, sum(new_cases) as CaseCount,max(population) as population, (sum(new_cases)/max(population)::numeric)*100 as SpreadRate from cov where continent = 'North America' group by location order by SpreadRate desc,CaseCount;

            --ASIA
select location, sum(new_cases) as CaseCount,max(population) as population, (sum(new_cases)/max(population)::numeric)*100 as SpreadRate from cov where continent = 'Asia' group by location order by SpreadRate desc,CaseCount;

            --SOUTH AMERICA
select location, sum(new_cases) as CaseCount,max(population) as population, (sum(new_cases)/max(population)::numeric)*100 as SpreadRate from cov where continent = 'South America' group by location order by SpreadRate desc,CaseCount;

            --OCEANIA
select location, sum(new_cases) as CaseCount,max(population) as population, (sum(new_cases)/max(population)::numeric)*100 as SpreadRate from cov where continent = 'Oceania' group by location order by SpreadRate desc,CaseCount;




/*Percentage of the population for each country killed by the virus across continent(Death Rate)*/

            --AFRICA
select location, sum(new_deaths) as DeathCount,max(population) as population, (sum(new_deaths)/max(population)::numeric)*100 as DeathRate from cov where continent = 'Africa' group by location order by DeathRate desc,DeathCount;

             --EUROPE
select location, sum(new_deaths) as DeathCount,max(population) as population, (sum(new_deaths)/max(population)::numeric)*100 as DeathRate from cov where continent = 'Europe' group by location order by DeathRate desc,DeathCount;
         
            --NORTH AMERICA
select location, sum(new_deaths) as DeathCount,max(population) as population, (sum(new_deaths)/max(population)::numeric)*100 as DeathRate from cov where continent = 'North America' group by location order by DeathRate desc,DeathCount;

            --ASIA
select location, sum(new_deaths) as DeathCount,max(population) as population, (sum(new_deaths)/max(population)::numeric)*100 as DeathRate from cov where continent = 'Asia' group by location order by DeathRate desc,DeathCount;

            --SOUTH AMERICA
select location, sum(new_deaths) as DeathCount,max(population) as population, (sum(new_deaths)/max(population)::numeric)*100 as DeathRate from cov where continent = 'South America' group by location order by DeathRate desc,DeathCount;

            --OCEANIA
select location, sum(new_deaths) as DeathCount,max(population) as population, (sum(new_deaths)/max(population)::numeric)*100 as DeathRate from cov where continent = 'Oceania' group by location order by DeathRate desc,DeathCount;



/*TEMP TABLE TO ANALYZE FIRST 9MONTHS FROM '2020-01-01' TO '2020-09-11' AND LAST 9MONTHS FROM '2020-09-12' TO '2021-06-11' */

create table cov2020 as select * from cov where date between '2020-01-01' and '2020-09-11';

create table covv2021 as select * from cov where date between '2020-09-12' and '2021-06-11';

select * from cov2020;

select * from covv2021;




select continent,sum(new_cases) as Total_Cases_Recorded,sum(new_deaths) as Total_Deaths_Recorded from cov2020 group by continent order by Total_Deaths_Recorded desc;
select continent,sum(new_cases) as Total_Cases_Recorded,sum(new_deaths) as Total_Deaths_Recorded from cov2020 group by continent order by Total_Cases_Recorded desc;



select continent,sum(new_cases) as Total_Cases_Recorded,sum(new_deaths) as Total_Deaths_Recorded from covv2021 group by continent order by Total_Deaths_Recorded desc;
select continent,sum(new_cases) as Total_Cases_Recorded,sum(new_deaths) as Total_Deaths_Recorded from covv2021 group by continent order by Total_Cases_Recorded desc;

