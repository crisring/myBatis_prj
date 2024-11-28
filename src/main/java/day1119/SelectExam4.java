package day1119;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.co.sist.domain.BoardDomain;
import kr.co.sist.domain.BoardInfoDomain;
import kr.co.sist.domain.EmpDomain;
import kr.co.sist.domain.RestDomain;
import kr.co.sist.domain.WebMemberDomain;
import kr.co.sist.test.MyBatisHandler;
import kr.co.sist.vo.TransactionVO;

public class SelectExam4 {

	private static SelectExam4 se;

	private SelectExam4() {

	}

	public static SelectExam4 getInstance() {
		if (se == null) {
			se = new SelectExam4();

		}
		return se;
	}// getInstance

	public List<EmpDomain> dynamicTable(String tableName) throws PersistenceException {

		List<EmpDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();

		// 1. handler얻기
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.select4.dollarSign", tableName);

		} finally {
			mbh.closeHandler(handler);

		}

		// 2. id 와 값을 넣어 해당 쿼리를 찾아서 파싱하고, 쿼리문을 실행 한 후 결과 얻기

		return list;
	}// dynamicTable

	public boolean transaction(TransactionVO tVO) throws PersistenceException {

		boolean flag = false;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		// 1. Handler얻기
		SqlSession handler = mbh.getHandler(false); // auto commit이 아닌상태로 얻기 -> rollback필요 x

		int cnt = 0;
		try {
			// 2. id에 해당하는 쿼리문을 찾아서 파싱하고 쿼리를 실행하고 결과를 얻는다.
			cnt = handler.insert("kr.co.sist.select4.transaction", tVO);

			cnt += handler.insert("kr.co.sist.select4.transaction2", tVO);

			// 3. 목표로 한 행수
			if (cnt == 2) {
				handler.commit();
				flag = true;
			} // end if

		} finally {
			mbh.closeHandler(handler);

		}

		return flag;
	}// transaction

	public static void main(String[] args) {

		SelectExam4 s = new SelectExam4();
		TransactionVO tVO = new TransactionVO();

		tVO.setName("테스트3");
		tVO.setAddr("서울");
		System.out.println(s.transaction(tVO));
	}

}
