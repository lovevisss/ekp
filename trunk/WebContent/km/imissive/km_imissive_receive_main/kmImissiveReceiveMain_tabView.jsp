<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

	 <template:include 
		showQrcode="${existOpinion}"
		pathFixed='yes' 
		ref="missive.view"
		rightWidth="50%"
		rightShow ="yes"
		rightBar="yes"
		formName ="kmImissiveReceiveMainForm"
		formUrl="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do">
  		<%@include file="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_viewHead.jsp"%>
  		<%@include file="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_tabContent.jsp"%>
 	 </template:include>
