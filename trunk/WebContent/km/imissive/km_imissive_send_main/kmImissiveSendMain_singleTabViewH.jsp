<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

 	<template:include 
		showQrcode="${existOpinion}"
		pathFixed='yes'
		ref="missive.view"
		rightWidth="414px"
		rightShow ="yes"
		rightBar="yes"
		leftBar="no"
		rightNavMode="horizontal"
		formName = "kmImissiveSendMainForm"
		formUrl="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do">
 		<%@include file="/km/imissive/km_imissive_send_main/kmImissiveSendMain_viewHead.jsp"%>
  		<%@include file="/km/imissive/km_imissive_send_main/kmImissiveSendMain_singleTabContent.jsp"%>
 	</template:include>
