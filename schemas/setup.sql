drop table Campaigns cascade;
create table Campaigns(
  campaign_name char(32) primary key,
  area char(20),
  start_date date,
  end_date date,
  topic char(20),
  budgets real
);

insert into Campaigns values('Save the trees', 'Nanaimo', '2018-07-20', '2018-07-25', 'forest', 500);
insert into Campaigns values('Bike, don''t drive', 'Victoria', '2018-09-22', '2018-10-10', 'air pollution', 1000);
insert into Campaigns values('More vegetables, less meat', 'Victoria', '2018-10-11', '2018-10-25', 'food', 200);
insert into Campaigns values('Bus life', 'Sannich', '2018-12-12', '2018-12-20', 'air pollution', 500);
insert into Campaigns values('No more killing', 'Nanaimo', '2018-12-25', '2019-01-10', 'food', 900);
insert into Campaigns values('Save the dophins', 'Victoria', '2019-01-05', '2019-02-20', 'animal', 1200);

drop table Events cascade;
create table Events(
  event_name char(32) primary key,
  start_time timestamp,
  end_time timestamp,
  place char(20),
  tools char(20)
);

insert into Events values('Clean up the forest', '2018-07-20 10:00:00', '2018-07-20 14:00:00', 'public squares', 'posters');
insert into Events values('Don''t bother the animals', '2018-07-21 10:00:00', '2018-07-21 18:00:00', 'street corner', 'flyers');
insert into Events values('Be active', '2018-09-22 09:00:00', '2018-09-22 15:00:00', 'street corner', 'flyers');
insert into Events values('red meat is not good', '2018-10-15 10:30:00', '2018-10-16 18:00:00', 'public squares', 'placards');
insert into Events values('TEXT ANYTIME', '2018-12-13 10:30:00', '2018-12-20 18:00:00', 'public squares', 'flyers');
insert into Events values('Chicken wants to live', '2018-12-26 13:30:00', '2018-12-28 18:00:00', 'public squares', 'placards');
insert into Events values('Dophins are so cute', '2019-01-06 15:30:00', '2019-01-08 20:00:00', 'street corner', 'posters');

drop table Volunteers cascade;
create table Volunteers(
  volunteer_id integer primary key,
  first_name char(20),
  last_name char(20),
  tiers integer
);

insert into Volunteers values(176, 'Amy', 'Santigo', 1);
insert into Volunteers values(088, 'Jake', 'Peralta', 2);
insert into Volunteers values(122, 'Gina', 'Linetti', 1);
insert into Volunteers values(100, 'Ray', 'Holt', 1);
insert into Volunteers values(165, 'Charles', 'Boyle', 2);
insert into Volunteers values(201, 'Terry', 'Jeffords', 1);

drop table Employees cascade;
create table Employees(
  employee_id integer primary key,
  first_name char(20),
  last_name char(20),
  salary real
);

insert into Employees values(133, 'Michael', 'Hitchcock', 300);
insert into Employees values(055, 'Norm', 'Scully', 500);
insert into Employees values(102, 'Kevin', 'Cozner', 800);
insert into Employees values(110, 'Doug', 'Judy', 800);

drop table Members cascade;
create table Members(
  member_id integer primary key,
  first_name char(20),
  last_name char(20),
  donate_amount real
);

insert into Members values(065, 'John', 'Kelly', 10000);
insert into Members values(255, 'Seamus', 'Murphy', 40000);
insert into Members values(783, 'Keith', 'Pembroke', 30000);
insert into Members values(550, 'Madeline', 'Wuntch', 90000);

drop table Website cascade;
create table Website(
  campaign_name char(32),
  push_time date,
  phase integer,
  foreign key(campaign_name) references Campaigns(campaign_name)
);

insert into Website values('Save the trees', '2018-07-20', 3);
insert into Website values('Bike, don''t drive', '2018-09-24', 4);
insert into Website values('More vegetables, less meat', '2018-10-09', 4);
insert into Website values('Bus life', '2018-12-11', 4);
insert into Website values('No more killing', '2018-12-25', 4);
insert into Website values('Save the dophins', '2019-01-05', 4);

drop table Run cascade;
create table Run(
  campaign_name char(32),
  event_name char(32)
);

insert into Run values('Save the trees', 'Clean up the forest');
insert into Run values('Save the trees', 'Don''t bother the animals');
insert into Run values('Bike, don''t drive', 'Be active');
insert into Run values('More vegetables, less meat', 'red meat is not good');
insert into Run values('Bus life', 'TEXT ANYTIME');
insert into Run values('No more killing', 'Chicken wants to live');
insert into Run values('Save the dophins', 'Dophins are so cute');

