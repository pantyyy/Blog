package cn.javaex.blog.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import cn.javaex.blog.view.UserInfo;

public class URLInterceptor implements HandlerInterceptor{

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		
		//获取用户的url
		String url = request.getRequestURI();
		
		//对特殊的请求放行
		if(url.indexOf("login") >= 0 || url.indexOf("front") >= 0){
			return true;
		}
		
		HttpSession session = request.getSession();
		UserInfo user = (UserInfo) session.getAttribute("userInfo");
		if(user != null){
			//管理员登录了 , 放行
			return true;
		}
		
		//没有登录 , 跳转到登录页面
		request.getRequestDispatcher("/WEB-INF/page/admin/login.jsp").forward(request, response);

		return false;
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
