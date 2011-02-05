CREATE TABLE EMP
(EMPNO NUMBER(4) NOT NULL,
     ENAME VARCHAR2(10),
     JOB VARCHAR2(9),
     MGR NUMBER(4),
     HIREDATE DATE,
     SAL NUMBER(7, 2),
     COMM NUMBER(7, 2),
     DEPTNO NUMBER(2),
     CONSTRAINT PK_EMP PRIMARY KEY(EMPNO),
     CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTNO) REFERENCES DEPT
);

CREATE TABLE DEPT
(DEPTNO NUMBER(2),
     DNAME VARCHAR2(14),
     LOC VARCHAR2(13),
     CONSTRAINT PK_DEPT PRIMARY KEY(DEPTNO)
);

CREATE TABLE album (
  site_id     INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
  url         TEXT,
  description TEXT,
  data        TEXT
);