drop table Hire cascade;
create table Hire(
  campaign_name char(32),
  employee_id integer
);

insert into Hire values('Save the trees', 133);
insert into Hire values('Save the trees', 055);
insert into Hire values('Save the trees', 110);
insert into Hire values('Bike, don''t drive', 133);
insert into Hire values('Bike, don''t drive', 102);
insert into Hire values('Bike, don''t drive', 055);
insert into Hire values('More vegetables, less meat', 110);
insert into Hire values('More vegetables, less meat', 055);
insert into Hire values('Bus life', 055);
insert into Hire values('No more killing', 055);
insert into Hire values('No more killing', 110);

drop table memberOf cascade;
create table memberOf(
  campaign_name char(32),
  member_id integer
);

insert into memberOf values('Save the trees', 065);
insert into memberOf values('Save the trees', 255);
insert into memberOf values('Save the trees', 783);
insert into memberOf values('Bike, don''t drive', 133);
insert into memberOf values('Bike, don''t drive', 065);
insert into memberOf values('Bike, don''t drive', 255);
insert into memberOf values('More vegetables, less meat', 133);
insert into memberOf values('Bus life', 065);
insert into memberOf values('Bus life', 783);
insert into memberOf values('No more killing', 783);
insert into memberOf values('No more killing', 065);
insert into memberOf values('No more killing', 133);
insert into memberOf values('Save the dophins', 065);
insert into memberOf values('Save the dophins', 255);

drop table participate cascade;
create table participate(
  event_name char(32),
  volunteer_id integer
);

insert into participate values('Save the trees', 088);
insert into participate values('Save the trees', 176);
insert into participate values('Save the trees', 122);
insert into participate values('Save the trees', 100);
insert into participate values('Save the trees', 165);
insert into participate values('Save the trees', 201);
insert into participate values('Bike, don''t drive', 088);
insert into participate values('Bike, don''t drive', 122);
insert into participate values('Bike, don''t drive', 100);
insert into participate values('Bike, don''t drive', 165);
insert into participate values('More vegetables, less meat', 176);
insert into participate values('More vegetables, less meat', 165);
insert into participate values('Bus life', 176);
insert into participate values('Bus life', 122);
insert into participate values('Bus life', 100);
insert into participate values('Bus life', 165);
insert into participate values('Bus life', 201);
insert into participate values('No more killing', 088);
insert into participate values('No more killing', 122);
insert into participate values('No more killing', 165);
insert into participate values('Save the dophins', 088);
insert into participate values('Save the dophins', 176);
insert into participate values('Save the dophins', 122);
insert into participate values('Save the dophins', 165);
insert into participate values('Save the dophins', 201);

/* Which member have donated more than 30000 dollars? */
create view query1 as
  select first_name, last_name
  from Members
  where donate_amount > 30000;

/* Find the member have donated the most money. */
create view query2 as
  select first_name, last_name
  from Members
  where donate_amount >= all (select donate_amount from Members);

/* Which campaign have push on the website since they start the campaign? */
create view query3 as
  select Campaigns.campaign_name
  from Campaigns, Website
  where Campaigns.campaign_name = Website.campaign_name
  and Campaigns.start_date = Website.push_time;

/* Who join the campaign “Save the dolphins?” */
create view query4 as
  select first_name, last_name
  from participate join volunteers
  on participate.volunteer_id = volunteers.volunteer_id
  and event_name = 'Save the dophins';

/* How many volunteers join the campaign “Bus life?” */
create view query5 as
  select count(*)
  from participate
  where event_name = 'Bus life';

/* Which campaign have only one volunteer? */
create view query6 as
  select campaign_name
  from hire h1
  where not exists (
    select *
    from hire
    where campaign_name = h1.campaign_name and employee_id <> h1.employee_id);

/* Which campaigns have Jake Peralta (id=88) volunteer in? */
create view query7 as
  select event_name
  from volunteers join participate
  on volunteers.volunteer_id = participate.volunteer_id and volunteers.volunteer_id = 88;

/* How many campaiagns have Terry Jeffords go to? */
create view query8 as
  select count(*)
  from volunteers join participate
  on volunteers.volunteer_id = participate.volunteer_id and Volunteers.first_name = 'Terry';

/* Which employee have been paid the most? */
create view query9 as
  select first_name, last_name
  from Employees
  where salary>= all (select salary from Employees);

/* How many volunteers join the campaign “Save the trees?” */
create view query10 as
  select count(*)
  from participate
  where event_name = 'Save the trees';
