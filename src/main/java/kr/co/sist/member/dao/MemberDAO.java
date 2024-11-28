package kr.co.sist.member.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.co.sist.test.MyBatisHandler;

public class MemberDAO {

	private static MemberDAO mDAO;

	private MemberDAO() {

	}

	public static MemberDAO getInstance() {

		if (mDAO == null) {

			mDAO = new MemberDAO();

		}
		return mDAO;

	}// getInstance

	/**
	 * 회원정보 조회
	 * 
	 * @param id 중복검사할 아이디
	 * @return
	 * @throws PersistenceException
	 */
	public List<WebMemberVO> selectId(String id) throws PersistenceException {
		List<WebMemberVO> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		// 1. MyBatis Handler 얻기
		SqlSession handler = mbh.getHandler();
		try {
			// 2. id에 해당하는 node를 찾아서, parsing하여 쿼리문 실행, 결과 얻기
			list = handler.selectList("kr.co.sist.member.selectId", id);

		} finally {
			// 3. Handler닫기
			mbh.closeHandler(handler);
		}
		return list;
	}// selectId

	/**
	 * 회원정보를 추가
	 * 
	 * @param wmVO
	 * @throws SQLException
	 */
	public int insertWebMember(WebMemberVO wmVO) throws PersistenceException {

		int cnt = 0;

		MyBatisHandler mbh = MyBatisHandler.getInstance();

		// 1. MyBatis Handler 얻기
		SqlSession handler = mbh.getHandler();
		try {

			// 2. id에 해당하는 node를 찾아서, parsing하여 쿼리문 실행, 결과 얻기
			cnt = handler.insert("kr.co.sist.member.insertWebMember", wmVO);
			handler.commit(); // 커밋

			if (wmVO.getLang() != null) {
				// insertLang(wmVO);// 관심언어 DB추가
			} // end if
		} finally {
			mbh.closeHandler(handler);
		} // end finally

		return cnt;
	}// insertWebMember

	public int insertLang(WebMemberVO wmVO) throws PersistenceException {
		int cntLang = 0;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			// wmVO 객체를 그대로 전달하여 lang 배열을 처리
			cntLang = handler.insert("kr.co.sist.member.insertLang", wmVO);

			// 실행된 후 변경된 행 수를 확인
			if (cntLang > 0) {
				System.out.println("언어 삽입 성공: " + cntLang + "행 삽입됨");
			} else {
				System.out.println("언어 삽입 실패");
			}

		} catch (Exception e) {
			e.printStackTrace(); // 디버깅을 위한 예외 출력
			throw new PersistenceException("언어 삽입 오류", e);
		} finally {
			// handler 종료
			mbh.closeHandler(handler);
		}

		return cntLang;
	}

}
