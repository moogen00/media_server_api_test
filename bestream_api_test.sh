#!/bin/bash
TOP_DIR=${PWD}
export PATH=${PATH}:${TOP_DIR}/api_sh

# unset apis
# apis="${apis}$(ls -1 ${TOP_DIR}/api_sh)"

# echo -e "${apis}" | tr ' ' '\n'

export BASE_URL="https://bestream-api.com/api/v1"                        
export HEADER_USER_TOKEN="USER-TOKEN:demo@obigo.com"
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

# curl -X GET "https://bestream-api.com/api/v1/track/search?type=TRACK&query=bang" -H "CLIENT-KEY:DvbzjZagSY3aRiG5LDRH" -H "Content-Type:application/x-www-form-urlencoded"


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
do_3_2_contextual_themes()
{
    # # fullname="USER INPUT"
    # read -p "Enter fullname: " fullname
    # # user="USER INPUT"
    # read -p "Enter user: " user

    # echo "fullname = ${fullname}"
    # echo "user = ${user}"

    TITLE="3.2 Contextual Theme"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    PATH_URL="/contextual/themes"
    echo "============================================================"
    echo "TITLE = ${TITLE} End Point = ${PATH_URL}"
    echo ""
    # echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    # echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    echo "============================================================"
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
    # read -p "Do you read result? (Y/N): " confirm 
    # && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] && || echo "exit" && exit 1 
}

# 3.3 PL Theme Endpoint
do_3_3_pl_themes()
{
    TITLE="3.3 PL Theme Endpoint"
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    THEMES="TM001 TM002 TM003 TM004 TM005 TM006 TM007 TM008 TM009 TM011"
    for TID in $THEMES
    do
        PATH_URL="/contextual/plThemes/themeId?themeId=$TID"
        echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
        response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
        #echo $test_response | grep "status"
        OUTPUT_FILE=${FUNCNAME}_${TID}.json
        do_check_file ${OUTPUT}/${OUTPUT_FILE}
        echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
        echo ""
    done
}

# 3.4 Smart PlayList Endpoint
# 3.4.1 By PL Theme ID
do_smartplaylist_plthemeid()
{
    TITLE="3.4 Smart PlayList Endpoint\n3.4.1 By PL Theme ID"
    PLTHEMEID=$1
    OUTPUT_FILE=${FUNCNAME}_${PLTHEMEID}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"    
    local PATH_URL="/contextual/smartPlayList/plThemeId?ids=${PLTHEMEID}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}

# 3.4.2 By Podcast Series ID
do_smartplaylist_podcastcategoryid()
{
    TITLE="3.4 Smart PlayList Endpoint\n3.4.2 By Podcast Series ID"
    CATEGORY_ID=$1
    OUTPUT_FILE=${FUNCNAME}_${CATEGORY_ID}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local PATH_URL="/contextual/smartPlayList/podcastCategoryId?ids=${CATEGORY_ID}"
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
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
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
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}

# 3.6 Aod Playback Endpoint
do_playback_aod_offset0_limit10()
{
    TITLE="3.6 Aod Playback Endpoint"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}

    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local PATH_URL="/playback/aod?seriesId=GA0000N000002h2&limit=10&offset=0"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}


# 3.6 Aod Playback Endpoint
do_playback_aod_offset5_limit10()
{
    TITLE="3.6 Aod Playback Endpoint"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}

    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local PATH_URL="/playback/aod?seriesId=GA0000N000002h2&limit=10&offset=5"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
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
    local PATH_URL="/aod/categories"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
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
    
    local PATH_URL="/aod/series?descriptorId=${DESCID}"    
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}

