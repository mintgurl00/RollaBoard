-- table 초기화 쿼리
drop table task_conn;
drop table cmt;
drop sequence seq_cmt;
drop table task_role;
drop table task;
drop sequence seq_task;
drop table section;
drop sequence seq_section;
drop table role_mem;
drop table role;
drop sequence seq_role;
drop table board_mem;
drop table board_ref;
drop table board;
drop sequence seq_board;
drop table mem;


-- 사람 테이블
--drop table mem;
Create table mem (
    id varchar2(20) primary key,
    password varchar2(20) not null,
    name varchar2(20) ,
    email varchar2(30)
    );

-- 보드 아이디에 사용될 시퀀스
--drop sequence seq_board;
Create sequence seq_board
start with 1
increment by 1
maxvalue 5000;

-- 보드
--drop table board;
Create table board (
    id number primary key,
    name varchar2(50) unique,
    admin references mem(id) on delete cascade,
    visibility varchar2(5) default 'FALSE' not null CONSTRAINT chk_visibility CHECK ( visibility in ('TRUE', 'FALSE'))
    );

-- 보드-참조
--drop table board_ref;
Create table board_ref (
    board_id number references board(id) on delete cascade,
    ref_id number references board(id) on delete cascade,
    primary key(board_id, ref_id)
    );
    
-- 보드-사람
--drop table board_mem;
Create table board_mem (
    board_id number references board(id) on delete cascade,
    mem_id varchar2(20) references mem(id) on delete cascade,
    permission varchar2(5) default 'FALSE' not null CONSTRAINT chk_permission CHECK ( permission in ('TRUE', 'FALSE')),
    admin varchar2(5) default 'FALSE' not null CONSTRAINT chk_admin CHECK ( admin in ('TRUE', 'FALSE')),
    primary key(board_id, mem_id)
    );
    
-- 롤 아이디에 사용될 시퀀스
--drop sequence seq_board;
Create sequence seq_role
start with 1
increment by 1
maxvalue 5000;

-- 롤 테이블
--drop table role;
Create table ROLE (
    id number primary key,
    board_id references board(id) on delete cascade,
    name varchar2(20),
    description varchar2(100)
    );
    
-- 롤-사람
--drop table role_mem;
Create table role_mem (
    role_id  references role(id) on delete cascade,
    mem_id references mem(id) on delete cascade,
    primary key(role_id, mem_id)
    );

-- 대분류 아이디에 사용될 시퀀스
--drop sequence seq_section;
Create sequence seq_section
start with 1
increment by 1
maxvalue 10000;

-- 대분류
--drop table section;
Create table section (
    id number primary key,
    board_id references board(id),
    name varchar2(30)
    );

-- 태스크 아이디에 사용될 시퀀스
--drop sequence seq_task;
Create sequence seq_task
start with 1
increment by 1
maxvalue 20000;

-- 태스크
--drop table task;
Create table task (
    id number primary key,
    name varchar2(30),
    description varchar2(100),
    status varchar2(10) default 'BLOCKED' not null CONSTRAINT chk_status CHECK (status in ('BLOCKED', 'NORMAL', 'COMPLETE')),
    section_id number references section(id) on delete cascade,
    start_date date,
    due_date date,
    cre_date date,
    priority number(1)
    );
    
-- 태스크-롤
--drop table task_role;
Create table task_role (
    task_id references task(id) on delete cascade,
    role_id references role(id) on delete cascade,
    primary key(task_id, role_id)
    );
    
-- 댓글 아이디에 사용될 시퀀스
--drop sequence seq_cmt;
Create sequence seq_cmt
start with 1
increment by 1
maxvalue 30000;

-- 댓글
--drop table cmt;
Create table cmt (
    id number primary key,
    task_id references task(id) on delete cascade,
    cre_date date,
    mem_id references mem(id) on delete set null,
    content varchar2(200)
    );
    
-- 태스크 관계
--drop table task_conn;
Create table task_conn (
    root_task_id references task(id) on delete set null,
    task_id references task(id) on delete set null,
    ref_level number default 0,
    primary key (task_id)
    );
    
insert into mem (ID, PASSWORD, NAME) values ('cdcase', '123456', '최규성');
insert into board(id, name, admin) values (seq_board.nextval, '첫번째 작업', 'cdcase');
select * from board;