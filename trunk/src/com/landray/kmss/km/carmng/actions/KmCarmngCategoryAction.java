package com.landray.kmss.km.carmng.actions;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.km.carmng.service.IKmCarmngCategoryService;
import com.landray.kmss.sys.simplecategory.actions.SysSimpleCategoryAction;
import com.landray.kmss.util.StringUtil;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇
 */
public class KmCarmngCategoryAction extends SysSimpleCategoryAction

{
	protected IKmCarmngCategoryService kmCarmngCategoryService;

	@Override
	protected IBaseService getServiceImp(HttpServletRequest request) {
		if (kmCarmngCategoryService == null) {
            kmCarmngCategoryService = (IKmCarmngCategoryService) getBean("kmCarmngCategoryService");
        }
		return kmCarmngCategoryService;
	}

	protected String getParentProperty() {
		return "hbmParent";
	}

	@Override
	protected String getFindPageOrderBy(HttpServletRequest request,
			String curOrderBy) throws Exception {
		if (StringUtil.isNull(curOrderBy)) {
			curOrderBy = " kmCarmngCategory.fdOrder asc";
		}
		return curOrderBy;
	}

}
