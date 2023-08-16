<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" rwd="true">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
		<div>
			<ui:tabpanel layout="sys.ui.tabpanel.list">
			  <ui:content title="会议纪要">
			  		<div style="background-color: #fff">
			  			<%@ include file="/sys/category/import/category_search.jsp"%>
			  			<%@ include file="/sys/lbpmperson/import/usualCate.jsp"%>
			  			<%@ include file="/sys/person/sys_person_favorite_category/favorite_category_flat.jsp"%>
			  		</div>
			  </ui:content>
			  
			  <ui:content title="我起草的">
			  	  <ui:iframe  src="${LUI_ContextPath }/km/imeeting/km_imeeting_summary/index_draft.jsp"></ui:iframe>
			  </ui:content>
			  
		   </ui:tabpanel>
	  </div>
	</template:replace> 
</template:include>