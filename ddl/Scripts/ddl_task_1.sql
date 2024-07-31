/*
1. 요구사항 분석
    안녕하세요 중고차 딜러입니다.
    이번에 자동차와 차주를 관리하고자 방문했습니다.
    자동차는 여러 명의 차주로 히스토리에 남아야 하고,
    차주는 여러 대의 자동차를 소유할 수 있습니다.
    그래서 우리는 항상 등록증(Registration)을 작성합니다.
    자동차는 브랜드, 모델명, 가격, 출시날짜가 필요하고
    차주는 이름, 전화번호, 주소가 필요합니다.

2. 개념 모델링
	차주			자동차
	-------------------
	번호			번호
	-------------------
	이름			브랜드
	전화번호		모델명
	주소			가격
				출시날짜
				등록증 Registration 
				차주번호
	
3. 논리 모델링
	차주			자동차			등록증
	-----------------------------------
	번호	PK		번호	PK			번호 PK
	-----------------------------------
	이름	U,NN	브랜드 NN			차주번호 FK
	전화번호 NN	모델명 NN			자동차번호 FK
	주소	NN		가격 D0
				출시날짜 DATE

							
							
4. 물리 모델링
OWNER
-------------------------------------------
ID NUMBER CONSTRAINT PK_OWNER PRIMARY KEY,
-------------------------------------------
OWNER_NAME VARCHAR2(1000) CONSTRAINT UK_OWNER UNIQUE NOT NULL,
OWNER_PHONE VARCHAR2(1000) NOT NULL,
OWNER_ADRESS VARCHAR2(1000) NOT NULL,


CAR
--------------------------------------------
ID NUMBER CONSTRAINT PK_CAR PRIMARY KEY,
-------------------------------------------
CAR_BRAND VARCHAR2(1000) NOT NULL,
CAR_MODLE_NAME VARCHAR2(1000) NOT NULL,
CAR_PRICE NUMBER DEFAULT 0,
CAR_DATE DATE DEFAULT CURRENT_TIMESTAMP,
OWNER_ID NUMBER


REGISTRATION
------------------------------------------------
ID NUMBER CONSTRAINT PK_REGISTRATION PRIMARY KEY,
------------------------------------------------
OWNER_ID NUMBER,
CONSTRAINT FK_REGISTRATION_OWNER FOREIGN KEY(OWNER_ID)
REFERENCES TBL_OWNER(ID)
CAR_ID NUMBER,
CONSTRAINT FK_REGISTRATION_CAR FOREIGN KEY(CAR_ID)
REFERENCES TBL_CAR(ID)

5. 구현
*/
CREATE TABLE TBL_OWNER(
	ID NUMBER CONSTRAINT PK_OWNER PRIMARY KEY,
	OWNER_NAME VARCHAR2(1000) CONSTRAINT UK_OWNER UNIQUE NOT NULL,
	OWNER_PHONE VARCHAR2(1000) NOT NULL,
	OWNER_ADRESS VARCHAR2(1000) NOT NULL
);

CREATE TABLE TBL_CAR(
	ID NUMBER CONSTRAINT PK_CAR PRIMARY KEY,
	CAR_BRAND VARCHAR2(1000) NOT NULL,
	CAR_MODLE_NAME VARCHAR2(1000) NOT NULL,
	CAR_PRICE NUMBER DEFAULT 0,
	CAR_DATE DATE DEFAULT CURRENT_TIMESTAMP,
	OWNER_ID NUMBER
);

CREATE TABLE TBL_REGISTRATION(
	ID NUMBER CONSTRAINT PK_REGISTRATION PRIMARY KEY,
	OWNER_ID NUMBER,
	CONSTRAINT FK_REGISTRATION_OWNER FOREIGN KEY(OWNER_ID)
	REFERENCES TBL_OWNER(ID),
	CAR_ID NUMBER,
	CONSTRAINT FK_REGISTRATION_CAR FOREIGN KEY(CAR_ID)
	REFERENCES TBL_CAR(ID)
);

