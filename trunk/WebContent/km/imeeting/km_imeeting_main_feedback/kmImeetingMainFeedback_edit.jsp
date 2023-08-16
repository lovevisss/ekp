<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingMainFeedbackForm" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.landray.kmss.km.imeeting.forms.KmImeetingMainForm" %>
<%@ page import="com.landray.kmss.util.DateUtil" %>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant" %>
<%
    Date now = new Date();
    Boolean isBegin = false, isEnd = false, isFeedBackDeadline = false;
    KmImeetingMainForm kmImeetingMainForm = (KmImeetingMainForm) request.getAttribute("kmImeetingMainForm");
    // 会议已开始
    if (DateUtil.convertStringToDate(kmImeetingMainForm.getFdHoldDate(),
            DateUtil.TYPE_DATETIME, request.getLocale()).getTime() < now.getTime()) {
        isBegin = true;
    }
    // 会议已结束
    if (DateUtil.convertStringToDate(kmImeetingMainForm.getFdFinishDate(),
            DateUtil.TYPE_DATETIME, request.getLocale()).getTime() < now.getTime()) {
        isEnd = true;
    }
    // 回执截止时间是否已过
    if (DateUtil.convertStringToDate(kmImeetingMainForm.getFdFeedBackDeadline(),
            DateUtil.TYPE_DATETIME, request.getLocale()).getTime() < now.getTime()) {
        isFeedBackDeadline = true;
    }
    request.setAttribute("isBegin", isBegin);
    request.setAttribute("isEnd", isEnd);
    request.setAttribute("isFeedBackDeadline", isFeedBackDeadline);

%>
<template:include ref="default.edit" sidebar="no">
    <template:replace name="head">
        <link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/resource/css/view.css?s_cache=${MUI_Cache}"/>
        <link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/resource/css/view_simple.css"/>
        <script type="text/javascript">
            Com_IncludeFile("doclist.js;data.js", null, "js");
        </script>
    </template:replace>
    <template:replace name="title">
        <c:out value="${kmImeetingMainForm.fdName} - ${ lfn:message('km-imeeting:table.kmImeetingMain') }"></c:out>
    </template:replace>

    <template:replace name="toolbar">
        <c:set var="editStatus" value="view"></c:set>
        <c:if test="${empty kmImeetingMainFeedbackForm.fdOperateType}">
            <c:set var="editStatus" value="edit"></c:set>
        </c:if>
        <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
            <%--保存--%>
            <c:if test="${isFeedBackDeadline == false  && fdIsShowOperateBtn eq 'true'}">
                <ui:button text="${lfn:message('button.submit') }" order="2"
                           onclick="commitMethod('update', 'false');"></ui:button>
            </c:if>
            <c:if test="${isFeedBackDeadline == false }">
                <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow()"></ui:button>
            </c:if>
            <c:if test="${isFeedBackDeadline == true }">
                <ui:button text="${ lfn:message('button.close') }" order="5"
                           onclick="top.opener = top;top.open('', '_self');top.close()"></ui:button>
            </c:if>

        </ui:toolbar>
    </template:replace>

    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav" id="categoryId">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home"></ui:menu-item>
            <ui:menu-item text="${ lfn:message('km-imeeting:module.km.imeeting') }"></ui:menu-item>
            <ui:menu-item text="${ lfn:message('km-imeeting:table.kmImeetingMain') }"></ui:menu-item>
            <ui:menu-source autoFetch="false">
                <ui:source type="AjaxJson">
                    {"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.imeeting.model.KmImeetingTemplate&categoryId=${kmImeetingMainForm.fdTemplateId}"}
                </ui:source>
            </ui:menu-source>
        </ui:menu>
    </template:replace>
    <template:replace name="content">
        <html:form action="/km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback.do">
            <p class="txttitle">
                <bean:message bundle="km-imeeting" key="kmImeetingMain.fdNotifyView"/>
            </p>
            <%-- 如果会议开始不能进行回执提示 --%>
            <c:if test="${isFeedBackDeadline == true }">
                <div style="color: red;text-align: center;">
                    <bean:message bundle="km-imeeting" key="kmImeetingMain.hasBegin.tip"/>
                </div>
            </c:if>
            <div class="lui_form_content_frame" style="padding-top:5px">
                <c:choose>
                    <c:when test="${kmImeetingMainForm.fdTemplateId == null || kmImeetingMainForm.fdTemplateId == ''}">
                        <jsp:include
                                page="/km/imeeting/km_imeeting_notify_letter/km_imeeting_notify_letter_simple.jsp"/>
                    </c:when>
                    <c:otherwise>
                        <%--会议通知单--%>
                        <c:if test="${type=='admin'  }">
                            <%--管理员，可以看到通知单所有信息--%>
                            <jsp:include
                                    page="/km/imeeting/km_imeeting_notify_letter/km_imeeting_notify_letter_admin.jsp"/>
                        </c:if>
                        <c:if test="${JsParam.type=='attend' }">
                            <%--会议主持人/参加人/列席人员看到的会议通知单--%>
                            <jsp:include
                                    page="/km/imeeting/km_imeeting_notify_letter/km_imeeting_notify_letter_attend.jsp"/>
                        </c:if>
                        <c:if test="${JsParam.type=='assist' }">
                            <%--会议协助人看到的会议通知单--%>
                            <jsp:include
                                    page="/km/imeeting/km_imeeting_notify_letter/km_imeeting_notify_letter_assist.jsp"/>
                        </c:if>
                    </c:otherwise>
                </c:choose>

                    <%--需要回复--%>
                <c:if test="${shouldFeedback==true }">
                    <br/>
                    <html:hidden property="fdId"/>
                    <html:hidden property="fdMeetingId"
                                 value="${HtmlParam['meetingId'] ?HtmlParam['meetingId']:kmImeetingMainFeedbackForm.fdMeetingId}"/>
                    <html:hidden property="fdType" value="${kmImeetingMainFeedbackForm.fdType}"/>
                    <c:choose>
                        <c:when test="${not empty kmImeetingMainFeedbackForm.fdUnitId }">
                            <html:hidden property="fdAgendaIds" value="${kmImeetingMainFeedbackForm.fdAgendaIds}"/>
                            <html:hidden property="fdUnitId" value="${kmImeetingMainFeedbackForm.fdUnitId}"/>
                            <html:hidden property="fdUnitName" value="${kmImeetingMainFeedbackForm.fdUnitName}"/>
                            <%@include file="/km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback_topic.jsp" %>
                        </c:when>
                        <c:otherwise>
                            <%@include
                                    file="/km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback_attend.jsp" %>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </div>
        </html:form>
    </template:replace>
