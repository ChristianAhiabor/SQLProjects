Select *
From Club_member_info;

-- Creating a Temp table to manipulate and restructure data without Altering the original.
Create table Cleaned_info
Like Club_Member_info;

Insert into Cleaned_info
Select *
From Club_Member_info;

-- TRIMMING ALL WHITE SPACES AND REMOVING UNNECESSARY CHARACTERS IN FULL NAME COLUMN
select trim(leading'?' from full_name)
from Cleaned_info;

update Cleaned_info
set full_name = trim(leading'?' from full_name);

select trim(full_name)
from Cleaned_info;

update Cleaned_info
set full_name = trim(full_name);

-- CHANGING FULL NAME TO LOWERCASE
update Cleaned_info
set full_name = lower(full_name);

-- REMOVING THE EXTRA DIGITS IN AGE COLUMN
select substring(age, 1, 2), age
from Cleaned_info;

update Cleaned_info
set age = substring(age, 1, 2);

-- CORRECTING GRAMMATICAL ERROR AND REPLACING EMPTY ROWS WITH NULL IN MARITAL STATUS COLUMN
select marital_status
from cleaned_info;

select marital_status
from Cleaned_info
where marital_status like 'div%';

update Cleaned_info
set marital_status = 'divorced'
where marital_status like 'div%';

update Cleaned_info
set marital_status = null
where marital_status = '';

-- CHANGING ROWS IN PHONE TO NULL IF LESS THAN 12
select phone,
case 
when length(phone) < 12  then null else trim(phone) end as Phone
from Cleaned_info;

update Cleaned_info
set Phone = case when length(phone) < 12 
then null else trim(phone) end;

-- CONVERT FULL ADDREESS TO LOWERCASE AND SEPARATE CITY, STATE AND STREET ADDRESS TO INDIVIDUAL COLUMNS
select lower(full_address)
from Cleaned_info;

update Cleaned_info
set full_address = lower(full_address);

select full_address, 
substring_index(full_address, ',', 1)as street_address,
substring_index(substring_index(full_address, ',', 2), ',', -1) as state,
substring_index(full_address, ',', -1) as city
from Cleaned_info;

alter table Cleaned_info
add (city text,
state text,
street_address text
);

update Cleaned_info
set city = substring_index(full_address, ',', -1);
update Cleaned_info
set state = substring_index(substring_index(full_address, ',', 2), ',', -1);
update Cleaned_info
set street_address = substring_index(full_address, ',', 1);

-- CHANGING EMPTY ROWS IN JOB TITLE TO NULL
select distinct job_title
from Cleaned_info;

update Cleaned_info
set job_title = null
where job_title ='';

-- CHANGING THE MEMBERSHIP DATE FROM TEXT TO DATE
select membership_date, str_to_date(membership_date, '%m/%d/%Y')
from  Cleaned_info;

update Cleaned_info
set membership_date = str_to_date(membership_date, '%m/%d/%Y');

select *
from cleaned_info;

-- REMOVING EXTRA COLUMNS
Alter table cleaned_info
drop column full_address;

-- CORRECTING SPELLING ERRORS IN STATE
select state
from cleaned_info
group by state
order by 1 asc;

update cleaned_info
set state = 'district of columbia'
where state = 'districts of columbia';

update cleaned_info
set state = 'california'
where state = 'kalifornia' ;

update cleaned_info
set state = 'kansas'
where state = 'kansus' ;

update cleaned_info
set state = 'new york'
where state = 'newyork';

update cleaned_info
set state = 'north carolina'
where state = 'northcarolina';

update cleaned_info
set state = 'south dakota'
where state ='south dakotaaa';

update cleaned_info
set state = 'tejas'
where state ='tej+f823as';

update cleaned_info
set state = 'tennessee'
where state ='tennesseeee';

select COUNT(*)
from cleaned_info;

-- CHECKING FOR DUPLICATES
alter table cleaned_info
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

SET @row_number = 0;

UPDATE cleaned_info
SET id = (@row_number := @row_number + 1);

select *
from cleaned_info as c1
join cleaned_info as c2
on c1.email = c2.email
where c1.email = c2.email and c1.id > c2.id;

delete c1
from cleaned_info  as c1
join cleaned_info as c2
on c1.email=c2.email
where c1.email=c2.email and c1.id > c2.id;

-- LETS TAKE A LOOK AT THE CLEANED TABLE
Select *
From cleaned_info;




