<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ page import="com.landray.kmss.util.UserUtil" %>
<%
    request.setAttribute("isAdmin", UserUtil.getKMSSUser().isAdmin());
%>
<template:include ref="default.simple" spa="true">
    <template:replace name="body">
        <script type="text/javascript">
            seajs.use(['theme!list']);
        </script>
        <list:criteria id="schemeCriteria" cfg-canExpand="false">
            <list:cri-ref key="docSubject" ref="criterion.sys.docSubject">
            </list:cri-ref>
            <list:cri-ref ref="criterion.sys.category" key="fdSchemeTemplate" multi="false"
                          title="${ lfn:message('sys-category:menu.sysCategory.index') }" expand="false">
                <list:varParams modelName="com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate"/>
            </list:cri-ref>
            <list:cri-auto modelName="com.landray.kmss.km.imeeting.model.KmImeetingScheme" property="docNumber"/>
            <list:cri-auto modelName="com.landray.kmss.km.imeeting.model.KmImeetingScheme"
                           property="fdHost;fdBeginDate"/>
        </list:criteria>


        <div class="lui_list_operation">
            <div class="gkp_list_operation_item_l">
                <div style="display: inline-block;vertical-align: middle;">
                    <ui:toolbar count="11" id="Btntoolbar">
                        <%-- 批量打印 --%>
                        <kmss:authShow roles="ROLE_KMIMEETING_PRINT_BATCH">
                            <ui:button text="${lfn:message('km-imeeting:kmImeeting.btn.print.batch')}" id="batchPrint"
                                       onclick="batchPrint();" order="1"/>
                        </kmss:authShow>
                        <kmss:authShow roles="ROLE_KMIMEETING_SCHEME_TRANSPORT_EXPORT">
                            <ui:button text="${lfn:message('button.export')}" id="export"
                                       onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingScheme')"
                                       order="2"/>
                        </kmss:authShow>
                        <kmss:auth requestURL="/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=deleteall">
                            <ui:button id="del" text="${lfn:message('button.deleteall')}" order="3"
                                       onclick="delDoc();"/>
                        </kmss:auth>
                        <%-- 修改权限 --%>
                        <c:import url="/sys/right/import/cchange_doc_right_button.jsp" charEncoding="UTF-8">
                            <c:param name="modelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme"/>
                            <c:param name="authReaderNoteFlag" value="2"/>
                        </c:import>
                        <kmss:auth requestURL="/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=changeTemplate&categoryId=${JsParam.categoryId}&nodeType=${JsParam.nodeType}"
                                requestMethod="GET">
                            <ui:button id="chgCate" text="${lfn:message('km-imeeting:kmImeeting.btn.translate')}"
                                       order="5" onclick="chgSelect();"/>
                        </kmss:auth>
                    </ui:toolbar>
                </div>
            </div>
            <div class="gkp_list_operation_item_r">
                <div data-lui-type="lui/search_box_new!SearchBox" class="searchBox">
                    <script type="text/config">
					{
						placeholder: "请输入标题",
						width: '200px'
					}
                    </script>
                    <ui:event event="search.changed" args="evt">
                        doSearchAction(evt);
                    </ui:event>
                </div>
                <div class="moreSearchBtn">
                    <a onclick="expanded();">高级搜索</a>
                </div>
            </div>
        </div>
        <ui:fixed elem=".lui_list_operation"/>
        <list:listview id="listview_scheme">
            <ui:source type="AjaxJson">
                {url:'/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=list&isDialog=0&q.j_path=%2FschemeApproval%2FschemeMyTodo&q.docType=myApproval'}
            </ui:source>
            <list:colTable
                    url="${LUI_ContextPath}/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.imeeting.model.KmImeetingScheme"
                    isDefault="false" layout="sys.ui.listview.columntable"
                    rowHref="/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=view&fdId=!{fdId}"
                    name="columntable">
                <list:col-checkbox/>
                <list:col-serial/>
                <list:col-auto props=""/>
            </list:colTable>
        </list:listview>
        <list:paging/>

        <%@ include file="/km/imeeting/km_imeeting_scheme/import/scheme_index_script.jsp" %>
    </template:replace>
</template:include>