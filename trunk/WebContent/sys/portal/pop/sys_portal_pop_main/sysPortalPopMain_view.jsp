<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
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
        <c:out value="${sysPortalPopMainForm.docSubject} - " />
        <c:out value="${ lfn:message('sys-portal:table.sysPortalPopMain') }" />
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
                basePath: '/sys/portal/pop/sys_portal_pop_main/sysPortalPopMain.do',
                customOpts: {

                    ____fork__: 0
                }
            };

            Com_IncludeFile("security.js");
            Com_IncludeFile("domain.js");
        </script>
        <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">

            <!--edit-->
            <kmss:auth requestURL="/sys/portal/pop/sys_portal_pop_main/sysPortalPopMain.do?method=edit&fdId=${param.fdId}">
                <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('sysPortalPopMain.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
            </kmss:auth>
            <!--delete-->
            <kmss:auth requestURL="/sys/portal/pop/sys_portal_pop_main/sysPortalPopMain.do?method=delete&fdId=${param.fdId}">
                <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('sysPortalPopMain.do?method=delete&fdId=${param.fdId}');" order="4" />
            </kmss:auth>
            <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />


        </ui:toolbar>
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
            <ui:menu-item text="${ lfn:message('sys-portal:table.sysPortalPopMain') }" href="/sys/portal/pop/sys_portal_pop_main/" target="_self" />
        </ui:menu>
    </template:replace>
    <template:replace name="content">

        <ui:tabpage expand="false" var-navwidth="90%">
            <ui:content title="${ lfn:message('sys-portal:sysPortalPage.msg.baseInfo') }" expand="true">
                <table class="tb_normal" width="100%">
                    <tr>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('sys-portal:sysPortalPopMain.docSubject')}
                        </td>
                        <td width="85%" colspan="3">
                            <div id="_xform_docSubject" _xform_type="text">
                                <xform:text property="docSubject" showStatus="view" style="width:95%;" />
                            </div>
                        </td>
                    </tr>
                    <tr>
						<td class="td_normal_title" width="15%">
                            ${lfn:message('sys-portal:sysPortalPopMain.fdIsAvailable')}
                        </td>
                        <td width="35%">
                            <div id="_xform_fdIsAvailable" _xform_type="radio">
                                <xform:radio property="fdIsAvailable" htmlElementProperties="id='fdIsAvailable'" showStatus="view">
                                    <xform:enumsDataSource enumsType="common_yesno" />
                                </xform:radio>
                            </div>
                        </td>
                        
                        <td class="td_normal_title" width="15%">
							${lfn:message('sys-portal:sysPortalPopMain.fdCategory')}
						</td>
                        
                        <td width="35%">
							<xform:select property="fdCustomCategory" showPleaseSelect="false" showStatus="view">
								<xform:enumsDataSource enumsType="sys_portal_pop_main_custom_category" />
							</xform:select>
						</td>
                        
                        <!--  
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('sys-portal:sysPortalPopMain.fdCategory')}
                        </td>
                        <td width="35%">
                            <div id="_xform_fdCategoryId" _xform_type="dialog">
                                <xform:dialog propertyId="fdCategoryId" propertyName="fdCategoryName" showStatus="view" style="width:95%;">
                                    dialogSelect(false,'sys_portal_pop_category_selectCategory','fdCategoryId','fdCategoryName');
                                </xform:dialog>
                            </div>
                        </td>
                        -->
                    </tr>
                    
					<tr>
						<td colspan="4">
							<c:import url="/sys/portal/pop/import/designer.jsp" charEncoding="utf-8">
                    			<c:param name="content" value="${sysPortalPopMainForm.docContent }"></c:param>
                    			<c:param name="fdKey" value="attPortalPopMain"></c:param>
                    			<c:param name="formBeanName" value="sysPortalPopMainForm"></c:param>
                    			<c:param name="editable" value="false"></c:param>
                    		</c:import>
                    	</td>
					</tr>
                    
                    <!--  
                    <tr>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('sys-portal:sysPortalPopMain.docContent')}
                        </td>
                        <td colspan="3" width="85.0%">
                            <div id="_xform_docContent" _xform_type="rtf">
                                <xform:rtf property="docContent" showStatus="view" width="95%" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('sys-portal:sysPortalPopMain.fdLink')}
                        </td>
                        <td width="85%" colspan="3">
                            <div id="_xform_fdLink" _xform_type="text">
                                <xform:text property="fdLink" showStatus="view" style="width:95%;" />
                            </div>
                        </td>
                    </tr>
                    -->
					
					<tr>
						<td class="td_normal_title" width="15%">
							${lfn:message('sys-portal:sysPortalPopMain.fdMode')}
                        </td>
                        <td width="35%">
                          	<xform:radio property="fdMode" showStatus="view">
								<xform:enumsDataSource enumsType="sys_portal_pop_main_mode" />
                          	</xform:radio>
                        </td>
						<td class="td_normal_title" width="15%">
                           	${lfn:message('sys-portal:sysPortalPopMain.fdDuration')}
                       	</td>
                      	<td width="35%">
                         	<div id="_xform_fdDuration" _xform_type="text">
                             	<xform:text property="fdDuration" showStatus="view" style="width:95%;" />
                           	</div>
                      	</td>
                  	</tr>
                    
                    <tr>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('sys-portal:sysPortalPopMain.fdStartTime')}
                        </td>
                        <td width="35%">
                            <div id="_xform_fdStartTime" _xform_type="datetime">
                                <xform:datetime property="fdStartTime" dateTimeType="datetime" showStatus="view" style="width:95%;" />
                            </div>
                        </td>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('sys-portal:sysPortalPopMain.fdEndTime')}
                        </td>
                        <td width="35%">
                            <div id="_xform_fdEndTime" _xform_type="datetime">
                                <xform:datetime property="fdEndTime" dateTimeType="datetime" showStatus="view" style="width:95%;" />
                            </div>
                        </td>
                    </tr>


                    <tr>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('sys-portal:sysPortalPopMain.fdNotifiers')}
                        </td>
                        <td width="85%" colspan="3">
                            <div id="_xform_fdNotifierIds" _xform_type="address">
                                <xform:address propertyId="fdNotifierIds" propertyName="fdNotifierNames" mulSelect="true" orgType="ORG_TYPE_ALL" showStatus="view" style="width:95%;" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('sys-portal:sysPortalPopMain.docCreator')}
                        </td>
                        <td width="35%">
                            <div id="_xform_docCreatorId" _xform_type="address">
                                <ui:person personId="${sysPortalPopMainForm.docCreatorId}" personName="${sysPortalPopMainForm.docCreatorName}" />
                            </div>
                        </td>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('sys-portal:sysPortalPopMain.docCreateTime')}
                        </td>
                        <td width="35%">
                            <div id="_xform_docCreateTime" _xform_type="datetime">
                                <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                            </div>
                        </td>
                    </tr>
                    
                    <%-- 
                    <tr>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('sys-portal:sysPortalPopMain.authReaders')}
                        </td>
                        <td colspan="3" width="85.0%">
                            <div id="_xform_authReaderIds" _xform_type="address">
                                <xform:address propertyId="authReaderIds" propertyName="authReaderNames" mulSelect="true" orgType="ORG_TYPE_ALL" showStatus="view" textarea="true" style="width:95%;" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('sys-portal:sysPortalPopMain.authEditors')}
                        </td>
                        <td colspan="3" width="85.0%">
                            <div id="_xform_authEditorIds" _xform_type="address">
                                <xform:address propertyId="authEditorIds" propertyName="authEditorNames" mulSelect="true" orgType="ORG_TYPE_ALL" showStatus="view" textarea="true" style="width:95%;" />
                            </div>
                        </td>
                    </tr>
                    --%>
                </table>
            </ui:content>
        </ui:tabpage>
    </template:replace>

</template:include>