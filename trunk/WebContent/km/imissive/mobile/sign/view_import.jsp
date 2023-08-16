<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<script>
    require(["mui/dialog/BarTip", "dojo/ready"], function (BarTip, ready) {
        ready(function () {
            if ("${_isWpsCloudEnable}" == 'true') {
                <c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true' or kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.cleardraft =='true' or kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sigzq =='true'}">
                BarTip.tip({text: '移动设备不支持正文签章、套红功能，建议使用电脑操作'});
                </c:if>
            } else if ("${_isWpsCenterEnable}" == 'true') {
                <c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true' or kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.cleardraft =='true' or kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sigzq =='true'}">
                BarTip.tip({text: '移动设备不支持正文签章功能，建议使用电脑操作'});
                </c:if>
            } else {
                <c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true' or kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true' or kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.cleardraft =='true' or kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sigzq =='true'}">
                BarTip.tip({text: '移动设备不支持正文签章、编号、套红功能，建议使用电脑操作'});
                </c:if>
            }
        });
    });
</script>
<script type="text/javascript">
    require(['dojo/topic',
        'dojo/ready',
        'dijit/registry',
        'dojox/mobile/TransitionEvent',
        'mui/device/adapter',
        "dojo/_base/lang",
        "mui/dialog/Tip"
    ], function (topic, ready, registry, TransitionEvent, adapter, lang, Tip) {

        //返回主视图
        window.backToDocView = function (obj) {
            var opts = {
                transition: 'slide',
                transitionDir: -1,
                moveTo: 'scrollView'
            };
            new TransitionEvent(obj, opts).dispatch();
        };
        window.circulate = function () {
            var url = Com_GetCurDnsHost() + Com_Parameter.ContextPath + 'sys/circulation/sys_circulation_opinion/sysCirculationOpinion.do?method=edit&fdModelId=${kmImissiveSignMainForm.fdId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain';
            window.open(url, "_self");
        };

        window.Com_submitReview = function () {
            Com_Submit(document.kmImissiveSignMainForm, 'approveSign');
            var docNum = document.getElementsByName("fdDocNum")[0];
            if (fdBufferNumId != "") {
                getTempNumberFromDb(fdBufferNumId, "com.landray.kmss.km.imissive.model.KmImissiveSignMain").then(lang.hitch(this, function (data) {
                    var results = eval("(" + data + ")");
                    if (results['docNum'] != null) {
                        var docBufferNum = results['docNum'];
                        if (docBufferNum) {
                            var docBufferNumArr = decodeURI(docBufferNum).split("#");
                            if ((docNum.value == formatNum(docBufferNumArr[0], docBufferNumArr[1])) || fdFlowNo.value > docBufferNumArr[1]) {
                                delTempNumFromDb(fdBufferNumId, decodeURI(docBufferNum));
                            }
                        }
                    }
                }));
            }
        };

        window.yqq = function (key) {
            var fileTypeUrl = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=validateSignFileType&signId=${param.fdId}";
            var queryStatusUrl = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryStatus&signId=${param.fdId}";
            var validateOnceUrl = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=validateOnce&signId=${param.fdId}";
            $.ajax({
                url: fileTypeUrl,
                type: 'post',
                data: {},
                dataType: 'text',
                async: true,
                error: function () {
                    Tip.tip({icon: 'mui mui-warn', text: '请求出错', width: '180', height: '60'});
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
                                Tip.tip({icon: 'mui mui-warn', text: '请求出错', width: '180', height: '60'});
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
                                            Tip.tip({icon: 'mui mui-warn', text: '请求出错', width: '180', height: '60'});
                                        },
                                        success: function (data) {
                                            if (data == "true") {
                                                Tip.tip({
                                                    icon: 'mui mui-warn',
                                                    text: '当前签报已经发送过易企签签署，整个签署事件未完成，请等待完成后在发起签署！！',
                                                    width: '180',
                                                    height: '60'
                                                });
                                            } else {
                                                var obj_ = document.getElementById("JGWebOffice_" + key);
                                                if (obj_) {
                                                    if (Attachment_ObjectInfo[key]) {
                                                        if (Attachment_ObjectInfo[key].ocxObj) {
                                                            var rFlag = Attachment_ObjectInfo[key].ocxObj.WebSave();
                                                            if (rFlag) {
                                                                var infoUrl = "${LUI_ContextPath}/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=openYqqExtendInfo&signId=${param.fdId}";
                                                                window.open(infoUrl, "_self");
                                                            }
                                                        }
                                                    }
                                                } else {
                                                    var infoUrl = "${LUI_ContextPath}/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=openYqqExtendInfo&signId=${param.fdId}";
                                                    window.open(infoUrl, "_self");
                                                }
                                            }
                                        }
                                    });
                                } else {
                                    window.open(data, "_self");
                                }
                            }
                        });
                    } else {
                        Tip.tip({
                            icon: 'mui mui-warn',
                            text: '不支持文件类型(' + data + ')签署，请上传以下文件类型(.pdf;.doc;.xls;.ppt;.docx;.xlsx;.pptx;.jpg;.png;.jpeg;)',
                            width: '300',
                            height: '160'
                        });
                    }
                }
            });
        };

        //正文阅读
        window.imissiveViewer = function () {
            var type = "${_sysAttMain.fdContentType}";
            var href = '${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${_sysAttMain.fdId}&viewer=mobilehtmlviewer';
            var downLoadUrl = "${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${_sysAttMain.fdId}";
            var hasViewer = "${hasViewer }";
            if (hasViewer != 'true' && type != 'img') {
                href = downLoadUrl;
            }
            window.location.href = href;
        }
    });
</script>

<script language="JavaScript">
    require(['dojo/ready',
            'dijit/registry',
            'dojo/topic',
            'dojo/query',
            'dojo/dom-style',
            "dojo/_base/array",
            'dojo/dom-class',
            "dojo/_base/lang",
            "mui/dialog/Tip",
            "dojo/request",
            "mui/device/adapter",
            "mui/util",
            "mui/device/device",
            'dojo/date/locale'],
        function (ready, registry, topic, query, domStyle, array, domClass, lang, Tip, req, adapter, util, device, locale) {

            <c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.signature =='true'}">
            Com_Parameter.event["submit"].push(function () {
                //操作类型为通过类型，才写回
                var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
                if ($(canStartProcess).val() != "false" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true) {
                    var flag = true;
                    req(util.formatUrl("/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=saveSignatureAndTime"), {
                        method: 'post',
                        data: {fdId: "${kmImissiveSignMainForm.fdId}"}
                    }).then(lang.hitch(this, function (data) {
                        results = eval("(" + data + ")");
                        if (results['flag'] == "false") {
                            alert('生成签发日期失败');
                            flag = false;
                        }
                    }));
                    return flag;
                }
                return true;
            });
            </c:if>
        });
</script>