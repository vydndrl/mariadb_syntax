-- not null 조건 추가
alter table 테이블명 modify column 컬럼명 타입 not null;

-- auto_increment
alter table author modify column id bigint auto_increment;
alter table post modify column id bigint auto_increment;

-- author.id에 제약조건 추가 시 fk로 인해 문제 발생 시
-- fk 먼저 제거 이후에 author.id에 제약 조건 추가
select * from information_schema.key_column_usage where table_name = 'post';

-- 삭제 
alter table post drop foreign key post_ibfk_1

-- 삭제 된 제약 조건 다시 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id);

-- uuid
alter table post add column user_id char(36) default (UUID()); 

-- pk, fk, unique -> 자동으로 index가 생성 -> 목차 페이지 (검색 성능을 높일 수 있음)

-- unique 제약 조건
alter table author modify column email varchar(255) unique;

-- on delete cascade 테스트 -> 부모 테이블의 id를 수정하면? 수정 안 됨
-- 삭제
alter table post drop foreign key post_author_fk;
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade;

-- (실습) delete는 set null, update cascade
alter table post drop foreign key post_author_fk;
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete set null on update cascade;
