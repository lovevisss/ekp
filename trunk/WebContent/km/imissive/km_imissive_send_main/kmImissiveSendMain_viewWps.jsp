<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="com.landray.kmss.km.imissive.forms.KmImissiveSendMainForm"%>
<%@ page import="com.landray.kmss.util.IDGenerator"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.StringUtil"%>


  <template:include ref="default.view"  sidebar="auto" >
  		<%@include file="/km/imissive/km_imissive_send_main/kmImissiveSendMain_viewHeadWps.jsp"%>
  		<%@include file="/km/imissive/km_imissive_send_main/kmImissiveSendMain_wpsContent.jsp"%>
  </template:include>
