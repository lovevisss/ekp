<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page import="com.landray.kmss.util.DateUtil"%>
<%@ page import="com.landray.kmss.km.imeeting.forms.KmImeetingMainForm"%>
<%
	Date now=new Date();
	Boolean isBegin=false,isEnd=false,isFeedBackDeadline = false,canEnter = false;
	KmImeetingMainForm kmImeetingMainForm = (KmImeetingMainForm)request.getAttribute("kmImeetingMainForm");
	if(kmImeetingMainForm.getFdHoldDate()!=null && kmImeetingMainForm.getFdFinishDate()!=null){
		// 会议已开始
		if (DateUtil.convertStringToDate(kmImeetingMainForm.getFdHoldDate(),
				ResourceUtil.getString("date.format.datetime")).getTime() < now.getTime()) {
			isBegin = true;
		}
		
		// 会议已结束
		if (DateUtil.convertStringToDate(kmImeetingMainForm.getFdFinishDate(),
				ResourceUtil.getString("date.format.datetime")).getTime() < now.getTime()) {
			isEnd = true;
		}
		// 视频会议可入会
		if( "3".equals(kmImeetingMainForm.getDocStatusFirstDigit()) && (isEnd == false)){
			canEnter = true;
		}
	}
	if(kmImeetingMainForm.getFdFeedBackDeadline()!=null){
		// 回执截止时间
		if (DateUtil.convertStringToDate(kmImeetingMainForm.getFdFeedBackDeadline(),
				ResourceUtil.getString("date.format.datetime")).getTime() < now.getTime()) {
			isFeedBackDeadline = true;
		}
	}
	
	request.setAttribute("isBegin", isBegin);
	request.setAttribute("isEnd", isEnd);
	request.setAttribute("isFeedBackDeadline", isFeedBackDeadline);
	request.setAttribute("canEnter", canEnter);
	request.setAttribute("now", now.getTime());
%>