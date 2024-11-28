package kr.co.sist.domain;

import java.math.BigDecimal;
import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CpEmpDomain {
	// BigDecimal 메모리 크기대로 끝없는 수를 저장할 수 있는 객체
	private BigDecimal empno, mgr, sal, comm, deptno;
	private String ename, job;
	// nano seconds인 정밀한 시간을 저장할 때 사용하는 객체
	private Timestamp hiredate;
}
