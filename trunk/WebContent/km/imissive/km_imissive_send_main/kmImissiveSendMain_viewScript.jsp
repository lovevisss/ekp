<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ page import="com.landray.kmss.util.UserUtil" %>
<%@ page import="com.landray.kmss.util.DateUtil" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil" %>
<%@ include file="/km/imissive/cookieUtil_script.jsp" %>
<%@ include file="/km/imissive/kmImissiveReg_script.jsp" %>
<%-- WPS中台和撤回套红操作JS --%>
<jsp:include page="/km/imissive/wps/kmImissive_wpsCenter_script.jsp">
    <jsp:param name="imissiveFormName" value="kmImissiveSendMainForm"/>
</jsp:include>
<c:set var="xinChuangWps" value="<%=ImissiveUtil.isWPSOAassistEmbed(request)%>"/>

<script>
    Com_IncludeFile("att_dynamic.js", "${KMSS_Parameter_ContextPath}km/imissive/", "js", true);
    Com_IncludeFile("jquery.js|docutil.js");
    Com_IncludeFile("unitDialog.js", Com_Parameter.ContextPath + "km/imissive/resource/js/", "js", true);
    Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath + "sys/unit/resource/js/", "js", true);
</script>
<script>
    $KMSSValidation(document.forms['kmImissiveSendMainForm']);

    var subject = "${kmImissiveSendMainForm.docSubjectBak}";
    subject = subject.replace("&#039;", "'").replace("&#034;", "\"").replace("%5C", "\\").replace(/&#013;/g, "\r").replace(/&#010;/g, "\n");

    seajs.use(['sys/ui/js/dialog'], function (dialog) {
        window.dialog = dialog;
    });

    seajs.use(['lui/topic'], function (topic) {
        topic.subscribe('/sys/attachment/wpsCloud/loaded', function (obj) {
            if (obj) {
                var officeIframeh = "560";
                if ($('.content').length > 0) {
                    var contentH = $('.content').height();
                    officeIframeh = contentH - 70;
                }
                obj.iframe.style.height = officeIframeh + "px";
            }
        });

        topic.subscribe('/sys/attachment/wpsCenter/loaded', function (obj) {
            if (obj) {
                if ($('.content').length > 0) {
                    var contentH = $('.content').height();
                    obj.iframe.style.height = (contentH - 110) + "px";
                } else {
                    obj.iframe.style.height = "560px";
                }
            }
        });
    });

    seajs.use(['lui/jquery', 'lui/dialog'], function ($, dialog) {
        window.ofdSursen = function (key) {
            var convertId = "";
            if ('${convertAttType}' == 'toOFD') {
                convertId = '${convertAttId}';
            }
            var url = Com_Parameter.ContextPath + "km/imissive/km_imissive_main/kmImissiveMain.do?method=existSursenSignFile";
            $.ajax({
                url: url,
                type: 'post',
                data: {
                    "fdId": "${param.fdId}",
                    "contentKey": key,
                    "modelName": "com.landray.kmss.km.imissive.model.KmImissiveSendMain",
                    "convertId": convertId
                },
                async: false,
                dataType: "json",
                error: function () {
                    dialog.alert('请求出错');
                },
                success: function (data) {
                    if (data) {
                        var result = data['result'];
                        if (result == 'true') {
                            var restDownloadUrl = data['restDownloadUrl'];
                            console.log(restDownloadUrl);
                            var openUrl = "${LUI_ContextPath}/km/imissive/km_imissive_sign/sursenSign/kmImissiveMain_sursenSign.jsp?fdId=${param.fdId}" +
                                "&filePath=" + encodeURIComponent(restDownloadUrl) +
                                "&fdKey=" + key +
                                "&fdUserId=<%=UserUtil.getUser().getFdId()%>" +
                                "&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain";
                            window.open(openUrl, '_self');
                        } else {
                            dialog.alert('文件未转换');
                        }
                    }
                }
            });
        }
        window.yqq = function (key) {
            var fileTypeUrl = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=validateFileType&signId=${param.fdId}";
            var queryStatusUrl = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryStatus&signId=${param.fdId}";
            var validateOnceUrl = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=validateOnce&signId=${param.fdId}";
            $.ajax({
                url: fileTypeUrl,
                type: 'post',
                data: {},
                dataType: 'text',
                async: true,
                error: function () {
                    dialog.alert('请求出错');
                },
                success: function (data) {
                    if (data == "true") {
                        $.ajax({
                            url: queryStatusUrl,
                            type: 'post',
                            data: {},
                            dataType: 'text',
                            async: true,
                            error: function () {
                                dialog.alert('请求出错');
                            },
                            success: function (data) {
                                if (data == "false") {
                                    $.ajax({
                                        url: validateOnceUrl,
                                        type: 'post',
                                        data: {},
                                        dataType: 'text',
                                        async: true,
                                        error: function () {
                                            dialog.alert('请求出错');
                                        },
                                        success: function (data) {
                                            if (data == "true") {
                                                dialog.alert("当前发文已经发送过易企签签署，整个签署事件未完成，请等待完成后在发起签署！！");
                                            } else {
                                                var obj_ = document.getElementById("JGWebOffice_" + key);
                                                if (obj_) {
                                                    if (Attachment_ObjectInfo[key]) {
                                                        if (Attachment_ObjectInfo[key].ocxObj) {
                                                            var rFlag = Attachment_ObjectInfo[key].ocxObj.WebSave();
                                                            if (rFlag) {
                                                                var infoUrl = "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=openYqqExtendInfo&signId=${param.fdId}";
                                                                var extendIframe = dialog.iframe(infoUrl, "签署平台签署", null, {
                                                                    width: 1200,
                                                                    height: 600,
                                                                    topWin: window,
                                                                    close: true
                                                                });
                                                            }
                                                        }
                                                    }
                                                } else {
                                                    var infoUrl = "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=openYqqExtendInfo&signId=${param.fdId}";
                                                    var extendIframe = dialog.iframe(infoUrl, "签署平台签署", null, {
                                                        width: 1200,
                                                        height: 600,
                                                        topWin: window,
                                                        close: true
                                                    });
                                                }
                                            }
                                        }
                                    });
                                } else {
                                    var extendIframe = dialog.iframe(data, "签署平台签署", null, {
                                        width: 1200,
                                        height: 600,
                                        topWin: window,
                                        close: true
                                    });
                                }
                            }
                        });
                    } else {
                        dialog.alert("易企签不支持该文件类型(" + data + ")签署，请上传以下文件类型(.pdf;.doc;.xls;.ppt;.docx;.xlsx;.pptx;.jpg;.jpeg;.png;)");
                    }
                }
            });

        }

        window.convertFileType = function (fileType) {
            var attKey = '${contentKey}';
            var attShowType = '${attShowType}';
            var editStatus = '${editStatus}';
            if ('0' == attShowType && 'true' == editStatus) {
                var obj_ = document.getElementById("JGWebOffice_" + attKey);
                if (obj_) {
                    var saveA = document.getElementsByName(attKey + "_saveDraft")[0];
                    if (saveA != null && saveA != undefined) {
                        saveA.click();
                        convertFile(fileType);
                    }
                } else {
                    dialog.alert("金格控件加载异常，操作失败！");
                }
            } else if ('1' == attShowType && 'true' == editStatus) {
                var wpsObject;
                if (attKey == 'editonline' && wps_cloud_editonline) {
                    wpsObject = wps_cloud_editonline;
                }
                if (attKey == 'mainonline' && wps_cloud_mainonline) {
                    wpsObject = wps_cloud_mainonline;
                }
                if (wpsObject) {
                    if (!wpsObject.hasLoad) {
                        dialog.alert("当前正文内容未加载，请切换到正文页签加载正文后操作！");
                        return;
                    }
                    var savePromise = wpsObject.wpsObj.save();
                    savePromise.then(function (rtn) {
                        convertFile(fileType);
                    });
                } else {
                    dialog.alert("wps加载异常，操作失败！");
                }
            } else {
                convertFile(fileType);
            }
        }

        function convertFile(fileType) {
            var url = Com_Parameter.ContextPath + "km/imissive/km_imissive_main/kmImissiveMain.do?method=convertTypeInfo";
            $.ajax({
                url: url,
                type: 'post',
                data: {
                    "fdMainId": "${param.fdId}",
                    "converterKey": fileType,
                    "modelKey": "com.landray.kmss.km.imissive.model.KmImissiveSendMain",
                    "fdKey": "${contentKey}"
                },
                dataType: 'text',
                async: false,
                dataType: "json",
                error: function () {
                    dialog.alert('请求出错');
                },
                success: function (data) {
                    if (data) {
                        var convertStatus = data['convertStatus'];
                        var resultMsg = data['resultMsg'];
                        switch (convertStatus) {
                            case "200":
                                dialog.alert(resultMsg);
                                window.parent.location.reload();
                                break;
                            default:
                                dialog.alert(resultMsg);
                                break;
                        }
                    }
                }
            });
        }

        window.eqb = function (signType) {
            var url = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=";
            var attQueryData = {};
            if ("PDF" == signType) {
                url += "queryCfcaStatusPdf";
                attQueryData['fdId'] = "${param.fdId}";
                attQueryData['fdName'] = "send";
                attQueryData['signFalg'] = "eqb";
                signType = "PDF";
            } else if ("OFD" == signType) {
                url += "queryContentAttOfdDone";
                attQueryData['fdModelId'] = "${param.fdId}";
                attQueryData['fdModelName'] = "com.landray.kmss.km.imissive.model.KmImissiveSendMain";
            }
            var validateOnceUrl = Com_Parameter.ContextPath +
                "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=validateSignOnce";
            $.ajax({
                url: validateOnceUrl,
                type: 'post',
                data: {signId: "${param.fdId}", getSignUrl: "true", signatoryType: "eqb"},
                dataType: 'text',
                async: true,
                error: function () {
                    dialog.alert('请求出错');
                },
                success: function (data) {
                    data = eval('(' + data + ')');
                    console.log("validator", data);
                    if (data.isSign == "true") {
                        if (data.signUrl) {
                            confirmOpenSignPage("当前发文已经发送过e签宝签署，整个签署事件未完成，是否跳转到签署页面？", data.signUrl);
                        } else {
                            dialog.alert("当前发文已经发送过e签宝签署，整个签署事件未完成，请等待完成后在发起签署。");
                        }
                    } else if (data.isSign == "saas" && data.signUrl == "SaasFalse") {
                        dialog.alert("当前发文已经发送过e签宝签署，整个签署事件未完成，请完成后在发起签署。");
                    } else {
                        $.ajax({
                            url: url,
                            type: 'post',
                            data: attQueryData,
                            dataType: 'text',
                            async: false,
                            dataType: "json",
                            error: function () {
                                dialog.alert('请求出错');
                            },
                            success: function (data) {
                                if (data == true) {
                                    var signLoading = dialog.loading();
                                    var url = Com_Parameter.ContextPath +
                                        "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=sendEqb";

                                    $.ajax({
                                        url: url,
                                        type: 'post',
                                        data: JSON.stringify(buildEqbInfo(signType)),
                                        contentType: "application/json;charset=UTF-8",
                                        dataType: "json",
                                        async: true,
                                        error: function () {
                                            signLoading.hide();
                                            dialog.alert("发送失败，请确认是否重复发送。");
                                        },
                                        success: function (data) {
                                            console.log("sendData: ", data);
                                            signLoading.hide();
                                            if (data.code == '0000') {
                                                if (data.data.signatories[0]) {
                                                    var signUrl = data.data.signatories[0].signUrl;
                                                    if (signUrl) {
                                                        confirmOpenSignPage("签署发送成功，是否立即跳转到签署页面，以免错过签署期限？", signUrl);
                                                    }
                                                } else {
                                                    dialog.alert("签署发送成功，请立即前往到签署页面，以免错过签署期限");
                                                }
                                            } else {
                                                dialog.alert("发送签署失败:" + data.desc);
                                                if (btn) {
                                                    btn.setDisabled(false);
                                                }
                                            }
                                        }
                                    });
                                } else {
                                    var tipStr = "当前PDF文件未转换成功，无法进行签署!";
                                    if ("OFD" == signType) {
                                        tipStr = "当前OFD文件未转换成功，无法进行签署!";
                                    }
                                    dialog.alert(tipStr);
                                }
                            }
                        });
                    }
                }
            });
        };

        /**
         * 确认是否跳转到签署页面
         */
        function confirmOpenSignPage(tipText, signUrl) {
            dialog.confirm(tipText, function (value) {
                if (value) {
                    Com_OpenWindow(signUrl, "_blank");
                    setTimeout(function () {
                        dialog.confirm("是否已经完成签署？", function (confirmVal) {
                            if (confirmVal) {
                                window.location.reload();
                            }
                        })
                    }, 1000)
                }
            });
        }

        /**
         * 构建e签宝签署信息
         */
        function buildEqbInfo(signType) {
            var signData = {};
            var our = {};

            signData['signId'] = '${param.fdId}';
            signData['applyId'] = '${kmImissiveSendMainForm.fdId}';
            // contractNo由后台生成UUID设值
            signData['contractNo'] = '';
            // signData['contractName'] = 'com.landray.kmss.km.imissive.model.KmImissiveSendMain';
            signData['contractName'] = subject;
            signData['signType'] = signType;
            signData['missiveName'] = 'com.landray.kmss.km.imissive.model.KmImissiveSendMain';
            signData['convertId'] = '${convertAttId}';
            signData['convertType'] = '${convertAttType}';

            //信息
            our['enterPriseName'] = subject; //名称
            //our['enterPriseMan']='${loginName}';//联系人
            our['enterPrisePhone'] = '${mobileNo}' //联系电话
            our['enterPriseManNo'] = '${fdCertNo}'//证件号
            our['enterPriseManType'] = '${fdCertType}'//证件类型

            //绑定
            our['bindOrgId'] = '${contentKey}'; //fdKey
            our['bindSignerName'] = '${loginName}'; //签署人
            our['enterpriseId'] = '${enterpriseId}'; //企业Id
            signData['ourInfo'] = our;
            return signData;
        }

        window.cfca = function () {
            //判断当前任务是否已完成
            var url = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryCfcaFinish";
            $.ajax({
                url: url,
                type: 'post',
                data: {"signId": "${param.fdId}"},
                dataType: 'text',
                async: false,
                dataType: "json",
                error: function () {
                    dialog.alert('请求出错');
                },
                success: function (data) {
                    if (data == true) {
                        dialog.alert("当前签署任务已完成，无法进行签署!");
                    } else {
                        //判断当前主文档是否有正文
                        var url = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryCfcaNeedContent";
                        $.ajax({
                            url: url,
                            type: 'post',
                            data: {"taskId": "${param.fdId}", "taskName": "send"},
                            dataType: 'text',
                            async: false,
                            dataType: "json",
                            error: function () {
                                dialog.alert('请求出错');
                            },
                            success: function (data) {
                                if (data == true) {
                                    var url = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryCfcaStatusPdf";
                                    $.ajax({
                                        url: url,
                                        type: 'post',
                                        data: {"fdId": "${param.fdId}", "fdName": "send"},
                                        dataType: 'text',
                                        async: false,
                                        dataType: "json",
                                        error: function () {
                                            dialog.alert('请求出错');
                                        },
                                        success: function (data) {
                                            if (data == true) {
                                                var infoUrl = "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=openYqqExtendInfo&signId=${param.fdId}&signFlag=cfca";
                                                var extendIframe = dialog.iframe(infoUrl, "签署平台签署", null, {
                                                    width: 1200,
                                                    height: 600,
                                                    topWin: window,
                                                    close: true
                                                });
                                            } else {
                                                dialog.alert("当前PDF文件未转换成功，无法进行签署!");
                                            }
                                        }
                                    });
                                } else {
                                    dialog.alert("没有正文附件，无法进行签署!");
                                }
                            }
                        });
                    }
                }
            });

        }

        window.querySignStatus = function () {
            var flag = false;
            var url = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryFinish&signId=${param.fdId}";
            $.ajax({
                url: url,
                type: 'post',
                data: {},
                dataType: 'text',
                async: false,
                error: function () {
                    dialog.alert('请求出错');
                },
                success: function (data) {
                    if (data == "true") {
                        flag = true;
                    } else {
                        dialog.alert("当前签署任务未完成，无法提交！！");
                        flag = false;
                    }
                }
            });
            return flag;
        }
        window.querySignStatusJgPdf = function () {
            var flag = false;
            var url = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryFinish&signId=${param.fdId}";
            $.ajax({
                url: url,
                type: 'post',
                data: {},
                dataType: 'text',
                async: false,
                error: function () {
                    dialog.alert('请求出错');
                },
                success: function (data) {
                    if (data == "true") {
                        flag = true;
                    } else {
                        //谷歌下金格控件隐藏显示问题
                        if (navigator.userAgent.indexOf("Firefox") >= 0 || navigator.userAgent.indexOf("Chrome") >= 0) {
                            try {
                                if (navigator.userAgent.indexOf("Chrome") >= 0) {
                                    // iwebPDF2018控件的优先级过高，会将弹出框和后面的按钮遮挡住value=1显示 value=0 隐藏
                                    var pdfFrame = document.getElementById('pdfFrame');
                                    if (pdfFrame != null) {
                                        pdfFrame.contentWindow.document.getElementById('JGWebPdf_convert_toPDF').HidePlugin(0);
                                    }
                                }
                            } catch (e) {
                            }
                        }
                        dialog.confirm("当前签署任务未完成，无法提交，请签章完成之后点击保存再提交！", function (_flag) {
                            //谷歌下金格控件隐藏显示问题
                            if (navigator.userAgent.indexOf("Firefox") >= 0 || navigator.userAgent.indexOf("Chrome") >= 0) {
                                try {
                                    if (navigator.userAgent.indexOf("Chrome") >= 0) {
                                        // iwebPDF2018控件的优先级过高，会将弹出框和后面的按钮遮挡住value=1显示 value=0 隐藏
                                        var pdfFrame = document.getElementById('pdfFrame');
                                        if (pdfFrame != null) {
                                            pdfFrame.contentWindow.document.getElementById('JGWebPdf_convert_toPDF').HidePlugin(1);
                                        }
                                    }
                                } catch (e) {
                                }
                            }
                        }, "warn");
                        flag = false;
                    }
                }
            });
            return flag;
        }
    });

    //#105274 流程分发页面调整
    $(document).ready(function () {
        if ($('#assignOprRow .lui-lbpm-checkbox').length > 0) {
            $('#assignOprRow .lui-lbpm-checkbox').hide();
        }
        if ($('input:radio[name="assignType"]')) {
            $("#assignTypeDIV").hide();
            $('input:radio[name="assignType"][value="1"]').prop('checked', true);
            $('input:radio[name="assignType"][value="1"]').click();
            $("#canMultiAssign").click();
        }
        //如果表单没有纳入督办元素，移除督办先
        var fdIsSupervised = document.getElementsByName("fdIsSupervised");
        if (fdIsSupervised.length <= 0) {
            $('#superVisedDiv').remove();
        }

    });

    <c:if test="${(kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.eqbSign =='true' || kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.ofdEqbSign =='true')  && eqbFlag=='true'}">
    Com_Parameter.event["submit"].push(function () {
        var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
        //操作类型为通过类型 ，才判断是否已经签署
        if ($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true) {
            return querySignStatus();
        } else {
            return true;
        }
    });
    </c:if>

    <c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.ofdSursenSign =='true'}">
    Com_Parameter.event["submit"].push(function () {
        var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
        //操作类型为通过类型 ，才判断是否已经签署
        if ($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true) {
            return querySignStatus();
        } else {
            return true;
        }
    });
    </c:if>

    <c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.ofdCySign =='true'}">
    Com_Parameter.event["submit"].push(function () {
        var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
        //操作类型为通过类型 ，才判断是否已经签署
        if ($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true) {
            return querySignStatus();
        } else {
            return true;
        }
    });
    </c:if>
    <c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.pdfJgSign =='true'}">
    seajs.use(['lui/jquery', 'lui/topic'], function ($, topic) {
        topic.subscribe('km.imissive.jgPdfSave', function (evt) {
            if (evt.flag) {
                //政务公文添加/修改kmImissiveOutSign表数据，给公文提交时用来判断是否已经签过章
                var url = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=jgPdfSaveSign&fdModelId=" + evt.fdModelId + "&persionId=" + evt.persionId;
                $.ajax({
                    url: url,
                    type: 'post',
                    data: {},
                    dataType: 'text',
                    async: false,
                    success: function (data) {
                    }
                });
            }
        });
    });
    Com_Parameter.event["submit"].push(function () {
        var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
        //操作类型为通过类型 ，才判断是否已经签署
        if ($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true) {
            return querySignStatusJgPdf();
        } else {
            return true;
        }
    });
    </c:if>


    <c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
    Com_Parameter.event["submit"].push(function () {
        var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
        //操作类型为通过类型 ，才判断是否已经签署
        if ($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true) {
            return querySignStatus();
        } else {
            return true;
        }
    });
    </c:if>

    <c:if test="${eSignatureModuleExist=='true'&&kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sign == 'true'}">
    Com_Parameter.event["submit"].push(function () {
        var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
        if ($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true) {
            return querySignStatus();
        } else {
            return true;
        }
    });
    </c:if>


    window.editDocNum = function () {
        var url = Com_GetCurDnsHost() + Com_Parameter.ContextPath + 'km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=editDocNum&fdId=${param.fdId}';
        dialog.iframe(url, '<bean:message  bundle="km-imissive" key="kmImissiveSendMain.editdocnum"/>', function (rtn) {
            if (rtn != null && rtn != "cancel") {
                location.reload();
            }
        }, {width: 600, height: 300});
    },

        window.saveRevisions = function (fdKey) {
            var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=generate2Id";
            var obj_ = document.getElementById("JGWebOffice_" + fdKey);
            if (Attachment_ObjectInfo[fdKey]) {
                var defaultName = '<bean:message  bundle="km-imissive" key="nodename.noderevision"/>' + '_' + '<%=UserUtil.getUser().getFdName()%>' + '_' + subject + '_' + '<%=DateUtil.convertDateToString(new Date(), DateUtil.PATTERN_DATETIME)%>' + '.doc';
                var nameUrl = Com_GetCurDnsHost() + Com_Parameter.ContextPath + "km/imissive/import/revisionName.jsp?defaultName=" + encodeURIComponent(defaultName);
                dialog.iframe(nameUrl, '重命名', function (rtn) {
                    if (rtn != null && rtn != "cancel") {
                        if (Attachment_ObjectInfo[fdKey].ocxObj) {
                            var editType = Attachment_ObjectInfo[fdKey].ocxObj.EditType;
                            Attachment_ObjectInfo[fdKey].ocxObj.EditType = "1,1";
                            $.ajax({
                                url: url,
                                async: false,    //用同步方式
                                success: function (data) {
                                    //obj_.WebSetProtect(true, "");
                                    results = eval("(" + data + ")");
                                    if (results['id1'] != "" && results['id2'] != "") {
                                        var rFlag = false;
                                        try {
                                            //信创环境下需要先进行一下暂存操作，金格的问题，暂时查不出什么原因
                                            var saveA = document.getElementsByName(fdKey + "_saveDraft")[0];
                                            if (saveA != null && saveA != undefined) {
                                                saveA.click();
                                            }
                                            Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("COMMAND", "REVISIONDRAFT");
                                            Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("_modelName", "com.landray.kmss.km.imissive.model.KmImissiveAttTrack");
                                            Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("_key", "revisionNodeAtt");
                                            Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("_fdId", results['id1']);
                                            Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("_fdFileName", encodeURIComponent(rtn));
                                            //obj_.AllowEmpty = true;//内容为空默认不校验
                                            //保存痕迹稿
                                            rFlag = Attachment_ObjectInfo[fdKey].ocxObj.WebSave();
                                            if (rFlag) {
                                                if (saveAttTrack(Attachment_ObjectInfo[fdKey].ocxObj.WebGetMsgByName("fd_fileId"), Attachment_ObjectInfo[fdKey].ocxObj.WebGetMsgByName("fd_fileName"), "6", "${nodevalue}")) {
                                                    Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("COMMAND", "NODRAFT");
                                                    Attachment_ObjectInfo[fdKey].ocxObj.ClearRevisions();
                                                    Attachment_ObjectInfo[fdKey].ocxObj.EditType = editType;
                                                    Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("_fdFileName", "");
                                                    dialog.alert("已生成痕迹稿，请到发文跟踪页签下查看！");
                                                }
                                            }
                                        } catch (e) {

                                        }
                                    }
                                }
                            });
                        }
                    }
                }, {width: 600, height: 250});
            } else {
                dialog.alert("当前文档无正文，不能保存痕迹稿！！！");
            }
        },

        window.saveRevisionsByWps = function (fdKey) {
            var wpsObject;
            if (fdKey == 'editonline' && wps_cloud_editonline) {
                wpsObject = wps_cloud_editonline;
            }
            if (fdKey == 'mainonline' && wps_cloud_mainonline) {
                wpsObject = wps_cloud_mainonline;
            }
            if (wpsObject) {
                if (!wpsObject.hasLoad) {
                    dialog.alert("当前正文内容未加载，请切换到正文页签加载正文后操作！");
                    return;
                }
                if ("${editStatus}" == "true" && "${isReadOnly}" == "false") {
                    var savePromise = wpsObject.wpsObj.save();
                    savePromise.then(function (rtn) {
                        doSaveRevisionsByWps(fdKey);
                    });
                } else {
                    doSaveRevisionsByWps(fdKey);
                }
            } else {
                dialog.alert("wps加载异常，操作失败！");
            }
        },

        window.saveRevisionsByWpsCenter = function (fdKey) {
            var wpsObject;
            if (fdKey == 'editonline' && wps_center_editonline) {
                wpsObject = wps_center_editonline;
            }
            if (fdKey == 'mainonline' && wps_center_mainonline) {
                wpsObject = wps_center_mainonline;
            }
            if (wpsObject) {
                if (!wpsObject.hasLoad) {
                    dialog.alert("当前正文内容未加载，请切换到正文页签加载正文后操作！");
                    return;
                }
                if ("${editStatus}" == "true" && "${isReadOnly}" == "false") {
                    var savePromise = wpsObject.wpsObj.save();
                    savePromise.then(function (rtn) {
                        doSaveRevisionsByWpsCenter(fdKey);
                    });
                } else {
                    doSaveRevisionsByWpsCenter(fdKey);
                }
            } else {
                dialog.alert("wps加载异常，操作失败！");
            }
        },


        window.doSaveRevisionsByWps = function (fdKey) {
            var defaultName = '<bean:message  bundle="km-imissive" key="nodename.noderevision"/>' + '_' + '<%=UserUtil.getUser().getFdName()%>' + '_' + subject + '_' + '<%=DateUtil.convertDateToString(new Date(), DateUtil.PATTERN_DATETIME)%>' + '.doc';
            var nameUrl = Com_GetCurDnsHost() + Com_Parameter.ContextPath + "km/imissive/import/revisionName.jsp?defaultName=" + encodeURIComponent(defaultName);
            dialog.iframe(nameUrl, '重命名', function (rtn) {
                if (rtn != null && rtn != "cancel") {
                    var nodeName = "${nodevalue}";
                    var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=saveRevisionsByWps&fdKey=" + fdKey + "&fdId=${param.fdId}&nodeName=" + encodeURIComponent(nodeName) + "&fileName=" + encodeURIComponent(rtn);
                    $.ajax({
                        url: url,
                        async: false,    //用同步方式
                        success: function (data) {
                            if (data) {
                                seajs.use(['lui/jquery', 'lui/dialog'], function ($, dialog) {
                                    var loading = dialog.loading("正在保存痕迹稿中,请稍候...");
                                    setTimeout(wpsSaveRevisionsResult, 2000);

                                    function wpsSaveRevisionsResult() {
                                        var ajaxUrl = Com_Parameter.ContextPath + "km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getSaveRevisionsResult&fdKey=" + fdKey + "&fdId=${param.fdId}&nodeName=" + encodeURIComponent(nodeName);
                                        $.ajax({
                                            url: ajaxUrl,
                                            type: 'post',
                                            data: {},
                                            dataType: 'text',
                                            async: true,
                                            error: function () {
                                                dialog.alert('请求出错');
                                            },
                                            success: function (data) {
                                                if (data == "true") {
                                                    loading.hide();
                                                    dialog.alert("保存痕迹稿成功", function () {
                                                        if (fdKey == 'editonline') {
                                                            wps_cloud_editonline.load();
                                                        } else if (fdKey == 'mainonline') {
                                                            wps_cloud_mainonline.load();
                                                        }
                                                    });
                                                } else if (data == "false") {
                                                    loading.hide();
                                                    dialog.alert("保存痕迹稿失败");
                                                } else {
                                                    setTimeout(wpsSaveRevisionsResult, 2000);
                                                }
                                            }
                                        });
                                    }
                                });
                            }
                        }
                    });
                }
            }, {width: 600, height: 250});
        },

        window.doSaveRevisionsByWpsCenter = function (fdKey) {
            var defaultName = '<bean:message  bundle="km-imissive" key="nodename.noderevision"/>' + '_' + '<%=UserUtil.getUser().getFdName()%>' + '_' + subject + '_' + '<%=DateUtil.convertDateToString(new Date(), DateUtil.PATTERN_DATETIME)%>' + '.doc';
            var nameUrl = Com_GetCurDnsHost() + Com_Parameter.ContextPath + "km/imissive/import/revisionName.jsp?defaultName=" + encodeURIComponent(defaultName);
            dialog.iframe(nameUrl, '重命名', function (rtn) {
                if (rtn != null && rtn != "cancel") {
                    var nodeName = "${nodevalue}";
                    var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=saveRevisionsByWps&fdKey=" + fdKey + "&fdId=${param.fdId}&nodeName=" + encodeURIComponent(nodeName) + "&fileName=" + encodeURIComponent(rtn);
                    $.ajax({
                        url: url,
                        async: false,    //用同步方式
                        success: function (data) {
                            if (data) {
                                seajs.use(['lui/jquery', 'lui/dialog'], function ($, dialog) {
                                    var loading = dialog.loading("正在保存痕迹稿中,请稍候...");
                                    setTimeout(wpsCenterSaveRevisionsResult, 2000);

                                    function wpsCenterSaveRevisionsResult() {
                                        var ajaxUrl = Com_Parameter.ContextPath + "km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getSaveRevisionsResult&fdKey=" + fdKey + "&fdId=${param.fdId}&nodeName=" + encodeURIComponent(nodeName);
                                        $.ajax({
                                            url: ajaxUrl,
                                            type: 'post',
                                            data: {},
                                            dataType: 'text',
                                            async: true,
                                            error: function () {
                                                dialog.alert('请求出错');
                                            },
                                            success: function (data) {
                                                if (data == "true") {
                                                    loading.hide();
                                                    dialog.alert("保存痕迹稿成功", function () {
                                                        if (fdKey == 'editonline') {
                                                            //wps_center_editonline.accent();
                                                            wps_center_editonline.forceLoad = true;
                                                            wps_center_editonline.load();
                                                        } else if (fdKey == 'mainonline') {
                                                            //wps_center_mainonline.accent();
                                                            wps_center_mainonline.forceLoad = true;
                                                            wps_center_mainonline.load();
                                                        }
                                                    });
                                                } else if (data == "false") {
                                                    loading.hide();
                                                    dialog.alert("保存痕迹稿失败");
                                                } else {
                                                    setTimeout(wpsCenterSaveRevisionsResult, 2000);
                                                }
                                            }
                                        });
                                    }
                                });
                            }
                        }
                    });
                }
            }, {width: 600, height: 250});
        },


        window.distributeDoc = function () {
            //saveFinal();
            var url = Com_GetCurDnsHost() + Com_Parameter.ContextPath + 'km/imissive/km_imissive_send_dr/kmImissiveSendDR.do?method=distribute&fdMainId=${param.fdId}';
            dialog.iframe(url, '<bean:message  bundle="km-imissive" key="kmImissiveSendMain.distribute.title"/>', function (rtn) {
                if (rtn != null && rtn != "cancel") {
                    location.reload();
                }
            }, {width: 960, height: 550});
        },
        window.report = function () {
            var url = Com_GetCurDnsHost() + Com_Parameter.ContextPath + 'km/imissive/km_imissive_send_dr/kmImissiveSendDR.do?method=report&fdMainId=${param.fdId}';
            dialog.iframe(url, '<bean:message  bundle="km-imissive" key="kmImissiveSendMain.report.title"/>', function (rtn) {
                if (rtn != null && rtn != "cancel") {
                    location.reload();
                }
            }, {width: 960, height: 550});
        },
        /* 软删除配置 */
        window.Delete = function (delUrl) {
            /* dialog.confirm("



            ${lfn:message('page.comfirmDelete')}",function(flag){
    	if(flag==true){
    		Com_OpenWindow('kmImissiveSendMain.do?method=delete&fdId=



            ${param.fdId}','_self');
    	}else{
    		return false;
	    }
    },"warn"); */
            Com_Delete_Get(delUrl, 'com.landray.kmss.km.imissive.model.KmImissiveSendMain');
            return;
        },

        window.filingDoc = function () {
            dialog.confirm("${lfn:message('km-imissive:alert.filing.msg')}", function (flag) {
                if (flag == true) {
                    Com_OpenWindow('kmImissiveSendMain.do?method=filing&fdId=${param.fdId}', '_self');
                } else {
                    return;
                }
            }, "warn");
        },
