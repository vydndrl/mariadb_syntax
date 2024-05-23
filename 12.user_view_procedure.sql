-- 사용자 관리
-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
create user 'test1'@'localhost' identified by '4321';

-- 사용자에게 권한 부여
grant select on board.author to 'test1'@'localhost';

-- 사용자 권한 회수
revoke select on board.author to 'test1'@'localhost';

-- 권한 조회
show grants for 'test1'@'localhost'

-- 환경설정을 변경 후 확정
flush privileges

-- test1으로 로그인 후에
select * from board.author;

-- 사용자 계정 삭제
drop user 'test1'@'localhost';


-- view
-- view 생성 
create view author_for_marketing_team as 
select name, age, role from author;

-- view 조회
select * from author_for_marketing_team;

-- view에 권한부여
grant select on board.author_for_marketing_team to ...;

-- view 변경(대체)
create or replace view author_for_marketing_team as
select name, email, age, role from author;

-- view 삭제
drop view author_for_marketing_team;



-- 프로시저 생성
DELIMITER //
create procedure test_procedure()
begin
    select 'hello world'
END
// DELIMITER ;

-- 프로시저 호출
call test_procedure();

-- 프로시저 삭제
drop procedure test_procedure;

-- 게시글 목록 조회 프로시저 생성
DELIMITER //
create procedure 게시글목록조회()
begin
    select * from post;
END
// DELIMITER ;

call 게시글목록조회();

-- 게시글 단건 조회
DELIMITER //
create procedure 게시글단건조회(in 저자id int, in 제목 varchar(255))
begin
    select * from post where author_id = 저자id and title = 제목;
END
// DELIMITER ;

call 게시글단건조회(4, 'hello');

-- 글쓰기 : title, contents, 저자ID
DELIMITER //
create procedure 글쓰기(in titleIn varchar(255),
in contentsIn varchar(255), in authorId int)
begin
    insert into post(title, contents, author_id) values (title = titleIn, contents = contentsIn, author_id = authorId);
END
// DELIMITER ;

call 글쓰기('Hi Hello Good', 'Hi Hi Hi', 45);

-- 글쓰기 : title, contents, email

DELIMITER //
 CREATE PROCEDURE 글쓰기2(in title varchar(255), in contents varchar(255), in emailinput varchar(255))
    BEGIN
        declare authorId int;
        select id into authorId from author where email = emailInput;
        insert into post(title, contents, author_id) values (title, contents, authorId);
        END
//DELIMITER ;

call 글쓰기2('Hi Hello Good', 'Hi Hi Hi', 'lee@naver.com');

-- sql에서 문자열 합치는 concat('hello', 'world');
-- 글 상세 조회: input 값이 postId
-- title, contents, '홍길동' + '님'

DELIMITER //
 CREATE PROCEDURE 글상세조회(in postId int)
 BEGIN
     declare authorName varchar(255);
     select name into authorName from author where id = (select author_id from post where id = postId);
     set authorName = concat(authorName, '님');
     select title, contents, authorName from post where id = postId;

end
//DELIMITER ;

-- 등급조회
-- 글을 100개 이상 쓴 사용자는 고수입니다. 출력
-- 10개이상 100개 미만이면 중수입니다.
-- 그 외는 초보 입니다.
-- input값: email값.

DELIMITER //
 CREATE PROCEDURE 등급조회(in emailInput varchar(255))
 BEGIN
     declare authorId int;
     declare count int;
     select id into authorId from author where email = email;
     select count(*) into count from post where author_id = authorId;
     if count >= 100 then
        select '고수입니다.';
    elseif count >= 10 and count < 100 then
        select '중수입니다.';
    else
        select '초보입니다.';
    end if;
end
//DELIMITER ;

-- 반복을 통해 post 대량 생성
-- 사용자가 입력한 반복 횟수에 따라 글이 도배되는데, title은 '안녕하세요.'
DELIMITER //
 CREATE PROCEDURE 글도배(in count int)
 BEGIN
    declare a int default 0;
    WHILE(a < count) DO
        insert into post(title) values('안녕하세요');
        set a = a + 1;
    END WHILE;
end
//DELIMITER ;

call 글도배(5);

-- 프로시저 생성문 조회
show create procedure 프로시저명;

-- 프로시저 권한 부여
grant excute on board.글도배 to 'test1'@'localhost';

