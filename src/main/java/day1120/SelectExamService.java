package day1120;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;

import kr.co.sist.domain.EmpDomain;
import kr.co.sist.vo.EmpVO;
import kr.co.sist.vo.OgnlVO;

/**
 * DAO를 건드림
 */
public class SelectExamService {

	private static SelectExamService ses;

	private SelectExamService() {

	}

	public static SelectExamService getInstance() {

		if (ses == null) {
			ses = new SelectExamService();

		}
		return ses;
	}// getInstance

	public List<EmpDomain> searchEmp(String paramDeptno) {

		List<EmpDomain> list = null;
		int deptno = 0;

		// getParameter이 String이기 때문에 존재시 int로 변환
		if (paramDeptno != null && !"".equals(paramDeptno)) {
			deptno = Integer.parseInt(paramDeptno);
		}

		SelectExam5 se5 = SelectExam5.getInstance();
		try {
			list = se5.ognlIf(deptno);
		} catch (PersistenceException pe) {
			pe.printStackTrace();

		}
		return list;
	}// searchEmp

	public List<EmpDomain> searchEmp2(OgnlVO oVO) {

		List<EmpDomain> list = null;

		SelectExam5 se5 = SelectExam5.getInstance();
		try {
			list = se5.ognlIf2(oVO);
		} catch (PersistenceException pe) {
			pe.printStackTrace();

		}
		return list;
	}// searchEmp2

	public List<EmpDomain> searchDeptEmp(String paramDeptno) {

		List<EmpDomain> list = null;
		int deptno = 0;

		// getParameter이 String이기 때문에 존재시 int로 변환
		if (paramDeptno != null && !"".equals(paramDeptno)) {
			deptno = Integer.parseInt(paramDeptno);
		}

		SelectExam5 se5 = SelectExam5.getInstance();
		try {
			list = se5.ognlChoose(deptno);
		} catch (PersistenceException pe) {
			pe.printStackTrace();

		}
		return list;
	}// searchDeptEmp

	public List<EmpDomain> searchMap(String paramDeptno, String[] jobArr) {

		List<EmpDomain> list = null;
		int deptno = 0;

		// getParameter이 String이기 때문에 존재시 int로 변환
		if (paramDeptno != null && !"".equals(paramDeptno)) {
			deptno = Integer.parseInt(paramDeptno);
		}

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("deptno", deptno);
		searchMap.put("jobArr", jobArr);

		SelectExam5 se5 = SelectExam5.getInstance();
		try {
			list = se5.ognlForeach(searchMap);
		} catch (PersistenceException pe) {
			pe.printStackTrace();

		}
		return list;
	}// searchDeptEmp

	public List<Integer> searchAllEmpno() {

		List<Integer> list = null;

		SelectExam5 se5 = SelectExam5.getInstance();

		try {
			list = se5.selectAllEmpno();

		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return list;
	}// searchAllEmpno

	public EmpDomain selectOneEmp(String paramEmpno) {

		EmpDomain ed = null;

		SelectExam5 se5 = SelectExam5.getInstance();

		int empno = 0;
		// getParameter이 String이기 때문에 존재시 int로 변환
		if (paramEmpno != null && !"".equals(paramEmpno)) {
			empno = Integer.parseInt(paramEmpno);
		}

		try {
			ed = se5.selectOneEmp(empno);

		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return ed;
	}// selectOneEmp

	public boolean modifyEmp(EmpVO eVO) {
		boolean flag = false;

		SelectExam5 se5 = SelectExam5.getInstance();

		try {
			int cnt = se5.updateEmp(eVO);

			if (cnt > 0) {
				flag = true;
			}

		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return flag;
	}

}
