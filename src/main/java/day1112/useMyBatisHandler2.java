package day1112;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import day1111.CpDeptVO;
import kr.co.sist.test.MyBatisHandler;

public class useMyBatisHandler2 {

	/*
	 * public void updateCpDept(CpDeptVO cdVO) throws PersistenceException {
	 * 
	 * // 1. MyBatis Handler얻기 SqlSession handler =
	 * MyBatisHandler.getInstance().getHandler();
	 * 
	 * // 2. Mapper.xml에서 id에 해당하는 노드를 찾아서 값을 넣고 실행한 후 결과 받기 int cnt =
	 * handler.update("kr.co.sist.test2.updateCpDept", cdVO);
	 * 
	 * // 3. Transaction 처리 if (cnt != 0) { handler.commit();
	 * 
	 * } // 4. MyBatis Handler닫기 if (handler != null) { handler.close(); }
	 * 
	 * }// updateCpDept
	 */
	public void deleteCpDept(int deptno) throws PersistenceException {
		MyBatisHandler mbh = MyBatisHandler.getInstance();

		SqlSession handler = mbh.getHandler();

		int cnt = handler.delete("kr.co.sist.test2.deleteCpDept", deptno);

		if (cnt != 0) {
			handler.commit();
		}
		mbh.closeHandler(handler);

	}// deleteCpDept

	public static void main(String[] args) {

		CpDeptVO cdVO = new CpDeptVO();
		cdVO.setDeptno(10);
		cdVO.setDname("QA");
		cdVO.setLoc("경기");

		useMyBatisHandler2 umbh = new useMyBatisHandler2();

		try {
			umbh.deleteCpDept(10);
			System.out.println("부서정보 변경성공");
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}
	}// main

}
