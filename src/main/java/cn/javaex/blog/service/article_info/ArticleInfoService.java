package cn.javaex.blog.service.article_info;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import cn.javaex.blog.view.Article;

public interface ArticleInfoService {

	List<Article> selectAllArticle(Map mapQuery);

	Article selectArticleById(String articleId);

	void insertArticle(Article article);

	void updateArticle(Article article);

	void deleteArticle(String[] selectList);

	void removeArticle(String[] selectList , String selectType);

	void recycleArticle(String[] selectList);

	void restoreArticle(String[] selectList);
}
