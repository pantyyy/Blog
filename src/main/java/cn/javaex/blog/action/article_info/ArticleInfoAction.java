package cn.javaex.blog.action.article_info;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
		//System.out.println(typeInfoService.selectAllType());
		return "admin/article_info/editArticle";
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