# 3.10 Aod Episodes Endpoint
do_aod_episode()
{
    TITLE="3.10 Aod Episodes Endpoint"
    SERIES_ID=$1
    OUTPUT_FILE=${FUNCNAME}_${SERIES_ID}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local PATH_URL="/aod/episode?seriesId=${SERIES_ID}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}

# 3.11 Send Personality Data Endpoint
do_custom_personalization()
{
    TITLE="3.11 Send Personality Data Endpoint"
    EVENT_TYPE=$1
    CONTENT_TYPE=$2
    CONTENT_ID=$3
    PLTHEME_ID=$4
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
    local PATH_URL="/custom/personalization?eventType=${EVENT_TYPE}&contentType=${CONTENT_TYPE}&contentId=${CONTENT_ID}&plThemeId=${PLTHEME_ID}"
    echo "HEADER_USER_TOKEN = ${HEADER_USER_TOKEN}"
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"    
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_USER_TOKEN\" -H \"$HEADER_CONTENT_TYPE\"" >> ${OUTPUT}/${OUTPUT_FILE}
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
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
    local PATH_URL="/aod/episode?seId=GA0000N000002h2"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
    #echo $test_response | grep "status"
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}



# do_()
# {
#     TITLE="Bad Request"
#     OUTPUT_FILE=${FUNCNAME}.json
#     do_check_file ${OUTPUT}/${OUTPUT_FILE}
#     echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
#     # test_response="{\"timestamp\":1647253879743,\"status\":400,\"error\":\"Bad Request\",\"path\":\"/api/v1/contextual/themes"\}"
#     local QUERY="/aod/episode?seId=GA0000N000002h2"
#     response=$(curl -X GET "${BASE_URL}${QUERY}" -H "$HEADER_CLIENT_KEY" -H "$HEADER_CONTENT_TYPE")
#     #echo $test_response | grep "status"
#     echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
# }


# smartplaylist_genre_category
do_smartplaylist_genre_category()
{
    TITLE="smartplaylist_genre_category"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/genre_category"
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}


# smartplaylist_genre_category
do_smartplaylist_mood_category()
{
    TITLE="smartplaylist_mood_category"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/mood_category"
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}
}


# curl –X GET
# “https://bestream-api.com/api/v1/custom/contextual?weather=cloudy&dayOfWeek=monday&tim
# eOfDay=10:00&temperature=29c&destination=home&traffic=heavy”



do_custom_contextual() 
{
    TITLE="custom_contextual"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/custom/contextual?weather=cloudy&dayOfWeek=monday&timeOfDay=10:00&temperature=29c&destination=home&traffic=heavy"
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}


# 3.13 Personal Smart PlayList Endpoint
# v1/contextual/smartPlayList/personal/plThemeIds
do_contextual_smartPlayList_personal_plThemeIds() 
{
    IDS=$1    
    TITLE="custom_contextual"
    OUTPUT_FILE=${FUNCNAME}_${IDS}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/contextual/smartPlayList/personal/plThemeIds?ids=${IDS}"
    echo "HEADER_USER_TOKEN = ${HEADER_USER_TOKEN}"
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_USER_TOKEN\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_USER_TOKEN}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}


# 3.14 3.14 Personal Aod PLTheme Endpoint
# /v1/contextual/aod/personal
do_contextual_aod_personal_themeIds() 
{
    IDS=$1    
    TITLE="contextual_aod_personal"
    OUTPUT_FILE=${FUNCNAME}_${IDS}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/contextual/aod/personal?themeId=${IDS}"
    echo "HEADER_USER_TOKEN = ${HEADER_USER_TOKEN}"
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_USER_TOKEN\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_USER_TOKEN}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}



do_smartplaylist_search_name_track() 
{
    PARAM=$1    
    TITLE="search"
    OUTPUT_FILE=${FUNCNAME}_${PARAM}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/searchName/track?param=${PARAM}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}


do_smartplaylist_search_name_album() 
{
    PARAM=$1    
    TITLE="search"
    OUTPUT_FILE=${FUNCNAME}_${PARAM}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/searchName/album?param=${PARAM}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}


do_smartplaylist_search_name_artist() 
{
    PARAM=$1    
    TITLE="search"
    OUTPUT_FILE=${FUNCNAME}_${PARAM}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/searchName/artist?param=${PARAM}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}