/*
1.요구사항

학사 관리 시스템에 학생과 교수, 과목을 관리합니다.
학생은 학번, 이름, 전공, 학년이 필요하고
교수는 교수 번호, 이름, 전공, 직위가 필요합니다.
과목은 고유한 과목 번호와 과목명, 학점이 필요합니다.
학생은 여러 과목을 수강할 수 있으며,
교수는 여러 과목을 강의할 수 있습니다.
학생이 수강한 과목은 성적(점수)이 모두 기록됩니다.


2.개념 모델링  

학생 			교수 			과목			학생+과목 			교수+과목
--------------------------------------------------------------------------
아이디			아이디			번호			번호					번호			
-------------------------------------------------------------------------
이름				이름				이름			학생아이디				교수아이디
전공				전공				학점			과목번호				과목번호
학년				직위

						
3.논리 모델링 

학생 			교수 			과목			학생+과목 			교수+과목
-------------------------------------------------------------------------
아이디 PK			아이디 PK			번호	PK		번호	PK				번호	PK		
-------------------------------------------------------------------------
이름	NN			이름	NN			이름	NN		학생아이디	FK			교수아이디	FK
전공	NN			전공	NN			학점	D1		과목번호	FK			과목번호	FK
학년	D1			직위

						
						
4.물리 모델링

STUDENT
----------------------------------------------------------
ID NUMBER CONSTRAINT PK_STUDENT PRIMARY KEY,
----------------------------------------------------------
STUDENT_NAME VARCHAR2(1000) NOT NULL,
STUDENT_MAJOR VARCHAR2(1000) NOT NULL,
STUDENT_GRADE NUMBER DEFAULT 1


PROFRSSOR
----------------------------------------------------------
ID NUMBER CONSTRAINT PK_PROFRSSOR PRIMARY KEY,
----------------------------------------------------------
PROFRSSOR_NAME VARCHAR2(1000) NOT NULL,
PROFRSSOR_MAJOR VARCHAR2(1000) NOT NULL,
PROFRSSOR_GRADE VARCHAR2(1000)


SUBJECT
----------------------------------------------------------
ID NUMBER CONSTRAINT PK_SUBJECT PRIMARY KEY,
----------------------------------------------------------
SUBJECT_NAME VARCHAR2(1000) CONSTRAINT UK_SUBJECT UNIQUE NOT NULL,
SUBJECT_SCORE NUMBER(3,2) DEFAULT 0.0


STUDENT_SUBJECT
----------------------------------------------------------
ID NUMBER CONSTRAINT PK_STUDENT_SUBJECT PRIMARY KEY,
----------------------------------------------------------
STUDENT_ID NUMBER NOT NULL,
CONSTRAINT FK_STUDENT_SUBJECT_STUDENT FOREIGN KEY(STUDENT_ID)
REFERENCES TBL_STUDENT(ID),
SUBJECT_ID NUMBER NOT NULL,
CONSTRAINT FK_STUDENT_SUBJECT_SUBJECT FOREIGN KEY(SUBJECT_ID)
REFERENCES TBL_SUBJECT(ID),
SUBJECT_SUM NUMBER DEFAULT 0


LECTURE
----------------------------------------------------------
ID NUMBER CONSTRAINT PK_LECTURE PRIMARY KEY,
----------------------------------------------------------
PROFRSSOR_ID NUMBER,
CONSTRAINT FK_LECTURE_PROFRSSOR FOREIGN KEY(PROFRSSOR_ID)
REFERENCES TBL_PROFRSSOR(ID),
SUBJECT_ID NUMBER NOT NULL,
CONSTRAINT FK_LECTURE_SUBJECT FOREIGN KEY(SUBJECT_ID)
REFERENCES TBL_SUBJECT(ID)



5.구현
*/


CREATE TABLE TBL_STUDENT(
	ID NUMBER CONSTRAINT PK_STUDENT PRIMARY KEY,
	STUDENT_NAME VARCHAR2(1000) NOT NULL,
	STUDENT_MAJOR VARCHAR2(1000) NOT NULL,
	STUDENT_GRADE NUMBER DEFAULT 1
);

CREATE TABLE TBL_PROFRSSOR(
	ID NUMBER CONSTRAINT PK_PROFRSSOR PRIMARY KEY,
	PROFRSSOR_NAME VARCHAR2(1000) NOT NULL,
	PROFRSSOR_MAJOR VARCHAR2(1000) NOT NULL,
	PROFRSSOR_GRADE VARCHAR2(1000) 
);

CREATE TABLE TBL_SUBJECT(
	ID NUMBER CONSTRAINT PK_SUBJECT PRIMARY KEY,
	SUBJECT_NAME VARCHAR2(1000) CONSTRAINT UK_SUBJECT UNIQUE NOT NULL,
	SUBJECT_SCORE NUMBER(3,2) DEFAULT 0.0
);

