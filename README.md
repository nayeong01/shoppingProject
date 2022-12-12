# 🌳프로젝트 명
```
<영구상점>
 웹 기반 제로웨이스트 제품 판매 플랫폼
'제로'웨이스트로 지구 '구'하기를 의미하는 '영구상점'으로 이름을 지었습니다.
'영구'적으로 사용할 수 있는 제품 판매가 목적인 플랫폼이기에 이중적 의미를 담고 있습니다.
```
# 🌳프로젝트 목적 & 동기
```
- 전세계적 이슈인 환경문제인 쓰레기 배출 감소를 실천할 수 있는 플랫폼을 만들어보자.
- 이곳저곳에서 찾기보다 한 곳에서 손쉽게 검색하고 구매할 수 있게 만들어보자.
- 일상생활에서 쓰레기 배출이 많은 곳을 큰 카테고리로 나눠 한눈에 필요한 제품을 볼 수 있게 만들어보자.
- 사용자와 관리자 페이지를 나눠서 관리할 수 있도록 만들어보자.
```
# 🌳화면구성 & 사용방법(사용자)
```
- login : 로그인을 통해 장바구니, 마이페이지, 제품주문을 사용할 수 있습니다.
(실제 사업자가 아니고 프로젝트로 만들어진 플랫폼이기 때문에 네이버 로그인은 현재 승인이 나지 않았습니다.)
(현재로는 네이버 개발자 센터에서 등록된 아이디로 회원가입, 로그인, 네이버 아이디 연동이 가능합니다.)
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206973803-05b328c9-c687-47d6-bfed-ab5779c78715.png"/>

```
-register : 기본정보와 주문에 사용되는 주소(우편번호, 주소, 상세주소) 3가지로 나눠 등록 가능
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206975523-cc80249d-3e07-4a95-a785-7bbc3d6a7f59.png"/>

```
- search id : 이름과 핸드폰번호를 입력하면 아이디 찾기 가능
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206977420-63b6e38c-a154-4726-a517-b0ac9677abcc.png"/>

```
-search password : 이름과 아이디와 핸드폰번호를 입력하면 임시비밀번호 발급
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206977734-f27d426b-b73f-4e24-bcad-d898f025429d.png"/>

```
- home : 배너화면과 리뷰 점수가 높은순으로 현재 인기품목 확인 가능
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206978434-7d2cfdea-6f61-4ddb-b659-0f57724f18f8.png"/>

```
- category : 원하는 카테고리를 선택하여 카테고리 목록과 제품사진, 평점, 가격을 확인 가능(페이징 기능 구현)
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206979007-313450ee-25b2-406f-8f17-cc8a6fbcee6d.png"/>

```
-search : 원하는 keyword를 검색하면 이름에 keyword가 있는 제품들 검색 가능
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206979460-5742deb3-1cf9-4cd7-9654-d4bac9110409.png"/>

```
-product detail : 제품사진을 클릭하면 제품 사진과, 가격, 상세설명, 리뷰 댓글 작성 가능
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206980328-0a95dcf2-54d5-435e-836b-f9667d8b1317.png"/>

```
review : 구입한 제품의 평점과 댓글 입력 가능 & 자신이 입력한 댓글 수정, 삭제 가능(평점의 평균으로 home에서 인기순 제품이 보이게 됩니다.)
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206981514-be430aba-d50e-4261-878c-0e6e34bf0962.png"/>
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206982029-8b63dbd5-eda9-4998-b2ec-7c48319505c6.png"/>

```
-cart : 원하는 제품을 장바구니 담기 버튼을 클릭하여 장바구니에 담기 가능 & 주문수량 수정 가능 & 장바구니 제품 삭제 가능
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206980930-08106876-bf72-40af-9b10-40446a25642e.png"/>
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206981220-e4572cad-4387-46db-bf8c-619f40528785.png"/>

```
-order : 총 주문 가격과 총 적립 포인트 확인 및 사용, 기존 등록된 회원정보를 기본으로 주문 가능(주소 변경 가능)
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206982872-67f8f0f4-4e2f-47d0-a68e-3edae476f85b.png"/>
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206983100-0fefb7c6-7b0a-4584-970a-eb2be94ed2e1.png"/>

```
-mypage : 현재 주문현황, 주문번호 클릭 시 주문상페이지 확인 가능, 회원정보수정 가능
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206983357-2f482dce-3903-4aa7-a39a-4788438648fc.png"/>
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206983519-5d25c207-ee65-4345-954e-a804892a8f6a.png"/>

# 🌳화면구성 & 사용방법(관리자)
```
-admin page : 관리자페이지 home
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206984666-03221619-c729-48d6-a5cb-8c741e8ce74a.png"/>
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206985823-c2d715b2-090f-43cc-a706-d2279c61dfd7.png"/>

```
-register product : 등록하고 싶은 제품 정보를 입력 후 등록 가능
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206985272-7bed678b-e9c5-4191-a671-aaa24e4ce4d1.png"/>

```
-product list : 등록된 제품 목록 확인 및 검색 가능
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206986409-4495672d-b33a-4dc7-8929-574e397a1638.png"/>

```
-product detail : 등록 제품 상세내용 확인 및 수정 및 삭제 가능
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206987053-704c1674-51a6-47b0-bd3c-0749f7e741c4.png"/>

```
order list : 회원들의 주문 데이터 확인 및 주문 취소 가능
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206987391-4e30f419-0525-4dcb-9875-738c0d2f8909.png"/>

```
member list : 가입회원 확인 및 정보 수정 가능
```
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206987977-371ebc81-d62d-4ab9-aee0-71e9be7ceff6.png"/>
<img width="50%" src="https://user-images.githubusercontent.com/108383043/206988197-225c3ed9-1983-4bc3-bac4-af12f0c35ca5.png"/>

# 🌳개발 환경
```
- Spring framework
- orcle
- Back-end: java, orcle, mybatis, tomcat 
- Front-end: JQuery, JavaScript, Ajax , html, css
```
# 🌳한계점 & 피드백
```
기존에 계획했던 Q&A 게시판, 공지 게시판을 구현하기에 시간이 부족해 만들지 못한 부분이 아쉬웠습니다.
네이버 로그인이 모든 사용자 아이디로 사용이 되지 않는 부분이 아쉬웠습니다. 
(현재 네이버 개발자 센터에서 사업자등록이 안 되어있어 승인이 나지 않아 미리 등록된 아이디만 사용이 가능한 상태입니다.)
팀원과 처음 구상을 할 때 DB 이름을 정확하게 지정하여 시작해야 됨을 프로젝트를 진행하는 중에 인지하였습니다.
제품 사진 등록시, web.xml에 경로를 지정하게 제작을 하였는데, local에선 잘 작동하지만 서버로 이동하니 상대경로로 지정해야함을 깨달았습니다.
local에서뿐만아니라, 서버에서 작동되는 것을 미리 인지하여 제작해야한다는 것을 인지하였습니다.

다음에 아이디어를 생각해 프로젝트를 구상할 땐 이번 피드백을 통해 초기부터 확실하게 구상 & 설계하여 더욱 완벽하게 개발을 완수해보고 싶습니다.

```
# 🌳작성자 정보
```
김나영
olive_yeong@naver.com
```
