/*1. 요구사항 분석
    꽃 테이블과 화분 테이블 2개가 필요하고,
    꽃을 구매할 때 화분도 같이 구매합니다.
    꽃은 이름과 색상, 가격이 있고,
    화분은 제품번호, 색상, 모양이 있습니다.
    화분은 모든 꽃을 담을 수 없고 정해진 꽃을 담아야 합니다.

2. 개념 모델링
	꽃		화분
	--------------
	이름		제품번호
	--------------
	색상		색상
	가격		모양

3. 논리 모델링
	꽃		화분
	--------------
	이름P		제품번호P
	--------------
	색상NN	색상NN
	가격D0	모양NN
			꽃이름 FK
	 
4. 물리 모델링
FLOWER
--------------------------------------------------------------
FLOWER_NAME VARCHAR2(255) CONSTRAINT PK_FLOWER PRIMARY KEY,
----------------------------------------------------------------
FLOWER_COLOR VARCHAR2(255) NOT NULL,
FLOWER_PRICE NUMBER DEFAULT 0

POT
-----------------------------------------------------------------
ID NUMBER CONSTRAINT PK_POT PRIMARY KEY,
-----------------------------------------------------
POT_COLOR VARCHAR2(255) NOT NULL,
POT_SHAPE VARCHAR2(255) NOT NULL,
CONSTRAINT FK_POT_FLOWER FOREIGN KEY(FLOWER_NAME),
REFERENCES TBL_FLOWER(NAME)


5. 구현
*/
CREATE TABLE TBL_FLOWER(
	NAME VARCHAR2(255) CONSTRAINT PK_FLOWER PRIMARY KEY,
	FLOWER_COLOR VARCHAR2(255) NOT NULL,
	FLOWER_PRICE NUMBER DEFAULT 0
);

CREATE TABLE TBL_POT(
	ID NUMBER CONSTRAINT PK_POT PRIMARY KEY,
	POT_COLOR VARCHAR2(255) NOT NULL,
	POT_SHAPE VARCHAR2(255) NOT NULL,
	FLOWER_NAME VARCHAR2(255),
	CONSTRAINT FK_POT_FLOWER FOREIGN KEY(FLOWER_NAME)
	REFERENCES TBL_FLOWER(NAME)
);

/*
1. 요구사항 분석
    안녕하세요, 동물병원을 곧 개원합니다.
    동물은 보호자랑 항상 같이 옵니다. 가끔 보호소에서 오는 동물도 있습니다.
    보호자가 여러 마리의 동물을 데리고 올 수 있습니다.
    보호자는 이름, 나이, 전화번호, 주소가 필요하고
    동물은 병명, 이름, 나이, 몸무게가 필요합니다.

2. 개념 모델링

동물 				보호자				동물병원				동물보호소
--------------------------------------------------------------------------------------------
이름				이름					번호					번호
---------------------------------------------------------------------------------------------
병명				나이					병원이름				주소
나이				전화번호  				동물이름			
몸무게			주소					
보호자이름									
보호소번호										 

3. 논리 모델링

동물 				보호자				동물병원				동물보호소
------------------------------------------------------------------------------------------------
이름	PK			이름	PK				번호	PK				번호	PK
-----------------------------------------------------------------------------------------------------
병명	NN			나이					병원이름 U				주소 NN
나이				전화번호 NN			동물이름 FK			
몸무게 NN			주소	NN				
보호자이름	FK								
보호소번호	FK

4. 물리 모델링

SICK_ANIMAL
----------------------------------------------------------
NAME VARCHAR2(1000) CONSTRAINT PK_SICK_ANIMAL PRIMARY KEY,
-----------------------------------------------------------
DISEASE_NAME VARCHAR2(1000) NOT MULL,
SICK_ANIMAL_AGE NUMBER,
SICK_ANIMAL_WEIGHT NUMBER NOT NULL,
GUARDIAN_NAME VARCHAR2(1000),
CONSTRAINT FK_GUARDIAN_NAME FOREIGN KEY(GUARDIAN_NAME)
REFERENCES TBL_GUARDIAN(NAME),
SHELTER_PHONE_NUMBER VARCHAR2(1000),
CONSTRAINT FK_SHELTER_PHONE_NUMBER FOREIGN KEY(SHELTER_PHONE_NUMBER)
REFERENCES TBL_SHELTER(PHONE_NUMBER)


GUARDIAN
---------------------------------------------------------
NAME VARCHAR2(1000) CONSTRAINT PK_GUARDIAN PRIMARY KEY,
-----------------------------------------------------------
GUARDIAN_AGE NUMBER,
GUARDIAN_PHONE VARCHAR2(1000) NOT NULL,
GUARDIAN_ADRESS VARCHAR2(1000) NOT NULL


ANIMAL_HOSPITAL
----------------------------------------------------------------------
PHONE_NUMBER VARCHAR2(1000) CONSTRAINT PK_ANIMAL_HOSPITAL PRIMARY KEY,
----------------------------------------------------------------------
ANIMAL_HOSPITAL_NAME VARCHAR2(1000) UNIQUE,
SICK_ANIMAL_NAME VARCHAR2(1000),
CONSTRAINT FK_HOSPITAL__ANIMAL_NAME FOREIGN KEY(SICK_ANIMAL_NAME)
REFERENCES TBL_SICK_ANIMAL(NAME)


SHELTER
---------------------------------------------------------------------
PHONE_NUMBER VARCHAR2(1000) CONSTRAINT PK_ANIMAL_SHELTER PRIMARY KEY,
ANIMAL_SHELTER_ADRESS VARCHAR2(1000) NOT NULL

5. 구현
*/

