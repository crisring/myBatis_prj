package kr.co.sist.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString

public class EmpDomain {

	private int empno, sal, comm, deptno, mgr;
	private String ename, job, hiredateStr;
	private Date hiredate;

}
