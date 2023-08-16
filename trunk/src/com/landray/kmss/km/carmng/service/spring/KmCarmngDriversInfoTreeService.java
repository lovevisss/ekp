package com.landray.kmss.km.carmng.service.spring;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IXMLDataBean;
import com.landray.kmss.constant.SysAuthConstant;
import com.landray.kmss.km.carmng.model.KmCarmngDriversInfo;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.km.carmng.service.IKmCarmngDriversInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngMotorcadeSetService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPost;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.BooleanUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class KmCarmngDriversInfoTreeService implements IXMLDataBean {

	private IKmCarmngDriversInfoService kmCarmngDriversInfoService;
	
	private IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService = null;

	public void setKmCarmngDriversInfoService(
			IKmCarmngDriversInfoService kmCarmngDriversInfoService) {
		this.kmCarmngDriversInfoService = kmCarmngDriversInfoService;
	}

	@Override
    public List getDataList(RequestContext requestInfo) throws Exception {
		List rtnList = new ArrayList();
		String motorcadeId = requestInfo.getParameter("motorcadeId");
		String kind = requestInfo.getParameter("kind");
		String method = requestInfo.getParameter("method");
		String keyword = requestInfo.getParameter("keyword");
		
		if (StringUtil.isNull(motorcadeId) && "dataList".equals(method)
				&& StringUtil.isNull(keyword)) {
			//移动端获取数据，没有传车队ID则列出所有的车队
			getAllMotorcadeForMobile(rtnList);	
			return rtnList;
		}else if("detail".equals(method)){
			////移动端获取数据，获取明细
			String fdId =  requestInfo.getParameter("fdId");
			KmCarmngDriversInfo kmCarmngDriversInfo = (KmCarmngDriversInfo) kmCarmngDriversInfoService.findByPrimaryKey(fdId);
			Map<String, Object> node = new HashMap<String, Object>();
			node.put("text", kmCarmngDriversInfo.getFdName());
			node.put("value", kmCarmngDriversInfo.getFdId());
			node.put("id", kmCarmngDriversInfo.getFdId());
			node.put("fdRelationPhone",kmCarmngDriversInfo.getFdRelationPhone());
			node.put("sysId", kmCarmngDriversInfo.getFdSysId() == null ? "" : kmCarmngDriversInfo.getFdSysId());
			rtnList.add(node);
			return rtnList;			
		}
		//pc端获取数据
		HQLInfo hql = new HQLInfo();
		String whereBlock = "1 < 2";
        if (StringUtil.isNotNull(motorcadeId)) {
			whereBlock = "kmCarmngDriversInfo.fdMotorcade.fdId =:motorcadeId";
			hql.setParameter("motorcadeId", motorcadeId);
		}
		if (StringUtil.isNotNull(keyword)) {
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					"kmCarmngDriversInfo.fdName like :keyword");
			hql.setParameter("keyword", "%" + keyword + "%");
			if (UserUtil.checkRole("ROLE_KMCARMNG_ATTEMPER")) {
				whereBlock += " and 1 = 1";
			} else if (UserUtil.checkRole("ROLE_KMCARMNG_MOTORCADE_ATTEMPER")) {
				whereBlock += " and (kmCarmngDriversInfo.fdMotorcade.fdDispatchers.fdId =:userId";
				hql.setParameter("userId", UserUtil.getKMSSUser().getUserId());
				List list = new ArrayList<String>();
				for (Object obj : UserUtil.getUser().getFdPosts()) {
					SysOrgPost post = (SysOrgPost) obj;
					list.add(post.getFdId());
				}
				if (list.size() > 0) {
					whereBlock += " or " + HQLUtil.buildLogicIN(
							" kmCarmngDriversInfo.fdMotorcade.fdDispatchers.fdId ",
							list)
							+ ")";
				} else {
					whereBlock += ")";
				}
			} else {
				whereBlock += " and 1 = 0";
			}
		}
		hql.setWhereBlock(whereBlock);
		List<KmCarmngDriversInfo> valueList = kmCarmngDriversInfoService.findList(hql);
		List<String> sysIds = new ArrayList<>();
		for (KmCarmngDriversInfo kmCarmngDriversInfo : valueList) {
			String sysId = kmCarmngDriversInfo.getFdSysId();
			if (StringUtil.isNotNull(sysId)) {
				sysIds.add(sysId);
			}
		}
		Map<String, Boolean> availables = new HashMap<>();
		if (CollectionUtils.isNotEmpty(sysIds)) {
			hql = new HQLInfo();
			hql.setModelName(SysOrgElement.class.getName());
			hql.setSelectBlock("sysOrgElement.fdId, sysOrgElement.fdIsAvailable");
			hql.setWhereBlock("sysOrgElement.fdId in (:ids)");
			hql.setParameter("ids", sysIds);
			List<Object[]> list = kmCarmngDriversInfoService.findList(hql);
			for (Object[] objs : list) {
				availables.put((String) objs[0], (Boolean) objs[1]);
			}
		}
		for (KmCarmngDriversInfo kmCarmngDriversInfo : valueList) {
			Map node = new HashMap();
			node.put("text", kmCarmngDriversInfo.getFdName());
			node.put("value", kmCarmngDriversInfo.getFdId());
			node.put("name", kmCarmngDriversInfo.getFdName());
			node.put("id", kmCarmngDriversInfo.getFdId());
			node.put("fdRelationPhone", kmCarmngDriversInfo
					.getFdRelationPhone());
			// 如果是注册用户，需要判断是否被禁用
			String sysId = kmCarmngDriversInfo.getFdSysId();
			if (StringUtil.isNotNull(sysId) && BooleanUtils.isNotTrue(availables.get(sysId))) {
				continue;
			}
			node.put("sysId", sysId);
			rtnList.add(node);
		}
		return rtnList;
	}
	
	private void getAllMotorcadeForMobile(List rtnList) throws Exception{
		HQLInfo hql = new HQLInfo();
		String whereBlock = "( kmCarmngMotorcadeSet.isEffective = 'true' or kmCarmngMotorcadeSet.isEffective is null )";
		hql.setCheckParam(SysAuthConstant.CheckType.AllCheck,
				SysAuthConstant.AllCheck.DEFAULT);
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
				whereBlock += " or " + HQLUtil.buildLogicIN(
						" kmCarmngMotorcadeSet.fdDispatchers.fdId ", list)
						+ ")";
			} else {
				whereBlock += ")";
			}
		} else {
			whereBlock += " and 1 = 0";
		}
		hql.setWhereBlock(whereBlock);
		hql.setOrderBy("kmCarmngMotorcadeSet.fdOrder asc");
		List<KmCarmngMotorcadeSet> categoryList = kmCarmngMotorcadeSetService
				.findValue(hql);
		for (KmCarmngMotorcadeSet kmCarmngMotorcadeSet : categoryList) {
			Map node = new HashMap();
			node.put("text", kmCarmngMotorcadeSet.getFdName());
			node.put("value", kmCarmngMotorcadeSet.getFdId());
			node.put("nodeType", "CATEGORY");
			rtnList.add(node);
		}		
	}
	public void setKmCarmngMotorcadeSetService(
			IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService) {
		this.kmCarmngMotorcadeSetService = kmCarmngMotorcadeSetService;
	}
}
