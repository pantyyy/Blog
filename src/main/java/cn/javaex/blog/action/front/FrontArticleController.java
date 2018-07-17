package cn.javaex.blog.action.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.javaex.blog.service.article_info.ArticleInfoService;
import cn.javaex.blog.service.type_info.TypeInfoService;
import cn.javaex.blog.view.Article;
import cn.javaex.blog.view.Result;
import cn.javaex.blog.view.TypeInfo;


@Controller
@RequestMapping("front/")
public class FrontArticleController {


	@Autowired
	ArticleInfoService articleInfoService;
	
	@Autowired
	TypeInfoService typeInfoService;
	
	/**
	 * 用户查看文章详细内容
	 * @param articleId
	 * @param map
	 * @return
	 */
	@RequestMapping("getArticle.action")//新增的时候不需要传递id , 所以需要设置为false
	public String getArticle(@RequestParam(required = false , value="articleId") String articleId , ModelMap map){
		Article article = articleInfoService.selectArticleById(articleId);
		
		map.put("article", article);
		return "front/detailArticle";
	}

	/**
	 * 关于我的Jsp页面
	 * @param articleId
	 * @param map
	 * @return
	 */
	@RequestMapping("aboutMe.action")//新增的时候不需要传递id , 所以需要设置为false
	public String aboutMe(){
		return "front/aboutMe";
	}
	
	
	/**
	 * 首页Jsp
	 * @return
	 */
	@RequestMapping("index.action")
	public String frontIndex(ModelMap map ,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,	//当前页
			@RequestParam(value="pageSize", defaultValue="5") int pageSize, //每页显示的条数
			@RequestParam(required = false , value="typeId") Integer typeId,//文章分类id
			@RequestParam(required = false , value = "typeName") String typeName ,
			@RequestParam(required = false , value="title") String title,	//文章标题
			@RequestParam(required = false , value="startDate") String startDate,
			@RequestParam(required = false , value="endDate") String endDate , 
			@RequestParam(required = false , value = "sta" , defaultValue="1") String sta ,
			@RequestParam(required = false , value = "indexSta" , defaultValue="1") String indexSta	//指定返回的页面类型
			){
		
		if("".equals(title)){
			indexSta = "1";
		}
		
		
		if("".equals(typeId)){
			indexSta = "1";
		}
		
		Map mapQuery = new HashMap();
		mapQuery.put("typeId", typeId);
		mapQuery.put("typeName", typeName);
		mapQuery.put("title", title);
		mapQuery.put("startDate", startDate);
		mapQuery.put("endDate", endDate);
		mapQuery.put("sta", sta);
		mapQuery.put("indexSta", indexSta);
		PageHelper.startPage(pageNum, pageSize);	//设置是哪一页 和每页显示的条数
		List<Article> articleList = articleInfoService.selectAllArticle(mapQuery);	//查询出所有的数据
		List<TypeInfo> typeList = typeInfoService.selectAllType();
		PageInfo<Article> pageInfo = new PageInfo<Article>(articleList);	//对所有的数据进行分页
		map.put("pageInfo", pageInfo);
		//查询所有的文章分类
		map.put("typeList", typeInfoService.selectAllType());
		map.put("mapQuery", mapQuery);
		map.put("typeList", typeList);
		
		return "front/index";
		
		//return "front/index";
	}
	
	
	/**
	 * 获取分类的json数据
	 * @param request
	 * @return
	 */
	@RequestMapping("selectAllType.json")
	@ResponseBody
	public Result selectAllType(HttpServletRequest request){
		List<TypeInfo> typeList = typeInfoService.selectAllType();
		Map map = new HashMap();
		map.put("types", typeList);
		Result result = new Result();
		result.setData(map);
		result.setMessage("success");
		return result;
	}
	
}
