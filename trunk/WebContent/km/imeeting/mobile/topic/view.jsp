<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="mobile.view" compatibleMode="true" tiny="true">
    <template:replace name="csshead">
        <mui:cache-file name="mui-imeeting-view.css" cacheType="md5"/>
    </template:replace>

    <template:replace name="head">
        <mui:min-file name="mui-imeeting.js"/>
        <link rel="Stylesheet" type="text/css"
              href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/view.css?s_cache=${MUI_Cache}"/>
    </template:replace>
    <template:replace name="title">
        <c:out value="${ kmImeetingTopicForm.docSubject}"></c:out>
    </template:replace>
    <template:replace name="content">
        <div id="scrollView" data-dojo-type="mui/view/DocScrollableView">
            <div data-dojo-type="mui/fixed/Fixed" id="fixed">
                <div data-dojo-type="mui/fixed/FixedItem">
                        <%--切换页签--%>
                    <div class="muiHeader">
                        <div
                                data-dojo-type="mui/nav/MobileCfgNavBar"
                                data-dojo-props="defaultUrl:'/km/imeeting/mobile/topic/view_nav.jsp' ">
                        </div>
                    </div>
                </div>
            </div>

            <div id="baseView" data-dojo-type="dojox/mobile/View">
                <div class="meetingDocContent">
                    <c:choose>
                        <c:when test="${notXFormFilePath eq 'true'}">
                            <c:import url="/km/imeeting/mobile/topic/import/topic_xform_default_view_mobile.jsp"
                                      charEncoding="UTF-8">
                            </c:import>
                        </c:when>
                        <c:otherwise>
                            <table class="muiSimple" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td colspan="2">
                                        <c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp"
                                                  charEncoding="UTF-8">
                                            <c:param name="formName" value="kmImeetingTopicForm"/>
                                            <c:param name="fdKey" value="mainTopic"/>
                                        </c:import>
                                    </td>
                                </tr>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
                <%--流程记录--%>
            <div data-dojo-type="dojox/mobile/View" id="folwView">
                <div class="meetingDocContent">
                    <c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
                        <c:param name="fdModelId" value="${kmImeetingTopicForm.fdId }"/>
                        <c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic"/>
                        <c:param name="formBeanName" value="kmImeetingTopicForm"/>
                    </c:import>
                </div>
            </div>

            <template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp"
                              editUrl="/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=edit&fdId=${kmImeetingTopicForm.fdId}"
                              formName="kmImeetingTopicForm"
                              viewName="lbpmView"
                              allowReview="true">

                <template:replace name="flowArea">
                    <c:if test="${(kmImeetingTopicForm.sysWfBusinessForm.fdIsHander ne 'true'
                                    and kmImeetingTopicForm.docStatusFirstDigit ne '0')
                                or kmImeetingTopicForm.docStatusFirstDigit >= '2'}">
                        <kmss:auth requestURL="/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=edit&fdId=${kmImeetingTopicForm.fdId}"
                                   requestMethod="GET">
                            <li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit"
                                data-dojo-props="colSize:2"
                                onclick="window.open('${LUI_ContextPath}/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=edit&fdId=${kmImeetingTopicForm.fdId}','_self');">
                                    ${lfn:message('button.edit')}
                            </li>
                        </kmss:auth>
                    </c:if>
                </template:replace>

                <template:replace name="publishArea">
                    <kmss:auth requestURL="/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=edit&fdId=${kmImeetingTopicForm.fdId}"
                               requestMethod="GET">
                        <li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit"
                            data-dojo-props="colSize:2"
                            onclick="window.open('${LUI_ContextPath}/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=edit&fdId=${kmImeetingTopicForm.fdId}','_self');">
                                ${lfn:message('button.edit')}
                        </li>
                    </kmss:auth>
                </template:replace>
            </template:include>
        </div>

        <c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
            <c:param name="formName" value="kmImeetingTopicForm"/>
            <c:param name="fdKey" value="mainTopic"/>
            <c:param name="viewName" value="lbpmView"/>
            <c:param name="backTo" value="scrollView"/>
        </c:import>

    </template:replace>
</template:include>