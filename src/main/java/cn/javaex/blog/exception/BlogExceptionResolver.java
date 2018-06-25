package cn.javaex.blog.exception;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

public class BlogExceptionResolver implements HandlerExceptionResolver{

	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		// TODO Auto-generated method stub
		
		//1.打印错误到控制台
		ex.printStackTrace();
		
		//定义一个错误信息
		String message = "系统繁忙 , 请稍后重试!";
		
		//判断该错误是否是预期错误
		if(ex instanceof BlogException){
			message = ((BlogException)ex).getMessage();	//强转为自定义的错误类型
		}
		//2.判断请求类型
		HandlerMethod handlerMethod = (HandlerMethod) handler;
		ResponseBody responseBody = handlerMethod.getMethod().getAnnotation(ResponseBody.class);
		//3.如果是json请求 , 则返回json数据
		if(responseBody != null){	//responseBody不为空 , 表示返回的是json数据 , 请求是.json请求
			
			// json请求（返回json数据）
			Map<String, Object> responseMap = new HashMap<String, Object>();
			responseMap.put("code", "999999");	//错误代码
			responseMap.put("message", message);	//错误描述
			String json = new Gson().toJson(responseMap);	//把map类型的数据转换为json字符串
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json; charset=utf-8");
			try {
				response.getWriter().write(json);
				response.getWriter().flush();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			
			// 返回一个空的ModelAndView表示已经手动生成响应
			return new ModelAndView();
		}
		
		
		//4.如果是action的跳转页面 , 则跳转到错误的页面
		// 页面转发（跳转至错误页面）
		ModelAndView modelAndView = new ModelAndView();
		//将错误信息传到页面
		modelAndView.addObject("message", message);
		//指向错误页面
		modelAndView.setViewName("error");
		
		return modelAndView;
	}

}
