<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/km/imissive/mobile/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person" %>
<%@ include file="/component/locker/import/componentLockerVersion_show.jsp" %>

<template:include ref="mobile.view" compatibleMode="true">
    <template:replace name="head">
        <link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/mobile/resource/css/dis.css?s_cache=${MUI_Cache}"/>
        <link rel="Stylesheet"
              href="${LUI_ContextPath}/km/imissive/mobile/resource/css/imissive.css?s_cache=${MUI_Cache}"/>
        <link rel="stylesheet" type="text/css"
              href="<%=request.getContextPath()%>/sys/mobile/css/themes/default/listview.css?s_cache=${MUI_Cache}"></link>

        <c:set var="readViewLog" value="false"/>
        <kmss:auth
                requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=readViewLog&fdId=${param.fdId}"
                requestMethod="GET">
            <c:set var="readViewLog" value="true"/>
        </kmss:auth>

        <c:if test="${kmImissiveSendMainForm.docStatus == '30'}">
            <script type="text/javascript">
                require(["dojo/store/Memory", "dojo/topic"], function (Memory, topic) {
                    var dataStore;
                    <%if("content".equals(KmImissiveConfigUtil.getDiplayOrder())){ %>
                    dataStore = [
                        <c:if test="${isShowContentTabpanel eq 'true'}">
                        {
                            'text': '<bean:message bundle="km-imissive" key="kmImissiveSendMain.docContent" />',
                            'moveTo': '_contentView',
                            'id': 'contentNav',
                            'selected': true
                        },
                        </c:if>
                        {
                            'text': '<bean:message bundle="km-imissive" key="kmImissiveSendMain.baseinfo" />',
                            'moveTo': 'baseinfoView'<c:if test="${isShowContentTabpanel ne 'true'}">,
                            'selected': true</c:if>
                        },
                        {'text': '发文跟踪', 'moveTo': 'trackView'},
                        <c:if test="${readViewLog eq 'true'}">
                        {
                            'text': '<bean:message  bundle="km-imissive" key="mui.process.records"/>',
                            'moveTo': '_noteView'
                        },
                        </c:if>
                        {'text': '传阅意见', 'moveTo': '_opinionView'}
                    ];

                    <%}else{%>
                    dataStore = [{
                        'text': '<bean:message bundle="km-imissive" key="kmImissiveSendMain.baseinfo" />',
                        'moveTo': 'baseinfoView',
                        'selected': true
                    },
                        <c:if test="${isShowContentTabpanel eq 'true'}">
                        {
                            'text': '<bean:message bundle="km-imissive" key="kmImissiveSendMain.docContent" />',
                            'moveTo': '_contentView',
                            'id': 'contentNav'
                        },
                        </c:if>
                        {'text': '发文跟踪', 'moveTo': 'trackView'},
                        <c:if test="${readViewLog eq 'true'}">
                        {
                            'text': '<bean:message  bundle="km-imissive" key="mui.process.records"/>',
                            'moveTo': '_noteView'
                        },
                        </c:if>
                        {'text': '传阅意见', 'moveTo': '_opinionView'}
                    ];
                    <%}%>
                    window._narStore = new Memory({
                        data: dataStore
                    });
                    topic.subscribe("/mui/navitem/_selected", function (evtObj) {
                        setTimeout(function () {
                            topic.publish("/mui/list/resize");
                        }, 150);
                    });
                });
            </script>
        </c:if>
        <c:if test="${kmImissiveSendMainForm.docStatus != '30'}">
            <script type="text/javascript">
                require(["dojo/store/Memory", "dojo/topic"], function (Memory, topic) {
                    var dataStore;
                    <%if("content".equals(KmImissiveConfigUtil.getDiplayOrder4Approval())){ %>
                    dataStore = [
                        <c:if test="${isShowContentTabpanel}">
                        {
                            'text': '<bean:message bundle="km-imissive" key="kmImissiveSendMain.docContent" />',
                            'moveTo': '_contentView',
                            'id': 'contentNav',
                            'selected': true
                        },
                        </c:if>
                        {
                            'text': '<bean:message bundle="km-imissive" key="kmImissiveSendMain.baseinfo" />',
                            'moveTo': 'baseinfoView'<c:if test="${isShowContentTabpanel ne 'true'}">,
                            'selected': true</c:if>
                        },
                        {'text': '发文跟踪', 'moveTo': 'trackView'},
                        <c:if test="${readViewLog eq 'true'}">
                        {
                            'text': '<bean:message  bundle="km-imissive" key="mui.process.records"/>',
                            'moveTo': '_noteView'
                        },
                        </c:if>
                        {'text': '传阅意见', 'moveTo': '_opinionView'}
                    ];
                    <%}else{%>
                    dataStore = [{
                        'text': '<bean:message bundle="km-imissive" key="kmImissiveSendMain.baseinfo" />',
                        'moveTo': 'baseinfoView',
                        'selected': true
                    },
                        <c:if test="${isShowContentTabpanel}">
                        {
                            'text': '<bean:message bundle="km-imissive" key="kmImissiveSendMain.docContent" />',
                            'moveTo': '_contentView',
                            'id': 'contentNav'
                        },
                        </c:if>
                        {'text': '发文跟踪', 'moveTo': 'trackView'},
                        <c:if test="${readViewLog eq 'true'}">
                        {
                            'text': '<bean:message  bundle="km-imissive" key="mui.process.records"/>',
                            'moveTo': '_noteView'
                        },
                        </c:if>
                        {'text': '传阅意见', 'moveTo': '_opinionView'}
                    ];
                    <%}%>
                    window._narStore = new Memory({
                        data: dataStore
                    });
                    topic.subscribe("/mui/navitem/_selected", function (evtObj) {
                        setTimeout(function () {
                            topic.publish("/mui/list/resize");
                        }, 150);
                    });
                });
            </script>
        </c:if>
    </template:replace>
    <template:replace name="title">
        <c:out value="${kmImissiveSendMainForm.docSubject}"></c:out>
    </template:replace>
    <template:replace name="content">
        <xform:config orient="vertical">
            <html:form action="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do">
                <div id="scrollView" data-dojo-type="mui/view/DocScrollableView"
                     data-dojo-mixins="mui/form/_ValidateMixin">
                    <div class="muiFlowInfoW">
                        <div data-dojo-type="mui/fixed/Fixed" id="fixed">
                            <div data-dojo-type="mui/fixed/FixedItem" class="muiFlowFixedItem">
                                <div data-dojo-type="mui/nav/NavBarStore" data-dojo-props="store:_narStore">
                                </div>
                            </div>
                        </div>
                        <%if ("content".equals(KmImissiveConfigUtil.getDiplayOrder()) || "content".equals(KmImissiveConfigUtil.getDiplayOrder4Approval())) { %>
                        <%@ include file="/km/imissive/mobile/send/tabview_content.jsp" %>
                        <%@ include file="/km/imissive/mobile/send/tabview_baseinfo.jsp" %>
                        <%} else { %>
                        <%@ include file="/km/imissive/mobile/send/tabview_baseinfo.jsp" %>
                        <%@ include file="/km/imissive/mobile/send/tabview_content.jsp" %>
                        <%} %>

                        <div data-dojo-type="dojox/mobile/View" id="_noteView">
                            <div class="muiFormContent">
                                <c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp"
                                          charEncoding="UTF-8">
                                    <c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId }"/>
                                    <c:param name="fdModelName"
                                             value="com.landray.kmss.km.imissive.model.KmImissiveSendMain"/>
                                    <c:param name="formBeanName" value="kmImissiveSendMainForm"/>
                                </c:import>
                            </div>
                        </div>
                        <div data-dojo-type="dojox/mobile/View" id="_opinionView">
                            <div class="muiFormContent">
                                <ul
                                        data-dojo-type="mui/list/JsonStoreList"
                                        data-dojo-mixins="mui/list/ProcessItemListMixin"
                                        data-dojo-props="url:'/sys/circulation/sys_circulation_opinion/sysCirculationOpinion.do?method=list&fdModelId=${param.fdId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain&isOpinion=true',lazy:false">
                                </ul>
                            </div>
                        </div>
                    </div>
                    <template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp"
                                      docStatus="${kmImissiveSendMainForm.docStatus}"
                                      formName="kmImissiveSendMainForm"
                                      viewName="lbpmView"
                                      allowReview="true">
                        <template:replace name="flowArea">
                            <c:choose>
                                <c:when test="${kmImissiveSendMainForm.docStatus < '20' && kmImissiveSendMainForm.docStatus >= '10'}">
                                    <c:if test="${ kmImissiveSendMainForm.sysWfBusinessForm.fdIsHander == 'true'}">
                                        <%--起草人草稿编辑操作 --%>
                                        <kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=edit&fdId=${param.fdId }">
                                            <div data-dojo-type="mui/tabbar/TabBarButton"
                                                 data-dojo-props="colSize:1,href:'/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=edit&fdId=${param.fdId }'">
                                                <bean:message key="button.edit"/>
                                            </div>
                                        </kmss:auth>
                                    </c:if>
                                </c:when>
                            </c:choose>
                            <%-- 清稿附加选项 --%>
                            <c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.cleardraft =='true'}">
                                <c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
                                    <c:choose>
                                        <c:when test="${wpsoaassist eq 'true'}">
                                        </c:when>
                                        <c:when test="${_isWpsCloudEnable}">
                                        </c:when>
                                        <c:when test="${_isWpsCenterEnable}">
                                            <div data-dojo-type="mui/tabbar/TabBarButton" class="cleardraftStyle"
                                                 onclick="cleardraftByWpsCenter('mainonline');">
                                                <bean:message bundle="km-imissive" key="kmImissiveSendMain.cleardraft"/>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                                <c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
                                    <c:choose>
                                        <c:when test="${wpsoaassist eq 'true'}">
                                        </c:when>
                                        <c:when test="${_isWpsCloudEnable}">
                                        </c:when>
                                        <c:when test="${_isWpsCenterEnable}">
                                            <div data-dojo-type="mui/tabbar/TabBarButton" class="cleardraftStyle"
                                                 onclick="cleardraftByWpsCenter('editonline');">
                                                <bean:message bundle="km-imissive" key="kmImissiveSendMain.cleardraft"/>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>

                                </c:if>
                            </c:if>
                            <%-- 套红附加选项 --%>
                            <c:if
                                    test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'}">
                                <c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
                                    <c:choose>
                                        <c:when test="${wpsoaassist eq 'true'}">
                                        </c:when>
                                        <c:when test="${_isWpsCloudEnable}">
                                        </c:when>
                                        <c:when test="${_isWpsCenterEnable}">
                                            <div data-dojo-type="mui/tabbar/TabBarButton" class="redHead"
                                                 onclick="LoadWpsCenterHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSendMain','mainonline');">
                                                <bean:message bundle="km-imissive" key="kmImissive.redhead"/>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                                <c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
                                    <c:choose>
                                        <c:when test="${wpsoaassist eq 'true'}">
                                        </c:when>
                                        <c:when test="${_isWpsCloudEnable}">
                                        </c:when>
                                        <c:when test="${_isWpsCenterEnable}">
                                            <div data-dojo-type="mui/tabbar/TabBarButton" class="redHead"
                                                 onclick="LoadWpsCenterHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSendMain','editonline');">
                                                <bean:message bundle="km-imissive" key="kmImissive.redhead"/>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:if>
                            <c:if test="${kmImissiveSendMainForm.fdMissiveType !=  '2'}">
                                <c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.distribute =='true'}">
                                    <div data-dojo-type="mui/tabbar/TabBarButton" onclick="distribute();">
                                        <bean:message bundle="km-imissive" key="kmImissiveSendMain.distribute"/>
                                    </div>
                                </c:if>
                            </c:if>
                            <c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
                                <c:if test="${not empty kmImissiveSendMainForm.attachmentForms['editonline'].attachments or not empty kmImissiveSendMainForm.attachmentForms['mainonline'].attachments}">
                                    <c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
                                        <%-- 集成了易企签、勾选了附件选项 --%>
                                        <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('mainonline');">
                                            <bean:message bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
                                        </div>
                                    </c:if>
                                    <c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
                                        <%-- 集成了易企签、勾选了附件选项 --%>
                                        <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('editonline');">
                                            <bean:message bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
                                        </div>
                                    </c:if>
                                </c:if>
                            </c:if>
                            <%--上报 --%>
                            <c:if test="${kmImissiveSendMainForm.fdMissiveType != '1'}">
                                <c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.report =='true'}">
                                    <div data-dojo-type="mui/tabbar/TabBarButton" onclick="report();">
                                        <bean:message bundle="km-imissive" key="kmImissiveSendMain.report"/>
                                    </div>
                                </c:if>
                            </c:if>
                            <c:if test="${existOpinion}">
                                <div data-dojo-type="mui/tabbar/TabBarButton" onclick="circulate();">
                                    传阅意见
                                </div>
                            </c:if>
                            <c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
                                <c:param name="fdModelName"
                                         value="com.landray.kmss.km.imissive.model.KmImissiveSendMain"></c:param>
                                <c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}"></c:param>
                                <c:param name="fdSubject" value="${kmImissiveSendMainForm.docSubject}"></c:param>
                                <c:param name="showOption" value="label"></c:param>
                            </c:import>
                            <c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
                                <c:param name="formName" value="kmImissiveSendMainForm"></c:param>
                                <c:param name="showOption" value="label"></c:param>
                            </c:import>
                            <c:import url="/km/imissive/mobile/circulation/view.jsp" charEncoding="UTF-8">
                                <c:param name="formName" value="kmImissiveSendMainForm"></c:param>
                                <c:param name="showOption" value="label"></c:param>
                                <c:param name="isNew" value="true"></c:param>
                            </c:import>
                        </template:replace>
                        <template:replace name="publishArea">
                            <c:if test="${kmImissiveSendMainForm.docStatus=='30' and kmImissiveSendMainForm.fdIsFiling!= true}">
                                <c:if test="${kmImissiveSendMainForm.fdMissiveType !=  '2'}">
                                    <kmss:auth
                                            requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=distribute&fdId=${param.fdId}"
                                            requestMethod="GET">
                                        <div data-dojo-type="mui/tabbar/TabBarButton" onclick="distribute();">
                                            <bean:message bundle="km-imissive" key="kmImissiveSendMain.distribute"/>
                                        </div>
                                    </kmss:auth>
                                </c:if>
                                <c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
                                    <c:if test="${not empty kmImissiveSendMainForm.attachmentForms['editonline'].attachments or not empty kmImissiveSendMainForm.attachmentForms['mainonline'].attachments}">
                                        <c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
                                            <%-- 集成了易企签、勾选了附件选项 --%>
                                            <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('mainonline');">
                                                <bean:message bundle="km-imissive"
                                                              key="kmImissive.sign.zhixingqianshu"/>
                                            </div>
                                        </c:if>
                                        <c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
                                            <%-- 集成了易企签、勾选了附件选项 --%>
                                            <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('editonline');">
                                                <bean:message bundle="km-imissive"
                                                              key="kmImissive.sign.zhixingqianshu"/>
                                            </div>
                                        </c:if>
                                    </c:if>
                                </c:if>
                                <c:if test="${kmImissiveSendMainForm.fdMissiveType !=  '1'}">
                                    <kmss:auth
                                            requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=report&fdId=${param.fdId}"
                                            requestMethod="GET">
                                        <div data-dojo-type="mui/tabbar/TabBarButton" onclick="report();">
                                            <bean:message bundle="km-imissive" key="kmImissiveSendMain.report"/>
                                        </div>
                                    </kmss:auth>
                                </c:if>
                            </c:if>
                            <c:if test="${existOpinion}">
                                <div data-dojo-type="mui/tabbar/TabBarButton" onclick="circulate();">
                                    传阅意见
                                </div>
                            </c:if>
                            <c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
                                <c:param name="fdModelName"
                                         value="com.landray.kmss.km.imissive.model.KmImissiveSendMain"></c:param>
                                <c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}"></c:param>
                                <c:param name="fdSubject" value="${kmImissiveSendMainForm.docSubject}"></c:param>
                                <c:param name="showOption" value="label"></c:param>
                            </c:import>
                            <c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
                                <c:param name="formName" value="kmImissiveSendMainForm"></c:param>
                                <c:param name="showOption" value="label"></c:param>
                            </c:import>
                            <c:import url="/km/imissive/mobile/circulation/view.jsp" charEncoding="UTF-8">
                                <c:param name="formName" value="kmImissiveSendMainForm"></c:param>
                                <c:param name="showOption" value="label"></c:param>
                                <c:param name="isNew" value="true"></c:param>
                            </c:import>
                        </template:replace>
                    </template:include>
                </div>
                <c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true' and (_isWpsCloudEnable eq 'true' or _isWpsCenterEnable eq 'true') }">
                    <%@ include file="/km/imissive/mobile/cookieUtil_script.jsp" %>
                    <%@ include file="/km/imissive/mobile/send/number_include.jsp" %>
                </c:if>
                <%@ include file="/km/imissive/mobile/send/view_import.jsp" %>
                <!-- 钉钉图标 -->
                <kmss:ifModuleExist path="/third/ding">
                    <c:import url="/third/ding/import/ding_view.jsp" charEncoding="UTF-8">
                        <c:param name="formName" value="kmImissiveSendMainForm"/>
                    </c:import>
                </kmss:ifModuleExist>
                <kmss:ifModuleExist path="/third/lding">
                    <c:import url="/third/lding/import/ding_view.jsp" charEncoding="UTF-8">
                        <c:param name="formName" value="kmImissiveSendMainForm"/>
                    </c:import>
                </kmss:ifModuleExist>
                <kmss:ifModuleExist path="/third/govding">
                    <c:import url="/third/govding/import/ding_view.jsp" charEncoding="UTF-8">
                        <c:param name="formName" value="kmImissiveSendMainForm"/>
                    </c:import>
                </kmss:ifModuleExist>
                <!-- 钉钉图标 end -->
                <c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="kmImissiveSendMainForm"/>
                    <c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain"/>
                </c:import>
                <!-- 版本锁机制 -->
                <c:import url="/component/locker/import/componentLockerVersion_import.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="kmImissiveSendMainForm"/>
                </c:import>
                <c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="kmImissiveSendMainForm"/>
                    <c:param name="fdKey" value="sendMainDoc"/>
                    <c:param name="viewName" value="lbpmView"/>
                    <c:param name="backTo" value="scrollView"/>
                    <c:param name="onClickSubmitButton" value="Com_submitReview();"/>
                </c:import>
                <%--发布和废弃的文档稿纸和流程默认折叠 --%>
                <script>
                    require(["mui/form/ajax-form!kmImissiveSendMainForm"]);
                </script>
                <%@ include file="/km/imissive/mobile/send/kmImissiveRedhead_script.jsp" %>
            </html:form>
        </xform:config>
    </template:replace>
</template:include>

