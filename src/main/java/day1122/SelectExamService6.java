package day1122;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;

import kr.co.sist.domain.CpEmpDomain;

/**
 * DAO를 건드림
 */
public class SelectExamService6 {

	private static SelectExamService6 ses;

	private SelectExamService6() {

	}

	public static SelectExamService6 getInstance() {

		if (ses == null) {
			ses = new SelectExamService6();

		}
		return ses;
	}// getInstance

	public void addEmp(CpEmp2VO ce2VO) {

		SelectExam6 se6 = SelectExam6.getInstance();

		try {
			se6.insertProcedure(ce2VO);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}
	}// addEmp

	public void modifyEmp(CpEmp2VO ce2VO) {

		SelectExam6 se6 = SelectExam6.getInstance();

		try {
			se6.updateProcedure(ce2VO);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}
	}// modifyEmp

	public void removeEmp(CpEmp2VO ce2VO) {

		SelectExam6 se6 = SelectExam6.getInstance();

		try {
			se6.deleteProcedure(ce2VO);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}
	}// removeEmp

	public void searchOneEmp(SelectProcedureVO spVO) {

		SelectExam6 se6 = SelectExam6.getInstance();

		try {
			se6.selectOneProcedure(spVO);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}
	}// searchOneEmp

	public List<CpEmpDomain> searchEmpDept(Map<String, Object> map) {
		List<CpEmpDomain> viewList = new ArrayList<CpEmpDomain>();
		SelectExam6 se6 = SelectExam6.getInstance();
		try {
			se6.selectCursorProcedure(map);

			List<Map<String, Object>> mapList = (List<Map<String, Object>>) map.get("selectEmp");

			CpEmpDomain ed = null;
			for (Map<String, Object> recordMap : mapList) {
				ed = new CpEmpDomain();
				ed.setEmpno((BigDecimal) recordMap.get("EMPNO"));
				ed.setEname((String) recordMap.get("ENAME"));
				ed.setSal((BigDecimal) recordMap.get("SAL"));
				ed.setHiredate((Timestamp) recordMap.get("HIREDATE"));

				viewList.add(ed);
			} // end for

		} catch (PersistenceException pe) {
			pe.printStackTrace();
		} // end catch

		return viewList;
	}// searchEmpDept

}// class
