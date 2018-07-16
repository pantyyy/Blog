package cn.javaex.blog.service.article_info;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.javaex.blog.dao.article_info.ArticleInfoDao;
import cn.javaex.blog.view.Article;
@Service
public class ArticleInfoServiceImpl implements ArticleInfoService {
	
	@Autowired
	ArticleInfoDao articleInfoDao;

	public List<Article> selectAllArticle(Map mapQuery) {
		// TODO Auto-generated method stub
		return articleInfoDao.selectAllArticle(mapQuery);
	}

	public Article selectArticleById(String articleId) {
		// TODO Auto-generated method stub
		return articleInfoDao.selectArticleById(articleId);
	}

	/**
	 * 新增文章
	 */
	public void insertArticle(Article article) {
		// TODO Auto-generated method stub
		articleInfoDao.insertArticle(article);
	}

	public void updateArticle(Article article) {
		// TODO Auto-generated method stub
		articleInfoDao.updateArticle(article);
	}

	/**
	 * 批量删除文章
	 */
	public void deleteArticle(String[] selectList) {
		// TODO Auto-generated method stub
		articleInfoDao.deleteArticle(selectList);
	}

	public void removeArticle(String[] selectList, String selectType) {
		// TODO Auto-generated method stub
		articleInfoDao.removeArticle(selectList , selectType);
	}

	public void recycleArticle(String[] selectList) {
		// TODO Auto-generated method stub
		articleInfoDao.recycleArticle(selectList);
	}

	public void restoreArticle(String[] selectList) {
		// TODO Auto-generated method stub
		articleInfoDao.restoreArticle(selectList);
	}

}
