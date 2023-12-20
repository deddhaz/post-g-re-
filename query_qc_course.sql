select
cc3.id as "course_id",
cc3.title as "coursename",
to_char(cc3.modified,'DD-MM-YYYY (HH24:MI)')  as "updated",
cc5.title as "collection",
cc6.title as "channel",
array_to_string(array_agg(distinct cc2.title), ' || ') as "contentlist",
--select * from quizzes_quiz qq 
--case when cc3.title like '%GLP%' then 'Mandatory' else 'Non Mandatory' end as "Tag",
to_char(cc3.created,'DD-MM-YYYY (HH24:MI)')  as "tanggal created",
cc3.is_active as "Active",
cc3.min_percentage_finish as "Min Pcnt",
cc3.content_in_sequence as "Seq",
case when qq2.title is null then 'Tidak ada Pre Test' else qq2.title end as "Pre Test",
case when qq2.title like '%Pre Test%' then count (distinct(qq3.id)) end as "Qty Pre-T",
case when qq.title is null then 'Tidak ada Post Test' else qq.title end as "Post Test",
qq.max_attempt as "Max_att",
case when qq.title like '%Post Test%' then count (distinct(qq3.id)) end as "Qty-Post-T",

cc3.max_questions as "Max_Question",
array_to_string(array_agg(distinct aa.name), ' || ') as "Audience List"

from contents_coursecontentasset cc

--select * from contents_course cc where title like '%GLP 1 Hard : NDF Car%'
--select * from users_user uu where username = '078719'

left join contents_contentasset cc2 on cc2.id = cc.content_asset_id
left join contents_course cc3 on cc3.id = cc.course_id 
left join quizzes_quiz qq on qq.id = cc3.post_test_id 
left join quizzes_quiz qq2 on qq2.id = cc3.pre_test_id 
left join quizzes_question qq3 on qq3.quiz_id = qq.id 
left join quizzes_question qq4 on qq4.quiz_id = qq2.id 
left join contents_coursecollection cc4 on cc4.course_id = cc3.id
left join contents_collection cc5 on cc5.id = cc4.collection_id 
left join contents_channel cc6 on cc6.id = cc5.channel_id 
left join audience_audience_courses aac on aac.course_id = cc3.id 
left join audience_audience aa on aa.id = aac.audience_id 
--where cc3.is_active = true --and cc3.title ='2gen01'
--where cc3.title like '%Risk Self Assesment (RSA) : HCBP Supervisor - SOP Rekrutmen Karyawan%'
 
where cc3.title like '%OWASP%' and cc3.is_Active = false 
--cc3.title like '%Branch Sales : Development Day Freeze - ACTOR (7 - 12 Agustus 2023)%' or 
--cc3.title like '%Branch Sales : Development Day Freeze - Head/Spv (7 - 12 Agustus 2023)%' 
--cc3.title like '%Refreshment : Becoming Leader for Great Team%'
--cc3.title like '%Asset Management : Risk Self Assesment (Q2 2023) - BAMSH'
--select * from mbeat_summary_course_report mscr where uu.name like '%Prayoga%'
group by cc3.id, cc3.title,cc5.title, cc6.title,qq2.title,  qq.title, qq.max_attempt, cc3.created, cc3.modified, cc3.is_active order by cc3.created desc;



