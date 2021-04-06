set -eux

CITY=Shenzhen
LANGUAGE="zh-CN"
UNIT=m
UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36"

curl \
  -H "Accept-Language: $LANGUAGE" \
  -H "User-Agent: $UA" \
  -o result.html \
  wttr.in/$CITY?format=4\&$UNIT

# be careful, the character is "`" that is under Esc 
CONTENT=`cat ./result.html`
echo "$CONTENT"
DINGTALK_URL="https://oapi.dingtalk.com/robot/send?access_token=88ea3f462739b17d396294f350b4472a369a903a2a081d67032087268e30b857"

function sendDingTalk(){
    curl "$DINGTALK_URL" -H 'Content-Type: application/json' -d "{
        \"msgtype\": \"text\",
        \"text\": {\"content\": \"早上好，又是新的一天，$CONTENT\"},
    }"
}
# execute function
sendDingTalk $CONTENT
