<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/km/imissive/mobile/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person" %>
<%@ include file="/component/locker/import/componentLockerVersion_show.jsp" %>

<template:include ref="mobile.view" compatibleMode="true">
    <template:replace name="head">
        <link rel="Stylesheet"
              href="${LUI_ContextPath}/km/imissive/mobile/resource/css/imissive.css?s_cache=${MUI_Cache}"/>
        <c:set var="readViewLog" value="false"/>
        <kmss:auth
                requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=readViewLog&fdId=${param.fdId}"
                requestMethod="GET">
            <c:set var="readViewLog" value="true"/>
        </kmss:auth>
        <c:set var="existAtt" value="false" scope="request"/>
        <c:if test="${not empty kmImissiveSignMainForm.attachmentForms['attachment'].attachments}">
            <c:set var="existAtt" value="true" scope="request"/>
        </c:if>
        <c:if test="${kmImissiveSignMainForm.docStatus == '30'}">
            <script type="text/javascript">
                require(["dojo/store/Memory", "dojo/topic"], function (Memory, topic) {
                    var dataStore;
                    <%if("content".equals(KmImissiveConfigUtil.getDiplayOrder())){ %>
                    dataStore = [
                        <c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
                        {
                            'text': '<bean:message bundle="km-imissive" key="kmImissiveSignMain.docContent" />',
                            'moveTo': '_contentView',
                            'id': 'contentNav',
                            'selected': true
                        },
                        </c:if>
                        {
                            'text': '<bean:message bundle="km-imissive" key="kmImissiveSignMain.baseinfo" />',
                            'moveTo': 'baseinfoView'<c:if test="${kmImissiveSignMainForm.fdNeedContent!='1'}">,
                            'selected': true</c:if>
                        },
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
                        'text': '<bean:message bundle="km-imissive" key="kmImissiveSignMain.baseinfo" />',
                        'moveTo': 'baseinfoView',
                        'selected': true
                    },
                        <c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
                        {
                            'text': '<bean:message bundle="km-imissive" key="kmImissiveSignMain.docContent" />',
                            'moveTo': '_contentView',
                            'id': 'contentNav'
                        },
                        </c:if>
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
        <c:if test="${kmImissiveSignMainForm.docStatus != '30'}">
            <script type="text/javascript">
                require(["dojo/store/Memory", "dojo/topic"], function (Memory, topic) {
                    var dataStore;
                    <%if("content".equals(KmImissiveConfigUtil.getDiplayOrder4Approval())){ %>
                    dataStore = [
                        <c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
                        {
                            'text': '<bean:message bundle="km-imissive" key="kmImissiveSignMain.docContent" />',
                            'moveTo': '_contentView',
                            'id': 'contentNav',
                            'selected': true
                        },
                        </c:if>
                        {
                            'text': '<bean:message bundle="km-imissive" key="kmImissiveSignMain.baseinfo" />',
                            'moveTo': 'baseinfoView'<c:if test="${kmImissiveSignMainForm.fdNeedContent!='1'}">,
                            'selected': true</c:if>
                        },
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
                        'text': '<bean:message bundle="km-imissive" key="kmImissiveSignMain.baseinfo" />',
                        'moveTo': 'baseinfoView',
                        'selected': true
                    },
                        <c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
                        {
                            'text': '<bean:message bundle="km-imissive" key="kmImissiveSignMain.docContent" />',
                            'moveTo': '_contentView',
                            'id': 'contentNav'
                        },
                        </c:if>
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
        <c:out value="${kmImissiveSignMainForm.docSubject}"></c:out>
    </template:replace>
    <template:replace name="content">
        <xform:config orient="vertical">
            <html:form action="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do">
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
                        <c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
                            <%@ include file="/km/imissive/mobile/sign/tabview_content.jsp" %>
                        </c:if>
                        <%@ include file="/km/imissive/mobile/sign/tabview_baseinfo.jsp" %>
                        <%} else { %>
                        <%@ include file="/km/imissive/mobile/sign/tabview_baseinfo.jsp" %>
                        <c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
                            <%@ include file="/km/imissive/mobile/sign/tabview_content.jsp" %>
                        </c:if>
                        <%} %>

                        <div data-dojo-type="dojox/mobile/View" id="_noteView">
                            <div class="muiFormContent">
                                <c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp"
                                          charEncoding="UTF-8">
                                    <c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId }"/>
                                    <c:param name="fdModelName"
                                             value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"/>
                                    <c:param name="formBeanName" value="kmImissiveSignMainForm"/>
                                </c:import>
                            </div>
                        </div>
                        <div data-dojo-type="dojox/mobile/View" id="_opinionView">
                            <div class="muiFormContent">
                                <ul
                                        data-dojo-type="mui/list/JsonStoreList"
                                        data-dojo-mixins="mui/list/ProcessItemListMixin"
                                        data-dojo-props="url:'/sys/circulation/sys_circulation_opinion/sysCirculationOpinion.do?method=list&fdModelId=${param.fdId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain&isOpinion=true',lazy:false">
                                </ul>
                            </div>
                        </div>
                    </div>
                    <template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp"
                                      docStatus="${kmImissiveSignMainForm.docStatus}"
                                      formName="kmImissiveSignMainForm"
                                      viewName="lbpmView"
                                      allowReview="true">
                        <template:replace name="flowArea">
                            <c:choose>
                                <c:when test="${kmImissiveSignMainForm.docStatus < '20' && kmImissiveSignMainForm.docStatus >= '10'}">
                                    <c:if test="${ kmImissiveSignMainForm.sysWfBusinessForm.fdIsHander == 'true'}">
                                        <%--起草人草稿编辑操作 --%>
                                        <kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=edit&fdId=${param.fdId }">
                                            <div data-dojo-type="mui/tabbar/TabBarButton"
                                                 data-dojo-props="colSize:1,href:'/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=edit&fdId=${param.fdId }'">
                                                <bean:message key="button.edit"/>
                                            </div>
                                        </kmss:auth>
                                    </c:if>
                                </c:when>
                            </c:choose>
                            <c:if test="${kmImissiveSignMainForm.fdNeedContent=='1' and kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'
			 						and 'word' eq attType and signAttsFlag ne true}">
                                <%-- 套红附加选项 --%>
                                <c:choose>
                                    <c:when test="${wpsoaassist eq 'true'}">
                                    </c:when>
                                    <c:when test="${_isWpsCloudEnable}">
                                    </c:when>
                                    <c:when test="${_isWpsCenterEnable}">
                                        <div data-dojo-type="mui/tabbar/TabBarButton"
                                             onclick="LoadWpsCenterHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSignMain');">
                                            <bean:message bundle="km-imissive" key="kmImissive.redhead"/>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <c:if test="${existOpinion}">
                                <div data-dojo-type="mui/tabbar/TabBarButton" onclick="circulate();">
                                    传阅意见
                                </div>
                            </c:if>
                            <c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
                                <c:if test="${not empty kmImissiveSignMainForm.attachmentForms['editonline'].attachments or not empty kmImissiveSignMainForm.attachmentForms['mainonline'].attachments}">
                                    <c:if test="${kmImissiveSignMainForm.fdNeedContent=='0'}">
                                        <%-- 集成了易企签、勾选了附件选项 --%>
                                        <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('mainonline');">
                                            <bean:message bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
                                        </div>
                                    </c:if>
                                    <c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
                                        <%-- 集成了易企签、勾选了附件选项 --%>
                                        <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('editonline');">
                                            <bean:message bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
                                        </div>
                                    </c:if>
                                </c:if>
                            </c:if>
                            <c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
                                <c:param name="fdModelName"
                                         value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"></c:param>
                                <c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}"></c:param>
                                <c:param name="fdSubject" value="${kmImissiveSignMainForm.docSubject}"></c:param>
                                <c:param name="showOption" value="label"></c:param>
                            </c:import>
                            <c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
                                <c:param name="formName" value="kmImissiveSignMainForm"></c:param>
                                <c:param name="showOption" value="label"></c:param>
                            </c:import>
                            <c:import url="/km/imissive/mobile/circulation/view.jsp" charEncoding="UTF-8">
                                <c:param name="formName" value="kmImissiveSignMainForm"></c:param>
                                <c:param name="showOption" value="label"></c:param>
                                <c:param name="isNew" value="true"></c:param>
                            </c:import>
                        </template:replace>
                        <template:replace name="publishArea">
                            <c:if test="${existOpinion}">
                                <div data-dojo-type="mui/tabbar/TabBarButton" onclick="circulate();">
                                    传阅意见
                                </div>
                            </c:if>
                            <c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
                                <c:if test="${not empty kmImissiveSignMainForm.attachmentForms['editonline'].attachments or not empty kmImissiveSignMainForm.attachmentForms['mainonline'].attachments}">
                                    <c:if test="${kmImissiveSignMainForm.fdNeedContent=='0'}">
                                        <%-- 集成了易企签、勾选了附件选项 --%>
                                        <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('mainonline');">
                                            <bean:message bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
                                        </div>
                                    </c:if>
                                    <c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
                                        <%-- 集成了易企签、勾选了附件选项 --%>
                                        <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('editonline');">
                                            <bean:message bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
                                        </div>
                                    </c:if>
                                </c:if>
                            </c:if>
                            <c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
                                <c:param name="fdModelName"
                                         value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"></c:param>
                                <c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}"></c:param>
                                <c:param name="fdSubject" value="${kmImissiveSignMainForm.docSubject}"></c:param>
                                <c:param name="showOption" value="label"></c:param>
                            </c:import>
                            <c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
                                <c:param name="formName" value="kmImissiveSignMainForm"></c:param>
                                <c:param name="showOption" value="label"></c:param>
                            </c:import>
                            <c:import url="/km/imissive/mobile/circulation/view.jsp" charEncoding="UTF-8">
                                <c:param name="formName" value="kmImissiveSignMainForm"></c:param>
                                <c:param name="showOption" value="label"></c:param>
                                <c:param name="isNew" value="true"></c:param>
                            </c:import>
                        </template:replace>
                    </template:include>
                </div>
                <c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true' and (_isWpsCloudEnable eq 'true' or _isWpsCenterEnable eq 'true')}">
                    <%@ include file="/km/imissive/mobile/cookieUtil_script.jsp" %>
                    <%@ include file="/km/imissive/mobile/sign/number_include.jsp" %>
                </c:if>

                <c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="kmImissiveSignMainForm"/>
                    <c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"/>
                </c:import>
                <!-- 版本锁机制 -->
                <c:import url="/component/locker/import/componentLockerVersion_import.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="kmImissiveSignMainForm"/>
                </c:import>
                <!-- 钉钉图标 -->
                <kmss:ifModuleExist path="/third/ding">
                    <c:import url="/third/ding/import/ding_view.jsp" charEncoding="UTF-8">
                        <c:param name="formName" value="kmImissiveSignMainForm"/>
                    </c:import>
                </kmss:ifModuleExist>
                <kmss:ifModuleExist path="/third/lding">
                    <c:import url="/third/lding/import/ding_view.jsp" charEncoding="UTF-8">
                        <c:param name="formName" value="kmImissiveSignMainForm"/>
                    </c:import>
                </kmss:ifModuleExist>
                <kmss:ifModuleExist path="/third/govding">
                    <c:import url="/third/govding/import/ding_view.jsp" charEncoding="UTF-8">
                        <c:param name="formName" value="kmImissiveSignMainForm"/>
                    </c:import>
                </kmss:ifModuleExist>
                <!-- 钉钉图标 end -->
                <c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="kmImissiveSignMainForm"/>
                    <c:param name="fdKey" value="signMainDoc"/>
                    <c:param name="viewName" value="lbpmView"/>
                    <c:param name="backTo" value="scrollView"/>
                    <c:param name="onClickSubmitButton" value="Com_submitReview();"/>
                </c:import>
                <%@ include file="/km/imissive/mobile/sign/view_import.jsp" %>
                <script>
                    require(["mui/form/ajax-form!kmImissiveSignMainForm"]);
                </script>
                <%@ include file="/km/imissive/mobile/sign/kmImissiveSignRedhead_script.jsp" %>
            </html:form>
        </xform:config>
    </template:replace>
</template:include>

