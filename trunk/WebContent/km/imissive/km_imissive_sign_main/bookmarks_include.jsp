<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.km.imissive.forms.KmImissiveSignMainForm"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="com.landray.kmss.util.StringUtil"%>
<%
KmImissiveSignMainForm kmImissiveSignMainForm = (KmImissiveSignMainForm)request.getAttribute("kmImissiveSignMainForm");
	JSONObject json = new JSONObject();
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getDocSubject())){
		json.put("docsubject",kmImissiveSignMainForm.getDocSubject());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdDocTypeName())){
		json.put("doctype",kmImissiveSignMainForm.getFdDocTypeName());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdDocNum())){
		json.put("docnum",kmImissiveSignMainForm.getFdDocNum());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdSecretGradeName())){
		json.put("secretgrade",kmImissiveSignMainForm.getFdSecretGradeName());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdEmergencyGradeName())){
		json.put("emergency",kmImissiveSignMainForm.getFdEmergencyGradeName());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdSignatureName())){
		json.put("signature",kmImissiveSignMainForm.getFdSignatureName());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getDocPublishTimeUpper())){
		json.put("signdatecn",kmImissiveSignMainForm.getDocPublishTimeUpper());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getDocPublishTime())){
		json.put("signdaten",kmImissiveSignMainForm.getDocPublishTime());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getDocPublishTimeNum())){
		json.put("signdate",kmImissiveSignMainForm.getDocPublishTimeNum());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdCheckerName())){
		json.put("checker",kmImissiveSignMainForm.getFdCheckerName());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdDraftDeptName())){
		json.put("draftunit",kmImissiveSignMainForm.getFdDraftDeptName());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdDrafterName())){
		json.put("drafter",kmImissiveSignMainForm.getFdDrafterName());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdDraftTime())){
		json.put("drafttime",kmImissiveSignMainForm.getFdDraftTime());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdDeadTime())){
		json.put("deadtime",kmImissiveSignMainForm.getFdDeadTime());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdPrintNum())){
		json.put("printnum",kmImissiveSignMainForm.getFdPrintNum());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdPrintPageNum())){
		json.put("printpagenum",kmImissiveSignMainForm.getFdPrintPageNum());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdContent())){
		json.put("content",kmImissiveSignMainForm.getFdContent());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdReserveOne())){
		json.put("reserveone",kmImissiveSignMainForm.getFdReserveOne());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdReserveTwo())){
		json.put("reservetwo",kmImissiveSignMainForm.getFdReserveTwo());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdReserveThree())){
		json.put("reservethree",kmImissiveSignMainForm.getFdReserveThree());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdReserveFour())){
		json.put("reservefour",kmImissiveSignMainForm.getFdReserveFour());
	}
	if(StringUtil.isNotNull(kmImissiveSignMainForm.getFdReserveFive())){
		json.put("reservefive",kmImissiveSignMainForm.getFdReserveFive());
	}
	request.setAttribute("bookmarkJson",json.toString());
%>