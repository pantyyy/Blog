package cn.javaex.blog.service.article_info;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.javaex.blog.dao.article_info.ArticleInfoDao;
import cn.javaex.blog.view.Article;
@Service
public class ArticleInfoServiceImpl implements ArticleInfoService {
	
	@Autowired
	ArticleInfoDao articleInfoDao;

	public List<Article> selectAllArticle() {
		// TODO Auto-generated method stub
		return articleInfoDao.selectAllArticle();
	}

	public Article selectArticleById(String articleId) {
		// TODO Auto-generated method stub
		return articleInfoDao.selectArticleById(articleId);
	}

}
