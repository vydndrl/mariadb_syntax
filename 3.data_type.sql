-- tinyint는 -128 ~ 127 까지 표현
-- author 테이블에 age 컬럼 추가
alter table author add column age tinyint;

-- insert 시에 age : 200 -> 125
insert into(id,email,age) values(5, 'hello@naver.com', 130); -- 오류
alter table author modify column age tinyint unsigned;

-- decimal 실습
alter table post add column price decimal(10,3);
describe post;

-- decimal 소수점 초과 값 입력 후 짤림 확인
insert into post(id, title, price) values (9,'hello Java', 3.123123);

-- update : price를 1234.1
update post set price = 1234.1 where id = 9;

-- blob 바이너리 데이터 실습
-- author 테이블에 profile_image 컬럼을 blob 형식으로 추가
alter table author add column profile_image longblob;
insert into author(id, email, profile_image) values(9, 'sky@naver.com', LOAD_FILE('C:\\test_pic.jpeg'));

-- enum : 삽입될 수 있는 데이터 종류를 한정하는 데이터 타입
-- role 컬럼
alter table author add column role enum('user', 'admin') not null default 'user';

-- enum 컬럼 실습 테스트
-- user1을 insert => 에러
-- user 또는 admin insert => 정상

-- date 타입
-- author 테이블에 birth_day 컬럼을 date로 추가
-- 날짜 타입의 insert는 문자열 형식으로 insert
alter table author add column birth_day date;
insert into author(id, email, birth_day) values(12, 'hello@naver.com', '1999-05-01');

-- datetime 타입
-- author, post 둘 다 datetime으로 created_timme 컬럼 추가
alter table author add column created_timme datetime default current_timestamp;
alter table post add column created_timme datetime;
insert into author(id, email) values(14, 'hello11@naver.com');
insert into post(id, title) values(13, 'hello hi');
alter table author modify column created_time datetime default current_timestamp;

-- 비교연산자
select * from post where id >= 2 && id <= 4;
select * from post where id < 2 || id > 4;
select * from post where !(id < 2 || id > 4);

-- NULL 인지 아닌지
select * from post where contents is null;
select * from post where contents is not null;

-- in(리스트형태), not in(리스트형태)
select * from post where id in(1,2,3,4);
select * from post where id not in(1,2,3,4);

-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '%o'; -- o로 끝나는 title 검색
select * from post where title like 'h%'; -- h로 시작하는 title 검색
select * from post where title like 'h%'; -- 단어의 중간에 llo라는 키워드가 있는 경우 검색
select * from post where title not like '%o'; -- o로 끝나는 title이 아닌 title 검색

-- ifnull(a,b) : 만약에 a가 null이면 b 반환, null이 아니면 a 반환
select title, contents, ifnull(author_id, '익명') as 저자 from post;

-- REGEXP : 정규표현식을 활용한 조회
select * from author where name regexp '[a-z]';
select * from author where name regexp '[가-힣]';

-- 날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜
-- CATS와 CONVERT
select cast(20200101 as date);
select cast('20200101' as date);
select CONVERT(20200101, date);
select CONVERT('20200101', date);

-- datetime 조회 방법
select * from post where created_time like '2024-02%';
select * from post where created_time <= '2024-12-31' and created_time >= '1999-01-01';
select * from post where created_time between '1999-01-01' and '2024-12-31';

-- date_format
select date_format(created_time, '%Y-%m') from post;
select cast(date_format(created_time, '%m') as unsigned) from post; -- 05 -> 5로 나옴

-- post를 조회할 때 date_format을 활용하여 2024년 데이터 조회, 결과는 *
select * from post where date_format(created_time, '%Y') = '2024';

-- 오늘 날짜
now()