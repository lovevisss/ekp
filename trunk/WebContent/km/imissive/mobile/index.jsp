<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include file="/sys/mportal/module/mobile/jsp/module.jsp">

    <%-- 浏览器title --%>
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			<c:out value="${lfn:message('km-imissive:kmImissive.tree.title')}"></c:out>
		</c:if>
	</template:replace>
	
	<%-- 导入JS、CSS --%>
	<template:replace name="head">
	    <mui:cache-file name="mui-kmImissive-indexMain.js" cacheType="md5"/>
		<script type="text/javascript">
		   window.buttons=[];  
		   <%-- 新建发文(按钮) --%>
		   <kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE">
		      window.buttons.push("send_create");
		   </kmss:authShow>		   
		   <%-- 新建收文(按钮) --%>
		   <kmss:authShow roles="ROLE_KMIMISSIVE_RECEIVE_CREATE">
		  	  window.buttons.push("receive_create");
		   </kmss:authShow>
		   <%-- 新建签报(按钮) --%>
		   <kmss:authShow roles="ROLE_KMIMISSIVE_SIGN_CREATE">
		      window.buttons.push("sign_create");
		   </kmss:authShow>
		   <!-- 有新建发文或新建收文或新建签报的权限，才展示新建icon -->
			<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE;ROLE_KMIMISSIVE_RECEIVE_CREATE;ROLE_KMIMISSIVE_SIGN_CREATE">
				<!-- kmImissiveRoles 属性在Module.js中用来判断是否解析生成新建按钮 -->
				window.kmImissiveRoles = ['addRole'];
			</kmss:authShow>
		</script>          
	</template:replace>
	
	<%-- 页面内容 --%>
	<template:replace name="content">
		<div data-dojo-type="km/imissive/mobile/module/js/Module"
			 data-dojo-mixins="km/imissive/mobile/module/js/ModuleMixin">
		</div>
	</template:replace>

</template:include>