//文档加载时自动获取文号（有些项目提出，他们的流程不止一个节点有编号，如果起草节点已经遍了号，审批过程中打开自动生成文号，会导致该文号规则跳号，所以该方法目前暂时没用到
        window.generateAutoNum = function () {
            var docNum = document.getElementsByName("fdDocNum")[0];
            if ("${fdNoId}" != "") {
                if (getValueFromCookie("${fdNoId}")) {
                    docNum.value = decodeURI(getValueFromCookie("${fdNoId}"));
                    tempDocNum = decodeURI(getValueFromCookie("${fdNoId}"));
                    document.getElementById("docnum").innerHTML = decodeURI(getValueFromCookie("${fdNoId}"));
                    //填充控件中的文号书签
                    if (Attachment_ObjectInfo['editonline'] && Attachment_ObjectInfo['editonline'].hasLoad) {
                        Attachment_ObjectInfo['editonline'].setBookmark('docnum', decodeURI(getValueFromCookie("${fdNoId}")));
                    }
                } else {
                    var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=generateNum";
                    $.ajax({
                        type: "post",
                        url: url,
                        data: {fdDocNum: docNum.value, fdId: "${kmImissiveSendMainForm.fdId}"},
                        async: false,    //用同步方式
                        success: function (data) {
                            var results = eval("(" + data + ")");
                            if (results['docNum'] != null) {
                                docNum.value = results['docNum'];
                                document.getElementById("docnum").innerHTML = results['docNum'];
                                //填充控件中的文号书签
                                if (Attachment_ObjectInfo['editonline'] && Attachment_ObjectInfo['editonline'].hasLoad) {
                                    Attachment_ObjectInfo['editonline'].setBookmark('docnum', document.getElementsByName("fdDocNum")[0].value);
                                }
                            }
                            document.cookie = ("${fdNoId}=" + encodeURI(results['docNum']));
                        }
                    });
                }
            }
        },

        window.generateFileNum4Publsh = function () {
            var path = Com_GetCurDnsHost() + Com_Parameter.ContextPath + 'km/imissive/km_imissive_send_main/kmImissiveNum.jsp?fdId=${kmImissiveSendMainForm.fdId}&fdNoId=${fdNoId}&fdBufferNumId=' + fdBufferNumId + '&fdTemplateId=${kmImissiveSendMainForm.fdTemplateId}';
            dialog.iframe(path, '<bean:message key="kmImissive.modifyDocNum" bundle="km-imissive" />', function (rtn) {
                if (rtn != "undefined" && rtn != null) {
                    var arr = rtn.fdRtnNum.split("#");
                    if (arr.length == 3) {
                        var fdNoRule = arr[0];
                        var fdFlowNo = arr[1];
                        var fdNumberMainId = arr[2];
                        var docNum = rtn.fdNum;
                        var fdYearNo = rtn.fdYearNo;

                        var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=saveDocNum";
                        $.ajax({
                            type: "post",
                            url: url,
                            data: {
                                fdDocNum: docNum,
                                fdFlowNo: fdFlowNo,
                                fdNoRule: fdNoRule,
                                fdNumberMainId: fdNumberMainId,
                                fdId: "${kmImissiveSendMainForm.fdId}",
                                fdYearNo: fdYearNo
                            },
                            async: false,    //用同步方式
                            success: function (data) {
                                results = eval("(" + data + ")");
                                if (results['isRepeat'] == "true") {
                                    dialog.failure('<bean:message bundle="km-imissive" key="kmImissiveSendMain.message.error.fdDocNum.repeat"/>');
                                } else {
                                    dialog.success("更新文档编号成功");
                                    LUI('toolbar').removeButton(LUI('generateFileNum4Publsh'));
                                    LUI('generateFileNum4Publsh').destroy();
                                }
                                if (fdBufferNumId != "") {
                                    var docBufferNum = getTempNumberFromDb(fdBufferNumId, "com.landray.kmss.km.imissive.model.KmImissiveSendMain");
                                    if (docBufferNum) {
                                        var docBufferNumArr = decodeURI(docBufferNum).split("#");
                                        if ((docNum == formatNum(docBufferNumArr[0], docBufferNumArr[1])) || fdFlowNo > docBufferNumArr[1]) {
                                            delTempNumFromDb(fdBufferNumId, decodeURI(docBufferNum));
                                        }
                                    }
                                }
                            }
                        });
                    }
                }
            }, {width: 600, height: 400});
        },

        window.generateFileNum = function () {
            //文件编号的时候，审批人不一定有编辑正文的权限，先接触文档保护
            if (Attachment_ObjectInfo['editonline'] && Attachment_ObjectInfo['editonline'].ocxObj) {
                Attachment_ObjectInfo['editonline'].ocxObj.EditType = "1";
            }
            if (Attachment_ObjectInfo['mainonline'] && Attachment_ObjectInfo['mainonline'].ocxObj) {
                Attachment_ObjectInfo['mainonline'].ocxObj.EditType = "1";
            }
            var docNum = document.getElementsByName("fdDocNum")[0];
            var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
            var fdNoRule = document.getElementsByName("fdNoRule")[0];
            var fdYearNo = document.getElementsByName("fdYearNo")[0];
            var fdNumberMainId = document.getElementsByName("fdNumberMainId")[0];
            path = Com_GetCurDnsHost() + Com_Parameter.ContextPath + 'km/imissive/km_imissive_send_main/kmImissiveNum.jsp?fdId=${kmImissiveSendMainForm.fdId}&fdNoId=${fdNoId}&fdBufferNumId=' + fdBufferNumId + '&fdTemplateId=${kmImissiveSendMainForm.fdTemplateId}';
            dialog.iframe(path, '<bean:message key="kmImissive.modifyDocNum" bundle="km-imissive" />', function (rtn) {
                if (rtn != "undefined" && rtn != null) {
                    var arr = rtn.fdRtnNum.split("#");
                    if (arr.length == 3) {
                        fdNoRule.value = arr[0];
                        fdFlowNo.value = arr[1];
                        fdNumberMainId.value = arr[2];
                        docNum.value = rtn.fdNum;
                        fdYearNo.value = rtn.fdYearNo;
                        document.getElementById("docnum").innerHTML = rtn.fdNum;
                    }
                    //填充控件中的文号书签
                    if (Attachment_ObjectInfo['editonline'] && Attachment_ObjectInfo['editonline'].hasLoad) {
                        Attachment_ObjectInfo['editonline'].setBookmark('docnum', rtn.fdNum);
                        if ("${isReadOnly}" == "true") {
                            if (Attachment_ObjectInfo['editonline'].ocxObj) {
                                if (!Attachment_ObjectInfo['editonline'].canCopy) {
                                    Attachment_ObjectInfo['editonline'].ocxObj.CopyType = "1";
                                    Attachment_ObjectInfo['editonline'].ocxObj.EditType = "0,1";
                                } else {
                                    Attachment_ObjectInfo['editonline'].ocxObj.CopyType = "1";
                                    Attachment_ObjectInfo['editonline'].ocxObj.EditType = "4,1";
                                }
                            }
                        }
                    }
                    if (Attachment_ObjectInfo['mainonline'] && Attachment_ObjectInfo['mainonline'].hasLoad) {
                        Attachment_ObjectInfo['mainonline'].setBookmark('docnum', rtn.fdNum);
                        if ("${isReadOnly}" == "true") {
                            if (Attachment_ObjectInfo['mainonline'].ocxObj) {
                                if (!Attachment_ObjectInfo['mainonline'].canCopy) {
                                    Attachment_ObjectInfo['mainonline'].ocxObj.CopyType = "1";
                                    Attachment_ObjectInfo['mainonline'].ocxObj.EditType = "0,1";
                                } else {
                                    Attachment_ObjectInfo['mainonline'].ocxObj.CopyType = "1";
                                    Attachment_ObjectInfo['mainonline'].ocxObj.EditType = "4,1";
                                }
                            }
                        }
                    }
                }
            }, {width: 600, height: 400});
        },
