<%--
  Created by IntelliJ IDEA.
  User: Butterball
  Date: 2021-10-21
  Time: 18:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil" %>
<%@ page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%
    pageContext.setAttribute("enableWpsCloud", new Boolean(ImissiveUtil.isEnableWpsCloud()));
    pageContext.setAttribute("enableWpsCenter", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
<c:set var="imissiveFormObj" value="${requestScope[param.imissiveFormName]}" />

<%-- WPS中台智能排版与撤销套红相关js --%>
<script type="text/javascript">
    // 主文档ID
    let entityId = "";
    // 公文域模型名称
    let entityName = "";
    // 请求URI
    let actionUri = "";
    // 公文类型 send | receive | sign
    let imissiveType = "";
    // 是否初始化标识
    let initFlag = false;

    /**
     * 初始化上述声明的变量
     */
    function init(type) {
        if (!initFlag && type) {
            switch (type) {
                case "send": {
                    entityName = "com.landray.kmss.km.imissive.model.KmImissiveSendMain";
                    actionUri = "${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do";
                    break;
                }
                case "receive": {
                    entityName = "com.landray.kmss.km.imissive.model.KmImissiveReceiveMain";
                    actionUri = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do";
                    break;
                }
                case "sign": {
                    entityName = "com.landray.kmss.km.imissive.model.KmImissiveSignMain";
                    actionUri = "${LUI_ContextPath}/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do";
                    break;
                }
            }
            entityId = $("input[name='fdId']").val();
            if (!entityId) {
                entityId = "${param.fdId}";
            }
            imissiveType = type;
            initFlag = true;
        }
    }

    /**
     * 检验当前用户是否展示撤回套红摁扭
     */
    function checkShowBtn() {
        // 暂存查看页不展示审批摁扭
        if ("${imissiveFormObj.method_GET}" === "view" && "${imissiveFormObj.docStatus}" === "10") {
            return false;
        }
        if ("${enableWpsCloud}" == "true" || "${enableWpsCenter}" == "true") {
            // 是否存在套红痕迹稿
            let existAttTrack = "false";
            $.ajax({
                url: actionUri + "?method=existAttTrack",
                data: {
                    fdModelName: entityName,
                    entityId: entityId,
                    fileType: '4'
                },
                async: false,
                success: function (res) {
                    existAttTrack = res;
                },
                error: function (res) {
                    // dialog.alert("获取");
                }
            });
            // 当前节点是否是套红节点
            let redHead = "${nodeExtAttributeMap['redhead4Draft'] == 'true' or nodeAdditionalMap['redhead'] == 'true' or nodeAdditionalMap['redhead'] == 'on' or imissiveFormObj.sysWfBusinessForm.fdNodeAdditionalInfo.redhead eq 'true'}";
            return existAttTrack === "true" && redHead === "true";
        } else {
            return false;
        }
    }

    $(document).ready(function () {
        let initImissiveType = "";
        switch ("${param.imissiveFormName}") {
            case "kmImissiveSendMainForm" : initImissiveType = "send"; break;
            case "kmImissiveReceiveMainForm" : initImissiveType = "receive"; break;
            case "kmImissiveSignMainForm" : initImissiveType = "sign";
        }
        if (initImissiveType) {
            init(initImissiveType);
            // 撤销套红摁扭
            if (checkShowBtn() && $('a#revokeRedHead').length == 0) {
                let btnText = '<a href="javascript:void(0);" class="revertOfficialSmart"' +
                    ' id="revokeRedHead" onclick="revokeContentChange(' +
                    '&quot;4&quot;,&quot;' + imissiveType + '&quot;)">撤销套红</a>';
                $('div#missiveButtonDiv').prepend(btnText);
            }
        }
        // 撤销智能排版摁扭
        /*let revokeOfficialBtnInfo = window.sessionStorage.getItem("revokeOfficialBtnInfo");
        if (revokeOfficialBtnInfo) {
            revokeOfficialBtnInfo = eval('(' + revokeOfficialBtnInfo + ')');
            if (revokeOfficialBtnInfo.showBtn && $('a#revertOfficialSmart').length == 0) {
                let btnText = '<a href="javascript:void(0);" class="revertOfficialSmart"' +
                    ' id="revertOfficialSmart" onclick="revokeContentChange(' +
                    '&quot;7&quot;,&quot;' + imissiveType + '&quot;)">撤销排版</a>';
                $('a#smartTypesettingBtn').before(btnText);
            }
        }*/
    })

    /**
     * 获取正文附件的fdKey
     */
    function getContentFdKey() {
        // docNeedContent 在引入该文件的jsp中定义
        return "${imissiveFormObj.fdNeedContent}" == "0" ? "mainonline" : "editonline";
    }

    /**
     * 获取文种
     */
    function getDocTypeName() {
        var fdDocType = $("span.fdDocTypeName_span").text();
        if (!fdDocType) {
            fdDocType = $("select[name='fdDocTypeId']").find("option:selected").text();
        }
        if (fdDocType) {
            // 去除转义符
            fdDocType = fdDocType.trim().replace(/[\'\"\\\/\b\f\n\r\t]/g, '');
            console.log(fdDocType);
            if (fdDocType == "==请选择==") {
                fdDocType = "";
            }
        }
        return fdDocType;
    }

    /**
     * 获取WPS对象
     */
    function getWpsObj(wpsType, fdKey) {
        if (!fdKey) {
            fdKey = getContentFdKey();
        }
        var resObj;
        if (wpsType == "center") {
            if (fdKey == "editonline") {
                resObj = wps_center_editonline;
            } else if (fdKey == "mainonline") {
                resObj = wps_center_mainonline;
            }
        } else if (wpsType == "cloud") {
            if (fdKey == "editonline") {
                resObj = wps_cloud_editonline;
            } else if (fdKey == "mainonline") {
                resObj = wps_cloud_mainonline;
            }
        }
        return resObj;
    }

    /**
     * 智能排版
     */
    function smartTypesetting(imissiveType, method_GET) {
        if (method_GET == 'add') {
            dialog.confirm("当前为起草节点，智能排版将自动对文档进行暂存，是否继续？", function(flag) {
                if (flag == true) {
                    if (imissiveType === "receive") {
                        // 是否是签收单转发文
                        let flag = "${not empty kmImissiveReceiveMainForm.fdDetailId or not empty param.fdReceiveId}";
                        if (flag == "true") {
                            saveReceive('saveDraft4OfficialSmart','true');
                        } else {
                            commitMethod('saveDraft4OfficialSmart','true');
                        }
                    } else {
                        redheadFlag = "true";
                        saveDraft4RedHead();
                    }
                } else {
                    return;
                }
            }, "warn");
        } else {
            init(imissiveType);
            // 排版前保存正文内容，否则排版内容会被覆盖
            let smartOfficialDtd = saveContentAttByWps("center");
            // WPS保存正文成功
            smartOfficialDtd.done(function (wpsObject) {
                // 获取文种，用于排版模板过滤
                let fdDocType = getDocTypeName();
                let jspUrl = Com_GetCurDnsHost() + Com_Parameter.ContextPath
                    + "km/imissive/import/wpsCenterOfficeSmart.jsp"
                    + "?fdDocType=" + encodeURIComponent(fdDocType);
                dialog.iframe(jspUrl, "智能排版模板选择", function (res) {
                    if (res) {
                        smartTypesettingExecutor(getContentFdKey(), res);
                    }
                }, {width: 380, height: 260});
            });
            // WPS保存正文失败
            smartOfficialDtd.fail(function (msg) {
                dialog.alert(msg);
            });
        }
    }

    /**
     * 智能排版执行器
     */
    function smartTypesettingExecutor(fdKey, preInstallTemplate) {
        var nodeName = "${nodevalue}";
        var url = actionUri + "?method=smartOfficial";
        $.ajax({
            url: url,
            async: false,    //用同步方式
            data: {
                fdKey: fdKey,
                fdModelId: entityId,
                fdModelName: entityName,
                nodeName: nodeName,
                preInstallTemplate: preInstallTemplate
            },
            success: function (data) {
                if (data) {
                    var res = eval('(' + data + ')');
                    seajs.use(['lui/jquery', 'lui/dialog'], function ($, dialog) {
                        var loading = dialog.loading("智能排版中，请稍候...");
                        setTimeout(function() {
                            wpsCenterSmartTypesettingResult(res);
                        }, 2000);

                        function wpsCenterSmartTypesettingResult(resData) {
                            if (resData && resData.success) {
                                var taskId = resData.taskId;
                                if (taskId) {
                                    getSmartOfficialRes(entityId, entityName, fdKey, taskId, loading);
                                } else {
                                    dialog.alert("排版失败" + resData.msg);
                                    loading.hide();
                                }
                            } else {
                                dialog.alert("排版失败" + resData.msg);
                                loading.hide();
                            }
                        }
                    });
                }
            }
        });
    }

    /**
     * 获取智能排版结果
     */
    function getSmartOfficialRes(fdModelId, fdModelName, fdKey, taskId, loading) {
        var getStreamUrl = actionUri + "?method=getSmartOfficialRes";
        setTimeout(function () {
            $.ajax({
                url: getStreamUrl,
                async: false,    //用同步方式
                data: {
                    taskId: taskId,
                    fdModelId: fdModelId,
                    fdModelName: fdModelName,
                    fdKey: fdKey
                },
                success: function (resData) {
                    var resData = eval('(' + resData + ')');
                    if (resData.success) {
                        dialog.alert("排版成功", function () {
                            var wesCenterObj = getWpsObj("center");
                            wesCenterObj.forceLoad = true;
                            wesCenterObj.load();
                            loading.hide();
                            if ($('a#revertOfficialSmart').length == 0) {
                                let btnText = '<a href="javascript:void(0);" class="revertOfficialSmart"' +
                                    ' id="revertOfficialSmart" onclick="revokeContentChange(' +
                                    '&quot;7&quot;,&quot;' + imissiveType + '&quot;)">撤销排版</a>';
                                $('a#smartTypesettingBtn').before(btnText);
                                // 用于刷新后页面还原撤销摁扭
                                let revokeBtnInfo = '{"showBtn":true,"imissiveType":"' + imissiveType + '"}';
                                window.sessionStorage.setItem("revokeOfficialBtnInfo", revokeBtnInfo);
                            }
                        });
                    } else {
                        getSmartOfficialRes(fdModelId, fdModelName, fdKey, taskId, loading);
                    }
                }
            });
        }, 1500)
    }

    /**
     * 撤销正文内容修改（如智能排版，套红等）
     * @param fdType KmImissiveAttTrack的 fileType
     * @param imissiveType 公文类型 send | receive | sign
     */
    function revokeContentChange(fdType, imissiveType) {
        // 初始化
        init(imissiveType);
        // WPS撤销前需要保存，保存方法需要处理异步问题
        let dtd;
        if ("${enableWpsCloud}" == "true") {
            dtd = saveContentAttByWps("cloud");
        } else if ("${enableWpsCenter}" == "true") {
            dtd = saveContentAttByWps("center");
        } else {
            // TODO 金格与加载项暂时不处理
            // revokeContentByJG();
            dialog.alert("目前仅支持WPS云文档和WPS中台撤销内容");
            return;
        }

        dtd.fail(function (msg) {
            dialog.alert(msg);
        });
        dtd.done(function (wpsObject) {
            revokeContentByWps(wpsObject, fdType);
        });
    }

    /**
     * 保存正文内容信息
     * @param wpsType WPS类型 center(中台) | cloud(云文档)
     * @returns $.Deferred对象
     */
    function saveContentAttByWps(wpsType) {
        var defer = $.Deferred();
        var wpsObject = getWpsObj(wpsType);
        if (wpsObject != null) {
            if (!wpsObject.hasLoad) {
                defer.reject("当前正文内容未加载，请切换到正文页签加载正文后操作！");
            }
            var savePromise = wpsObject.wpsObj.save();
            savePromise.then(function (rtn) {
                defer.resolve(wpsObject);
            });
        } else {
            defer.reject("WPS加载异常，操作失败！");
        }
        return defer;
    }

    /**
     * 撤销正文内容修改 WPS
     * @param wpsObject WPS对象
     * @param fdType KmImissiveAttTrack中的fileType
     */
    function revokeContentByWps(wpsObject, fdType) {
        let fdKey = getContentFdKey();
        let url = "/km/imissive/km_imissive_att_track/index_dialog_select.jsp?fdMainId="
            + entityId + "&fdType=" + fdType + "&fdModelName=" + entityName;
        dialog.iframe(url, '选择痕迹稿', function (fdTrackId) {
            if (fdTrackId) {
                let revertUrl = actionUri + "?method=revokeContentChange";
                let loading = dialog.loading("撤回智能排版中，请稍候...");
                $.ajax({
                    url: revertUrl,
                    data: {
                        fdModelName: entityName,
                        fdKey: fdKey,
                        fdTrackId: fdTrackId
                    },
                    async: false,
                    success: function (res) {
                        let resData = eval('(' + res + ')');
                        if (resData.success) {
                            if ("${_isWpsCenterEnable}" == "true") {
                                wpsObject.forceLoad = true;
                            }
                            wpsObject.load();
                        } else {
                            dialog.alert("撤销失败")
                        }
                        loading.hide();
                    },
                    error: function (res) {
                        loading.hide();
                        dialog.alert("撤销失败");
                    }
                });
            }
        }, {width: 950, height: 550})
    }

    function revokeContentByJG() {
        // TODO 金格撤销
    }
</script>
