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
                        Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=delete&fdId=${param.fdId}', '_self');
                    } else {
                        return false;
                    }
                }, "warn");
            };
        })
    </script>
</template:replace>
<template:replace name="title">
    <c:choose>
        <c:when test="${ kmImeetingSchemeForm.method_GET == 'add' }">
            <c:out value="${ lfn:message('km-imeeting:module.km.imeeting') }"/>
        </c:when>
        <c:otherwise>
            <c:out value="${kmImeetingSchemeForm.docSubject} - ${ lfn:message('km-imeeting:module.km.imeeting') }"/>
        </c:otherwise>
    </c:choose>
</template:replace>
<template:replace name="toolbar">
    <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6">
        <c:if test="${kmImeetingSchemeForm.docStatusFirstDigit > '0' &&  kmImeetingSchemeForm.docStatusFirstDigit < '3'}">
            <kmss:auth
                    requestURL="/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=edit&fdId=${param.fdId}"
                    requestMethod="GET">
                <ui:button text="${lfn:message('button.edit')}"
                           onclick="Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=edit&fdId=${param.fdId}', '_self');"
                           order="2">
                </ui:button>
            </kmss:auth>
        </c:if>
        <!--打印 -->
        <kmss:auth requestURL="/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=print&fdId=${param.fdId}"
                   requestMethod="GET">
            <ui:button text="${ lfn:message('button.print') }"
                       onclick="Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=print&fdId=${param.fdId}', '_blank');">
            </ui:button>
        </kmss:auth>
        <kmss:auth requestURL="/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=delete&fdId=${param.fdId}"
                   requestMethod="GET">
            <ui:button text="${lfn:message('button.delete')}" order="4" onclick="docDelete();">
            </ui:button>
        </kmss:auth>
        <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow()">
        </ui:button>
    </ui:toolbar>
</template:replace>
<template:replace name="path">
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav" id="categoryId">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home"/>
            <ui:menu-item text="会议方案"/>
            <ui:menu-item text="会议方案申报"/>
            <ui:menu-source autoFetch="false">
                <ui:source type="AjaxJson">
                    {"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate&categoryId=${kmImeetingSchemeForm.fdSchemeTemplateId}"}
                </ui:source>
            </ui:menu-source>
        </ui:menu>
    </template:replace>
</template:replace>	