package kr.co.sist.member.dao;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class WebMemberVO {
	private String id, pass, name, birth, tel = " ", cellphone, save, email1, email2, email, gender, location, zipcode,
			addr1, tel_flag = " ", addr2, ip;

	private String[] lang;
}