CREATE TABLE TBL_SICK_ANIMAL(
	NAME VARCHAR2(1000) CONSTRAINT PK_SICK_ANIMAL PRIMARY KEY,
	DISEASE_NAME VARCHAR2(1000) NOT NULL,
	SICK_ANIMAL_AGE NUMBER,
	SICK_ANIMAL_WEIGHT NUMBER NOT NULL,
	GUARDIAN_NAME VARCHAR2(1000),
	CONSTRAINT FK_SICK_ANIMAL_GUARDIAN_NAME FOREIGN KEY(GUARDIAN_NAME)
	REFERENCES TBL_GUARDIAN(NAME),
	SHELTER_PHONE_NUMBER VARCHAR2(1000),
	CONSTRAINT FK_SHELTER_PHONE_NUMBER FOREIGN KEY(SHELTER_PHONE_NUMBER)
	REFERENCES TBL_SHELTER(PHONE_NUMBER)
);

CREATE TABLE TBL_GUARDIAN(
	NAME VARCHAR2(1000) CONSTRAINT PK_GUARDIAN PRIMARY KEY,
	GUARDIAN_AGE NUMBER,
	GUARDIAN_PHONE VARCHAR2(1000) NOT NULL,
	GUARDIAN_ADRESS VARCHAR2(1000) NOT NULL
);

CREATE TABLE TBL_ANIMAL_HOSPITAL(
	PHONE_NUMBER VARCHAR2(1000) CONSTRAINT PK_ANIMAL_HOSPITAL PRIMARY KEY,
	ANIMAL_HOSPITAL_NAME VARCHAR2(1000) UNIQUE,
	SICK_ANIMAL_NAME VARCHAR2(1000),
	CONSTRAINT FK_HOSPITAL__ANIMAL_NAME FOREIGN KEY(SICK_ANIMAL_NAME)
	REFERENCES TBL_SICK_ANIMAL(NAME)
);

CREATE TABLE TBL_SHELTER(
	PHONE_NUMBER VARCHAR2(1000) CONSTRAINT PK_ANIMAL_SHELTER PRIMARY KEY,
	ANIMAL_SHELTER_ADRESS VARCHAR2(1000) NOT NULL
);


/*
1. 요구 사항

    커뮤니티 게시판을 만들고 싶어요.
    게시판에는 게시글 제목과 게시글 내용, 작성한 시간, 작성자가 있고,
    게시글에는 댓글이 있어서 댓글 내용들이 나와야 해요.
    작성자는 회원(tbl_user)정보를 그대로 사용해요.
    댓글에도 작성자가 필요해요.


2. 개념 모델링

회원		게시글		댓글
-----------------------------
번호		번호			번호
-----------------------------
아이디	제목			댓글 내용
비밀번호	내용			글 작성자
이름		게시날짜		댓글작성자
주소		작성한회원
이메일
생일
																																																													
																																																
3. 논리 모델링

회원			게시글		댓글
-----------------------------
번호 PK		번호 PK		번호 PK
-----------------------------
아이디 U NN	제목	NN		댓글 내용 NN
비밀번호 NN	내용	NN		글 작성자 FK
이름	NN		게시날짜 DATE	댓글작성자 FK
주소	NN		작성한회원 FK
이메일
생일


4. 물리 모델링

MEMBER_2
--------------------------------------------
ID NUMBER CONSTRAINT PK_MEMBER_2 PRIMARY KEY,
-----------------------------------------------
MEMBER_2_ID  VARCHAR2(1000) CONSTRAINT UK_MEMBER_2 UNIQUE NOT NULL,
MEMBER_2_PASSWORD  VARCHAR2(1000) NOT NULL,
MEMBER_2_NAME  VARCHAR2(1000) NOT NULL,
MEMBER_2_ADRESS  VARCHAR2(1000) NOT NULL,
MEMBER_2_EMAIL  VARCHAR2(1000),
MEMBER_2_BIRTHDAY DATE


POST
-------------------------------------------------------
ID NUMBER CONSTRAINT PK_POST PRIMARY KEY,
-------------------------------------------------------
POST_TITLE VARCHAR2(255) NOT NULL,
POST_CONTENT VARCHAR2(255) NOT NULL,
CREATED_DATE DATE DEFAULT CURRENT_TIMESTAMP,
MEMBER_ID_2 NUMBER,
CONSTRAINTS FK_POST_MEMBER FOREIGN KEY(MEMBER_ID_2)
REFERENCES TBL_MEMBER_2(ID)


REPLY
--------------------------------------------------
ID NUMBER CONSTRAINT PK_REPLY PRIMARY KEY,
---------------------------------------------------
REPLY_CONTENT VARCHAR2(255) NOT NULL,
POST_ID NUMBER NOT NULL,
MEMBER_2_ID NUMBER NOT NULL,
CONSTRAINTS FK_REPLY_POST FOREIGN KEY(POST_ID)
REFERENCES TBL_POST(ID),
CONSTRAINTS FK_REPLY_MEMBER FOREIGN KEY(MEMBER_2_ID)
REFERENCES TBL_MEMBER_2(ID)



5. 구현
*/

