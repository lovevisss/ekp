<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.third.ding.scenegroup.util.ThirdDingUtil" %>
    
        <%
            pageContext.setAttribute("currentPerson", UserUtil.getKMSSUser().getUserId());
        pageContext.setAttribute("currentPost", UserUtil.getKMSSUser().getPostIds());
        pageContext.setAttribute("currentDept", UserUtil.getKMSSUser().getDeptId());
        if(UserUtil.getUser().getFdParentOrg() != null) {
            pageContext.setAttribute("currentOrg", UserUtil.getUser().getFdParentOrg().getFdId());
        } else {
            pageContext.setAttribute("currentOrg", "");
        } %>
    
    <template:include ref="default.view">
        <template:replace name="head">
            <style type="text/css">
                
                			.lui_paragraph_title{
                				font-size: 15px;
                				color: #15a4fa;
                		    	padding: 15px 0px 5px 0px;
                			}
                			.lui_paragraph_title span{
                				display: inline-block;
                				margin: -2px 5px 0px 0px;
                			}
                			.inputsgl[readonly], .tb_normal .inputsgl[readonly] {
                			    border: 0px;
                			    color: #868686
                			}
                		
            </style>
            <script type="text/javascript">
                var formInitData = {

                };
                var messageInfo = {

                };
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>
        <template:replace name="title">
            <c:out value="${thirdDingScenegroupMappForm.fdName} - " />
            <c:out value="${ lfn:message('third-ding-scenegroup:table.thirdDingScenegroupMapp') }" />
        </template:replace>
        <template:replace name="toolbar">
            <script>
                function deleteDoc(delUrl) {
                    seajs.use(['lui/dialog'], function(dialog) {
                        dialog.confirm('${ lfn:message("page.comfirmDelete") }', function(isOk) {
                            if(isOk) {
                                Com_OpenWindow(delUrl, '_self');
                            }
                        });
                    });
                }

                function openWindowViaDynamicForm(popurl, params, target) {
                    var form = document.createElement('form');
                    if(form) {
                        try {
                            target = !target ? '_blank' : target;
                            form.style = "display:none;";
                            form.method = 'post';
                            form.action = popurl;
                            form.target = target;
                            if(params) {
                                for(var key in params) {
                                    var
                                    v = params[key];
                                    var vt = typeof
                                    v;
                                    var hdn = document.createElement('input');
                                    hdn.type = 'hidden';
                                    hdn.name = key;
                                    if(vt == 'string' || vt == 'boolean' || vt == 'number') {
                                        hdn.value =
                                        v +'';
                                    } else {
                                        if($.isArray(
                                            v)) {
                                            hdn.value =
                                            v.join(';');
                                        } else {
                                            hdn.value = toString(
                                                v);
                                        }
                                    }
                                    form.appendChild(hdn);
                                }
                            }
                            document.body.appendChild(form);
                            form.submit();
                        } finally {
                            document.body.removeChild(form);
                        }
                    }
                }

                function doCustomOpt(fdId, optCode) {
                    if(!fdId || !optCode) {
                        return;
                    }

                    if(viewOption.customOpts && viewOption.customOpts[optCode]) {
                        var param = {
                            "List_Selected_Count": 1
                        };
                        var argsObject = viewOption.customOpts[optCode];
                        if(argsObject.popup == 'true') {
                            var popurl = viewOption.contextPath + argsObject.popupUrl + '&fdId=' + fdId;
                            for(var arg in argsObject) {
                                param[arg] = argsObject[arg];
                            }
                            openWindowViaDynamicForm(popurl, param, '_self');
                            return;
                        }
                        var optAction = viewOption.contextPath + viewOption.basePath + '?method=' + optCode + '&fdId=' + fdId;
                        Com_OpenWindow(optAction, '_self');
                    }
                }
                window.doCustomOpt = doCustomOpt;
                var viewOption = {
                    contextPath: '${LUI_ContextPath}',
                    basePath: '/third/ding/scenegroup/third_ding_scenegroup_mapp/thirdDingScenegroupMapp.do',
                    customOpts: {

                        ____fork__: 0
                    }
                };

                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
            </script>
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">

                <!--edit-->
                <kmss:auth requestURL="/third/ding/scenegroup/third_ding_scenegroup_mapp/thirdDingScenegroupMapp.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('thirdDingScenegroupMapp.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
                <!--delete-->
                <kmss:auth requestURL="/third/ding/scenegroup/third_ding_scenegroup_mapp/thirdDingScenegroupMapp.do?method=delete&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('thirdDingScenegroupMapp.do?method=delete&fdId=${param.fdId}');" order="4" />
                </kmss:auth>
                <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />


            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('third-ding-scenegroup:table.thirdDingScenegroupMapp') }" href="/third/ding/scenegroup/third_ding_scenegroup_mapp/" target="_self" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">

            <ui:tabpage expand="false" var-navwidth="90%">
                <ui:content title="${ lfn:message('third-ding-scenegroup:py.JiBenXinXi') }" expand="true">
                    <div class='lui_form_title_frame'>
                        <div class='lui_form_subject'>
                            ${lfn:message('third-ding-scenegroup:table.thirdDingScenegroupMapp')}
                        </div>
                        <div class='lui_form_baseinfo'>

                        </div>
                    </div>
                    <table class="tb_normal" width="100%">
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.fdName')}
                            </td>
                            <td colspan="3" width="85.0%">
                                <%-- 群名称--%>
                                <div id="_xform_fdName" _xform_type="text">
                                    <xform:text property="fdName" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.fdModule')}
                            </td>
                            <td width="35%">
                                <%-- 所属模板--%>
                                <div id="_xform_fdModuleId" _xform_type="radio">
                                    <xform:select property="fdModuleId" htmlElementProperties="id='fdModuleId'" showStatus="view">
                                        <xform:beanDataSource serviceBean="thirdDingScenegroupModuleService" selectBlock="fdId,fdName" />
                                    </xform:select>
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.fdStatus')}
                            </td>
                            <td width="35%">
                                <%-- 群状态--%>
                                <div id="_xform_fdStatus" _xform_type="select">
                                    <xform:select property="fdStatus" htmlElementProperties="id='fdStatus'" showStatus="view">
                                        <xform:enumsDataSource enumsType="third_ding_group_status" />
                                    </xform:select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.fdSceneGroupId')}
                            </td>
                            <td width="35%">
                                <%-- 群ID--%>
                                <div id="_xform_fdSceneGroupId" _xform_type="text">
                                    <xform:text property="fdSceneGroupId" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.fdChatId')}
                            </td>
                            <td width="35%">
                                <%-- 群会话ID--%>
                                <div id="_xform_fdChatId" _xform_type="text">
                                    <xform:text property="fdChatId" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.fdModelName')}
                            </td>
                            <td width="35%">
                                <%-- model名称--%>
                                <div id="_xform_fdModelName" _xform_type="text">
                                    <xform:text property="fdModelName" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.fdModelId')}
                            </td>
                            <td width="35%">
                                <%-- model id--%>
                                <div id="_xform_fdModelId" _xform_type="text">
                                    <xform:text property="fdModelId" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.fdKey')}
                            </td>
                            <td width="35%">
                                <%-- 关键字--%>
                                <div id="_xform_fdKey" _xform_type="text">
                                    <xform:text property="fdKey" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.docCreator')}
                            </td>
                            <td width="35%">
                                <%-- 创建人--%>
                                <div id="_xform_docCreatorId" _xform_type="address">
                                    <ui:person personId="${thirdDingScenegroupMappForm.docCreatorId}" personName="${thirdDingScenegroupMappForm.docCreatorName}" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.docCreateTime')}
                            </td>
                            <td width="35%">
                                <%-- 创建时间--%>
                                <div id="_xform_docCreateTime" _xform_type="datetime">
                                    <xform:datetime property="docCreateTime" showStatus="view" dateTimeType="datetime" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('third-ding-scenegroup:thirdDingScenegroupMapp.docAlterTime')}
                            </td>
                            <td width="35%">
                                <%-- 更新时间--%>
                                <div id="_xform_docAlterTime" _xform_type="datetime">
                                    <xform:datetime property="docAlterTime" showStatus="view" dateTimeType="datetime" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </ui:content>
            </ui:tabpage>
        </template:replace>

    </template:include>