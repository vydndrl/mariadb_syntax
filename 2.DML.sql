-- insert into : 데이터 삽입
insert into 테이블명(컬럼1, 컬럼2, 컬럼3) values(데이터1, 데이터2, 데이터3);

-- id, name, email -> author 1건 추가
insert into author(id, name, email) values(1, 'hongildong', 'hong@naver.com');

-- select : 데이터 조회, * : 모든 컬럼 조회
select * from author;

-- id, title, content, author_id -> posts에 1건 추가
insert into posts(id, title, content, author_id) values (1, 'hello', 'hello world', 1);
select * from posts;

-- 테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'posts';

-- insert 문을 통해 author 데이터 4개정도 추가, post 데이터 5개 정도 추가(1개 정도는 익명)

-- update 테이블명 set 컬럼명1 = 데이터1, 컬럼명2 = 데이터2  where id = 1;
-- where 문을 빠트리게 될 경우, 모든 데이터에 update 문이 실행됨에 유의
update author set name = 'abc', email = 'abc@test.com' where id=1;
update author set email = 'abc@test.com' where id=2;

-- delete from 테이블명 where 조건
-- where 조건이 생략 될 경우 모든 데이터가 삭제됨에 유의
delete from author where id = 5;

-- SELECT의 다양한 조회 방법
select * from author;
select * from author where id = 1;
select * from author where id > 2;
select * from author where id > 2 and name = 'lee';


-- 특정 컬럼만을 조회할 때
select name, email from author where id = 3;

-- 중복 제거하고 조회
select title from post;
select distinct title from post;

-- 정렬 : order by, 데이터의 출력 결과를 특정 기준으로 정렬
-- 아무런 정렬 조건 없이 조회 할 경우에는 pk 기준으로 오름차순 정렬
-- asc : 오름차순, desc : 내림차순
select * from author order by name asc;

-- 멀티 컬럼 order by : 여러 컬럼으로 정렬, 먼저 쓴 컬럼 우선 정렬, 중복 시 그 다음 정렬 옵션 적용
select * from post order by title; -- asc/desc 생략 시 오름차순
select * from post order by title, id desc;

-- limit number : 특정 숫자로 결과값 제한
select * from author order by id desc limit 1;

-- alias(별칭)을 이용한 select : as 키워드 사용
select name as 이름, email as 이메일 from author;
select a.name as 이름, a.email as 이메일 from author as a;

-- null을 조회 조건으로
select * from post where author_id is null;
select * from post where author_id is not null;

-- 여러 기준으로 정렬하기

-- 상위 n개 레코드