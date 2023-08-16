<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ page import="com.landray.kmss.util.UserUtil" %>
<template:include ref="default.simple" spa="true">
    <template:replace name="body">
        <script type="text/javascript">
            seajs.use(['theme!list']);
        </script>
        <list:criteria id="topicCriteria" cfg-canExpand="false">
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
            <list:cri-ref key="docSubject" ref="criterion.sys.docSubject"/>
            <list:cri-ref ref="criterion.sys.simpleCategory" key="fdTopicCategory" multi="false"
                          title="${ lfn:message('km-imeeting:kmImeetingTopic.fdTopicCategory') }" expand="false">
                <list:varParams modelName="com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory"/>
            </list:cri-ref>
            <list:cri-auto modelName="com.landray.kmss.km.imeeting.model.KmImeetingTopic"
                           property="docCreateTime;fdIsAccept"/>
        </list:criteria>
        <div class="lui_list_operation">
            <div class="gkp_list_operation_item_l" style="float:left">
                <div style="display: inline-block;vertical-align: middle;">
                    <ui:toolbar count="5" id="Btntoolbar">
                        <%-- 批量打印 --%>
                        <kmss:authShow roles="ROLE_KMIMEETING_PRINT_BATCH">
                            <ui:button text="${lfn:message('km-imeeting:kmImeeting.btn.print.batch')}" id="batchPrint"
                                       onclick="batchPrint();" order="1"></ui:button>
                        </kmss:authShow>
                        <kmss:authShow roles="ROLE_KMIMEETING_TOPIC_TRANSPORT_EXPORT">
                            <ui:button text="${lfn:message('button.export')}" id="export"
                                       onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingTopic')"
                                       order="1"></ui:button>
                        </kmss:authShow>
                        <c:if test="${not empty JsParam.fdTemplateId}">
                            <kmss:auth
                                    requestURL="/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=add&fdTemplateId=${JsParam.fdTemplateId}">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="1"></ui:button>
                            </kmss:auth>
                        </c:if>
                        <c:if test="${empty JsParam.docCategoryId}">
                            <kmss:auth requestURL="/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="1"></ui:button>
                            </kmss:auth>
                        </c:if>
                        <kmss:auth requestURL="/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=deleteall">
                            <ui:button id="del" text="${lfn:message('button.deleteall')}" order="3"
                                       onclick="delDoc();"></ui:button>
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
        <ui:fixed elem=".lui_list_operation"></ui:fixed>
        <list:listview id="listview_topic">
            <ui:source type="AjaxJson">
                {url:'/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=list&q.docType=myDraft&q.j_path=%2Findex_myDraft'}
            </ui:source>
            <list:colTable
                    url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.imeeting.model.KmImeetingTopic"
                    isDefault="false" layout="sys.ui.listview.columntable"
                    rowHref="/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=view&fdId=!{fdId}"
                    name="columntable">
                <list:col-checkbox></list:col-checkbox>
                <list:col-serial></list:col-serial>
                <list:col-auto props=""></list:col-auto>
            </list:colTable>
        </list:listview>
        <list:paging></list:paging>

        <%@ include file="/km/imeeting/km_imeeting_topic/import/topic_index_script.jsp" %>
    </template:replace>
</template:include>