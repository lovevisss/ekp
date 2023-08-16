<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDictModel"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDataDict"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.km.imissive.service.IKmImissiveSendMainService"%>
<template:include ref="default.simple" rwd="true">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
		<style>
			.createPanelItem{
				width:32%;
				float: left;
			}
		</style>
		<div class="createPanelContainer">
			<div class="createPanelItem">
				<ui:iframe id="sendFrame" src=""></ui:iframe>
			</div>
			<div class="createPanelItem">
				<ui:iframe id="receiveFrame" src=""></ui:iframe>
			</div>
			<div class="createPanelItem">
				<ui:iframe id="signFrame" src=""></ui:iframe>
			</div>
		 </div>
		 <script>
		 	LUI.ready(function(){
		 		
		 		var sendFrame=LUI("sendFrame");
		 		var sendFrameUrl = "${LUI_ContextPath }/km/imissive/import/favorite_category_create.jsp?mainModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendTemplate&isSimpleCategory=false";
		 		sendFrameUrl = Com_SetUrlParameter(sendFrameUrl, 'contentTitle',encodeURIComponent('发文拟稿'));
		 		sendFrame.src=sendFrameUrl;
		 		sendFrame.reload();
		 		
		 		var receiveFrame=LUI("receiveFrame");
		 		var receiveFrameUrl = "${LUI_ContextPath }/km/imissive/import/favorite_category_create.jsp?mainModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&modelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate&isSimpleCategory=false";
		 		receiveFrameUrl = Com_SetUrlParameter(receiveFrameUrl, 'contentTitle',encodeURIComponent('收文登记'));
		 		receiveFrame.src=receiveFrameUrl;
		 		receiveFrame.reload();
		 		
		 		var signFrame=LUI("signFrame");
		 		var signFrameUrl ="${LUI_ContextPath }/km/imissive/import/favorite_category_create.jsp?mainModelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain&modelName=com.landray.kmss.km.imissive.model.KmImissiveSignTemplate&isSimpleCategory=false";
		 		signFrameUrl = Com_SetUrlParameter(signFrameUrl, 'contentTitle',encodeURIComponent('签报拟稿'));
		 		signFrame.src=signFrameUrl;
		 		signFrame.reload();
		 	})
		 </script>
	</template:replace>
</template:include>