<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="sysOmsGroup" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('sys-oms:sysOmsGroup.fdName')}" />
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('sys-oms:sysOmsGroup.fdIsAvailable')}">
            <sunbor:enumsShow value="${sysOmsGroup.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${sysOmsGroup.fdIsAvailable}" />
        </list:data-column>
        <list:data-column property="fdNo" title="${lfn:message('sys-oms:sysOmsGroup.fdNo')}" />
        <list:data-column property="fdKeyword" title="${lfn:message('sys-oms:sysOmsGroup.fdKeyword')}" />
        <list:data-column property="fdImportinfo" title="${lfn:message('sys-oms:sysOmsGroup.fdImportinfo')}" />
        <list:data-column property="fdHandleStatus" title="${lfn:message('sys-oms:sysOmsGroup.fdHandleStatus')}" />
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
