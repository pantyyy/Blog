package cn.javaex.blog.view;

public class UserInfo {
	private int id;
	private String loginName;
	private String passWord;
	public int getId() {
		return id;
	}
	@Override
	public String toString() {
		return "UserInfo [id=" + id + ", loginName=" + loginName + ", passWord=" + passWord + "]";
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	
}
