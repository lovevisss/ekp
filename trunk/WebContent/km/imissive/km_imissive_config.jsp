<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="config.profile.edit" sidebar="no">
    <template:replace name="content">
        <style>
            .expand {
                display: none;
            }

            #superviseTipBox {
                color: #ff0000b8;
                font-size: smaller;
            }
        </style>
        <html:form action="/sys/appconfig/sys_appconfig/sysAppConfig.do">
            <script>
                seajs.use(['lui/dialog'], function (dialog) {
                    window.dialog = dialog;
                });
            </script>
            <div style="margin-top:25px">
                <p class="configtitle"><bean:message key="kmMissive.tree.displayConfig" bundle="km-imissive"/></p>
                <center>
                    <table class="tb_normal" width=90% style="table-layout:fixed;">
                        <tr>
                            <td class="td_normal_title" width=20%>
                                <bean:message bundle="km-imissive" key="setting.navigation.model"/>
                            </td>
                            <td colspan="3">
                                <xform:radio property="value(navigation)">
                                    <xform:enumsDataSource enumsType="kmImissive_config_navigation"></xform:enumsDataSource>
                                </xform:radio>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width=20%>
                                <bean:message bundle="km-imissive" key="setting.displayMode.default"/>
                            </td>
                            <td colspan="3">
                                <xform:radio property="value(displayMode)" onValueChange="changeDisplayMode(this.value);">
                                    <xform:enumsDataSource enumsType="kmImissive_config_displayMode"></xform:enumsDataSource>
                                </xform:radio>
                            </td>
                        </tr>
                        <tr id="navModeTr" style="display:none">
                            <td class="td_normal_title" width=20%>
                                <bean:message bundle="km-imissive" key="setting.navMode.default"/>
                            </td>
                            <td colspan="3">
                                <xform:radio property="value(navMode)">
                                    <xform:enumsDataSource enumsType="kmImissive_config_navMode"></xform:enumsDataSource>
                                </xform:radio>
                            </td>
                        </tr>

                        <tr>
                            <!-- 默认启用阅读加速模式  -->
                            <td class="td_normal_title" width=20%>
                                <bean:message bundle="km-imissive" key="setting.read.default.type"/>
                            </td>
                            <td colspan="3">
                                <ui:switch property="value(showImgDoc)" checkVal="2" unCheckVal="1"
                                           enabledText="${ lfn:message('km-imissive:setting.read.default.type.on') }"
                                           disabledText="${ lfn:message('km-imissive:setting.read.default.type.off') }"
                                           onValueChange="changeValue();">
                                </ui:switch>
                                <br>
                                <div id="showImg4ContentDiv" style="padding-top:5px;display:none">
                                    <html:hidden property="value(showImg4Content)"/>
                                    <label>
                                        <input name="showImg4Content" type="checkbox" onclick="changeValue4Content(this);"/>
                                        <bean:message bundle="km-imissive" key="setting.read.default.typeInfo4"/>
                                    </label>
                                </div>
                                <div id="showImg4DocDiv" style="padding-top:5px;display:none">
                                    <html:hidden property="value(showImg4Doc)"/>
                                    <label>
                                        <input name="showImg4Doc" type="checkbox" onclick="changeValue4Doc(this);"/>
                                        <bean:message bundle="km-imissive" key="setting.read.default.typeInfo5"/>
                                    </label>
                                </div>
                                <div>
                                    <bean:message bundle="km-imissive" key="setting.read.default.typeInfo0"/><br>
                                    <bean:message bundle="km-imissive" key="setting.read.default.typeInfo6"/><br>
                                    <bean:message bundle="km-imissive" key="setting.read.default.typeInfo1"/><br>
                                    <bean:message bundle="km-imissive" key="setting.read.default.typeInfo2"/><br>
                                    <bean:message bundle="km-imissive" key="setting.read.default.typeInfo3"/>
                                </div>
                            </td>
                        </tr>
                        <tr class="displayType" style="display:none">
                            <!-- 正文是否展开  -->
                            <td class="td_normal_title" width=20% rowspan="4">
                                <bean:message bundle="km-imissive" key="setting.display.default.type"/>
                            </td>
                            <td class="td_normal_title" width=20%>
                                <bean:message bundle="km-imissive" key="setting.display.default.send"/>
                            </td>
                            <td width=30%>
                                <html:hidden property="value(expandBaseInfo4Send)"/>
                                <label>
                                    <input name="expandBaseInfo4Send" type="checkbox"
                                           onclick="changeBaseInfoValue4Send(this);"/>
                                    <bean:message bundle="km-imissive" key="kmMissive.tree.displayConfig.baseInfo"/>
                                </label>
                            </td>
                            <td width=30%>
                                <html:hidden property="value(expandDoc4Send)"/>
                                <label>
                                    <input name="expandDoc4Send" type="checkbox" onclick="changeDocValue4Send(this);"/>
                                    <bean:message bundle="km-imissive" key="kmMissive.tree.displayConfig.content"/>
                                </label>
                            </td>
                        </tr>
                        <tr class="displayType" style="display:none">
                            <td class="td_normal_title" width=20%>
                                <bean:message bundle="km-imissive" key="setting.display.default.receive"/>
                            </td>
                            <td width=30%>
                                <html:hidden property="value(expandBaseInfo4Receive)"/>
                                <label>
                                    <input name="expandBaseInfo4Receive" type="checkbox" onclick="changeBaseInfoValue4Receive(this);"/>
                                    <bean:message bundle="km-imissive" key="kmMissive.tree.displayConfig.baseInfo"/>
                                </label>
                            </td>
                            <td width=30%>
                                <html:hidden property="value(expandDoc4Receive)"/>
                                <label>
                                    <input name="expandDoc4Receive" type="checkbox" onclick="changeDocValue4Receive(this);"/>
                                    <bean:message bundle="km-imissive" key="kmMissive.tree.displayConfig.content"/>
                                </label>
                            </td>
                        </tr>
                        <tr class="displayType" style="display:none">
                            <td class="td_normal_title" width=20%>
                                <bean:message bundle="km-imissive" key="setting.display.default.sign"/>
                            </td>
                            <td width=30%>
                                <html:hidden property="value(expandBaseInfo4Sign)"/>
                                <label>
                                    <input name="expandBaseInfo4Sign" type="checkbox" onclick="changeBaseInfoValue4Sign(this);"/>
                                    <bean:message bundle="km-imissive" key="kmMissive.tree.displayConfig.baseInfo"/>
                                </label>
                            </td>
                            <td width=30%>
                                <html:hidden property="value(expandDoc4Sign)"/>
                                <label>
                                    <input name="expandDoc4Sign" type="checkbox" onclick="changeDocValue4Sign(this);"/>
                                    <bean:message bundle="km-imissive" key="kmMissive.tree.displayConfig.content"/>
                                </label>
                            </td>
                        </tr>
                        <tr class="displayType" style="display:none">
                            <td colspan="3">
                                <bean:message bundle="km-imissive" key="setting.display.default.typeInfo0"/><br>
                                <bean:message bundle="km-imissive" key="setting.display.default.typeInfo2"/><br>
                                <bean:message bundle="km-imissive" key="setting.display.default.typeInfo1"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width=20%>
                                <bean:message bundle="km-imissive" key="setting.displayOrder.approval.default"/>
                            </td>
                            <td colspan="3">
                                <xform:radio property="value(displayOrder4Approval)">
                                    <xform:enumsDataSource enumsType="kmImissive_config_displayOrder"></xform:enumsDataSource>
                                </xform:radio>
                            </td>
                        </tr>

                        <tr>
                            <td class="td_normal_title" width=20%>
                                <bean:message bundle="km-imissive" key="setting.displayOrder.default"/>
                            </td>
                            <td colspan="3">
                                <xform:radio property="value(displayOrder)">
                                    <xform:enumsDataSource enumsType="kmImissive_config_displayOrder"></xform:enumsDataSource>
                                </xform:radio>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width=20%>
                                <bean:message bundle="km-imissive" key="setting.distributeOrReport.default"/>
                            </td>
                            <td colspan="3">
                                <html:hidden property="value(readOpinion)"/>
                                <label>
                                    <input name="readOpinion" type="checkbox" onclick="changeReadOpinion(this);"/>
                                    <bean:message bundle="km-imissive" key="kmImissiveSendMain.fdReadMissiveOpinion"/>
                                </label>&nbsp;&nbsp;&nbsp;
                                <html:hidden property="value(deliverOpinion)"/>
                                <label>
                                    <input name="deliverOpinion" type="checkbox" onclick="changeDeliverOpinion(this);"/>
                                    <bean:message bundle="km-imissive" key="kmImissiveSendMain.fdReadSendOpinion"/>
                                </label>&nbsp;&nbsp;&nbsp;
                                <html:hidden property="value(attAuthFlag)"/>
                                <label>
                                    <input name="attAuthFlag" type="checkbox" onclick="changeAttAuthFlag(this);"/>
                                    <bean:message bundle="km-imissive" key="kmImissiveSendMain.fdAttAuthFlag"/>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width=20%>
                                <bean:message bundle="km-imissive" key="setting.loadType.default"/>
                            </td>
                            <td colspan="3">
                                <xform:radio property="value(loadType)">
                                    <xform:enumsDataSource enumsType="kmImissive_config_loadType"></xform:enumsDataSource>
                                </xform:radio>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width=20%>
                                <bean:message bundle="km-imissive" key="setting.revision.default"/>
                            </td>
                            <td colspan="3">
                                <xform:radio property="value(revision)">
                                    <xform:enumsDataSource enumsType="kmImissive_config_revision"></xform:enumsDataSource>
                                </xform:radio>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width=20%>
                                是否优先使用漏号
                            </td>
                            <td colspan="3">
                                <ui:switch property="value(unUseNumFirst)" checkVal="1" unCheckVal="0"
                                           enabledText="${ lfn:message('km-imissive:setting.read.default.type.on') }"
                                           disabledText="${ lfn:message('km-imissive:setting.read.default.type.off') }">
                                </ui:switch>
                            </td>
                        </tr>

                        <tr>
                            <td class="td_normal_title" width=20%>
                                <bean:message bundle="km-imissive" key="setting.spreadauth.default"/>
                            </td>
                            <td colspan="3">
                                <ui:switch property="value(spreadAuth)" checkVal="1" unCheckVal="0"
                                           enabledText="${ lfn:message('km-imissive:setting.read.default.type.on') }"
                                           disabledText="${ lfn:message('km-imissive:setting.read.default.type.off') }">
                                </ui:switch>
                                <bean:message bundle="km-imissive" key="setting.spreadAuth.default.hint"/>
                            </td>
                        </tr>
                        <kmss:ifModuleExist path="/km/supervise/">
                        <tr>
                            <td class="td_normal_title" width=20%>
                                默认纳入督办模板
                            </td>
                            <td colspan="3">
                                <div id="dialogSuperTemplateBox">
                                    <xform:dialog propertyName="value(fdSuperviseTemplateName)"
                                                  propertyId="value(fdSuperviseTemplateId)" className="inputsgl"
                                                  style="width:95%">
                                        dialogSuperTemplate();
                                    </xform:dialog>
                                </div>
                            </td>
                        </tr>
                        </kmss:ifModuleExist>

                        <tr>
                            <td class="td_normal_title" width=20%>
                                优先打开正文页签开关
                            </td>
                            <td colspan="3">
                                <ui:switch property="value(isPriorityDoc)" checkVal="2" unCheckVal="1"
                                           enabledText="${ lfn:message('km-imissive:setting.read.default.type.on') }"
                                           disabledText="${ lfn:message('km-imissive:setting.read.default.type.off') }">
                                </ui:switch>
                                注：审批过程中有编辑正文权限者，优先打开正文页签，不受任何页签排序影响。
                            </td>
                        </tr>

                        <tr>
                            <td class="td_normal_title" width=20%>
                                启用流程意见类型
                            </td>
                            <td colspan="3">
                                <ui:switch property="value(auditOpinionCate)" checkVal="1" unCheckVal="0"
                                           enabledText="${ lfn:message('km-imissive:setting.read.default.type.on') }"
                                           disabledText="${ lfn:message('km-imissive:setting.read.default.type.off') }">
                                </ui:switch>
                            </td>
                        </tr>

                        <tr>
                            <td class="td_normal_title" width=20%>
                                启用业务权限
                            </td>
                            <td colspan="3">
                                <ui:switch property="value(businessAuth)" checkVal="1" unCheckVal="0"
                                           enabledText="${ lfn:message('km-imissive:setting.read.default.type.on') }"
                                           disabledText="${ lfn:message('km-imissive:setting.read.default.type.off') }">
                                </ui:switch>
                            </td>
                        </tr>

                        <tr>
                            <td class="td_normal_title" width=20%>
                                WPS文件转换开关
                            </td>
                            <td colspan="3">
                                <html:hidden property="value(pdfFormat)"/>
                                <label>
                                    <input name="pdfFormat" type="checkbox" onclick="changePdfFormat(this);"/>
                                    正文转PDF格式
                                </label>&nbsp;&nbsp;&nbsp;
                                <html:hidden property="value(ofdFormat)"/>
                                <label>
                                    <input name="ofdFormat" type="checkbox" onclick="changeOfdFormat(this);"/>
                                    正文转OFD格式
                                </label>&nbsp;&nbsp;&nbsp;
                                <br/>
                                注:开启后在公文分发或者上报时才可以选择PDF或者OFD格式正文
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width=20%>
                                收发文正文必填项开关
                            </td>
                            <td colspan="3">
                                <html:hidden property="value(sendContent)"/>
                                <label>
                                    <input name="sendContent" type="checkbox" onclick="changeSendContent(this);"/>
                                    发文正文
                                </label>&nbsp;&nbsp;&nbsp;
                                <html:hidden property="value(receiveContent)"/>
                                <label>
                                    <input name="receiveContent" type="checkbox" onclick="changeReceiveContent(this);"/>
                                    收文正文
                                </label>&nbsp;&nbsp;&nbsp;
                                <br/>
                                注:必填项只针对附件上传
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width=20%>
                                pdf文件转换来源
                            </td>
                            <td colspan="3">
                                <xform:radio property="value(pdfFileFrom)">
                                    <xform:enumsDataSource enumsType="kmImissive_config_pdfFileFrom"></xform:enumsDataSource>
                                </xform:radio><br/>
                                注:</br>
                                1、若系统没有购买任何pdf转换服务，该选项则不会生效</br>
                                2、实际系统使用中请根据客户购买的转换服务进行勾选
                            </td>
                        </tr>

                        <tr>
                            <td class="td_normal_title" width=20%>
                                ofd文件转换来源
                            </td>
                            <td colspan="3">
                                <xform:radio property="value(ofdFileFrom)">
                                    <xform:enumsDataSource enumsType="kmImissive_config_ofdFileFrom"></xform:enumsDataSource>
                                </xform:radio><br/>
                                注:</br>
                                1、若系统没有购买任何pdf转换服务，该选项则不会生效</br>
                                2、实际系统使用中请根据客户购买的转换服务进行勾选
                            </td>
                        </tr>

                        <tr>
                            <td class="td_normal_title" width="15%">wps加载项可使用者</td>
                            <td width="85%" colspan='3'>
                                <xform:address propertyId="value(authReaderIds)" propertyName="value(authReaderNames)"
                                               mulSelect="true" orgType="ORG_TYPE_ALL" showStatus="edit"
                                               style="width:97%;height:90px;"/>
                                <br><span class="com_help">为空保持不变</span>
                            </td>
                        </tr>

                        <tr >
                            <td class="td_normal_title" width=20%>
                                E签宝版本设置
                            </td>
                            <td colspan="3">
                                <xform:radio property="value(eqbSignatureChoice)" onValueChange="changeEqbSignature(this.value);">
                                    <xform:enumsDataSource enumsType="kmImissive_eqb_signature"></xform:enumsDataSource>
                                </xform:radio>
                                <span id="eqbSign">
                                    <br>
                                    <br>
                                    企业名称&nbsp;&nbsp; <xform:text property="value(eqbEnterpriseName)" subject="企业名称" style="width:90%" showStatus="edit" /><br>
                                    企业证件号<xform:text property="value(eqbEnterpriseId)" subject="企业证件号" style="width:90%" showStatus="edit" /><br>
                                </span>
                            </td>
                        </tr>
                    </table>
                    <div style="margin-bottom: 10px;margin-top:25px">
                        <ui:button text="${lfn:message('button.save')}" suspend="bottom" height="35" width="120"
                                   onclick="commitMethod();" order="1">
                        </ui:button>
                    </div>
                </center>
            </div>
        </html:form>
        <script>
            Com_IncludeFile("jquery.js");
        </script>
        <script type="text/javascript">
            // 持久化的督办立项模板是否存在: true 存在
            window.templateExistFlag = true;
            // 是否已重新选择模板
            window.reSelectTemplate = false;
            // 存放旧的督办立项模板
            let oldTemplateId = "";

            $(document).ready(function () {
                oldTemplateId = $('[name="value(fdSuperviseTemplateId)"]').val();
                window.templateExistFlag = existSuperviseTemplate();
                if (!window.templateExistFlag) {
                    let element = '<p id="superviseTipBox">所选模板已被删除或未开启，请重新选择！<p>';
                    $("#dialogSuperTemplateBox").append(element);
                }
            });

            /**
             * 选择督办立项模板
             */
            window.dialogSuperTemplate = function () {
                // 如果不存在模板，先将模板的值置为空，否则弹出框报错
                if (!templateExistFlag && !reSelectTemplate) {
                    $('[name="value(fdSuperviseTemplateId)"]').val("");
                }
                dialog.category('com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
                    'value(fdSuperviseTemplateId)', 'value(fdSuperviseTemplateName)',
                    false, function (rtn) {
                        if ($.isPlainObject(rtn)) {
                            reSelectTemplate = true;
                            if ($("#superviseTipBox").length > 0) {
                                $("#superviseTipBox").remove();
                            }
                        } else {
                            // 回写ID
                            let curId = $('[name="value(fdSuperviseTemplateId)"]').val();
                            if (oldTemplateId && !curId) {
                                $('[name="value(fdSuperviseTemplateId)"]').val(oldTemplateId);
                            }
                        }
                    });
            }

            function existSuperviseTemplate() {
                let isExist = true;
                let superviseTemplateId = $('[name="value(fdSuperviseTemplateId)"]').val();
                if (superviseTemplateId) {
                    $.ajax({
                        url: "${LUI_ContextPath}/km/imissive/km_imissive_main/kmImissiveMain.do?method=existSuperviseTemplate",
                        type: "GET",
                        data: {
                            curTemplateId: superviseTemplateId
                        },
                        async: false,
                        success: function (res) {
                            if (res === "false" || !res) {
                                isExist = false;
                            }
                        }
                    });
                }
                return isExist;
            }
        </script>
        <script>
            function changeDisplayMode(value) {
                if (value == '3') {
                    $('#navModeTr').show();
                } else {
                    $('#navModeTr').hide();
                }
                if (value != '3' && value != '2') {
                    $('.displayType').show();
                } else {
                    $('.displayType').hide();
                }
            }

            function changeEqbSignature(value){
                if(value == '1'){
                    $('#eqbSign').hide();
                }else{
                    $('#eqbSign').show();
                }
            }

            function commitMethod(value) {
                var flag = true;
                var expandDoc4Send = document.getElementsByName("expandDoc4Send")[0];
                var expandBaseInfo4Send = document.getElementsByName("expandBaseInfo4Send")[0];
                var expandDoc4Receive = document.getElementsByName("expandDoc4Receive")[0];
                var expandBaseInfo4Receive = document.getElementsByName("expandBaseInfo4Receive")[0];
                var expandDoc4Sign = document.getElementsByName("expandDoc4Sign")[0];
                var expandBaseInfo4Sign = document.getElementsByName("expandBaseInfo4Sign")[0];
                if (!expandDoc4Send.checked && !expandBaseInfo4Send.checked) {
                    alert('<bean:message bundle="km-imissive" key="setting.display.notNull.send"/>');
                    flag = false;
                }
                if (!expandDoc4Receive.checked && !expandBaseInfo4Receive.checked) {
                    alert('<bean:message bundle="km-imissive" key="setting.display.notNull.receive"/>');
                    flag = false;
                }
                if (!expandDoc4Sign.checked && !expandBaseInfo4Sign.checked) {
                    alert('<bean:message bundle="km-imissive" key="setting.display.notNull.sign"/>');
                    flag = false;
                }
                if (flag) {
                    Com_Submit(document.sysAppConfigForm, 'update');
                }
            }

            function changeValue() {
                var showImgDoc = document.getElementsByName("value(showImgDoc)")[0];
                if (showImgDoc.value == "1") {
                    document.getElementById("showImg4ContentDiv").style.display = "none";
                    document.getElementById("showImg4DocDiv").style.display = "none";
                } else {
                    document.getElementById("showImg4ContentDiv").style.display = "block";
                    document.getElementById("showImg4DocDiv").style.display = "block";
                }
            }

            function changeValue4Doc() {
                var showImg4Doc = document.getElementsByName("showImg4Doc")[0];
                var showImg4Docvalue = document.getElementsByName("value(showImg4Doc)")[0];
                if (showImg4Doc.checked) {
                    showImg4Docvalue.value = "2";
                } else {
                    showImg4Docvalue.value = "1";

                }
            }

            function changeValue4Content() {
                var showImg4Content = document.getElementsByName("showImg4Content")[0];
                var showImg4Contentvalue = document.getElementsByName("value(showImg4Content)")[0];
                if (showImg4Content.checked) {
                    showImg4Contentvalue.value = "2";
                } else {
                    showImg4Contentvalue.value = "1";
                }
            }

            function changeDocValue4Send() {
                var expandDoc4Send = document.getElementsByName("expandDoc4Send")[0];
                var expandDocvalue4Send = document.getElementsByName("value(expandDoc4Send)")[0];
                if (expandDoc4Send.checked) {
                    expandDocvalue4Send.value = "1";
                } else {
                    expandDocvalue4Send.value = "2";
                }
            }

            function changeDocValue4Receive() {
                var expandDoc4Receive = document.getElementsByName("expandDoc4Receive")[0];
                var expandDocvalue4Receive = document.getElementsByName("value(expandDoc4Receive)")[0];
                if (expandDoc4Receive.checked) {
                    expandDocvalue4Receive.value = "1";
                } else {
                    expandDocvalue4Receive.value = "2";
                }
            }

            function changeDocValue4Sign() {
                var expandDoc4Sign = document.getElementsByName("expandDoc4Sign")[0];
                var expandDocvalue4Sign = document.getElementsByName("value(expandDoc4Sign)")[0];
                if (expandDoc4Sign.checked) {
                    expandDocvalue4Sign.value = "1";
                } else {
                    expandDocvalue4Sign.value = "2";
                }
            }

            function changeBaseInfoValue4Send() {
                var expandBaseInfo4Send = document.getElementsByName("expandBaseInfo4Send")[0];
                var expandBaseInfovalue4Send = document.getElementsByName("value(expandBaseInfo4Send)")[0];
                if (expandBaseInfo4Send.checked) {
                    expandBaseInfovalue4Send.value = "1";
                } else {
                    expandBaseInfovalue4Send.value = "2";
                }
            }

            function changeBaseInfoValue4Receive() {
                var expandBaseInfo4Receive = document.getElementsByName("expandBaseInfo4Receive")[0];
                var expandBaseInfovalue4Receive = document.getElementsByName("value(expandBaseInfo4Receive)")[0];
                if (expandBaseInfo4Receive.checked) {
                    expandBaseInfovalue4Receive.value = "1";
                } else {
                    expandBaseInfovalue4Receive.value = "2";
                }
            }

            function changeBaseInfoValue4Sign() {
                var expandBaseInfo4Sign = document.getElementsByName("expandBaseInfo4Sign")[0];
                var expandBaseInfovalue4Sign = document.getElementsByName("value(expandBaseInfo4Sign)")[0];
                if (expandBaseInfo4Sign.checked) {
                    expandBaseInfovalue4Sign.value = "1";
                } else {
                    expandBaseInfovalue4Sign.value = "2";
                }
            }

            function changeReadOpinion() {
                var readOpinion = document.getElementsByName("readOpinion")[0];
                var readOpinionvalue = document.getElementsByName("value(readOpinion)")[0];
                if (readOpinion.checked) {
                    readOpinionvalue.value = "1";
                } else {
                    readOpinionvalue.value = "0";
                }
            }

            //pdf格式
            function changePdfFormat() {
                var pdfFormat = document.getElementsByName("pdfFormat")[0];
                var pdfFormatValue = document.getElementsByName("value(pdfFormat)")[0];
                if (pdfFormat.checked) {
                    pdfFormatValue.value = "1";
                } else {
                    pdfFormatValue.value = "0";
                }
            }

            //ofd格式
            function changeOfdFormat() {
                var ofdFormat = document.getElementsByName("ofdFormat")[0];
                var ofdFormatValue = document.getElementsByName("value(ofdFormat)")[0];
                if (ofdFormat.checked) {
                    ofdFormatValue.value = "1";
                } else {
                    ofdFormatValue.value = "0";
                }
            }

            //发文正文
            function changeSendContent(){
                var pdfFormat=document.getElementsByName("sendContent")[0];
                var pdfFormatValue=document.getElementsByName("value(sendContent)")[0];
                if(pdfFormat.checked){
                    pdfFormatValue.value="1";
                }else{
                    pdfFormatValue.value="0";
                }
            }

            //收文正文
            function changeReceiveContent(){
                var ofdFormat=document.getElementsByName("receiveContent")[0];
                var ofdFormatValue=document.getElementsByName("value(receiveContent)")[0];
                if(ofdFormat.checked){
                    ofdFormatValue.value="1";
                }else{
                    ofdFormatValue.value="0";
                }
            }

            function changeDeliverOpinion() {
                var deliverOpinion = document.getElementsByName("deliverOpinion")[0];
                var deliverOpinionvalue = document.getElementsByName("value(deliverOpinion)")[0];
                if (deliverOpinion.checked) {
                    deliverOpinionvalue.value = "1";
                } else {
                    deliverOpinionvalue.value = "0";
                }
            }

            function changeAttAuthFlag() {
                var attAuthFlag = document.getElementsByName("attAuthFlag")[0];
                var attAuthFlagvalue = document.getElementsByName("value(attAuthFlag)")[0];
                if (attAuthFlag.checked) {
                    attAuthFlagvalue.value = "1";
                } else {
                    attAuthFlagvalue.value = "0";
                }
            }

            function changeShowRelation() {
                var showRelation = document.getElementsByName("showRelation")[0];
                var showRelationvalue = document.getElementsByName("value(showRelation)")[0];
                if (showRelation.checked) {
                    showRelationvalue.value = "1";
                } else {
                    showRelationvalue.value = "0";
                }
            }

            function changeSpreadAuth() {
                var spreadAuth = document.getElementsByName("spreadAuth")[0];
                var spreadAuthvalue = document.getElementsByName("value(spreadAuth)")[0];
                if (spreadAuth.checked) {
                    spreadAuthvalue.value = "1";
                } else {
                    spreadAuthvalue.value = "0";
                }
            }

            function changeAuditOpinionCate() {
                var auditOpinionCate = document.getElementsByName("auditOpinionCate")[0];
                var auditOpinionCatevalue = document.getElementsByName("value(auditOpinionCate)")[0];
                if (auditOpinionCate.checked) {
                    auditOpinionCatevalue.value = "1";
                } else {
                    auditOpinionCatevalue.value = "0";
                }
            }


            function changeBusinessAuth() {
                var businessAuth = document.getElementsByName("businessAuth")[0];
                var businessAuthvalue = document.getElementsByName("value(businessAuth)")[0];
                if (businessAuth.checked) {
                    businessAuthvalue.value = "1";
                } else {
                    businessAuthvalue.value = "0";
                }
            }

            function changeSpreadAuth() {
                var spreadAuth = document.getElementsByName("spreadAuth")[0];
                var spreadAuthvalue = document.getElementsByName("value(spreadAuth)")[0];
                if (spreadAuth.checked) {
                    spreadAuthvalue.value = "1";
                } else {
                    spreadAuthvalue.value = "0";
                }
            }


            $(document).ready(function () {
                init();
                var displayMode = document.getElementsByName("value(displayMode)");
                for (var i = 0; i < displayMode.length; i++) {
                    if (displayMode[i].checked) {
                        changeDisplayMode(displayMode[i].value);
                    }
                }
                var eqbSignatureChoice=document.getElementsByName("value(eqbSignatureChoice)");
                for(var i=0;i<eqbSignatureChoice.length;i++){
                    if(eqbSignatureChoice[i].checked){
                        changeEqbSignature(eqbSignatureChoice[i].value);
                    }
                }
            });
            LUI.ready(function () {
                changeValue();
            });

            /****
             * 初始化
             */
            function init() {
                //发文展现配置
                var expandDoc4Send = document.getElementsByName("expandDoc4Send")[0];
                var expandDocvalue4Send = document.getElementsByName("value(expandDoc4Send)")[0];
                if (expandDocvalue4Send.value == "2") {
                    expandDoc4Send.checked = false;
                } else {
                    expandDoc4Send.checked = true;
                }
                var expandBaseInfo4Send = document.getElementsByName("expandBaseInfo4Send")[0];
                var expandBaseInfovalue4Send = document.getElementsByName("value(expandBaseInfo4Send)")[0];
                if (expandBaseInfovalue4Send.value == "2") {
                    expandBaseInfo4Send.checked = false;
                } else {
                    expandBaseInfo4Send.checked = true;
                }
                //收文展现配置
                var expandDoc4Receive = document.getElementsByName("expandDoc4Receive")[0];
                var expandDocvalue4Receive = document.getElementsByName("value(expandDoc4Receive)")[0];
                if (expandDocvalue4Receive.value == "2") {
                    expandDoc4Receive.checked = false;
                } else {
                    expandDoc4Receive.checked = true;
                }
                var expandBaseInfo4Receive = document.getElementsByName("expandBaseInfo4Receive")[0];
                var expandBaseInfovalue4Receive = document.getElementsByName("value(expandBaseInfo4Receive)")[0];
                if (expandBaseInfovalue4Receive.value == "2") {
                    expandBaseInfo4Receive.checked = false;
                } else {
                    expandBaseInfo4Receive.checked = true;
                }
                //签报展现配置
                var expandDoc4Sign = document.getElementsByName("expandDoc4Sign")[0];
                var expandDocvalue4Sign = document.getElementsByName("value(expandDoc4Sign)")[0];
                if (expandDocvalue4Sign.value == "2") {
                    expandDoc4Sign.checked = false;
                } else {
                    expandDoc4Sign.checked = true;
                }
                var expandBaseInfo4Sign = document.getElementsByName("expandBaseInfo4Sign")[0];
                var expandBaseInfovalue4Sign = document.getElementsByName("value(expandBaseInfo4Sign)")[0];
                if (expandBaseInfovalue4Sign.value == "2") {
                    expandBaseInfo4Sign.checked = false;
                } else {
                    expandBaseInfo4Sign.checked = true;
                }

                var showImg4Doc = document.getElementsByName("showImg4Doc")[0];
                var showImg4Docvalue = document.getElementsByName("value(showImg4Doc)")[0];
                if (showImg4Docvalue.value == "2") {
                    showImg4Doc.checked = true;
                } else {
                    showImg4Doc.checked = false;
                }
                var showImg4Content = document.getElementsByName("showImg4Content")[0];
                var showImg4Contentvalue = document.getElementsByName("value(showImg4Content)")[0];
                if (showImg4Contentvalue.value == "2") {
                    showImg4Content.checked = true;
                } else {
                    showImg4Content.checked = false;
                }

                var readOpinion = document.getElementsByName("readOpinion")[0];
                var readOpinionvalue = document.getElementsByName("value(readOpinion)")[0];
                if (readOpinionvalue.value == "1") {
                    readOpinion.checked = true;
                } else {
                    readOpinion.checked = false;
                }

                //pdf格式
                var pdfFormat = document.getElementsByName("pdfFormat")[0];
                var pdfFormatValue = document.getElementsByName("value(pdfFormat)")[0];
                if (!pdfFormatValue) return;
                if (pdfFormatValue.value == "1") {
                    pdfFormat.checked = true;
                } else {
                    pdfFormat.checked = false;
                }

                //ofd格式
                var ofdFormat = document.getElementsByName("ofdFormat")[0];
                var ofdFormatValue = document.getElementsByName("value(ofdFormat)")[0];
                if (!ofdFormatValue) return;
                if (ofdFormatValue.value == "1") {
                    ofdFormat.checked = true;
                } else {
                    ofdFormat.checked = false;
                }

                //发文正文
                var sendContent=document.getElementsByName("sendContent")[0];
                var sendContentValue=document.getElementsByName("value(sendContent)")[0];
                if(!sendContentValue) return;
                if(sendContentValue.value=="1"){
                    sendContent.checked = true;
                }else{
                    sendContent.checked = false;
                }

                //收文正文
                var receiveContent=document.getElementsByName("receiveContent")[0];
                var receiveContentValue=document.getElementsByName("value(receiveContent)")[0];
                if(!receiveContentValue) return;
                if(receiveContentValue.value=="1"){
                    receiveContent.checked = true;
                }else{
                    receiveContent.checked = false;
                }

                var deliverOpinion = document.getElementsByName("deliverOpinion")[0];
                var deliverOpinionvalue = document.getElementsByName("value(deliverOpinion)")[0];
                if (deliverOpinionvalue.value == "1") {
                    deliverOpinion.checked = true;
                } else {
                    deliverOpinion.checked = false;
                }
                var attAuthFlag = document.getElementsByName("attAuthFlag")[0];
                var attAuthFlagvalue = document.getElementsByName("value(attAuthFlag)")[0];
                if (attAuthFlagvalue.value == "1") {
                    attAuthFlag.checked = true;
                } else {
                    attAuthFlag.checked = false;
                }

                /*
                var showRelation=document.getElementsByName("showRelation")[0];
                var showRelationvalue=document.getElementsByName("value(showRelation)")[0];
                if(showRelationvalue.value=="1"){
                    showRelation.checked = true;
                }else{
                    showRelation.checked = false;
                }
                var spreadAuth=document.getElementsByName("spreadAuth")[0];
                var spreadAuthvalue=document.getElementsByName("value(spreadAuth)")[0];
                if(spreadAuthvalue.value=="1"){
                    spreadAuth.checked = true;
                }else{
                    spreadAuth.checked = false;
                }
                */
            }
        </script>
    </template:replace>
</template:include>