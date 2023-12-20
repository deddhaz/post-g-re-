--create or replace view mbeat_feedback_reports as
select
--qq2.attributes ->> 'order' as "No",
to_char (qq.status_changed, 'Month') as "Periode",
to_char(qq.status_changed, 'DD-MM-YYYY') as "Tanggal Pengisian",
to_char(qq.status_changed, 'HH:MI:SS AM') as "Jam Pengisian",
--qq2.questionnaire_id as "Questionaire_ID",
--ss3.title as "Category",
replace(cc.title,'Feedback ','') as "Program Name",
replace(ss3.title,'Feedback : ','') as "Feedback Category",
--cc.title as "Program Name",
qq.title as "Feedback Name",
--qq.assignee_id as "ID Pengisi",
--uu.first_name as "Nama",
--ss.survey_id as "Survey ID",
--json_agg (qq2.attributes, '$.type')as "Type",
qq2.attributes ->> 'type'   as "Type", 
qq2.question as "Pertanyaan",qq4.answer as "Jawabannya",
upper(replace(replace(replace(replace(qq4.answer, '<div>', ''),'</div>',''),'amp;',''),'&nbsp;',''))as "Jawaban"
--replace(replace(replace (qq4.answer, '<div>',''),'</div>',''),'amp;',''),'&nbsp;','' as "Jawaban"
--ss2.category_id as "Category ID",

from questionnaires_questionnaire qq 
left join questionnaires_questionnaireitem qq2  on qq2.questionnaire_id =qq.id 
left join questionnaires_questionnaireitemsubmission qq4 on qq4.question_id = qq2.id 
left join surveys_surveyquestionnaire ss on qq2.questionnaire_id = ss.questionnaire_id
left join surveys_surveyitem ss2 on ss2.survey_id = ss.survey_id 
left join surveys_surveyitemcategory ss3 on ss3.id = ss2.category_id  
left join contents_course cc on cc.id = ss.course_id 
left join users_user uu on uu.id = qq.assignee_id 

where ss.survey_id is not null and 
ss3.title like '%Feedback :%' or 
ss3.title like '%Form Post Program%' or
ss3.title like '%Pendaftaran%' or 
ss3.title like '%Feedback Mentor%' or 
cc.title not like '%Trial :%' and 
qq4.answer is not null 
--qq4.answer like '%&%'
group by qq.status_changed, qq.assignee_id, qq.title, ss2,type, qq2.attributes, cc.title, ss3.title,qq2.question,qq4.answer,uu.first_name
order by qq.status_changed desc
