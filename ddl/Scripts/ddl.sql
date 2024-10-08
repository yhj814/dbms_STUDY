/*항상 범위 주석을 사용한다.*/
CREATE TABLE TBL_MEMBER(
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE,
   MEMBER_PASSWORD VARCHAR2(255),
   MEMBER_AGE NUMBER(3) CONSTRAINT CHECK_AGE CHECK(MEMBER_AGE > 0)
);

CREATE TABLE TBL_ORDER(
   ID NUMBER CONSTRAINT PK_ORDER PRIMARY KEY,
   MEMBER_ID NUMBER,
   ORDER_DATE DATE DEFAULT CURRENT_TIMESTAMP,
   ORDER_COUNT NUMBER DEFAULT 1,
   CONSTRAINT FK_ORDER_MEMBER FOREIGN KEY(MEMBER_ID)
   REFERENCES TBL_MEMBER(ID) 
);

/*동물원*/
CREATE TABLE TBL_ZOO(
   ID NUMBER CONSTRAINT PK_ZOO PRIMARY KEY,
   ZOO_NAME VARCHAR2(255),
   ZOO_ADDRESS VARCHAR2(255),
   ZOO_ADDRESS_DETAIL VARCHAR2(255),
   ZOO_MAX_ANIMAL NUMBER DEFAULT 0
);

/*동물*/
CREATE TABLE TBL_ANIMAL(
   ID NUMBER CONSTRAINT PK_ANIMAL PRIMARY KEY,
   ANIMAL_NAME VARCHAR2(255),
   ANIMAL_TYPE VARCHAR2(255),
   ANIMAL_AGE NUMBER DEFAULT 0,
   ANIMAL_HEIGHT NUMBER(3, 5),
   ANIMAL_WEIGHT NUMBER(3, 5),
   ZOO_ID NUMBER,
   CONSTRAINT FK_ANIMAL_ZOO FOREIGN KEY(ZOO_ID)
   REFERENCES TBL_ZOO(ID)
);



/*논리적 설계
   회원          주문              상품
   ----------------------------------------
   번호PK      	번호PK          	번호PK
   ----------------------------------------
   아이디U, NN    날짜NN          	이름NN
   비밀번호NN     회원번호FK, NN    가격D=0
   이름NN      	상품번호FK, NN     재고D=0
   주소NN
   이메일
   생일
*/

/*물리적 설계
 * MEMBER 	
 * ---------------------------------------------
 * ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,			
 * --------------------------------------------- 
 * MEMBER_ID : VARCHAR2(1000) : UNIQUE, NOT NULL,
 * MEMBER_PASSWORD : VARCHAR2(1000), NOT NULL,
 * MEMBER_NAME : VARCHAR2(1000), NOT NULL,
 * MEMBER_ADRESS : VARCHAR2(1000), NOT NULL,
 * MEMBER_EMAIL : VARCHAR2(1000),
 * MEMBER_BIRTHDAY : VARCHAR2(1000)
 * 
 * 
 * ORDER
 * ---------------------------------------------
 * ID NUMBER CONSTRAINT PK_ORDER PRIMARY KEY,
 * ---------------------------------------------
 * ORDER_1_DATE DATE DEFAULT CURRENT_TIMESTAMP,
 * MEMBER_1_ID NUMBER,
 * GOODS_ID NUMBER,
 * CONSTRAINT FK_ORDER_MEMBER FOREIGN KEY(MEMBER_ID),
 * REFERENCES TBL_MEMBER(ID),
 * CONSTRAINT FK_ORDER_GOODS FOREIGN KEY(GOODS_ID),
 * REFERENCES TBL_GOODS(ID)
 *  
 * 
 * GOODS
 * --------------------------------------------
 * ID NUMBER CONSTRAINT PK_GOODS PRIMARY KEY,
 * --------------------------------------------
 * GOODS_NAME : VARCHAR2(1000),NOT NULL,
 * GOODS_PRICE : NUMBER, DEFAULT 0,
 * GOODS_STOCK : NUMBER, DEFAULT 0
 * 
 *  
 *구현
 * */

CREATE TABLE TBL_MEMBER_1(
	ID NUMBER CONSTRAINT PK_MEMBER_1 PRIMARY KEY,
	MEMBER_1_ID  VARCHAR2(1000) CONSTRAINT UK_MEMBER_1 UNIQUE NOT NULL,
  	MEMBER_1_PASSWORD  VARCHAR2(1000) NOT NULL,
 	MEMBER_1_NAME  VARCHAR2(1000) NOT NULL,
 	MEMBER_1_ADRESS  VARCHAR2(1000) NOT NULL,
 	MEMBER_1_EMAIL  VARCHAR2(1000),
 	MEMBER_1_BIRTHDAY  VARCHAR2(1000)
);

CREATE TABLE TBL_ORDER_1(
	ID NUMBER CONSTRAINT PK_ORDER_1 PRIMARY KEY,
	ORDER_1_DATE DATE DEFAULT CURRENT_TIMESTAMP,
	MEMBER_1_ID NUMBER,
   	GOODS_ID NUMBER,
 	CONSTRAINT FK_ORDER_1_MEMBER_1 FOREIGN KEY(MEMBER_1_ID)
 	REFERENCES TBL_MEMBER_1(ID),
 	CONSTRAINT FK_ORDER_1_GOODS FOREIGN KEY(GOODS_ID)
 	REFERENCES TBL_GOODS(ID)
);

CREATE TABLE TBL_GOODS(
	ID NUMBER CONSTRAINT PK_GOODS PRIMARY KEY,
	GOODS_NAME VARCHAR2(1000) NOT NULL,
 	GOODS_PRICE NUMBER DEFAULT 0,
 	GOODS_STOCK NUMBER DEFAULT 0
);










































