select 
uu.username,
de.Name,
de.JobTitle,
de.WorkLocation,
de.Area,
de.Region,
de.[Resign Date],
cu.id,
cc.name,
cc2.title as "Nama Program",
cu.completion_date as "Certificate Completion Date"
from certificates_usercertificate cu
left join UsersMbeat uu on uu.id = cu.user_id
left join DataEmployee de on de.NIK = uu.username
left join certificates_certificate cc on cc.id = cu.certificate_id
left join ContentsCourse2 cc2 on cc2.id = cu.content_id and cu.content_type_id = (select id from django_content_type where app_label='contents' and model='course')
order by cu.completion_date desc