//异步保存附件跟踪信息
        window.saveAttTrack = function (fdFileId, fdFileName, type, fdNodeName) {
            fdFileName = decodeURIComponent(fdFileName);
            if (null != fdFileName && "undefined" != fdFileName) {
                //转化全部的空格 %20——空格
                fdFileName = fdFileName.replace(/%20/g, " ");
            }
            var flag = false;
            var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=addAttTrack";
            $.ajax({
                type: "post",
                url: url,
                data: {
                    fdMainId: "${kmImissiveSendMainForm.fdId}",
                    type: type,
                    fdFileId: fdFileId,
                    fdFileName: fdFileName,
                    fdNodeName: fdNodeName
                },
                async: false,    //用同步方式
                success: function () {
                    flag = true;
                }
            });
            return flag;
        },

        <%
 //生成一个附件id,供痕迹稿上传用
  request.setAttribute("revisionAttId",IDGenerator.generateID());
 //生成一个附件id,供清稿上传用
  request.setAttribute("clearAttId",IDGenerator.generateID());
%>

//清稿
        window.doCleardraft = function (fdKey) {
            var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=generate2Id";
            $.ajax({
                url: url,
                async: false,    //用同步方式
                success: function (data) {
                    results = eval("(" + data + ")");
                    if (results['id1'] != "" && results['id2'] != "") {
                        var obj_ = document.getElementById("JGWebOffice_" + fdKey);
                        var rFlag = false;
                        var cFlag = false;
                        try {
                            if (Attachment_ObjectInfo[fdKey] && Attachment_ObjectInfo[fdKey].ocxObj) {
                                //信创环境下需要先进行一下暂存操作，金格的问题，暂时查不出什么原因
                                var saveA = document.getElementsByName(fdKey + "_saveDraft")[0];
                                if (saveA != null && saveA != undefined) {
                                    saveA.click();
                                }
                                Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("COMMAND", "REVISIONDRAFT");
                                Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("_modelName", "com.landray.kmss.km.imissive.model.KmImissiveAttTrack");
                                Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("_key", "revisionAtt");
                                Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("_fdId", results['id1']);
                                Attachment_ObjectInfo[fdKey].ocxObj.AllowEmpty = true;//内容为空默认不校验
                                //保存痕迹稿
                                rFlag = Attachment_ObjectInfo[fdKey].ocxObj.WebSave();
                                if (rFlag) {
                                    if (saveAttTrack(Attachment_ObjectInfo[fdKey].ocxObj.WebGetMsgByName("fd_fileId"), Attachment_ObjectInfo[fdKey].ocxObj.WebGetMsgByName("fd_fileName"), "1", "${nodevalue}")) {
                                        Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("COMMAND", "CLEARDRAFT");
                                        Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("_modelName", "com.landray.kmss.km.imissive.model.KmImissiveAttTrack");
                                        Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("_key", "clearAtt");
                                        Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("_fdId", results['id2']);
                                        //删除正文痕迹
                                        Attachment_ObjectInfo[fdKey].ocxObj.WebObject.Application.ActiveDocument.Revisions.AcceptAll();
                                        //Attachment_ObjectInfo[fdKey].ocxObj.ClearRevisions();
                                        ////保存清稿
                                        cFlag = Attachment_ObjectInfo[fdKey].ocxObj.WebSave();
                                        if (cFlag) {
                                            if (saveAttTrack(Attachment_ObjectInfo[fdKey].ocxObj.WebGetMsgByName("fd_fileId"), Attachment_ObjectInfo[fdKey].ocxObj.WebGetMsgByName("fd_fileName"), "2", "${nodevalue}")) {
                                                Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("COMMAND", "NODRAFT");
                                                //清稿成功后需要保存正文
                                                var saveA = document.getElementsByName(fdKey + "_saveDraft")[0];
                                                if (saveA != null && saveA != undefined) {
                                                    saveA.click();
                                                    dialog.alert('<bean:message bundle="km-imissive" key="kmImissive.cleardraft.success"/>', function () {
                                                        //location.reload();
                                                    });
                                                }
                                            }
                                        } else {
                                            dialog.alert('<bean:message bundle="km-imissive" key="kmImissive.cleardraft.fail"/>');
                                        }
                                    }
                                }
                            } else {
                                dialog.alert('<bean:message bundle="km-imissive" key="kmImissive.cleardraft.warn"/>');
                            }
                        } catch (e) {
                            dialog.alert('<bean:message bundle="km-imissive" key="kmImissive.cleardraft.fail"/>');
                        }
                    }
                }
            });
        },
        window.cleardraft = function (fdKey) {
            var obj_ = document.getElementById("JGWebOffice_" + fdKey);
            if (obj_) {
                dialog.confirm('<bean:message bundle="km-imissive" key="kmImissive.cleardraft.comfirm"/>', function (flag) {
                    if (flag == true) {
                        doCleardraft(fdKey);
                    }
                }, "warn");
            } else {
                dialog.alert('<bean:message bundle="km-imissive" key="kmImissive.cleardraft.warn"/>');
            }
        }


    window.cleardraftByWps = function (fdKey) {
        dialog.confirm('<bean:message bundle="km-imissive" key="kmImissive.cleardraft.comfirm"/>', function (flag) {
            if (flag == true) {
                var wpsObject;
                if (fdKey == 'editonline' && wps_cloud_editonline) {
                    wpsObject = wps_cloud_editonline;
                }
                if (fdKey == 'mainonline' && wps_cloud_mainonline) {
                    wpsObject = wps_cloud_mainonline;
                }
                if (wpsObject) {
                    if (!wpsObject.hasLoad) {
                        dialog.alert("当前正文内容未加载，请切换到正文页签加载正文后操作！");
                        return;
                    }
                    var savePromise = wpsObject.wpsObj.save();
                    savePromise.then(function (rtn) {
                        doClearDraftByWps(fdKey);
                    });
                } else {
                    dialog.alert("wps加载异常，操作失败！");
                }
            }
        }, "warn");
    },
        window.cleardraftByWpsCenter = function (fdKey) {
            dialog.confirm('<bean:message bundle="km-imissive" key="kmImissive.cleardraft.comfirm"/>', function (flag) {
                if (flag == true) {
                    var wpsObject;
                    if (fdKey == 'editonline' && wps_center_editonline) {
                        wpsObject = wps_center_editonline;
                    }
                    if (fdKey == 'mainonline' && wps_center_mainonline) {
                        wpsObject = wps_center_mainonline;
                    }
                    if (wpsObject) {
                        if (!wpsObject.hasLoad) {
                            dialog.alert("当前正文内容未加载，请切换到正文页签加载正文后操作！");
                            return;
                        }
                        var savePromise = wpsObject.wpsObj.save();
                        savePromise.then(function (rtn) {
                            doClearDraftByWpsCenter(fdKey);
                        });
                    } else {
                        dialog.alert("wps加载异常，操作失败！");
                    }
                }
            }, "warn");
        },

        window.doClearDraftByWps = function (fdKey) {
            var nodeName = "${nodevalue}";
            var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=clearDraftByWps&fdKey=" + fdKey + "&fdId=${param.fdId}&nodeName=" + encodeURIComponent(nodeName);
            $.ajax({
                url: url,
                async: false,    //用同步方式
                success: function (data) {
                    if (data) {
                        seajs.use(['lui/jquery', 'lui/dialog'], function ($, dialog) {
                            var loading = dialog.loading("正在清稿中,请稍候...");
                            setTimeout(wpsClearDraftResult, 2000);

                            function wpsClearDraftResult() {
                                var ajaxUrl = Com_Parameter.ContextPath + "km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getClearDraftResult&fdKey=" + fdKey + "&fdId=${param.fdId}&nodeName=" + encodeURIComponent(nodeName);
                                $.ajax({
                                    url: ajaxUrl,
                                    type: 'post',
                                    data: {},
                                    dataType: 'text',
                                    async: true,
                                    error: function () {
                                        dialog.alert('请求出错');
                                    },
                                    success: function (data) {
                                        if (data == "true") {
                                            loading.hide();
                                            dialog.alert("清稿成功", function () {
                                                if (fdKey == 'editonline') {
                                                    wps_cloud_editonline.load();
                                                } else if (fdKey == 'mainonline') {
                                                    wps_cloud_mainonline.load();
                                                }
                                            });
                                        } else if (data == "false") {
                                            loading.hide();
                                            dialog.alert("清稿失败");
                                        } else {
                                            setTimeout(wpsClearDraftResult, 2000);
                                        }
                                    }
                                });
                            }
                        });
                    }
                }
            });
        },
        window.doClearDraftByWpsCenter = function (fdKey) {
            var nodeName = "${nodevalue}";
            var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=clearDraftByWps&fdKey=" + fdKey + "&fdId=${param.fdId}&nodeName=" + encodeURIComponent(nodeName);
            $.ajax({
                url: url,
                async: false,    //用同步方式
                success: function (data) {
                    if (data) {
                        seajs.use(['lui/jquery', 'lui/dialog'], function ($, dialog) {
                            var loading = dialog.loading("正在清稿中,请稍候...");
                            setTimeout(function () {
                                wpsCenterClearDraftResult(60);
                            }, 2000);

                            function wpsCenterClearDraftResult(count) {
                                var ajaxUrl = Com_Parameter.ContextPath + "km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getClearDraftResult&fdKey=" + fdKey + "&fdId=${param.fdId}&nodeName=" + encodeURIComponent(nodeName);
                                $.ajax({
                                    url: ajaxUrl,
                                    type: 'post',
                                    data: {},
                                    dataType: 'text',
                                    async: true,
                                    error: function () {
                                        dialog.alert('请求出错');
                                    },
                                    success: function (data) {
                                        if (data == "true") {
                                            loading.hide();
                                            dialog.alert("清稿成功", function () {
                                                if (fdKey == 'editonline') {
                                                    //wps_center_editonline.accent();
                                                    wps_center_editonline.forceLoad = true;
                                                    wps_center_editonline.load();
                                                } else if (fdKey == 'mainonline') {
                                                    //wps_center_mainonline.accent();
                                                    wps_center_mainonline.forceLoad = true;
                                                    wps_center_mainonline.load();
                                                }
                                            });
                                        } else if (data == "false") {
                                            if (count > 0) {
                                                setTimeout(function () {
                                                    wpsCenterClearDraftResult(count - 1);
                                                }, 2000);
                                            } else {
                                                loading.hide();
                                                dialog.alert("清稿失败");
                                            }
                                        }
                                    }
                                });
                            }
                        });
                    }
                }
            });
        }
