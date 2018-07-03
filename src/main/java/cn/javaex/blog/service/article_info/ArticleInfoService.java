package cn.javaex.blog.service.article_info;

import java.util.List;

import cn.javaex.blog.view.Article;

public interface ArticleInfoService {

	List<Article> selectAllArticle();

	Article selectArticleById(String articleId);

}
