<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.forms.KmImissiveReceiveMainForm"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="com.landray.kmss.util.StringUtil"%>
<%
KmImissiveReceiveMainForm kmImissiveReceiveMainForm = (KmImissiveReceiveMainForm)request.getAttribute("kmImissiveReceiveMainForm");
	JSONObject json = new JSONObject();
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getDocSubject())){
		json.put("docsubject",kmImissiveReceiveMainForm.getDocSubject());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdDocTypeName())){
		json.put("doctype",kmImissiveReceiveMainForm.getFdDocTypeName());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdSendtoUnitName())){
		json.put("sendunit",kmImissiveReceiveMainForm.getFdSendtoUnitName());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdOtherSendtoUnitsNames())){
		json.put("othersendtounits",kmImissiveReceiveMainForm.getFdOtherSendtoUnitsNames());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdDocNum())){
		json.put("docnum",kmImissiveReceiveMainForm.getFdDocNum());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdReceiveDocNum())){
		json.put("receivenum",kmImissiveReceiveMainForm.getFdReceiveDocNum());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdSecretGradeName())){
		json.put("secretgrade",kmImissiveReceiveMainForm.getFdSecretGradeName());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdEmergencyGradeName())){
		json.put("emergency",kmImissiveReceiveMainForm.getFdEmergencyGradeName());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdSignerName())){
		json.put("signer",kmImissiveReceiveMainForm.getFdSignerName());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdSignTime())){
		json.put("signtime",kmImissiveReceiveMainForm.getFdSignTime());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdRecorderName())){
		json.put("recorder",kmImissiveReceiveMainForm.getFdRecorderName());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdRecordTime())){
		json.put("recordtime",kmImissiveReceiveMainForm.getFdRecordTime());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdDeadTime())){
		json.put("fddeadtime",kmImissiveReceiveMainForm.getFdDeadTime());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdReceiveTime())){
		json.put("receivetime",kmImissiveReceiveMainForm.getFdReceiveTime());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdReceiveUnitName())||StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdOutSendto())){
		json.put("receiveunit",kmImissiveReceiveMainForm.getFdReceiveUnitName()+ kmImissiveReceiveMainForm.getFdOutSendto());
	}
	if(kmImissiveReceiveMainForm.getFdShareNum()!=null){
		json.put("shareNum",kmImissiveReceiveMainForm.getFdShareNum());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdContent())){
		json.put("content",kmImissiveReceiveMainForm.getFdContent());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdReserveOne())){
		json.put("reserveone",kmImissiveReceiveMainForm.getFdReserveOne());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdReserveTwo())){
		json.put("reservetwo",kmImissiveReceiveMainForm.getFdReserveTwo());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdReserveThree())){
		json.put("reservethree",kmImissiveReceiveMainForm.getFdReserveThree());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdReserveFour())){
		json.put("reservefour",kmImissiveReceiveMainForm.getFdReserveFour());
	}
	if(StringUtil.isNotNull(kmImissiveReceiveMainForm.getFdReserveFive())){
		json.put("reservefive",kmImissiveReceiveMainForm.getFdReserveFive());
	}
	request.setAttribute("bookmarkJson",json.toString());
%>