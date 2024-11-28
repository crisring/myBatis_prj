package kr.co.sist.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter

public class BoardDomain {

	private int num;
	private String subject, content, writer, ip;
	private Date input_date;

}
