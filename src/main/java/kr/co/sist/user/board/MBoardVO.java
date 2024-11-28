package kr.co.sist.user.board;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class MBoardVO {

	private int num;
	private String subject, content, writer, ip, pass;
	private Timestamp input_date;

}
