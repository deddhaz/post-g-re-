

--select * from HCIR.dbo.quizzes_quizsession2
--KOSONGIN

--alter table HCIR.dbo.mbeat_PBI_GPOP add Unit Nvarchar(255)
--select * from HCIR.dbo.mbeat_PBI_GPOP

--alter table HCIR.dbo.mbeat_PBI_GPOP add Organization Nvarchar(255)
--select * from HCIR.dbo.mbeat_PBI_GPOP

--ISI DEHH
--DELETE FROM mbeat_PBI_GPOP3
--INSERT INTO mbeat_PBI_GPOP3
--select * from HCIR.dbo.quizzes_quizsession2
--select * from mbeat_PBI_GPOP3
--drop table mbeat_PBI_GPOP3
select ee.NIK as "NIK", ee.Name as "Name", ee.JobTitle as "Job Title", ee.region as "Region", ee.WorkLocation as "Work Location", ph.[Handle Spv] as "PIC HC", ee.Area as "Area", ee.[Join Date] as "Join Date", ee.[Resign Date] as "Resign Date", ee.EmploymentStatus as "Employment Status",

-- Company Profile
coalesce(nullif(convert(varchar(10), max(case when qq.course_id = '2330' and qq.quiz_id = '980' then (qq.score) 
end)), ''), '-') as "CP_Score",

coalesce(nullif(convert(varchar(16), (select top 1 qq2.quiz_created from HCIR.dbo.quizzes_quizsession2 as qq2
where qq2.course_id = '2330' and qq2.quiz_id = '980' and qq2.user_id = qq.user_id
order by qq2.score desc, qq2.quiz_created desc)), ''), '-') as "CP_Created_Date",

max(case when qq.course_id = '2330' and qq.quiz_id = '980' and qq.score >= 70 then 'Lulus' else 'Belum Lulus'
end) as "CP_Status",

coalesce(sum(case when qq.course_id = '2330' and qq.quiz_id = '980' then 1
end), 0) as "CP_Num_Of_Attempt",

