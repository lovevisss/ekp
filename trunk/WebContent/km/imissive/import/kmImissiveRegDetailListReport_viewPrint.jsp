<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.landray.kmss.km.imissive.actions.KmImissiveRegDetailListAction" %>
<%@ include file="/resource/jsp/common.jsp" %>
<c:set var="fdMainId" value="${requestScope[param.formName].fdId}" scope="request"/>
<c:set var="deliverType" value="2" scope="request"/>
<% new KmImissiveRegDetailListAction().listPrint(request, response);%>
<c:choose>
    <c:when test="${not empty queryList}">
        <table class="tb_normal" width="100%">
            <tr class="tr_normal">
                <td width="20%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="kmImissiveReg.fdName"/>
                </td>
                <td width="20%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="kmImissiveReg.from"/>
                </td>
                <td width="10%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="kmImissiveReg.fdUnit"/>
                </td>
                <td width="10%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="kmImissiveReg.docCreateTime"/>
                </td>
                <td width="10%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="kmImissiveReg.fdOrgNames"/>
                </td>
                <td width="10%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="kmImissiveReg.fdStatus"/>
                </td>
                <td width="10%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="sysWfNode.processingNode.currentProcess"/>
                </td>
                <td width="10%" class="td_normal_title">
                    <bean:message bundle="km-imissive" key="sysWfNode.processingNode.currentProcessor"/>
                </td>
            </tr>
            <c:forEach items="${queryList}" var="kmImissiveRegDetailList" varStatus="vStatus">
                <tr>
                    <td>
                        <c:out value="${kmImissiveRegDetailList.fdReg.fdName}" />
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${kmImissiveRegDetailList.fdReg.fdRegType eq '2' }">
                                ${ lfn:message('km-imissive:kmImissiveReg.fdRegType.receive')}
                            </c:when>
                            <c:otherwise>
                                ${ lfn:message('km-imissive:kmImissiveReg.fdRegType.send')}
                            </c:otherwise>
                        </c:choose>
                        <sunbor:enumsShow value="${kmImissiveRegDetailList.fdReg.fdDeliverType}" enumsType="kmImissiveRegDetailList_type" bundle="km-imissive" />
                        <sunbor:enumsShow value="${kmImissiveRegDetailList.fdType}" enumsType="kmImissiveRegDetailList_unittype" bundle="km-imissive" />
                    </td>
                    <td>
                        <c:out value="${kmImissiveRegDetailList.fdUnit.fdName}" />
                    </td>
                    <td>
                        <kmss:showDate value="${kmImissiveRegDetailList.docCreateTime}" type="date" />
                    </td>
                    <td>
                        <c:forEach items="${kmImissiveRegDetailList.fdOrg}" var="fdOrg" varStatus="vstatus">
                            <c:out value="${fdOrg.fdName}"/>
                        </c:forEach>
                    </td>
                    <td>
                        <sunbor:enumsShow value="${kmImissiveRegDetailList.fdStatus}" enumsType="kmImissiveReg_status" bundle="km-imissive" />
                    </td>
                    <td>
                        <c:if test="${kmImissiveRegDetailList.fdUnit.fdNature != 2}">
                            <kmss:showWfPropertyValues idValue="${json[kmImissiveRegDetailList.fdId]}" propertyName="nodeName" />
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${kmImissiveRegDetailList.fdUnit.fdNature != 2}">
                            <kmss:showWfPropertyValues idValue="${json[kmImissiveRegDetailList.fdId]}" propertyName="handlerName" />
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:when>
    <c:otherwise>
        <%@ include file="/resource/jsp/list_norecord_simple.jsp" %>
    </c:otherwise>
</c:choose>