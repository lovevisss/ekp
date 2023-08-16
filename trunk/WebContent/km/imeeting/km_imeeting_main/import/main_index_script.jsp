<%--
  Created by IntelliJ IDEA.
  User: Butterball
  Date: 2021-8-16
  Time: 18:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<script type="text/javascript">
    var SYS_SEARCH_MODEL_NAME = "com.landray.kmss.km.imeeting.model.KmImeetingMain";

    seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog', 'lui/topic', 'lui/toolbar'], function ($, strutil, dialog, topic, toolbar) {
        var isFreshWithTemplate = false;
        LUI.ready(function () {
            if (getValueByHash("fdTemplate") != "") {
                isFreshWithTemplate = true;
            }
        });

        //根据地址获取key对应的筛选值
        var getValueByHash = function (key) {
            var hash = window.location.hash;

            if (hash.indexOf(key) < 0) {
                return "";
            }
            var url = hash.split("cri.q=")[1];
            var reg = new RegExp("(^|;)" + key + "%3A([^;]*)(;|$)");
            if (url.indexOf(":") > 0) {
                reg = new RegExp("(^|;)" + key + ":([^;]*)(;|$)");
            }
            var r = url.match(reg);
            if (r != null) {
                return unescape(r[2]);
            }
            return "";
        };

        // 监听新建更新等成功后刷新
        topic.subscribe('successReloadPage', function () {
            setTimeout(function () {
                topic.publish('list.refresh');
            }, 300);
        });

        //新建会议
        window.addDoc = function () {
            dialog.categoryForNewFile(
                'com.landray.kmss.km.imeeting.model.KmImeetingTemplate',
                '/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}', false, null, null, cateId);
        };

        var cateId = '', nodeType = '';
        window.delDoc = function (draft) {
            var values = [];
            $("input[name='List_Selected']:checked").each(function () {
                values.push($(this).val());
            });
            if (values.length == 0) {
                dialog.alert('<bean:message key="page.noSelect"/>');
                return;
            }
            var url = '${LUI_ContextPath }/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=deleteall';
            url = Com_SetUrlParameter(url, 'categoryId', cateId);
            url = Com_SetUrlParameter(url, 'nodeType', nodeType);
            if (draft == '0') {
                url = '${LUI_ContextPath }/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=deleteall&status=10';
            }
            var config = {
                url: url, // 删除数据的URL
                data: $.param({"List_Selected": values}, true), // 要删除的数据
                modelName: "com.landray.kmss.km.imeeting.model.KmImeetingMain" // 主要是判断此文档是否有部署软删除
            };

            // 通用删除方法
            function delCallback(data) {
                topic.publish("list.refresh");
                dialog.result(data);
            }

            Com_Delete(config, delCallback);

        };

        //分类转移
        window.chgSelect = function () {
            var values = [];
            $("input[name='List_Selected']:checked").each(function () {
                values.push($(this).val());
            });
            if (values.length == 0) {
                dialog.alert('<bean:message key="page.noSelect"/>');
                return;
            }
            var cfg = {
                'modelName': 'com.landray.kmss.km.imeeting.model.KmImeetingTemplate',
                'mulSelect': false,
                <%-- 如果用户有“分类权限扩充”角色，则允许转移到所有的分类 --%>
                <%
                    if(com.landray.kmss.util.UserUtil.checkRole("ROLE_KMIMEETING_OPTALL")) {
                %>
                'authType': '00',
                <%
                    } else {
                %>
                'authType': '01',
                <%
                    }
                %>
                'action': function (value, ____dialog) {
                    if (value && value.id) {
                        window.chg_load = dialog.loading();
                        $.post('<c:url value="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=changeTemplate"/>',
                            $.param({"List_Selected": values, "templateId": value.id}, true), function (data) {
                                if (window.chg_load != null)
                                    window.chg_load.hide();
                                if (data != null && data.status == true) {
                                    topic.publish("list.refresh");
                                    dialog.success('<bean:message key="return.optSuccess" />');
                                } else {
                                    dialog.failure('<bean:message key="return.optFailure" />');
                                }
                            }, 'json');
                    }
                }
            };
            dialog.category(cfg);
        };

        /*//删除
        window.delDoc = function(){
            var docCategory = getValueByHash("fdTemplate");

            var values = [];
            $("input[name='List_Selected']:checked").each(function(){
                values.push($(this).val());
            });
            if(values.length==0){
                dialog.alert('<bean:message key="page.noSelect"/>');
                return;
            }
            dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
                if(value==true){
                    window.del_load = dialog.loading();
                    $.post('<c:url value="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=deleteall&categoryId="/>'+docCategory+"nodeType=TEMPLATE",
                        $.param({"List_Selected":values},true),function(data){
                            if(window.del_load!=null)
                                window.del_load.hide();
                            if(data!=null && data.status==true){
                                topic.publish("list.refresh");
                                dialog.success('<bean:message key="return.optSuccess" />');
                            }else{
                                dialog.failure('<bean:message key="return.optFailure" />');
                            }
                        },'json');
                }
            });
        };*/

        var AuthCache = {};
        window.showButtons = function (cateId, nodeType) {
            if (AuthCache[cateId]) {
                if (AuthCache[cateId].delBtn) {
                    if (!LUI('del')) {
                        var delBtn = toolbar.buildButton({
                            id: 'del',
                            order: '2',
                            text: '${lfn:message("button.deleteall")}',
                            click: 'delDoc()'
                        });
                        LUI('Btntoolbar').addButton(delBtn);
                    }
                } else {
                    if (LUI('del')) {
                        LUI('Btntoolbar').removeButton(LUI('del'));
                        LUI('del').destroy();
                    }
                }
                if (AuthCache[cateId].chgCateBtn) {
                    if (!LUI('chgCate')) {
                        var chgCateBtn = toolbar.buildButton({
                            id: 'chgCate',
                            order: '2',
                            text: '${lfn:message("km-imeeting:kmImeeting.btn.translate")}',
                            click: 'chgSelect()'
                        });
                        LUI('Btntoolbar').addButton(chgCateBtn);
                    }
                } else {
                    if (LUI('chgCate')) {
                        LUI('Btntoolbar').removeButton(LUI('chgCate'));
                        LUI('chgCate').destroy();
                    }
                }
                //批量修改权限按钮
                if (AuthCache[cateId].changeRightBatchBtn) {
                    if (!LUI('docChangeRightBatch')) {
                        var changeRightBatchBtn = toolbar.buildButton({
                            id: 'docChangeRightBatch',
                            order: '4',
                            text: '${lfn:message("sys-right:right.button.changeRightBatch")}',
                            click: 'changeRightCheckSelect("' + cateId + '","' + nodeType + '")'
                        });
                        LUI('Btntoolbar').addButton(changeRightBatchBtn);
                    }
                } else {
                    if (LUI('docChangeRightBatch')) {
                        LUI('Btntoolbar').removeButton(LUI('docChangeRightBatch'));
                        LUI('docChangeRightBatch').destroy();
                    }
                }
            }
            if (AuthCache[cateId] == null) {
                var checkChgCateUrl = "/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=changeTemplate&categoryId=" + cateId + "&nodeType=" + nodeType;
                var checkDelUrl = "/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=deleteall&categoryId=" + cateId + "&nodeType=" + nodeType;
                var changeRightBatchUrl = "/sys/right/cchange_doc_right/cchange_doc_right.jsp?modelName=com.landray.kmss.km.imeeting.model.KmImeetingMain&categoryId=" + cateId + "&nodeType=" + nodeType;
                var data = new Array();
                data.push(["delBtn", checkDelUrl]);
                data.push(["chgCateBtn", checkChgCateUrl]);
                data.push(["changeRightBatchBtn", changeRightBatchUrl]);
                $.ajax({
                    url: "${LUI_ContextPath}/sys/authorization/SysAuthUrlCheckAction.do?method=checkUrlAuth",
                    dataType: "json",
                    type: "post",
                    data: {"data": LUI.stringify(data)},
                    async: false,
                    success: function (rtn) {
                        var btnInfo = {};
                        if (rtn.length > 0) {
                            for (var i = 0; i < rtn.length; i++) {
                                if (rtn[i]['delBtn'] == 'true') {
                                    btnInfo.delBtn = true;
                                    if (!LUI('del')) {
                                        var delBtn = toolbar.buildButton({
                                            id: 'del',
                                            order: '2',
                                            text: '${lfn:message("button.deleteall")}',
                                            click: 'delDoc()'
                                        });
                                        LUI('Btntoolbar').addButton(delBtn);
                                    }
                                }
                                if (rtn[i]['chgCateBtn'] == 'true') {
                                    btnInfo.chgCateBtn = true;
                                    if (!LUI('chgCate')) {
                                        var chgCateBtn = toolbar.buildButton({
                                            id: 'chgCate',
                                            order: '2',
                                            text: '${lfn:message("km-imeeting:kmImeeting.btn.translate")}',
                                            click: 'chgSelect()'
                                        });
                                        LUI('Btntoolbar').addButton(chgCateBtn);
                                    }
                                }
                                if (rtn[i]['changeRightBatchBtn'] == 'true') {
                                    btnInfo.changeRightBatchBtn = true;
                                    if (!LUI('docChangeRightBatch')) {
                                        var changeRightBatchBtn = toolbar.buildButton({
                                            id: 'docChangeRightBatch',
                                            order: '4',
                                            text: '${lfn:message("sys-right:right.button.changeRightBatch")}',
                                            click: 'changeRightCheckSelect("' + cateId + '","' + nodeType + '")'
                                        });
                                        LUI('Btntoolbar').addButton(changeRightBatchBtn);
                                    }
                                }
                            }
                        } else {
                            btnInfo.delBtn = false;
                            btnInfo.chgCateBtn = false;
                            if (LUI('del')) {
                                LUI('Btntoolbar').removeButton(LUI('del'));
                                LUI('del').destroy();
                            }
                            if (LUI('chgCate')) {
                                LUI('Btntoolbar').removeButton(LUI('chgCate'));
                                LUI('chgCate').destroy();
                            }
                            btnInfo.changeRightBatchBtn = false;
                            if (LUI('docChangeRightBatch')) {
                                LUI('Btntoolbar').removeButton(LUI('docChangeRightBatch'));
                                LUI('docChangeRightBatch').destroy();
                            }
                        }
                        AuthCache[cateId] = btnInfo;
                    }
                });
            }
        };
        window.removeDelBtn = function () {
            if (LUI('del')) {
                LUI('Btntoolbar').removeButton(LUI('del'));
                LUI('del').destroy();
            }
        };
        window.removeChgCateBtn = function () {
            if (LUI('chgCate')) {
                LUI('Btntoolbar').removeButton(LUI('chgCate'));
                LUI('chgCate').destroy();
            }
        };
        window.removeChangeRightBatchBtn = function () {
            if (LUI('docChangeRightBatch')) {
                LUI('Btntoolbar').removeButton(LUI('docChangeRightBatch'));
                LUI('docChangeRightBatch').destroy();
            }
        };

        <%
           request.setAttribute("admin",UserUtil.getKMSSUser().isAdmin());
        %>

        //根据筛选器分类异步校验权限
        topic.subscribe('criteria.spa.changed', function (evt) {
            if ("${admin}" == "false") {
                removeDelBtn();
                removeChgCateBtn();
                removeChangeRightBatchBtn();
            }
            //removeShowNumberBtn();
            var hasTemp = false;    //筛选器中是否包含模板筛选项
            //筛选器变化时清空分类和节点类型的值
            cateId = "";
            nodeType = "";
            for (var i = 0; i < evt['criterions'].length; i++) {
                //获取分类id和类型
                if (evt['criterions'][i].key == "fdTemplate") {
                    cateId = evt['criterions'][i].value[0];
                    nodeType = evt['criterions'][i].nodeType;
                    hasTemp = true;
                }
            }
            showButtons(cateId, nodeType);
            //筛选器全部清空的情况
            if (evt['criterions'].length == 0) {
                showButtons("", "");
            }
        });

        // 高级搜索展开
        window.expanded = function () {
            LUI('imeetingCriteria').expandCriterions(!LUI('imeetingCriteria').expand);
        };

        // 搜索
        window.doSearchAction = function (evt) {
            var topicEvent = {
                criterions: LUI("imeetingCriteria")._buildCriteriaSelectedValues(),
                query: []
            };
            var obj = {};
            var values = [];
            values.push(evt.searchText);
            obj.key = "docSubject";
            obj.value = values;
            topicEvent.criterions.push(obj);
            topic.publish("criteria.changed", topicEvent);
        };

        // 批量打印
        window.batchPrint = function () {
            var values = [];
            $("input[name='List_Selected']:checked").each(function () {
                values.push($(this).val());
            });
            if (values.length == 0) {
                dialog.alert('<bean:message key="page.noSelect"/>');
                return;
            }
            if (values.length > 50) {
                dialog.alert('<bean:message key="kmImeeting.print.hint" bundle="km-imeeting"/>');
                return;
            }
            var url = '<c:url value="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=printBatch"/>' + '&fdIds=' + values;
            Com_OpenWindow(url);
        };

    });
</script>

