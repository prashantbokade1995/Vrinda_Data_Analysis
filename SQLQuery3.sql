


Create database election_db;
 Use election_db
create schema votersSchema;

Create table votersSchema.Citizen(citizen_id int primary key,
					citizen_name varchar(100) not null,
					aadhar_no varchar(12) unique,
					country varchar(10))

select * from votersSchema.Citizen

drop table Citizen;