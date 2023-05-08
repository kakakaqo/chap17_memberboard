[회원제 + 답변형 게시판]
[context.xml] 변경
 context.xml에서 데이터소스 관련 데이터베이스명 변경 잊지말것.

-- 1. 데이터베이스(계정) 생성 이미 만들어져 있으면 테이블 생성으로 이동
show user;
-- 12c 버전 부터는 아래 문장 실행후 계정 생성 
 ALTER SESSION SET "_ORACLE_SCRIPT"=true; 
 
 -- 계정(데이터베이스) 생성
create user memberboard identified by 1234;  

-- 새로 만든 계정(데이터베이스)에 권한 부역
--grant connect to memberboard;  -- DB 연결권한(권한취소 : revoke connect  from company)
--grant create table to memberboard;  -- 테이블 생성권한
--grant create view to memberboard; -- view  생성권한

--grant connect, resource, create view to hospital;

-- 전권한 부여
grant all privileges to memberboard;

-- 사용자 테이블 스페이스 사용 권한 부여
alter user memberboard default tablespace users quota unlimited on users;
drop table tbl_member;
drop table tbl_board;

-- 1. 회원(tbl_member) 테이블 생성
--drop table tbl_member cascade constraint;
 create table tbl_member (
    id varchar2(10),
    pwd varchar2(20) not null,
    name varchar2(10) not null,
    email varchar2(20),
    joindate date default sysdate,
    constraint pk_member_id primary key(id)
 ); 
 
-- 2. 게시판(tbl_board) 테이블 생성
-- drop table tbl_board  cascade constraint;
 create table tbl_board (
    no number, /* 게시물 번호 */
    title varchar2(100) not null, /* 제목 */
    content varchar2(4000) not null, /* 내용 */
    id varchar2(10), /* 작성자ID */
    hit number default 0,   /*  조회수 */
    regdate date default sysdate, /* 게시물 작성일 */
    
    reply_group number(5) default 0 not null, /* 글을 묶어주는 그룹 */
    reply_order number(5) default 0  not null, /* 그룹내 정렬순서 */
    reply_indent number(5) default 0  not null,    /* 글의 들여쓰기 */
    
    constraint pk_board_no primary key(no), /* 기본키 */
    constraint fk_board_id foreign key(id) 
         references tbl_member(id) /* 외래키-tbl_member의 id 참조 */
 );
 
 -- 3. tbl_board에서 사용할 게시물 번호 자동생성 시퀀스 만들기
create sequence seq_board_no increment by 1 start with 1;
 
 
-- 4. tbl_member 샘플 데이터 등록
--delete from tbl_member ;
insert into tbl_member(id, pwd, name, email, joindate) 
values ('user01', '1', 'John', 'john@example.com',  sysdate);

insert into tbl_member(id, pwd, name, email, joindate) 
values ('user02', '2', 'Sarah', 'sarah@example.com',  sysdate);

insert into tbl_member(id, pwd, name, email, joindate) 
values ('user03', '3', 'David', 'david@example.com',  sysdate);

insert into tbl_member(id, pwd, name, email, joindate) 
values ('user04', '4', 'Mary', 'mary@example.com',  sysdate-1);

insert into tbl_member(id, pwd, name, email, joindate) 
values ('user05', '5', 'Michael', 'michael@example.com', sysdate-2);
commit;

