<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<%@page import="com.landray.kmss.sys.modeling.base.util.SysModelingUtil" %>
<%@ page import="com.landray.kmss.sys.modeling.base.constant.ModelingAppVersionConstant" %>
<template:include ref="default.dialog">
    <template:replace name="head">
        <style type="text/css">
        </style>
    </template:replace>
    <template:replace name="content">
        <c:if test="${param.type=='0'}">
        <p class="txttitle" style="margin: 10px 0;"> 触发场景</p>
    </c:if>
        <c:if test="${param.type=='1'}">
            <p class="txttitle" style="margin: 10px 0;"> 触发动作</p>
        </c:if>
        <table class="tb_normal" width="98%">
                <%--            场景--%>
            <c:if test="${param.type=='0'}">
            <tr>
                <td colspan="4">

                    <div style="max-height: 270px; overflow-y: auto;">
                            <%--列表--%>
                        <list:listview id="listview" style="">
                            <ui:source type="AjaxJson">
                                {url:'/sys/modeling/base/sysModelingScenes.do?method=data&fdType=1&q.modelMain=${param.modelId}'}
                            </ui:source>
                            <list:colTable isDefault="false" onRowClick="selectRdmTask('!{fdId}','!{fdName}');"
                                           rowHref=""
                                           name="columntable">
                                <list:col-radio/>
                                <list:col-html title="名称">
                                    {$ <span data-id="{%row['fdId']%}_name"
                                             style="max-width: 500px; display: inline-block;">{%row['fdName']%}</span> $}
                                </list:col-html>
                                <list:col-html title="类型">
                                    {$ <span data-id="{%row['fdId']%}">{%row['fdType']%}</span> $}
                                </list:col-html>
                                <list:col-html title="创建者">
                                    {$ <span data-id="{%row['fdId']%}">{%row['docCreator.name']%}</span> $}
                                </list:col-html>
                                <list:col-html title="创建时间">
                                    {$ <span data-id="{%row['fdId']%}">{%row['docCreateTime']%}</span> $}
                                </list:col-html>
                            </list:colTable>
                        </list:listview>
                        <list:paging></list:paging>
                    </div>
                </td>
            </tr>
            </c:if>
                    <c:if test="${param.type=='1'}">
                <%--动作--%>
            <tr>
                <td colspan="4">

                    <div style="max-height: 270px; overflow-y: auto;">
                        <list:listview id="listview" style="">
                            <ui:source type="AjaxJson">
                                {url:'/sys/modeling/base/sysModelingBehavior.do?method=data&q.modelMain=${param.modelId}'}
                            </ui:source>
                            <list:colTable isDefault="false" onRowClick="selectRdmTask('!{fdId}','!{fdName}');"
                                           rowHref=""
                                           name="columntable">
                                <list:col-radio/>
                                <list:col-html title="名称">
                                    {$ <span data-id="{%row['fdId']%}_name"
                                             style="max-width: 500px; display: inline-block;">{%row['fdName']%}</span> $}
                                </list:col-html>
                                <list:col-html title="类型">
                                    {$ <span data-id="{%row['fdId']%}">{%row['fdType']%}</span> $}
                                </list:col-html>
                                <list:col-html title="创建者">
                                    {$ <span data-id="{%row['fdId']%}">{%row['docCreator.name']%}</span> $}
                                </list:col-html>
                                <list:col-html title="创建时间">
                                    {$ <span data-id="{%row['fdId']%}">{%row['docCreateTime']%}</span> $}
                                </list:col-html>
                            </list:colTable>
                        </list:listview>
                        <list:paging></list:paging>
                    </div>
                </td>
            </tr>
                    </c:if>
            <tr>
                <td colspan="4" style="text-align: center;">
                        <%--选择--%>
                    <ui:button text="${lfn:message('button.select')}" onclick="doSubmit();"/> <%--取消--%>
                    <ui:button text="${lfn:message('button.cancel') }" onclick="cancel();"/>
                </td>
            </tr>
        </table>

        <script type="text/javascript">
            /************ 模态窗口的兼容处理 start ****************/
            var dialogRtnValue = null;
            var dialogObject = null;
            var isOpenWindow = true;//弹出形式:弹窗or弹层
            if(window.showModalDialog && window.dialogArguments){
                dialogObject = window.dialogArguments;
            }else if(opener && opener.Com_Parameter.Dialog){
                dialogObject = opener.Com_Parameter.Dialog;
            }else{
                dialogObject = (Com_Parameter.top || window.top).Com_Parameter.Dialog;
                isOpenWindow = false;
            }
            if(dialogObject){
                Com_Parameter.XMLDebug = dialogObject.XMLDebug;
                var Data_XMLCatche = new Object();
            }
            Com_AddEventListener(window, "beforeunload", beforeClose);
            function dialogReturn(value){
                window.dialogRtnValue = $.extend(true, {}, value);//复制一份新数组,防止window.close时出现无法执行已释放的script代码
                if(isOpenWindow){
                    window.close();
                }else if(window.$dialog!=null){
                    dialogObject.rtnData = dialogRtnValue;
                    dialogObject.AfterShow();
                    $dialog.hide();
                }
            }

            function beforeClose(){
                dialogObject.rtnData = dialogRtnValue;
                dialogObject.AfterShow();
            }
            Com_SetWindowTitle(dialogObject.winTitle);

            /************ 模态窗口的兼容处理 start ****************/
            seajs
                .use(
                    ['lui/jquery', 'lui/dialog', 'lui/topic', 'lui/util/str'],
                    function ($, dialog, topic, str) {
                        var selected = {}
                        window.selectRdmTask = function (fdId, fdName) {
                            selected = {
                                "fdId": fdId,
                                "fdName": fdName
                            }
                            if ($('[name="List_Selected"][value="' + fdId + '"]').is(':checked')) {
                                $('[name="List_Selected"][value="' + fdId + '"]').prop('checked', false);
                            } else {
                                $('[name="List_Selected"][value="' + fdId + '"]').prop('checked', true);
                            }
                        }
                        window.doSubmit = function(){
                            // var wgt = LUI("stepDialog");
                            // if(!wgt.validateData()){
                            //     dialog.alert("请先选择数据！");
                            //     return;
                            // }
                            //var rtn = wgt.getKeyData();
                            dialogReturn({
                                data : selected
                            });
                        }
                        // window.doSubmit = function () {
                        //     var fdId = $('[name="List_Selected"]:checked').val();
                        //     $dialog.hide(selected);
                        // };

                        window.cancel = function () {
                            $dialog.hide(null);
                        }

                    });
        </script>
    </template:replace>
</template:include>