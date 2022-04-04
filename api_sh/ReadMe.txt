문의 하신 내용 정리해서 전달 드립니다. 

1.Bestream API - Track Endpoint(3.7)에 "artists", "albums" Type은 응답이 없음                                                                                      

    artists와 albums 에 대해서도 동작 가능하게 추가 개발 하였으며 호출 방식은 BeStream API Release 1.1 문서 내용과 동일 합니다
    (artists 및 album은 각각 track검색 과 리턴 값이 상이하므로 호출 후 확인 필수)

2.Bestream API  문서에 "장르를 통한 음악 리스트 검색" 없음 

 2-1 장르 카테고리 검색

curl –X GET

“https://bestream-api.com/api/v1/genres”

–H “CLIENT-KEY : <client-key>”

-H "Content-Type: application/x-www-form-urlencoded"

 2-2 장르를 이용한 음악 검색 (장르 카테고리에서 도출된 값을 바탕으로 호출) 

curl –X GET

“https://bestream-api.com/api/v1/genres/{genreCategoryName}/tracks”

–H “CLIENT-KEY : <client-key>”

-H "Content-Type: application/x-www-form-urlencoded"

3.Bestream API  문서에 "이미지 URL 조회" 기능 없음 (API 초기 문서에는 없었으나, 고객사에서 Nice To have 기능으로 판단함)

  3-1 아티스트 이미지 검색

curl –X GET

“https://bestream-api.com/api/v1/location/artistImage?name=floris ”

–H “CLIENT-KEY : <client-key>”

-H "Content-Type: application/x-www-form-urlencoded"

   3-2 앨범 이미지 검색

curl –X GET

“https://bestream-api.com/api/v1/location/recordingImage?name=Ride Home ”

–H “CLIENT-KEY : <client-key>”

-H "Content-Type: application/x-www-form-urlencoded"