(case when (max(case when qq.course_id = '2330' and qq.quiz_id = '980' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2330' and qq.quiz_id = '980' then 1 end) >= 3) 
then 'Completed' else 'Incomplete'
end) as "CP_Completion",

-- Product Knowledge
coalesce(nullif(convert(varchar(10), max(case when qq.course_id = '2332' and qq.quiz_id = '984' then (qq.score) 
end)), ''), '-') as "PK_Score",

coalesce(nullif(convert(varchar(16), (select top 1 qq2.quiz_created from HCIR.dbo.quizzes_quizsession2 as qq2
where qq2.course_id = '2332' and qq2.quiz_id = '984' and qq2.user_id = qq.user_id
order by qq2.score desc, qq2.quiz_created desc)), ''), '-') as "PK_Created_Date",

max(case when qq.course_id = '2332' and qq.quiz_id = '984' and qq.score >= 70 then 'Lulus' else 'Belum Lulus'
end) as "PK_Status",

coalesce(sum(case when qq.course_id = '2332' and qq.quiz_id = '984' then 1
end), 0) as "PK_Num_Of_Attempt",

(case when (max(case when qq.course_id = '2332' and qq.quiz_id = '984' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2332' and qq.quiz_id = '984' then 1 end) >= 3) 
then 'Completed' else 'Incomplete'
end) as "PK_Completion",

-- Core Value
coalesce(nullif(convert(varchar(10), max(case when qq.course_id = '2331' and qq.quiz_id = '981' then (qq.score) 
end)), ''), '-') as "CV_Score",

coalesce(nullif(convert(varchar(16), (select top 1 qq2.quiz_created from HCIR.dbo.quizzes_quizsession2 as qq2
where qq2.course_id = '2331' and qq2.quiz_id = '981' and qq2.user_id = qq.user_id
order by qq2.score desc, qq2.quiz_created desc)), ''), '-') as "CV_Created_Date",

max(case when qq.course_id = '2331' and qq.quiz_id = '981' and qq.score >= 70 then 'Lulus' else 'Belum Lulus'
end) as "CV_Status",

coalesce(sum(case when qq.course_id = '2331' and qq.quiz_id = '981' then 1
end), 0) as "CV_Num_Of_Attempt",

(case when (max(case when qq.course_id = '2331' and qq.quiz_id = '981' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2331' and qq.quiz_id = '981' then 1 end) >= 3) 
then 'Completed' else 'Incomplete'
end) as "CV_Completion",

-- Proses Bisnis
coalesce(nullif(convert(varchar(10), max(case when qq.course_id = '2333' and qq.quiz_id = '985' then (qq.score) 
end)), ''), '-') as "BP_Score",

coalesce(nullif(convert(varchar(16), (select top 1 qq2.quiz_created from HCIR.dbo.quizzes_quizsession2 as qq2
where qq2.course_id = '2333' and qq2.quiz_id = '985' and qq2.user_id = qq.user_id
order by qq2.score desc, qq2.quiz_created desc)), ''), '-') as "BP_Created_Date",

max(case when qq.course_id = '2333' and qq.quiz_id = '985' and qq.score >= 70 then 'Lulus' else 'Belum Lulus'
end) as "BP_Status",

coalesce(sum(case when qq.course_id = '2333' and qq.quiz_id = '985' then 1
end), 0) as "BP_Num_Of_Attempt",

(case when (max(case when qq.course_id = '2333' and qq.quiz_id = '985' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2333' and qq.quiz_id = '985' then 1 end) >= 3) 
then 'Completed' else 'Incomplete'
end) as "BP_Completion",

-- Overview System BFI
coalesce(nullif(convert(varchar(10), max(case when qq.course_id = '2334' and qq.quiz_id = '988' then (qq.score) 
end)), ''), '-') as "OS_Score",

coalesce(nullif(convert(varchar(16), (select top 1 qq2.quiz_created from HCIR.dbo.quizzes_quizsession2 as qq2
where qq2.course_id = '2334' and qq2.quiz_id = '988' and qq2.user_id = qq.user_id
order by qq2.score desc, qq2.quiz_created desc)), ''), '-') as "OS_Created_Date",

max(case when qq.course_id = '2334' and qq.quiz_id = '988' and qq.score >= 70 then 'Lulus' else 'Belum Lulus'
end) as "OS_Status",

coalesce(sum(case when qq.course_id = '2334' and qq.quiz_id = '988' then 1
end), 0) as "OS_Num_Of_Attempt",

(case when (max(case when qq.course_id = '2334' and qq.quiz_id = '988' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2334' and qq.quiz_id = '988' then 1 end) >= 3) 
then 'Completed' else 'Incomplete'
end) as "OS_Completion",

-- Fraud Awareness
coalesce(nullif(convert(varchar(10), max(case when qq.course_id = '2335' and qq.quiz_id = '989' then (qq.score) 
end)), ''), '-') as "FA_Score",

coalesce(nullif(convert(varchar(16), (select top 1 qq2.quiz_created from HCIR.dbo.quizzes_quizsession2 as qq2
where qq2.course_id = '2335' and qq2.quiz_id = '989' and qq2.user_id = qq.user_id
order by qq2.score desc, qq2.quiz_created desc)), ''), '-') as "FA_Created_Date",

max(case when qq.course_id = '2335' and qq.quiz_id = '989' and qq.score >= 70 then 'Lulus' else 'Belum Lulus'
end) as "FA_Status",

coalesce(sum(case when qq.course_id = '2335' and qq.quiz_id = '989' then 1
end), 0) as "FA_Num_Of_Attempt",

(case when (max(case when qq.course_id = '2335' and qq.quiz_id = '989' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2335' and qq.quiz_id = '989' then 1 end) >= 3) 
then 'Completed' else 'Incomplete'
end) as "FA_Completion",

-- Standar Etika Pelayanan
coalesce(nullif(convert(varchar(10), max(case when qq.course_id = '2336' and qq.quiz_id = '992' then (qq.score) 
end)), ''), '-') as "SEP_Score",

coalesce(nullif(convert(varchar(16), (select top 1 qq2.quiz_created from HCIR.dbo.quizzes_quizsession2 as qq2
where qq2.course_id = '2336' and qq2.quiz_id = '992' and qq2.user_id = qq.user_id
order by qq2.score desc, qq2.quiz_created desc)), ''), '-') as "SEP_Created_Date",

max(case when qq.course_id = '2336' and qq.quiz_id = '992' and qq.score >= 70 then 'Lulus' else 'Belum Lulus'
end) as "SEP_Status",

coalesce(sum(case when qq.course_id = '2336' and qq.quiz_id = '992' then 1
end), 0) as "SEP_Num_Of_Attempt",

(case when (max(case when qq.course_id = '2336' and qq.quiz_id = '992' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2336' and qq.quiz_id = '992' then 1 end) >= 3) 
then 'Completed' else 'Incomplete'
end) as "SEP_Completion",

-- APU-PPT
coalesce(nullif(convert(varchar(10), max(case when qq.course_id = '2337' and qq.quiz_id = '994' then (qq.score) 
end)), ''), '-') as "APU_Score",

coalesce(nullif(convert(varchar(16), (select top 1 qq2.quiz_created from HCIR.dbo.quizzes_quizsession2 as qq2
where qq2.course_id = '2337' and qq2.quiz_id = '994' and qq2.user_id = qq.user_id
order by qq2.score desc, qq2.quiz_created desc)), ''), '-') as "APU_Created_Date",

max(case when qq.course_id = '2337' and qq.quiz_id = '994' and qq.score >= 70 then 'Lulus' else 'Belum Lulus'
end) as "APU_Status",

coalesce(sum(case when qq.course_id = '2337' and qq.quiz_id = '994' then 1
end), 0) as "APU_Num_Of_Attempt",

(case when (max(case when qq.course_id = '2337' and qq.quiz_id = '994' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2337' and qq.quiz_id = '994' then 1 end) >= 3) 
then 'Completed' else 'Incomplete'
end) as "APU_Completion",

-- Peraturan Perusahaan
coalesce(nullif(convert(varchar(10), max(case when qq.course_id = '2233' and qq.quiz_id = '852' then (qq.score) 
end)), ''), '-') as "PP_Score",

coalesce(nullif(convert(varchar(16), (select top 1 qq2.quiz_created from HCIR.dbo.quizzes_quizsession2 as qq2
where qq2.course_id = '2233' and qq2.quiz_id = '852' and qq2.user_id = qq.user_id
order by qq2.score desc, qq2.quiz_created desc)), ''), '-') as "PP_Created_Date",

max(case when qq.course_id = '2233' and qq.quiz_id = '852' and qq.score >= 70 then 'Lulus' else 'Belum Lulus'
end) as "PP_Status",

coalesce(sum(case when qq.course_id = '2233' and qq.quiz_id = '852' then 1
end), 0) as "PP_Num_Of_Attempt",

(case when (max(case when qq.course_id = '2233' and qq.quiz_id = '852' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2233' and qq.quiz_id = '852' then 1 end) >= 3) 
then 'Completed' else 'Incomplete'
end) as "PP_Completion",

(case when 
	(max(case when qq.course_id = '2330' and qq.quiz_id = '980' then (qq.score) end) >= 70) and
	(max(case when qq.course_id = '2332' and qq.quiz_id = '984' then (qq.score) end) >= 70) and
	(max(case when qq.course_id = '2331' and qq.quiz_id = '981' then (qq.score) end) >= 70) and
	(max(case when qq.course_id = '2333' and qq.quiz_id = '985' then (qq.score) end) >= 70) and
	(max(case when qq.course_id = '2334' and qq.quiz_id = '988' then (qq.score) end) >= 70) and
	(max(case when qq.course_id = '2335' and qq.quiz_id = '989' then (qq.score) end) >= 70) and
	(max(case when qq.course_id = '2336' and qq.quiz_id = '992' then (qq.score) end) >= 70) and
	(max(case when qq.course_id = '2337' and qq.quiz_id = '994' then (qq.score) end) >= 70) and
	(max(case when qq.course_id = '2233' and qq.quiz_id = '852' then (qq.score) end) >= 70) then 'Lulus' else 'Belum Lulus'
end) as "Final_Status",

(case when
	((max(case when qq.course_id = '2330' and qq.quiz_id = '980' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2330' and qq.quiz_id = '980' then 1 end) >= 3)) and
	((max(case when qq.course_id = '2332' and qq.quiz_id = '984' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2332' and qq.quiz_id = '984' then 1 end) >= 3)) and
	((max(case when qq.course_id = '2331' and qq.quiz_id = '981' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2331' and qq.quiz_id = '981' then 1 end) >= 3)) and
	((max(case when qq.course_id = '2333' and qq.quiz_id = '985' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2333' and qq.quiz_id = '985' then 1 end) >= 3)) and
	((max(case when qq.course_id = '2334' and qq.quiz_id = '988' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2334' and qq.quiz_id = '988' then 1 end) >= 3)) and
	((max(case when qq.course_id = '2335' and qq.quiz_id = '989' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2335' and qq.quiz_id = '989' then 1 end) >= 3)) and
	((max(case when qq.course_id = '2336' and qq.quiz_id = '992' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2336' and qq.quiz_id = '992' then 1 end) >= 3)) and
	((max(case when qq.course_id = '2337' and qq.quiz_id = '994' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2337' and qq.quiz_id = '994' then 1 end) >= 3)) and
	((max(case when qq.course_id = '2233' and qq.quiz_id = '852' then (qq.score) end) >= 70) or (sum(case when qq.course_id = '2233' and qq.quiz_id = '852' then 1 end) >= 3)) then 'Completed' else 'Incomplete'
end) as "Final_Completion", 

ee.Unit as "Unit",
ee.Organization as "Organization"

--select * from quizzes_quizsession2
--select * from mbeat_PBI_GPOP3

--into HCIR.dbo.mbeat_PBI_GPOP3
from HCIR.dbo.quizzes_quizsession2 as qq
full join HCIR.dbo.UsersMbeat as uu on uu.id = qq.user_id
--full join dbo.ContentsCourse as cc on qq.course_id = qq.course_id
full join HCIR.dbo.DataEmployee as ee on ee.NIK = uu.username
full join HCIR.dbo.pichchandle as ph on ph.Cabang = ee.WorkLocation
--where uu.username = '094350'
where ee.[Resign Date] is null and (ee.EmploymentStatus = 'Contract' or ee.EmploymentStatus = 'Mitra' or ee.EmploymentStatus = 'Permanent' or ee.EmploymentStatus = 'Probation')
and ee.JobTitle != 'Management Trainee External In Class' /*and year(ee.[Join Date]) >= 2023*/ and
ee.[Join Date] >= DATEADD(DAY, -90, GETDATE()) 
group by ee.NIK, ee.Name, qq.user_id, ee.JobTitle, ee.Unit, ee.Organization, ee.Region, ee.WorkLocation, ph.[Handle Spv], ee.Area, ee.[Join Date], ee.[Resign Date], ee.EmploymentStatus
order by [Join Date] desc