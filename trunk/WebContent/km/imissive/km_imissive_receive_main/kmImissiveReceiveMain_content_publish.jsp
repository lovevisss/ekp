<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<c:if test="${kmImissiveReceiveMainForm.fdNeedContent=='0'}">
	<div class="lui_form_content_frame" style="padding-top:10px">
		 <jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_content_include.jsp"></jsp:include>
	</div>
 </c:if>
 <c:if test="${kmImissiveReceiveMainForm.fdNeedContent=='1'}">
 <div class="lui_form_content_frame" style="padding-top:10px">
  <table class="tb_normal" width="100%">
	  <!-- 提示信息 -->
		<c:forEach items="${kmImissiveReceiveMainForm.attachmentForms['editonline'].attachments}" var="sysAttMain"	varStatus="vstatus">
			<c:set var="fdAttMainId" value="${sysAttMain.fdId}" scope="request"/>
		</c:forEach>
		<%if(com.landray.kmss.sys.attachment.util.JgWebOffice.isJGEnabled()&&JgWebOffice.isExistViewPath(request)){%>
			<c:if test="${isShowImg and editStatus != true}">
			   <tr>
			     	<td colspan="4">
			     	  <font style="text-align:center"><bean:message  bundle="km-imissive" key="kmMissiveMain.prompt"/></font>
			        </td>
			   </tr>
			 </c:if>
		<%} %>
	   <tr>
			<td colspan="4">
			 <div id="missiveButtonDiv">
			      <jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_btn_include.jsp"></jsp:include>
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
					<c:param name="bookMarks" value="${bookmarkJson}" />
				</c:import>		
			</td>
		</tr>
	</table>
 </div>
</c:if>
<%if("flat".equals(KmImissiveConfigUtil.getDisplayMode())){ %>
<c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms['attachment'].attachments}">
   <div class="lui_form_content_frame" style="padding-top:10px">
		<div class="lui_form_spacing"></div> 
		<div>
			<div class="lui_form_subhead"><img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png"> ${ lfn:message('sys-doc:sysDocBaseInfo.docAttachments') }(${fn:length(kmImissiveReceiveMainForm.attachmentForms['attachment'].attachments)})</div>
			<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
						charEncoding="UTF-8">
				<c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
				<c:param name="fdKey" value="attachment" />
			</c:import>
		</div> 
    </div>
</c:if>
<%}%>