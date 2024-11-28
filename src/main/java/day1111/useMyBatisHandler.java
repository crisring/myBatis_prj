package day1111;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.co.sist.test.MyBatisHandler;

public class useMyBatisHandler {

	public void insertCpDept(CpDeptVO cdVO) {
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		int cnt = handler.insert("insertCpDept", cdVO);
		// int cnt = handler.insert("kr.co.sist.test.insertCpDept", cdVO);
		if (cnt == 0) {
			System.out.println(cnt + "건 추가실패");
		} else {
			System.out.println(cnt + "건 추가 되었음");
			handler.commit();
		} // if~else

		// 3. handler 닫기
		handler.close();

	}

	public static void main(String[] args) {

		CpDeptVO cdVO = new CpDeptVO();
		cdVO.setDeptno(50);
		cdVO.setDname("개발부");
		cdVO.setLoc("서울");

		useMyBatisHandler umbh = new useMyBatisHandler();
		try {
			umbh.insertCpDept(cdVO);
		} catch (PersistenceException pe) {
			pe.printStackTrace();

		}
	}// main

}
