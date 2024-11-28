package day1120;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.ognl.Ognl;
import org.apache.ibatis.session.SqlSession;

import kr.co.sist.domain.BoardDomain;
import kr.co.sist.domain.BoardInfoDomain;
import kr.co.sist.domain.EmpDomain;
import kr.co.sist.domain.RestDomain;
import kr.co.sist.domain.WebMemberDomain;
import kr.co.sist.test.MyBatisHandler;
import kr.co.sist.vo.EmpVO;
import kr.co.sist.vo.OgnlVO;
import kr.co.sist.vo.TransactionVO;

public class SelectExam5 {

	private static SelectExam5 se;

	private SelectExam5() {

	}

	public static SelectExam5 getInstance() {
		if (se == null) {
			se = new SelectExam5();

		}
		return se;
	}// getInstance

	public List<EmpDomain> ognlIf(int deptno) throws PersistenceException {

		List<EmpDomain> list = null;
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.select5.ognl_if", deptno);
		} finally {
			mbh.closeHandler(handler);
		}

		return list;
	}// ognlIf

	public List<EmpDomain> ognlIf2(OgnlVO oVO) throws PersistenceException {

		List<EmpDomain> list = null;
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.select5.ognl_if2", oVO);
		} finally {
			mbh.closeHandler(handler);
		}

		return list;
	}// ognlIf2

	public List<EmpDomain> ognlChoose(int deptno) throws PersistenceException {

		List<EmpDomain> list = null;
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.select5.ognl_choose", deptno);
		} finally {
			mbh.closeHandler(handler);
		}

		return list;
	}// ognlChoose

	public List<EmpDomain> ognlForeach(Map<String, Object> map) throws PersistenceException {

		List<EmpDomain> list = null;
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.select5.ognl_foreach", map);
		} finally {
			mbh.closeHandler(handler);
		}

		return list;
	}// ognlForeach

	public List<Integer> selectAllEmpno() throws PersistenceException {

		List<Integer> list = null;
		EmpVO eVO = new EmpVO();

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.select5.selectAllEmpno");
		} finally {
			mbh.closeHandler(handler);
		}

		return list;

	}// selectAllEmpno

	public EmpDomain selectOneEmp(int emp) throws PersistenceException {
		EmpDomain ed = null;

		EmpVO eVO = new EmpVO();

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			ed = handler.selectOne("kr.co.sist.select5.selectOneEmpno", emp);
		} finally {
			mbh.closeHandler(handler);
		}

		return ed;
	}// selectOneEmp

	public int updateEmp(EmpVO eVO) throws PersistenceException {

		int cnt = 0;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler(true);

		try {
			cnt = handler.update("kr.co.sist.select5.updateEmp", eVO);
			handler.commit();

		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return cnt;
	}// updateEmp

	public static void main(String[] args) {

		SelectExam5 s = new SelectExam5();

		Map<String, Object> map = new HashMap<String, Object>();
		/*
		 * List<String> list = new ArrayList<String>();
		 * 
		 * list.add("MANAGER"); list.add("CLERK"); list.add("SALEMAN");
		 */

		String[] list = { "MANAGER", "CLERK", "SALESMAN" };

		map.put("deptno", 10);
		map.put("jobArr", list);

		System.out.println(s.selectOneEmp(7521));
	}

}