--5. tbl_board 샘플 데이터 등록
--delete from tbl_board;
Insert into TBL_BOARD (no,TITLE,CONTENT,id,hit,regdate,REPLY_GROUP,REPLY_ORDER,REPLY_INDENT) 
values (seq_board_no.nextval,'First Post','This is the first post.','user01',0,to_date('22/01/01','RR/MM/DD'),seq_board_no.currval,0,0);
Insert into TBL_BOARD (no,TITLE,CONTENT,id,hit,regdate,REPLY_GROUP,REPLY_ORDER,REPLY_INDENT) 
values (seq_board_no.nextval,'Second Post','This is the second post.','user02',0,to_date('22/01/02','RR/MM/DD'),seq_board_no.currval,0,0);
Insert into TBL_BOARD (no,TITLE,CONTENT,id,hit,regdate,REPLY_GROUP,REPLY_ORDER,REPLY_INDENT) 
values (seq_board_no.nextval,'Third Post','This is the third post.','user03',0,to_date('22/02/03','RR/MM/DD'),seq_board_no.currval,0,0);
Insert into TBL_BOARD (no,TITLE,CONTENT,id,hit,regdate,REPLY_GROUP,REPLY_ORDER,REPLY_INDENT) 
values (seq_board_no.nextval,'Fourth Post','This is the fourth post.','user04',0,to_date('22/03/04','RR/MM/DD'),seq_board_no.currval,0,0);
Insert into TBL_BOARD (no,TITLE,CONTENT,id,hit,regdate,REPLY_GROUP,REPLY_ORDER,REPLY_INDENT) 
values (seq_board_no.nextval,'Fifth Post','This is the fifth post.','user05',0,to_date('22/04/05','RR/MM/DD'),seq_board_no.currval,0,0);
Insert into TBL_BOARD (no,TITLE,CONTENT,id,hit,regdate,REPLY_GROUP,REPLY_ORDER,REPLY_INDENT) 
values (seq_board_no.nextval,'Sixth to First Post','This is a Sixth post.','user02',0,to_date('22/05/06','RR/MM/DD'),seq_board_no.currval,0,0);
Insert into TBL_BOARD (no,TITLE,CONTENT,id,hit,regdate,REPLY_GROUP,REPLY_ORDER,REPLY_INDENT) 
values (seq_board_no.nextval,'Seventh to First Post','This is Seventh post.','user03',0,to_date('22/06/07','RR/MM/DD'),seq_board_no.currval,0,0);
Insert into TBL_BOARD (no,TITLE,CONTENT,id,hit,regdate,REPLY_GROUP,REPLY_ORDER,REPLY_INDENT) 
values (seq_board_no.nextval,'Eight to Second Post','This is Eight post.','user04',0,to_date('22/07/08','RR/MM/DD'),seq_board_no.currval,0,0);
Insert into TBL_BOARD (no,TITLE,CONTENT,id,hit,regdate,REPLY_GROUP,REPLY_ORDER,REPLY_INDENT) 
values (seq_board_no.nextval,'Ninth to Second Post','This is Ninth post.','user05',0,to_date('22/08/08','RR/MM/DD'),seq_board_no.currval,0,0);
Insert into TBL_BOARD (no,TITLE,CONTENT,id,hit,regdate,REPLY_GROUP,REPLY_ORDER,REPLY_INDENT) 
values (seq_board_no.nextval,'Tenth to Third Post','This is a Tenth post.','user01',0,to_date('22/09/10','RR/MM/DD'),seq_board_no.currval,0,0);
commit;
 
2. 프로젝트 생성

3. 각종 드라이버 import
 - 오라클/taglibs/커넥션풀
 
4  ckeditor

5. images/reply_icon.gif

6. 
 
 
 
 
 
 
 
 
 //// 정리 필요 /////////////////////////////////////////////////////

[회원관리 기능]

1. 세션을 통한 로그인 정보 저장
 1) chap11_jsp_web0601 프로젝트의 다음 JSP 페이지를  member 폴더에 붙여넣기
  - memberList.jsp
  - memberForm.jsp - 이름 변경 -> memberInsertForm.jsp
  - memberUpdateForm.jsp
 2) jsp 내용에서 test06 폴더 경로를 -> member로 수정
 3) memberInsertForm.jsp 실행해서 결과 보기 -> 정상적으로 동작하면 다음단계
 4) MemberDao 싱글톤으로 변경작업(BoardDao참고) 
  - MemberDAO로 되어 있는지  클래스명 확인
  - MemberDao 메소드들 변경 작업
 5) 서블릿 생성작업
  - MemberInsertServlet : member_insert.jsp의 자바 소스 코드 부분을 복사/붙여넣기
  - MemberListServlet : memberList.jsp의 자바 소스 코드 부분을 복사/붙여넣기
  - MemberModifyServlet : member_Update.jsp의 자바 소스 코드 부분을 복사/붙여넣기
  - MemberDeleteServlet :
 6) 회원관리 테스트 실시 완료시 다음 작업으로 이동  