</script>
<script>
    var confirmSuperviseFlag = "";  //是否核发督办标示

    function confirmSupervisedInner() {
        var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=updateConfirmSupervise"
        $.ajax({
            type: "post",
            url: url,
            data: {
                fdModelId: "${kmImissiveSendMainForm.fdId}",
                fdModelName: "com.landray.kmss.km.imissive.model.KmImissiveSendMain"
            },
            async: false,    //用同步方式
            success: function (data) {
                results = eval("(" + data + ")");
                if (results['flag'] == "true") {
                    confirmSuperviseFlag = "true";
                    //隐藏督办核发按钮
                    $("#confirmSuperVisedBtn").hide();
                    dialog.alert("督办核发成功");
                }
            }
        });
    }

    function confirmSupervised() {
        if ("${kmImissiveSendMainForm.fdSuperviseFlag}" == 'true') {
            dialog.confirm("该督办已核发，是否确定重新核发？", function (flag) {
                if (flag == true) {
                    confirmSupervisedInner();
                } else {
                    return;
                }
            }, "warn");
        } else {
            confirmSupervisedInner();
        }
    }

    function Com_submitReviewInner() {
        Com_Submit(document.kmImissiveSendMainForm, 'approveSend');

        var docNum = document.getElementsByName("fdDocNum")[0];
        //删除当前所用编号规则的cookie,避免新建每次取到同一编号
        var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
        if (fdBufferNumId != "" && (checkIfFutureNodeSelected() || (canStartProcess && canStartProcess.value == "false"))) {
            deleteBufferNumByNumberId(fdBufferNumId);
        }
    }


    <c:if  test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.confirmSupervise =='true' and not empty fdSuperviseId}">
    Com_Parameter.event["submit"].push(function () {
        var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
        if($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true){
            var fdSuperviseFlag = '${kmImissiveSendMainForm.fdSuperviseFlag}';
            if ("" == confirmSuperviseFlag && "true"!=fdSuperviseFlag) {
                flag = confirm("当前审批节点有“核发督办”附加选项，请确认是否核发督办？");
                if (flag) {
                    confirmSupervised();
                }
            }
        }
        return true;
    });
    </c:if>

    function deleteBufferNumByNumberId(fdBufferNumId) {
        var docBufferNum = getTempNumberFromDb(fdBufferNumId, "com.landray.kmss.km.imissive.model.KmImissiveSendMain");
        if (docBufferNum) {
            var fdYearNo = document.getElementsByName("fdYearNo");
            var nowYearNo = "";
            var date = new Date();
            nowYearNo = date.getFullYear();
            var docBufferNumArr = decodeURI(docBufferNum).split("#");
            var docNum = document.getElementsByName("fdDocNum")[0];
            var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
            if ((docNum.value == formatNum(docBufferNumArr[0], docBufferNumArr[1])) || (fdYearNo.length > 0 && fdYearNo[0].value == nowYearNo && fdFlowNo.value > docBufferNumArr[1])) {
                delTempNumFromDb(fdBufferNumId, decodeURI(docBufferNum));
                //delCookieByName(fdBufferNumId);
            }
        }
    }

    //文件编号
    var fdBufferNumId = "";  //记录当前所预览的编号规则id
    var fdVirtualNum = "";  //记录当前所预览的编号规则的虚拟值
    function Com_submitReview() {
        var fdIsSupervised = document.getElementsByName("fdIsSupervised");
        var superVisedFrame = LUI('superVisedFrame');
        if (fdIsSupervised.length > 0 && fdIsSupervised[0].value == "true" && superVisedFrame.src != "") {
            superVisedFrame.$iframeNode[0].contentWindow.goushi();
        } else {
            Com_submitReviewInner();
        }
    }

    <c:if  test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true'}">
    Com_Parameter.event["submit"].push(function () {
        //操作类型为通过类型 ，才写回编号
        if (lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true) {
            var docNum = document.getElementsByName("fdDocNum")[0];
            var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
            var fdNoRule = document.getElementsByName("fdNoRule")[0];
            var fdNumberMainId = document.getElementsByName("fdNumberMainId")[0];
            var fdYearNo = document.getElementsByName("fdYearNo")[0];
            var isRepeat = true;
            var results;
            if ("" == docNum.value) {
                isRepeat = confirm('<bean:message key="kmImissive.number.notNull" bundle="km-imissive" />');
            } else {
                var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=saveDocNum";
                $.ajax({
                    type: "post",
                    url: url,
                    data: {
                        fdDocNum: docNum.value,
                        fdFlowNo: fdFlowNo.value,
                        fdNoRule: fdNoRule.value,
                        fdNumberMainId: fdNumberMainId.value,
                        fdId: "${kmImissiveSendMainForm.fdId}",
                        fdYearNo: fdYearNo.value
                    },
                    async: false,    //用同步方式
                    success: function (data) {
                        results = eval("(" + data + ")");
                        if (results['isRepeat'] == "true") {
                            //如果编号被占用，则删除cookie和 数据库保存的编号
                            if (fdBufferNumId != "") {
                                deleteBufferNumByNumberId(fdBufferNumId);
                            }
                            alert('<bean:message bundle="km-imissive" key="kmImissiveSendMain.message.error.fdDocNum.repeat"/>');
                            isRepeat = false;
                        }
                    }
                });
                if (results['flag'] == "false" && results['isRepeat'] != "true") {
                    alert("更新文档编号不成功");
                    return false
                } else {
                    return isRepeat;
                }
            }
            return isRepeat;
        } else {
            return true;
        }
    });
    </c:if>

    <c:if test="${kmImissiveSendMainForm.fdNeedContent=='1' or attType eq 'word'}">
    var redheadFlag = "";  //是否进行套红标示
    <c:if  test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'}">
    Com_Parameter.event["submit"].push(function () {
        var flag = true;
        if ("${wpsoaassist}" != "true") {
            if ("" == redheadFlag) {
                flag = confirm('<bean:message  bundle="km-imissive" key="kmImissive.redhead.comfirm.notNull"/>');
            }
        }
        return flag;
    });
    </c:if>
    var sigzqFlag = "";  //是否进行签章标示
    var sigzqJGObjectKey = "";	//金格控件标示
    <c:if  test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sigzq =='true'}">
    <c:choose>
    <c:when test="${wpsoaassist eq 'true'}">
    </c:when>
    <c:when test="${_isWpsCloudEnable}">
    </c:when>
    <c:when test="${_isWpsCenterEnable}">
    </c:when>
    <c:otherwise>
    Com_Parameter.event["submit"].push(function () {
        var flag = true;
        <c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
        sigzqJGObjectKey = "mainonline";
        </c:if>
        <c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
        sigzqJGObjectKey = "editonline";
        </c:if>
        var sigZqCount = checkSigzqFlag(sigzqJGObjectKey);
        if (sigZqCount == "0") {
            flag = confirm('<bean:message key="kmImissive.sigzq.comfirm.notNull" bundle="km-imissive"/>');
        }
        return flag;
    });
    </c:otherwise>
    </c:choose>
    </c:if>
    </c:if>

    //得到正在文中签章或签名个数以判断是否完成正在文签章功能
    function checkSigzqFlag(fdKey) {
        var returnFlag = "0";	//0代表没有完成正文签章（印章或签名）,1代表已完成
        if (Attachment_ObjectInfo[fdKey] && Attachment_ObjectInfo[fdKey].ocxObj) {

            var mCount = Attachment_ObjectInfo[fdKey].ocxObj.SignatureCount(true);	//先得到印章 个数
            if (mCount > 0) {
                returnFlag = "1";
            } else {
                mCount = Attachment_ObjectInfo[fdKey].ocxObj.SignatureCount(false);	//再得到签名个数
                if (mCount > 0) {
                    returnFlag = "1";
                }
            }
        }
        return returnFlag;
    }

    function loadWordEdit(fdKey) {
        var wordFloat = $("#wordEditFloat");
        var _attEdit = $('#' + fdKey);
        wordFloat.css({'width': 'auto', 'height': '600px', 'filter': 'alpha(opacity=100)', 'opacity': '1'});
        _attEdit.css({'display': "none"});
        setTimeout(function () {
            if (Attachment_ObjectInfo[fdKey]) {
                Attachment_ObjectInfo[fdKey].unLoad();
                if ($('.bar-right') && $('.content')) {
                    $('.bar-right').css('width', '50%');
                    $('.content').css('margin-right', '51.5%');
                }
                Attachment_ObjectInfo[fdKey].load();
                Attachment_ObjectInfo[fdKey].show();
                if ("${isReadOnly}" == "true") {
                    if (Attachment_ObjectInfo[fdKey].ocxObj) {
                        if (!Attachment_ObjectInfo[fdKey].canCopy) {
                            Attachment_ObjectInfo[fdKey].ocxObj.CopyType = "1";
                            Attachment_ObjectInfo[fdKey].ocxObj.EditType = "0,1";
                        } else {
                            Attachment_ObjectInfo[fdKey].ocxObj.CopyType = "1";
                            Attachment_ObjectInfo[fdKey].ocxObj.EditType = "4,1";
                        }
                    }
                }
                if (Attachment_ObjectInfo[fdKey].ocxObj) {
                    Attachment_ObjectInfo[fdKey].ocxObj.Active(true);
                    //在线编辑打开，默认显示留痕
                    if (Attachment_ObjectInfo[fdKey].showRevisions == true && Attachment_ObjectInfo[fdKey].forceRevisions) {
                        Attachment_ObjectInfo[fdKey].ocxObj.WebSetRevision(true, true, true, true);
                    }
                }
            }
        }, 1);
    }

    //如果流程附加节点中有签发操作，则将签发日期和签发人写回
    <c:if  test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.signature =='true'}">
    Com_Parameter.event["submit"].push(function () {
        var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");//canStartProcess.value等于false为暂存，等于true为提交
        //操作类型为通过类型，才写回
        if (canStartProcess.value == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true) {
            //签发的时候，审批人不一定有编辑正文的权限，先接触文档保护
            if (Attachment_ObjectInfo['editonline'] && Attachment_ObjectInfo['editonline'].ocxObj) {
                Attachment_ObjectInfo['editonline'].ocxObj.EditType = "1";
            }
            if (Attachment_ObjectInfo['mainonline'] && Attachment_ObjectInfo['mainonline'].ocxObj) {
                Attachment_ObjectInfo['mainonline'].ocxObj.EditType = "1";
            }
            var flag = true;
            var docPublishTimeVal = "";
            var docPublishTime = document.getElementsByName("docPublishTime");
            if (docPublishTime.length > 0) {
                docPublishTimeVal = docPublishTime[0].value;
            }
            var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=saveSignatureAndTime";
            $.ajax({
                type: "post",
                url: url,
                data: {fdId: "${kmImissiveSendMainForm.fdId}", docPublishTime: docPublishTimeVal},
                async: false,     //用同步方式
                success: function (data) {
                    results = eval("(" + data + ")");
                    if (results['flag'] == "true") {
                        docPublishTime.value = results['publishTime'];
                        if (Attachment_ObjectInfo['editonline'] && Attachment_ObjectInfo['editonline'].hasLoad) {
                            Attachment_ObjectInfo['editonline'].setBookmark('signature', results['fdSignatureName']);
                            Attachment_ObjectInfo['editonline'].setBookmark('signdatecn', results['publishTimeUpper']);
                            Attachment_ObjectInfo['editonline'].setBookmark('signdate', results['publishTimeNum']);
                            Attachment_ObjectInfo['editonline'].setBookmark('signdaten', results['publishTime']);
                            if ("${isReadOnly}" == "true") {
                                if (Attachment_ObjectInfo['editonline'].ocxObj) {
                                    if (!Attachment_ObjectInfo['editonline'].canCopy) {
                                        Attachment_ObjectInfo['editonline'].ocxObj.CopyType = "1";
                                        Attachment_ObjectInfo['editonline'].ocxObj.EditType = "0,1";
                                    } else {
                                        Attachment_ObjectInfo['editonline'].ocxObj.CopyType = "1";
                                        Attachment_ObjectInfo['editonline'].ocxObj.EditType = "4,1";
                                    }
                                }
                            }
                        }
                        if (Attachment_ObjectInfo['mainonline'] && Attachment_ObjectInfo['mainonline'].hasLoad) {
                            Attachment_ObjectInfo['mainonline'].setBookmark('signature', results['fdSignatureName']);
                            Attachment_ObjectInfo['mainonline'].setBookmark('signdatecn', results['publishTimeUpper']);
                            Attachment_ObjectInfo['mainonline'].setBookmark('signdate', results['publishTimeNum']);
                            Attachment_ObjectInfo['mainonline'].setBookmark('signdaten', results['publishTime']);
                            if ("${isReadOnly}" == "true") {
                                if (Attachment_ObjectInfo['mainonline'].ocxObj) {
                                    if (!Attachment_ObjectInfo['mainonline'].canCopy) {
                                        Attachment_ObjectInfo['mainonline'].ocxObj.CopyType = "1";
                                        Attachment_ObjectInfo['mainonline'].ocxObj.EditType = "0,1";
                                    } else {
                                        Attachment_ObjectInfo['mainonline'].ocxObj.CopyType = "1";
                                        Attachment_ObjectInfo['mainonline'].ocxObj.EditType = "4,1";
                                    }
                                }
                            }
                        }
                    } else {
                        alert('生成签发日期失败');
                        flag = false;
                    }
                }
            });
            return flag;
        } else {
            return true;
        }
    });
    </c:if>
