<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.landray.kmss.km.imissive.actions.KmImissiveReceiveMainAction" %>
<%@ include file="/resource/jsp/common.jsp" %>
<c:set var="fdMainId" value="${requestScope[param.formName].fdId}" scope="request"/>
<% new KmImissiveReceiveMainAction().listPrint(request, response);%>
<c:choose>
    <c:when test="${not empty queryList}">
        <table class="tb_normal" width="100%">
            <tr class="tr_normal">
                <td width="20%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="kmImissiveReceiveMain.docSubject"/>
                </td>
                <td width="10%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="kmImissiveReceiveMain.fdSendtoDept"/>
                </td>
                <td width="20%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="kmImissiveReceiveMain.fdReceiveNum"/>
                </td>
                <td width="10%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="kmImissiveReceiveMain.fdReceiveTime"/>
                </td>
                <td width="10%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="kmImissiveReceiveMain.fdEmergencyGrade"/>
                </td>
                <td width="10%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="kmImissiveReceiveMain.docStatus"/>
                </td>
                <td width="10%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="sysWfNode.processingNode.currentProcess"/>
                </td>
                <td width="10%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="sysWfNode.processingNode.currentProcessor"/>
                </td>
            </tr>
            <c:forEach items="${queryList}" var="kmImissiveReceiveMain" varStatus="vStatus">
                <tr>
                    <td>
                        <c:out value="${kmImissiveReceiveMain.docSubject}"/>
                    </td>
                    <td>
                        <c:out value="${kmImissiveReceiveMain.fdSendtoUnit.fdName}"/><c:out
                            value="${kmImissiveReceiveMain.fdOutSendto}"/>
                    </td>
                    <td>
                        <c:if test="${empty kmImissiveReceiveMain.fdReceiveNum}">
                            <c:choose>
                                <c:when test="${kmImissiveReceiveMain.docStatus!='30'}">
                                    <bean:message bundle="km-imissive"
                                                  key="kmImissiveReceiveMain.fdReceiveNum.docNum.info"/>
                                </c:when>
                                <c:otherwise>
                                    <bean:message bundle="km-imissive"
                                                  key="kmImissiveReceiveMain.fdReceiveNum.docNum.info.null"/>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        <c:if test="${not empty kmImissiveReceiveMain.fdReceiveNum}">
                            <c:out value="${kmImissiveReceiveMain.fdReceiveNum}"/>
                        </c:if>
                    </td>
                    <td>
                        <kmss:showDate value="${kmImissiveReceiveMain.fdReceiveTime}" type="date"/>
                    </td>
                    <td>
                        <c:if test="${not empty kmImissiveReceiveMain.fdEmergencyGrade.fdColor}">
                        <div style="background:${kmImissiveReceiveMain.fdEmergencyGrade.fdColor};color:#fff;">
                            </c:if>
                            <c:out value="${kmImissiveReceiveMain.fdEmergencyGrade.fdName }"/>
                            <c:if test="${not empty kmImissiveReceiveMain.fdEmergencyGrade.fdColor}">
                        </div>
                        </c:if>
                    </td>
                    <td>
                        <span title='<c:out value="${lbpmAuditNote.detailHandlerName}" />'>
                            <sunbor:enumsShow value="${kmImissiveReceiveMain.docStatus}" enumsType="kmImissive_common_status"/>
                        </span>
                    </td>
                    <td>
                        <kmss:showWfPropertyValues var="nodevalue" idValue="${kmImissiveReceiveMain.fdId}" propertyName="nodeName"/>
                        <c:out value="${nodevalue}"></c:out>
                    </td>
                    <td>
                        <kmss:showWfPropertyValues var="handlerValue" idValue="${kmImissiveReceiveMain.fdId}" propertyName="handlerName"/>
                        <c:out value="${handlerValue}"></c:out>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:when>
    <c:otherwise>
        <%@ include file="/resource/jsp/list_norecord_simple.jsp" %>
    </c:otherwise>
</c:choose>