[로그인 + 세션, 쿠키 저장과 삭제]

1. 프로젝트 : chap11_jsp_web08 참고
2. 로그인 폼 복사 : session 폴더에 있는 loginForm.jsp, welcome.jsp 복사해서
3. WebContent / login 폴더에 붙여넣기
4. 로그인 처리 서블릿 : LoginServlet, LogoutServlet 복사 붙여넣기
5. MemberDao에 loginCheck() 메소드 추가(id/pwd 조회 쿼리)
6. login/loginForm.jsp 실행해서 로그인 작업 테스트하고 성공후
7. 로그인 서블릿과 로그아웃 서블릿에  쿠키 기능 추가
7. web.xml에 다음 문구 추가    
 - <welcome-file>login/loginForm.jsp</welcome-file>
8. 프로젝트 자체를 실행하면 login/loginForm.jsp가 첫화면으로 실행됨.

[게시판 기능 변경]
1. 게시물 작성시 로그인 유무 확인해서 안되었으면 로그인 유도하는 기능 추가
 - 

[리팩토링]
 - 외부적으로 드러나지 않지만 소프트웨어의 내부 구조를 개선하는 과정
1. 모든 기능이 완료되었을 때 리팩토링을 시작한다.
2. 로그인 서블릿과 멤버 관련 서블릿을 별도의 패키지로 이동
 - com.javalab.servlet.login 패키지 생성하여 이동시킴
3. com.javalab.servlet 패키지를 com.javalab.servlet.board로 변경


[답변형 게시판]


1. 데이터소스 Datasource - 커넥션 풀 관련 설정 확인
- context.xml 

 	<Resource name="jdbc/oracle" type="javax.sql.DataSource"
	    driverClassName="oracle.jdbc.driver.OracleDriver"
	    url="jdbc:oracle:thin:@127.0.0.1:1521:orcl"
	    username="board" 
	    password="1234" 
	    maxTotal="100" 
	    maxIdle="30" 
	    maxWaitMillis="10000" />  

2. 데이터베이스 추가사항
 1) 테이블 추가
  - 오라클 rownum에 대한 개념 설명
  - company 데이터베이스의 members 테이블 복사
  - board 데이터베이스에 board 테이블 추가
       기존 board 테이블이 있으면 다른 이름으로 생성. 기존 테이블에서 몇가지 필드 추가됨
 2) board 테이블 변동사항
  - 컬럼추가 : 부모글번호, 작성자ID-members 테이블의 id(기존 writer 삭제), 조회수
 3) sql 파일 참조 

3. 필요한 Library
 - common-dbcp2-2.9.0.jar 업뎃
 - jstl.jar
 - ojdbc8.jar
 - standard.jar
 
4. 기존 프로젝트에서 프로그램 복사
 1) chap11_jsp_web10 프로젝트에서 자바 패키지와 클래스(서블릿, vo, Dao)  
  - jsp 복사
  - ckeditor 복사
 2) chap11_jsp_web0601 프로젝트에서 jsp + java bean/servlet/dao 복사
 
5. 프로그램에 추가할 사항
 1) 필요시 0601에서 MembersVo vo 클래스 추가 
 
 
[SQL] 

1. 오라클 rownum 개념(hr_sql.sql 참고)

-- 1. 데이터베이스(계정) 생성
show user;
-- 12c 버전 부터는 아래 문장 실행후 계정 생성 
 ALTER SESSION SET "_ORACLE_SCRIPT"=true; 
 
 -- 계정(데이터베이스) 생성
create user board identified by 1234;  

-- 새로 만든 계정(데이터베이스)에 권한 부역
grant connect to board;  -- DB 연결권한(권한취소 : revoke connect  from company)
grant create table to board;  -- 테이블 생성권한
grant create view to board; -- view  생성권한
grant all privileges to board; -- 모든 권한 일괄 부여
commit;

