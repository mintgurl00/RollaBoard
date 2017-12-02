package com.spring.rollaboard.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.rollaboard.board.BoardDAOService;
import com.spring.rollaboard.board.BoardVO;
import com.spring.rollaboard.cmt.CmtDAOService;
import com.spring.rollaboard.mem.MemDAOService;
import com.spring.rollaboard.mem.MemVO;
import com.spring.rollaboard.role.RoleAndTaskVO;
import com.spring.rollaboard.role.RoleDAOService;
import com.spring.rollaboard.role.RoleVO;
import com.spring.rollaboard.section.SectionDAOService;
import com.spring.rollaboard.section.SectionVO;
import com.spring.rollaboard.task.TaskDAOService;
import com.spring.rollaboard.task.TaskVO;

//깃 테스트
@Controller
public class ViewBoardController {

	@Autowired
	private CmtDAOService cmtDAOService;
	@Autowired
	private MemDAOService memDAOService;
	@Autowired
	private RoleDAOService roleDAOService;
	@Autowired
	private SectionDAOService sectionDAOService;
	@Autowired
	private TaskDAOService taskDAOService;
	@Autowired
	private BoardDAOService boardDAOService;
	
	private static final Logger logger = LoggerFactory.getLogger(ViewBoardController.class);
	

    
    @RequestMapping("board.do")
    public ModelAndView board( HttpSession session , HttpServletRequest request, HttpServletResponse response ) throws Exception {
    	/*
    	 * 석원이 지금 하고 있는 부분
    	 * 1. 참조하는 보드 명단 가져오기. 함. model만
    	 * 2. 태스크 예쁘게 보기. 하는 중
    	 * 2-1 섹션
    	 * 2-2 태스크
    	 * 2-3 롤
    	 * 3. 검색 & 필터
    	 * */
    	
    	ModelAndView result = new ModelAndView();
    	int board_id = 0;
    	System.out.println("세션 보드아이디 : " + session.getAttribute("board_id"));
    	System.out.println("리쿼스트 보드아이디 : " + request.getParameter("board_id"));
    	if (request.getParameter("board_id") == null) {
    		if (session.getAttribute("board_id") == null) {
    			List<BoardVO> boardList = boardDAOService.getBoards((String)(session.getAttribute("id"))); //수민. 대시보드로 갈 때 보드리스트 받아옴
    			result.addObject("boardList", boardList);
				result.setViewName("dashboard/dashboard");
				return result;
			}
    		board_id = Integer.parseInt((String) session.getAttribute("board_id")) ;	// 보드 id
		} else {
			board_id = Integer.parseInt((String) request.getParameter("board_id"));
		}
    	// board_id를 어디서도 받지 못했다면 대쉬보드로 간다.
    	if (board_id == 0) {
    		List<BoardVO> boardList = boardDAOService.getBoards((String)(session.getAttribute("id"))); //수민. 대시보드로 갈 때 보드리스트 받아옴
			result.addObject("boardList", boardList);
			result.setViewName("dashboard/dashboard");
			return result;
		}
    	String board_id2 = "" + board_id;
    	session.setAttribute("board_id", board_id2);
    	System.out.println("id=="+session.getAttribute( "id" ).toString());
    	String id = session.getAttribute( "id" ).toString() ;
    	  	
    	// 보드에 승인이 안되어 있으면 들어갈 수 없다.
    	String permission = boardDAOService.permitChk(board_id, id);
    	System.out.println("허가여부 : " + permission);
    	if (permission.equals("FALSE")) {
    		// alert처리단
    		response.setContentType("text/html; charset-utf-8");
    		PrintWriter out = response.getWriter();
            out.println("<script>alert('아직 승인되지 않았습니다.');</script>");
            out.flush(); 
        	List<BoardVO> boardList = boardDAOService.getBoards(id); // 보드리스트 받아옴
        	session.removeAttribute("board_id"); // 대쉬보드로 이동시 board_id 세션을 없앤다.
        	ArrayList<TaskVO> taskList = taskDAOService.getMyTasks(id);
        	// 회원정보수정시 기존 정보를 불러오기 위해 memDAOService.getMemInfoToUpdate를 사용한다(세션에서 ).
        	MemVO memVO = memDAOService.getMemInfoToUpdate((String)session.getAttribute("id"));
        	result.addObject("member", memVO);
        	result.addObject("taskList", taskList);
        	result.addObject("boardList", boardList);
            result.setViewName("dashboard/dashboard");
            return result;
		}
    	BoardVO boardVO = boardDAOService.getBoardInfo(board_id);
    	System.out.println( "id:" + id + ", board_id:" + board_id );
    	
    	/* ******************************************************************** */
    	// 참조 보드 리스트 추출
    	// 01. 참조 보드 리스트 추출
    	ArrayList<BoardVO> refBoardList = boardDAOService.getRefBoards( board_id );
    	System.out.println("참조보드리스트추출");
    	
		// ....을 전달
    	result.addObject( "refBoardList" , refBoardList ) ;
    	// 여기까지 석원구역.
    	/* ******************************************************************** */
    	// 회원정보수정시 기존 정보를 불러오기 위해 memDAOService.getMemInfoToUpdate를 사용한다(세션에서 ).
    	MemVO memVO = memDAOService.getMemInfoToUpdate((String)session.getAttribute("id"));
    	result.addObject("member", memVO);
    	result.addObject( "boardVO" , boardVO ) ;	// 쓸 데가 많을 것 같아서 전달합니다. view에서 request객체를 통해 참조할 수 있습니다.
    	result.setViewName("board/board");
        return result;
    }
    
    
	
    
    /*
     * 석원. 검색 결과
     * */
    @RequestMapping("searchresult.do")
	public ModelAndView searchresult( HttpServletRequest request ) {
    	ModelAndView result = new ModelAndView();
    	
    	int board_id = Integer.parseInt( (String) request.getParameter( "board_id" ) ) ;
    	String keyword = (String) request.getParameter( "keyword" ) ;
    	String filter = (String) request.getParameter( "filter" ) ; //선택된 checkBox의 name ex)due, priority, due priority
    	String[] filters = null ;
    	String[] orders = null ;	// 나중에 해야함
    	if( filter != null ){
	    	System.out.println( "필터 값 : " + filter ); // test
	    	StringTokenizer st = new StringTokenizer(filter," ");
	    	filters = new String[ st.countTokens() ] ; 
	    	for( int i = 0 ; i < filters.length ; i++ ){
	    		// st.hasMoreTokens() ;
	    		filters[ i ] = st.nextToken() ; //filters배열에는 선택된 필터들이 저장됨 ex)due, priority, due/priority
	    	}
	    	System.out.println( "전달된 필터 : " + filters.length +"개" );
	    	for( String filterString : filters ){
	    		System.out.print( filterString + " ");
	    	}
	    	System.out.println() ;
    	}else{
    		System.out.println( "전달된 필터는 없습니다." ) ;
    	}
    	/* ******************************************************************** */
    	// 아래부터는 석원 구역. 보드에 태스크 보여주기
    	
    	/*
    	 * 사실 이 부분에 보드멤버가 맞는지 확인하는 부분이 들어가야 한다.
    	 * (뭐, 어서 일단 넘어가구요.)
    	 * */
    	
    	// 01. 참조 보드 리스트 추출...은 할 필요 없고
    	// 02. 섹션 리스트 추출
    	ArrayList<SectionVO> sectionList = sectionDAOService.getSections( board_id ) ;
    	System.out.println("섹션리스트추출");
    	
    	
    	// 03. 태스크 리스트 추출
    	ArrayList<TaskVO> taskList ;
    	if( filters == null && orders == null ){
    		taskList = taskDAOService.getTasksByBoard2( board_id , keyword ) ;	// sql문에서 섹션별로 그룹해야 편할듯 + 섹션순서번호 정렬
    	} else {
    		taskList = taskDAOService.getTasksByBoard2( board_id , keyword , filters , orders ) ; //filters배열에는 선택된 필터들이 저장됨 ex)due, priority, due/priority
    	}
    	//ArrayList<TaskVO> taskList = taskDAOService.getTasksByBoard( board_id ) ;
    	System.out.println("태스크리스트추출 끝");
    	System.out.println("보드id:" + board_id + ", 키워드:" + keyword );
    	// 04. 롤 배치 리스트 추출
    	HashMap<Integer, ArrayList<RoleAndTaskVO>> ratHashMap = roleDAOService.getRATByTasks( board_id ) ;
    	ArrayList<ArrayList<ArrayList<RoleAndTaskVO>>> roleAndTaskList = new ArrayList<ArrayList<ArrayList<RoleAndTaskVO>>>() ;
    	
    	
    	// 태스크 배치
    	ArrayList<ArrayList<TaskVO>> taskViewList = new ArrayList<ArrayList<TaskVO>>() ;	// 태스크리스트 저장객체 생성
    	for( int i = 0 ; i < sectionList.size() ; i++ ){
    		taskViewList.add( new ArrayList<TaskVO>() ) ;	// 섹션 수만큼 칸을 만들고
    		roleAndTaskList.add( new ArrayList<ArrayList<RoleAndTaskVO>>() ) ;	// *RAT
    	}
    	
    	for( TaskVO task : taskList ){
    		int t_sid = task.getSection_id() ;	// 태스크의 섹션아이디
    		
    		for( int j = 0 ; j < sectionList.size() ; j++ ){	// 섹션리스트 하나하나 섹션아이디 확인
    			int sid = sectionList.get( j ).getId() ;
    			if( sid == t_sid ){
    				taskViewList.get( j ).add( task ) ;
    				int temp_id = task.getId() ;

    				ArrayList<RoleAndTaskVO> temp = ratHashMap.get( temp_id ) ;
    				roleAndTaskList.get( j ).add( temp ) ;	// *RAT
    				//roleAndTaskList.get( j ).add( ratHashMap.get( task.getId() ) ) ;	// *RAT
    				break ;
    			}
    		}
    	}
    	if( ! keyword.equals( "" ) ){	// 검색 결과 화면이라면
	    	for( int i = 0 ; i < taskViewList.size() ; i++ ){	// 태스크 없는 섹션은 지우기
	    		if( taskViewList.get(i).isEmpty() ){
	    			taskViewList.remove( i ) ;
	    			sectionList.remove( i ) ;
	    			roleAndTaskList.remove( i ) ;
	    			i-- ;
	    		}
	    	}
    	}
    	// 롤 배치(나중에 하려고 함)
    	//ArrayList<ArrayList<ArrayList<RoleVO>>> roleViewList ;
    	
		// ....을 전달
    	result.addObject( "roleAndTaskList" , roleAndTaskList ) ;
    	result.addObject( "sectionList" , sectionList ) ;
    	result.addObject( "taskViewList" , taskViewList ) ;
    	
    	// 여기까지 석원구역.
    	/* ******************************************************************** */
    	
    	//result.addObject( "rat_hasmap" , ratHashMap ) ;
    	BoardVO boardVO = boardDAOService.getBoardInfo(board_id);
    	result.addObject("boardVO", boardVO);
    	
    	result.addObject( "board_id" , board_id + "" ) ;
    	result.addObject( "keyword" , keyword ) ;
    	result.setViewName("board/searchresult");
		return result;
	}
    
