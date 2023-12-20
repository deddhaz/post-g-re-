--create or replace view mbeat_summary_course_report as



select uu.username as "NIK",/* uu.id as "User_ID",*/ uu.first_name as "Nama", user_ca.jabatan as "Jobtitle", user_ca.dt_join as "Join Date", user_ca.work_location as "Work Location",user_ca.area as "Area", user_ca.region as "Regional", 
cc4.title as "Kategori",

case when max(case when qq.code = 'Post Test' then to_char(qq.created,'Month YYYY')
end) is null then '-' else max(case when qq.code = 'Post Test' then to_char(qq.created,'Month YYYY')
end)::text end as "Access Period",
--cc3.title as "Sub Kategori",
cc.title as "Course Title", --cc.id as "Course ID",
--case when cc.title like '%GLP%' or cc.title like '%GPOP%' then 'Mandatory' else 'Non Mandatory' end as "Category",

case when max(case when qq.quiz_id = qq2.id and qq.code = 'Pre Test' and cc.id = qq.content_id and qq.content_type_id = (select id from django_content_type where app_label='contents' and model='course') then (qq.score)
end) is null then '-' else max(case when qq.quiz_id = qq2.id and qq.code = 'Pre Test' and cc.id = qq.content_id and qq.content_type_id = (select id from django_content_type where app_label='contents' and model='course') then (qq.score)
end)::text end as "Pre Test",

case when max(case when qq.code = 'Pre Test' then qq.created
end) is null then '-' else max(case when qq.code = 'Pre Test' then qq.created
end)::text end as "Tanggal (Pre Test)",

--case when max(case when qq.title like '%(Pre Test)' then qq.created end) is null then 'ddmmyy' else max(case when qq.title like '%(Pre Test)' then qq.created end) end as "Tanggal (Pre Test)",

case when max(case when qq.quiz_id = qq2.id and qq.code = 'Post Test' and cc.id = qq.content_id and qq.content_type_id = (select id from django_content_type where app_label='contents' and model='course') then (qq.score)
end) is null then '-' else max(case when qq.quiz_id = qq2.id and qq.code = 'Post Test' and cc.id = qq.content_id and qq.content_type_id = (select id from django_content_type where app_label='contents' and model='course') then (qq.score)
end)::text end as "Post Test",

--case when qq.code = 'Post Test' then qq.created end as "tanggal",

case when max(case when qq.code = 'Post Test' then to_char(qq.created, 'MM/DD/YYYY : HH:MI')
end) is null then '-' else max(case when qq.code = 'Post Test' then to_char(qq.created, 'MM/DD/YYYY | HH:MI')
end)::text end as "Tanggal (Post Test)",

case when max(case when qq.quiz_id = qq2.id and qq.code = 'Post Test' and cc.id = qq.content_id and qq.content_type_id = (select id from django_content_type where app_label='contents' and model='course') then qq.score else null end) is null then 'Tidak Post Test' else 
     case when max(case when qq.quiz_id = qq2.id and qq.code = 'Post Test' and cc.id = qq.content_id and qq.content_type_id = (select id from django_content_type where app_label='contents' and model='course') then qq.score else null end) >= 70 then 'Lulus' else 'Belum Lulus'
     end 
end as "Status",

coalesce(sum(case when qq.quiz_id = qq2.id and qq.code = 'Post Test' and cc.id = qq.content_id and qq.content_type_id = (select id from django_content_type where app_label='contents' and model='course') then 1
end), 0) as "Num of Attempt (Post Test)"

/*case when max(case when qq.quiz_id = qq2.id and qq.code = 'Post Test' and cc.id = qq.content_id and qq.content_type_id = (select id from django_content_type where app_label='contents' and model='course') then qq.score end) is null then 0 else 1 
end AS "Is Participant"*/

