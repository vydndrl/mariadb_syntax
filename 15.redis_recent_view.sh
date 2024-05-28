
while true; do
    # 사용자가 product를 입력할 때 마다, 현재 시간을 score로 해서 zadd
    echo "원하는 상품 입력 또는 나가기(exit)"
    read product
    if [ "$product" == "exit" ]; then
        echo "나갑니다."
        break
    fi
    timestamp=$(date +%s)
    redis-cli zadd recent:products $timestamp $product
done

echo "사용자의 최근 본 상품목록 5개: "
redis-cli -h localhost -p 6379 zrevrange recent:products 0 4