</template:include>
<script>
    var validation = $KMSSValidation();//校验框架
</script>
<script>
    seajs.use([
        'km/imeeting/resource/js/dateUtil',
        'lui/jquery',
        'lui/dialog'
    ], function (dateUtil, $, dialog) {

        // 会议开始后禁用所有文本输入
        if ("${isFeedBackDeadline}" == "true") {
            $(':input').attr('readOnly', true);
            $("input[type=radio]").each(function () {
                this.disabled = "disabled";
            });
        }

        // 提交
        window.commitMethod=function(commitType, saveDraft) {
            let isTopicType = "${not empty kmImeetingMainFeedbackForm.fdUnitId}";
            if (isTopicType === "true") {
                // 明细表添加的个数
                let editSize = $('tr.feedback-sign-status-edit').length;
                if (editSize <= 0) {
                    dialog.confirm(
                        "您本次提交回执没有填写参会人员信息，建议您添加报名填写信息后再提交，请确认是否立即进行提交操作？",
                        function(val) {
                            if (val) {
                                submitExec(commitType);
                            }
                        }
                    );
                } else {
                    submitExec(commitType);
                }
            } else {
                submitExec(commitType);
            }
        };

        function submitExec(commitType) {
            var formObj = document.kmImeetingMainFeedbackForm;
            var fdOperateType=$('[name="fdOperateType"]:checked');
            if(fdOperateType && fdOperateType.val()=="05"){
                $('[name="attendOther"]').val('true');
                $('[name="fdOperateType"]').val('01');
            }
            if ('save' == commitType) {
                Com_Submit(formObj, commitType, 'fdId');
            } else {
                Com_Submit(formObj, commitType);
            }
        }

        //初始化会议历时
        if ('${kmImeetingMainForm.fdHoldDuration}') {
            //将小时分解成时分
            var timeObj = dateUtil.splitTime({"ms": "${kmImeetingMainForm.fdHoldDuration}"});
            $('#fdHoldDurationHour').html(timeObj.hour);
            $('#fdHoldDurationMin').html(timeObj.minute);
            if (timeObj.minute) {
                $('#fdHoldDurationMinSpan').show();
            } else {
                $('#fdHoldDurationMinSpan').hide();
            }
        }
    });
</script>