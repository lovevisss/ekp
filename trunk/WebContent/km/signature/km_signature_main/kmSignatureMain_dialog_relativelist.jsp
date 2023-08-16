<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="kmSignatureMain" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column property="fdMarkName" title="${lfn:message('km-signature:signature.markname')}" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdMarkDate" title="${lfn:message('km-signature:kmSignatureMain.fdMarkDate')}" />
        <list:data-column property="fdDocType" title="${lfn:message('km-signature:kmSignatureMain.fdDocType')}" />
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
