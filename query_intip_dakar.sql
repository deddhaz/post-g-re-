--create or replace view mbeat_summary_course_report as

select uu.username as "NIK", uu.mobile_number as "HP", uu.first_name as "Nama",user_ca.jg as "JG", user_ca.jabatan as "Jobtitle", user_ca.dt_join as "Join Date", user_ca.work_location as "Work Location",user_ca.area as "Area", user_ca.region as "Regional"

from users_user uu 
LEFT JOIN ( SELECT uca.user_id,
			max(
                CASE
                    WHEN uca.attribute::text = 'jg'::text THEN uca.attribute_value
                    ELSE NULL::character varying
                END::text) AS jg,

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
                    where user_ca.jabatan like '%HCBP%' order by 3 desc


          
/*select * from users_user uu
where uu.username = '099872'
select * from contents_course cc 
order by created desc*/

