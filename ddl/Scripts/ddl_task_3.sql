/*
1. 요구사항
   유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
   아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
   체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
   아이들은 여러 번 체험학습에 등록할 수 있어요.
    
2. 개념 모델링 

아이들		학부모 		체험학습		이미지		프로그램
--------------------------------------------------------
아이디		아이디		아이디		아이디		아이디
---------------------------------------------------------
이름			이름			제목			정보			아이들
나이			나이			내용						체험학습
성별 		주소			이벤트이미지
학부모		전화번호		
			성별

3. 논리 모델링

아이들		학부모 		체험학습		이미지		프로그램
--------------------------------------------------------
아이디 PK		아이디 PK		아이디 PK		아이디 PK		아이디 PK
---------------------------------------------------------
이름	NN		이름	NN		제목	NN		정보	NN		아이들 FK
나이	D1		나이	D1		내용	NN					체험학습 FK
성별 NN		주소	NN		이미지 FK
학부모 FK		전화번호 NN	
			성별 NN
			
			
			
4. 물리 모델링

CHILDREN
--------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_CHILDREN PRIMARY KEY,
--------------------------------------------------------------------
CHILDREN_NAME VARCHAR2(255) NOT NULL,
CHILDREN_AGE NUMBER DEFAULT 1,
CHILDREN_GENDER VARCHAR2(255) NOT NULL,
PARENTS_ID NUMBER,
CONSTRAINT FK_CHILDREN_PARENTS FOREIGN KEY(PARENTS_ID)
REFERENCES TBL_PARENTS(ID)


PARENTS
--------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_PARENTS PRIMARY KEY,
--------------------------------------------------------------------
PARENTS_NAME VARCHAR2(255) NOT NULL,
PARENTS_AGE NUMBER DEFAULT 1,
PARENTS_ADRESS VARCHAR2(255) NOT NULL,
PARENTS_NUMBER VARCHAR2(255) NOT NULL,
PARENTS_GENDER VARCHAR2(255) NOT NULL


FIELD_STUDY
--------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_FIELD_STUDY PRIMARY KEY,
--------------------------------------------------------------------
FIELD_STUDY_NAME VARCHAR2(255) NOT NULL,
FIELD_STUDY_DETAIL VARCHAR2(255) NOT NULL,
IMAGE_ID NUMBER NOT NULL,
CONSTRAINT FK_FIELD_STUDY_IMAGE FOREIGN KEY(IMAGE_ID)
REFERENCES TBL_IMAGE(ID)


IMAGE
--------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_IMAGE PRIMARY KEY,
--------------------------------------------------------------------
IMAGE_NAME VARCHAR2(255) NOT NULL


PROGRAM
--------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_PROGRAM PRIMARY KEY,
--------------------------------------------------------------------
CHILDREN_ID NUMBER NOT NULL,
CONSTRAINT FK_PROGRAM_CHILDREN FOREIGN KEY(CHILDREN_ID)
REFERENCES TBL_CHILDREN(ID),
FIELD_STUDY_ID NUMBER NOT NULL,
CONSTRAINT FK_PROGRAM_FIELD_STUDY FOREIGN KEY(FIELD_STUDY_ID)
REFERENCES TBL_FIELD_STUDY(ID)


5. 구현
*/

CREATE TABLE TBL_CHILDREN(
	ID NUMBER CONSTRAINT PK_CHILDREN PRIMARY KEY,
	CHILDREN_NAME VARCHAR2(255) NOT NULL,
	CHILDREN_AGE NUMBER DEFAULT 1,
	CHILDREN_GENDER VARCHAR2(255) NOT NULL,
	PARENTS_ID NUMBER,
	CONSTRAINT FK_CHILDREN_PARENTS FOREIGN KEY(PARENTS_ID)
	REFERENCES TBL_PARENTS(ID)
);

CREATE TABLE TBL_PARENTS(
	ID NUMBER CONSTRAINT PK_PARENTS PRIMARY KEY,
	PARENTS_NAME VARCHAR2(255) NOT NULL,
	PARENTS_AGE NUMBER DEFAULT 1,
	PARENTS_ADRESS VARCHAR2(255) NOT NULL,
	PARENTS_NUMBER VARCHAR2(255) NOT NULL,
	PARENTS_GENDER VARCHAR2(255) NOT NULL
);

