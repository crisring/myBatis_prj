package day1114;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.co.sist.domain.BoardDomain;
import kr.co.sist.domain.EmpDomain;
import kr.co.sist.domain.RestDomain;
import kr.co.sist.test.MyBatisHandler;

public class SelectExam2 {

	private static SelectExam2 se;

	private SelectExam2() {

	}

	public static SelectExam2 getInstance() {
		if (se == null) {
			se = new SelectExam2();

		}
		return se;
	}// getInstance

	/**
	 * 행하나에 컬럼하나 조회<br>
	 * 부서번호를 입력받아 부서명을 검색<br>
	 * 
	 * @param deptno
	 * @return 부서명
	 * @throws PersistenceException
	 */
	public String srsc(int deptno) throws PersistenceException {
		String dname = "";

		MyBatisHandler mbh = MyBatisHandler.getInstance();

		SqlSession handler = mbh.getHandler();

		dname = handler.selectOne("srsc", deptno);

		mbh.closeHandler(handler);

		EmpDomain ed = new EmpDomain();
		ed.setEmpno(10);
		System.out.println(ed.getEmpno());

		return dname;
	}

	public List<String> mrsc(int deptno) throws PersistenceException {

		List<String> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		// 1. MyBatis Handler 얻기
		SqlSession handler = mbh.getHandler();
		// 2. id에 해당하는 node를 찾아서, parsing하여 쿼리문 실행, 결과 얻기
		list = handler.selectList("mrsc", deptno);

		// 3. Handler닫기
		mbh.closeHandler(handler);
		return list;
	}// mrsc

	public List<String> mrsc2() throws PersistenceException {

		List<String> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		// 1. MyBatis Handler 얻기
		SqlSession handler = mbh.getHandler();
		// 2. id에 해당하는 node를 찾아서, parsing하여 쿼리문 실행, 결과 얻기
		list = handler.selectList("mrsc2");

		// 3. Handler닫기
		mbh.closeHandler(handler);
		return list;
	}// mrsc2

	public List<RestDomain> mrmc(String id) throws PersistenceException {

		List<RestDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		// 1. MyBatis Handler 얻기
		SqlSession handler = mbh.getHandler();
		// 2. id에 해당하는 node를 찾아서, parsing하여 쿼리문 실행, 결과 얻기
		list = handler.selectList("mrmc", id);

		// 3. Handler닫기
		mbh.closeHandler(handler);
		return list;
	}// mrsc2

	public List<EmpDomain> lessThan(int sal) throws PersistenceException {

		List<EmpDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		// 1. MyBatis Handler 얻기
		SqlSession handler = mbh.getHandler();
		// 2. id에 해당하는 node를 찾아서, parsing하여 쿼리문 실행, 결과 얻기
		list = handler.selectList("kr.co.sist.select2.lessThan", sal);

		// 3. Handler닫기
		mbh.closeHandler(handler);
		return list;
	}// lessThan

	public List<EmpDomain> greaterThan(int sal) throws PersistenceException {

		List<EmpDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		// 1. MyBatis Handler 얻기
		SqlSession handler = mbh.getHandler();
		// 2. id에 해당하는 node를 찾아서, parsing하여 쿼리문 실행, 결과 얻기
		list = handler.selectList("kr.co.sist.select2.greaterThan", sal);

		// 3. Handler닫기
		mbh.closeHandler(handler);
		return list;
	}// lessThan

	public List<BoardDomain> like(String subject) throws PersistenceException {

		List<BoardDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		// 1. MyBatis Handler 얻기
		SqlSession handler = mbh.getHandler();
		// 2. id에 해당하는 node를 찾아서, parsing하여 쿼리문 실행, 결과 얻기
		list = handler.selectList("kr.co.sist.select2.like", subject);

		// 3. Handler닫기
		mbh.closeHandler(handler);
		return list;
	}// mrsc2

	public static void main(String[] args) {

		SelectExam2 s = new SelectExam2();
		s.like("오늘은");
	}

}
