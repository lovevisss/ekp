<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include 
		showQrcode="${existOpinion}"
		pathFixed='yes' 
		ref="missive.view"
		rightWidth="50%"
		rightShow ="yes"
		rightBar="yes"
		formName = "kmImissiveSignMainForm"
		formUrl="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_sign_main/kmImissiveSignMain.do">
  		<%@include file="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_viewHead.jsp"%>
  		<%@include file="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_tabContent.jsp"%>
 </template:include>
