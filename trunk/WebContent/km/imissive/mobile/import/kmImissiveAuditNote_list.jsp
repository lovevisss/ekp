<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.util.AttImageUtils"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/kmss-bean.tld" prefix="bean"%>
<%@page import="java.util.List,
				java.lang.StringBuffer,
				com.landray.kmss.util.StringUtil,
				com.landray.kmss.util.SpringBeanUtil,
				com.landray.kmss.km.imissive.service.IKmImissiveReturnOpinionService"%>

<%
	String fdMainId = request.getParameter("fdId");
	IKmImissiveReturnOpinionService kmImissiveReturnOpinionService = (IKmImissiveReturnOpinionService)SpringBeanUtil.getBean("kmImissiveReturnOpinionService");
	List opinionlist =kmImissiveReturnOpinionService.getOpinion(fdMainId);
	request.setAttribute("opinionlist", opinionlist);
%>
<c:if test="${opinionlist!=null && fn:length(opinionlist)>0}">
	<c:forEach items="${opinionlist}" var="opinion" varStatus="vsStatus">
		<div class="muiLbpmserviceAuditNodeItem muiLbpmserviceAuditNodeItemBorder" >
			<div class="muiLbpmserviceAuditNodeItemContainer">
				<div class="muiLbpmserviceAuditNodeInfo">
					<a href="javascript:;">
						<span class="muiLbpmserviceAuditNodeImage" style="background:url(/ekpx/sys/person/image.jsp?personId=166b4392989ad9974a8ca634839b1dfc&amp;size=90&amp;s_time=1541664178000) center center no-repeat;background-size:cover;display:inline-block;">
						</span>
					</a>
					<h4>${opinion.fdApprover}</h4>
					<p class="muiLbpmserviceAuditNodeDate mui mui-time">
						<span>${opinion.fdApprovalTime}</span>
					</p>
				</div>
				<div class="muiLbpmserviceAuditNodeContent">
					<p class="muiLbpmserviceAuditNodeNode">
						${opinion.fdContent}
					</p>
				</div>
			</div>
		</div>
	</c:forEach>
</c:if>


