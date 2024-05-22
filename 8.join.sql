-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
select * from post inner join author on author.id  = post.author_id;
select * from author a inner join post p on a.id = p.author_id;

-- 글쓴이가 있는 글 목록과, 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents, a.email from post p 
inner join author a on p.author_id = a.id;

-- 모든 글 목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력
select p.id, p.title, p.contents, a.email from post p 
left outer join author a on p.author_id = a.id;

-- join된 상황에서의 where 조건: on 뒤에 where 조건이 나옴
-- 1) 글쓴이가 있는 글 중에 글의 title과 저자의 email을 출력,
--    저자의 나이는 25세 이상인 글만 출력
select p.title, a.email from post p
inner join author a on p.author_id = a.id
where a.age >= 25;


-- 2) 모든 글 목록 중에 글의 title과 저자가 있다면 email을 출력,
--    2024-05-01 이후에 만들어진 글만 출력
select p.title, a.email from post p
left join author a on p.author_id = a.id
where p.created_time >= '2024-05-01';

-- 조건에 맞는 도서와 저자 리스트 출력
SELECT b.BOOK_ID, a.AUTHOR_NAME, date_format(b.PUBLISHED_DATE, '%Y-%m-%d')
from BOOK b inner join AUTHOR a
on a.AUTHOR_ID = b.AUTHOR_ID
where b.CATEGORY = "경제"
order by b.PUBLISHED_DATE; 

-- union: 중복 제외한 두 테이블의 select를 결합
-- 컬럼의 개수와 타입이 같아야함에 유의
-- union all: 중복 포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from table2;
-- author 테이블의 name,email 그리고 post 테이블의 title, contents union
select name, email from author union select title, contents from post;

-- 유지보수성: 서비스를 유지하고, 서비스를 고치고
-- 코드의 간결성과 직관성


-- 서브쿼리: select문 안에 또 다른 select문을 서브쿼리라 한다.
-- select절 안에 서브쿼리
-- author email 과 해당 author가 쓴 글의 개수를 출력
select email, (select count(*) from post p where p.author_id = a.id) as count
from author a;

-- from 절 안에 서브쿼리
select a.name from(select * frin author) as a;

-- where 절 안에 서브쿼리
select a.* from author a inner join post p on a.id = p.author_id;

select * from author where id in (select author_id from post);

-- 없어진 기록 찾기 문제:
-- join으로 풀 수 있는 문제, 서브쿼리로도 풀어보면 좋음
-- left join 활용
SELECT ao.ANIMAL_ID, ao.NAME from ANIMAL_OUTS ao left join ANIMAL_INS ai
on ao.ANIMAL_ID = ai.ANIMAL_ID
where ai.ANIMAL_ID is null order by ao.ANIMAL_ID;

-- 서브쿼리 활용
SELECT ANIMAL_ID, NAME from ANIMAL_OUTS ao 
where ANIMAL_ID NOT IN(select ANIMAL_ID FROM ANIMAL_INS)
order by ANIMAL_ID;

-- 집계함수
SELECT COUNT(*) from author; -- = COUNT(id)도 동일(row의 값)
select sum(price) from post;
select round(avg(price), 0) from post;

-- group by와 집계함수
select author_id from post group by author_id;
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price), round(avg(price), 0),
min(price), max(price)
from post group by author_id;

-- 저자 email, 해당 저자가 작성한 글 수를 출력
select a.id, if(p.id is null, 0, count(*)) from author a
left join post p on a.id = p.author_id group by a.id;

-- where와 group by
-- 연도별 post 글 출력, 연도가 null인 데이터는 제외
select date_format(created_time, '%Y'), count(*)
from post
where created_time is not null
group by date_format(created_time, '%Y');

-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기

-- 입양 시각 구하기
SELECT date_format(DATETIME, '%H') as HOUR, COUNT(*) as COUNT
from ANIMAL_OUTS
where date_format(DATETIME, '%H:%i') between '09:00' and '19:59'
group by HOUR
order by HOUR;

-- HAVING: group by를 통해 나온 통계에 대한 조건
select author_id, count(*)
from post
group by author_id

-- 글을 2개 이상 쓴 사람에 대한 통계정보
select author_id, count(*) as count
from post
group by author_id
having count >= 2;

-- (실습) 포스팅 price가 2000원 이상인 글을 대상으로 
-- 작성자별로 몇 건인지와 평균 price를 구하되, 
-- 평균 price가 3000원 이상인 데이터를 대상으로만 통계 출력
select author_id ,round(AVG(price),0) as avg_price
from post
where price >= 2000
group by author_id
having avg_price >= 3000;

-- 동명 동물 수 찾기
SELECT NAME, COUNT(NAME) as COUNT 
from ANIMAL_INS
group by NAME
having COUNT >= 2
order by NAME;

-- (실습) 2건 이상의 글을 쓴 사람의 email, 글의 수 구할건데
-- 나이는 25세 이상인 사람만 통계에 사용하고, 
-- 가장 나이 많은 사람 1명의 통계를 출력하시오
select a.id, count(a.id) as count
from author a inner join post p
on a.id = p.author_id
where a.age >= 25
group by a.id
having count >= 2
order by MAX(a.age) desc limit 1;

-- 다중열 group by
select author_id, title, count(*)
from post
group by author_id, title;

-- 재구매가 일어난 상품과 회원 리스트 구하기
SELECT USER_ID, PRODUCT_ID
from ONLINE_SALE
group by USER_ID, PRODUCT_ID
having count(*) >= 2
order by USER_ID, PRODUCT_ID desc;
