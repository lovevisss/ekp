<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: Butterball
  Date: 2021-9-8
  Time: 16:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
    request.setAttribute("templates", ImissiveUtil.getWpsCenterSmartOfficialTemplate());
%>
<template:include ref="default.simple" spa="true">
    <template:replace name="head">
        <script type="text/javascript">
            Com_IncludeFile('jquery.js');
        </script>
        <style type="text/css">
            .center-div {
                margin-top: 16px;
                padding: 5px 0 5px 25px;
                width: 93%;
            }
            input {
                width: 75%;
                height: 30px;
                padding-left: 10px!important;
                outline: none;
                border: 1px solid #999;
                border-radius: 4px;
            }
            ul {
                position: absolute;
                width: 78%;
                padding-top: 3px !important;
                color: #626675;
                background-color: #ffffff !important;
                line-height: 28px;
                position: relative;
                cursor: default;
                box-shadow: 0 2px 8px -2px rgba(0, 0, 0, .334);
                top: 2px;
                z-index: 9999999;
            }
            li {
                padding-left: 10px!important;
                padding: 3px;
                width: auto;
                background-color: white;
            }
            li.can-select {
                cursor: pointer;
            }
            #searcher-res li:hover {
                background: #F2F4F8;
            }
            #searcher-res li::marker {
                content: none;
            }
            .select-template-box {
                text-align: center;
                position: absolute;
                top: 100px;
                z-index: 1;
                left: 0;
                right: 0;
                margin-left: auto;
                margin-right: auto;
                width: 340px; /* 要设定宽度 */
            }
            .select-template-detail {
                position: relative;
            }
            .select-template-detail-btn {
                padding-bottom: 10px;
            }
        </style>
    </template:replace>

    <template:replace name="body">
        <div class="center-div">
            <input id="searcher-text" type="text" placeholder="请输入关键词（为空则搜索所有模板）" value="${param.fdDocType}" autocomplete="off">
            <ui:button text="搜索" id="searcher-btn" order="1"></ui:button>
            <ul id="searcher-res" style="display: none">
            </ul>
        </div>
        <div class="select-template-box">
            <div class="select-template-detail">
                <div class="select-template-detail-btn">
                    <span>所选模板：</span>
                    <input name="templateType" type="hidden">
                    <span class="template-type-res"></span>
                </div>
                <ui:button text="${lfn:message('button.ok')}" id="searcher-btn" order="1" onclick="getReturnValue();"></ui:button>
            </div>
        </div>
        <script type="text/javascript">
            /* 设置回调的返回数据 */
            window.getReturnValue = function(){
                var selectedVal = $("input[name='templateType']").val();
                if (!selectedVal) {
                    seajs.use(['lui/dialog'], function(dialog) {
                        dialog.alert('请选择模板!');
                    });
                    return;
                }
                $dialog.hide(selectedVal);
            };

            // 智能公文排版的预设模板
            var templates = eval('(' + '${templates}' + ')');
            // 无匹配模板时备用数组
            const noTemplate = [{"empty":"无匹配的模板"}];

            $(document).ready(function () {
                // 搜索摁扭
                var sBtn = document.getElementById("searcher-btn");
                // 搜索输入框
                var sText = document.getElementById("searcher-text");
                // 结果列表
                var sRes = document.getElementById("searcher-res");
                // 搜索框 JQ对象
                var searcher = $("#searcher-text");
                // 获取到稿纸的文种信息
                var fdDocType = "${param.fdDocType}".replace(/\s*/g, "");
                searcher.val(fdDocType);
                setTimeout(function () {
                    renderList(searchByRegExp(fdDocType, templates));
                }, 300);

                // 点击摁扭查询
                sBtn.addEventListener('click', function(){
                    var keyWord = sText.value;
                    var res = searchByRegExp(keyWord, templates);
                    renderList(res);
                }, false);

                // 敲击回车查询
                sText.addEventListener('keydown', function(e) {
                    if (e.keyCode === 13) {
                        var keyWord = sText.value;
                        var res = searchByRegExp(keyWord, templates);
                        renderList(res);
                    }
                }, false);

                /* ================ 监听输入框搜索 ================= */
                var searchLock = false;
                searcher.on('compositionstart', function () {
                    searchLock = true;
                });
                searcher.on('compositionend', function () {
                    searchLock = false;
                    var keyWord = sText.value;
                    var res = searchByRegExp(keyWord, templates);
                    renderList(res);
                });
                searcher.on('input', function () {
                    if (!searchLock) {
                        var keyWord = sText.value;
                        var res = searchByRegExp(keyWord, templates);
                        renderList(res);
                    }
                });
                /* ================ 监听输入框搜索 ================= */

                // 构建搜索结果
                function renderList(list) {
                    if (!(list instanceof Array)) {
                        return;
                    }
                    sRes.innerHTML = '';
                    var len = list.length;
                    var item = null;
                    for (var i=0; i < len; i++) {
                        for (var key in list[i]) {
                            item = document.createElement('li');
                            item.innerHTML = list[i][key];
                            if (key === "empty") {
                                item.className = "searcher-res-li";
                            } else {
                                item.className = "searcher-res-li can-select";
                                // 保存预设模板的code
                                $(item).attr("data-val", key);
                                // 设置所选模板的点击事件
                                item.onclick = function () {
                                    let itemName = $(this).text();
                                    searcher.val(itemName);
                                    $(".template-type-res").text(itemName);
                                    $("input[name='templateType']").val($(this).data("val"));
                                    $("#searcher-res").hide("normal");
                                }
                            }
                            sRes.appendChild(item);
                        }
                    }
                    $("#searcher-res").show("normal");
                }

                /**
                 * 模糊匹配模板
                 * @param keyWord 搜索关键字
                 * @param list WPS中台预设模板
                 */
                function searchByRegExp(keyWord, list){
                    if(!(list instanceof Array)){
                        return ;
                    }
                    var len = list.length;
                    var arr = [];
                    var reg = new RegExp('.*' + keyWord + '.*');
                    for (var i = 0; i < len; i++) {
                        for (var key in list[i]) {
                            // 如果字符串中不包含目标字符会返回-1
                            if (list[i][key].match(reg)) {
                                arr.push(list[i]);
                            }
                        }
                    }
                    if (arr.length === 0) {
                        arr = noTemplate;
                    }
                    return arr;
                }
            });
        </script>
    </template:replace>
