package kr.co.sist.user.board;

import java.sql.Date;

public class BoardVO {
private int num;
private String subject,	content,	writer,		ip;
private Date input_date;

public int getNum() {
	return num;
}
public void setNum(int num) {
	this.num = num;
}
public String getSubject() {
	return subject;
}
public void setSubject(String subject) {
	this.subject = subject;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public String getWriter() {
	return writer;
}
public void setWriter(String writer) {
	this.writer = writer;
}
public String getIp() {
	return ip;
}
public void setIp(String ip) {
	this.ip = ip;
}
public Date getInput_date() {
	return input_date;
}
public void setInput_date(Date input_date) {
	this.input_date = input_date;
}
@Override
public String toString() {
	return "BoardVO [num=" + num + ", subject=" + subject + ", content=" + content + ", writer=" + writer + ", ip=" + ip
			+ ", input_date=" + input_date + "]";
}

}