</script>
<script language="javascript"><!--
var wnd;  //定义辅助功能全局变量

//作用：签章
function DoJFSignature() {
    var nodeId = $("#processNodeId").text();
    var processNodeId = "fd_" + nodeId.substring(0, nodeId.indexOf("."));
    kmImissiveSendMainForm.SignatureControl.FieldsList = "DOCUMENTID=文档主键值"       //所保护字段
    kmImissiveSendMainForm.SignatureControl.DivId = processNodeId;                             //设置签章位置是相对于哪个标记的什么位置
    kmImissiveSendMainForm.SignatureControl.RunSignature();                         //执行签章操作
    //标签页是否展开
    var tab = LUI('kmImissiveSendMain_content');

    if (tab != null) {
        var panel = tab.parent;
        $.each(panel.contents, function (i) {
            if (this == tab) {
                panel.onToggle(i, false, true);
                panel.onToggle(i, false, false);
                return false;
            }
        });
    }
}


//作用：自动锁定文档
function ProtectDocument() {
    var mLength = document.getElementsByName("iHtmlSignature").length;
    var mProtect = false;
    for (var i = 0; i < mLength; i++) {
        var vItem = document.getElementsByName("iHtmlSignature")[i];
        if (vItem.DocProtect) {
            mProtect = true;
            break;
        }
    }
    if (!mProtect) {
        var vItem = document.getElementsByName("iHtmlSignature")[mLength - 1];
        vItem.LockDocument(true);
    }
}


