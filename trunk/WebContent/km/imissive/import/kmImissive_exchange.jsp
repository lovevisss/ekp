<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include  ref="default.simple">
	<template:replace name="body">
	<div style="width:100%;">
	  <ui:tabpanel layout="sys.ui.tabpanel.list">
		 <ui:content title="${lfn:message('km-imissive:kmImissive.tree.mydistribute') }">
		 	 <ui:iframe id="distribute" src="${LUI_ContextPath }/km/imissive/km_imissive_reg/index_content_reg_distribute.jsp?path=/exchange/mydistribute"></ui:iframe>
		  </ui:content>
		  <ui:content title="${ lfn:message('km-imissive:kmImissive.tree.myreport') }">
		  	<ui:iframe id="distribute" src="${LUI_ContextPath }/km/imissive/km_imissive_reg/index_content_reg_report.jsp?path=/exchange/myreport"></ui:iframe>
		  </ui:content>
		   <ui:content title="${ lfn:message('km-imissive:kmImissive.tree.mysign') }">
		   	<ui:iframe id="sign" src="${LUI_ContextPath }/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList_mySign.jsp?path=/exchange/mysign"></ui:iframe>
		  </ui:content>
		   <ui:content title="${ lfn:message('km-imissive:kmImissive.tree.myreceive') }">
		  	 <ui:iframe id="detaillist" src="${LUI_ContextPath }/km/imissive/km_imissive_regdetail_list/index_content_reglist.jsp?path=/exchange/myreceive"></ui:iframe>
		  </ui:content>
		</ui:tabpanel>
	  </div> 
	</template:replace>
</template:include>
