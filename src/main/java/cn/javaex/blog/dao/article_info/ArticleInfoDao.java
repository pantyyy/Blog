package cn.javaex.blog.dao.article_info;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import cn.javaex.blog.view.Article;

public interface ArticleInfoDao {

	List<Article> selectAllArticle(Map mapQuery);

	Article selectArticleById(String articleId);

	void insertArticle(Article article);

	void updateArticle(Article article);

	void deleteArticle(@Param("selectList")String[] selectList);
	
	void removeArticle(@Param("selectList")String[] selectList , @Param("selectType")String selectType);

	void recycleArticle(@Param("selectList")String[] selectList);

	void restoreArticle(@Param("selectList")String[] selectList);
}