from quizzes_quizsession qq
left join contents_course cc on cc.id = qq.content_id and qq.content_type_id = (select id from django_content_type where app_label='contents' and model='course')
left join quizzes_quiz qq2 on qq2.id = qq.quiz_id
left join users_user uu on uu.id = qq.user_id
LEFT JOIN ( SELECT uca.user_id,
            max(
                CASE
                    WHEN uca.attribute::text = 'work_location'::text THEN uca.attribute_value
                    ELSE NULL::character varying
                END::text) AS work_location,
            max(
                CASE
                    WHEN uca.attribute::text = 'dt_join'::text THEN uca.attribute_value
                    ELSE NULL::character varying
                END::text) AS dt_join,
                          
            max(
                CASE
                    WHEN uca.attribute::text = 'section'::text OR uca.attribute::text = 'section'::text THEN uca.attribute_value
                    ELSE NULL::character varying
                END::text) AS section,
            max(
                CASE
                    WHEN uca.attribute::text = 'Area'::text OR uca.attribute::text = 'area'::text THEN uca.attribute_value
                    ELSE NULL::character varying
                END::text) AS area,
            max(
                CASE
                    WHEN uca.attribute::text = 'region'::text OR uca.attribute::text = 'area'::text THEN uca.attribute_value
                    ELSE NULL::character varying
                END::text) AS region,
            max(
                CASE
                    WHEN uca.attribute::text = 'job_title'::text THEN uca.attribute_value
                    ELSE NULL::character varying
                END::text) AS jabatan
           FROM ( SELECT u.id AS user_id,
                    cat.name AS attribute,
                        CASE
                            WHEN cat.type_value::text = 'Char'::text THEN cav.char_value
                            WHEN cat.type_value::text = 'Integer'::text THEN cav.integer_value::character varying
                            WHEN cat.type_value::text = 'Boolean'::text THEN cav.boolean_value::character varying
                            WHEN cat.type_value::text = 'Date'::text THEN cav.date_value::character varying
                            WHEN cat.type_value::text = 'Datetime'::text THEN cav.datetime_value::character varying
                            WHEN cat.type_value::text = 'Choice'::text THEN relation.name
                            ELSE NULL::character varying
                        END AS attribute_value
                   FROM custom_attribute_customattributevalue cav
                     JOIN custom_attribute_customattribute cat ON cat.id = cav.attribute_id
                     JOIN django_content_type contenttype ON cav.model_applied_id = contenttype.id
                     JOIN users_user u ON u.id = cav.model_id
                     LEFT JOIN custom_attribute_customattributevaluerelation relation ON relation.attribute_id = cat.id AND relation.id = cav.choice_value_id
                  WHERE contenttype.model::text = 'user'::text
                  ORDER BY u.username) uca
          GROUP BY uca.user_id) user_ca ON user_ca.user_id = uu.id
left join contents_coursecollection cc2 on cc2.course_id = cc.id
left join contents_collection cc3 on cc3.id = cc2.collection_id 
left join contents_channel cc4 on cc4.id = cc3.channel_id 

where cc.is_active is true and
--qq.created >= to_char(CURRENT_DATE - '4 mons'::interval, 'YYYY/MM/01'::text)::date and
--'Tanggal (Post Test)' >= '2023' and 
--uu.first_name = '%Prayoga%'and
--uu.username ='096124' and
uu.username not like 'mbeat%' and
cc.title != 'Trial Quiz Mixed' and
cc.title != 'Trial : Quiz' and
cc.title != 'Dummy : Quiz' and
cc.title not like '2gen%' and --uu.username = '5001091'
cc.title not like '3gen%' and 
cc.title not like '2spc%' and 
cc.title not like '3spc%' and 
cc.title not like '2SPC%' and
cc.title like '%GPOP%'or 
cc.title like '%GREAT Pe%' or 
cc.title like '%GLP 1%' and
uu.username != '06478' and
uu.username != '7002565' and\\\\\\\\\\\\\\\\\\\\\\\\\
uu.username != '86168' and
uu.username != '89928' and
uu.username != '91228' and
uu.username != 'bfi-admin'
group by uu.first_name, uu.username, user_ca.dt_join, cc.title, cc4.title, cc3.title, cc.id, user_ca.jabatan, user_ca.work_location,user_ca.area,user_ca.region--qq.created--, qq.code
order by 12 desc

/*select * from contents_coursecollection cc2 
select * from collec
select * from contents_course cc 
select * from contents_collection cc 
select * from contents_channel cc */