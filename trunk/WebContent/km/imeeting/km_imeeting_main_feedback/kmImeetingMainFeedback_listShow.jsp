<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.common.forms.IExtendForm"%>
<%@page import="com.landray.kmss.common.actions.RequestContext"%>
<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingMainFeedbackForm"%>
<%@page import="com.landray.kmss.km.imeeting.service.IKmImeetingMainFeedbackService"%>
<%@page import="com.landray.kmss.sys.organization.model.SysOrgPost"%>
<%@page import="com.landray.kmss.sys.organization.model.SysOrgPerson"%>
<%@page import="com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService"%>
<%@page import="com.landray.kmss.km.imeeting.model.KmImeetingMainFeedback" %>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.util.ModelUtil"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<%
	ISysAttMainCoreInnerService sysAttMainCoreInnerService = (ISysAttMainCoreInnerService)SpringBeanUtil.getBean("sysAttMainService");
	IKmImeetingMainFeedbackService kmImeetingMainFeedbackService = (IKmImeetingMainFeedbackService)SpringBeanUtil.getBean("kmImeetingMainFeedbackService");
%>
<list:data>
	<list:data-columns var="kmImeetingMainFeedback" list="${queryPage.list}">
		<%
			KmImeetingMainFeedback feedback = (KmImeetingMainFeedback)pageContext
					.getAttribute("kmImeetingMainFeedback");
		%>
		<list:data-column property="fdId"></list:data-column>
		
		<list:data-column headerClass="width120" property="fdUnitName" title="参会单位"></list:data-column>
		
		<list:data-column headerClass="width200" col="fdAgendaNames" title="议题名称" escape="false">
			<%
				String fdAgendaNames = feedback.getFdAgendaNames();
				String formatNames = "";
				if (StringUtil.isNotNull(fdAgendaNames)) {
					String[] topicName = fdAgendaNames.split(";");
					for (int i = 0; i < topicName.length; i++) {
						formatNames += topicName[i] + "；";
					}
					formatNames = formatNames.substring(0, formatNames.length() - 1);
				}
				request.setAttribute("formatNames", formatNames);
			%>
			${formatNames}
		</list:data-column>
		
		<list:data-column  headerClass="width100" col="personName" title="姓名" escape="false">
			<span class="com_subject"><c:out value="${kmImeetingMainFeedback.docCreator.fdName}" /></span>
		</list:data-column>
		
		<list:data-column  headerClass="width80" col="fdStaffingLevel" title="职务" escape="false">
			<%
				String fdStaffingLevel = "";
				if (feedback.getDocCreator().getFdStaffingLevel() != null) {
					fdStaffingLevel = feedback.getDocCreator().getFdStaffingLevel().getFdName();
				}
				request.setAttribute("fdStaffingLevel", fdStaffingLevel);
			%>
			<span class="com_subject"><c:out value="${fdStaffingLevel}" /></span>
		</list:data-column>
		
		<list:data-column headerClass="width100"  col="fdMobileNo" title="联系方式">
			<%
				if (StringUtil.isNotNull(feedback.getFdMobileNo())) {
					request.setAttribute("fdMobileNo", feedback.getFdMobileNo());
				} else {
					request.setAttribute("fdMobileNo", feedback.getDocCreator().getFdMobileNo());
				}
			%>
			<c:out value="${fdMobileNo}"></c:out>
		</list:data-column>
		
		<list:data-column col="fdOperateType" title="回执结果">
			<c:choose>
				<c:when test="${kmImeetingMainFeedback.fdOperateType eq '01'}">
					<c:out value="参加"></c:out>
				</c:when>
				<c:when test="${kmImeetingMainFeedback.fdOperateType eq '02'}">
					<c:out value="不参加"></c:out>
				</c:when>
				<c:when test="${kmImeetingMainFeedback.fdOperateType eq '07'}">
					<c:out value="已报名"></c:out>
				</c:when>
				<c:otherwise>
					<c:out value="未回执"></c:out>
				</c:otherwise>
			</c:choose>
		</list:data-column>
		
		<list:data-column headerClass="width200" property="fdReason" title="回执备注"></list:data-column>
		
		<list:data-column headerClass="width150" col="att" title="请假附件"  escape="false">
			<% 
				String fdLeaveAttKey = feedback.getFdLeaveAttKey();
				List attList = new ArrayList();
				if (StringUtil.isNotNull(fdLeaveAttKey)) {
					attList = sysAttMainCoreInnerService.findByModelKey(KmImeetingMainFeedback.class.getName(),
							feedback.getFdFeedback().getFdId(), fdLeaveAttKey);
				} else {
					attList = sysAttMainCoreInnerService.findByModelKey(KmImeetingMainFeedback.class.getName(),
							feedback.getFdId(), "fdAttKey");
				}
				request.setAttribute("attList", attList);
			%>
			<div class="conf_show_more_w">
				<c:forEach items="${attList}" var="feedbackAttItem" varStatus="vStatus">
					
					<%
						SysAttMain sysAttMain = (SysAttMain) pageContext.getAttribute("feedbackAttItem");
						if (sysAttMain.getFdContentType().indexOf("image/") > -1) {
							request.setAttribute("fdAttType", "img");
						} else if (sysAttMain.getFdContentType().indexOf("application/pdf") > -1) {
							request.setAttribute("fdAttType", "pdf");
						} else if (sysAttMain.getFdContentType().indexOf("text/plain") > -1) {
							request.setAttribute("fdAttType", "txt");
						} else {
							request.setAttribute("fdAttType", "other");
						}
					%>
					<c:choose>
						<c:when test="${fdAttType eq 'img'}">
							<div class="feedback_btn feedbackPicAtt" data-img-id="${feedbackAttItem.fdId}" onclick="openFeedbackImg('${feedbackAttItem.fdId}')">
								<span class="btn_txt" style="cursor:pointer;">${feedbackAttItem.fdFileName}</span>
							</div>
						</c:when>
						<c:when test="${fdAttType eq 'pdf' or fdAttType eq 'txt'}">
							<div class="feedback_btn">
								<a class="btn_txt" href="javascript:viewFeedbackAtt('${feedbackAttItem.fdId}', 'readDownload')">${feedbackAttItem.fdFileName}</a>
							</div>
						</c:when>
						<c:otherwise>
							<div class="feedback_btn">
								<a class="btn_txt" href="javascript:viewFeedbackAtt('${feedbackAttItem.fdId}', 'view')">${feedbackAttItem.fdFileName}</a>
							</div>
						</c:otherwise>
					</c:choose>
					
				</c:forEach>		
			</div>
		</list:data-column>	
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>