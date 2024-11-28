package kr.co.sist.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter

public class RestDomain {

	private int num;
	private String restaurant, menu, info, id;
	private double lng, lat;
	private Date input_date;

}