CREATE TABLE TBL_STUDENT_SUBJECT(
	ID NUMBER CONSTRAINT PK_STUDENT_SUBJECT PRIMARY KEY,
	STUDENT_ID NUMBER NOT NULL,
	CONSTRAINT FK_STUDENT_SUBJECT_STUDENT FOREIGN KEY(STUDENT_ID)
	REFERENCES TBL_STUDENT(ID),
	SUBJECT_ID NUMBER NOT NULL,
	CONSTRAINT FK_STUDENT_SUBJECT_SUBJECT FOREIGN KEY(SUBJECT_ID)
	REFERENCES TBL_SUBJECT(ID),
	SUBJECT_SUM NUMBER DEFAULT 0
);

CREATE TABLE TBL_LECTURE(
	ID NUMBER CONSTRAINT PK_LECTURE PRIMARY KEY,
	PROFRSSOR_ID NUMBER,
	CONSTRAINT FK_LECTURE_PROFRSSOR FOREIGN KEY(PROFRSSOR_ID)
	REFERENCES TBL_PROFRSSOR(ID),
	SUBJECT_ID NUMBER NOT NULL,
	CONSTRAINT FK_LECTURE_SUBJECT FOREIGN KEY(SUBJECT_ID)
	REFERENCES TBL_SUBJECT(ID)
);

/*
1. 요구사항
   대카테고리, 소카테고리가 필요해요.   
2. 개념 모델링
3. 논리 모델링
4. 물리 모델링
5. 구현
*/

/*대카*/
CREATE TABLE TBL_CATEGORY_A(
   ID NUMBER CONSTRAINT PK_CATEGORY_A PRIMARY KEY,
   CATEGORY_A_NAME VARCHAR2(255)
);

/*소카*/
CREATE TABLE TBL_CATEGORY_B(
   ID NUMBER CONSTRAINT PK_CATEGORY_B PRIMARY KEY,
   CATEGORY_B_NAME VARCHAR2(255),
   CATEGORY_A_ID NUMBER,
   CONSTRAINT FK_CATEGORY_B_CATEGORY_A FOREIGN KEY(CATEGORY_A_ID)
   REFERENCES TBL_CATEGORY_A(ID)
);


/*
 * 요구 사항
 * 
 * 회의실 예약 서비스를 제작하고 싶습니다.
 * 회원별로 등급이 존재하고 사무실마다 회의실이 여러 개 있습니다.
 * 회의실 이용 가능 시간은 파트 타임으로서 여러 시간대가 존재합니다.
 * 
 * 
 * 개념적 모델링
 * 
 * 회원		사무실		회의실			파트타임		예약서비스 
 * --------------------------------------------------------
 * 아이디		아이디		아이디			아이디		아이디	
 * --------------------------------------------------------		
 * 아이디		이름			사무실			시작시간		회원
 * 비밀번호	위치							끝난시간		파트타임
 * 이름									회의실
 * 주소
 * 이메일
 * 생일
 * 
 * 
 * 논리적 모델링
 * 
 * 회원			사무실		회의실			파트타임			예약서비스 
 * ---------------------------------------------------------------------
 * 아이디 PK		아이디 PK		아이디 PK			아이디 PK			아이디 PK	
 * ----------------------------------------------------------------------	
 * 아이디	U NN	이름 NN		사무실 FK			시작시간 DATE		회원 FK
 * 비밀번호 NN	위치	NN						끝난시간 DATE		파트타임 FK
 * 이름 NN									회의실 FK
 * 주소 NN
 * 이메일
 * 생일
 * 
 * 물리적 모델링
 * 
 * MEMBER_6
 * ---------------------------------------------------------------------
 * ID NUMBER CONSTRAINT PK_MEMBER_6 PRIMARY KEY,
 * ---------------------------------------------------------------------
 * MEMBER_6_ID VARCHAR2(255) CONSTRAINT UK_MEMBER_6 UNIQUE NOT NULL,
 * MEMBER_6_PASSWORD VARCHAR2(255) NOT NULL,
 * MEMBER_6_NAME VARCHAR2(255) NOT NULL,
 * MEMBER_6_ADDRESS VARCHAR2(255) NOT NULL,
 * MEMBER_6_EMAIL VARCHAR2(255),
 * MEMBER_6_BIRTH DATE
 * 
 * 
 * OFFICE
 * ---------------------------------------------------------------------
 * ID NUMBER CONSTRAINT PK_OFFICE PRIMARY KEY,
 * ---------------------------------------------------------------------
 * OFFICE_NAME VARCHAR2(255) NOT NULL,
 * OFFICE_LOCATION VARCHAR2(255) NOT NULL
 * 
 * 
 * CONFERENCE_ROOM
 * ---------------------------------------------------------------------
 * ID NUMBER CONSTRAINT PK_CONFERENCE_ROOM PRIMARY KEY,
 * ---------------------------------------------------------------------
 * OFFICE_ID NUMBER NOT NULL,
 * CONSTRAINT FK_CONFERENCE_ROOM_OFFICE FOREIGN KEY(OFFICE_ID)
 * REFERENCES TBL_OFFICE(ID)
 * 
 * 
 * PART_TIME
 * ---------------------------------------------------------------------
 * ID NUMBER CONSTRAINT PK_PART_TIME PRIMARY KEY,
 * ---------------------------------------------------------------------
 * START_TIME DATE NOT NULL,
 * END_TIME DATE NOT NULL,
 * CONFERENCE_ROOM_ID NUMBER,
 * CONSTRAINT FK_PART_TIME_CONFERENCE_ROOM FOREIGN KEY(CONFERENCE_ROOM_ID)
 * REFERENCES TBL_CONFERENCE_ROOM(ID)
 * 
 * 
 * RESERVATION
 * ---------------------------------------------------------------------
 * ID NUMBER CONSTRAINT PK_RESERVATION PRIMARY KEY,
 * ---------------------------------------------------------------------
 * MEMBER_6_ID NUMBER NOT NULL,
 * PART_TIME_ID NUMBER NOT NULL,
 * CONSTRAINT FK_RESERVATION_MEMBER_6 FOREIGN KEY(MEMBER_6_ID)
 * REFERENCES TBL_MEMBER_6(ID),
 * CONSTRAINT FK_RESERVATION_PART_TIME FOREIGN KEY(PART_TIME_ID)
 * REFERENCES TBL_PART_TIME(ID)
 * 
 * 
 * 구현
 * */

