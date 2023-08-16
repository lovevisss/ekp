<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDictModel"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDataDict"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.km.imissive.service.IKmImissiveSignMainService"%>
<template:include ref="default.simple" rwd="true">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
		<%
		
			String DraftCount = ((IKmImissiveSignMainService)SpringBeanUtil.getBean("kmImissiveSignMainService")).getCount(true);
			pageContext.setAttribute("draftTitle",ResourceUtil.getString("km-imissive:kmImissive.tree.draftBox")+"("+DraftCount+")");
			
		%> 
		<div>
			<ui:tabpanel layout="sys.ui.tabpanel.list">
			  <ui:content title="${lfn:message('km-imissive:kmImissiveSignMain.create.title') }">
			  		<div style="background-color: #fff">
			  			<%@ include file="/sys/category/import/category_search.jsp"%>
			  			<%@ include file="/sys/lbpmperson/import/usualCate.jsp"%>
			  			<%@ include file="/sys/person/sys_person_favorite_category/favorite_category_flat.jsp"%>
			  		</div>
			  </ui:content>
			  <ui:content title="${draftTitle}">
			  		<%@ include file="/km/imissive/km_imissive_sign_main/draftBox.jsp"%>
			  </ui:content>
		   </ui:tabpanel>
	  </div>
	</template:replace> 
</template:include>