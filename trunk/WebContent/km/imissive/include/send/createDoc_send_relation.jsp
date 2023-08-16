<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDictModel"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDataDict"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.km.imissive.service.IKmImissiveSendMainService"%>
<%
	String titleKey = request.getParameter("titleMsgKey");
	String titleBundle = request.getParameter("titleBundle");
	String titleName = "";
	if (StringUtil.isNotNull(titleKey) && StringUtil.isNotNull(titleBundle)) {
		titleName = ResourceUtil.getString(titleKey, titleBundle);
	}
	request.setAttribute("titleName", titleName);
%>
<template:include ref="default.simple" rwd="true">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
		<%
		
			String DraftCount = ((IKmImissiveSendMainService)SpringBeanUtil.getBean("kmImissiveSendMainService")).getCount(true);
			pageContext.setAttribute("draftTitle",ResourceUtil.getString("km-imissive:kmImissive.tree.draftBox")+"("+DraftCount+")");
			
		%> 
		<div>
			<ui:tabpanel layout="sys.ui.tabpanel.list">
			  <ui:content title="${titleName}">
			  		<div style="background-color: #fff">
			  			<%@ include file="/km/imissive/import/category_search_relation.jsp"%>
			  			<%@ include file="/km/imissive/import/usualCate_relation.jsp"%>
			  			<%@ include file="/km/imissive/import/favorite_category_flat_relation.jsp"%>
			  		</div>
			  </ui:content>
			  <ui:content title="我起草的">
				<ui:iframe  
						src="${LUI_ContextPath }/km/imissive/include/send/index_myDraft.jsp?fdModelName=${param.fdModelName}&urlParam=${param.urlParam}">
				</ui:iframe>
			</ui:content>
		</ui:tabpanel>
	  </div>
	</template:replace> 
</template:include>