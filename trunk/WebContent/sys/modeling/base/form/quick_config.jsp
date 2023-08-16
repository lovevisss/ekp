<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="default.dialog">
    <template:replace name="head">
        <link type="text/css" rel="stylesheet"
              href="${KMSS_Parameter_ContextPath}sys/modeling/base/resources/css/modeling.css?s_cache=${LUI_Cache}"/>
        <link href="${KMSS_Parameter_ContextPath}sys/modeling/base/resources/css/common.css" rel="stylesheet">
        <link href="${LUI_ContextPath}/sys/modeling/base/resources/css/process.css" rel="stylesheet">
        <style>
            .icon {
                background: url(../resources/images/process/success@2x.png) no-repeat center;
                background-size: contain;
                width: 12px;
                height: 12px;
                position: absolute;
                margin-left: -17px;
                margin-top: 4px;
            }

            .success_save_tips {
                font-family: PingFangSC-Regular;
                font-size: 14px;
                color: #666666;
                display: inline-block;
                margin: 17px 0 0px 34px;
                padding-right: 10px;
                padding-left: 16px;
            }

            .config_content {
                margin-left: 20px;
                width: 720px;
                height: 73px;
                background: #F8F8F8;
                border-radius: 4px;
            }

            .format_select_content_left {
                display: inline-block;
                margin-left: 16px;
                margin-top: 14px;
            }

            .format_select_content_left p {
                width: 56px;
                height: 20px;
                font-family: PingFangSC-Medium;
                font-size: 14px;
                color: #000000;
                font-weight: 500;
            }

            .format_select_content_right {
                float: right;
                margin-top: 26px;
                margin-right: 16px;
                color: #4285F4;
                cursor: pointer;
            }

            .config_icon {
                background: url(../resources/images/config@2x.png) no-repeat center;
                background-size: contain;
                width: 50px;
                height: 18px;
                position: relative;
                margin-left: 66px;
                margin-top: -20px;
            }

            .desc {
                margin-top: 5px;
                color: #666666;
                max-width: 580px;
            }
        </style>
    </template:replace>
    <template:replace name="content">
        <div class="content" style="display: none">
            <div class="success_save_tips">
                <div class="icon"></div>
                <p>${lfn:message('sys-modeling-base:modeling.form.success.save.tips') }</p></div>
            <div style="padding-bottom:63px;height: 100%;box-sizing: border-box;">
                <table class="tb_simple formatSelectTab" width="98%" style="margin-top: 12px">
                    <tr>
                        <td>
                            <div class="config_content">
                                <div class="format_select_content_left">
                                    <div style="color: #000000;">${lfn:message('sys-modeling-base:table.modelingAppView') }</div>
                                    <div class="view_configured config_icon" style="display: none"></div>
                                    <div class="desc">${lfn:message('sys-modeling-base:modeling.form.view.desc') }</div>
                                </div>
                                <div class="format_select_content_right" style="display: none" onclick="myselfConfig('Fview_main')">
                                        ${lfn:message('sys-modeling-base:modeling.form.self.config') }
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="config_content">
                                <div style="display: inline-block;" class="format_select_content_left">
                                    <div style="color: #000000;">${lfn:message('sys-modeling-base:table.modelingCollectionView') }</div>
                                    <div class="listView_configured config_icon" style="display: none"></div>
                                    <div class="desc">${lfn:message('sys-modeling-base:modeling.form.listview.desc') }</div>
                                </div>

                                <div class="format_select_content_right" style="display: none" onclick="myselfConfig('Flistview_main')">
                                        ${lfn:message('sys-modeling-base:modeling.form.self.config') }
                                </div>
                            </div>
                        </td>
                    </tr>
                    <c:if test="${param.isFlow }">
                        <tr>
                            <td>
                                <div class="config_content">
                                    <div style="display: inline-block;" class="format_select_content_left">
                                        <div style="color: #000000;">${lfn:message('sys-modeling-base:modeling.model.frame.flow') }</div>
                                        <div class="flow_configured config_icon" style="display: none"></div>
                                        <div class="desc">${lfn:message('sys-modeling-base:modeling.form.flow.desc') }</div>
                                    </div>

                                    <div class="format_select_content_right" style="display: none" onclick="myselfConfig('Flbpm')">
                                            ${lfn:message('sys-modeling-base:modeling.form.self.config') }
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td>
                            <div class="config_content">
                                <div style="display: inline-block;" class="format_select_content_left">
                                    <div style="color: #000000;">${lfn:message('sys-modeling-base:modeling.app.businessAdministrator') }</div>
                                    <div class="admin_configured config_icon"
                                         style="margin-left: 80px;display: none"></div>
                                    <div class="desc">${lfn:message('sys-modeling-base:modeling.form.businessAdministrator.desc') }</div>
                                </div>

                                <div class="format_select_content_right" style="display: none" onclick="myselfConfig('Fbaseinfo')">
                                        ${lfn:message('sys-modeling-base:modeling.form.self.config') }
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="config_content">
                                <div style="display: inline-block;" class="format_select_content_left">
                                    <div style="color: #000000;">${lfn:message('sys-modeling-base:modeling.form.app.nav') }</div>
                                    <div class="appNav_configured config_icon" style="display: none"></div>
                                    <div class="desc">${lfn:message('sys-modeling-base:modeling.form.nav.desc') }</div>
                                </div>

                                <div class="format_select_content_right"style="display: none" onclick="myselfConfig('Fspace')">
                                        ${lfn:message('sys-modeling-base:modeling.form.self.config') }
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="toolbar-bottom">
                <c:if test="${param.type =='auto' }">
                    <ui:button text="${lfn:message('sys-modeling-base:modeling.form.system.config') }"
                               onclick="systemDefaultConfig();"/>
                    <ui:button styleClass="lui_toolbar_btn_gray"
                               text="${lfn:message('sys-modeling-base:modeling.form.unnecessary') }"
                               onclick="cancel();"/>
                </c:if>
                <c:if test="${param.type =='self' }">
                    <ui:button styleClass="lui_toolbar_btn_gray"
                               text="${lfn:message('sys-modeling-base:modeling.Cancel') }" onclick="cancel();"/>
                    <ui:button text="${lfn:message('sys-modeling-base:modeling.form.app.preview') }"
                               onclick="toAppHome();"/>
                </c:if>


            </div>
        </div>

        <script type="text/javascript">
            var fdId = "${param.fdId}";
            var fdAppId = "${param.fdAppId}";
            var isFlow = "${param.isFlow }";
            var type = "${param.type }";
            seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic', 'lui/util/str', 'lui/util/env'], function ($, dialog, topic, str, env) {
                function checkInit() {
                    var url = "<c:url value="/sys/modeling/base/modelingAppFlow.do" />?method=hasXForm&fdModelId=" + fdId;
                    $.ajax({
                        url: url,
                        type: "get",
                        async: false,
                        success: function (rtn) {
                            if (rtn.hasXForm === "true") {
                                $(".content").show();
                            } else {
                                var nurl = Com_Parameter.ContextPath + "sys/modeling/base/noxform/noxform.jsp?page=externalQuery";
                                window.location.href = nurl;
                            }
                        }
                    });
                };

                function checkIsConfig() {
                    var url = Com_Parameter.ContextPath + "sys/modeling/base/modelingAppModel.do?method=chickIsHaveConfig&fdModelId=" + fdId;
                    $.ajax({
                        url: url,
                        type: "get",
                        async: false,
                        success: function (haveConfig) {
                            console.log("haveConfig0", haveConfig);
                            if (haveConfig) {
                                if (haveConfig.view) {
                                    $(".view_configured").show();
                                }
                                if (haveConfig.collectionView) {
                                    $(".listView_configured").show();
                                }
                                if (haveConfig.appNav) {
                                    $(".appNav_configured").show();
                                }
                                if (haveConfig.admin) {
                                    $(".admin_configured").show();
                                }
                                if (haveConfig.flow) {
                                    $(".flow_configured").show();
                                }
                            }
                        }
                    });
                }

                checkInit();
                if (type === 'self') {
                    $(".format_select_content_right").show();
                    $(".success_save_tips").hide();
                    checkIsConfig();
                }
                window.doSubmit = function () {
                    $dialog.hide(selectedVal);
                };
                window.toAppHome = function () {
                    window.open(env.fn.formatUrl("/sys/modeling/main/index.jsp?fdAppId=" + fdAppId), "_blank");
                };
                window.myselfConfig = function (method) {
                    if (method === "Fspace" || method === "Fbaseinfo") {
                        var url = Com_Parameter.ContextPath + "sys/modeling/base/modelingApplication.do?method=appIndex&fdId=" + fdAppId + "#j_path=%2" + method;
                        Com_OpenWindow(url, "_blank");
                    } else {
                        var url = Com_Parameter.ContextPath + "sys/modeling/base/modelingAppModel.do?method=frame&fdId=" + fdId + "#j_path=%2" + method;
                        Com_OpenWindow(url, "_blank");
                    }
                };
                window.cancel = function () {
                    $dialog.hide(null);
                };

                window.systemDefaultConfig = function () {
                    var expprt_load = dialog.loading();
                    var url = Com_Parameter.ContextPath + "sys/modeling/base/modelingAppModel.do?method=saveSystemQuickConfig&fdIsNew=true&fdModelId=" + fdId;
                    $.ajax({
                        url: url,
                        type: "get",
                        success: function (result) {
                            if (result && result.status == '00') {
                                if (isFlow ==="true") {
                                    addFlowModel($(".content"), fdId, function (data) {
                                        if (data) {
                                            expprt_load.hide();
                                            location.href = Com_Parameter.ContextPath + 'sys/modeling/base/form/quickConfig_status.jsp?fdAppId=' + fdAppId + '&fdId=' + fdId + '&isFlow=' + isFlow + '&type=self';
                                        } else {
                                            dialog.failure("${lfn:message('sys-modeling-base:modeling.page.operation.failed') }");
                                        }
                                    })
                                } else {
                                    expprt_load.hide();
                                    location.href = Com_Parameter.ContextPath + 'sys/modeling/base/form/quickConfig_status.jsp?fdAppId=' + fdAppId + '&fdId=' + fdId + '&isFlow=' + isFlow + '&type=self';
                                }
                            } else {
                                expprt_load.hide();
                                dialog.failure("${lfn:message('sys-modeling-base:modeling.page.operation.failed') }");
                            }

                        }
                    });
                }

            });

            /**
             * 系统配置，新增流程模板的方法
             * @param $parentDom  父级页面的dom对象
             * @param modelId
             * @param roback
             */
            function addFlowModel($parentDom, modelId, rollback) {
                //创建iframe
                var $iframe = $('<iframe height="0" width="0" style="border:0"  src="${KMSS_Parameter_ContextPath }sys/modeling/base/modelingAppFlow.do?method=add&addType=system&fdModelId=' + modelId + '"></iframe>');
                //添加到父页面
                $parentDom.append($iframe);
                //监听iframe的加载完成事件
                $iframe.load(function () {
                    //找到body对象
                    var $iframeBody = $iframe.contents().find('body');
                    //判断流程名称的dom是否存在，不存在返回值应该是json
                    var $fdName = $iframeBody.find('input[name="fdName"]');
                    if ($fdName && $fdName.length > 0) {
                        var $fdName = $iframeBody.find('input[name="fdName"]');
                        $fdName.val("${lfn:message('sys-modeling-base:listview.default') }");
                        var $saveBtn = $iframeBody.find('[data-lui-type="lui/toolbar!Button"]');
                        $saveBtn.click();
                    } else {
                        var text = $iframeBody.text();
                        var json = $.parseJSON(text);
                        if (json && json.status) {
                            rollback(true)
                        } else {
                            rollback(false)
                        }
                        $iframe.remove();
                    }
                })
            }

        </script>
    </template:replace>
</template:include>