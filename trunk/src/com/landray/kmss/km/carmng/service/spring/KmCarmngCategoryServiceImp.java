package com.landray.kmss.km.carmng.service.spring;

import java.util.Date;

import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.km.carmng.model.KmCarmngCategory;
import com.landray.kmss.km.carmng.service.IKmCarmngCategoryService;
import com.landray.kmss.sys.simplecategory.service.SysSimpleCategoryServiceImp;
import com.landray.kmss.util.UserUtil;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 类别设置业务接口实现
 */
public class KmCarmngCategoryServiceImp extends SysSimpleCategoryServiceImp
		implements IKmCarmngCategoryService {

	@Override
	public String add(IBaseModel modelObj) throws Exception {
		KmCarmngCategory kmCarmngCategory = (KmCarmngCategory) modelObj;
		kmCarmngCategory.setDocCreateTime(new Date());
		kmCarmngCategory.setDocCreator(UserUtil.getUser());
		return super.add(kmCarmngCategory);
	}

}
