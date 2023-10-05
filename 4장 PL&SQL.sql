/**
    날짜 : 2023/10/05
    이름 : 박한산
    내용 : 4장 PL/SQL 실습
*/

-- 실습 1-1.Hello Oracle 출력
SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello Oracle!');
END;

-- 실습 1-2. 주석 처리
DECLARE
    NO NUMBER(4) := 1001;
    NAME VARCHAR2(10) := '홍길동';
    HP CHAR(13) := '010-1000-1001';
    ADDR VARCHAR2(100) := '부산광역시';
BEGIN
    DBMS_OUTPUT.PUT_LINE('번호 : ' || NO);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('전화 : ' || HP);
    DBMS_OUTPUT.PUT_LINE('주소 : ' || ADDR);
END;

-- 실습 2-1. 변수 선언 및 변수값 출력
-- 콘솔 출력이 안될 경우 실행
SET SERVEROUTPUT ON;

DECLARE
    NO CONSTANT NUMBER(4) := 1001;
    NAME VARCHAR2(10);
    HP CHAR(13) := '000-0000-0000';
    AGE NUMBER(2) DEFAULT 1;
    ADDR VARCHAR2(10) NOT NULL := '부산';
BEGIN
    NAME := '김유신';
    HP := '010-1000-1001';
    DBMS_OUTPUT.PUT_LINE('번호 : ' || NO);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('전화 : ' || HP);
    DBMS_OUTPUT.PUT_LINE('나이 : ' || AGE);
    DBMS_OUTPUT.PUT_LINE('주소 : ' || ADDR);
END;

-- 실습 2-2. 열 참조형 변수 실습
DECLARE
    NO DEPT.DEPTNO%TYPE;
    NAME DEPT.DNAME%TYPE;
    ADDR DEPT.LOC%TYPE;
BEGIN
    SELECT * 
    INTO NO, NAME, ADDR
    FROM DEPT
    WHERE DEPTNO = 30;
    
    DBMS_OUTPUT.PUT_LINE('부서번호 : ' || NO);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('부서주소 : ' || ADDR);
END;

-- 실습 2-3. 행 참조형 변수 실습
DECLARE
    -- 선언
    ROW_DEPT DEPT%ROWTYPE;
BEGIN
    -- 처리
    SELECT * 
    INTO ROW_DEPT 
    FROM DEPT
    WHERE DEPTNO = 40;
 
    -- 출력
    DBMS_OUTPUT.PUT_LINE('부서번호 : ' || ROW_DEPT.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || ROW_DEPT.DNAME);
    DBMS_OUTPUT.PUT_LINE('주소 : ' || ROW_DEPT.LOC);
END;

-- 실습 2-4. 레코드 자료형 기본 실습
DECLARE
     -- 정의
     TYPE REC_DEPT IS RECORD (
     deptno NUMBER(2),
     dname DEPT.DNAME%TYPE,
     loc DEPT.LOC%TYPE
 );
     -- 선언 
     dept_rec REC_DEPT; -- dept_rec가 REC_DEPT 레코드를 따름
     
BEGIN
     dept_rec.deptno := 10;
     dept_rec.dname := '개발부';
     dept_rec.loc := '부산'; 
     -- 출력
     DBMS_OUTPUT.PUT_LINE('deptno : ' || dept_rec.deptno);
     DBMS_OUTPUT.PUT_LINE('dname : ' || dept_rec.dname);
     DBMS_OUTPUT.PUT_LINE('loc : ' || dept_rec.loc); 
     DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 실습 2-5. 레코드 INSERT 실습 
CREATE TABLE DEPT_RECORD AS SELECT * FROM DEPT WHERE 1 = 0; -- 테이블 복사

DECLARE
     -- 정의
     TYPE REC_DEPT IS RECORD (
     deptno NUMBER(2),
     dname DEPT.DNAME%TYPE,
     loc DEPT.LOC%TYPE
 );
     -- 선언
     dept_rec REC_DEPT;
     
BEGIN
     dept_rec.deptno := 10;
     dept_rec.dname := '개발부';
     dept_rec.loc := '부산'; 
     
     INSERT INTO DEPT_RECORD VALUES dept_rec;
     -- 출력
     --DBMS_OUTPUT.PUT_LINE('deptno : ' || dept_rec.deptno);
     --DBMS_OUTPUT.PUT_LINE('dname : ' || dept_rec.dname);
     --DBMS_OUTPUT.PUT_LINE('loc : ' || dept_rec.loc); 
     --DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 실습 2-6. 레코드를 포함하는 레코드 실습
DECLARE
     -- 정의
     TYPE REC_DEPT IS RECORD (
     deptno     DEPT.DEPTNO%TYPE,
     dname      DEPT.DNAME%TYPE,
     loc        DEPT.LOC%TYPE
 );
     TYPE REC_EMP IS RECORD (
         empno      EMP.EMPNO%TYPE,
         ename      EMP.ENAME%TYPE,
         dinfo      REC_DEPT
    );

    emp_rec REC_EMP;
    
BEGIN
    SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
    INTO
        emp_rec.empno,
        emp_rec.ename,
        emp_rec.dinfo.deptno,
        emp_rec.dinfo.dname,
        emp_rec.dinfo.loc
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND E.EMPNO = 7788;
        
     DBMS_OUTPUT.PUT_LINE('EMPNO : ' || emp_rec.empno);
     DBMS_OUTPUT.PUT_LINE('ENAME : ' || emp_rec.ename); 
     DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || emp_rec.dinfo.deptno);
     DBMS_OUTPUT.PUT_LINE('DNAME : ' || emp_rec.dinfo.dname);
     DBMS_OUTPUT.PUT_LINE('LOC : ' || emp_rec.dinfo.loc);
     DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 실습 2-7. 테이블(연관배열) 기본 실습
