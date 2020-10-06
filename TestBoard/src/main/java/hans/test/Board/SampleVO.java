package hans.test.Board;

import org.springframework.web.bind.annotation.RequestMapping;

public class SampleVO {
	
	private Integer mno;
	private String firstName;
	private String listName;
	public Integer getMno() {
		return mno;
	}
	public void setMno(Integer mno) {
		this.mno = mno;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getListName() {
		return listName;
	}
	public void setListName(String listName) {
		this.listName = listName;
	}
	
	
	@Override
	public String toString() {
		return "SampleVO [mno=" + mno + ", firstName=" + firstName + ", listName=" + listName + ", getMno()=" + getMno()
				+ ", getFirstName()=" + getFirstName() + ", getListName()=" + getListName() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}
	
	

}
