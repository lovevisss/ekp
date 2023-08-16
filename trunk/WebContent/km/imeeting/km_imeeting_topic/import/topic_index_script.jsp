<%--
  Created by IntelliJ IDEA.
  User: Butterball
  Date: 2021-8-16
  Time: 17:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<script type="text/javascript">
    var SYS_SEARCH_MODEL_NAME = "com.landray.kmss.km.imeeting.model.KmImeetingMain;com.landray.kmss.km.imeeting.model.KmImeetingSummary";

    seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog', 'lui/topic', 'lui/toolbar'], function ($, strutil, dialog, topic, toolbar) {

        //记录当前筛选器的分类（或模板）id和节点类型
        var cateId = "";
        var nodeType = "";

        // 监听新建更新等成功后刷新
        topic.subscribe('successReloadPage', function () {
            setTimeout(function () {
                topic.publish('list.refresh');
            }, 300);
        });


        var docCategoryId = '';

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
            }
            if (AuthCache[cateId] == null) {
                var checkDelUrl = "/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=deleteall&categoryId=" + cateId + "&nodeType=" + nodeType;
                var data = new Array();
                data.push(["delBtn", checkDelUrl]);
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
                            }
                        } else {
                            btnInfo.delBtn = false;
                            if (LUI('del')) {
                                LUI('Btntoolbar').removeButton(LUI('del'));
                                LUI('del').destroy();
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

        //根据筛选器分类异步校验权限
        topic.subscribe('criteria.spa.changed', function (evt) {
            if ("${admin}" == "false") {
                removeDelBtn();
            }
            var hasTemp = false;    //筛选器中是否包含模板筛选项
            var docStatus = "";    //记录筛选器中状态筛选项的值
            //筛选器变化时清空分类和节点类型的值
            docCategoryId = "";
            nodeType = "";
            for (var i = 0; i < evt['criterions'].length; i++) {
                //获取分类id和类型
                if (evt['criterions'][i].key == "fdTopicCategory") {
                    docCategoryId = evt['criterions'][i].value[0];
                    nodeType = evt['criterions'][i].nodeType;
                    hasTemp = true;
                }
            }

            //分类变化或者带有分类刷新
            showButtons(docCategoryId, nodeType);

            //筛选器全部清空的情况
            if (evt['criterions'].length == 0) {
                showButtons("", "");
            }
        });
        //新建
        window.addDoc = function () {
            dialog.simpleCategoryForNewFile(
                'com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory',
                '/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=add&fdTemplateId=!{id}', false, null, null, docCategoryId);
        };
        //删除回调
        window.delCallback = function (data) {
            if (window.del_load != null)
                window.del_load.hide();
            if (data != null && data.status == true) {
                topic.publish("list.refresh");
                dialog.success('<bean:message key="return.optSuccess" />');
            } else {
                dialog.failure('<bean:message key="return.optFailure" />');
            }
        };
        //删除
        window.delDoc = function () {
            var values = [];
            $("input[name='List_Selected']:checked").each(function () {
                values.push($(this).val());
            });
            if (values.length == 0) {
                dialog.alert('<bean:message key="page.noSelect"/>');
                return;
            }
            var config = {
                url: '${LUI_ContextPath}/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=deleteall&categoryId=' + docCategoryId, // 删除数据的URL
                data: $.param({"List_Selected": values}, true), // 要删除的数据
                modelName: "com.landray.kmss.km.imeeting.model.KmImeetingTopic"
            };
            // 通用删除方法
            Com_Delete(config, delCallback);
        };

        // 高级搜索展开
        window.expanded = function () {
            LUI('topicCriteria').expandCriterions(!(LUI('topicCriteria').expand));
        };

        // 搜索
        window.doSearchAction = function (evt) {
            var topicEvent = {
                criterions: LUI("topicCriteria")._buildCriteriaSelectedValues(),
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
            var url = '<c:url value="/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=printBatch"/>' + '&fdIds=' + values;
            Com_OpenWindow(url);
        };

    });
</script>