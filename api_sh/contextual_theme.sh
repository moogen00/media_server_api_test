#!/bin/bash
   
# HTTP_CODE=$(curl --write-out "%{http_code}\n" "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22" --output output.txt --silent)
# HTTP_CODE=$(curl -X GET https://bestream-api.com/api/v1/contextual/themes -H CLITNET-KEY:DvbzjZagSY3aRiG5LDRH -H Content-Type:application/x-www-form-urlencoded)
# TEST="curl -X POST --header "$H1" --header "$H2" --header "$H3" -d @s_100mb.xml "$URL"
# response=$(curl -X GET -H "CLITNET-KEY:DvbzjZagSY3aRiG5LDRH" -H "Content-Type:application/x-www-form-urlencoded" -d @s_100mb.xml "https://bestream-api.com/api/v1/contextual/themes")
# response=$(curl -X GET -H "CLITNET-KEY:DvbzjZagSY3aRiG5LDRH" -H "Content-Type:application/x-www-form-urlencoded" "https://bestream-api.com/api/v1/contextual/themes")
# echo $response




# curl -X GET https://reqbin.com/echo/get/json -H "X-Powered-By: ReqBin HTTP Client" 
response=$(curl -X GET "https://bestream-api.com/api/v1/contextual/themes" -H "CLIENT-KEY:DvbzjZagSY3aRiG5LDRH" -H "Content-Type:application/x-www-form-urlencoded")   


resp=$(curl -X GET "https://bestream-api.com/api/v1/track/search?type=TRACK&query=bang" -H "CLIENT-KEY:DvbzjZagSY3aRiG5LDRH" -H "Content-Type:application/x-www-form-urlencoded")
echo $response | json_pp > contextual_themes.json
echo $resp | json_pp > search_track.json