CREATE TABLE TBL_FIELD_STUDY(
	ID NUMBER CONSTRAINT PK_FIELD_STUDY PRIMARY KEY,
	FIELD_STUDY_NAME VARCHAR2(255) NOT NULL,
	FIELD_STUDY_DETAIL VARCHAR2(255) NOT NULL,
	IMAGE_ID NUMBER NOT NULL,
	CONSTRAINT FK_FIELD_STUDY_IMAGE FOREIGN KEY(IMAGE_ID)
	REFERENCES TBL_IMAGE(ID)
);

CREATE TABLE TBL_IMAGE(
	ID NUMBER CONSTRAINT PK_IMAGE PRIMARY KEY,
	IMAGE_NAME VARCHAR2(255) NOT NULL
);

CREATE TABLE TBL_PROGRAM(
	ID NUMBER CONSTRAINT PK_PROGRAM PRIMARY KEY,
	CHILDREN_ID NUMBER NOT NULL,
	CONSTRAINT FK_PROGRAM_CHILDREN FOREIGN KEY(CHILDREN_ID)
	REFERENCES TBL_CHILDREN(ID),
	FIELD_STUDY_ID NUMBER NOT NULL,
	CONSTRAINT FK_PROGRAM_FIELD_STUDY FOREIGN KEY(FIELD_STUDY_ID)
	REFERENCES TBL_FIELD_STUDY(ID)
);


/*
1. 요구사항
   안녕하세요, 광고 회사를 운영하려고 준비중인 사업가입니다.
   광고주는 기업이고 기업 정보는 이름, 주소, 대표번호, 기업종류(스타트업, 중소기업, 중견기업, 대기업)입니다.
   광고는 제목, 내용이 있고 기업은 여러 광고를 신청할 수 있습니다.
   기업이 광고를 선택할 때에는 카테고리로 선택하며, 대카테고리, 중카테고리, 소카테고리가 있습니다.

2. 개념 모델링 (다시하기)

기업 		대카(A)		중카(B)		소카(C)			광고			수락
------------------------------------------------------------------------
아이디		아이디		아이디		아이디			아이디		아이디
--------------------------------------------------------------------------
이름			이름			이름			이름				제목			기업아이디
주소						대카아이디		중카아이디			내용			광고아이디
전화번호												기업아이디
종류													소카아이디
											(대,중카를 받아놔서 소카만 받으면 그 목록이 다뜸)

3. 논리 모델링

기업 		대카(A)		중카(B)		소카(C)			광고			수락
------------------------------------------------------------------------
아이디		아이디		아이디		아이디			아이디		아이디
--------------------------------------------------------------------------
이름	NN		이름 		이름			이름				제목	NN		기업아이디 FK
주소	NN					대카아이디	FK	중카아이디 FK		내용	NN		광고아이디 FK
전화번호 NN											기업아이디 FK
종류													소카아이디 FK
											(대,중카를 받아놔서 소카만 받으면 그 목록이 다뜸)
											
											
4. 물리 모델링

COMPANY
-----------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_COMPANY PRIMARY KEY,
-----------------------------------------------------------------------
COMAPNY_NAME VARCHAR2(255) NOT NULL,
COMAPNY_ADDRESS VARCHAR2(255) NOT NULL,
COMAPNY_TEL VARCHAR2(255) NOT NULL,
COMAPNY_TYPE NUMBER

CATEGORY_A
-----------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_CATEGORY_A PRIMARY KEY,
-----------------------------------------------------------------------
CATEGORY_A_NAME VARCHAR2(255)


CATEGORY_B
-----------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_CATEGORY_B PRIMARY KEY,
-----------------------------------------------------------------------
CATEGORY_B_NAME VARCHAR2(255),
CATEGORY_A_ID NUMBER,
CONSTRAINT FK_CATEGORY_B_CATEGORY_A FOREIGN KEY(CATEGORY_A_ID)
REFERENCES TBL_CATEGORY_A(ID)


CATEGORY_C
-----------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_CATEGORY_C PRIMARY KEY,
-----------------------------------------------------------------------
CATEGORY_C_NAME VARCHAR2(255),
CATEGORY_B_ID NUMBER,
CONSTRAINT FK_CATEGORY_C_CATEGORY_B FOREIGN KEY(CATEGORY_B_ID)
REFERENCES TBL_CATEGORY_B(ID)


ADVERTISEMENT
-----------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_ADVERTISEMENT PRIMARY KEY,
-----------------------------------------------------------------------
ADVERTISEMENT_TITLE VARCHAR2(255) NOT NULL,
ADVERTISEMENT_CONTENT VARCHAR2(255) NOT NULL,
COMPANY_ID NUMBER,
CONSTRAINT FK_ADVERTISEMENT_COMPANY FOREIGN KEY(COMPANY_ID)
REFERENCES TBL_COMPANY(ID),
CATEGORY_C_ID NUMBER,
CONSTRAINT FK_ADVERTISEMENT_CATEGORY_C FOREIGN KEY(CATEGORY_C_ID)
REFERENCES TBL_CATEGORY_C(ID)


APPLY
-----------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_APPLY PRIMARY KEY,
-----------------------------------------------------------------------
COMPANY_ID NUMBER NOT NULL, 
ADVERTISEMENT_ID NUMBER NOT NULL,
CONSTRAINT FK_APPLY_COMPANY FOREIGN KEY(COMPANY_ID)
REFERENCES TBL_COMPANY(ID),
CONSTRAINT FK_APPLY_ADVERTISEMENT FOREIGN KEY(ADVERTISEMENT_ID)
REFERENCES TBL_ADVERTISEMENT(ID)



5. 구현
*/

