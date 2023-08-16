<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil" %>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
<%-- --套红头 -- --%>
<jsp:include page="/km/imissive/kmImissiveRedhead_script.jsp"></jsp:include>
<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendRedhead_script.jsp"></jsp:include>
<c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
	<div class="lui_form_content_frame">
		 <jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_content_include.jsp"></jsp:include>
	</div>
</c:if>
<c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
	<!-- 提示信息 -->
	<c:forEach items="${kmImissiveSendMainForm.attachmentForms['editonline'].attachments}" var="sysAttMain"	varStatus="vstatus">
		<c:set var="fdAttMainId" value="${sysAttMain.fdId}" scope="request"/>
	</c:forEach>
		<div class="lui_form_content_frame">
			<c:if test="${editStatus == true or editFlag == true }">
				<kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
					<c:set var="isReadOnly" value="false" scope="request" />
				</kmss:auth>
				<c:if  test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true' and editFlag != true}">
					<c:set var="isReadOnly" value="false" scope="request" />
			    </c:if>
				 <div id="missiveButtonDiv" >
				 </div>
				 <c:choose>
					<c:when test="${_isWpsCloudEnable}">
						<c:choose>
							<c:when test="${isReadOnly}">
								<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_view.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="editonline" />
									<c:param name="load" value="false" />
									<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
									<c:param name="formBeanName" value="kmImissiveSendMainForm" />
									<c:param  name="contentFlag"  value="true"/>
								</c:import>
							</c:when>
							<c:otherwise>
								<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_edit.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="editonline" />
									<c:param name="load" value="false" />
									<c:param name="bindSubmit" value="false"/>	
									<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
									<c:param name="formBeanName" value="kmImissiveSendMainForm" />
									<c:param name="fdTemplateModelId" value="${kmImissiveSendMainForm.fdTemplateId}" />
									<c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
									<c:param name="fdTemplateKey" value="editonline" />
									<c:param name="fdTempKey" value="${kmImissiveSendMainForm.fdTemplateId}" />
									<c:param name="buttonDiv" value="missiveButtonDiv" />
								</c:import>
							</c:otherwise>
						</c:choose>
					</c:when>
					 <c:when test="${_isWpsCenterEnable}">
						 <c:choose>
							 <c:when test="${isReadOnly}">
								 <c:import url="/sys/attachment/sys_att_main/wps/center/sysAttMain_view.jsp" charEncoding="UTF-8">
									 <c:param name="fdKey" value="editonline" />
									 <c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
									 <c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
									 <c:param name="formBeanName" value="kmImissiveSendMainForm" />
									 <c:param  name="contentFlag"  value="true"/>
									 <c:param name="wpsPreview" value="0010000" />
								 </c:import>
							 </c:when>
							 <c:otherwise>
								 <c:import url="/sys/attachment/sys_att_main/wps/center/sysAttMain_edit.jsp" charEncoding="UTF-8">
									 <c:param name="fdKey" value="editonline" />
									 <c:param name="load" value="true" />
									 <c:param name="bindSubmit" value="false"/>
									 <c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
									 <c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
									 <c:param name="formBeanName" value="kmImissiveSendMainForm" />
									 <c:param name="fdTemplateModelId" value="${kmImissiveSendMainForm.fdTemplateId}" />
									 <c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
									 <c:param name="fdTemplateKey" value="editonline" />
									 <c:param name="fdTempKey" value="${kmImissiveSendMainForm.fdTemplateId}" />
									 <c:param name="buttonDiv" value="missiveButtonDiv" />
								 </c:import>
							 </c:otherwise>
						 </c:choose>
					 </c:when>
					<c:otherwise>
						<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_edit.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="editonline" />
							<c:param name="fdAttType" value="office" />
							<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
							<c:param name="formBeanName" value="kmImissiveSendMainForm" />
							<c:param name="bookMarks"  value="${bookmarkJson}"/>
							<c:param name="isToImg" value="false"/>
							<c:param name="isReadOnly" value="${isReadOnly}"/>
							<c:param name="buttonDiv" value="missiveButtonDiv" />
							<c:param name="showRevisions" value="<%=KmImissiveConfigUtil.isShowRevision()%>" />
							<c:param name="forceRevisions" value="${forceRevisions}"/>
							<c:param name="trackRevisions" value="${trackRevisions}"/>
							<c:param name="attHeight" value="566"/>
						</c:import>
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${editStatus != true}">
					<%if(JgWebOffice.isJGEnabled()){%>
						  <%if(("true".equals(KmImissiveConfigUtil.isShowImg())&&"true".equals(KmImissiveConfigUtil.isShowImg4Content()))||"false".equals(KmImissiveConfigUtil.isShowImg())){ %>
							<%--编辑正文 --%>
							<c:if  test="${not empty isReadOnly and  isReadOnly != 'true' && kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true' and editFlag != true}">
								<c:choose>
								  <c:when test="${isIE}">
									 <c:set var="editable" value="true"></c:set>
								  </c:when>
								  <c:otherwise>
									  <%if(JgWebOffice.isJGMULEnabled()){%>
										  <c:set var="editable" value="true"></c:set>
									  <%} %>
								  </c:otherwise>
							    </c:choose>
						    </c:if>
						    <%} %>
					 <%} %>
					 <div id="editonline">
			 		 <% if("tab".equals(KmImissiveConfigUtil.getDisplayMode()) && "false".equals(KmImissiveConfigUtil.isExpandContent4Send())){%>
			 			<script type="text/javascript">
			 			$(document).ready(function(){
							setTimeout(function(){
								$('.contentArea').hide();
								$('.jg_tip_container').hide();
								if($('.bar-right') && $('.content')){
									$('.bar-right').css('width','30%');
									$('.content').css('margin-right','31.5%');
								}
							},100);
			 			});
						</script>
				 		 <c:import url="/km/imissive/import/sysAttMain_view_swf2.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="editonline" />
							<c:param name="fdAttType" value="office" />
							<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
							<c:param name="formBeanName" value="kmImissiveSendMainForm" />
							<c:param  name="contentFlag"  value="true"/>
							<c:param  name="protectstatus"  value="${protectstatus}"/>
							<c:param  name="bookMarks"  value="${bookmarkJson}"/>
						    <c:param name="isShowImg" value="${isShowImg}"/>
						    <c:param  name="showAllPage"  value="${showAllPage}"/>
						    <c:param name="buttonDiv" value="missiveButtonDiv" />
						    <c:param name="editable" value="${editable}" />
						    <c:param name="editUrl" value="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=${param.fdId}&editFlag=true" />
						</c:import>
					<%}else{%>
					<%if(com.landray.kmss.sys.attachment.util.JgWebOffice.isJGEnabled()&&JgWebOffice.isExistViewPath(request)){%>
					   <c:if test="${isShowImg and editStatus != true and (isJGMULEnabled or isIE)}">
						   	<table class="tb_normal" width="100%">
							   <tr>
							     	<td colspan="4">
							     	  <font style="text-align:center"><bean:message  bundle="km-imissive" key="kmMissiveMain.prompt"/></font>
							        </td>
							   </tr>
						    </table>
					  </c:if>
					<%}%>
					<div id="missiveButtonDiv" >
					    <jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_btn_include.jsp"></jsp:include>
					   <c:if test="${editable eq true}">
					   	 <a href="javascript:void(0);" class="editContent com_btn_link"
							onclick="Com_OpenWindow('kmImissiveSendMain.do?method=view&fdId=${param.fdId}&editFlag=true','_self');">
						   <bean:message  bundle="km-imissive" key="kmImissive.editDocContent"/>
						 </a>
					   </c:if>
					<%if(("true".equals(KmImissiveConfigUtil.isShowImg())&&"true".equals(KmImissiveConfigUtil.isShowImg4Content()))||"false".equals(KmImissiveConfigUtil.isShowImg())){ %>
						<c:if  test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true' and editFlag == true}">
						   <a href="javascript:void(0);" class="back com_btn_link"
								onclick="Com_OpenWindow('kmImissiveSendMain.do?method=view&fdId=${param.fdId}','_self');">
							   返回
						   </a>
						</c:if>
					<%} %>
				    </div>
			 		<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_include_viewHtml.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="editonline" />
						<c:param name="fdAttType" value="office" />
						<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
						<c:param name="formBeanName" value="kmImissiveSendMainForm" />
						<c:param  name="contentFlag"  value="true"/>
						<c:param  name="protectstatus"  value="${protectstatus}"/>
						<c:param  name="bookMarks"  value="${bookmarkJson}"/>
					    <c:param name="isShowImg" value="${isShowImg}"/>
					    <c:param  name="showAllPage"  value="${showAllPage}"/>
					    <c:param name="editable" value="${editable}" />
					    <c:param name="buttonDiv" value="missiveButtonDiv" />
					</c:import>
					<%}%>
				</div>	
			</c:if>
		</div>
</c:if>
<%if("flat".equals(KmImissiveConfigUtil.getDisplayMode())){ %>
 <c:if test="${not empty kmImissiveSendMainForm.attachmentForms['attachment'].attachments or editAtt eq true}">
  <div class="lui_form_content_frame" style="padding-top:10px">
	<div class="lui_form_spacing"></div> 
	<div>
		<div class="lui_form_subhead"><img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png"> ${ lfn:message('sys-doc:sysDocBaseInfo.docAttachments') }(${fn:length(kmImissiveSendMainForm.attachmentForms['attachment'].attachments)})</div>
		<c:choose>
			<c:when test="${editAtt eq true}">
				<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formBeanName" value="kmImissiveSendMainForm" />
					<c:param name="fdKey" value="attachment" />
					<c:param name="fdModelId" value="${param.fdId}" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
				</c:import>
			</c:when>
			<c:otherwise>
				<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"  charEncoding="UTF-8">
					<c:param name="formBeanName" value="kmImissiveSendMainForm" />
					<c:param name="fdKey" value="attachment" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
				</c:import>
			</c:otherwise>
		</c:choose>		
	</div>	
  </div>
</c:if>
<%}%>