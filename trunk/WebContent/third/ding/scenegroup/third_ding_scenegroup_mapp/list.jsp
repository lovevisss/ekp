<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.third.ding.scenegroup.util.ThirdDingUtil" %>
    <template:include file="/sys/profile/resource/template/list.jsp">
        
        <template:replace name="content">
            <div style="margin:5px 10px;">
                <!-- 筛选 -->
                <list:criteria id="criteria1">
                    <list:cri-ref key="fdName" ref="criterion.sys.docSubject" title="${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.fdName')}" />
                    <list:cri-auto modelName="com.landray.kmss.third.ding.scenegroup.model.ThirdDingScenegroupMapp" property="fdSceneGroupId" />
                    <list:cri-auto modelName="com.landray.kmss.third.ding.scenegroup.model.ThirdDingScenegroupMapp" property="fdChatId" />
                    <list:cri-criterion title="${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.fdModule')}" key="fdModule" multi="false">
                        <list:box-select>
                            <list:item-select>
                                <ui:source type="Static">
                                    <%=ThirdDingUtil.buildCriteria( "thirdDingScenegroupModuleService", "thirdDingScenegroupModule.fdId,thirdDingScenegroupModule.fdName", null, null) %>
                                </ui:source>
                            </list:item-select>
                        </list:box-select>
                    </list:cri-criterion>
                </list:criteria>
                <!-- 操作 -->
                <div class="lui_list_operation">

                    <div style='color: #979797;float: left;padding-top:1px;'>
                        ${ lfn:message('list.orderType') }：
                    </div>
                    <div style="float:left">
                        <div style="display: inline-block;vertical-align: middle;">
                            <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                                <list:sort property="thirdDingScenegroupMapp.docCreateTime" text="${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.docCreateTime')}" group="sort.list" />
                                <list:sort property="thirdDingScenegroupMapp.fdStatus" text="${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.fdStatus')}" group="sort.list" />
                            </ui:toolbar>
                        </div>
                    </div>
                    <div style="float:left;">
                        <list:paging layout="sys.ui.paging.top" />
                    </div>
                    <div style="float:right">
                        <div style="display: inline-block;vertical-align: middle;">
                            <ui:toolbar count="3">

                                <kmss:auth requestURL="/third/ding/scenegroup/third_ding_scenegroup_mapp/thirdDingScenegroupMapp.do?method=add">
                                    <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                                </kmss:auth>
                                <kmss:auth requestURL="/third/ding/scenegroup/third_ding_scenegroup_mapp/thirdDingScenegroupMapp.do?method=deleteall">
                                    <c:set var="canDelete" value="true" />
                                </kmss:auth>
                                <!---->
                                <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
                            </ui:toolbar>
                        </div>
                    </div>
                </div>
                <ui:fixed elem=".lui_list_operation" />
                <!-- 列表 -->
                <list:listview id="listview">
                    <ui:source type="AjaxJson">
                        {url:appendQueryParameter('/third/ding/scenegroup/third_ding_scenegroup_mapp/thirdDingScenegroupMapp.do?method=data')}
                    </ui:source>
                    <!-- 列表视图 -->
                    <list:colTable isDefault="false" rowHref="/third/ding/scenegroup/third_ding_scenegroup_mapp/thirdDingScenegroupMapp.do?method=view&fdId=!{fdId}" name="columntable">
                        <list:col-checkbox />
                        <list:col-serial/>
                        <list:col-auto props="fdName;fdSceneGroupId;fdChatId;fdModule.name;fdStatus.name;docCreateTime" url="" /></list:colTable>
                </list:listview>
                <!-- 翻页 -->
                <list:paging />
            </div>
            <script>
                var listOption = {
                    contextPath: '${LUI_ContextPath}',
                    jPath: 'scenegroup_mapp',
                    modelName: 'com.landray.kmss.third.ding.scenegroup.model.ThirdDingScenegroupMapp',
                    templateName: '',
                    basePath: '/third/ding/scenegroup/third_ding_scenegroup_mapp/thirdDingScenegroupMapp.do',
                    canDelete: '${canDelete}',
                    mode: '',
                    templateService: '',
                    templateAlert: '${lfn:message("third-ding-scenegroup:treeModel.alert.templateAlert")}',
                    customOpts: {

                        ____fork__: 0
                    },
                    lang: {
                        noSelect: '${lfn:message("page.noSelect")}',
                        comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                    }

                };
                Com_IncludeFile("list.js", "${LUI_ContextPath}/third/ding/resource/js/", 'js', true);
            </script>
        </template:replace>
    </template:include>