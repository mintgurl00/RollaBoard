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
    description varchar2(100),
    color varchar2(10) --alter table role add (color varchar2(10)); 이거로 컬럼추가하시면 됩니다 뒤에부터는 디폴트 색 지정: alter table role modify (color default '#7A7A7A');
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
    name varchar2(30),
    seq_num number
    color varchar(2) --alter table section add (color varchar2(10)); 뒤에부터는 디폴트 색 지정 : alter table section modify (color default '#EAEAEA');
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
    description varchar2(500), --ALTER TABLE task MODIFY description varchar2(500);  100에서 500으로 용량 높임. 
    status varchar2(10) default 'NORMAL' not null CONSTRAINT chk_status CHECK (status in ('BLOCKED', 'NORMAL', 'COMPLETE')),
    section_id number references section(id) on delete cascade,
    start_date date,
    due_date date,
    cre_date date,
    location varchar2(40),--ALTER TABLE task ADD location varchar(40); 이걸로 추가하세요.-석원
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
    
-----------------------------------------------------------------------------------------------------------------------
-----------------------아래는 채팅 기능에 필요한 DB
------------------------------수정 중
-------채팅 룸
DROP TABLE chatroom0;
CREATE TABLE chatroom0 (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    description VARCHAR2(500),
    board_id NUMBER, -- REFERENCES board(id) ON DELETE CASCADE
    visibility varchar2(10) default 'PUBLIC' not null 
        CONSTRAINT chk_ch_visib CHECK ( visibility in ('PUBLIC', 'PRIVATE', 'PROTECTED')),
    type varchar2(15) default 'MEM_CHN' not null 
        CONSTRAINT chk_ch_type CHECK ( type in ('MEM_CHN', 'ROLE_CHN', 'MESSAGE')),
    cre_mem_id VARCHAR2(20)
);
SELECT * FROM chatroom0 ;

-- 채팅 룸 아이디 시퀀스
drop sequence seq_ch;
Create sequence seq_ch
start with 1
increment by 1
maxvalue 5000;

------채팅 멤버
DROP TABLE chat_mem0;
CREATE TABLE chat_mem0 (
    ch_id NUMBER, -- REFERENCES chatroom(id) ON DELETE CASCADE
    mem_id VARCHAR2(20), -- REFERENCES mem(id) ON DELETE CASCADE
    role_id NUMBER, -- REFERENCES role(id) ON DELETE CASCADE
    PRIMARY KEY(ch_id, mem_id, role_id)
);
SELECT * FROM chat_mem0;

-------메시지
DROP TABLE message0;
CREATE TABLE message0 (
    id NUMBER PRIMARY KEY,
    ch_id NUMBER, -- REFERENCES chatroom(id) ON DELETE CASCADE
    mem_id VARCHAR2(20), -- REFERENCES mem(id) ON DELETE CASCADE
    role_id NUMBER, -- REFERENCES role(id) ON DELETE CASCADE
    text VARCHAR2(500),
    cre_date DATE -- SYSTIMESTAMP
);
SELECT * FROM message0;
-- 메시지 시퀀스
drop sequence seq_msg;
Create sequence seq_msg
start with 1
increment by 1
maxvalue 50000;

-------채팅 룸 리스트
DROP TABLE chat_list0 ;
CREATE TABLE chat_list0 (
    mem_id VARCHAR2(20), -- REFERENCES mem(id) ON DELETE CASCADE
    ch_id NUMBER, -- REFERENCES chatroom(id) ON DELETE CASCADE
    visibility VARCHAR2(10) default 'VISIBLE'
        CONSTRAINT chk_chlist_visib CHECK ( visibility in ('VISIBLE', 'HIDDEN') ),
    status VARCHAR2(5) default 'IN'
        CONSTRAINT chk_chlist_stat CHECK ( status in ('IN', 'OUT') ),
    recent_date DATE, -- SYSTIMESTAMP
    PRIMARY KEY(mem_id, ch_id)
) ;
SELECT * FROM chat_list0;
    
-----------------------------------------------------------------------------------------------------------------------
-- 여기까지 테이블, 시퀀스 생성
-- --테이블 바꿀 때에는 반드시 공유파일(DB모델링)에 기록할 것.
-- 아래부터 샘플 데이터 삽입
-----------------------------------------------------------------------------------------------------------------------
insert into mem (ID, PASSWORD, NAME) values ('cdcase', '123456', '최규성');
insert into board(id, name, admin) values (seq_board.nextval, '첫번째 작업', 'cdcase');
select * from board;