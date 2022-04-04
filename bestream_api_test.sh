#!/bin/bash
TOP_DIR=${PWD}
export PATH=${PATH}:${TOP_DIR}/api_sh

# unset apis
# apis="${apis}$(ls -1 ${TOP_DIR}/api_sh)"

# echo -e "${apis}" | tr ' ' '\n'

export BASE_URL="https://bestream-api.com/api/v1"                        
export HEADER_CLIENT_KEY="CLIENT-KEY:DvbzjZagSY3aRiG5LDRH"
export HEADER_CONTENT_TYPE="Content-Type:application/x-www-form-urlencoded"
export CURL_CMD="curl -X GET"
TODAY=`date +%m-%d`
OUTPUT=${TOP_DIR}/out/${TODAY}


# curl -X GET https://reqbin.com/echo/get/json -H "X-Powered-By: ReqBin HTTP Client" 
# response=$(curl -X GET "https://bestream-api.com/api/v1/contextual/themes" -H "CLIENT-KEY:DvbzjZagSY3aRiG5LDRH" -H "Content-Type:application/x-www-form-urlencoded")   


# resp=$(curl -X GET "https://bestream-api.com/api/v1/track/search?type=TRACK&query=bang" -H "CLIENT-KEY:DvbzjZagSY3aRiG5LDRH" -H "Content-Type:application/x-www-form-urlencoded")
# echo $response | json_pp > contextual_themes.json
# echo $resp | json_pp > search_track.json

do_check_file() 
{
    if [ -f "$1" ];then
        rm -f $1
    else
        touch $1
    fi
}


do_check_outdir() 
{
    if [[ -d ${OUTPUT} ]]
    then
        echo "${OUTPUT} exists on your filesystem."
    else
        echo "${OUTPUT} is not exists on your filesystem."
        mkdir -p ${OUTPUT}
    fi
}


# 3.2 Contextual Theme
do_contextual_themes()
{
    TITLE="3.2 Contextual Theme"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    PATH_URL="/contextual/themes"
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    # response=$(curl -v -X GET "${BASE_URL}/contextual/themes" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    # response=$(curl -X GET "https://bestream-api.com/api/v1/contextual/themes" -H "CLIENT-KEY:DvbzjZagSY3aRiG5LDRH" -H "Content-Type:application/x-www-form-urlencoded")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}

# 3.3 PL Theme Endpoint
do_pl_themes()
{
    TITLE="3.3 PL Theme Endpoint"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local PATH_URL="/contextual/plThemes/themeId?themeId=TM001"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
    echo ""
}

# 3.4 Smart PlayList Endpoint
# 3.4.1 By PL Theme ID
do_smartplaylist_plthemeid()
{
    TITLE="3.4 Smart PlayList Endpoint\n3.4.1 By PL Theme ID"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"    
    local PATH_URL="/contextual/smartPlayList/plThemeId?ids=PL001"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}

# 3.4.2 By Podcast Series ID
do_smartplaylist_podcastcategoryid()
{
    TITLE="3.4 Smart PlayList Endpoint\n3.4.2 By Podcast Series ID"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local PATH_URL="/contextual/smartPlayList/podcastCategoryId?ids=90272"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}   
}

# 3.5 Music Playback Endpoint
do_playback_music()
{
    TITLE="3.5 Music Playback Endpoint"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local PATH_URL="/playback/music?tidalTrackId=199197493"
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}

# 3.6 Aod Playback Endpoint
do_playback_aod()
{
    TITLE="3.6 Aod Playback Endpoint"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}

    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local PATH_URL="/playback/aod?seriesId=GA0000N000002h2"
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}

