<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.edit" compatibleMode="true" tiny="true">
    <template:replace name="title">
        <c:if test="${empty  kmImeetingMainForm.fdName}">
            <bean:message bundle="km-imeeting" key="mobile.header.addMain"/>
        </c:if>
        <c:out value="${kmImeetingMainForm.fdName}"></c:out>
    </template:replace>
    <template:replace name="head">
        <mui:min-file name="mui-imeeting-edit.css"/>
        <link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/edit_topic.css"/>
        <link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/edit.css"/>
    </template:replace>
    <template:replace name="content">
        <script type="text/javascript">
            window.getStaffingLevel = function (el) {};
        </script>
        <html:form action="/km/imeeting/km_imeeting_main/kmImeetingMain.do">
            <div>
                <div data-dojo-type="mui/fixed/Fixed" data-dojo-props="fixedOrder:1" class="muiFlowEditFixed">
                    <div data-dojo-type="mui/fixed/FixedItem">
                        <div data-dojo-type="mui/nav/NavBarStore"
                             data-dojo-mixins="mui/nav/NavBarStepMixin,km/imeeting/mobile/main/js/MainEditNavMixin"
                             id="_flowNav">
                        </div>
                    </div>
                </div>
            </div>
            <div data-dojo-type="mui/view/DocScrollableView"
                 data-dojo-mixins="mui/form/_ValidateMixin,mui/form/_AlignMixin" id="scrollView">
                <div class="muiFlowInfoW muiFormContent">
                    <html:hidden property="fdId"/>
                    <html:hidden property="docStatus"/>
                    <html:hidden property="docCreateTime"/>
                    <html:hidden property="fdNotifyerId"/>
                    <html:hidden property="fdChangeMeetingFlag"/>
                    <html:hidden property="fdSummaryFlag"/>
                    <html:hidden property="method_GET"/>
                    <html:hidden property="fdIsTopic" value="${kmImeetingMainForm.fdIsTopic}"/>
                    <html:hidden property="fdModelId" value="${kmImeetingMainForm.fdModelId}"/>
                    <html:hidden property="fdModelName" value="${kmImeetingMainForm.fdModelName}"/>
                    <html:hidden property="fdPhaseId" value="${kmImeetingMainForm.fdPhaseId}"/>
                    <html:hidden property="fdWorkId" value="${kmImeetingMainForm.fdWorkId}"/>
                    <html:hidden property="fdChangeType" value="${kmImeetingMainForm.fdChangeType}"/>
                    <html:hidden property="fdTemplateId" value="${kmImeetingMainForm.fdTemplateId}"/>
                    <html:hidden property="fdTemplateName" value="${kmImeetingMainForm.fdTemplateName}"/>
                    <html:hidden property="fdNotifyType" value="1"/>

                    <c:set var="showType" value="edit"></c:set>
                    <c:if test="${not empty kmImeetingMainForm.fdSchemeId}">
                        <c:set var="showType" value="readOnly"></c:set>
                    </c:if>
                    <table class="muiSimple" cellpadding="0" cellspacing="0">
                        <c:if test="${kmImeetingMainForm.fdChangeMeetingFlag=='true' }">
                            <tr>
                                <td colspan="2">
                                    <xform:textarea mobile="true" property="changeMeetingReason"
                                                    className="m-changeMeetingReason"
                                                    required="true" showStatus="edit" validators="maxLength(1500)"
                                                    subject="变更事由"></xform:textarea>
                                    <html:hidden property="beforeChangeContent"/>
                                </td>
                            </tr>
                        </c:if>
                        <tr>
                            <td class="muiTitle">
                                关联会议方案
                            </td>
                            <td>
                                <html:hidden property="fdSchemeId" value="${kmImeetingMainForm.fdSchemeId}"/>
                                <div id="fdSchemeName"></div>
                                <span class="fdSchemeSelectBtn" onclick="selectScheme();" id="selectSchemeButton">
                                    <span class="muiImeetingSIFont">请选择</span>
                                    <span class="fontmuis muis-to-right"></span>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="muiTitle">
                                会议标题
                            </td>
                            <td>
                                <xform:text property="fdName" mobile="true" required="true" showStatus="edit"
                                            htmlElementProperties="class='kmImeetingTextRignt'"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="muiTitle">
                                会议编号
                            </td>
                            <td>
                                <span style="flpadding-right: 2.2rem;float: right;">（提交后系统自动生成）</span>
                            </td>
                        </tr>
                        <tr class="placeResTr">
                            <td class="muiTitle">
                                会议地点
                            </td>
                            <td class="placeComponentTd">
                                <div id="placeComponent"
                                     data-dojo-type="km/imeeting/mobile/resource/js/PlaceComponent"
                                     data-dojo-props='
											"subject":"${lfn:message("km-imeeting:kmImeetingMain.fdPlace") }",
											"idField":"fdPlaceId",
											"nameField":"fdPlaceName",
											"showStatus":"edit",
											"curIds":"${kmImeetingMainForm.fdPlaceId}",
											"curNames":"${kmImeetingMainForm.fdPlaceName}",
											"validate":"validateUserTime",
											"orient":"vertical",
											"required":false'>
                                </div>
                                <div id="otherPlace">
                                    <xform:text property="fdOtherPlace" style="width:46%;" mobile="true"
                                                subject="${lfn:message('km-imeeting:kmImeetingMain.fdPlace') }"
                                                htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdOtherMainPlace') }'"></xform:text>
                                </div>
                                <input type="hidden" name="fdPlaceUserTime" value="${ kmImeetingMainForm.fdUserTime}"
                                       subject="${lfn:message('km-imeeting:kmImeetingMain.fdPlace') }"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="kmImeetingTimeBox">
                                    <div class="kmImeetingHoldTimeBox">
                                        <div id="kmImeetingHoldTimeDiv" class="kmImeetingHoldTimeBoxDiv">
                                            <div class="kmImeetingHoldTimeTitle">
                                                <div class="title">开始时间</div>
                                            </div>
                                            <div class="kmImeetingHoldDate">
                                            </div>
                                            <div class="kmImeetingHoldTimeContent kmImeetingHoldTimeFont"></div>
                                            <div class="kmImeetingHoldTimeTip"></div>
                                        </div>
                                            <%-- dateDomStatus 在setValueFromScheme() 中定义 --%>
                                        <c:if test="${empty dateDomStatus}">
                                            <c:set var="dateDomStatus" value="edit"/>
                                        </c:if>
                                        <xform:datetime htmlElementProperties="id='fdHoldDate'" property="fdHoldDate"
                                                        dateTimeType="datetime" mobile="true" required="true"
                                                        validators="after beforeFinishDate"
                                                        onValueChange="handleDurationChange();getMeetingDateInfo();"
                                                        showStatus="${dateDomStatus}"></xform:datetime>
                                    </div>
                                    <div class="kmImeetingTimeIcon">
                                    </div>
                                    <div class="kmImeetingEndTimeBox">
                                        <div id="kmImeetingEndTimeBoxDiv">
                                            <div class="kmImeetingEndTimeTitle">
                                                <div class="title">结束时间</div>
                                            </div>
                                            <div class="kmImeetingEndDate">
                                            </div>
                                            <div class="kmImeetingEndTimeContent kmImeetingEndTimeFont"></div>
                                            <div class="kmImeetingEndTimeTip"></div>
                                        </div>
                                        <xform:datetime htmlElementProperties="id='fdFinishDate'"
                                                        property="fdFinishDate" dateTimeType="datetime" mobile="true"
                                                        required="true" validators="after afterHoldDate"
                                                        onValueChange="handleDurationChange();getMeetingDateInfo();"
                                                        showStatus="${dateDomStatus}"></xform:datetime>
                                    </div>
                                    <div class="muiFormRequired">*</div>
                                    <div class="kmImeetingHoldDurationBox">
                                        <input type="hidden" name="fdHoldDuration"/>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="muiTitle">
                                报名截止时间
                            </td>
                            <td>
                                <xform:datetime style="width:90%" property="fdFeedBackDeadline" dateTimeType="datetime"
                                                showStatus="edit"
                                                subject="${lfn:message('km-imeeting:kmImeetingMain.fdFeedBackDeadline')}"
                                                required="true" validators="after valDeadline"
                                                mobile="true"></xform:datetime>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="kmImeetingULTitle kmImeetingLLBox">
                                    主持人
                                </div>
                                <div id="presidtor" class="kmImeetingLLBox">
                                    <xform:address propertyName="fdHostName" propertyId="fdHostId"
                                                   subject="${lfn:message('km-imeeting:kmImeetingMain.fdHost') }"
                                                   orgType="ORG_TYPE_PERSON" required="false" mobile="true"
                                                   showStatus="${showType}" onValueChange="getStaffingLevel(this);"
                                                   htmlElementProperties="class='kmImeetingLLContent'">
                                    </xform:address>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="muiTitle">
                                <div class="kmImeetingULTitle">
                                    职务
                                </div>
                                <div class="kmImeetingLLContent">
                                    <input name="fdPosition" type="hidden" value="${kmImeetingMainForm.fdPosition}">
                                    <span id="fdPositionName"></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="kmImeetingULTitle kmImeetingLLBox">
                                    会议发起人
                                </div>
                                <div class="kmImeetingLLBox">
                                    <xform:address propertyName="docCreatorName" propertyId="docCreatorId"
                                                   subject="会议发起人"
                                                   orgType="ORG_TYPE_PERSON" required="false" mobile="true"
                                                   showStatus="readOnly"
                                                   htmlElementProperties="class='kmImeetingLLContent'">
                                    </xform:address>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="kmImeetingULTitle">
                                    发起人部门
                                </div>
                                <div class="kmImeetingLLBox">
                                    <xform:address propertyName="fdCreatorDeptName" propertyId="fdCreatorDeptId"
                                                   subject="发起人部门"
                                                   orgType="ORG_TYPE_ALL" required="false" mobile="true"
                                                   showStatus="readOnly"
                                                   htmlElementProperties="class='kmImeetingLLContent'">
                                    </xform:address>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                    <%-- attendDomStatus 在setValueFromScheme() 中定义 --%>
                                <c:if test="${empty attendDomStatus}">
                                    <c:set var="attendDomStatus" value="edit"/>
                                </c:if>
                                <div class="kmImeetingULTitle">
                                    出席会议人员
                                </div>
                                <div class="kmImeetingLLBox">
                                    <xform:address propertyId="fdAttendPersonIds" showStatus="${attendDomStatus}"
                                                   propertyName="fdAttendPersonNames"
                                                   subject="${lfn:message('km-imeeting:kmImeetingMain.fdAttendPersons')}"
                                                   htmlElementProperties="class='kmImeetingLLContent'"
                                                   orgType="ORG_TYPE_ALL" mulSelect="true" mobile="true"
                                                   required="true">
                                    </xform:address>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="kmImeetingULTitle">
                                    邀请参加人员
                                </div>
                                <div class="kmImeetingLLBox">
                                    <xform:address propertyId="fdInvitePersonIds" showStatus="${showType}"
                                                   propertyName="fdInvitePersonNames"
                                                   subject="${lfn:message('km-imeeting:kmImeetingMain.fdAttendPersons')}"
                                                   htmlElementProperties="class='kmImeetingLLContent'"
                                                   orgType="ORG_TYPE_ALL" mulSelect="true" mobile="true">
                                    </xform:address>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="kmImeetingULTitle">
                                    列席会议人员
                                </div>
                                <div class="kmImeetingLLBox">
                                    <xform:address textarea="true"
                                                   showStatus="${showType}"
                                                   mobile="true"
                                                   propertyId="fdParticipantPersonIds"
                                                   propertyName="fdParticipantPersonNames"
                                                   orgType="ORG_TYPE_ALL" mulSelect="true"
                                                   htmlElementProperties="class='kmImeetingLLContent'">
                                    </xform:address>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="kmImeetingULTitle">
                                    会议纪要人员
                                </div>
                                <div class="kmImeetingLLBox">
                                    <xform:address
                                            propertyId="fdSummaryInputPersonId"
                                            propertyName="fdSummaryInputPersonName"
                                            orgType="ORG_TYPE_PERSON"
                                            mobile="true"
                                            validators="validateSummaryInputPerson"
                                            htmlElementProperties="class='kmImeetingLLContent'">
                                    </xform:address>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="kmImeetingULTitle">
                                    会服人员
                                </div>
                                <div class="kmImeetingLLBox">
                                    <xform:address
                                            showStatus="edit"
                                            propertyId="fdAssistPersonIds"
                                            propertyName="fdAssistPersonNames"
                                            mobile="true"
                                            orgType="ORG_TYPE_ALL"
                                            mulSelect="true"
                                            htmlElementProperties="class='kmImeetingLLContent'">
                                    </xform:address>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div>
                                    <div class="kmImeetingULTitle">
                                        会议内容
                                    </div>
                                    <c:choose>
                                        <c:when test="${kmImeetingMainForm.method_GET == 'add'}">
                                            <html:hidden property="fdIsTopic" value="1"/>
                                            <%@include file="/km/imeeting/mobile/topic/agenda_editTopic.jsp" %>
                                        </c:when>
                                        <c:otherwise>
                                            <html:hidden property="fdIsTopic" value="1"/>
                                            <%@include file="/km/imeeting/mobile/topic/agenda_editTopic.jsp" %>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="kmImeetingULTitle">
                                    出席单位
                                </div>
                                <div>
                                    <span class="topicUnit"></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="kmImeetingULTitle">
                                    工作安排
                                </div>
                                <div>
                                    <xform:textarea property="workArrangement" showStatus="${showType}" mobile="true"
                                                    htmlElementProperties="class='kmImeetingLLContent'">
                                    </xform:textarea>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div id="equipmentComponent"
                                     data-dojo-type="km/imeeting/mobile/resource/js/EquipmentComponent"
                                     data-dojo-props='"subject":"${lfn:message("km-imeeting:kmImeetingMain.kmImeetingEquipment")}","idField":"kmImeetingEquipmentIds","nameField":"kmImeetingEquipmentNames","showStatus":"edit","curIds":"${kmImeetingMainForm.kmImeetingEquipmentIds}","curNames":"${kmImeetingMainForm.kmImeetingEquipmentNames}",orient:"vertical"'></div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="kmImeetingULTitle">
                                    <bean:message bundle="km-imeeting" key="kmImeetingMain.kmImeetingDevices"/>
                                </div>
                                <xform:checkbox property="kmImeetingDeviceIds" showStatus="edit"
                                                subject="${lfn:message('km-imeeting:kmImeetingMain.kmImeetingDevices')}"
                                                mobile="true" htmlElementProperties="class='mobile-meeting-devices'">
                                    <xform:beanDataSource serviceBean="kmImeetingDeviceService"
                                                          selectBlock="fdId,fdName"
                                                          whereBlock="kmImeetingDevice.fdIsAvailable=true"
                                                          orderBy="fdOrder"/>
                                </xform:checkbox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="kmImeetingULTitle">
                                    通知方式
                                </div>
                                <kmss:editNotifyType property="fdNotifyWay" mobile="true"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="kmImeetingULTitle">
                                    短信内容
                                </div>
                                <xform:textarea property="fdSMSContent" mobile="true" placeholder="请填写短信内容"></xform:textarea>
                            </td>
                        </tr>
                    </table>

                    <c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
                        <c:param name="formName" value="kmImeetingMainForm"/>
                        <c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic"/>
                    </c:import>
                </div>

                <ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom">
                    <li data-dojo-type="mui/tabbar/TabBarButton"
                        data-dojo-props='colSize:4,moveTo:"lbpmView",transition:"slide"'>
                        <bean:message bundle="km-imeeting" key="button.next"/>
                    </li>
                </ul>
            </div>

            <c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
                <c:param name="formName" value="kmImeetingMainForm"/>
                <c:param name="fdKey" value="ImeetingMain"/>
                <c:param name="viewName" value="lbpmView"/>
                <c:param name="backTo" value="scrollView"/>
                <c:param name="onClickSubmitButton" value="main_submit();"/>
            </c:import>

            <!-- 日程继承 -->
            <c:forEach items="${kmImeetingMainForm.sysNotifyRemindMainContextForm.sysNotifyRemindMainFormList}" var="i"
                       varStatus="vs">
                <input type="hidden"
                       value="${kmImeetingMainForm.sysNotifyRemindMainContextForm.sysNotifyRemindMainFormList[vs.index].fdId }"
                       name="sysNotifyRemindMainContextForm.sysNotifyRemindMainFormList[${vs.index}].fdId"/>
                <input type="hidden"
                       name="sysNotifyRemindMainContextForm.sysNotifyRemindMainFormList[${vs.index}].fdModelName"
                       value="com.landray.kmss.km.imeeting.model.KmImeetingMain">
                <input type="hidden"
                       name="sysNotifyRemindMainContextForm.sysNotifyRemindMainFormList[${vs.index}].fdNotifyType"
                       value="todo">
                <input type="hidden"
                       name="sysNotifyRemindMainContextForm.sysNotifyRemindMainFormList[${vs.index}].fdBeforeTime"
                       value="${kmImeetingMainForm.sysNotifyRemindMainContextForm.sysNotifyRemindMainFormList[vs.index].fdBeforeTime}">
                <input type="hidden"
                       name="sysNotifyRemindMainContextForm.sysNotifyRemindMainFormList[${vs.index}].fdTimeUnit"
                       value="${kmImeetingMainForm.sysNotifyRemindMainContextForm.sysNotifyRemindMainFormList[vs.index].fdTimeUnit}"/>
            </c:forEach>

            <!-- 发布隐藏机制 -->
            <c:import url="/sys/news/import/sysNewsPublishMain_edit.jsp" charEncoding="UTF-8">
                <c:param name="formName" value="kmImeetingMainForm"/>
                <c:param name="fdKey" value="ImeetingMain"/>
                <c:param name="isShow" value="false"/>
            </c:import>

            <%-- 会议历史操作信息隐藏域 --%>
            <div style="display: none;">
                <c:forEach items="${kmImeetingMainForm.kmImeetingMainHistoryForms}" var="kmImeetingMainHistoryItem" varStatus="vstatus">
                    <input type="hidden" name="kmImeetingMainHistoryForms[${vstatus.index}].fdId" value="${kmImeetingMainHistoryItem.fdId}"/>
                </c:forEach>
            </div>

            <script type="text/javascript">
                require(["mui/form/ajax-form!kmImeetingMainForm"]);
                require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 'mui/device/adapter', 'dojo/dom',
                        'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip', 'mui/util'],
                    function (ready, registry, topic, request, adapter, dom, domAttr, domStyle, domClass, query, Tip, util, DialogSelector) {

                        window.main_submit = function () {
                            var validorObj = registry.byId('scrollView');
                            if (!validorObj.validate()) {
                                return;
                            }
                            var method = Com_GetUrlParameter(location.href, 'method');
                            var noTemplate = '${kmImeetingMainForm.fdTemplateId!=null}';

                            if (method == 'edit') {
                                window.commitMethod("update", noTemplate);
                            } else if (method == "changeMeeting") {
                                window.commitMethod("updateChange", noTemplate);
                            } else {
                                window.commitMethod("save", noTemplate);
                            }
                        };

                        window.changeMeetingPlace = function (domElement) {
                            topic.publish("/km/imeeting/otherPlace/changed", {
                                'fdOtherPlace': domElement.value,
                            });
                        }
                    });
            </script>
            <%@ include file="/km/imeeting/mobile/main/edit_js.jsp" %>
        </html:form>
    </template:replace>
</template:include>
