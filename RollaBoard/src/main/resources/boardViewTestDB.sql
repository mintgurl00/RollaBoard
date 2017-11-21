-----------------------------------------------------------------------------------------------------
-- ** 보드뷰에 태스크 잘 나오는지 확인하는 용도

-----아이디 : bb1
-----비밀번호 : 123
-----모든 데이터의 id는 500번대로 정했어요.

-- 테스트 계정
INSERT INTO mem (ID, PASSWORD, NAME) values ('bb1', '123', '임시름');
-- 테스트 보드(id는 원래 시퀀스로)
INSERT INTO board(id, name, admin) values ( 500, '정공준비TF(테스트)', 'bb1');
-- 보드~멤버
INSERT INTO board_mem(board_id, mem_id, permission, admin)
VALUES( 500 , 'bb1', 'TRUE', 'TRUE' ) ;

-- 테스트 섹션(id는 원래 시퀀스로)
INSERT INTO section(id, board_id, name, seq_num )
VALUES( 501, 500, '공연(샘플섹션1)', 1 );
INSERT INTO section(id, board_id, name, seq_num )
VALUES( 502, 500, '기획(샘플섹션2)', 2 );
INSERT INTO section(id, board_id, name, seq_num )
VALUES( 503, 500, '홍보(샘플섹션3)', 3 );

-- 테스트 태스크(id는 원래 시퀀스로)
INSERT INTO task( id, name, description, status, section_id )
VALUES( 501 , '공연팀 모집', '', 'COMPLETE', 501 ) ;
INSERT INTO task( id, name, description, status, section_id )
VALUES( 502 , '중간점검 날짜 정하기', '11월 중으로', 'COMPLETE', 501 ) ;
INSERT INTO task( id, name, description, status, section_id )
VALUES( 503 , '중간점검 실시', '', 'NORMAL', 501 ) ;
INSERT INTO task( id, name, description, status, section_id )
VALUES( 504 , '포스터 만들사람 찾기', '잘해야 함', 'NORMAL', 503 ) ;
INSERT INTO task( id, name, description, status, section_id )
VALUES( 505 , '공연장소 찾기', '', 'COMPLETE', 502 ) ;
INSERT INTO task( id, name, description, status, section_id )
VALUES( 506 , '공연장 예약', '황금극장:01040690266', 'NORMAL', 502 ) ;
INSERT INTO task( id, name, description, status, section_id )
VALUES( 507 , '뒷풀이 장소 찾기', '고기뷔페 ㄴㄴ', 'NORMAL', 502 ) ;
INSERT INTO task( id, name, description, status, section_id )
VALUES( 508 , '홍보 이벤트 회의', '하고 싶은 사람 아무나 모이라 그래', 'NORMAL', 503 ) ;

-- ** 보드뷰에 참조보드 잘 나오는지 확인하는 용도
-- 임시 계정(로그인해볼필요X)
INSERT INTO mem (ID, PASSWORD, NAME) values ('bb2', '123', '임시용');
-- 테스트 보드(id는 원래 시퀀스로)
INSERT INTO board(id, name, admin) values ( 501, '1년전정공준비(테스트)', 'bb2');
-- 테스트 보드(id는 원래 시퀀스로)
INSERT INTO board(id, name, admin) values ( 502, '다른사람보드(테스트)', 'bb2');
-- 보드 참조 연결
INSERT INTO board_ref(board_id, ref_id) VALUES(500,501);
INSERT INTO board_ref(board_id, ref_id) VALUES(500,502);

ALTER TABLE SECTION ADD(SEQ_NUM NUMBER);

commit;

SELECT * FROM section ;
SELECT  * FROM board_mem ;
SELECT * FROM board ;

SELECT * FROM board_ref ;
-------------------------------------------------------------------------------------------