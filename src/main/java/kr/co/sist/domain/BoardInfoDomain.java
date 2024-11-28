package kr.co.sist.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class BoardInfoDomain {

	private int num;
	private String subject, name, id, birth, gender;

	private Date input_date;

}
