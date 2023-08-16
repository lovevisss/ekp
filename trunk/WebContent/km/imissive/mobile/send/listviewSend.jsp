<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

	<div data-dojo-type="mui/header/Header" data-dojo-props="height:'3.8rem'">
		<div
			data-dojo-type="mui/nav/MobileCfgNavBar" 
			data-dojo-props="defaultUrl:'/km/imissive/mobile/send/navSend.jsp',modelName:'com.landray.kmss.km.imissive.model.KmImissiveSendMain'">
		</div>
		<div data-dojo-type="mui/header/HeaderItem"
			data-dojo-mixins="mui/folder/Folder" 
			data-dojo-props="tmplURL:'/km/imissive/mobile/send/querySend.jsp'">
		</div> 
	</div>
	
	<div data-dojo-type="mui/list/NavSwapScrollableView" class="gray">
	    <ul 
	    	data-dojo-type="mui/list/JsonStoreList"
	    	data-dojo-mixins="mui/list/CardItemDListMixin">
		</ul>
	</div>