CREATE TABLE TBL_MEMBER_6(
   ID NUMBER CONSTRAINT PK_MEMBER_6 PRIMARY KEY,
   MEMBER_6_ID VARCHAR2(255) CONSTRAINT UK_MEMBER_6 UNIQUE NOT NULL,
   MEMBER_6_PASSWORD VARCHAR2(255) NOT NULL,
   MEMBER_6_NAME VARCHAR2(255) NOT NULL,
   MEMBER_6_ADDRESS VARCHAR2(255) NOT NULL,
   MEMBER_6_EMAIL VARCHAR2(255),
   MEMBER_6_BIRTH DATE
);

CREATE TABLE TBL_OFFICE(
   ID NUMBER CONSTRAINT PK_OFFICE PRIMARY KEY,
   OFFICE_NAME VARCHAR2(255) NOT NULL,
   OFFICE_LOCATION VARCHAR2(255) NOT NULL
);

CREATE TABLE TBL_CONFERENCE_ROOM(
   ID NUMBER CONSTRAINT PK_CONFERENCE_ROOM PRIMARY KEY,
   OFFICE_ID NUMBER NOT NULL,
   CONSTRAINT FK_CONFERENCE_ROOM_OFFICE FOREIGN KEY(OFFICE_ID)
   REFERENCES TBL_OFFICE(ID)
);

CREATE TABLE TBL_PART_TIME(
   ID NUMBER CONSTRAINT PK_PART_TIME PRIMARY KEY,
   START_TIME DATE NOT NULL,
   END_TIME DATE NOT NULL,
   CONFERENCE_ROOM_ID NUMBER,
   CONSTRAINT FK_PART_TIME_CONFERENCE_ROOM FOREIGN KEY(CONFERENCE_ROOM_ID)
   REFERENCES TBL_CONFERENCE_ROOM(ID)
);

CREATE TABLE TBL_RESERVATION(
   ID NUMBER CONSTRAINT PK_RESERVATION PRIMARY KEY,
   MEMBER_6_ID NUMBER NOT NULL,
   PART_TIME_ID NUMBER NOT NULL,
   CONSTRAINT FK_RESERVATION_MEMBER_6 FOREIGN KEY(MEMBER_6_ID)
   REFERENCES TBL_MEMBER_6(ID),
   CONSTRAINT FK_RESERVATION_PART_TIME FOREIGN KEY(PART_TIME_ID)
   REFERENCES TBL_PART_TIME(ID)
);

































