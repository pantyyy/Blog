package cn.javaex.blog.dao.user_info;

import org.apache.ibatis.annotations.Param;

import cn.javaex.blog.view.UserInfo;

public interface UserInfoDao {

	UserInfo checkUser(@Param("loginName") String loginName , @Param("passWord") String passWord);
	
	UserInfo selectUser(@Param("loginName") String loginName , @Param("passWord") String passWord);
	UserInfo findUserById(String id);
}