DECLARE
    TYPE ARR_CITY IS TABLE OF VARCHAR2(20) INDEX BY PLS_INTEGER;
    arrCity ARR_CITY;
BEGIN
    arrCity(1) := '서울';
    arrCity(2) := '대전';
    arrCity(3) := '부산';
    
    DBMS_OUTPUT.PUT_LINE('arrCity(1) : ' || arrCity(1));
    DBMS_OUTPUT.PUT_LINE('arrCity(2) : ' || arrCity(2));
    DBMS_OUTPUT.PUT_LINE('arrCity(3) : ' || arrCity(3));
    
END;

-- 실습 3-1. IF문 실습
DECLARE
    NUM NUMBER := 1;
BEGIN
     IF NUM > 0 THEN
        DBMS_OUTPUT.PUT_LINE('NUM은 0보다 크다.');
     END IF; 
     DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 실습 3-2. IF~ELSE 실습
DECLARE
     NUM NUMBER := -1;
BEGIN
     IF NUM > 0 THEN
        DBMS_OUTPUT.PUT_LINE('NUM은 0보다 크다.');
     ELSE
        DBMS_OUTPUT.PUT_LINE('NUM은 0보다 작다.');
     END IF; 
     DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 실습 3-3. IF~ELSIF 실습
DECLARE
    SCORE NUMBER := 86;
BEGIN
     IF SCORE >= 90 AND SCORE <= 100 THEN
        DBMS_OUTPUT.PUT_LINE('A 입니다.');
     ELSIF SCORE >= 80 AND SCORE < 90 THEN
        DBMS_OUTPUT.PUT_LINE('B 입니다.');
     ELSIF SCORE >= 70 AND SCORE < 80 THEN
        DBMS_OUTPUT.PUT_LINE('C 입니다.');
     ELSIF SCORE >= 60 AND SCORE < 70 THEN
        DBMS_OUTPUT.PUT_LINE('D 입니다.');
     ELSE
        DBMS_OUTPUT.PUT_LINE('F 입니다.'); 
     END IF; 
     DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;


-- 실습 3-4. CASE 실습
DECLARE
    SCORE NUMBER := 86;
BEGIN
     CASE FLOOR(SCORE/10) -- FLOOR : 버림
         WHEN 9 THEN DBMS_OUTPUT.PUT_LINE('A 입니다.');
         WHEN 8 THEN DBMS_OUTPUT.PUT_LINE('B 입니다.');
         WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('C 입니다.');
         WHEN 6 THEN DBMS_OUTPUT.PUT_LINE('D 입니다.');
         ELSE DBMS_OUTPUT.PUT_LINE('F 입니다.'); 
     END CASE; 
     DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 실습 3-5. 기본 LOOP 실습
DECLARE
    NUM NUMBER := 0;
BEGIN
     LOOP
        DBMS_OUTPUT.PUT_LINE('NUM : ' || NUM);
        NUM := NUM + 1;
     
     IF NUM > 3 THEN
        EXIT;
        END IF;
     END LOOP; 
     DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 실습 3-6. 기본 FOR 실습
BEGIN
     FOR i IN 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE('i : ' || i);
     END LOOP; 
     DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 실습 3-7. 기본 WHILE 실습
DECLARE
    NUM NUMBER := 0;
BEGIN
     WHILE NUM < 4 LOOP
        DBMS_OUTPUT.PUT_LINE('NUM : ' || NUM);
        NUM := NUM + 1; 
     END LOOP; 
     DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 실습 3-8. CONTINUE 실습
DECLARE
    NUM NUMBER := 0;
BEGIN
     WHILE NUM < 5 LOOP 
         NUM := NUM + 1;
         
         -- MOD(): 나머지를 구하는 SQL함수 
         IF MOD(NUM, 2) = 0 THEN 
            CONTINUE; -- NUM 2, 4 는 루프로 CONTINUE 한다, 그래서 출력안됨
         END IF; -- IF문 끝날때는 항상 END IF
         DBMS_OUTPUT.PUT_LINE('NUM : ' || NUM);
     END LOOP; 
     DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 실습 3-9. CONTINUE-WHEN 실습
BEGIN
     FOR i IN 1..5 LOOP
         CONTINUE WHEN MOD(i, 2) = 0; -- i = 2, 4는 루프로 바로
         DBMS_OUTPUT.PUT_LINE('i : ' || i);
     END LOOP; 
     DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 실습 4-1. 단일 행 결과를 처리하는 커서
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
    
    CURSOR c1 IS SELECT * FROM DEPT WHERE DEPTNO=40;
BEGIN

    OPEN c1;
    FETCH c1 INTO V_DEPT_ROW;
    
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);
END;

-- 실습 4-2. 여러 행 결과를 처리하는 커서
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
    
    CURSOR c1 IS SELECT * FROM DEPT;
BEGIN
    OPEN c1;
    
    LOOP
        FETCH c1 INTO V_DEPT_ROW;
        EXIT WHEN c1%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);
    END LOOP;
    
    CLOSE c1;
        
END;





