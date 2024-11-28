package kr.co.sist.user.board;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.co.sist.test.MyBatisHandler;

/**
 * 게시판의 리스트, 상세조회, 추가, 삭제, 변경 업무
 */
public class BoardDAO {

	private static BoardDAO bDAO;

	private BoardDAO() {
	}

	public static BoardDAO getInstance() {
		if (bDAO == null) {
			bDAO = new BoardDAO();
		} // end if
		return bDAO;
	}// getInstance

	/**
	 * 총 게시물의 수 검색
	 * 
	 * @param sVO
	 * @return 게시물의 수
	 * @throws SQLException
	 */
	public int selectTotalCount(SearchVO sVO) throws PersistenceException {
		int totalCount = 0;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {

			totalCount = handler.selectOne("kr.co.sist.board.totalCnt", sVO);

		} finally {
			// 7.연결 끊기
			mbh.closeHandler(handler);
		} // end finally
		return totalCount;
	}// selectTotalCount

	public List<MBoardDomain> selectBoard(SearchVO sVO) throws PersistenceException {
		List<MBoardDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {

			list = handler.selectList("kr.co.sist.board.selectBoard", sVO);

		} finally {
			// 7.연결 끊기
			mbh.closeHandler(handler);
		} // end finally

		return list;
	}// selectBoard

	/**
	 * 입력 값을 board 테이블에 추가하는 일
	 * 
	 * @param bVO
	 * @throws SQLException
	 */
	public int insertBoard(MBoardVO mVO) throws PersistenceException {

		int cnt = 0;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler(true);

		try {

			cnt = handler.insert("kr.co.sist.board.insertBoard", mVO);

		} finally {
			// 7.연결 끊기
			mbh.closeHandler(handler);
		} // end finally

		return cnt;
	}// insertBoard

	/**
	 * 입력된 글번호에 해당하는 글 하나 조회
	 * 
	 * @param num
	 * @return
	 * @throws SQLException
	 */
	public MBoardDomain selectDetailBoard(int num) throws PersistenceException {
		MBoardDomain mbDomain = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler(true);

		try {

			mbDomain = handler.selectOne("kr.co.sist.board.selectDetailBoard", num);
			if (mbDomain != null) {
				mbDomain.setNum(num);
			}
		} finally {
			// 7.연결 끊기
			mbh.closeHandler(handler);
		} // end finally

		return mbDomain;
	}// selectBoard

	/**
	 * 글번호와 아이디에 해당하는 글의 내용을 변경
	 * 
	 * @param bVO
	 * @return
	 * @throws SQLException
	 */
	public int updateBoard(MBoardVO mbVO) throws PersistenceException {
		int rowCnt = 0;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler(true);

		try {

			rowCnt = handler.update("kr.co.sist.board.updateBoard", mbVO);
		} finally {
			// 7.연결 끊기
			mbh.closeHandler(handler);
		} // end finally

		return rowCnt;
	}// updateBoard

	public int deleteBoard(MBoardVO mbVO) throws PersistenceException {
		int rowCnt = 0;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler(true);

		try {

			rowCnt = handler.update("kr.co.sist.board.deleteBoard", mbVO);

		} finally {
			// 7.연결 끊기
			mbh.closeHandler(handler);
		} // end finally

		return rowCnt;
	}// boardUpdate

	public static void main(String[] args) {

		SearchVO sVO = new SearchVO();

		/*
		 * sVO.setField("0"); sVO.setKeyword("오늘은");
		 */

		sVO.setStartNum(1);
		sVO.setEndNum(10);

		/*
		 * MBoardVO mbVO = new MBoardVO();
		 * 
		 * mbVO.setSubject("myBatis Test"); mbVO.setContent("오늘은 목요일");
		 * mbVO.setWriter("테스트"); mbVO.setIp("192.168.10.219"); mbVO.setPass("1234");
		 * 
		 * BoardDAO.getInstance().insertBoard(mbVO);
		 */

		System.out.println(BoardDAO.getInstance().selectBoard(sVO));
		System.out.println(BoardDAO.getInstance().selectDetailBoard(1));

	}

}// class
