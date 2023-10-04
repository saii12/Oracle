/**
    날짜 : 2023/10/02
    이름 : 박한산
    내용 : 1장 데이터베이스와 DBMS개요
*/ 

// 실습1-1
CREATE TABLE USER1 (
    ID      VARCHAR2(20),
    NAME    VARCHAR2(20),
    HP      CHAR(13),
    AGE     NUMBER
);

DROP TABLE USER1;

// 실습1-2
INSERT INTO USER1 VALUES ('A101', '김유신', '010-1234-1111', 25);
INSERT INTO USER1 VALUES ('A102', '김춘추', '010-1234-2222', 23);
INSERT INTO USER1 VALUES ('A103', '장보고', '010-1234-3333', 32);
INSERT INTO USER1 (id, name, age) VALUES ('A104', '강감찬', 45);
INSERT INTO USER1 (id, name, hp) VALUES ('A105', '이순신', '010-1234-5555');

// 실습1-3
SELECT * FROM USER1;
SELECT * FROM USER1 WHERE id='A101';
SELECT * FROM USER1 WHERE name='김춘추';
SELECT * FROM USER1 WHERE age > 30;
SELECT id, name, age FROM USER1;

// 실습1-4
UPDATE USER1 SET hp='010-1234-4444' WHERE id='A104';
UPDATE USER1 SET age=51 WHERE id='A105';
UPDATE USER1 SET hp='010-1234-1001', age=27 WHERE id='A101';

// 실습1-5
DELETE FROM User1 WHERE id='A101';
DELETE FROM User1 WHERE id='A102' AND age=25;
DELETE FROM User1 WHERE age >= 30;

// 실습 2-1. 기본키 실습
CREATE TABLE USER2 (
    ID      VARCHAR2(20) PRIMARY KEY,
    NAME    VARCHAR2(20),
    HP      CHAR(13),
    AGE     NUMBER(2)
);

INSERT INTO USER2 VALUES ('a101', '김유신', '010-1234-1001', 21);
INSERT INTO USER2 VALUES ('a102', '김춘추', '010-1234-1002', 23);
INSERT INTO USER2 VALUES ('a103', '장보고', '010-1234-1003', 25);





// 실습하기 2-2
CREATE TABLE USER3 (
    ID      VARCHAR2(20) PRIMARY KEY,
    NAME    VARCHAR2(20),
    HP      CHAR(13) UNIQUE,
    AGE     NUMBER(3)
);

INSERT INTO USER3 VALUES ('a101', '김유신', '010-1234-1001', 23);
INSERT INTO USER3 (ID, NAME, AGE) VALUES ('a102', '김춘추', 25);

// 실습하기 2-3
CREATE TABLE PARENT (
    PID VARCHAR2(20) PRIMARY KEY,
    NAME VARCHAR2(20),
    HP CHAR(13) UNIQUE
);

// VARCHAR로 해도 VARCHAR2로 알아서 생성됨
CREATE TABLE CHILD (
    CID VARCHAR2(20) PRIMARY KEY,
    NAME VARCHAR2(20),
    HP CHAR(13) UNIQUE,
    PARENT VARCHAR2(20), 
    FOREIGN KEY (PARENT) REFERENCES PARENT (PID)
);

INSERT INTO PARENT VALUES ('P101', '김서현', '010-1234-1001');
INSERT INTO PARENT VALUES ('P102', '이성계', '010-1234-1002');
INSERT INTO PARENT VALUES ('P103', '신사임당', '010-1234-1003');

INSERT INTO CHILD VALUES ('C101', '김유신', '010-1234-2001', 'P101');
INSERT INTO CHILD VALUES ('C102', '이방우', '010-1234-2002', 'P102');
INSERT INTO CHILD VALUES ('C103', '이방원', '010-1234-2003', 'P102');
INSERT INTO CHILD VALUES ('C104', '이이', '010-1234-2004', 'P103');

// 실습하기 2-4
CREATE TABLE USER4 (
    NAME    VARCHAR2(20) NOT NULL,
    GENDER  CHAR(1) NOT NULL,
    AGE     INT DEFAULT 1,
    ADDR    VARCHAR2(255)
);