-- 사용자 테이블 스페이스 사용 권한 부여
alter user board default tablespace users quota unlimited on users;

-- board 계정으로 접속 가능해짐. board 계정 접속 경로 설정

-- 7. sys 계정을 닫고 새로 만든 ky 계정으로 다시 접속
show user;
-- USER이(가) "BOARD"입니다.

-- board 데이터베이스에 board 테이블 생성
--drop table simple_board;
create table simple_board (
     no number(5),
     title varchar(50)  not null,
     content  varchar(1000) not null,
     writer varchar(50)  not null,
     hit number (5) default 0,
     regdate date default sysdate
       );
-- primary key constraint 추가
alter table simple_board add constraint pk_board primary key(no);
-- 시퀀스 생성(번호가 자동으로 1씩 증가)
create sequence seq_simple_board increment by 1 start with 1;
--drop sequence seq_simple_board;

--샘플 데이터 저장
insert into simple_board(no, title, content, writer, hit) values(seq_simple_board.nextval, 'title1', 'content1', 'writer1', 0);
insert into simple_board(no, title, content, writer, hit) values(seq_simple_board.nextval, 'title2', 'content2', 'writer2', 0);
insert into simple_board(no, title, content, writer, hit) values(seq_simple_board.nextval, 'title2', 'content2', 'writer2', 0);
commit;

select no, title, content, writer, hit, regdate from simple_board order by regdate desc;

create table members(
     id varchar2(20) primary key,
     pwd varchar2(20) not null,
     name varchar2(50) not null,
     email varchar2(100),
     joindate date default sysdate );

insert into members values ('dream', '1234', '이정미', 'dream@google.com', to_date('20190516', 'yyyy-mm-dd'));
insert into members values ('hong', '4567', '홍순남', 'hong@google.com', to_date('20170228', 'yyyy-mm-dd'));
insert into members values ('jsupark', '2596', '박준수', 'jsupark@google.com', to_date('20200120', 'yyyy-mm-dd'));
commit;
select * from members

-- board 데이터베이스에 board 테이블 생성
-- drop table board;
create table board (
     no number(5) primary key,
     title varchar(50)  not null,
     content  varchar(1000) not null,
     id  varchar2(20) references members(id),
     hit number (5) default 0,
     regdate date default sysdate,
     reply_ref number(5) default 0 not null,
     reply_lev number(5) default 0  not null,
     reply_seq number(5) default 0  not null
      );
-- primary key constraint 추가(테이블생성후 추가할경우에 사용)
--alter table board add constraint pk_board primary key(no);

-- 외래키 foreign key constraint 추가(테이블생성후 추가할경우에 사용)
-- alter table board add constraint fk_board foreign key(id) references members(id);


-- 시퀀스 생성(번호가 자동으로 1씩 증가)
--drop sequence seq_board;
create sequence seq_board increment by 1 start with 1;
commit;

--샘플 데이터 저장
insert into board(no, title, content, id, hit, regdate, reply_ref, reply_lev, reply_seq) values(seq_board.nextval, 'title1', 'content1', '1', 0, sysdate, seq_board.nextval, 0, 0);
insert into board(no, title, content, id, hit, regdate, reply_ref, reply_lev, reply_seq) values(seq_board.nextval, 'title2', 'content2', 'dream', 0, sysdate, seq_board.nextval, 0, 0);

select no, title, content, id, hit, regdate, reply_ref, reply_lev, reply_seq from board;
commit;

select id, pwd, name, email, to_char(joindate, 'yyyy-mm-dd') as joindate 
from members
where id = 'abcd';

-- 오라클 rownum
select no, title, content, id, hit, regdate, reply_ref, reply_lev, reply_seq
from(
     select rownum rnum, no, title, content, id, hit, regdate, reply_ref, reply_lev, reply_seq
     from (
          select no, title, content, id, hit, regdate, reply_ref, reply_lev, reply_seq
          from board
          order by reply_ref desc, reply_seq asc
     )
)
where rnum >= 1 and rnum <=10

update board set reply_seq= reply_seq + 1
where reply_ref = 34 and reply_seq  > 0
