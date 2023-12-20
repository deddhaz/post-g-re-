

select  

--qq3.user_id as "Userid",
--qq3.id as "Session ID",
--uu.username as "NIK",
--uu.first_name as "Name",

cc.title as "course title",
qq3.created as "tanggal dibuat",
qq3.title as "Title Quiz",
--max (qq3.score) as "Score",
qq3.max_attempt as "max attemp",
--qq2.question_id as "Question ID",
--qq3.code as "Quiz_Type",
qq2.text as "Pertanyaan (Soal)",
--case when qq.is_answer is true then qq.text end as "Jawaban User",
--qq.correct_answer as "benar/ salah",
(case when qa.correct_answer is true then qa.text end) as "Jawaban Benar"
--qq.answer_id as "Answer ID",
--qq3.quiz_id as "Quiz_ID"

--qa.text as "Jawaban Benar",
--case when qa.correct_answer is true then qa.text end as "Jawaban Benar",

from quizzes_quizanswersession qq
join quizzes_quizquestionsession qq2 on qq2.id = qq.quiz_question_session_id
join quizzes_quizsession qq3 on qq3.id = qq2.quiz_session_id
join quizzes_answer qa on qa.question_id = qq2.question_id 
join quizzes_quiz qq4 on qq4.id = qq3.quiz_id 
join users_user uu on uu.id = qq3.user_id 
join contents_course cc ON cc.id  = qq3.content_id and qq3.content_type_id = (select id from django_content_type where app_label='contents' and model='course') 
--join quizzes_quizquestionresult qq3 on qq3.answer_id = qq.answer_id 
--join quizzes_quizquestionsession qq2 
where qq.is_answer is true and qq3.code  = 'Post Test' and cc.is_active is true /*and qq3.id ='1614533'*/ and qa.text is not null and qa.correct_answer is true and 
cc.title = 'Risk Self Assesment (RSA) : HCBP Head - SK Talent Management' or 
uu.username != '083277'  and 
uu.username != '071751'-- and uu.first_name like '%Nurul%'--
--and qq3.score = (select max(qq3.score) from quizzes_quizsession q5 where qq3.id = qq5.id)
group by cc.id , qq3.id , qq3.quiz_id , uu.username,  uu.first_name , cc.title, qq3.created, qq3.title , qq3.max_attempt, qq2.text , qq.is_answer , qa.correct_answer, qq.text, qa."text", qq3.code , qq.correct_answer  , qq3.score
--order by qq3.score, qq3.title desc	