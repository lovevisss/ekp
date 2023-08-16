<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:replace name="head">
    <style type="text/css">
        .tb_simple > tbody > tr > .td_normal_title {
            text-align: left;
        }
    </style>
    <script type="text/javascript">
        seajs.use(['sys/ui/js/dialog'], function (dialog) {
            window.docDelete = function () {
                dialog.confirm("${lfn:message('page.comfirmDelete')}", function (flag) {
                    if (flag == true) {
                        Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=delete&fdId=${param.fdId}', '_self');
                    } else {
                        return false;
                    }
                }, "warn");
            };
        })
    </script>
</template:replace>
<template:replace name="title">
    <c:out value="${kmImeetingTopicForm.docSubject} - ${ lfn:message('km-imeeting:module.km.imeeting') }"/>
</template:replace>
<template:replace name="toolbar">
    <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6">
        <c:if test="${kmImeetingTopicForm.docStatusFirstDigit > '0'}">
            <kmss:auth requestURL="/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=edit&fdId=${param.fdId}"
                       requestMethod="GET">
                <ui:button text="${lfn:message('button.edit')}"
                           onclick="Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=edit&fdId=${param.fdId}','_self');"
                           order="2">
                </ui:button>
            </kmss:auth>
        </c:if>
        <kmss:auth requestURL="/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=delete&fdId=${param.fdId}"
                   requestMethod="GET">
            <ui:button text="${lfn:message('button.delete')}" order="4" onclick="docDelete();">
            </ui:button>
        </kmss:auth>
        <!--打印 -->
        <kmss:auth requestURL="/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=print&fdId=${param.fdId}"
                   requestMethod="GET">
            <ui:button text="${ lfn:message('button.print') }"
                       onclick="Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=print&fdId=${param.fdId}','_blank');">
            </ui:button>
        </kmss:auth>
        <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow()"/>
    </ui:toolbar>
</template:replace>
<template:replace name="path">
    <ui:combin ref="menu.path.simplecategory">
        <ui:varParams
                moduleTitle="${ lfn:message('km-imeeting:module.km.imeeting') }"
                modulePath="/km/imeeting/"
                modelName="com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory"
                autoFetch="false"
                target="_blank"
                categoryId="${kmImeetingTopicForm.fdTopicCategoryId}"/>
    </ui:combin>
</template:replace>	
