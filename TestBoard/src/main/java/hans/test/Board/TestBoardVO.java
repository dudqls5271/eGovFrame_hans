package hans.test.Board;

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

	private String user_id;
	private String pw;
	private String email;
	private String nickname;
	private String name;

	public String getWriter() {
		return writer;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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
				+ ", user_id=" + user_id + ", pw=" + pw + ", email=" + email + "]";
	}

}
