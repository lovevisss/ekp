<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="kmImeetingScheme" list="${queryPage.list }">
        <%--ID--%>
        <list:data-column property="fdId"/>
        <%--方案编号--%>
        <list:data-column headerClass="width200" col="docNumber" title="方案编号" escape="false">
            <span class="com_subject"><c:out value="${kmImeetingScheme.docNumber}"/></span>
        </list:data-column>
        <%--方案类型--%>
        <list:data-column headerClass="width200" col="fdType" title="方案类型" escape="false">
                <span class="com_subject"><c:out value="${kmImeetingScheme.fdType}"/></span>
        </list:data-column>
        <%--方案名称--%>
        <list:data-column headerClass="width200" col="docSubject" title="方案名称" escape="false">
                <span class="com_subject"><c:out value="${kmImeetingScheme.docSubject}"/></span>
        </list:data-column>
        <%--主持人--%>
        <list:data-column headerClass="width200" col="fdHost.fdName" title="主持人" escape="false">
                <span class="com_subject"><c:out value="${kmImeetingScheme.fdHost.fdName}"/></span>
        </list:data-column>
        <%--方案开始时间--%>
        <list:data-column headerClass="width200" col="fdBeginDate" title="方案开始时间" escape="false">
                <span class="com_subject">
                <kmss:showDate value="${kmImeetingScheme.fdBeginDate}" type="datetime"/>
            </span>
        </list:data-column>
        <%--方案结束时间--%>
        <list:data-column headerClass="width200" col="fdEndDate" title="方案结束时间" escape="false">
                <span class="com_subject">
                <kmss:showDate value="${kmImeetingScheme.fdEndDate}" type="datetime"/>
            </span>
        </list:data-column>
        <%--方案地点--%>
        <list:data-column headerClass="width200" col="fdSchemePlace" title="会议地点" escape="false">
                <span class="com_subject"><c:out value="${kmImeetingScheme.fdSchemePlace}"/></span>
        </list:data-column>
        <list:data-column headerClass="width140" col="docCreateTime" title="创建时间">
            <kmss:showDate value="${kmImeetingScheme.docCreateTime}" type="datetime"/>
        </list:data-column>
        <list:data-column headerClass="width140" col="docPublishTime" title="发布时间">
            <kmss:showDate value="${kmImeetingScheme.docPublishTime}" type="datetime"/>
        </list:data-column>
        <list:data-column col="nodeName" escape="false"
                          title="${ lfn:message('km-imeeting:sysWfNode.processingNode.currentProcess') }">
            <kmss:showWfPropertyValues var="nodevalue" idValue="${kmImeetingScheme.fdId}" propertyName="nodeName"/>
                <div class="textEllipsis width100" title="${nodevalue}">
                <c:out value="${nodevalue}"/>
            </div>
        </list:data-column>
        <list:data-column col="handlerName" escape="false"
                          title="${ lfn:message('km-imeeting:sysWfNode.processingNode.currentProcessor') }">
            <kmss:showWfPropertyValues var="handlerValue" idValue="${kmImeetingScheme.fdId}"
                                       propertyName="handlerName"/>
                <div class="textEllipsis width80" style="font-weight:bold;" title="${handlerValue}">
                <c:out value="${handlerValue}"/>
            </div>
        </list:data-column>
    </list:data-columns>
    <list:data-paging currentPage="${queryPage.pageno }"
                      pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
    </list:data-paging>
</list:data>