# /v1/smartplaylist/searchId/track/album GN82N8B2V1Z20MJ

do_smartplaylist_search_id_track_album() 
{
    PARAM=$1    
    TITLE="search"
    OUTPUT_FILE=${FUNCNAME}_${PARAM}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/searchId/track/album?param=${PARAM}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}


# /v1/smartplaylist/searchId/track/artist GN0AH22ZGPYGQA2

do_smartplaylist_search_id_track_artist() 
{
    PARAM=$1    
    TITLE="search"
    OUTPUT_FILE=${FUNCNAME}_${PARAM}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/searchId/track/artist?param=${PARAM}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}

# smartplaylist/searchId/track/album
do_smartplaylist_search_id_album_track() 
{
    PARAM=$1    
    TITLE="search"
    OUTPUT_FILE=${FUNCNAME}_${PARAM}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/searchId/album/track?param=${PARAM}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}

# /smartplaylist/searchId/album/artist
do_smartplaylist_search_id_album_artist() 
{
    PARAM=$1    
    TITLE="search"
    OUTPUT_FILE=${FUNCNAME}_${PARAM}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/searchId/album/artist?param=${PARAM}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}


# /smartplaylist/searchId/artist/track
do_smartplaylist_search_id_artist_track() 
{
    PARAM=$1    
    TITLE="search"
    OUTPUT_FILE=${FUNCNAME}_${PARAM}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/searchId/artist/track?param=${PARAM}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}


# /smartplaylist/searchId/artist/album
do_smartplaylist_search_id_artist_album() 
{
    PARAM=$1    
    TITLE="search"
    OUTPUT_FILE=${FUNCNAME}_${PARAM}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/searchId/artist/album?param=${PARAM}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}





# 3.17 Smart PlayList By Genre Endpoint
# /v1/smartplaylist/genre/playlist?categoryId
do_smartplaylist_genre_playlist_categoryid() 
{
    CATEGORY_ID=$1    
    SORT_TYPE=$2
    LIMIT=$3
    TITLE="Smart PlayList By Genre Endpoint"
    OUTPUT_FILE=${FUNCNAME}_${CATEGORY_ID}_${SORT_TYPE}_${LIMIT}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/genre/playlist?categoryId=${CATEGORY_ID}&sortType=${SORT_TYPE}&limit=${LIMIT}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}


# 3.18 Smart PlayList By Mood Endpoint
# /v1/smartplaylist/mood/playlist?categoryId
do_smartplaylist_mood_playlist_categoryid() 
{
    CATEGORY_ID=$1    
    SORT_TYPE=$2
    LIMIT=$3
    TITLE="Smart PlayList By Genre Endpoint"
    OUTPUT_FILE=${FUNCNAME}_${CATEGORY_ID}_${SORT_TYPE}_${LIMIT}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/mood/playlist?categoryId=${CATEGORY_ID}&sortType=${SORT_TYPE}&limit=${LIMIT}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}



# 3.21 Aod Series Search Endpoint 1
# /v1/aod/series/person
do_aod_series_person() 
{
    CREDIT_NAME=$1    
    CATEGORY_ID=$2    
    TITLE="3.21 Aod Series Search Endpoint person"
    OUTPUT_FILE=${FUNCNAME}_${CREDIT_NAME}_${CATEGORY_ID}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/aod/series/person?param=${CREDIT_NAME}&categories=${CATEGORY_ID}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}


# 3.21 Aod Series Search Endpoint 2
# /v1/aod/series/title
do_aod_series_title() 
{
    SERIES_TITLE=$1    
    CATEGORY_ID=$2    
    TITLE="3.21 Aod Series Search Endpoint title"
    OUTPUT_FILE=${FUNCNAME}_${SERIES_TITLE}_${CATEGORY_ID}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/aod/series/title?param=${SERIES_TITLE}&categories=${CATEGORY_ID}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}  




