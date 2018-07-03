package cn.javaex.blog.dao.article_info;

import java.util.List;

import cn.javaex.blog.view.Article;

public interface ArticleInfoDao {

	List<Article> selectAllArticle();

	Article selectArticleById(String articleId);

}