CREATE TABLE TBL_COMPANY(
   ID NUMBER CONSTRAINT PK_COMPANY PRIMARY KEY,
   COMAPNY_NAME VARCHAR2(255) NOT NULL,
   COMAPNY_ADDRESS VARCHAR2(255) NOT NULL,
   COMAPNY_TEL VARCHAR2(255) NOT NULL,
   COMAPNY_TYPE NUMBER
);

CREATE TABLE TBL_CATEGORY_A(
   ID NUMBER CONSTRAINT PK_CATEGORY_A PRIMARY KEY,
   CATEGORY_A_NAME VARCHAR2(255)
);

CREATE TABLE TBL_CATEGORY_B(
   ID NUMBER CONSTRAINT PK_CATEGORY_B PRIMARY KEY,
   CATEGORY_B_NAME VARCHAR2(255),
   CATEGORY_A_ID NUMBER,
   CONSTRAINT FK_CATEGORY_B_CATEGORY_A FOREIGN KEY(CATEGORY_A_ID)
   REFERENCES TBL_CATEGORY_A(ID)
);

CREATE TABLE TBL_CATEGORY_C(
   ID NUMBER CONSTRAINT PK_CATEGORY_C PRIMARY KEY,
   CATEGORY_C_NAME VARCHAR2(255),
   CATEGORY_B_ID NUMBER,
   CONSTRAINT FK_CATEGORY_C_CATEGORY_B FOREIGN KEY(CATEGORY_B_ID)
   REFERENCES TBL_CATEGORY_B(ID)
);

CREATE TABLE TBL_ADVERTISEMENT(
   ID NUMBER CONSTRAINT PK_ADVERTISEMENT PRIMARY KEY,
   ADVERTISEMENT_TITLE VARCHAR2(255) NOT NULL,
   ADVERTISEMENT_CONTENT VARCHAR2(255) NOT NULL,
   COMPANY_ID NUMBER,
   CONSTRAINT FK_ADVERTISEMENT_COMPANY FOREIGN KEY(COMPANY_ID)
   REFERENCES TBL_COMPANY(ID),
   CATEGORY_C_ID NUMBER,
   CONSTRAINT FK_ADVERTISEMENT_CATEGORY_C FOREIGN KEY(CATEGORY_C_ID)
   REFERENCES TBL_CATEGORY_C(ID)
);

