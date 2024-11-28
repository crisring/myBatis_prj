package day1113;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.co.sist.domain.EmpDomain;
import kr.co.sist.test.MyBatisHandler;

public class SelectExam {

	private static SelectExam se;

	private SelectExam() {

	}

	public static SelectExam getInstance() {
		if (se == null) {
			se = new SelectExam();

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

	public EmpDomain srmc(int empno) throws PersistenceException {

		EmpDomain ed = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		// 1. MyBatis Handler 얻기
		SqlSession handler = mbh.getHandler();
		// 2. id에 해당하는 node를 찾아서, parsing하여 쿼리문 실행, 결과 얻기
		ed = handler.selectOne("kr.co.sist.test2.srmc", empno);
		System.out.println(ed);
		// 3. Handler닫기
		mbh.closeHandler(handler);
		return ed;
	}// srmc

	public static void main(String[] args) {

		SelectExam s = new SelectExam();
		s.srmc(7521);

	}

}