# 3.7 Track Endpoint
do_track_search()
{
    TITLE="3.7 Track Endpoint"
    TYPE=$1
    QUERY_STR=$2
    LIMIT=3
    OUTPUT_FILE=${FUNCNAME}_${TYPE}_${QUERY_STR}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local PATH_URL="/track/search?type=${TYPE}&query=${QUERY_STR}&limit=${LIMIT}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}

# 3.8 Aod Categories Endpoint
do_aod_categories()
{
    TITLE="3.8 Aod Categories Endpoint"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local QUERY="/aod/categories"
    response=$(curl -X GET "${BASE_URL}${QUERY}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}

# 3.9 Aod Series Endpoint
do_aod_series()
{
    TITLE="3.9 Aod Series Endpoint"
    DESCID=$1
    OUTPUT_FILE=${FUNCNAME}_${DESCID}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    
    local QUERY="/aod/series?descriptorId=${DESCID}"    
    echo "curl -X GET \"${BASE_URL}${QUERY}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${QUERY}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}

# 3.10 Aod Episodes Endpoint
do_aod_episode()
{
    TITLE="3.10 Aod Episodes Endpoint"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local QUERY="/aod/episode?seriesId=GA0000N000002h2"
    response=$(curl -X GET "${BASE_URL}${QUERY}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}

# 3.11 Send Personality Data Endpoint
do_custom_personalization()
{
    TITLE="3.11 Send Personality Data Endpoint"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local QUERY="/custom/personalization?eventType=user_select_track&contentType=music&contentId=GN4K7CK2A9FMNZS"
    echo "curl -X GET \"${BASE_URL}${QUERY}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${QUERY}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}


# Genre
# do_genres()
# {
#     TITLE="do_genres"
#     OUTPUT_FILE=${FUNCNAME}.json
#     echo "${TITLE} ${FUNCNAME} ===========================================" > ${OUTPUT}/${OUTPUT_FILE}
#     # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
#     local QUERY="/custom/personalization?eventType=user_select_track&contentType=music&contentId=GN4K7CK2A9FMNZS"
#     echo "curl -X GET \"${BASE_URL}${QUERY}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
#     response=$(curl -X GET "${BASE_URL}${QUERY}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
#     #echo $test_response | grep "status"
#     echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
# }


# https://bestream-api.com/api/v1/location/recordingImage


do_test()
{
    echo "output $OUTPUT"
    echo "aaaa" > $OUTPUT/aaa.json
    echo "bbbb" >> $OUTPUT/aaa.json
    echo "${FUNCNAME}"
    OUTPUT_FILE=${FUNCNAME}.json
    echo "file = ${OUTPUT_FILE}"
}


# # Additional test
# do_track_search_artist()
# {
#     TITLE="3.7 Track Endpoint"
#     OUTPUT_FILE=${FUNCNAME}.json
#     echo "${TITLE} ${FUNCNAME} ===========================================" > ${OUTPUT}/${OUTPUT_FILE}
#     # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
#     local QUERY="/track/search?type=ARTIST&query=Dark&limit=2"
#     echo "curl -X GET \"${BASE_URL}${QUERY}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
#     response=$(curl -X GET "${BASE_URL}${QUERY}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
#     #echo $test_response | grep "status"
#     echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
# }


# do_track_search_album()
# {
#     TITLE="3.7 Track Endpoint"
#     OUTPUT_FILE=${FUNCNAME}.json
#     echo "${TITLE} ${FUNCNAME} ===========================================" > ${OUTPUT}/${OUTPUT_FILE}
#     # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
#     local QUERY="/track/search?type=ALBUM&query=Bang&limit=2"
#     echo "curl -X GET \"${BASE_URL}${QUERY}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
#     response=$(curl -X GET "${BASE_URL}${QUERY}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
#     #echo $test_response | grep "status"
#     echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
# }



do_bad_request()
{
    TITLE="Bad Request"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local QUERY="/aod/episode?seId=GA0000N000002h2"
    response=$(curl -X GET "${BASE_URL}${QUERY}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}



do_()
{
    TITLE="Bad Request"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local QUERY="/aod/episode?seId=GA0000N000002h2"
    response=$(curl -X GET "${BASE_URL}${QUERY}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}





ALL_FUNC=$(compgen -A function)

test_main()
{ 
# do_contextual_themes
# do_pl_themes
# do_smartplaylist_plthemeid
# do_track_search_album
# do_track_search_artist
# do_aod_series
# do_custom_personalization
# echo "func ${ALL_FUNC}"
do_check_outdir
for TEST_FUNC in ${ALL_FUNC[@]}; do
    # echo "This is ${TEST_FUNC}"        
    if [ "${TEST_FUNC}" = "do_aod_series" ]; then
        echo "${TEST_FUNC} level 1"
        ${TEST_FUNC} "90263"
        echo "${TEST_FUNC} level 2"
        ${TEST_FUNC} "90290"
        echo "${TEST_FUNC} level 2"
        ${TEST_FUNC} "90288"
        echo "${TEST_FUNC} level 3"
        ${TEST_FUNC} "90547"
        echo "${TEST_FUNC} level 3"
        ${TEST_FUNC} "90546"
    elif [ "${TEST_FUNC}" = "do_track_search" ]; then
        echo "${TEST_FUNC} TRACK position"
        ${TEST_FUNC} "TRACK" "position"
        echo "${TEST_FUNC} ALBUM Positions"
        ${TEST_FUNC} "ALBUM" "Positions"
        echo "${TEST_FUNC} ARTIST Ariana Grande"
        ${TEST_FUNC} "ARTIST" "Ariana Grande"
        echo "${TEST_FUNC} ARTIST Ari"
        ${TEST_FUNC} "ARTIST" "Ari"
    else
        ${TEST_FUNC}
    fi

done

    # TITLE="3.7 Track Endpoint"
    # TYPE=$1
    # QUERY_STR=$2
    # LIMIT=3


}

test_main