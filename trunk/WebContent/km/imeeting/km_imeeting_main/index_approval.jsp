<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.util.SpringBeanUtil" %>
<%@page import="com.landray.kmss.sys.appconfig.service.ISysAppConfigService" %>
<%@page import="java.util.Map" %>
<%@ page import=" com.landray.kmss.util.ResourceUtil" %>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil" %>
<%
    String modelName = "com.landray.kmss.km.imeeting.model.KmImeetingConfig";
    ISysAppConfigService sysAppConfigService = (ISysAppConfigService) SpringBeanUtil.getBean("sysAppConfigService");
    Map map = sysAppConfigService.findByKey(modelName);
    request.setAttribute("kmImeetingConfig", map);
    request.setAttribute("useCloud", KmImeetingConfigUtil.isUseCloudMng());
    request.setAttribute("isAdmin", UserUtil.getKMSSUser().isAdmin());
%>

<template:include ref="default.simple" spa="true">
    <template:replace name="body">
        <script type="text/javascript">
            seajs.use(['theme!list']);
        </script>
        <%-- 筛选器 --%>
        <list:criteria id="imeetingCriteria" cfg-canExpand="false">
            <list:cri-ref key="fdName" ref="criterion.sys.docSubject"
                          title="${lfn:message('km-imeeting:kmImeetingMain.fdName') }"/>
            <%-- 分类导航 --%>
            <list:cri-ref ref="criterion.sys.category" key="fdTemplate" multi="false"
                          title="${lfn:message('sys-category:menu.sysCategory.index') }" expand="false">
                <list:varParams modelName="com.landray.kmss.km.imeeting.model.KmImeetingTemplate"/>
            </list:cri-ref>
            <list:cri-auto modelName="com.landray.kmss.km.imeeting.model.KmImeetingMain" property="fdMeetingNum"/>
            <%-- 主持人、召开时间 --%>
            <list:cri-auto modelName="com.landray.kmss.km.imeeting.model.KmImeetingMain" property="fdHost;fdHoldDate"/>
        </list:criteria>
        <div class="lui_list_operation">
            <div class="gkp_list_operation_item_l">
                <div style="display: inline-block;vertical-align: middle;">

                    <ui:toolbar count="7" id="Btntoolbar">
                        <%-- 批量打印 --%>
                        <kmss:authShow roles="ROLE_KMIMEETING_PRINT_BATCH">
                            <ui:button text="${lfn:message('km-imeeting:kmImeeting.btn.print.batch')}" id="batchPrint"
                                       onclick="batchPrint();" order="1"/>
                        </kmss:authShow>
                        <kmss:authShow roles="ROLE_KMIMEETING_TRANSPORT_EXPORT">
                            <ui:button text="${lfn:message('button.export')}" id="export"
                                       onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain')"
                                       order="2"/>
                        </kmss:authShow>
                        <%-- 收藏 --%>
                        <c:import url="/sys/bookmark/import/bookmark_bar_all.jsp" charEncoding="UTF-8">
                            <c:param name="fdTitleProName" value="fdName"/>
                            <c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain"/>
                        </c:import>
                        <c:import url="/sys/right/import/cchange_doc_right_button.jsp" charEncoding="UTF-8">
                            <c:param name="modelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain"/>
                            <c:param name="authReaderNoteFlag" value="2"/>
                        </c:import>
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
        <%-- 列表视图 --%>
        <list:listview id="listview">
            <ui:source type="AjaxJson">
                {url:'/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=listChildren&categoryId=${JsParam.categoryId}&nodeType=${JsParam.nodeType}&except=${JsParam.except}&isCycle=false&q.j_path=%2FmainApproval%2FmainMyTodo&q.docType=myApproval'}
            </ui:source>
            <list:colTable
                    url="${LUI_ContextPath}/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.imeeting.model.KmImeetingMain"
                    isDefault="true" layout="sys.ui.listview.columntable"
                    rowHref="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=view&fdId=!{fdId}"
                    name="columntable">
                <list:col-checkbox name="List_Selected"/>
                <list:col-serial title="${ lfn:message('page.serial')}"/>
                <list:col-auto/>
            </list:colTable>
        </list:listview>
        <list:paging/>

        <%@include file="/km/imeeting/km_imeeting_main/import/main_index_script.jsp" %>
    </template:replace>
</template:include>	
