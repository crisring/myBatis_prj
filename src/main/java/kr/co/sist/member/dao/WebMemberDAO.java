package kr.co.sist.member.dao;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.co.sist.test.MyBatisHandler;

public class WebMemberDAO {

	private static WebMemberDAO wmDAO;

	private WebMemberDAO() {

	}

	public static WebMemberDAO getInstance() {

		if (wmDAO == null) {

			wmDAO = new WebMemberDAO();
		}
		return wmDAO;
	}// getInstance

	public String selectIdDup(String id) throws PersistenceException {

		String resultId = "";

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			resultId = handler.selectOne("kr.co.sist.member.selectIdDup", id);

		} finally {

			mbh.closeHandler(handler);
		}

		return resultId;
	}// selectIdDup

	public int insertWebMember(WebMemberVO wmVO, WebMemberLangVO[] wmlVO) throws PersistenceException {

		int cnt = 0;
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler(false);

		try {

			cnt = handler.insert("kr.co.sist.member.insertMember", wmVO);

			int langCnt = 0;
			if (wmlVO != null) {

				langCnt = wmlVO.length;
				for (WebMemberLangVO tempVO : wmlVO) {
					cnt += handler.insert("kr.co.sist.member.insertLang", tempVO);
				} // end for
			} // end if

			if (cnt == (langCnt + 1)) {
				handler.commit();
			} // end if

		} finally {
			mbh.closeHandler(handler);

		}

		return cnt;
	}
}
