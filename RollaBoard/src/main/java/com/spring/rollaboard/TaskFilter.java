package com.spring.rollaboard;

/*
 * 석원.
 * 태스크 필터, 정렬 지정용 enum입니다.
 * 필터 : ~가 있는 태스크만 보여줌
 * 정렬 : ~기준으로 오름차순, 내림차순 정렬
 * 
 * */
public enum TaskFilter {
	
	/*
	 * 없음
	 * */
	NONE,
	
	/*
	 * 필터
	 * */
	F_DUEDATE, F_PRIORITY, F_CONNECTED, F_ROLE,	// 마감기한, 우선순위, 연결태스크, 롤
	
	/*
	 * 정렬
	 * (접미 ASC는 오름차순, DESC는 내림차순)
	 * */
	DUEDATE_ASC, DUDATE_DESC,	// 마감 기한
	PRIORITY_ASC, PRIORITY_DESC,	// 중요도 값
	STARTDATE_ASC, STARTDATE_DESC,	// 시작일
	CREDATE_ASC, CREDATE_DESC,	// 생성일
	NAME_ASC, NAME_DESC,	// 태스크 이름
	STATUS_BNC, STATUS_BCN, STATUS_CBN, STATUS_CNB, STATUS_NBC, STATUS_NCB	// 상태(B:blocked, C:complete, N:normal)
	
}
