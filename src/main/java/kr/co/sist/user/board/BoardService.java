package kr.co.sist.user.board;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;

public class BoardService {

	private static BoardService bs;

	private BoardService() {

	}

	public static BoardService getInstance() {
		if (bs == null) {
			bs = new BoardService();
		}
		return bs;
	}

	public List<MBoardDomain> searchBoard(SearchVO sVO) {

		List<MBoardDomain> list = null;

		BoardDAO bDAO = BoardDAO.getInstance();

		try {
			list = bDAO.selectBoard(sVO);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return list;
	}// searchBoard

	/**
	 * 1. 총 레코드 수 구하기
	 * 
	 * @param sVO
	 * @return
	 */
	public int totalCount(SearchVO sVO) {
		int cnt = 0;

		BoardDAO bDAO = BoardDAO.getInstance();

		try {
			cnt = bDAO.selectTotalCount(sVO);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return cnt;
	}// totalCount

	/**
	 * 2. 한 화면에 보여줄 레코드의 수
	 * 
	 * @return
	 */
	public int pageScale() {

		int pageScale = 10;
		return pageScale;
	}// pageScale

	/**
	 * 3. 총 페이지 수
	 * 
	 * @return
	 */
	public int totalPage(int totalCount, int pageScale) {

		int totalPage = (int) Math.ceil((double) totalCount / pageScale);

		return totalPage;
	}// totalPage

	/**
	 * 4. 현재 페이지 구하기
	 * 
	 * @param paramPage
	 * @param pageScale
	 * @return
	 */
	public int currentPage(String paramPage) {

		int currentPage = 1;
		if (paramPage != null) {
			try {
				currentPage = Integer.parseInt(paramPage);
			} catch (NumberFormatException nfe) {
			} // end catch
		} // end if

		return currentPage;
	}

	/**
	 * 5. 검색의 시작번호를 구하기 ( pagination의 번호) [1][2][3]
	 * 
	 * @param paramPage
	 * @param pageScale
	 * @return
	 */
	public int startNum(String paramPage, int currentPage, int pageScale) {

		int startNum = currentPage * pageScale - pageScale + 1;// 시작번호

		return startNum;
	}// startNum

	/**
	 * 6. 끝번호 구하기
	 * 
	 * @return
	 */
	public int endNum(int startNum, int pageScale) {

		int endNum = startNum + pageScale - 1; // 끝 번호

		return endNum;
	}// endNum

	public void changeLength(List<MBoardDomain> listBoard) {

		String tempSubject = "";
		for (MBoardDomain tempVO : listBoard) {
			tempSubject = tempVO.getSubject();
			if (tempSubject.length() > 30) {
				tempVO.setSubject(tempSubject.substring(0, 29) + "...");
			}
		} // end for
	}// changeLength

	public boolean writeBoard(MBoardVO mbVO) {

		boolean flag = false;

		try {

			flag = BoardDAO.getInstance().insertBoard(mbVO) == 1 ? true : false;

		} catch (PersistenceException pe) {
			// TODO: handle exception
			pe.printStackTrace();
		}

		return flag;
	}// writeBoard

	public MBoardDomain searchDetailBoard(int num) {

		MBoardDomain mbDomain = null;

		try {

			mbDomain = BoardDAO.getInstance().selectDetailBoard(num);

		} catch (PersistenceException pe) {

			pe.printStackTrace();

		}
		return mbDomain;
	}// searchDetailBoard

	public boolean modifyBoard(MBoardVO mbVO) {

		boolean flag = false;

		try {
			flag = BoardDAO.getInstance().updateBoard(mbVO) == 1;
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}
		return flag;
	}// modifyBoard

	public boolean removeBoard(MBoardVO mbVO) {

		boolean flag = false;

		try {
			flag = BoardDAO.getInstance().deleteBoard(mbVO) == 1;
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}
		return flag;
	}// removeBoard

}// class
