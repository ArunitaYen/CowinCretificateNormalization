create database if not exists vaccineCert;
use vaccineCert;
create table if not exists beneficiary(Beneficiary_Name varchar(50),
    age tinyint, 
    gender enum('M','F','T'), 
    uhid char(16) unique, 
    id_verified char(30) primary key);


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


create table if not exists vaccination(v_name enum('Covaxin', 'Covishield','Sputnik V','Moderna'),
v_Status enum('Partial','Fully Vaccinated'), 
br_id char(13) primary key, 
foreign key(br_id) references date_place(br_id));



CREATE USER 'joshi'@'localhost' IDENTIFIED BY 'joshi';
CREATE USER 'ravneet'@'localhost' IDENTIFIED BY 'ravneet';
CREATE USER 'athiya'@'localhost' IDENTIFIED BY 'athiya';

GRANT ALL ON vaccineCert.* TO 'joshi'@'localhost';
GRANT SELECT ON vaccineCert.* TO 'athiya'@'localhost';
GRANT INSERT, UPDATE ON vaccineCert.beneficiary TO 'athiya'@'localhost';
GRANT SELECT, INSERT, UPDATE ON vaccineCert.vaccination TO 'ravneet'@'localhost';
GRANT SELECT, INSERT, UPDATE ON vaccineCert.date_place TO 'ravneet'@'localhost';











