<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include  ref="default.simple" rwd="true">
	<template:replace name="body">
	<div style="width:100%;">
	  <ui:tabpanel layout="sys.ui.tabpanel.list">
		 <ui:content title="${lfn:message('km-imissive:kmImissive.tree.recycle.send') }">
		 	 <ui:iframe id="recysle_send" src="${LUI_ContextPath }/sys/recycle/import/sysRecycle_index.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain"></ui:iframe>
		  </ui:content>
		  <ui:content title="${ lfn:message('km-imissive:kmImissive.tree.recycle.receive') }">
		  	<ui:iframe id="recysle_receive" src="${LUI_ContextPath }/sys/recycle/import/sysRecycle_index.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"></ui:iframe>
		  </ui:content>
		   <ui:content title="${ lfn:message('km-imissive:kmImissive.tree.recycle.sign') }">
		   	<ui:iframe id="recysle_sign" src="${LUI_ContextPath }/sys/recycle/import/sysRecycle_index.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain"></ui:iframe>
		  </ui:content>
		</ui:tabpanel>
	  </div> 
	</template:replace>
</template:include>
