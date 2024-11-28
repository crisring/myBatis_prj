package day1122;

import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.co.sist.test.MyBatisHandler;

public class SelectExam6 {

	private static SelectExam6 se;

	private SelectExam6() {

	}

	public static SelectExam6 getInstance() {

		if (se == null) {

			se = new SelectExam6();
		}
		return se;
	}// getInstance

	public void insertProcedure(CpEmp2VO ce2VO) throws PersistenceException {

		MyBatisHandler mbh = MyBatisHandler.getInstance();

		SqlSession handler = mbh.getHandler();

		try {
			handler.selectOne("kr.co.sist.select6.plsql_insert", ce2VO);

		} finally {
			mbh.closeHandler(handler);
		}

	}// insertProcedure

	public void updateProcedure(CpEmp2VO ce2VO) throws PersistenceException {

		MyBatisHandler mbh = MyBatisHandler.getInstance();

		SqlSession handler = mbh.getHandler();

		try {
			handler.selectOne("kr.co.sist.select6.plsql_update", ce2VO);

		} finally {
			mbh.closeHandler(handler);
		}

	}// updateProcedure

	public void deleteProcedure(CpEmp2VO ce2VO) throws PersistenceException {

		MyBatisHandler mbh = MyBatisHandler.getInstance();

		SqlSession handler = mbh.getHandler();

		try {
			handler.selectOne("kr.co.sist.select6.plsql_delete", ce2VO);

		} finally {
			mbh.closeHandler(handler);
		}

	}// deleteProcedure

	public void selectOneProcedure(SelectProcedureVO spVO) throws PersistenceException {

		MyBatisHandler mbh = MyBatisHandler.getInstance();

		SqlSession handler = mbh.getHandler();

		try {
			handler.selectOne("kr.co.sist.select6.plsql_selectOne", spVO);

		} finally {
			mbh.closeHandler(handler);
		}

	}// selectOneProcedure

	public void selectCursorProcedure(Map<String, Object> map) throws PersistenceException {

		MyBatisHandler mbh = MyBatisHandler.getInstance();

		SqlSession handler = mbh.getHandler();

		try {

			handler.selectOne("kr.co.sist.select6.plsql_select", map);

		} finally {
			mbh.closeHandler(handler);
		}

	}// selectCursorProcedure

	public static void main(String[] args) {

		SelectExam6 s = new SelectExam6();

		SelectProcedureVO spVO = new SelectProcedureVO();
		spVO.setEmpno(7521);
		s.selectOneProcedure(spVO);
		System.err.println(spVO);

	}// main

}// class
