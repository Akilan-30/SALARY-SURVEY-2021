

-- MILESTONE 1: QUERIES --


use Milestone;

-- 1. Average Salary by Industry and Gender --

SELECT industry,gender,ROUND(AVG(Annual_Salary)) AS average_salary
FROM salary_survey
GROUP BY industry, gender
ORDER BY industry, gender;


-- 2. Total Salary Compensation by Job Title

SELECT job_title, round(SUM(Annual_Salary + Additional_Monetary_Compensation)) 
     AS total_salary_compensation
FROM  salary_survey
GROUP BY job_title
ORDER BY total_salary_compensation DESC;


-- 3. Salary Distribution by Education Level

SELECT Highest_Education, round(MIN(Annual_Salary)) AS min_salary, 
       round(MAX(Annual_Salary)) AS max_salary, 
       round(AVG(Annual_Salary)) AS avg_salary
FROM salary_survey
GROUP BY Highest_Education
ORDER BY Highest_Education;


-- 4. Number of Employees by Industry and Years of Experience

SELECT Industry, Years_of_Professional_Experience_Overall, 
   COUNT(id) AS Number_of_Employees
FROM salary_survey
GROUP BY 
    Industry, 
    Years_of_Professional_Experience_Overall
ORDER BY 
    Industry, 
    Years_of_Professional_Experience_Overall;


-- 5. Median Salary by Age Range and Gender

WITH RankedSalaries AS (
    SELECT 
        Age_range, 
        Gender, 
        Annual_Salary,
        ROW_NUMBER() OVER (PARTITION BY Age_range, Gender ORDER BY Annual_Salary) AS RowAsc,
        ROW_NUMBER() OVER (PARTITION BY Age_range, Gender ORDER BY Annual_Salary DESC) AS RowDesc,
        COUNT(*) OVER (PARTITION BY Age_range, Gender) AS TotalCount
    FROM salary_survey
)
SELECT 
    Age_range, 
    Gender,
    ROUND(AVG(Annual_Salary)) AS Median_Salary
FROM RankedSalaries
WHERE RowAsc = RowDesc OR RowAsc = TotalCount / 2 + 1
GROUP BY Age_range, Gender
ORDER BY Age_range, Gender;


-- 6. Job Titles with the Highest Salary in Each Country

WITH MaxSalaryPerCountry AS (
    SELECT Country, MAX(Annual_Salary) AS Max_Salary
    FROM Salary_Survey
    GROUP BY Country
)
SELECT S.Job_Title, S.Country, S.Annual_Salary AS Max_Salary
FROM Salary_Survey S
JOIN MaxSalaryPerCountry M
ON S.Country = M.Country AND S.Annual_Salary = M.Max_Salary
ORDER BY Max_Salary Desc, S.Country;


-- 7. Average Salary by City and Industry

SELECT City, Industry, 
    round(AVG(Annual_Salary)) AS Average_Salary
FROM salary_survey
GROUP BY City, Industry
ORDER BY City, Industry;
    

-- 8. Percentage of Employees with Additional Monetary Compensation by Gender

SELECT 
    Gender, ROUND(COUNT(CASE WHEN Additional_Monetary_Compensation > 0 THEN 1 END) * 100.0 / COUNT(*), 2) 
    AS Percentage_With_Compensation
FROM 
    salary_survey
GROUP BY 
    Gender
ORDER BY 
    Gender;

-- 9. Total Compensation by Job Title and Years of Experience

SELECT Job_Title, Years_of_Professional_Experience_Overall AS Years_of_Experience,
    round(SUM(Annual_Salary + COALESCE(Additional_Monetary_Compensation, 0)))AS Total_Compensation
FROM salary_survey
GROUP BY 
    Job_Title, 
	Years_of_Professional_Experience_Overall
ORDER BY 
    Job_Title, 
    Years_of_Experience;


-- 10. Average Salary by Industry, Gender, and Education Level

SELECT Industry, Gender, Highest_Education,
	round(AVG(Annual_Salary)) AS Average_Salary
FROM salary_survey
GROUP BY 
     Industry, Gender, Highest_Education
ORDER BY 
	 Industry, Gender, Highest_Education;
