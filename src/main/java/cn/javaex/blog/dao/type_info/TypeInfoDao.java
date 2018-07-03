package cn.javaex.blog.dao.type_info;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.javaex.blog.view.TypeInfo;

public interface TypeInfoDao {
	
	List<TypeInfo> selectAllType();	//查询所有的分类
	
	void insertType(@Param("sort") String sort ,@Param("name") String name);	//插入类型
	void updateType(@Param("id") String id ,@Param("sort") String sort ,@Param("name") String name);	//更新类型
	void deleteTypes(@Param("idArr") String[] idArr);	//更新类型
}
