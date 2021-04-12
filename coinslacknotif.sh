#!/bin/sh

 
sendSlackMsg() {
  if [ -z "$SLACK_HOOK" ]
  then
    echo "----------- SLACK_HOOK is required ------------"
  else
    currentDate=$(date '+%d/%m/%Y %H:%M:%S');
    crytpo_name=$(echo $1 | tr a-z A-Z)
    symbol=$(echo $2 | tr a-z A-Z)
    price=$3
    high_24h=$4
    low_24h=$5
    image_url=$6
    binance_link=https://www.binance.com/en/trade/"$symbol"_USDT
    data="{
      \"blocks\": [
        {
          \"type\": \"section\",
          \"block_id\": \"section567\",
          \"text\": {
            \"type\": \"mrkdwn\",
            \"text\": \" *$crytpo_name ($symbol) News* :bar_chart: \n $currentDate \n Price : *$price\$* :  \n *$high_24h\$* :arrow_up:  | *$low_24h\$* :arrow_down:\"
          },
          \"accessory\": {
            \"type\": \"image\",
            \"image_url\": \"$image_url\",
            \"alt_text\": \"Ajouté une image\"
          }
        },
      ],
      \"text\":\"$crytpo_name ($symbol) News :bar_chart:\",
      \"attachments\": [
        {
          \"text\": \"For more details\",
          \"fallback\": \"You are unable to choose a game\",
          \"callback_id\": \"wopr_game\",
          \"color\": \"#3AA3E3\",
          \"attachment_type\": \"default\",
          \"actions\": [
            {
              \"name\": \"Go to binance\",
              \"text\": \"Go to binance\",
              \"style\": \"primary\",
              \"type\": \"button\",
              \"value\": \"Check on binance\",
              \"url\": \"$binance_link\",
            },
          ],
        }
      ],    
    }"
    curl -X POST -H 'Content-type: application/json' --data "$data" $SLACK_HOOK
  fi
}

firstArrayValue() {
  echo $1 | jq -r '.[]'
}

getFieldValue() {
  object=$1
  field=$2
  # example price=$(getFieldValue "$res" "current_price")
  echo $1 | jq -r ".$2"
}


add="${1#*=}"


res=$(curl -s https://api.coingecko.com/api/v3/coins/markets\?vs_currency\=usd\&ids\=$1)
res=$(firstArrayValue $res)

price=$(getFieldValue "$res" "current_price")
symbol=$(getFieldValue "$res" "symbol")
image_url=$(getFieldValue "$res" "image")
high_24h=$(getFieldValue "$res" "high_24h")
low_24h=$(getFieldValue "$res" "low_24h")

crypto_name=$1
echo "--- price : $price ---"
echo "--- image_url : $image_url ---"
echo "--- high_24h : $high_24h ---" 
echo "--- low_24h : $low_24h ---"
echo "--- symbol : $symbol ---"

sendSlackMsg $crypto_name $symbol $price $high_24h $low_24h $image_url


