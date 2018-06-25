package cn.javaex.blog.action.user_info;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.javaex.blog.exception.BlogException;
import cn.javaex.blog.service.user_info.UserInfoService;
import cn.javaex.blog.view.Result;
import cn.javaex.blog.view.UserInfo;
///blog/user_info/index.action
@Controller
@RequestMapping("admin/")
public class UserInfoAction {
	
	@Autowired
	private UserInfoService userInfoService;
	
	// 在类下添加这句话
	private Logger log = Logger.getLogger(this.getClass());

	/**
	 * 后台首页的Jsp
	 * @return
	 */
	@RequestMapping("index.action")
	public String index(){
		log.debug("登录开始");
		//UserInfo user = userInfoService.selectUser("lck" , "123");
		return "admin/index";
	}
	
	/**
	 * 后台登录的Jsp
	 * @return
	 */
	@RequestMapping("loginAdmin.action")
	public String loginAdmin(){
		return "admin/login";
	}
	
	/**
	 * 验证用户的登录
	 * @param map
	 * @param request
	 * @return
	 * @throws BlogException 
	 */
	@RequestMapping("login.json")
	@ResponseBody
	public Result loginCheck(ModelMap map , HttpServletRequest request) throws BlogException{
		
		
		
		//1.获取参数
		String loginName = request.getParameter("login_name"); 
		String passWord = request.getParameter("pass_word");
		
		
		//2.数据对比
		if(StringUtils.isEmpty(loginName) || StringUtils.isEmpty(passWord)){
			throw new BlogException("用户名 , 密码不能为空");	//抛出自定义的异常
			//return Result.error("用户名 , 密码不能为空");
		}
		
		UserInfo user = userInfoService.checkUser(loginName , passWord);
		if(user == null){
			throw new BlogException("用户名或密码不正确");	//抛出自定义的异常
			//return Result.error("用户名或密码不正确");
		}
		
		//3.成功放入session
		request.getSession().setAttribute("userInfo", user);
		
		return Result.success();
	}
	
	
	/**
	 * 用户注销
	 */
	@RequestMapping("login_out.action")
	public String loginOut(HttpServletRequest request){
		request.getSession().removeAttribute("userInfo");
		return "admin/login";
	}
	
	
	
/*	@RequestMapping("login.action")
	public String login(ModelMap map,
						@RequestParam(required = false , value = "login_name") String loginName , 
						@RequestParam(required = false , value = "pass_word") String passWord){
			
			if(StringUtils.isEmpty(loginName) || StringUtils.isEmpty(passWord)){
				return "loign";
			}
			
			UserInfo userInfo = userInfoService.checkUser(loginName, passWord);
			
			if(userInfo == null){
				return "login";
			}
			
			return "admin/index";
	}*/
}
