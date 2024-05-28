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
# 1번 author 회원 정보 조회
# select name, email, age from author where id=1;
# 위 데이터의 결과값을 redis로 캐싱: json 데이터 형식으로 저장
set user:1:detail "{\"name\":\"hong\", \"email\":\"hong@naver.com\", \"age\":30}"

# list
# redis의 list는 java의 deque와 같은 구조 즉, double-ended queue 구조

# 데이터 왼쪽 삽입
LPUSH key value
# 데이터 오른쪽 삽입
RPUSH key value
# 데이터 왼쪽부터 꺼내기
LPOP key
# 데이터 오른쪽부터 꺼내기
RPOP key

lpush hongildongs hong1
lpush hongildongs hong2
lpush hongildongs hong3
lpop hongildongs

# 꺼내서 없애는게 아니라, 꺼내서 보기만
lrange hongildongs -1 -1
lrange hongildongs 0 0 

# 데이터 개수 조회
llen key
llen hongildongs

# list의 요소 조회시에는 범위 지정
lrange hongildongs 0 -1  # 처음부터 끝까지
lrange hongildongs start end   # (인덱스 번호)

# TTL 적용
expire hongildongs 30
# TTL 조회 
ttl hongildongs

# pop과 push 동시에
# A리스트에서 pop하여 B리스트 push
RPOPLPUSH A리스트 B리스트


# 최근 방문한 페이지
# 5개 정도 데이터 push
# 최근 방문한 페이지 3개 정도만 보여주는
lpush pages page1
lpush pages page2
lpush pages page3
lpush pages page4
lpush pages page5

lrange pages 0 2

# 위 방문페이지를 5개에서 뒤로가기 앞으로가기 구현
# 뒤로가기 페이지를 누르면 뒤로가기 페이지가 뭔지 출력
# 다시 앞으로가기 누르면 앞으로 간 페이지가 뭔지 출력
RPUSH forwards page1
RPUSH forwards page2
RPUSH forwards page3
RPUSH forwards page4
RPUSH forwards page5
lrange forwards -1 -1
RPOPLPUSH forwards backwards

# set 자료구조
# set 자료구조에 멤버 추가

sadd members member1
sadd members member2
sadd members member1

# set 조회
smembers members

# set에서 멤버 삭제
srem members member2

# set멤버 개수 반환
scard members

# 특정 멤버가 set 안에 있는지 존재 여부 확인
sismember members member3

# 매일 방문자수 계산
sadd visit:2024-05-27 hong1@naver.com

# zset(sorted set)
zadd zmembers 3 member1
zadd zmembers 4 member2
zadd zmembers 1 member3
zadd zmembers 2 member4

# score 기준 오름차순 정렬
zrange zemebers 0 -1
# score 기준 내림차순 정렬
zrevrange zmembers 0 -1

# zset 삭제
zrem zmembers member2

# zrank는 해당 멤버가 index 몇 번째인지 출력
zrank zmembers member2

# 최근 본 상품목록 => sorted set (zset)을 활용하는 것이 적절
zadd recnet:products 192411 apple
zadd recnet:products 192413 apple
zadd recnet:products 192415 banana
zadd recnet:products 192420 orange
zadd recnet:products 192425 apple
zadd recnet:products 192430 apple



# hashes
# 해당 자료구조에서는 문자, 숫자가 구분
hset product:1 name "apple" price 1000 stock 50
hget product:1 price
# 모든 객체값 get
hgetall product:1
# 특정 요소 값 수정
hset product:1 stock 40

# 특정 요소의 값을 증가
hincrby product:1 stock 5
hget product:1 stock

# 특정 요소의 값을 감소
hincrby product:1 stock -5
hget product:1 stock