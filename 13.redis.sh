sudo apt-get install redis-server
redis-server --version

# 레디스 접속
# cli: commandline interface
redis-cli

# redis는 0~15번까지의 database 구성
# 데이터베이스 선택
select 번호(0번 default)

# 데이터베이스 내 모든 키 조회
keys *

# 일반 String 자료구조
# key:value 값 세팅
# key값은 중복되면 안 됨
SET key(키) value(값)
set test_key1 test_value1
set user:email:1 hongildong@naver.com
# set 할 때 key 값이 이미 존재하면 덮어쓰기 되는 것이 기본
# 맵 저장소에서 key 값은 유일하게 관리가 되므로
# nx: not exist (key가 존재하지 않는 경우에만 set)
set user:email:1 hongildong2@naver.com nx
# ex(만료시간: 초 단위) - ttl
set user:email:2 hong2@naver.com ex 20

# get을 통해 value값 얻기
get test_key1

# 특정 key 삭제
del user:email:1

# 현재 데이터베이스 모든 key값 삭제
flushdb

# 좋아요 기능 구현
set likes:posting:1 0
incr likes:posting:1 # 특정 key 값의 value를 1만큼 증가
decr likes:posting:1

# 재고 기능 구현
set product:1:stock 100
decr product:1:stock 
get product:1:stock 

# bash 쉘을 활용하여 재고 감소 프로그램 작성