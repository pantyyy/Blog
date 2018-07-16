package cn.javaex.blog.view;
/**
 * 
 * @author lck
 * @description	文章分类
 */
public class TypeInfo {
	private String id;
	private String name;
	private String sort;
	private String typeCount;
	
	public String getTypeCount() {
		return typeCount;
	}
	public void setTypeCount(String typeCount) {
		this.typeCount = typeCount;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
}
