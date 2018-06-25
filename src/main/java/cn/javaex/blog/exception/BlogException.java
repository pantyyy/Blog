package cn.javaex.blog.exception;

/**
 * 
 * @author lck
 * @description	系统自定义异常处理类 , 针对预期的异常 , 需要在程序中抛出此类的异常
 */
public class BlogException extends Exception{
	
	private static final long serialVersionUID = 1L;
	private String message;
	
	public BlogException(String message){
		super(message);
		this.message = message;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	
}
