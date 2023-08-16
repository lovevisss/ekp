<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil" %>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
<div class="lui_form_content_frame" style="padding-top:10px">
	 <jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_content_include.jsp"></jsp:include>
</div>
<c:if test="${kmImissiveReceiveMainForm.fdNeedContent=='1'}">
<table class="tb_normal" width="100%">
  <!-- 提示信息 -->
		<c:forEach items="${kmImissiveReceiveMainForm.attachmentForms['editonline'].attachments}" var="sysAttMain"	varStatus="vstatus">
			<c:set var="fdAttMainId" value="${sysAttMain.fdId}" scope="request"/>
		</c:forEach>
   		<tr>
		<td colspan="4">
			 <c:if test="${editStatus == true or editFlag == true}">
			 	<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
					<c:set var="isReadOnly" value="false" scope="request" />
				</kmss:auth>
				<c:if  test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true' and editFlag != true}">
					<c:set var="isReadOnly" value="false" scope="request" />
			    </c:if>
			 	 <div id="missiveButtonDiv"> </div>

			 	 <c:choose>
					<c:when test="${_isWpsCloudEnable}">
						<c:choose>
							<c:when test="${isReadOnly}">
								<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_view.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="editonline" />
					 				<c:param name="load" value="false" />
									<c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId}" />
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
									<c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
									<c:param  name="contentFlag"  value="true"/>
								</c:import>
							</c:when>
							<c:otherwise>
								<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_edit.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="editonline" />
									<c:param name="load" value="false" />
									<c:param name="bindSubmit" value="false"/>
									<c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId}" />
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
									<c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
									<c:param name="fdTemplateModelId" value="${kmImissiveReceiveMainForm.fdTemplateId}" />
									<c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate" />
									<c:param name="fdTemplateKey" value="editonline" />
									<c:param name="fdTempKey" value="${kmImissiveReceiveMainForm.fdTemplateId}" />
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
                                     <c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId}" />
                                     <c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
                                     <c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
                                     <c:param  name="contentFlag"  value="true"/>
					 				 <c:param name="wpsPreview" value="0010000" />
                                 </c:import>
                            </c:when>
                            <c:otherwise>
                                 <c:import url="/sys/attachment/sys_att_main/wps/center/sysAttMain_edit.jsp" charEncoding="UTF-8">
                                     <c:param name="fdKey" value="editonline" />
                                     <c:param name="load" value="false" />
                                     <c:param name="bindSubmit" value="false"/>
                                     <c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId}" />
                                     <c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
                                     <c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
                                     <c:param name="fdTemplateModelId" value="${kmImissiveReceiveMainForm.fdTemplateId}" />
                                     <c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate" />
                                     <c:param name="fdTemplateKey" value="editonline" />
                                     <c:param name="fdTempKey" value="${kmImissiveReceiveMainForm.fdTemplateId}" />
                                     <c:param name="buttonDiv" value="missiveButtonDiv" />
                                 </c:import>
                            </c:otherwise>
				        </c:choose>
				    </c:when>
					<c:otherwise>
						<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_edit.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="editonline" />
							<c:param name="fdAttType" value="office" />
							<c:param  name="fdMulti"  value="false" />
							<c:param name="fdModelId" value="${param.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
							<c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
							<c:param name="buttonDiv" value="missiveButtonDiv" />
							<c:param name="isToImg" value="false"/>
							<c:param name="isReadOnly" value="${isReadOnly}"/>
							<c:param  name="bookMarks"  value="${bookmarkJson}"/>
							<c:param name="showRevisions" value="<%=KmImissiveConfigUtil.isShowRevision()%>" />
							<c:param name="attHeight" value="566"/>
						</c:import>
					</c:otherwise>
				</c:choose>

			 </c:if>
			 <c:if test="${editStatus != true}">
			 		<%if(JgWebOffice.isJGEnabled()){%>
					  	<%if(("true".equals(KmImissiveConfigUtil.isShowImg())&&"true".equals(KmImissiveConfigUtil.isShowImg4Content()))||"false".equals(KmImissiveConfigUtil.isShowImg())){ %>
						<%--编辑正文 --%>
						<c:if  test="${not empty isReadOnly and  isReadOnly != 'true' &&  kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true' and editFlag != true}">
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
					<% if("tab".equals(KmImissiveConfigUtil.getDisplayMode()) && "false".equals(KmImissiveConfigUtil.isExpandContent4Receive())){%>
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
							<c:param name="fdMulti"  value="false" />
							<c:param name="fdModelId" value="${param.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
							<c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
							<c:param  name="contentFlag"  value="true"/>
							<c:param  name="protectstatus"  value="${protectstatus}"/>
							<c:param name="isShowImg" value="${isShowImg}"/>
							<c:param  name="showAllPage"  value="${showAllPage}"/>
							<c:param name="buttonDiv" value="missiveButtonDiv" />
							<c:param name="bookMarks" value="${bookmarkJson}" />
							<c:param name="editable" value="${editable}" />
							 <c:param name="editUrl" value="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=view&fdId=${param.fdId}&editFlag=true" />
						</c:import>
			 	<%}else{ %>
			 		<%if(com.landray.kmss.sys.attachment.util.JgWebOffice.isJGEnabled()&&JgWebOffice.isExistViewPath(request)){%>
					   <c:if test="${isShowImg and editStatus != true and (isJGMULEnabled or isIE)}">
						   <tr>
						     	<td colspan="4">
						     	  <font style="text-align:center"><bean:message  bundle="km-imissive" key="kmMissiveMain.prompt"/></font>
						        </td>
						   </tr>
					  </c:if>
					<%} %>
				 	<div id="missiveButtonDiv">
						<jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_btn_include.jsp"></jsp:include>
						<c:if test="${editable eq true}">
							<a href="javascript:void(0);" class="editContent com_btn_link" onclick="Com_OpenWindow('kmImissiveReceiveMain.do?method=view&fdId=${JsParam.fdId}&editFlag=true','_self');">
							   编辑正文
							 </a>
						</c:if>
					   <%if(("true".equals(KmImissiveConfigUtil.isShowImg())&&"true".equals(KmImissiveConfigUtil.isShowImg4Content()))||"false".equals(KmImissiveConfigUtil.isShowImg())){ %>
							<c:if  test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true' and editFlag == true}">
							   <a href="javascript:void(0);" class="back com_btn_link"
									onclick="Com_OpenWindow('kmImissiveReceiveMain.do?method=view&fdId=${JsParam.fdId}','_self');">
								   返回
							   </a>
							</c:if>
						<%} %>
				 	 </div>
			 		<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_include_viewHtml.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="editonline" />
						<c:param name="fdAttType" value="office" />
						<c:param name="fdMulti"  value="false" />
						<c:param name="fdModelId" value="${param.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
						<c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
						<c:param  name="contentFlag"  value="true"/>
						<c:param  name="protectstatus"  value="${protectstatus}"/>
						<c:param name="isShowImg" value="${isShowImg}"/>
						<c:param  name="showAllPage"  value="${showAllPage}"/>
						<c:param name="buttonDiv" value="missiveButtonDiv" />
						 <c:param name="editable" value="${editable}" />
						<c:param name="bookMarks" value="${bookmarkJson}" />
					</c:import>
				<%} %>
				</div>
			</c:if>
		</td>
	</tr>
</table>
</c:if>
<%if("flat".equals(KmImissiveConfigUtil.getDisplayMode())){ %>
<c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms['attachment'].attachments}">
   <div class="lui_form_content_frame" style="padding-top:10px">
		<div class="lui_form_spacing"></div>
		<div>
			<div class="lui_form_subhead"><img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png"> ${ lfn:message('sys-doc:sysDocBaseInfo.docAttachments') }(${fn:length(kmImissiveReceiveMainForm.attachmentForms['attachment'].attachments)})</div>
			<c:choose>
				<c:when test="${editAtt eq true}">
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
						<c:param name="fdKey" value="attachment" />
						<c:param name="fdModelId" value="${param.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
					</c:import>
				</c:when>
				<c:otherwise>
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
								charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
						<c:param name="fdKey" value="attachment" />
					</c:import>
				</c:otherwise>
			</c:choose>
		</div>
    </div>
</c:if>
<%}%>