# 3.22 Aod Episode Search Endpoint 1
# /v1/aod/episodes/person
do_aod_episode_person() 
{
    CREDIT_NAME=$1    
    CATEGORY_ID=$2    
    TITLE="3.22 Aod Episode Search Endpoint person"
    OUTPUT_FILE=${FUNCNAME}_${CREDIT_NAME}_${CATEGORY_ID}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/aod/episodes/person?param=${CREDIT_NAME}&categories=${CATEGORY_ID}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}


# 3.22 Aod Episode Search Endpoint 2
# /v1/aod/episodes/title
do_aod_episode_title() 
{
    EPISODE_TITLE=$1    
    CATEGORY_ID=$2    
    TITLE="3.22 Aod Episode Search Endpoint title"
    OUTPUT_FILE=${FUNCNAME}_${EPISODE_TITLE}_${CATEGORY_ID}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/aod/episodes/title?param=${EPISODE_TITLE}&categories=${CATEGORY_ID}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}  





# 3.23 Image Search Endpoint 1
# /v1/location/artistImage
do_location_artistImage() 
{
    NAME=$1    
    TITLE="3.23 Image Search Endpoint artistImage"
    OUTPUT_FILE=${FUNCNAME}_${NAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/location/artistImage?name=${NAME}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}  



# 3.23 Image Search Endpoint 2
# /v1/location/recordingImage
do_location_recordingImage() 
{
    NAME=$1    
    TITLE="3.23 Image Search Endpoint recordingImage"
    OUTPUT_FILE=${FUNCNAME}_${NAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/location/recordingImage?name=${NAME}"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
}  


# 3.15 Genre Category Endpoint
# /v1/smartplaylist/genre_category
do_get_genre_category() 
{    
    TITLE="3.15 Genre Category Endpoint"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/genre_category"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
    echo $response | json_pp >> ${OUTPUT}/${OUTPUT_FILE}    
} 


# 3.16 Mood Category Endpoint
# /v1/smartplaylist/mood_category
do_get_mood_category() 
{    
    TITLE="3.16 Mood Category Endpoint"
    OUTPUT_FILE=${FUNCNAME}.json
    do_check_file ${OUTPUT}/${OUTPUT_FILE}
    echo "${TITLE} ${FUNCNAME} ===========================================" >> ${OUTPUT}/${OUTPUT_FILE}
    PATH_URL="/smartplaylist/mood_category"    
    echo "HEADER_CLIENT_KEY = ${HEADER_CLIENT_KEY}"
    echo "HEADER_CONTENT_TYPE = ${HEADER_CONTENT_TYPE}"
    echo "curl -X GET \"${BASE_URL}${PATH_URL}\" -H \"$HEADER_CLIENT_KEY\" -H \"$HEADER_CONTENT_TYPE\""
    response=$(curl -X GET "${BASE_URL}${PATH_URL}" -H "${HEADER_CLIENT_KEY}" -H "${HEADER_CONTENT_TYPE}")
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

# echo "function = $(declare -F)"




########################################################
# INDEX=0

# array=()
# IFS=$'\n'
# for f in $(declare -F); do
# #    echo "${f:11}"
#    array+=("${f:11}")
#    # echo ${INDEX}_${f:11}
#    let INDEX=${INDEX}+1
# done
# # echo "array[*] = ${array[*]}"

# PS3='Please enter your choice: '
# select opt in ${array[@]}
# do
#     case $opt in
#         *)
#         $opt
#         ;;
#     esac
# done
########################################################



for TEST_FUNC in ${ALL_FUNC[@]}; do
    # echo "This is ${TEST_FUNC}"        
    if [ "${TEST_FUNC}" = "do_aod_series" ]; then
        echo "${TEST_FUNC} level 1"
        ${TEST_FUNC} "90263"
        echo "${TEST_FUNC} level 2"
        ${TEST_FUNC} "90277"
        # echo "${TEST_FUNC} level 2"
        # ${TEST_FUNC} "90288"
        # echo "${TEST_FUNC} level 3"
        # ${TEST_FUNC} "90547"
        # echo "${TEST_FUNC} level 3"
        # ${TEST_FUNC} "90546"
    elif [ "${TEST_FUNC}" = "do_track_search" ]; then
        echo "${TEST_FUNC} TRACK position"
        ${TEST_FUNC} "TRACK" "position"
        echo "${TEST_FUNC} ALBUM Positions"
        ${TEST_FUNC} "ALBUM" "Positions"
        echo "${TEST_FUNC} ARTIST Ariana Grande"
        ${TEST_FUNC} "ARTIST" "Ariana"
        echo "${TEST_FUNC} ARTIST Ari"
        ${TEST_FUNC} "ARTIST" "Ari"
        echo "${TEST_FUNC} ARTIST Paul"
        ${TEST_FUNC} "ARTIST" "Paul"
    elif [ "${TEST_FUNC}" = "do_smartplaylist_plthemeid" ]; then
        echo "${TEST_FUNC} PL007  ========="
        ${TEST_FUNC} "PL007"
        echo "${TEST_FUNC} PL008  ========="
        ${TEST_FUNC} "PL008"
        echo "${TEST_FUNC} PL009  ========="
        ${TEST_FUNC} "PL009"
    elif [ "${TEST_FUNC}" = "do_custom_personalization" ]; then
        # select music
        echo "${TEST_FUNC} user_select_track music GNFTDQVWKBSZR6K PL007"
        ${TEST_FUNC} "user_select_track" "music" "GNFTDQVWKBSZR6K" "PL007"

        echo "${TEST_FUNC} user_select_track aod GA0000N000000NS PL007"
        ${TEST_FUNC} "user_select_track" "aod" "GA0000N000000NS" "PL007"
        
        echo "${TEST_FUNC} user_select_track aod GA0000N000000P0 PL007"
        ${TEST_FUNC} "user_select_track" "aod" "GA0000N000000P0" "PL007"
        # echo "${TEST_FUNC} user_select_track GNFTDQVWKBSZR6K PL007"
        # ${TEST_FUNC} "user_select_track" "GNFTDQVWKBSZR6K" "PL007"
        # echo "${TEST_FUNC} user_select_track GNFTDQVWKBSZR6K PL007"
        # ${TEST_FUNC} "user_select_track" "GNFTDQVWKBSZR6K" "PL007"
        # echo "${TEST_FUNC} user_select_track GNFTDQVWKBSZR6K PL007"
        # ${TEST_FUNC} "user_select_track" "GNFTDQVWKBSZR6K" "PL007"
    elif [ "${TEST_FUNC}" = "do_contextual_smartPlayList_personal_plThemeIds" ]; then
        echo "${TEST_FUNC} PL007  ========="
        ${TEST_FUNC} "PL007"
        echo "${TEST_FUNC} PL008  ========="
        ${TEST_FUNC} "PL008"
        echo "${TEST_FUNC} PL009  ========="
        ${TEST_FUNC} "PL009"        
    elif [ "${TEST_FUNC}" = "do_smartplaylist_search_name_track" ]; then
        ${TEST_FUNC} "savages" 
    elif [ "${TEST_FUNC}" = "do_smartplaylist_search_name_album" ]; then
        ${TEST_FUNC} "Catch" 
    elif [ "${TEST_FUNC}" = "do_smartplaylist_search_name_artist" ]; then
        ${TEST_FUNC} "Paul"
    elif [ "${TEST_FUNC}" = "do_smartplaylist_search_id_track_album" ]; then
        ${TEST_FUNC} "GN82N8B2V1Z20MJ"
    elif [ "${TEST_FUNC}" = "do_smartplaylist_search_id_track_artist" ]; then
        ${TEST_FUNC} "GN0AH22ZGPYGQA2"        

    elif [ "${TEST_FUNC}" = "do_smartplaylist_search_id_album_track" ]; then
        ${TEST_FUNC} "GN1ZNP8P02KB13B"        
    elif [ "${TEST_FUNC}" = "do_smartplaylist_search_id_album_artist" ]; then
        ${TEST_FUNC} "GN12EW2MCSHPP2R"
    elif [ "${TEST_FUNC}" = "do_smartplaylist_search_id_artist_track" ]; then
        ${TEST_FUNC} "GN1ZNP8P02KB13B"        
    elif [ "${TEST_FUNC}" = "do_smartplaylist_search_id_artist_album" ]; then
        ${TEST_FUNC} "GN2NBD1MV953H0G"
    elif [ "${TEST_FUNC}" = "do_contextual_aod_personal_themeIds" ]; then
        echo "${TEST_FUNC} TM001  ========="
        ${TEST_FUNC} "TM001"
        echo "${TEST_FUNC} TM002  ========="
        ${TEST_FUNC} "TM002"
        echo "${TEST_FUNC} TM003  ========="
        ${TEST_FUNC} "TM003"
    elif [ "${TEST_FUNC}" = "do_smartplaylist_podcastcategoryid" ]; then
        echo "${TEST_FUNC} 90279  ========="
        ${TEST_FUNC} "90279"
        echo "${TEST_FUNC} 90265  ========="
        ${TEST_FUNC} "90265"
        echo "${TEST_FUNC} 90271  ========="
        ${TEST_FUNC} "90271"
    elif [ "${TEST_FUNC}" = "do_aod_episode" ]; then
        echo "${TEST_FUNC} GA0000N000000RZ  ========="
        ${TEST_FUNC} "GA0000N000000RZ"
        echo "${TEST_FUNC} GA0000N000000Rt  ========="
        ${TEST_FUNC} "GA0000N000000Rt"
        echo "${TEST_FUNC} GA0000N000000RR  ========="
        ${TEST_FUNC} "GA0000N000000RR"
    elif [ "${TEST_FUNC}" = "do_smartplaylist_genre_playlist_categoryid" ]; then
        echo "${TEST_FUNC} 36053 popularity 3 ========="
        ${TEST_FUNC} "36053" "popularity" "3"
        echo "${TEST_FUNC} 36053 recent 3 ========="
        ${TEST_FUNC} "36053" "recent" "3"                            
    elif [ "${TEST_FUNC}" = "do_smartplaylist_mood_playlist_categoryid" ]; then
        echo "${TEST_FUNC} 36053 popularity 3 ========="
        ${TEST_FUNC} "36053" "popularity" "3"
        echo "${TEST_FUNC} 36053 recent 3 ========="
        ${TEST_FUNC} "36053" "recent" "3" 
    elif [ "${TEST_FUNC}" = "do_aod_series_person" ]; then
        echo "${TEST_FUNC} Conan 90280 ========="
        ${TEST_FUNC} "Conan" "90280" 
    elif [ "${TEST_FUNC}" = "do_aod_series_title" ]; then
        echo "${TEST_FUNC} History 90280 ========="
        ${TEST_FUNC} "History" "90280" 
    elif [ "${TEST_FUNC}" = "do_aod_episode_person" ]; then
        echo "${TEST_FUNC} Conan 90280 ========="
        ${TEST_FUNC} "Conan" "90280" 
    elif [ "${TEST_FUNC}" = "do_aod_episode_title" ]; then
        echo "${TEST_FUNC} History 90280 ========="
        ${TEST_FUNC} "History" "90280"         
    elif [ "${TEST_FUNC}" = "do_location_artistImage" ]; then
        echo "${TEST_FUNC} floris ========="
        ${TEST_FUNC} "floris"
    elif [ "${TEST_FUNC}" = "do_location_recordingImage" ]; then
        echo "${TEST_FUNC} Ride Home ========="
        ${TEST_FUNC} "Ride Home"
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



