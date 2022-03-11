/*
creating database name Vaccine certificate identified by name vaccineCert.
and using the database vaccineCert
*/
create database if not exists vaccineCert;
use vaccineCert;

/*
creating a table for beneficiary(those who register to get vaccinated)
Considered three genders M-male, F-female, T-transgender
uhid is a 16 digit unique health id, known to the beneficiary

id_verified refers to all kind of govt id that beneficiary can upload.
It will be unique always and hemce it is the primary key for this table.
*/
create table if not exists beneficiary(Beneficiary_Name varchar(50),
    age tinyint, 
    gender enum('M','F','T'), 
    uhid char(16) unique, 
    id_verified char(30) primary key);

/*creating date_place table that contains attributes for date and place of vaccination, and
the person name who administered the vaccine

Dose 1 must have details about due date period strat and end, and hence it cannot
be null, that is checked by check constraint

Assuming vaccines are being provided only at 5 booths*/

create table if not exists date_place(v_date DATE not null, 
 dose_num enum('Dose 1', 'Dose 2') not null, 
 next_dds DATE, 
 next_dde DATE, 
 vaccinated_by char(30), 
 vaccinated_at enum('Triton Hospital','Irene Hospital','GBSS','Defence Colony care','medanta'),
 id_verified char(30) not null, 
 br_id char(13) not null unique, 
 foreign key(id_verified) references beneficiary(id_verified), 
 primary key(id_verified, br_id, dose_num),
 constraint chk_dose1 Check(dose_num = 'Dose 1' AND next_dds is not null AND next_dde is not null));


 /*creating a table to contain vaccination status and vaccine name
 Only 5 govt approved vaccines are considered here
 Vaccination status can only be partial vaccination or fully vaccinated*/
create table if not exists vaccination(v_name enum('Covaxin', 'Covishield','Sputnik V','Moderna'),
v_Status enum('Partial','Fully Vaccinated'), 
br_id char(13) primary key, 
foreign key(br_id) references date_place(br_id));


-- creating roles --
CREATE USER 'joshi'@'localhost' IDENTIFIED BY 'joshi'; --DBA--
CREATE USER 'ravneet'@'localhost' IDENTIFIED BY 'ravneet'; -- vaccine administrator --
CREATE USER 'athiya'@'localhost' IDENTIFIED BY 'athiya'; -- beneficiary --

-- Granting permissions to above users --
GRANT ALL ON vaccineCert.* TO 'joshi'@'localhost';
GRANT SELECT ON vaccineCert.* TO 'athiya'@'localhost';
GRANT INSERT, UPDATE ON vaccineCert.beneficiary TO 'athiya'@'localhost';
GRANT SELECT, INSERT, UPDATE ON vaccineCert.vaccination TO 'ravneet'@'localhost';
GRANT SELECT, INSERT, UPDATE ON vaccineCert.date_place TO 'ravneet'@'localhost';











