package cn.javaex.blog.service.type_info;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.javaex.blog.dao.type_info.TypeInfoDao;
import cn.javaex.blog.view.TypeInfo;

@Service
public class TypeInfoServiceImpl implements TypeInfoService {
	
	@Autowired
	TypeInfoDao typeInfoDao;
	
	public List<TypeInfo> selectAllType() {
		// TODO Auto-generated method stub
		return typeInfoDao.selectAllType();
	}

	/**
	 * 批量添加或更新类型
	 */
	public void saveTypes(String[] idArr, String[] sortArr, String[] nameArr) {
		// TODO Auto-generated method stub
		for(int i=0 ; i < idArr.length ; i++){	//遍历type的主键
			if(StringUtils.isEmpty(idArr[i])){	//判断主键是否为空 , 如果为空插入数据 , 反之 , 更新数据
				//插入
				typeInfoDao.insertType(sortArr[i] , nameArr[i]);
			}else{
				//更新
				typeInfoDao.updateType(idArr[i] , sortArr[i] , nameArr[i]);
			}
		}
	}

	public void deleteTypes(String[] idArr) {
		// TODO Auto-generated method stub
		typeInfoDao.deleteTypes(idArr);
	}

}
