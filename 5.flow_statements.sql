-- 흐름제어 : case문
select 컬럼1, 컬럼2, 컬럼3
case 컬럼4
    when [비교값1] then 결과값1
    when [비교값2] then 결과값2
    else 결과값3
end
from 테이블명;

-- post 테이블에서 1번 user는 first author, 2번 user는 second author
select id, title, contents,
case
    when 1 then 'first author'
    when 2 then 'second author'
    else 'others'
end
from post;

-- author_id가 있으면 그대로 출력 else author_id, 
-- 없으면 '익명사용자로' 출력 되도록 post테이블 조회
select id, title, contents,
case
    when author_id is null then 'anonymous'
    else author_id
end as author_id
from post

-- 위 케이스문을 ifnull 구문으로 변환
select id, title, contents, IFNULL(post.author_id, 'anonymous') from post;

-- if문 구문으로 변환
select id, title, contents, IF(author_id = 1, 'first user', 'others' )
from post;

-- 조건에 부합하는 중고거래 상태 조회하기
SELECT BOARD_ID, WRITER_ID, TITLE, PRICE, 
case STATUS
    when 'SALE' then '판매중'
    when 'RESERVED' then '예약중'
    when 'DONE' then '거래완료'
end as STATUS
from USED_GOODS_BOARD 
where CREATED_DATE = '2022-10-05'
order by BOARD_ID desc;

-- 12세 이하인 여자 환자 목록 출력하기
SELECT PT_NAME,	PT_NO, GEND_CD, AGE ,IFNULL(TLNO, 'NONE') from PATIENT
where GEND_CD = 'W' and AGE <= 12 
order by age desc, PT_NAME;