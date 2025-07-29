CREATE DATABASE KAGGLE;
USE KAGGLE;

SELECT * FROM college_student_placement_dataset;

-- 1.List all students who got placed.
select * from college_student_placement_dataset
where placement = 'yes';

-- 2.How many students got placed and how many did not?
select placement, count(*) from 
college_student_placement_dataset
group by placement;

-- 3.Find students who have CGPA greater than 7.
select * from  college_student_placement_dataset
where cgpa >7;

-- 4.Show students who have internship experience.
select * from college_student_placement_dataset
where internship_experience = 'yes';

-- 5.Display students who completed more than 2 projects.
select * from college_student_placement_dataset
where projects_completed >= 2;



-- 🔶 Intermediate Level Questions
-- 6.What is the average CGPA of placed students?
select avg(cgpa) from college_student_placement_dataset
where placement = 'yes';

-- 7.Who are the top 5 students with the highest IQ?
select * from college_student_placement_dataset
order by iq desc
limit 5;

-- 8.How many placed students had internship experience?
select count(*) as placed_with_internship
from college_student_placement_dataset
where placement = 'yes' and internship_experience = 'yes';

-- 9.List students who have high communication skills (≥8) but were not placed.
select * from college_student_placement_dataset
where communication_skills >=8 and placement = 'no';


-- 10.What is the average extracurricular score of students who completed 3 or more projects?
select avg(extra_curricular_score) as avg_score
from college_student_placement_dataset
where projects_completed >= 3;

-- 11.Compare the average CGPA of students with and without internship experience.
select internship_experience, avg(cgpa) as average_cgpa from college_student_placement_dataset
group by internship_experience;


-- 12.Is there any difference in average CGPA between placed and non-placed students?
select placement, avg(cgpa) 
from college_student_placement_dataset 
group by placement;


-- 13.Find students who have CGPA > 7, completed at least 2 projects, and have communication skills ≥ 7.
select * from college_student_placement_dataset
where cgpa >7 and projects_completed >= 2 and communication_skills >=7;


-- 14.Rank students based on IQ and display their placement status.
SELECT college_id,iq,placement,
  RANK() OVER (ORDER BY iq DESC) AS iq_rank
FROM college_student_placement_dataset ;


-- 15.List students whose academic performance is below the overall average.
select * from college_student_placement_dataset
where cgpa < (select avg(cgpa) from college_student_placement_dataset);