CREATE TABLE TBL_APPLY(
   ID NUMBER CONSTRAINT PK_APPLY PRIMARY KEY,
   COMPANY_ID NUMBER NOT NULL, 
   ADVERTISEMENT_ID NUMBER NOT NULL,
   CONSTRAINT FK_APPLY_COMPANY FOREIGN KEY(COMPANY_ID)
   REFERENCES TBL_COMPANY(ID),
   CONSTRAINT FK_APPLY_ADVERTISEMENT FOREIGN KEY(ADVERTISEMENT_ID)
   REFERENCES TBL_ADVERTISEMENT(ID)
);



/*
1. 요구사항
   음료수 판매 업체입니다. 음료수마다 당첨번호가 있습니다. 
   음료수의 당첨번호는 1개이고 당첨자의 정보를 알아야 상품을 배송할 수 있습니다.
   당첨 번호마다 당첨 상품이 있고, 당첨 상품이 배송 중인지 배송 완료인지 구분해야 합니다.

2. 개념 모델링

맴버(당첨자)		음료수		상품		당첨번호		유통			배송
----------------------------------------------------------------------------
아이디			아이디		아이디	아이디		아이디		아이디
----------------------------------------------------------------------------
아이디			이름			이름		번호			음료수		당첨자
비밀번호						가격		상품			당첨번호		상품
이름							재고								배송여부변수
주소
이메일
생일							
	
																																																																					
3. 논리 모델링		

맴버(당첨자)		음료수		상품			당첨번호		유통			배송
----------------------------------------------------------------------------
아이디 PK			아이디 PK		아이디 PK		아이디 PK		아이디 PK		아이디 PK
----------------------------------------------------------------------------
아이디 U NN		이름			이름	NN		번호 NN		음료수 FK		당첨자 FK
비밀번호 NN					가격	D0		상품	FK		당첨번호 FK	상품 FK
이름	NN						재고	D0								배송여부변수 STATUS
주소 NN
이메일
생일																																																			
										

4. 물리 모델링
MEMBER
------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
------------------------------------------------------------------
MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE NOT NULL,
MEMBER_PASSWORD VARCHAR2(255) NOT NULL,
MEMBER_NAME VARCHAR2(255) NOT NULL,
MEMBER_ADDRESS VARCHAR2(255) NOT NULL,
MEMBER_EMAIL VARCHAR2(255),
MEMBER_BIRTH DATE
   

SOFT_DRINK
------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_SOFT_DRINK PRIMARY KEY,
------------------------------------------------------------------
SOFT_DRINK_NAME VARCHAR2(255)


PRODUCT
------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_PRODUCT PRIMARY KEY,
------------------------------------------------------------------
PRODUCT_NAME VARCHAR2(255) NOT NULL,
PRODUCT_PRICE NUMBER DEFAULT 0,
PRODUCT_STOCK NUMBER DEFAULT 0


LOTTERY
------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_LOTTERY PRIMARY KEY,
------------------------------------------------------------------
LOTTERY_NUMBER VARCHAR2(255) NOT NULL,
PRODUCT_ID NUMBER,
CONSTRAINT FK_LOTTERY_PRODUCT FOREIGN KEY(PRODUCT_ID)
REFERENCES TBL_PRODUCT(ID)
   
   
CIRCULATION
------------------------------------------------------------------
ID NUMBER CONSTRAINT PK_CIRCULATION PRIMARY KEY,
------------------------------------------------------------------
SOFT_DRINK_ID NUMBER,
LOTTERY_ID NUMBER,
CONSTRAINT FK_CIRCULATION_SOFT_DRINK FOREIGN KEY(SOFT_DRINK_ID)
REFERENCES TBL_SOFT_DRINK(ID),
CONSTRAINT FK_CIRCULATION_LOTTERY FOREIGN KEY(LOTTERY_ID)
REFERENCES TBL_LOTTERY(ID)
  
   
DILIVERY
------------------------------------------------------------------    
ID NUMBER CONSTRAINT PK_DILIVERY PRIMARY KEY,
------------------------------------------------------------------
MEMBER_ID NUMBER NOT NULL,
PRODUCT_ID NUMBER NOT NULL,
STATUS NUMBER DEFAULT 0,
CONSTRAINT FK_DILIVERY_MEMBER FOREIGN KEY(MEMBER_ID)
REFERENCES TBL_MEMBER(ID),
CONSTRAINT FK_DILIVERY_PRODUCT FOREIGN KEY(PRODUCT_ID)
REFERENCES TBL_PRODUCT(ID) 
            
                                
                                
5. 구현
*/

