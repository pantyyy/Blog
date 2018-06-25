package cn.javaex.blog.service.user_info;

import cn.javaex.blog.view.UserInfo;

public interface UserInfoService {
	public UserInfo checkUser(String loginName, String passWord);
	public UserInfo selectUser (String loginName , String passWord);
}
