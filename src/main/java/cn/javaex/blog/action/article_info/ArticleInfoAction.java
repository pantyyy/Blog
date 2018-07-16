package cn.javaex.blog.action.article_info;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.javaex.blog.service.article_info.ArticleInfoService;
import cn.javaex.blog.service.type_info.TypeInfoService;
import cn.javaex.blog.view.Article;
import cn.javaex.blog.view.Result;

@Controller
@RequestMapping("admin/")
public class ArticleInfoAction {

	@Autowired
	ArticleInfoService articleInfoService;
	
	@Autowired
	TypeInfoService typeInfoService;

	
	@RequestMapping("editeContent.action")
	public String editeContent(String articleId , ModelMap map){
		Article article = articleInfoService.selectArticleById(articleId);
		map.put("article", article);
		return "admin/article_info/editeContent";
	}
	
	
	@RequestMapping("restoreArticle.json")
	@ResponseBody
	public Result restoreArticle(String[] selectList){
		articleInfoService.restoreArticle(selectList);
		return Result.success();		
	}
	
	@RequestMapping("removeArticle.json")
	@ResponseBody
	public Result removeArticle(String[] selectList , String selectType){
		articleInfoService.removeArticle(selectList , selectType);
		return Result.success();
	}
	
	
	@RequestMapping("deleteArticle.json")
	@ResponseBody
	public Result deleteArticle(@RequestParam(value="selectList") String[] selectList , String sta){
		if("0".equals(sta)){
			//移动到回收站
			articleInfoService.recycleArticle(selectList);
		}else{
			//删除文章
			articleInfoService.deleteArticle(selectList);
		}
		//System.out.println(selectList);
		return Result.success();
	}
	
	/**
	 * 跳转到文章列表的jsp页面
	 * @return
	 */
	@RequestMapping("articles.action")
	public String getAllArticle(ModelMap map ,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,	//当前页
			@RequestParam(value="pageSize", defaultValue="5") int pageSize, //每页显示的条数
			@RequestParam(required = false , value="typeId") Integer typeId,
			@RequestParam(required = false , value="title") String title,
			@RequestParam(required = false , value="startDate") String startDate,
			@RequestParam(required = false , value="endDate") String endDate , 
			@RequestParam(required = false , value = "sta" , defaultValue="1") String sta
			){
		Map mapQuery = new HashMap();
		mapQuery.put("typeId", typeId);
		mapQuery.put("title", title);
		mapQuery.put("startDate", startDate);
		mapQuery.put("endDate", endDate);
		mapQuery.put("sta", sta);
		
		PageHelper.startPage(pageNum, pageSize);	//设置是哪一页 和每页显示的条数
		List<Article> articleList = articleInfoService.selectAllArticle(mapQuery);	//查询出所有的数据
		PageInfo<Article> pageInfo = new PageInfo<Article>(articleList);	//对所有的数据进行分页
		map.put("pageInfo", pageInfo);
		//查询所有的文章分类
		map.put("typeList", typeInfoService.selectAllType());
		map.put("mapQuery", mapQuery);
		
		if("0".equals(sta)){
			return "admin/article_info/recycleList";
		}else{
			return "admin/article_info/articleList";
		}

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
	
	
	/**
	 * 保存文章
	 */
	@RequestMapping("saveArticle.json")
	@ResponseBody
	public Result saveArticle(Article article){
		
		//日期类型转字符串类型
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentDate = sdf.format(date);
		
		article.setUpdateTime(currentDate);
		article.setStatus(1);
		article.setViewCount("1");
		
		//去掉简介开头的逗号
		if(!(StringUtils.isEmpty(article.getContentText()))){
			article.setContentText(article.getContentText().substring(1 , article.getContentText().length()));
		}
		//article.setContentText("ce");
		
		if(StringUtils.isEmpty(article.getId())){
			//如果是空 , 就是新增
			articleInfoService.insertArticle(article);
		}else{
			//如果不为空 , 就是更新
			articleInfoService.updateArticle(article);
		}
		
		
		return Result.success();
	}
	
	
	
	
	/**
	 * 上传文件到磁盘（物理路径）
	 * @throws IOException 
	 */
	@RequestMapping("upload.json")
	@ResponseBody
	public Result upload(MultipartFile file, HttpServletRequest request) throws IOException {
		// 文件原名称
		String szFileName = file.getOriginalFilename();
		// 重命名后的文件名称
		String szNewFileName = "";
		// 根据日期自动创建3级目录
		String szDateFolder = "";
		// 上传文件
		if (file!=null && szFileName!=null && szFileName.length()>0) {
			Date date = new Date();
			szDateFolder = new SimpleDateFormat("yyyy/MM/dd").format(date);
			// 存储文件的物理路径
			String szFilePath = "C:\\upload\\" + szDateFolder;
			// 自动创建文件夹
			File f = new File(szFilePath);
			if (!f.exists()) {
				f.mkdirs();
			}
			// 新的文件名称
			szNewFileName = UUID.randomUUID() + szFileName.substring(szFileName.lastIndexOf("."));
			// 新文件
			File newFile = new File(szFilePath+"\\"+szNewFileName);
			
			// 将内存中的数据写入磁盘
			file.transferTo(newFile);
		}
		return Result.success().add("imgUrl", szDateFolder+"/"+szNewFileName);
	}
	
	
}
