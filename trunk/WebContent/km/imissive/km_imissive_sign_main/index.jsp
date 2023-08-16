<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include ref="default.list">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-imissive:kmImissive.tree.title') }"></c:out>
	</template:replace>
	<%-- 导航路径 --%>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav"  id="categoryId"> 
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self"></ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-imissive:module.km.imissive') }" href="/km/imissive/" target="_self"></ui:menu-item>
		    <ui:menu-item text="${ lfn:message('km-imissive:kmImissive.nav.SignManagement') }" href="/km/imissive/km_imissive_sign_main/index.jsp" target="_self">
				<ui:menu-item text="${ lfn:message('km-imissive:kmImissive.nav.SendManagement') }" href="/km/imissive/index.jsp" target="_self"></ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-imissive:kmImissive.nav.ReceiveManagement') }" href="/km/imissive/km_imissive_receive_main/index.jsp" target="_self"></ui:menu-item>
			   	<ui:menu-item text="${ lfn:message('km-imissive:kmImissive.nav.Exchange') }" href="/km/imissive/km_imissive_reg/index.jsp" target="_self"></ui:menu-item>
			</ui:menu-item>
		</ui:menu>
	</template:replace>
	<template:replace name="nav">
		<ui:combin ref="menu.nav.create">
			<ui:varParam name="title" value="${ lfn:message('km-imissive:kmImissive.tree.title') }" />
			<ui:varParam name="button">
				[
					<kmss:authShow roles="ROLE_KMIMISSIVE_SIGN_CREATE">
					{
						"text": "${ lfn:message('km-imissive:kmImissiveSignMain.create.title') }",
						"href": "javascript:addDoc();",
						"icon": "lui_icon_l_icon_12"
					}
					</kmss:authShow>
				]
			</ui:varParam>			
		</ui:combin>
	<div class="lui_list_nav_frame">
	  <ui:accordionpanel>
			<c:import url="/km/imissive/import/nav.jsp" charEncoding="UTF-8">
			   <c:param name="key" value="kmImissiveSign"></c:param>
			    <c:param name="criteria" value="signCriteria"></c:param>
			</c:import>
			<ui:combin ref="menu.nav.favorite.category">
						<ui:varParams 
							modelName="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate"
							onClick="LUI('signCriteria').setValue('fdTemplate','!{value}');resetMenuNavStyleForCate('!{value}');"/>
			</ui:combin>
			<kmss:authShow roles="ROLE_KMIMISSIVE_BACKSTAGE_MANAGER">
			<ui:content title="${ lfn:message('list.otherOpt') }" expand="false">
				<ul class='lui_list_nav_list'>
					<li><a href="${LUI_ContextPath }/sys/profile/index.jsp#app/ekp/km/imissive" target="_blank">${ lfn:message('list.manager') }</a></li>
				</ul>
			</ui:content>
			</kmss:authShow>
		</ui:accordionpanel>
	</div>
	</template:replace>
	<template:replace name="content">  
	   <%@ include file="/km/imissive/km_imissive_sign_main/index_content_sign.jsp"%> 
	</template:replace>
</template:include>