//作用：进行手写签名
function DoSXSignature() {
    var isIEFlag = '${isIE}';
    if (null != isIEFlag && isIEFlag != 'true') {
        alert('<bean:message key="kmImissiveSignature.signatureIsIE" bundle="km-imissive"/>');
        return '';
    }

    var nodeId = $("#processNodeId").text();
    var processNodeId = "fd_" + nodeId.substring(0, nodeId.indexOf("."));
    var siginatureDivObj = document.getElementById(processNodeId);
    if (null == siginatureDivObj || "undefined" == siginatureDivObj) {
        alert('<bean:message key="kmImissiveSignature.signatureAlert" bundle="km-imissive"/>');
        return '';
    }
    //雾化功能
    //var mXml = "<?xml version='1.0' encoding='gb2312' standalone='yes'?>";
    //mXml = mXml + "  <Signature>";
    //mXml =mXml  +  "<OtherParam>";
    //mXml = mXml + "  <IsAtomize>TRUE</IsAtomize>";
    //mXml = mXml + "  <AtomizeValue>5</AtomizeValue>";
    //mXml =mXml  +  "</OtherParam>";
    //mXml = mXml + "  </Signature>";
    //kmImissiveSendMainForm.SignatureControl.XmlConfigParam = mXml;

    //屏蔽签章中的不通过项
    var noPassXml = "<?xml version='1.0' encoding='gb2312' standalone='yes'?>";
    noPassXml = noPassXml + "  <Signature><RunHandwrite> " +
        "  <PermissionNotPassEnabled>0</PermissionNotPassEnabled>"
        + "  </RunHandwrite></Signature>";
    kmImissiveSendMainForm.SignatureControl.XmlConfigParam = noPassXml;

    kmImissiveSendMainForm.SignatureControl.FieldsList = "DOCUMENTID=文档主键值"       //所保护字段
    kmImissiveSendMainForm.SignatureControl.Position(0, 0);                           //手写签名位置
    kmImissiveSendMainForm.SignatureControl.HandPenWidth = 1;                        //设置、读取手写签名的笔宽
    kmImissiveSendMainForm.SignatureControl.HandPenColor = 100;                      //设置、读取手写签名
    kmImissiveSendMainForm.SignatureControl.HandPenWidth = 1;                        //设置、读取手写签名的笔宽
    kmImissiveSendMainForm.SignatureControl.HandPenColor = 100;                      //设置、读取手写签名笔颜色笔颜色
    kmImissiveSendMainForm.SignatureControl.DivId = processNodeId;                            //设置签章位置是相对于哪个标记的什么位置
    kmImissiveSendMainForm.SignatureControl.RunHandWrite();                          //执行手写签名
}

//作用：删除签章
function DeleteSignature() {
    var mLength = document.getElementsByName("iHtmlSignature").length;
    var mSigOrder = "";
    for (var i = mLength - 1; i >= 0; i--) {
        var vItem = document.getElementsByName("iHtmlSignature")[i];
        //mSigOrder :=
        if (vItem.SignatureOrder == "1") {
            vItem.DeleteSignature();
        }
    }
}

//作用：打印文档
function PrintDocument() {
    //var tagElement = document.getElementById('kmImissiveSendMain_content');
    // alert(tagElement);
    // tagElement.className = 'print';                                                 //样式改变为可打印
    var mCount = kmImissiveSendMainForm.SignatureControl.PrintDocument(false, 2, 5);  //打印控制窗体
    // alert("实际打印份数："+mCount);
    // tagElement.className = 'Noprint';                                               //样式改变为不可打印
}

<c:if test="${JGSignatureHTMLEnabled == 'true'}">
window.onload = function () {
    kmImissiveSendMainForm.SignatureControl.ShowSignature('${param.fdId}');
};
window.onunload = function () {
    kmImissiveSendMainForm.SignatureControl.DeleteSignature();
};
</c:if>
--></script>

