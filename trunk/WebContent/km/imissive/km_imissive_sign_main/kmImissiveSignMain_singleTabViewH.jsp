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
		formName = "kmImissiveSignMainForm"
		formUrl="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_sign_main/kmImissiveSignMain.do">
  		<%@include file="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_viewHead.jsp"%>
  		<%@include file="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_singleTabContent.jsp"%>
 </template:include>
