package com.landray.kmss.km.carmng.service.spring;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IXMLDataBean;
import com.landray.kmss.constant.SysAuthConstant;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.km.carmng.service.IKmCarmngMotorcadeSetService;
import com.landray.kmss.sys.organization.model.SysOrgPost;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;

public class KmCarmngMotorcadeSetTreeService implements IXMLDataBean {

	private IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService = null;

	public void setKmCarmngMotorcadeSetService(
			IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService) {
		this.kmCarmngMotorcadeSetService = kmCarmngMotorcadeSetService;
	}

	@Override
    public List getDataList(RequestContext requestInfo) throws Exception {
		List rtnList = new ArrayList();
		String categoryId = requestInfo.getParameter("categoryId");
		String portlet = requestInfo.getParameter("portlet");
		String parentId = requestInfo.getParameter("parentId");
		if (!StringUtil.isNull(parentId)) {
			return null;
		}
		/*
		if (StringUtil.isNotNull(method) && "detailList".equals(method)) {
			//获取车辆详细信息
			KmCarmngMotorcadeSet kmCarmngMotorcadeSet = (KmCarmngMotorcadeSet) kmCarmngMotorcadeSetService
					.findByPrimaryKey(categoryId);
			Map node = new HashMap();
			node.put("label", kmCarmngMotorcadeSet.getFdName());
			node.put("fdId", kmCarmngMotorcadeSet.getFdId());
			rtnList.add(node);
			return rtnList;
		}
		*/
		
		if (StringUtil.isNotNull(categoryId)) {
			return rtnList;
		}

		HQLInfo hql = new HQLInfo();
		String whereBlock = "( kmCarmngMotorcadeSet.isEffective = 'true' or kmCarmngMotorcadeSet.isEffective is null )";
		hql.setOrderBy("kmCarmngMotorcadeSet.fdOrder asc");
		hql.setCheckParam(SysAuthConstant.CheckType.AllCheck, SysAuthConstant.AllCheck.DEFAULT);
		if (UserUtil.checkRole("ROLE_KMCARMNG_ATTEMPER")) {
			whereBlock += " and 1 = 1";
		} else if (UserUtil.checkRole("ROLE_KMCARMNG_MOTORCADE_ATTEMPER")) {
			whereBlock += " and (kmCarmngMotorcadeSet.fdDispatchers.fdId =:userId";
			hql.setParameter("userId", UserUtil.getKMSSUser().getUserId());
			List list = new ArrayList<String>();
			for (Object obj : UserUtil.getUser().getFdPosts()) {
				SysOrgPost post = (SysOrgPost) obj;
				list.add(post.getFdId());
			}
			if (list.size() > 0) {
				whereBlock += " or " + HQLUtil.buildLogicIN(" kmCarmngMotorcadeSet.fdDispatchers.fdId ", list) + ")";
			} else {
				whereBlock += ")";
			}
		} else {
			whereBlock += " and 1 = 0";
		}
		hql.setWhereBlock(whereBlock);
		List<KmCarmngMotorcadeSet> categoryList = kmCarmngMotorcadeSetService
				.findValue(hql);
		if (StringUtil.isNull(portlet)) {
			for (KmCarmngMotorcadeSet kmCarmngMotorcadeSet : categoryList) {
				Map node = new HashMap();
				node.put("text", kmCarmngMotorcadeSet.getFdName());
				node.put("value", kmCarmngMotorcadeSet.getFdId());
				rtnList.add(node);
			}
		} else {
			for (KmCarmngMotorcadeSet kmCarmngMotorcadeSet : categoryList) {
				Map node = new HashMap();
				node.put("text", kmCarmngMotorcadeSet.getFdName());
				node.put("value", kmCarmngMotorcadeSet.getFdId());
				node.put("id", kmCarmngMotorcadeSet.getFdId());
				node.put("name", kmCarmngMotorcadeSet.getFdName());
				node.put("nodeType", "CATEGORY");
				rtnList.add(node);
			}
		}
		return rtnList;
	}
	
}
