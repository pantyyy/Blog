package cn.javaex.blog.service.user_info;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.javaex.blog.dao.user_info.UserInfoDao;
import cn.javaex.blog.view.UserInfo;

@Service
public class UserInfoServiceImpl implements UserInfoService {

	@Autowired
	private UserInfoDao userInfoDao;
	
	public UserInfo checkUser(String loginName, String passWord) {
		// TODO Auto-generated method stub
		return userInfoDao.checkUser(loginName , passWord);
		//return new UserInfo();
	}

	public UserInfo selectUser(String loginName, String passWord) {
		// TODO Auto-generated method stub
		return userInfoDao.selectUser(loginName , passWord);
	}

} 
