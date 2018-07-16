package cn.javaex.blog.service.type_info;

import java.util.List;

import cn.javaex.blog.view.TypeInfo;

public interface TypeInfoService {
	List<TypeInfo> selectAllType();	//查询所有的分类
	void saveTypes(String[] idArr,String[] sortArr,String[] nameArr);
	void deleteTypes(String[] idArr);
	int selectArticleCountById(String id);
}