</template:include>
<%--
<xform:simpleDataSource value="announcement_ds_ls1">通告（长署名）</xform:simpleDataSource>
<xform:simpleDataSource value="approval_ds_ss1">批复（短署名）</xform:simpleDataSource>
<xform:simpleDataSource value="blanktext">空白正文</xform:simpleDataSource>
<xform:simpleDataSource value="bulletin_ds_1seal">通报（1公章）</xform:simpleDataSource>
<xform:simpleDataSource value="communique_ds_ls1">公报（长署名）</xform:simpleDataSource>
<xform:simpleDataSource value="consult_us_5seals">请示（5公章）</xform:simpleDataSource>
<xform:simpleDataSource value="decision_ds_5seals">决定（5公章）</xform:simpleDataSource>
<xform:simpleDataSource value="letter">信函</xform:simpleDataSource>
<xform:simpleDataSource value="motion_us_ps">议案（签名章）</xform:simpleDataSource>
<xform:simpleDataSource value="notice_ds_ls1_ht">公告（长署名，带横排表格）</xform:simpleDataSource>
<xform:simpleDataSource value="notification_ds_ss1_atcm">通知（短署名，带附件）</xform:simpleDataSource>
<xform:simpleDataSource value="opinion_ds_ss1">意见（短署名）</xform:simpleDataSource>
<xform:simpleDataSource value="order">命令</xform:simpleDataSource>
<xform:simpleDataSource value="referral_us_1seal">请示（1公章）</xform:simpleDataSource>
<xform:simpleDataSource value="report_us_ls1">报告（长署名）</xform:simpleDataSource>
<xform:simpleDataSource value="report_us_ss1">报告（短署名）</xform:simpleDataSource>
<xform:simpleDataSource value="report_us_ss2">报告（短署名2个）</xform:simpleDataSource>
<xform:simpleDataSource value="resolution_ds_ss3">决议（短署名3个）</xform:simpleDataSource>
<xform:simpleDataSource value="summary">纪要</xform:simpleDataSource>
--%>