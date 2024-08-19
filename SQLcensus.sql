select *from project.dbo.data1;
select *from project.dbo.data2;

--number of rows present in the dataset
select count(*)from project..data1
select count(*)from project..data2

--dataset for jharkhand and bihar
select * from project..data1
where state in('Jharkhand','Bihar')

--population of india
select sum(population) population from project..data2

--average growth 
select avg(growth)*100 avg_growth from project..data1

--average sex ratio
select state,round(avg(sex_ratio),0) sex_ratio from project..data1
group by state order by sex_ratio  desc;\

---main difference between where and having clause is that in where we apply to rows and having we apply to aggregated rows(group by,etc)
----average literacy rate
select state,round(avg(literacy),0) avg_literacy_ratio from project..data1
group by state having round(avg(literacy),0)>90 order by avg_literacy_ratio desc

--top 3 state showing highest growth ratio
select top 3 state,avg(growth)*100 avg_growth from project..data1
group by state
order by avg_growth desc

--bottom 3 state showing lowest sex ratio
select top 3 state,round(avg(sex_ratio),0) avg_ratio from project..data1 group by state order by avg_ratio asc;

--top and bottom 3 states in literacy rate

drop table if exists #topstates;
create table #topstates
(state nvarchar(255),
topstates float)


insert into #topstates
select state,round(avg(literacy),0) avg_literacy_ratio from project..data1 
group by state order by avg_literacy_ratio desc;

select top 3 * from #topstates order by #topstates.topstates desc;

drop table if exists #bottomstates;
create table #bottomstates
(state nvarchar(255),
bottomstates float)


insert into #bottomstates
select state,round(avg(literacy),0) avg_literacy_ratio from project..data1 
group by state order by avg_literacy_ratio desc;


--union operator
select *from(
select top 3 * from #bottomstates order by #bottomstates.bottomstates asc)a
union
select *from(
select top 3 * from #topstates order by #topstates.topstates desc)b;

--states starting from letter a
select distinct state from project..data1 where lower(state)like 'a%' 
