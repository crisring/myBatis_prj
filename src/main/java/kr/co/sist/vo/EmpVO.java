package kr.co.sist.vo;

import lombok.Data;

@Data
public class EmpVO {

	private String empno, ename, job;
	private int sal, comm, deptno, mgr;

}
