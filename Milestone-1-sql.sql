Create Database if not exists Milestone;
use Milestone;

create table Salary_survey(
	id int primary key,
	Age_range varchar(100),
    Industry varchar(500),
    Job_Title varchar(500),
    Annual_Salary decimal(15,2),
    Additional_Monetary_Compensation decimal(15,2),
    Currency varchar(100),
    Other_Currency varchar(100),
    Country varchar(100),
    State varchar(100),
    City varchar(100),
    Years_of_Professional_Experience_Overall varchar(500),
    Years_of_Professional_Experience_in_Field varchar(500),
    Highest_Education varchar(250),
    Gender varchar(250)
);

select * from Salary_Survey;


LOAD DATA INFILE "C:/Sql Files/Milestoney updated.csv"
INTO TABLE Salary_Survey
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS;