CREATE TABLE TBL_MEMBER(
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE NOT NULL,
   MEMBER_PASSWORD VARCHAR2(255) NOT NULL,
   MEMBER_NAME VARCHAR2(255) NOT NULL,
   MEMBER_ADDRESS VARCHAR2(255) NOT NULL,
   MEMBER_EMAIL VARCHAR2(255),
   MEMBER_BIRTH DATE
);

CREATE TABLE TBL_SOFT_DRINK(
   ID NUMBER CONSTRAINT PK_SOFT_DRINK PRIMARY KEY,
   SOFT_DRINK_NAME VARCHAR2(255)
);

CREATE TABLE TBL_PRODUCT(
   ID NUMBER CONSTRAINT PK_PRODUCT PRIMARY KEY,
   PRODUCT_NAME VARCHAR2(255) NOT NULL,
   PRODUCT_PRICE NUMBER DEFAULT 0,
   PRODUCT_STOCK NUMBER DEFAULT 0
);

CREATE TABLE TBL_LOTTERY(
   ID NUMBER CONSTRAINT PK_LOTTERY PRIMARY KEY,
   LOTTERY_NUMBER VARCHAR2(255) NOT NULL,
   PRODUCT_ID NUMBER,
   CONSTRAINT FK_LOTTERY_PRODUCT FOREIGN KEY(PRODUCT_ID)
   REFERENCES TBL_PRODUCT(ID)
);

CREATE TABLE TBL_CIRCULATION(
   ID NUMBER CONSTRAINT PK_CIRCULATION PRIMARY KEY,
   SOFT_DRINK_ID NUMBER,
   LOTTERY_ID NUMBER,
   CONSTRAINT FK_CIRCULATION_SOFT_DRINK FOREIGN KEY(SOFT_DRINK_ID)
   REFERENCES TBL_SOFT_DRINK(ID),
   CONSTRAINT FK_CIRCULATION_LOTTERY FOREIGN KEY(LOTTERY_ID)
   REFERENCES TBL_LOTTERY(ID)
);

CREATE TABLE TBL_DILIVERY(
   ID NUMBER CONSTRAINT PK_DILIVERY PRIMARY KEY,
   MEMBER_ID NUMBER NOT NULL,
   PRODUCT_ID NUMBER NOT NULL,
   STATUS NUMBER DEFAULT 0,
   CONSTRAINT FK_DILIVERY_MEMBER FOREIGN KEY(MEMBER_ID)
   REFERENCES TBL_MEMBER(ID),
   CONSTRAINT FK_DILIVERY_PRODUCT FOREIGN KEY(PRODUCT_ID)
   REFERENCES TBL_PRODUCT(ID)
);


/*
1. 요구사항
   이커머스 창업 준비중입니다. 기업과 사용자 간 거래를 위해 기업의 정보와 사용자 정보가 필요합니다.
   기업의 정보는 기업 이름, 주소, 대표번호가 있고
   사용자 정보는 이름, 주소, 전화번호가 있습니다. 결제 시 사용자 정보와 기업의 정보, 결제한 카드의 정보 모두 필요하며,
   상품의 정보도 필요합니다. 상품의 정보는 이름, 가격, 재고입니다.
   사용자는 등록한 카드의 정보를 저장할 수 있으며, 카드의 정보는 카드번호, 카드사, 회원 정보가 필요합니다.

2. 개념 모델링 

기업			사용자		상품			카드			결제			거래			회원
------------------------------------------------------------------------------
이름			이름			이름			카드번호		사용자정보		기업정보		이름
주소			주소			가격			카드사		기업정보		사용자정보		주소
대표번호		전화번호		재고			회원정보		카드정보					전화번호
			카드정보								상품정보					


3. 논리 모델링

기업			사용자		상품			카드			결제			거래			회원
------------------------------------------------------------------------------
이름	NN		이름	NN		이름	NN		카드번호 NN	사용자정보	FK	기업정보 FK	이름 NN
주소	NN		주소	NN		가격	D0		카드사 NN		기업정보 FK	사용자정보	FK	주소 NN
대표번호 NN	전화번호	NN	재고	D0		회원정보 FK	카드정보 FK				전화번호 NN
			카드정보	FK							상품정보 FK	
			
			
			
4. 물리 모델링
5. 구현
*/

