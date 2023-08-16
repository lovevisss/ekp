<%--
  Created by IntelliJ IDEA.
  User: Butterball
  Date: 2021-7-14
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/resource/jsp/common.jsp"%>
<div class="lui_form_content_frame clearfloat" id="lui_form_content_frame">
    <div style="min-height: 150px;" id="contentDiv">
        <div id="meetingButtonDiv" style="text-align:right;padding-bottom:5px">
            &nbsp;
        </div>
        <c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_include_viewHtml.jsp" charEncoding="UTF-8">
            <c:param name="fdKey" value="editonline"/>
            <c:param name="fdAttType" value="office"/>
            <c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId}"/>
            <c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary"/>
            <c:param name="formBeanName" value="kmImeetingSummaryForm"/>
            <c:param name="buttonDiv" value="meetingButtonDiv"/>
            <c:param name="isExpand" value="true"/>
            <c:param name="showAllPage" value="false"/>
            <c:param name="showToolBar" value="false"/>
        </c:import>
    </div>
</div>
