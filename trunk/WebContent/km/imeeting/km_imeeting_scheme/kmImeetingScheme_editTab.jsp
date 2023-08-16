<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:replace name="content">
    <script>
        Com_IncludeFile("dialog.js|jquery.js");
        Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath + "sys/unit/resource/js/", "js", true);
    </script>
    <script type="text/javascript">
        function commitMethod(commitType, saveDraft) {
            if (!validation.validate()) {
                // 移除检验组件在新UI的顶部提示
                if ($("#lui_validate_message").length > 0) {
                    $("#lui_validate_message").remove();
                }
                if (LUI("tabpanelBox")) {
                    var contents = LUI("tabpanelBox").contents;
                    for (var i = 0; i < contents.length; i++) {
                        if (contents[i].id == "kmImeetingSchemeContent") {
                            LUI("tabpanelBox").setSelectedIndex(i);
                        }
                    }
                }
            }
            var formObj = document.kmImeetingSchemeForm;
            var docStatus = document.getElementsByName("docStatus")[0];
            if (saveDraft == "true") {
                docStatus.value = "10";
            } else {
                docStatus.value = "20";
            }
            if ('save' == commitType) {
                Com_Submit(formObj, commitType, 'fdId');
            } else {
                Com_Submit(formObj, commitType);
            }
        }
    </script>

    <c:if test="${param.approveModel ne 'right'}">
        <form name="kmImeetingSchemeForm" method="post" action ="${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_scheme/kmImeetingScheme.do">
        <html:hidden property="docStatus"/>
    </c:if>

    <c:choose>
        <c:when test="${param.approveModel eq 'right'}">
            <ui:tabpanel id="tabpanelBox" layout="sys.ui.tabpanel.view" var-count="4" var-average='false'>
                <!-- 方案详情 -->
                <c:import url="/km/imeeting/km_imeeting_scheme/kmImeetingScheme_editContent.jsp" charEncoding="UTF-8">
                    <c:param name="approveModel" value="right" />
                </c:import>
                <ui:content id="rightEdit" titleicon="lui-tab-icon tab-icon-02" title="权限">
                    <%--权限机制 --%>
                    <c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
                        <c:param name="formName" value="kmImeetingSchemeForm"/>
                        <c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme"/>
                    </c:import>
                </ui:content>
                <ui:content id="rightEdit2" titleicon="lui-tab-icon tab-icon-02" title="流程">
                    <%--流程--%>
                    <c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
                        <c:param name="formName" value="kmImeetingSchemeForm"/>
                        <c:param name="fdKey" value="ImeetingScheme"/>
                        <c:param name="showHistoryOpers" value="true"/>
                        <c:param name="isExpand" value="true"/>
                        <c:param name="approveType" value="right"/>
                    </c:import>
                </ui:content>
            </ui:tabpanel>
            <%@ include file="/km/imeeting/km_imeeting_scheme/kmImeetingAttPreview.jsp" %>
        </c:when>
        <c:otherwise>
            <ui:tabpage id="tabpanelDiv" expand="false">
                <!-- 方案详情 -->
                <c:import url="/km/imeeting/km_imeeting_scheme/kmImeetingScheme_editContent.jsp" charEncoding="UTF-8">
                    <c:param name="approveModel" value="noRight" />
                </c:import>

                <%--流程机制 --%>
                <c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="kmImeetingSchemeForm"/>
                    <c:param name="fdKey" value="ImeetingScheme"/>
                </c:import>
                <%--权限机制 --%>
                <c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="kmImeetingSchemeForm"/>
                    <c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme"/>
                </c:import>
            </ui:tabpage>
            <%@ include file="/km/imeeting/km_imeeting_scheme/kmImeetingAttPreview.jsp" %>
        </c:otherwise>
    </c:choose>
    <script language="JavaScript">
        var validation = $KMSSValidation(document.forms['kmImeetingSchemeForm']);
    </script>
    <c:if test="${param.approveModel ne 'right'}">
        </form>
    </c:if>
</template:replace>

<c:if test="${param.approveModel eq 'right'}">
    <template:replace name="barRight">
        <ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
            <%--流程--%>
            <c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
                <c:param name="formName" value="kmImeetingSchemeForm"/>
                <c:param name="fdKey" value="ImeetingScheme"/>
                <c:param name="showHistoryOpers" value="true"/>
                <c:param name="isExpand" value="true"/>
                <c:param name="approveType" value="right"/>
                <c:param name="approvePosition" value="right"/>
            </c:import>
        </ui:tabpanel>
    </template:replace>
</c:if>