select
--aa.name as "Audience",
cc.title as "Course",
--array_to_string(array_agg(distinct cc.title), ' || ') as "Courselist"
array_to_string(array_agg(distinct aa.name), ' || ') as "Audience List"
from audience_audience aa 
join audience_audience_courses aac on aac.audience_id = aa.id 
join contents_course cc on cc.id = aac.course_id
where cc.is_active is true
group  by cc.title --,aa.name 


--select * from audience_audience_courses aac 