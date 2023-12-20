select 

de.NIK as 'NIK',
de.Name as 'Nama',
cu.id as 'Certificate ID',
cc.name 'Certificate Name',
cc2.title 'Training Name'

from certificates_usercertificate cu
left join UsersMbeat um on um.id = cu.user_id
left join DataEmployee de on de.NIK = um.username
left join certificates_certificate cc on cc.id = cu.certificate_id
left join ContentsCourse2 cc2 on cc2.id = cu.content_id and cu.content_type_id = (select id from django_content_type where app_label='contents' and model='course')