CREATE TABLE TBL_MEMBER_2(
	ID NUMBER CONSTRAINT PK_MEMBER_2 PRIMARY KEY,
	MEMBER_2_ID  VARCHAR2(1000) CONSTRAINT UK_MEMBER_2 UNIQUE NOT NULL,
	MEMBER_2_PASSWORD  VARCHAR2(1000) NOT NULL,
	MEMBER_2_NAME  VARCHAR2(1000) NOT NULL,
	MEMBER_2_ADRESS  VARCHAR2(1000) NOT NULL,
	MEMBER_2_EMAIL  VARCHAR2(1000),
	MEMBER_2_BIRTHDAY DATE
);


CREATE TABLE TBL_POST(
	ID NUMBER CONSTRAINT PK_POST PRIMARY KEY,
	POST_TITLE VARCHAR2(255) NOT NULL,
   	POST_CONTENT VARCHAR2(255) NOT NULL,
   	CREATED_DATE DATE DEFAULT CURRENT_TIMESTAMP,
  	MEMBER_ID_2 NUMBER,
  	CONSTRAINTS FK_POST_MEMBER FOREIGN KEY(MEMBER_ID_2)
   	REFERENCES TBL_MEMBER_2(ID)
);

CREATE TABLE TBL_REPLY(
   ID NUMBER CONSTRAINT PK_REPLY PRIMARY KEY,
   REPLY_CONTENT VARCHAR2(255) NOT NULL,
   POST_ID NUMBER NOT NULL,
   MEMBER_2_ID NUMBER NOT NULL,
   CONSTRAINTS FK_REPLY_POST FOREIGN KEY(POST_ID)
   REFERENCES TBL_POST(ID),
   CONSTRAINTS FK_REPLY_MEMBER FOREIGN KEY(MEMBER_2_ID)
   REFERENCES TBL_MEMBER_2(ID)
);

/*
1.요구 사항
    마이페이지에서 회원 프로필을 구현하고 싶습니다.
    회원당 프로필을 여러 개 설정할 수 있고,
    대표 이미지로 선택된 프로필만 화면에 보여주고 싶습니다.

2. 개념 모델링

회원			회원프로필		
---------------------
번호 			  번호 		
---------------------
아이디		 회원번호		
비밀번호		 대표이미지
이름
주소
이메일
생일

3. 논리 모델링

회원			회원프로필		
-----------------------
번호 PK 		번호 PK		
----------------------
아이디 U,NN	회원번호FK	
비밀번호NN		대표이미지설정을위한 STATUS 변수	
이름NN
주소NN
이메일
생일

4. 물리 모델링

MEMBER_3
--------------------------------------
ID NUMBER CONSTRAINT PK_MEMBER_3 PRIMARY KEY,
-----------------------------------------------
MEMBER_3_ID  VARCHAR2(1000) UNIQUE NOT NULL,
MEMBER_3_PASSWORD  VARCHAR2(1000) NOT NULL,
MEMBER_3_NAME  VARCHAR2(1000) NOT NULL,
MEMBER_3_ADRESS  VARCHAR2(1000) NOT NULL,
MEMBER_3_EMAIL  VARCHAR2(1000),
MEMBER_3_BIRTHDAY VARCHAR2(1000)

PROFILE
-------------------------------------------------
ID NUMBER CONSTRAINT PK_PROFILE PRIMARY KEY,
--------------------------------------------------
MEMBER_3_ID NUMBER,
STATUS NUMBER DEFAULT 0,
CONSTRAINT FK_PROFILE_MEMBER_3 FOREIGN KEY(MEMBER_3_ID)
REFERENCES TBL_MEMBER_3(ID)


5. 구현
*/
CREATE TABLE TBL_MEMBER_3(
	ID NUMBER CONSTRAINT PK_MEMBER_3 PRIMARY KEY,
	MEMBER_3_ID  VARCHAR2(1000) UNIQUE NOT NULL,
	MEMBER_3_PASSWORD  VARCHAR2(1000) NOT NULL,
	MEMBER_3_NAME  VARCHAR2(1000) NOT NULL,
	MEMBER_3_ADRESS  VARCHAR2(1000) NOT NULL,
	MEMBER_3_EMAIL  VARCHAR2(1000),
	MEMBER_3_BIRTHDAY VARCHAR2(1000)
);

