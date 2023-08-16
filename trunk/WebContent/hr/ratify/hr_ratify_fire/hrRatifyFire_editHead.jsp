<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="head">
    <style type="text/css">
        
        		.lui_paragraph_title{
        			font-size: 15px;
        			color: #15a4fa;
        	    	padding: 15px 0px 5px 0px;
        		}
        		.lui_paragraph_title span{
        			display: inline-block;
        			margin: -2px 5px 0px 0px;
        		}
        		.inputsgl[readonly], .tb_normal .inputsgl[readonly] {
        		    border: 0px;
        		    color: #868686
        		}
        		
    </style>
    <script type="text/javascript">
        var formInitData = {

        };
        var messageInfo = {

        };

        var initData = {
            contextPath: '${LUI_ContextPath}',
        };
        Com_IncludeFile("security.js");
        Com_IncludeFile("domain.js");
        Com_IncludeFile("form.js");
        Com_IncludeFile("form_option.js", "${LUI_ContextPath}/hr/ratify/hr_ratify_fire/", 'js', true);
        Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/hr/ratify/resource/js/", 'js', true);
        Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
    </script>
</template:replace>
<c:if test="${hrRatifyFireForm.method_GET == 'edit' || (param['i.docTemplate']!=null && param['i.docTemplate']!='')}">
<template:replace name="title">
    <c:choose>
        <c:when test="${hrRatifyFireForm.method_GET == 'add' }">
            <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('hr-ratify:table.hrRatifyFire') }" />
        </c:when>
        <c:otherwise>
            <c:out value="${hrRatifyFireForm.docSubject} - " />
            <c:out value="${ lfn:message('hr-ratify:table.hrRatifyFire') }" />
        </c:otherwise>
    </c:choose>
</template:replace>
	<template:replace name="toolbar">
	<c:if test="${hrRatifyFireForm.docDeleteFlag ==1}">
		<div id="toolbar" style="display:none"></div>
	</c:if>
	<c:if test="${hrRatifyFireForm.docDeleteFlag !=1}">
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
	            <c:choose>
	                <c:when test="${ hrRatifyFireForm.method_GET == 'edit' }">
	                    <c:if test="${ hrRatifyFireForm.docStatus=='10' || hrRatifyFireForm.docStatus=='11' }">
	                        <ui:button text="${ lfn:message('button.savedraft') }" onclick="if(validateDetail()){submitForm('${hrRatifyFireForm.docStatus}','update',true);}" styleClass="lui_widget_btn_primary" isForcedAddClass="true"/>
	                    </c:if>
	                    <c:if test="${ hrRatifyFireForm.docStatus=='10' || hrRatifyFireForm.docStatus=='11' || hrRatifyFireForm.docStatus=='20' }">
	                        <ui:button text="${ lfn:message('button.submit') }" onclick="if(validateDetail()){submitForm('20','update');}" styleClass="lui_widget_btn_primary" isForcedAddClass="true"/>
	                    </c:if>
	                </c:when>
	                <c:when test="${ hrRatifyFireForm.method_GET == 'add' }">
	                    <ui:button text="${ lfn:message('button.savedraft') }" order="2" onclick="if(validateDetail()){submitForm('10','save',true);}" styleClass="lui_widget_btn_primary" isForcedAddClass="true"/>
	                    <ui:button text="${ lfn:message('button.submit') }" order="2" onclick="if(validateDetail()){submitForm('20','save');}" styleClass="lui_widget_btn_primary" isForcedAddClass="true"/>
	                </c:when>
	            </c:choose>
	
	            <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
	        </ui:toolbar>
		</c:when>
		<c:otherwise>
			<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
	            <c:choose>
	                <c:when test="${ hrRatifyFireForm.method_GET == 'edit' }">
	                    <c:if test="${ hrRatifyFireForm.docStatus=='10' || hrRatifyFireForm.docStatus=='11' }">
	                        <ui:button text="${ lfn:message('button.savedraft') }" onclick="if(validateDetail()){submitForm('${hrRatifyFireForm.docStatus}','update',true);}" />
	                    </c:if>
	                    <c:if test="${ hrRatifyFireForm.docStatus=='10' || hrRatifyFireForm.docStatus=='11' || hrRatifyFireForm.docStatus=='20' }">
	                        <ui:button text="${ lfn:message('button.submit') }" onclick="if(validateDetail()){submitForm('20','update');}" />
	                    </c:if>
	                </c:when>
	                <c:when test="${ hrRatifyFireForm.method_GET == 'add' }">
	                    <ui:button text="${ lfn:message('button.savedraft') }" order="2" onclick="if(validateDetail()){submitForm('10','save',true);}" />
	                    <ui:button text="${ lfn:message('button.submit') }" order="2" onclick="if(validateDetail()){submitForm('20','save');}" />
	                </c:when>
	            </c:choose>
	
	            <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
	        </ui:toolbar>
		</c:otherwise>
	</c:choose>
</c:if>
</template:replace>
<template:replace name="path">
    <ui:combin ref="menu.path.category">
		<ui:varParams 
    		moduleTitle="${ lfn:message('hr-ratify:table.hrRatifyFire') }" 
   			modulePath="/hr/ratify/" 
			modelName="com.landray.kmss.hr.ratify.model.HrRatifyTemplate" 
			autoFetch="false"	
			target="_blank" 
			categoryId="${hrRatifyFireForm.docTemplateId}" />
	</ui:combin>
</template:replace>
</c:if>