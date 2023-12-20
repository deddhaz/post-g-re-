--select * from certificates_certificate cc 
select 

uu.username,
uu.first_name,
cu.id,
cc.name,
cc2.title,
cu.completion_date
from certificates_usercertificate cu
left join users_user uu on uu.id = cu.user_id
left join certificates_certificate cc on cc.id = cu.certificate_id
left join contents_course cc2 on cc2.id = cu.content_id and cu.content_type_id = (select id from django_content_type where app_label='contents' and model='course')

/*where 	
(uu.username = '009132' or 
uu.username =	'077080'	or
uu.username =	'054610'	or
uu.username =	'026085'	or
uu.username =	'090767'	or
uu.username =	'063898'	or
uu.username =	'071681'	or
uu.username =	'067283'	or
uu.username =	'079156'	or
uu.username =	'087414'	or
uu.username =	'013757'	or
uu.username =	'082213'	or
uu.username =	'087793'	or
uu.username =	'072787'	or
uu.username =	'077627'	or
uu.username =	'051151') and cc2.title like '%(BMDP)%'	*/