CREATE TABLE TBL_ENTERPRISE(
	ID NUMBER CONSTRAINT PK_ENTERPRISE PRIMARY KEY,
	ENTERPRISE_NAME VARCHAR2(255) NOT NULL,
	ENTERPRISE_ADRESS VARCHAR2(255) NOT NULL,
	ENTERPRISE_TEL VARCHAR2(255) NOT NULL
);

CREATE TABLE TBL_GOODS(
	ID NUMBER CONSTRAINT PK_GOODS PRIMARY KEY,
	GOODS_NAME VARCHAR2(255) NOT NULL,
	GOODS_PRICE NUMBER DEFAULT 0,
	GOODS_STOCK NUMBER DEFAULT 0
);

CREATE TABLE TBL_MEMBER_7(
	ID NUMBER CONSTRAINT PK_MEMBER_7 PRIMARY KEY,
	MEMBER_7_NAME VARCHAR2(255) NOT NULL,
	MEMBER_7_ADRESS VARCHAR2(255) NOT NULL,
	MEMBER_7_TEL VARCHAR2(255) NOT NULL
);

CREATE TABLE TBL_CARD(
	ID NUMBER CONSTRAINT PK_CARD PRIMARY KEY,
	CARD_NUMBER VARCHAR2(255) NOT NULL,
	CARD_NAME VARCHAR2(255) NOT NULL,
	MEMBER_7_ID NUMBER,
	CONSTRAINT FK_CARD_MEMBER_7 FOREIGN KEY(MEMBER_7_ID)
	REFERENCES TBL_MEMBER_7(ID)
);

CREATE TABLE TBL_USER(
	ID NUMBER CONSTRAINT PK_USER PRIMARY KEY,
	USER_NAME VARCHAR2(255) NOT NULL,
	USER_ADRESS VARCHAR2(255) NOT NULL,
	USER_TEL VARCHAR2(255) NOT NULL,
	CARD_ID NUMBER,
	CONSTRAINT FK_USER_CARD FOREIGN KEY(CARD_ID)
	REFERENCES TBL_CARD(ID)
);

CREATE TABLE TBL_TRANSACTION(
	ID NUMBER CONSTRAINT PK_TRANSACTION PRIMARY KEY,
	ENTERPRISE_ID NUMBER,
	CONSTRAINT FK_TRANSACTION_ENTERPRISE FOREIGN KEY(ENTERPRISE_ID)
	REFERENCES TBL_ENTERPRISE(ID),
	USER_ID NUMBER,
	CONSTRAINT FK_TRANSACTION_USER FOREIGN KEY(USER_ID)
	REFERENCES TBL_USER(ID)
);

CREATE TABLE TBL_PAYMENT(
	ID NUMBER CONSTRAINT PK_PAYMENT PRIMARY KEY,
	USER_ID NUMBER,
	CONSTRAINT FK_PAYMENT_USER FOREIGN KEY(USER_ID)
	REFERENCES TBL_USER(ID),
	ENTERPRISE_ID NUMBER,
	CONSTRAINT FK_PAYMENT_ENTERPRISE FOREIGN KEY(ENTERPRISE_ID)
	REFERENCES TBL_ENTERPRISE(ID),
	CARD_ID NUMBER,
	CONSTRAINT FK_PAYMENT_CARD FOREIGN KEY(CARD_ID)
	REFERENCES TBL_CARD(ID),
	GOODS_ID NUMBER,
	CONSTRAINT FK_PAYMENT_GOODS FOREIGN KEY(GOODS_ID)
	REFERENCES TBL_GOODS(ID)
);






















