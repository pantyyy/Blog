package cn.javaex.blog.view;

import java.util.Date;

public class Article {
	private String id;
	private String title;
	private String content;
	private String contentText;	//文章的简介
	private String cover;	//文章的封面
	private String viewCount;	//浏览次数
	private String updateTime;	//文章最后一个更新的时间
	private int status;			//文章的状态 , 1 = 正常 , 0 = 回收站
	private int typeId;			//文章的类型id
	private String typeName;	//文章类型的名称
	
	private String srcContent;
	private String htmlContent;
	
	
	public String getSrcContent() {
		return srcContent;
	}
	public void setSrcContent(String srcContent) {
		this.srcContent = srcContent;
	}
	public String getHtmlContent() {
		return htmlContent;
	}
	public void setHtmlContent(String htmlContent) {
		this.htmlContent = htmlContent;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getContentText() {
		return contentText;
	}
	public void setContentText(String contentText) {
		this.contentText = contentText;
	}
	public String getCover() {
		return cover;
	}
	public void setCover(String cover) {
		this.cover = cover;
	}
	public String getViewCount() {
		return viewCount;
	}
	public void setViewCount(String viewCount) {
		this.viewCount = viewCount;
	}

	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}
