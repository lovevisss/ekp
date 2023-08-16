<%@page import="com.landray.kmss.km.imissive.service.IKmImissiveReturnOpinionService"%>
<%@page import="com.landray.kmss.km.imissive.model.KmImissiveRegDetailList"%>
<%@page import="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion"%>
<%@page import="com.landray.kmss.km.imissive.util.ImissiveConstants"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.km.imissive.service.IKmImissiveRegDetailListService"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.km.imissive.forms.KmImissiveSendMainForm"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>	

<c:if test="${kmImissiveSendMainForm.fdIsAdvice eq true}">
	<%
		KmImissiveSendMainForm kmImissiveSendMainForm = (KmImissiveSendMainForm)request.getAttribute("kmImissiveSendMainForm");
		if(kmImissiveSendMainForm != null){
			String fdMainId = kmImissiveSendMainForm.getFdId();
			IKmImissiveRegDetailListService kmImissiveRegDetailListService  = (IKmImissiveRegDetailListService)SpringBeanUtil.getBean("kmImissiveRegDetailListService");
			List regDetailList = kmImissiveRegDetailListService.findByRegTypeAndMain(fdMainId, ImissiveConstants.REG_TYPE_SEND, ImissiveConstants.DELIVERTYPE_ADVICE, "");
			request.setAttribute("regDetailList", regDetailList);
		}
	%>
	<c:if test="${not empty regDetailList}">
	<table class="tb_normal" width="100%">
		<tr>
			<td width="10%" class="td_normal_title">
				反馈处室
			</td>
			<td width="8%" class="td_normal_title" >
				反馈人
			</td>
			<td width="15%" class="td_normal_title">
				反馈时间
			</td>
			<td width="8%"class="td_normal_title">
				状态
			</td>
			<td width="20%" class="td_normal_title">
				反馈结果
			</td>
			<td width="31%" class="td_normal_title">
				相关附件
			</td>
			<td width="8%" class="td_normal_title">
				操作
			</td>
		</tr>
		
		<c:forEach items="${regDetailList}" var="regDetail">
			<%
				KmImissiveRegDetailList kmImissiveRegDetailList = (KmImissiveRegDetailList)pageContext.getAttribute("regDetail");
				IKmImissiveReturnOpinionService kmImissiveReturnOpinionService = (IKmImissiveReturnOpinionService)SpringBeanUtil.getBean("kmImissiveReturnOpinionService");
				List opinions  = kmImissiveReturnOpinionService.findByDetailAndType(kmImissiveRegDetailList.getFdId(), ImissiveConstants.REGDETAIL_STATUS_ADVICE_RECEIVED);
				if(opinions.size() >0){
					for (int i = 0; i < opinions.size(); i++) {
						KmImissiveReturnOpinion kmImissiveReturnOpinion = (KmImissiveReturnOpinion)opinions.get(i);
						request.setAttribute("kmImissiveReturnOpinion", kmImissiveReturnOpinion);
			%>
				<tr>
					<td width="10%">
						<c:out value="${regDetail.fdUnit.fdName}"></c:out>
					</td>
					<td width="8%">
						<c:out value="${kmImissiveReturnOpinion.docCreator.fdName}"></c:out>
					</td>
					<td width="15%">
						<kmss:showDate type="datetime" value="${kmImissiveReturnOpinion.docCreateTime}"/>
					</td>
					<td width="8%">
						已办结
					</td>
					<td width="20%">
						<c:out value="${kmImissiveReturnOpinion.docContent}"></c:out>
					</td>
					<td width="31%">
						<c:choose>
							<c:when test="${kmImissiveSendMainForm.method_GET eq 'viewXformInfo'}">
								<c:import url="/resource/html_locate/sysAttMain_view.jsp"  charEncoding="UTF-8">
									<c:param name="fdKey" value="opinionAtt"/>
									<c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
									<c:param name="fdModelId" value="${kmImissiveReturnOpinion.fdId}" />
								   	<c:param name="fdForceDisabledOpt" value="edit;print;download;copy" />
								</c:import>
							</c:when>
							<c:otherwise>
								<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="opinionAtt"/>
									<c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
									<c:param name="fdModelId" value="${kmImissiveReturnOpinion.fdId}" />
								   	<c:param name="fdForceDisabledOpt" value="edit;print;download;copy" />
								</c:import>
							</c:otherwise>	
						</c:choose>	
					</td>
					<td width="8%">
						<c:if test="${not empty regDetail.fdReceiveId}">
							<a class="com_btn_link" href="javascript:void(0);" onclick="receiveDetail('${regDetail.fdReceiveId}');">详情</a>
						</c:if>
					</td>
				</tr>
			<%} %>
		<%}else{ %>
			<tr>
				<td width="10%">
					<c:out value="${regDetail.fdUnit.fdName}"></c:out>
				</td>
				<td width="8%">
					
				</td>
				<td width="15%">
					
				</td>
				<td width="8%">
					办理中
				</td>
				<td width="20%">
					
				</td>
				<td width="31%">
					
				</td>
				<td width="8%">
					
				</td>
			</tr>
		<%} %>
		</c:forEach>
	</table>
	</c:if>
	<script>
		function receiveDetail(fdReceiveId){
			window.open('<c:url value="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=${kmImissiveSendMainForm.fdId}&spreadAuth=true&fdTargetModelId="/>'+fdReceiveId,'_blank');
		}
	</script>
</c:if>

