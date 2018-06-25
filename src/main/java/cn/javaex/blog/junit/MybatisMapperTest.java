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
		//���غ��������ļ�
		String resource = "sqlMapConfigMybatis.xml";
		InputStream in = Resources.getResourceAsStream(resource);
		//����SqlSessionFactory
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(in);
		//����SqlSession
		SqlSession sqlSession = sqlSessionFactory.openSession();
		
		//SqlSEssion��������һ��ʵ����  �����ݽӿڣ�
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
