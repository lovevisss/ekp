package com.landray.kmss.km.carmng.service.spring;

import org.apache.commons.collections.CollectionUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IXMLDataBean;
import com.landray.kmss.km.carmng.model.KmCarmngCategory;
import com.landray.kmss.km.carmng.service.IKmCarmngCategoryService;
import com.landray.kmss.util.StringUtil;
import org.hibernate.CacheMode;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;
import org.hibernate.type.StandardBasicTypes;

public class KmCarmngCategoryTreeService implements IXMLDataBean {

	private IKmCarmngCategoryService kmCarmngCategoryService;

	public void setKmCarmngCategoryService(
			IKmCarmngCategoryService kmCarmngCategoryService) {
		this.kmCarmngCategoryService = kmCarmngCategoryService;
	}

	@Override
    public List getDataList(RequestContext requestInfo) throws Exception {
		List rtnList = new ArrayList();
		String categoryId = requestInfo.getParameter("categoryId");
		String fdId = requestInfo.getParameter("fdId");
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append( "select fd_id,fd_name from km_carmng_category where 1=1");
		stringBuffer.append(StringUtil.isNull(categoryId)? " and fd_parent_id is null ":"  and fd_parent_id = :categoryId");
		stringBuffer.append(" order by fd_order asc");
		List<Object[]> result;
		NativeQuery query = kmCarmngCategoryService.getBaseDao().getHibernateSession().createNativeQuery(stringBuffer.toString());
		query.setCacheable(true);
		query.setCacheMode(CacheMode.NORMAL);
		query.setCacheRegion("km-carmng");
		// 增加别名
		query.addScalar("fd_id", StandardBasicTypes.STRING).addScalar("fd_name", StandardBasicTypes.STRING);
		if(StringUtil.isNull(categoryId)){
			 result = query.list();
		}else{
			result = query.setParameter("categoryId",categoryId).list();
		}
		if(CollectionUtils.isEmpty(result)){
			return rtnList;
		}
		for (Object[] kmCarmngCategory : result) {
			if (!kmCarmngCategory[0].toString().equals(fdId)) {
				Map node = new HashMap();
				node.put("text", kmCarmngCategory[1]);
				node.put("value", kmCarmngCategory[0]);
				rtnList.add(node);
			}
		}
		return rtnList;
	}

}
