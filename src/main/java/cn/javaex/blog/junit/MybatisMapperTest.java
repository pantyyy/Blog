package cn.javaex.blog.junit;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.javaex.blog.dao.user_info.UserInfoDao;
import cn.javaex.blog.view.UserInfo;

public class MybatisMapperTest {
	
	@Test
	public void testMapper() throws Exception {
		//加载核心配置文件
		String resource = "sqlMapConfigMybatis.xml";
		InputStream in = Resources.getResourceAsStream(resource);
		//创建SqlSessionFactory
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(in);
		//创建SqlSession
		SqlSession sqlSession = sqlSessionFactory.openSession();
		
		//SqlSEssion帮我生成一个实现类  （根据接口）
		UserInfoDao userMapper = sqlSession.getMapper(UserInfoDao.class);
		
		
		UserInfo user = userMapper.findUserById("1");
		System.out.println(user);
	}
	
	
	@Test
	public void testMapper1() throws Exception {
		ApplicationContext ac = new ClassPathXmlApplicationContext("spring-mybatis.xml");
		UserInfoDao mapper = ac.getBean(UserInfoDao.class);
//		UserMapper mapper = (UserMapper) ac.getBean("userMapper");
//		UserDao ud =  ac.getBean(UserDao.class);
		UserInfo u = mapper.findUserById("1");
		System.out.println(u);
	}
	
	
}