    //참조보드 Modal로 보여주기
    @RequestMapping("referenceboard.do")
    public ModelAndView referenceboard( HttpSession session , HttpServletRequest request, HttpServletResponse response ) throws Exception {
    	ModelAndView result = new ModelAndView();
    	
    	System.out.println("보드 아이디: " + request.getParameter("board_id"));
    	System.out.println("참조보드 아이디: " + request.getParameter("ref_board_id"));
    	
    	int board_id = Integer.parseInt((String) request.getParameter("ref_board_id"));
    	
    	String keyword = (String) request.getParameter( "keyword" ) ;
    	String filter = (String) request.getParameter( "filter" ) ;
    	String[] filters = null ;
    	String[] orders = null ;	// 나중에 해야함
    	if( filter != null ){
	    	System.out.println( "필터 값 : " + filter ); // test
	    	StringTokenizer st = new StringTokenizer(filter," ");
	    	filters = new String[ st.countTokens() ] ; 
	    	for( int i = 0 ; i < filters.length ; i++ ){
	    		// st.hasMoreTokens() ;
	    		filters[ i ] = st.nextToken() ;
	    	}
	    	System.out.println( "전달된 필터 : " + filters.length +"개" );
	    	for( String filterString : filters ){
	    		System.out.print( filterString + " ");
	    	}
	    	System.out.println() ;
    	}else{
    		System.out.println( "전달된 필터는 없습니다." ) ;
    	}
    	/* ******************************************************************** */
    	// 아래부터는 석원 구역. 보드에 태스크 보여주기
    	
    	/*
    	 * 사실 이 부분에 보드멤버가 맞는지 확인하는 부분이 들어가야 한다.
    	 * (뭐, 어서 일단 넘어가구요.)
    	 * */
    	
    	// 01. 참조 보드 리스트 추출...은 할 필요 없고
    	// 02. 섹션 리스트 추출
    	ArrayList<SectionVO> sectionList = sectionDAOService.getSections( board_id ) ;
    	System.out.println("섹션리스트추출");
    	
    	
    	// 03. 태스크 리스트 추출
    	ArrayList<TaskVO> taskList ;
    	if( filters == null && orders == null ){
    		taskList = taskDAOService.getTasksByBoard2( board_id , keyword ) ;	// sql문에서 섹션별로 그룹해야 편할듯 + 섹션순서번호 정렬
    	} else {
    		taskList = taskDAOService.getTasksByBoard2( board_id , keyword , filters , orders ) ;	
    	}
    	//ArrayList<TaskVO> taskList = taskDAOService.getTasksByBoard( board_id ) ;
    	System.out.println("태스크리스트추출 끝");
    	System.out.println("보드id:" + board_id + ", 키워드:" + keyword );
    	// 04. 롤 배치 리스트 추출
    	HashMap<Integer, ArrayList<RoleAndTaskVO>> ratHashMap = roleDAOService.getRATByTasks( board_id ) ;
    	ArrayList<ArrayList<ArrayList<RoleAndTaskVO>>> roleAndTaskList = new ArrayList<ArrayList<ArrayList<RoleAndTaskVO>>>() ;
    	
    	
    	// 태스크 배치
    	ArrayList<ArrayList<TaskVO>> taskViewList = new ArrayList<ArrayList<TaskVO>>() ;	// 태스크리스트 저장객체 생성
    	for( int i = 0 ; i < sectionList.size() ; i++ ){
    		taskViewList.add( new ArrayList<TaskVO>() ) ;	// 섹션 수만큼 칸을 만들고
    		roleAndTaskList.add( new ArrayList<ArrayList<RoleAndTaskVO>>() ) ;	// *RAT
    	}
    	
    	for( TaskVO task : taskList ){
    		int t_sid = task.getSection_id() ;	// 태스크의 섹션아이디
    		
    		for( int j = 0 ; j < sectionList.size() ; j++ ){	// 섹션리스트 하나하나 섹션아이디 확인
    			int sid = sectionList.get( j ).getId() ;
    			if( sid == t_sid ){
    				taskViewList.get( j ).add( task ) ;
    				int temp_id = task.getId() ;

    				ArrayList<RoleAndTaskVO> temp = ratHashMap.get( temp_id ) ;
    				roleAndTaskList.get( j ).add( temp ) ;	// *RAT
    				//roleAndTaskList.get( j ).add( ratHashMap.get( task.getId() ) ) ;	// *RAT
    				break ;
    			}
    		}
    	}
    	if( ! keyword.equals( "" ) ){	// 검색 결과 화면이라면
	    	for( int i = 0 ; i < taskViewList.size() ; i++ ){	// 태스크 없는 섹션은 지우기
	    		if( taskViewList.get(i).isEmpty() ){
	    			taskViewList.remove( i ) ;
	    			sectionList.remove( i ) ;
	    			roleAndTaskList.remove( i ) ;
	    			i-- ;
	    		}
	    	}
    	}
    	// 롤 배치(나중에 하려고 함)
    	//ArrayList<ArrayList<ArrayList<RoleVO>>> roleViewList ;
    	
		// ....을 전달
    	result.addObject( "roleAndTaskList" , roleAndTaskList ) ;
    	result.addObject( "sectionList" , sectionList ) ;
    	result.addObject( "taskViewList" , taskViewList ) ;
    	
    	// 여기까지 석원구역.
    	/* ******************************************************************** */
    	
    	//result.addObject( "rat_hasmap" , ratHashMap ) ;
    	BoardVO boardVO = boardDAOService.getBoardInfo(board_id);
    	result.addObject("boardVO", boardVO);
    	result.addObject( "board_id" , board_id + "" ) ;
    	result.addObject( "keyword" , keyword ) ;
    	result.setViewName("board/searchresultref");
		return result;
		

    }

    
    
}

