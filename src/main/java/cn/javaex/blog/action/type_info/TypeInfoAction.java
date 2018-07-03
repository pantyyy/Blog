package cn.javaex.blog.action.type_info;

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

import cn.javaex.blog.service.type_info.TypeInfoService;
import cn.javaex.blog.view.Result;
import cn.javaex.blog.view.TypeInfo;

@Controller
@RequestMapping("admin/")
public class TypeInfoAction {
	@Autowired
	TypeInfoService typeInfoService;
	
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
	
	/**
	 * 跳转到分类的jsp页面
	 * @return
	 */
	@RequestMapping("types.action")
	public String getTypeJsp(ModelMap map){
		List<TypeInfo> typeList = typeInfoService.selectAllType();
		map.put("typeList", typeList);
		return "admin/type_info/typeList";
	}
	
	/**
	 * 保存分类
	 */
	@RequestMapping("saveTypes.json")
	@ResponseBody
	public Result saveTypes(
			@RequestParam(value="idArr") String[] idArr,	//接受ajax传递过来的参数
			@RequestParam(value="sortArr") String[] sortArr,
			@RequestParam(value="nameArr") String[] nameArr
			){
		
		typeInfoService.saveTypes(idArr, sortArr, nameArr);
		
		return Result.success();
	}
	
	
	
	/**
	 * 删除分类
	 */
	@RequestMapping("deleteTypes.json")
	@ResponseBody
	public Result deleteTypes(
			@RequestParam(value="idArr") String[] idArr	//接受ajax传递过来的参数
			){
		
		typeInfoService.deleteTypes(idArr);
		
		return Result.success();
	}
	
	
	
	
}