CREATE TABLE TBL_PROFILE(
	ID NUMBER CONSTRAINT PK_PROFILE PRIMARY KEY,
	MEMBER_3_ID NUMBER,
	STATUS NUMBER DEFAULT 0,
	CONSTRAINT FK_PROFILE_MEMBER_3 FOREIGN KEY(MEMBER_3_ID)
	REFERENCES TBL_MEMBER_3(ID)
);

/*
1. 요구 사항
    회원들끼리 좋아요를 누를 수 있습니다.

2. 개념 모델링

회원			좋아요
--------------------
번호 		번호
---------------------
아이디 		회원번호 
비밀번호		누가 좋아요를 누른지 확인하는 변수
이름
주소
이메일
생일

3. 논리 모델링

회원			좋아요
--------------------
번호 PK 		번호 PK
---------------------
아이디 U NN	누가 좋아요를 누른지 확인하기위한 회원번호 FK
비밀번호 NN	누가 좋아요를 누른지 확인하기위한 회원번호_1 FK
이름 NN
주소
이메일
생일

4. 물리 모델링

MEMBER_4
--------------------------------------
ID NUMBER CONSTRAINT PK_MEMBER_4 PRIMARY KEY,
-----------------------------------------------
MEMBER_4_ID  VARCHAR2(1000) UNIQUE NOT NULL,
MEMBER_4_PASSWORD  VARCHAR2(1000) NOT NULL,
MEMBER_4_NAME  VARCHAR2(1000) NOT NULL,
MEMBER_4_ADRESS  VARCHAR2(1000) NOT NULL,
MEMBER_4_EMAIL  VARCHAR2(1000),
MEMBER_4_BIRTHDAY VARCHAR2(1000)

LIKE
---------------------------------------------
ID NUMBER CONSTRAINT PK_LIKE PRIMARY KEY,
--------------------------------------------------
MEMBER_4_ID NUMBER,
CONSTRAINT FK_LIKE_MEMBER_4 FOREIGN KEY(MEMBER_4_ID)
REFERENCES TBL_MEMBER_4(ID)
MEMBER_4_ID_1 NUMBER,
CONSTRAINT FK_LIKE_MEMBER_4_ID_1 FOREIGN KEY(MEMBER_4_ID_1)
REFERENCES TBL_MEMBER_4(ID)

5. 구현
*/

CREATE TABLE TBL_MEMBER_4(
	ID NUMBER CONSTRAINT PK_MEMBER_4 PRIMARY KEY,
	MEMBER_4_ID  VARCHAR2(1000) UNIQUE NOT NULL,
	MEMBER_4_PASSWORD VARCHAR2(1000) NOT NULL,
	MEMBER_4_NAME  VARCHAR2(1000) NOT NULL,
	MEMBER_4_ADRESS  VARCHAR2(1000) NOT NULL,
	MEMBER_4_EMAIL  VARCHAR2(1000),
	MEMBER_4_BIRTHDAY VARCHAR2(1000)
);

CREATE TABLE TBL_LIKE(
	ID NUMBER CONSTRAINT PK_LIKE PRIMARY KEY,
	MEMBER_4_ID NUMBER,
	CONSTRAINT FK_LIKE_MEMBER_4_ID FOREIGN KEY(MEMBER_4_ID)
	REFERENCES TBL_MEMBER_4(ID),
	MEMBER_4_ID_1 NUMBER,
	CONSTRAINT FK_LIKE_MEMBER_4_ID_1 FOREIGN KEY(MEMBER_4_ID_1)
	REFERENCES TBL_MEMBER_4(ID)
);




