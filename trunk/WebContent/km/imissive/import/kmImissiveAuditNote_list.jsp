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
				com.landray.kmss.km.imissive.service.IKmImissiveRegDetailOpinionService"%>

<%
	String fdMainId = request.getParameter("fdMainId");
	String fdDeliverType = request.getParameter("fdDeliverType");
	IKmImissiveRegDetailOpinionService kmImissiveRegDetailOpinionService = (IKmImissiveRegDetailOpinionService)SpringBeanUtil.getBean("kmImissiveRegDetailOpinionService");
	List opinionlist =kmImissiveRegDetailOpinionService.getOpinion(fdMainId,fdDeliverType);
	request.setAttribute("opinionlist", opinionlist);
%>
<c:if test="${opinionlist!=null && fn:length(opinionlist)>0}">
	<table style="width:100%" class="tb_normal">
		<tr class="tr_normal">
			<td width="12%" class="td_normal_title">
				<bean:message bundle="sys-lbpmservice-support" key="lbpmAuditNote.list.date" />
			</td>
			<td width="15%" class="td_normal_title">
				<bean:message bundle="sys-lbpmservice-support" key="lbpmAuditNote.list.fdHandlerId" />
			</td>
			<td width="15%" class="td_normal_title">
				审批人部门
			</td>
			<td width="43%" class="td_normal_title">
				<bean:message bundle="sys-lbpmservice-support" key="lbpmAuditNote.list.fdAuditNote" />
			</td>
		</tr>
		<c:forEach items="${opinionlist}" var="opinion" varStatus="vsStatus">
			<tr>
				<td>
					<kmss:showDate value="${opinion.fdApprovalTime}" type="datetime"></kmss:showDate>
				</td>
				<td>
					<c:out value="${opinion.fdApprover}"></c:out>
				</td>
				<td>
					<c:out value="${opinion.fdApproverDept}"></c:out>
				</td>
				<td>
					<table class="tb_noborder" width="100%">
						<tr>
							<td style="word-wrap: break-word;word-break: break-all;">
								${opinion.fdContent}
							</td>
						</tr>
						<c:import url="/sys/attachment/import/OpinionAtt/sysAttMain_view_qz.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_qz"/>
							<c:param name="formBeanName" value="${param.formBeanName}"/>
							<c:param name="fdModelName" value="${param.fdModelName}" />
							<c:param name="fdModelId" value="${param.fdModelId}" />
						</c:import>
						<c:import url="/sys/attachment/import/OpinionAtt/sysAttMain_view_hw.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_hw"/>
								<c:param name="fdAttType" value="pic"></c:param>
								<c:param name="fdExtendClass" value="muiAuditHandLog"/>
								<c:param name="formBeanName" value="${param.formBeanName}"/>
								<c:param name="fdModelName" value="${param.fdModelName}" />
								<c:param name="fdModelId" value="${param.fdModelId}" />
						</c:import>
						<tr>	
							<td>
								<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_sp"/>
									<c:param name="fdViewType" value="simple" />
									<c:param name="formBeanName" value="${param.formBeanName}"/>
									<c:param name="fdModelName" value="${param.fdModelName}" />
									<c:param name="fdModelId" value="${param.fdModelId}" />
								   	<c:param name="fdForceDisabledOpt" value="edit;print;download;copy" />
								</c:import>
							</td>
						</tr>
						<tr>	
							<td>
								<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_sq"/>
									<c:param name="fdViewType" value="simple" />
									<c:param name="formBeanName" value="${param.formBeanName}"/>
									<c:param name="fdModelName" value="${param.fdModelName}" />
									<c:param name="fdModelId" value="${param.fdModelId}" />
								   	<c:param name="fdForceDisabledOpt" value="edit;print;download;copy" />
								</c:import>
							</td>
						</tr>
						<tr>	
							<td>
								<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						          <c:param name="fdKey" value="${opinion.fdApprovalRecodeId}"/>
						          <c:param name="formBeanName" value="${param.formBeanName}"/>
								  <c:param name="fdModelName" value="${param.fdModelName}" />
								  <c:param name="fdModelId" value="${param.fdModelId}" />
						          <c:param name="fdViewType" value="byte" />
						          <c:param name="fdForceDisabledOpt" value="edit;print;download;copy" />
						        </c:import>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</c:forEach>
	</table>
</c:if>


