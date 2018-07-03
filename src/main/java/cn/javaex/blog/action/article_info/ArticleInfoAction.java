package cn.javaex.blog.action.article_info;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.javaex.blog.service.article_info.ArticleInfoService;
import cn.javaex.blog.service.type_info.TypeInfoService;
import cn.javaex.blog.view.Article;

@Controller
@RequestMapping("admin/")
public class ArticleInfoAction {

	@Autowired
	ArticleInfoService articleInfoService;
	
	@Autowired
	TypeInfoService typeInfoService;
	/**
	 * 跳转到所有文章的jsp页面
	 * @return
	 */
	@RequestMapping("articles.action")
	public String getAllArticle(ModelMap map){
		List<Article> articleList = articleInfoService.selectAllArticle();
		map.put("articleList", articleList);
		return "admin/article_info/articleList";
	}
	
	/**
	 * 跳转到编辑文章的jsp页面
	 * @return
	 */
	@RequestMapping("editArticle.action")//新增的时候不需要传递id , 所以需要设置为false
	public String editArticle(@RequestParam(required = false , value="articleId") String articleId , ModelMap map){
		if(!StringUtils.isEmpty(articleId)){
			//编辑文章
			Article article = articleInfoService.selectArticleById(articleId);
			map.put("article", article);
		}
		
		//查询所有的文章分类
		map.put("typeList", typeInfoService.selectAllType());
		
		return "admin/article_info/editArticle";
	}
}