INSERT INTO USER4 VALUES ('김유신', 'M', 23, '김해시');
INSERT INTO USER4 VALUES ('김춘추', 'M', 21, '경주시');
INSERT INTO USER4 (NAME, GENDER, ADDR) VALUES ('신사임당', 'F', '강릉시');
INSERT INTO USER4 (NAME, GENDER) VALUES ('이순신', 'M');
// GENDER NOT NULL이라 값 넣어줘야함
INSERT INTO USER4 (NAME, GENDER, AGE) VALUES ('정약용', 'M', 33);

// 실습하기 2-5
CREATE TABLE USER5 (
    NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(1) NOT NULL CHECK(GENDER IN('M', 'F')),
    AGE INT DEFAULT 1 CHECK(AGE > 0 AND AGE < 100),
    ADDR VARCHAR2(255)
);

INSERT INTO USER5 VALUES ('김유신', 'M', 23, '김해시');
INSERT INTO USER5 VALUES ('김춘추', 'M', 21, '경주시');
INSERT INTO USER5 (NAME, GENDER, ADDR) VALUES ('신사임당', 'F', '강릉시');
INSERT INTO USER5 (NAME, GENDER) VALUES ('이순신', 'M');
// GENDER NOT NULL이라 값 넣어줘야함
INSERT INTO USER5 (NAME, GENDER, AGE) VALUES ('정약용', 'M', 33);

// 실습 3-1.데이터 사전 조회 / DIC 아님 오타

SELECT * FROM DICT;
SELECT TABLE_NAME FROM USER_TABLES;
SELECT OWNER, TABLE_NAME FROM ALL_TABLES;
SELECT * FROM DBA_TABLES;
SELECT * FROM DBA_USERS;

// 실습하기 3-2 인덱스 조회/생성/삭제
-- 현재 사용자 인덱스 조회
SELECT * FROM USER_INDEXES;

-- 현재 사용자 인덱스 정보 조회
SELECT * FROM USER_IND_COLUMNS;

-- 인덱스 생성
CREATE INDEX IDX_USER1_ID ON USER1 (ID);
SELECT * FROM USER_IND_COLUMNS;

-- 인덱스 삭제
DROP INDEX IDX_USER1_ID;
SELECT * FROM USER_IND_COLUMNS;

// 실습 3-3. 뷰 생성 권한 할당
GRANT CREATE VIEW TO scott;

// 실습 3-4. 뷰 생성/조회/삭제
// 뷰 생성
CREATE VIEW VW_USER1 AS (SELECT NAME, HP, AGE FROM USER1);
CREATE VIEW VW_USER2_AGE_UNDER30 AS (
    SELECT * FROM USER2 WHERE AGE < 30
);
SELECT * FROM USER_VIEWS;

// 뷰 조회
SELECT * FROM VW_USER1;
SELECT * FROM VW_USER2_AGE_UNDER30;

// 뷰 삭제
DROP VIEW VW_USER1;
DROP VIEW VW_USER2_AGE_UNDER30;

// 실습 3-5. 시퀀스 실습
CREATE TABLE USER6 (
    SEQ     NUMBER PRIMARY KEY,
    NAME    VARCHAR2(20),
    GENDER  CHAR(1),
    AGE     NUMBER,
    ADDR    VARCHAR2(255)
);

// 실습 3-6. 시퀀스 생성
CREATE SEQUENCE SEQ_USER6 INCREMENT BY 1 START WITH 1;

// 실습 3-7. 시퀀스 값 입력
INSERT INTO USER6 VALUES (SEQ_USER6.NEXTVAL, '김유신', 'M', 25, '김해시');
INSERT INTO USER6 VALUES (SEQ_USER6.NEXTVAL, '김춘추', 'M', 23, '경주시');
INSERT INTO USER6 VALUES (SEQ_USER6.NEXTVAL, '신사임당', 'F', 27, '강릉시');

// 실습 4-1. 사용자 생성
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER hansan IDENTIFIED BY "1234";

// 실습 4-2. 사용자 조회
SELECT * FROM ALL_USERS;
// 대소문자 구분함 hansan으로는 조회 안 됨
SELECT * FROM ALL_USERS WHERE USERNAME='HANSAN';

// 실습 4-3. 사용자 변경
ALTER USER HANSAN IDENTIFIED BY "1234";
DROP USER hansan;
DROP USER hansan CASCADE;

// 실습 4-4. Role 부여
GRANT CONNECT, RESOURCE TO hansan;
GRANT UNLIMITED TABLESPACE TO hansan;