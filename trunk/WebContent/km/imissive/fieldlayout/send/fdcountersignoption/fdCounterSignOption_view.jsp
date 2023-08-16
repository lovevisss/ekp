<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.imissive.util.SignOptionUtil" %>
<%@ page import="com.landray.kmss.util.StringUtil" %>
<%@ page import="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" %>
<%@ page import="com.landray.kmss.km.imissive.actions.KmImissiveReturnOpinionAction" %>
<%@ include file="/resource/jsp/common.jsp"%>
<style>
.opinionContent{
	width:100%;
	height: auto;
	border-bottom:1px solid #f2f2f2;
	margin-bottom:8px;
}
.opinionContent:LAST-CHILD{
	border-bottom:none;
}
.opinionContent .info{
	margin: 5px 0px 8px 0px;
}

</style>
    	<c:forEach items="${signOpinions}" var="signOpinion">
		 <c:if test="${signOpinion.fdDeliverType eq '3' }">
			  <div class="opinionContent">  	
			            <% KmImissiveReturnOpinion option = (KmImissiveReturnOpinion)pageContext.getAttribute("signOpinion");
			           	   String htmlContent =SignOptionUtil.getHtmlOption(option.getDocContent(),request.getContextPath());
			           	   request.setAttribute("htmlContent",htmlContent);
			           	   if(StringUtil.isNotNull(htmlContent)){
			           	  	 out.write(htmlContent);
			           	   }
			           	   %>
			          <c:if test="${not empty htmlContent}">
				            <p align="right" class="info" >
				            	<c:out value="${signOpinion.fdUnit.fdName}"/>
				                <kmss:showDate value="${signOpinion.docCreateTime}" type="datetime"> </kmss:showDate>
				            </p>
			          </c:if>
			  </div>
		  </c:if>
		  <c:if test="${signOpinion.fdDeliverType eq '6' }">
		 	 <div class="opinionContent"> 
		 		<table class="tb_noborder" style="width:100%">
			 	 	<c:forEach items="${signOpinion.fdAuditNoteList}" var="opinion" varStatus="vsStatus">
			 	 		<c:if test="${not empty opinion.fdContent}">
							<tr>
								<td style="word-wrap: break-word;word-break: break-all;">
									${opinion.fdContent}
								</td>
							</tr>
							<c:import url="/sys/attachment/import/OpinionAtt/sysAttMain_view_qz.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_qz"/>
								<c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
								<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
								<c:param name="fdModelId" value="${signOpinion.fdId}" />
							</c:import>
							<c:import url="/sys/attachment/import/OpinionAtt/sysAttMain_view_hw.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_hw"/>
									<c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
									<c:param name="fdAttType" value="pic"></c:param>
									<c:param name="fdExtendClass" value="muiAuditHandLog"/>
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
									<c:param name="fdModelId" value="${signOpinion.fdId}" />
							</c:import>
							<c:choose>
							    <c:when test="${param.mobile eq 'true'}">
							    	<tr>	
										<td>
											<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
												<c:param name="formName" value="kmImissiveReturnOpinionForm"></c:param>
												<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_sp"/>
												<c:param name="fdViewType" value="simple"></c:param>
												<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
												<c:param name="fdModelId" value="${signOpinion.fdId}" />
											</c:import>
										</td>
									</tr>
									<tr>	
										<td>
											<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
												<c:param name="formName" value="kmImissiveReturnOpinionForm"></c:param>
												<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_sq"/>
												<c:param name="fdViewType" value="simple"></c:param>
												<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
												<c:param name="fdModelId" value="${signOpinion.fdId}" />
											</c:import>
										</td>
									</tr>
									<tr>	
										<td>
											<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
												<c:param name="formName" value="kmImissiveReturnOpinionForm"></c:param>
												<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}"/>
												<c:param name="fdViewType" value="simple"></c:param>
												<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
												<c:param name="fdModelId" value="${signOpinion.fdId}" />
											</c:import>
										</td>
									</tr>
							    </c:when>
							    <c:otherwise>
							    	<tr>	
										<td>
											<c:choose>
												<c:when test="${kmImissiveSendMainForm.method_GET eq 'viewXformInfo'}">
													<c:import url="/resource/html_locate/sysAttMain_view.jsp" charEncoding="UTF-8">
														<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_sp"/>
														<c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
														<c:param name="fdViewType" value="simple" />
														<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
														<c:param name="fdModelId" value="${signOpinion.fdId}" />
													   	<c:param name="fdForceDisabledOpt" value="edit" />
													</c:import>
												</c:when>
												<c:otherwise>
													<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
														<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_sp"/>
														<c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
														<c:param name="fdViewType" value="simple" />
														<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
														<c:param name="fdModelId" value="${signOpinion.fdId}" />
													   	<c:param name="fdForceDisabledOpt" value="edit" />
													</c:import>
												</c:otherwise>	
											</c:choose>	
											
										</td>
									</tr>
									<tr>	
										<td>
											<c:choose>
												<c:when test="${kmImissiveSendMainForm.method_GET eq 'viewXformInfo'}">
													<c:import url="/resource/html_locate/sysAttMain_view.jsp" charEncoding="UTF-8">
														<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_sq"/>
														<c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
														<c:param name="fdViewType" value="simple" />
														<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
														<c:param name="fdModelId" value="${signOpinion.fdId}" />
													   	<c:param name="fdForceDisabledOpt" value="edit" />
													</c:import>
												</c:when>
												<c:otherwise>
													<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
														<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_sq"/>
														<c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
														<c:param name="fdViewType" value="simple" />
														<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
														<c:param name="fdModelId" value="${signOpinion.fdId}" />
													   	<c:param name="fdForceDisabledOpt" value="edit" />
													</c:import>
												</c:otherwise>	
											</c:choose>	
											
										</td>
									</tr>
									<tr>	
										<td>
											<c:choose>
												<c:when test="${kmImissiveSendMainForm.method_GET eq 'viewXformInfo'}">
													<c:import url="/resource/html_locate/sysAttMain_view.jsp" charEncoding="UTF-8">
														 <c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
												          <c:param name="fdKey" value="${opinion.fdApprovalRecodeId}"/>
												          <c:param name="fdModelId" value="${signOpinion.fdId}"/>
												          <c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion"/>
												          <c:param name="fdViewType" value="byte" />
												          <c:param name="fdForceDisabledOpt" value="edit" />
													</c:import>
												</c:when>
												<c:otherwise>
													<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
											          <c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
											          <c:param name="fdKey" value="${opinion.fdApprovalRecodeId}"/>
											          <c:param name="fdModelId" value="${signOpinion.fdId}"/>
											          <c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion"/>
											          <c:param name="fdViewType" value="byte" />
											          <c:param name="fdForceDisabledOpt" value="edit" />
											        </c:import>
												</c:otherwise>	
											</c:choose>	
										</td>
									</tr>
							     </c:otherwise>
							</c:choose> 
							<tr>
								<td>
									<p align="right">
						            	<c:out value="${opinion.fdApproverDept}"></c:out>&nbsp;&nbsp;
						            	<c:out value="${opinion.fdApprover}"></c:out>&nbsp;&nbsp;
						                <kmss:showDate value="${opinion.fdApprovalTime}" type="datetime"> </kmss:showDate>
						            </p>
								</td>
							</tr>
						</c:if>
			 	 	</c:forEach>
			 	 	<c:choose>
					    <c:when test="${param.mobile eq 'true'}">
							<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveReturnOpinionForm"></c:param>
								<c:param name="fdKey" value="opinionAtt"></c:param>
								<c:param name="fdViewType" value="simple"></c:param>
								<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
								<c:param name="fdModelId" value="${signOpinion.fdId}" />
							</c:import>
					    </c:when>
					    <c:otherwise>
					 	 	<tr>
					 	 		<td>
					 	 			<div>
					 	 				<c:choose>
											<c:when test="${kmImissiveSendMainForm.method_GET eq 'viewXformInfo'}">
												<c:import url="/resource/html_locate/sysAttMain_view.jsp" charEncoding="UTF-8">
													<c:param name="fdKey" value="opinionAtt" />
													<c:param name="fdMulti" value="true" />
													<c:param name="formBeanName" value="kmImissiveReturnOpinionForm" />
													<c:param name="fdModelId" value="${signOpinion.fdId }" />
													<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
												</c:import>
											</c:when>
											<c:otherwise>
												<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
													<c:param name="fdKey" value="opinionAtt" />
													<c:param name="fdMulti" value="true" />
													<c:param name="formBeanName" value="kmImissiveReturnOpinionForm" />
													<c:param name="fdModelId" value="${signOpinion.fdId }" />
													<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
												</c:import>
											</c:otherwise>
										</c:choose>		 
						 	 		</div>
					 	 		</td>
					 	 	</tr>
					 	 </c:otherwise>
			 	 	</c:choose>
			 	 	<tr>
			 	 		<td>
			 	 			<div>
				 	 			<p align="right" class="info" >
					            	<c:out value="${signOpinion.fdUnit.fdName}"/>
					                <kmss:showDate value="${signOpinion.docCreateTime}" type="datetime"> </kmss:showDate>
					            </p>
			 	 		</div>
			 	 		</td>
			 	 	</tr>
		 	 	</table>
		  	 </div>
		  </c:if>
		</c:forEach>
      
	
