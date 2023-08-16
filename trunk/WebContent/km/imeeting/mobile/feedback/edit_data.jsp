<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.landray.kmss.util.DateUtil" %>
<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingMainForm" %>
<%@page import="java.util.Date" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<ui:ajaxtext>
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
    <%-- 此处为浏览器窗口标题 --%>
    <div data-dojo-block="title">
        <c:out value="会议回执"/>
    </div>
    <%--此处为内容 --%>
    <div data-dojo-block="content">
        <!-- xform标签渲染dojo组件时会调用changeAttend(),但是require引js的速度可能会慢dojo组件的渲染，再次先定义，避免报错 -->
        <script type="text/javascript">window.changeAttend = function (el) {};</script>

        <html:form action="/km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback.do">
            <div>
                <%-- 滚动区域视图 --%>
                <div data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin"
                     data-dojo-props="validateNext:false" id="scrollView">
                    <div data-dojo-type="mui/panel/NavPanel">
                        <div data-dojo-type="mui/panel/Content" data-dojo-mixins="mui/form/_AlignMixin"
                             data-dojo-props="title:'回执填写'" style="padding-top:1px">
                            <div class="kmImeetingFeedbackContent muiFormContent">
                                <html:hidden property="fdId"/>
                                <html:hidden property="fdMeetingId"
                                             value="${HtmlParam['meetingId'] ? HtmlParam['meetingId'] : kmImeetingMainFeedbackForm.fdMeetingId}"/>
                                <html:hidden property="fdType" value="${kmImeetingMainFeedbackForm.fdType}"/>
                                <c:choose>
                                    <c:when test="${not empty kmImeetingMainFeedbackForm.fdUnitId }">
                                        <html:hidden property="fdAgendaIds"
                                                     value="${kmImeetingMainFeedbackForm.fdAgendaIds}"/>
                                        <html:hidden property="fdUnitId" value="${kmImeetingMainFeedbackForm.fdUnitId}"/>
                                        <html:hidden property="fdUnitName"
                                                     value="${kmImeetingMainFeedbackForm.fdUnitName}"/>
                                        <%@include file="/km/imeeting/mobile/feedback/edit_topic.jsp" %>
                                    </c:when>
                                    <c:otherwise>
                                        <%@include file="/km/imeeting/mobile/feedback/edit_attend.jsp" %>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <c:if test="${isFeedBackDeadline == false  && fdIsShowOperateBtn eq 'true'}">
                        <ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom">
                            <li data-dojo-type="mui/tabbar/TabBarButton"
                                data-dojo-props="colSize:2,onClick:function(){submitFormValidate('update');}">
                                <bean:message key="button.submit"/>
                            </li>
                        </ul>
                    </c:if>
                </div>
                <div class="feedback-submit-confirm-box" style="display: none">
                    <div class="feedback-submit-confirm" id="feedback_submit_confirm">
                    <span class="feedback-submit-confirm-text">
                        您本次提交回执没有填写参会人员信息，建议您添加报名填写信息后再提交，请确认是否立即进行提交操作？
                    </span>
                    </div>
                </div>
                <script type="text/javascript">
                    require(["mui/form/ajax-form!kmImeetingFeedbackForm"]);
                    require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 'mui/dialog/Dialog',
                            'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip'],
                        function (ready, registry, topic, request, Dialog, dom, domAttr, domStyle, domClass, query, Tip) {
                            var submitConfirmObj = dom.byId("feedback_submit_confirm");
                            window.submitFormValidate = function (method) {
                                // 是否是议题报名方式
                                var isTopicType = "${not empty kmImeetingMainFeedbackForm.fdUnitId}";
                                if (isTopicType === 'true') {
                                    // 明细表添加的个数
                                    let editSize = query('tr.feedback-sign-status-edit').length;
                                    if (editSize <= 0) {
                                        var submitConfirm = new Dialog.claz({
                                            element: submitConfirmObj,
                                            scrollable: false,
                                            parseable: false,
                                            position: "center",
                                            canClose: false,
                                            buttons: [{
                                                title: "取消",
                                                fn: function(dialog) {
                                                    dialog.hide();
                                                }
                                            }, {
                                                title : "确定",
                                                fn: function(dialog) {
                                                    submitExec();
                                                    dialog.hide();
                                                }
                                            }]
                                        });
                                        submitConfirm.show();
                                    } else {
                                        submitExec();
                                    }
                                } else {
                                    submitExec();
                                }
                            };

                            function submitExec () {
                                var validorObj = registry.byId('scrollView');
                                if (validorObj.validate()) {
                                    Com_Submit(document.forms[0], 'update');
                                }
                            }

                            ready(function () {
                                var isFeedBackDeadline = "${isFeedBackDeadline}";
                                if ("true" == isFeedBackDeadline) {
                                    var msg = '<bean:message bundle="km-imeeting" key="kmImeetingMain.hasBegin.tip"/>';
                                    Tip.tip({text: msg, icon: 'mui mui-warn'});
                                }
                            })
                        });
                </script>
            </div>
        </html:form>
    </div>
</ui:ajaxtext>
