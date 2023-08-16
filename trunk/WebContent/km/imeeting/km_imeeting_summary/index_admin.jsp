<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="default.simple" spa="true">
    <template:replace name="head">
        <link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/resource/css/listview.css?s_cache=${MUI_Cache}"/>
    </template:replace>
    <template:replace name="body">
        <script type="text/javascript">
            seajs.use(['theme!list']);
        </script>
        <%-- 筛选器 --%>
        <list:criteria id="summaryCriteria" cfg-canExpand="false">

            <%-- 状态 --%>
            <list:tab-criterion title="" key="docStatus">
                <list:box-select>
                    <list:item-select cfg-enable="true" type="lui/criteria/select_panel!TabCriterionSelectDatas">
                        <ui:source type="Static">
                            [
                            {text:'${ lfn:message('status.draft')}', value:'10'},
                            {text:'${ lfn:message('status.examine')}',value:'20'},
                            {text:'${ lfn:message('km-imeeting:kmImeeting.status.refuse')}',value:'11'},
                            {text:'${ lfn:message('km-imeeting:kmImeeting.status.publish')}',value:'30'},
                            {text:'${ lfn:message('status.discard')}',value:'00'}
                            ]
                        </ui:source>
                    </list:item-select>
                </list:box-select>
            </list:tab-criterion>
            <list:cri-ref key="fdName" ref="criterion.sys.docSubject"> </list:cri-ref>
            <%-- 分类导航 --%>
            <list:cri-ref ref="criterion.sys.category" key="fdTemplate" multi="false"
                          title="${lfn:message('sys-category:menu.sysCategory.index') }" expand="false">
                <list:varParams modelName="com.landray.kmss.km.imeeting.model.KmImeetingTemplate"/>
            </list:cri-ref>
            <%-- 主持人、会议发起人、组织部门、召开时间 --%>
            <list:cri-auto modelName="com.landray.kmss.km.imeeting.model.KmImeetingSummary"
                           property="docCreator;fdHost;docCreateTime"/>
        </list:criteria>

        <!-- 操作 -->
        <div class="lui_list_operation">
            <div class="gkp_list_operation_item_l">
                <div style="display: inline-block;vertical-align: middle;">
                    <ui:toolbar count="8" id="Btntoolbar">
                        <%-- 批量打印 --%>
                        <kmss:authShow roles="ROLE_KMIMEETING_PRINT_BATCH">
                            <ui:button text="${lfn:message('km-imeeting:kmImeeting.btn.print.batch')}" id="batchPrint"
                                       onclick="batchPrint();" order="1"></ui:button>
                        </kmss:authShow>
                        <kmss:authShow roles="ROLE_KMIMEETING_TRANSPORT_EXPORT">
                            <ui:button text="${lfn:message('button.export')}" id="export"
                                       onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingSummary')"
                                       order="2"></ui:button>
                        </kmss:authShow>
                        <kmss:authShow roles="ROLE_KMIMEETING_SUMMARY_CREATE">
                            <ui:button title="${lfn:message('button.add')}" text="${lfn:message('button.add')}"
                                       onclick="addDoc()" order="2"
                                       cfg-if="param['j_path']!='/abandom/mySummary'"></ui:button>
                        </kmss:authShow>
                        <!-- 收藏 -->
                        <c:import url="/sys/bookmark/import/bookmark_bar_all.jsp" charEncoding="UTF-8">
                            <c:param name="fdTitleProName" value="fdName"/>
                            <c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary"/>
                        </c:import>
                        <!-- 修改权限 -->
                        <c:import url="/sys/right/import/cchange_doc_right_button.jsp" charEncoding="UTF-8">
                            <c:param name="modelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary"/>
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
        <ui:fixed elem=".lui_list_operation"></ui:fixed>
        <%-- 列表视图 --%>
        <list:listview id="listview">
            <ui:source type="AjaxJson">
                {url:'/km/imeeting/km_imeeting_summary/kmImeetingSummary.do?method=listChildren&categoryId=!{categoryId}&nodeType=!{nodeType}&q.j_path=%2Fdrafted%2FmySummary'}
            </ui:source>
            <list:colTable
                    url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.imeeting.model.KmImeetingSummary"
                    isDefault="true" layout="sys.ui.listview.columntable"
                    rowHref="/km/imeeting/km_imeeting_summary/kmImeetingSummary.do?method=view&fdId=!{fdId}"
                    name="columntable">
                <list:col-checkbox name="List_Selected"></list:col-checkbox>
                <list:col-serial title="${ lfn:message('page.serial')}"></list:col-serial>
                <list:col-auto></list:col-auto>
            </list:colTable>
        </list:listview>
        <list:paging></list:paging>

        <%@include file="/km/imeeting/km_imeeting_summary/import/summary_index_script.jsp" %>
    </template:replace>
</template:include>	
