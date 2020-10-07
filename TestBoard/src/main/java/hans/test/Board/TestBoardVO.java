package hans.test.Board;

import java.util.ArrayList;

import org.stringtemplate.v4.compiler.CodeGenerator.primary_return;

public class TestBoardVO {
	/*
	 * CREATE TABLE `testboard` ( `seqno` int(11) NOT NULL AUTO_INCREMENT COMMENT
	 * 'pk', `title` varchar(100) DEFAULT NULL COMMENT '제목', `contents`
	 * varchar(1000) DEFAULT NULL COMMENT '내용', `regdate` datetime DEFAULT NULL
	 * COMMENT '등록일', PRIMARY KEY (`seqno`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8
	 * COMMENT='테스트용 테이블'
	 */

	private int seqno;
	private String title;
	private String contents;
	private String regdate;
	private String writer;

	private String add1;
	private String add2;
	private String add3;
	private String add4;
	
	private String user_id;
	private String pw;
	private String email1;
	private String email2;
	private String nickname;
	private String name;
	private String pw_boader;
	
	private String oriname;
	private String fullname;
	private ArrayList<String> fullnames;
	private ArrayList<String> orinames;
	
	private String pw_ch;
	
	
	private int rno;
	private String bno;
	private String replytext;
	private String replyer;
	
	

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public String getBno() {
		return bno;
	}

	public void setBno(String bno) {
		this.bno = bno;
	}

	public String getReplytext() {
		return replytext;
	}

	public void setReplytext(String replytext) {
		this.replytext = replytext;
	}

	public String getReplyer() {
		return replyer;
	}

	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}


	
	
	public String getPw_ch() {
		return pw_ch;
	}

	public void setPw_ch(String pw_ch) {
		this.pw_ch = pw_ch;
	}

	public ArrayList<String> getOrinames() {
		return orinames;
	}

	public void setOrinames(ArrayList<String> orinames) {
		this.orinames = orinames;
	}

	private int seqno_img;
	private String regfata;
	

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public ArrayList<String> getFullnames() {
		return fullnames;
	}

	public void setFullnames(ArrayList<String> fullnames) {
		this.fullnames = fullnames;
	}

	public int getSeqno_img() {
		return seqno_img;
	}

	public void setSeqno_img(int seqno_img) {
		this.seqno_img = seqno_img;
	}

	public String getRegfata() {
		return regfata;
	}

	public void setRegfata(String regfata) {
		this.regfata = regfata;
	}

	public String getPw_boader() {
		return pw_boader;
	}

	public String getAdd1() {
		return add1;
	}

	
	public void setAdd1(String add1) {
		this.add1 = add1;
	}

	public String getAdd2() {
		return add2;
	}

	public void setAdd2(String add2) {
		this.add2 = add2;
	}

	public String getAdd3() {
		return add3;
	}

	public void setAdd3(String add3) {
		this.add3 = add3;
	}

	public String getAdd4() {
		return add4;
	}

	public void setAdd4(String add4) {
		this.add4 = add4;
	}

	public String getEmail1() {
		return email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}

	public void setPw_boader(String pw_boader) {
		this.pw_boader = pw_boader;
	}

	private String phone1;
	private String phone2;
	private String phone3;
	
	
	

	public String getWriter() {
		return writer;
	}

	public String getPhone1() {
		return phone1;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	public String getPhone2() {
		return phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

	public String getPhone3() {
		return phone3;
	}

	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public int getSeqno() {
		return seqno;
	}

	public void setSeqno(int swqno) {
		this.seqno = swqno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "TestBoardVO [seqno=" + seqno + ", title=" + title + ", contents=" + contents + ", regdate=" + regdate
				+ ", writer=" + writer + ", add1=" + add1 + ", add2=" + add2 + ", add3=" + add3 + ", add4=" + add4
				+ ", user_id=" + user_id + ", pw=" + pw + ", email1=" + email1 + ", email2=" + email2 + ", nickname="
				+ nickname + ", name=" + name + ", pw_boader=" + pw_boader + ", oriname=" + oriname + ", fullname="
				+ fullname + ", fullnames=" + fullnames + ", orinames=" + orinames + ", pw_ch=" + pw_ch + ", bno=" + bno
				+ ", replytext=" + replytext + ", replyer=" + replyer + ", seqno_img=" + seqno_img + ", regfata="
				+ regfata + ", phone1=" + phone1 + ", phone2=" + phone2 + ", phone3=" + phone3 + ", getBno()="
				+ getBno() + ", getReplytext()=" + getReplytext() + ", getReplyer()=" + getReplyer() + ", getPw_ch()="
				+ getPw_ch() + ", getOrinames()=" + getOrinames() + ", getFullname()=" + getFullname()
				+ ", getFullnames()=" + getFullnames() + ", getSeqno_img()=" + getSeqno_img() + ", getRegfata()="
				+ getRegfata() + ", getPw_boader()=" + getPw_boader() + ", getAdd1()=" + getAdd1() + ", getAdd2()="
				+ getAdd2() + ", getAdd3()=" + getAdd3() + ", getAdd4()=" + getAdd4() + ", getEmail1()=" + getEmail1()
				+ ", getEmail2()=" + getEmail2() + ", getWriter()=" + getWriter() + ", getPhone1()=" + getPhone1()
				+ ", getPhone2()=" + getPhone2() + ", getPhone3()=" + getPhone3() + ", getUser_id()=" + getUser_id()
				+ ", getPw()=" + getPw() + ", getSeqno()=" + getSeqno() + ", getTitle()=" + getTitle()
				+ ", getContents()=" + getContents() + ", getRegdate()=" + getRegdate() + ", getNickname()="
				+ getNickname() + ", getName()=" + getName() + ", getOriname()=" + getOriname() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}

	public String getOriname() {
		return oriname;
	}

	public void setOriname(String oriname) {
		this.oriname = oriname;
	}
	
}
