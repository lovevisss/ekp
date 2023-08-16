<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="default.simple" spa="true">
    <template:replace name="head">
    </template:replace>
    <template:replace name="body">
        <style>
            .km_att_track_select {
                text-align: center;
                border-top: solid 1px #797874;
                position: fixed;
                left: 0;
                right: 0;
                bottom: 0;
                padding: 10px 0px;
                background-color: #fff
            }
        </style>
        <script type="text/javascript">
            seajs.use(['theme!list']);
        </script>
        <list:criteria id="sendCriteria">
            <list:cri-ref key="fileName" ref="criterion.sys.docSubject" title="文件名称">
            </list:cri-ref>
        </list:criteria>
        <ui:fixed elem=".lui_list_operation"></ui:fixed>
        <list:listview id="listview_main">
            <ui:source type="AjaxJson">
                {"url":"/km/imissive/km_imissive_att_track/kmImissiveAttTrack.do?method=list&fdMainId=${param.fdMainId}&isRevokeDialog=1&fdType=${param.fdType}&fdModelName=${param.fdModelName}"}
            </ui:source>
            <list:colTable isDefault="false" layout="sys.ui.listview.columntable" onRowClick="selectStock('!{fdId}')"
                           name="columntable" channel="true">
                <list:col-html title="" headerStyle="width:10px;">
                    <!-- 设置复选框监听函数，用于限定单选 -->
                    {$
                    <input type="checkbox" onclick="selectMeeting(this);" name="List_Selected" value="{%row.fdId%}"/>
                    $}
                </list:col-html>
                <list:col-auto props="fdNodeName"></list:col-auto>
                <list:col-auto props="docCreator.fdName"></list:col-auto>
                <list:col-auto props="docCreateTime"></list:col-auto>
                <list:col-auto props="fileType"></list:col-auto>
                <list:col-auto props="fileName"></list:col-auto>
            </list:colTable>
        </list:listview>
        <list:paging></list:paging>

        <div style="height:50px"></div>
        <div class="km_att_track_select">
            <ui:button text="${lfn:message('button.ok')}" onclick="getReturnValue();" order="1"></ui:button>
            <ui:button text="${lfn:message('button.cancel')}" onclick="$dialog.hide();" order="1"></ui:button>
        </div>

        <script type="text/javascript">
            seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog', 'sys/attachment/sys_att_main/wps/oaassist/js/wps_utils.js'], function ($, strutil, dialog, wpsUtils) {

                // 查看痕迹稿
                window.openfile = function(fdId) {
                    if ('${wpsoaassist}'=="true" && '${_useWpsLinuxView}'!='true') {
                        let wpsParam = {};
                        wpsParam['wpsExtAppModel'] = "kmImissive";
                        wpsUtils.openWpsOAAssit(fdId, wpsParam);
                    } else {
                        let url="${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=view" +
                            "&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveAttTrack&fdSendId=" +
                            "${kmImissiveSendMainForm.fdId}&fdId=" + fdId + "&imissiveName=${param.fdModelName}&directPreview=1110110";
                        Com_OpenWindow(url, "_blank");
                    }
                }

                /* 点击row后，将之前的复选框取消勾选，并将新的复选框设置勾选 */
                window.selectStock = function (fdId) {
                    $('[name="List_Selected"]:checked').prop('checked', false)
                    if ($('[name="List_Selected"][value="' + fdId + '"]').prop('checked')) {
                        $('[name="List_Selected"][value="' + fdId + '"]').prop('checked', false);
                    } else {
                        $('[name="List_Selected"][value="' + fdId + '"]').prop('checked', true);
                    }
                };

                /* 点击复选框后，将之前的复选框取消勾选，并将新的复选框设置勾选 */
                window.selectMeeting = function (obj) {
                    var checks = document.getElementsByName("List_Selected");
                    for (var i = 0; i < checks.length; i++) {
                        if (checks[i].checked) {
                            $(checks[i]).prop('checked', false);
                        }
                    }
                    $(obj).prop('checked', true);
                }

                /* 设置回调的返回数据 */
                window.getReturnValue = function () {
                    let checks = document.getElementsByName("List_Selected");
                    let res = "";
                    let docSubject = "";
                    let selectedObj;
                    for (let i = 0; i < checks.length; i++) {
                        if (checks[i].checked) {
                            selectedObj = $(checks[i]).parent().parent().find("a.com_btn_link");
                            docSubject = selectedObj.text().trim();
                            res = checks[i].value;
                        }
                    }
                    console.log(selectedObj.parent().parent().find("a.com_btn_link"));
                    if (!res) {
                        dialog.alert('请选择痕迹稿!');
                        return;
                    } else {
                        let fileId = selectedObj.data("targetId");
                        dialog.confirm("当前选择为：" + docSubject + "，确认以该痕迹稿还原正文内容？", function (val) {
                            if (val) {
                                $dialog.hide(res);
                            }
                        });
                    }
                }
            });
        </script>
    </template:replace>
</template:include>