<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ page import="com.landray.kmss.util.UserUtil" %>
<template:include ref="default.simple" spa="true">
    <template:replace name="head">
        <link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/resource/css/listview.css?s_cache=${MUI_Cache}"/>
    </template:replace>
    <template:replace name="body">
        <style>
            .km_imeeting_topic_select {
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
            <list:cri-ref key="docSubject" ref="criterion.sys.docSubject">
            </list:cri-ref>
            <list:tab-criterion title="" key="meetingStatus">
                <list:box-select>
                    <list:item-select id="status_for_imeeting" cfg-enable="true" type="lui/criteria/select_panel!TabCriterionSelectDatas">
                        <ui:source type="Static">
                            [
								{text:'${ lfn:message('km-imeeting:kmImeeting.status.publish.unHold') }', value:'unHold'}
								,{text:'${ lfn:message('km-imeeting:kmImeeting.status.publish.holding') }', value:'holding'}
								,{text:'${ lfn:message('km-imeeting:kmImeeting.status.publish.hold') }', value:'hold'}
                            ]
                        </ui:source>
                        <ui:event event="selectedChanged" args="evt">
                            var vals = evt.values;
                            if (vals.length > 0 && vals[0] != null) {
								LUI('status_for_fixed').setEnable(false);
							}
                            else {
								LUI('status_for_fixed').setEnable(true);
							}
                        </ui:event>
                    </list:item-select>
                </list:box-select>
            </list:tab-criterion>
            <list:cri-ref ref="criterion.sys.category" key="fdTemplate" multi="false" title="${ lfn:message('km-imeeting:table.kmImeetingTemplate') }" expand="false">
                <list:varParams modelName="com.landray.kmss.km.imeeting.model.KmImeetingTemplate"/>
            </list:cri-ref>
            <list:cri-auto modelName="com.landray.kmss.km.imeeting.model.KmImeetingMain" property="fdMeetingNum;fdHost;fdHoldDate"/>
        </list:criteria>
        <ui:fixed elem=".lui_list_operation"></ui:fixed>
        <list:listview id="listview_main">
            <ui:source type="AjaxJson">
                {url:'/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=list&isRelationDialog=0&isSummaryList=1'}
            </ui:source>
            <list:colTable isDefault="false" layout="sys.ui.listview.columntable" onRowClick="selectStock('!{fdId}')"
                           name="columntable" channel="true">
                <list:col-html title="" headerStyle="width:10px;">
                    <!-- 设置复选框监听函数，用于限定单选 -->
                    {$
                    <input type="checkbox" onclick="selectMeeting(this);" name="List_Selected" value="{%row.fdId%}"/>
                    $}
                </list:col-html>
                <list:col-serial></list:col-serial>
                <list:col-auto props=""></list:col-auto>
            </list:colTable>
        </list:listview>
        <list:paging></list:paging>

        <div style="height:50px"></div>
        <div class="km_imeeting_topic_select">
            <ui:button text="${lfn:message('button.ok')}" onclick="getReturnValue();" order="1"></ui:button>
            <ui:button text="${lfn:message('button.cancel')}" onclick="$dialog.hide();" order="1"></ui:button>
        </div>

        <script type="text/javascript">
            seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog', 'lui/topic', 'lui/toolbar'], function ($, strutil, dialog, topic, toolbar) {

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
                    var checks = document.getElementsByName("List_Selected");
                    var checksValue = "";
                    var returnObj = new Object();
                    for (var i = 0; i < checks.length; i++) {
                        if (checks[i].checked) {
                            var docSubject = $(checks[i]).parent().next().next().children().text();
                            var fdId = checks[i].value;
                            returnObj.fdId = fdId;
                            returnObj.docSubject = docSubject;
                        }
                    }
                    if (!returnObj) {
                        seajs.use(['lui/dialog'], function (dialog) {
                            dialog.alert('请选择会议通知!');
                        });
                        return;
                    }
                    $dialog.hide(returnObj);
                }
            });
        </script>
    </template:replace>
</template:include>