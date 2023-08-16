<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view"  sidebar="no">
<template:replace name="content">
<p class="txttitle"><bean:message bundle="km-imissive" key="kmImissiveReceiveMain.opinion.title"/></p>
<center>
<%@ include file="/km/imissive/km_imissive_return_opinion/kmImissiveReturnOpinion_viewinclude.jsp"%>
</center>
</template:replace>
</template:include>