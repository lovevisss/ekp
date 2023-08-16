<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/resource/jsp/common.jsp" %>
<kmss:showWfPropertyValues var="nodevalue" idValue="${kmImissiveSendMainForm.fdId}" propertyName="nodeName"/>
<script type="text/javascript">
    function saveAttTrack(fdFileId, fdFileName, type, fdNodeName) {
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
    }


    function LoadWpsHeadWordList(fdModelName, attKey) {
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
                DoLoadWpsHeadWordList(fdModelName, attKey);
            });
        } else {
            dialog.alert("wps加载异常，操作失败！");
        }
    }

    function LoadWpsCenterHeadWordList(fdModelName, attKey) {
        var wpsObject;
        if (attKey == 'editonline' && wps_center_editonline) {
            wpsObject = wps_center_editonline;
        }
        if (attKey == 'mainonline' && wps_center_mainonline) {
            wpsObject = wps_center_mainonline;
        }
        if (wpsObject) {
            if (!wpsObject.hasLoad) {
                dialog.alert("当前正文内容未加载，请切换到正文页签加载正文后操作！");
                return;
            }
            var savePromise = wpsObject.wpsObj.save();
            savePromise.then(function (rtn) {
                DoLoadWpsCenterHeadWordList(fdModelName, attKey);
            });
        } else {
            dialog.alert("wps加载异常，操作失败！");
        }
    }

    function DoLoadWpsHeadWordList(fdModelName, attKey) {
        var flag = true;
        if (flag) {
            var lock = true;//#169596防止多次点击
            Dialog_SimpleCategoryForNewFile("com.landray.kmss.km.imissive.model.KmImissiveRedHeadTemplate", "createUrl?&fdTemplateId=!{id}&fdTemplateName=!{name}", false, true, "02", function (rtnVal) {
                var selAttId = rtnVal[0].id;
                try {
                    if (selAttId != null) {
                        if(!lock){
                            console.log("请勿重复提交");
                            return;
                        }
                        lock = false;
                        function addBookMarksByWpsCloud() {
                            var result = {};
                            var json = {};
                            var jsonStr = "<c:out value='${bookmarkJson}'/>"
                            var fdContent = "";
                            if (jsonStr != "") {
                                var theString = '${bookmarkJson}';
                                var bookmarksStr = 'docsubject,doctype,secretgrade,emergency,content,docnum,checker,signature,drafter,drafttime,deadtime,sendunit,draftunit,draftdept,maintounit,copytounit,reporttounit,maintoperson,copytoperson,reporttoperson,signdatecn,signdaten,signdate,printnum,printpagenum,printunit,printtimen,printtime,printtimecn,level,version,secretyear,reserveone,reservetwo,reservethree,reservefour,reservefive';
                                //var json = JSON.parse(theString);
                                theString = theString.replace(/[\n\r]/g, "");
                                json = (new Function("return (" + theString + ");"))();

                                for (var o in json) {
                                    var objVal = json[o];
                                    if (objVal) {
                                        objVal = objVal.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                    }
                                    if (bookmarksStr.indexOf(o) == -1) {
                                        var _fdObjE = document.getElementsByName("_extendDataFormInfo.value(" + o + ")");
                                        var fdObjE = document.getElementsByName("extendDataFormInfo.value(" + o + ")");
                                        var fdObjNameE = document.getElementsByName("extendDataFormInfo.value(" + o + ".name)");
                                        if (_fdObjE.length > 0) {
                                            objVal = '';
                                            for (var i = 0; i < _fdObjE.length; i++) {
                                                if (_fdObjE[i].type == 'checkbox' && _fdObjE[i].checked) {
                                                    objVal += _fdObjE[i].nextSibling.innerText + ";"
                                                }
                                            }
                                        } else if (fdObjE.length > 0) {
                                            objVal = '';
                                            if (fdObjE[0].nodeName.toLowerCase() == 'select') {
                                                var index = fdObjE[0].selectedIndex;
                                                objVal = fdObjE[0].options[index].text;
                                            } else if (fdObjE[0].type == 'radio') {
                                                for (var i = 0; i < fdObjE.length; i++) {
                                                    if (fdObjE[i].type == 'radio' && fdObjE[i].checked) {
                                                        objVal = fdObjE[i].nextSibling.nodeValue ? fdObjE[i].nextSibling.nodeValue : fdObjE[i].nextSibling.innerText;
                                                    }
                                                }
                                            } else {
                                                objVal = fdObjE[0].value;
                                            }
                                        } else if (fdObjNameE.length > 0) {
                                            objVal = fdObjNameE[0].value;

                                        }
                                        result[o] = objVal;
                                    } else {
                                        if (o == 'content') {
                                            fdContent = objVal;
                                        }
                                    }
                                }
                            }

                            //文种
                            var fdDocTypeNameE = document.getElementsByName("fdDocTypeId");
                            var fdDocTypeName = ""
                            if (fdDocTypeNameE.length > 0) {
                                var index = fdDocTypeNameE[0].selectedIndex;
                                fdDocTypeName = fdDocTypeNameE[0].options[index].text;
                            } else {
                                fdDocTypeName = json['doctype'];
                                if (fdDocTypeName) {
                                    fdDocTypeName = fdDocTypeName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['doctype'] = fdDocTypeName;

                            //密级
                            var fdSecretGradeNameE = document.getElementsByName("fdSecretGradeId");
                            var fdSecretGradeName = "";
                            if (fdSecretGradeNameE.length > 0) {
                                var index = fdSecretGradeNameE[0].selectedIndex
                                fdSecretGradeName = fdSecretGradeNameE[0].options[index].text;
                            } else {
                                fdSecretGradeName = json['secretgrade'];
                                if (fdSecretGradeName) {
                                    fdSecretGradeName = fdSecretGradeName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['secretgrade'] = fdSecretGradeName;

                            //缓急
                            var fdEmergencyGradeNameE = document.getElementsByName("fdEmergencyGradeId");
                            var fdEmergencyGradeName = "";
                            if (fdEmergencyGradeNameE.length > 0) {
                                var index = fdEmergencyGradeNameE[0].selectedIndex
                                fdEmergencyGradeName = fdEmergencyGradeNameE[0].options[index].text;
                            } else {
                                fdEmergencyGradeName = json['emergency'];
                                if (fdEmergencyGradeName) {
                                    fdEmergencyGradeName = fdEmergencyGradeName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['emergency'] = fdEmergencyGradeName;

                            //标题
                            var docSubjectE = document.getElementsByName("docSubject");
                            var docSubject = "";
                            if (docSubjectE.length > 0 && docSubjectE[0].value != '') {
                                docSubject = docSubjectE[0].value;
                            } else {
                                docSubject = json['docsubject'];
                                if (docSubject) {
                                    docSubject = docSubject.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['docsubject'] = docSubject;

                            //备注
                            var fdContentE = document.getElementsByName("fdContent");
                            if (fdContentE.length > 0 && fdContentE[0].value != '') {
                                fdContent = fdContentE[0].value;
                            }
                            result['content'] = fdContent;

                            // 发文文号
                            var fdDocNumE = document.getElementsByName("fdDocNum");
                            var fdDocNum = "";
                            if (fdDocNumE.length > 0 && fdDocNumE[0].value != '') {
                                fdDocNum = fdDocNumE[0].value;
                            } else {
                                fdDocNum = json['docnum'];
                                if (fdDocNum) {
                                    fdDocNum = fdDocNum.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['docnum'] = fdDocNum;

                            var fdDocFlow = json['docflow'];
                            if (fdDocFlow) {
                                fdDocFlow = fdDocFlow.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                            }
                            result['docflow'] = fdDocFlow;

                            var fdCheckerNameE = document.getElementsByName("fdCheckerName");
                            var fdCheckerName = "";
                            if (fdCheckerNameE.length > 0 && fdCheckerNameE[0].value != '') {
                                fdCheckerName = fdCheckerNameE[0].value;
                            } else {
                                fdCheckerName = json['checker'];
                                if (fdCheckerName) {
                                    fdCheckerName = fdCheckerName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['checker'] = fdCheckerName;

                            var fdSignatureNameE = document.getElementsByName("fdSignatureName");
                            var fdSignatureName = "";
                            if (fdSignatureNameE.length > 0 && fdSignatureNameE[0].value != '') {
                                fdSignatureName = fdSignatureNameE[0].value;
                            } else {
                                fdSignatureName = json['signature'];
                                if (fdSignatureName) {
                                    fdSignatureName = fdSignatureName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['signature'] = fdSignatureName;

                            var fdDrafterNameE = document.getElementsByName("fdDrafterName");
                            var fdDrafterName = "";
                            if (fdDrafterNameE.length > 0 && fdDrafterNameE[0].value != '') {
                                fdDrafterName = fdDrafterNameE[0].value;
                            } else {
                                fdDrafterName = json['drafter'];
                                if (fdDrafterName) {
                                    fdDrafterName = fdDrafterName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['drafter'] = fdDrafterName;

                            // 起草时间
                            var fdDraftTimeE = document.getElementsByName("fdDraftTime");
                            var fdDraftTime = "";
                            if (fdDraftTimeE.length > 0 && fdDraftTimeE[0].value != '') {
                                fdDraftTime = fdDraftTimeE[0].value;
                            } else {
                                fdDraftTime = "<c:out value='${kmImissiveSendMainForm.fdDraftTime}'/>";
                            }
                            result['drafttime'] = fdDraftTime;

                            // 限办时间
                            var fdDeadTimeE = document.getElementsByName("fdDeadTime");
                            var fdDeadTime = "";
                            if (fdDeadTimeE.length > 0 && fdDeadTimeE[0].value != '') {
                                fdDeadTime = fdDeadTimeE[0].value;
                            } else {
                                fdDeadTime = "<c:out value='${kmImissiveSendMainForm.fdDeadTime}'/>";
                            }
                            result['deadtime'] = fdDeadTime;

                            //发文单位
                            var fdSendtoUnitNameE = document.getElementsByName("fdSendtoUnitName");
                            var fdSendtoUnitName = "";
                            if (fdSendtoUnitNameE.length > 0 && fdSendtoUnitNameE[0].value != '') {
                                fdSendtoUnitName = fdSendtoUnitNameE[0].value;
                            }
                            var unitName = fdSendtoUnitName;
                            var fdOtherSendUnitNamesE = document.getElementsByName("fdOtherSendUnitNames");
                            var fdOtherSendUnitNames = "";
                            if (fdOtherSendUnitNamesE.length > 0 && fdOtherSendUnitNamesE[0].value != '') {
                                fdOtherSendUnitNames = fdOtherSendUnitNamesE[0].value;
                            }
                            if (fdOtherSendUnitNames != '' && '${kmImissiveSendMainForm.fdIsJoint}' == '2') {
                                unitName += ";" + fdOtherSendUnitNames;
                            } else {
                                unitName = json['sendunit'];
                                if (unitName) {
                                    unitName = unitName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['sendunit'] = unitName;

                            //拟文单位
                            var fdDraftUnitNameE = document.getElementsByName("fdDraftUnitName");
                            var fdDraftUnitName = "";
                            if (fdDraftUnitNameE.length > 0 && fdDraftUnitNameE[0].value != '') {
                                fdDraftUnitName = fdDraftUnitNameE[0].value;
                            } else {
                                fdDraftUnitName = json['draftunit'];
                                if (fdDraftUnitName) {
                                    fdDraftUnitName = fdDraftUnitName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['draftunit'] = fdDraftUnitName;

                            //拟稿部门
                            var fdDraftDeptNameE = document.getElementsByName("fdDraftDeptName");
                            var fdDraftDeptName = "";
                            if (fdDraftDeptNameE.length > 0 && fdDraftDeptNameE[0].value != '') {
                                fdDraftDeptName = fdDraftDeptNameE[0].value;
                            } else {
                                fdDraftDeptName = json['draftdept'];
                                if (fdDraftDeptName) {
                                    fdDraftDeptName = fdDraftDeptName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['draftdept'] = fdDraftDeptName;

                            //主送
                            var fdMaintoNamesE = document.getElementsByName("fdMaintoNames");
                            var fdMaintoNames = "";
                            if (fdMaintoNamesE.length > 0 && fdMaintoNamesE[0].value != '') {
                                fdMaintoNames = fdMaintoNamesE[0].value;
                            } else {
                                fdMaintoNames = json['maintounit'];
                                if (fdMaintoNames) {
                                    fdMaintoNames = fdMaintoNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            //if(fdMaintoNames != ""){
                            //	fdMaintoNames = fdMaintoNames.replace(new RegExp(";",'g'),"、");
                            //}
                            result['maintounit'] = fdMaintoNames;

                            //抄送
                            var fdCopytoNamesE = document.getElementsByName("fdCopytoNames");
                            var fdMaintoNames = "";
                            if (fdCopytoNamesE.length > 0 && fdCopytoNamesE[0].value != '') {
                                fdCopytoNames = fdCopytoNamesE[0].value;
                            } else {
                                fdCopytoNames = json['copytounit'];
                                if (fdCopytoNames) {
                                    fdCopytoNames = fdCopytoNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            //if(fdCopytoNames != ""){
                            //	fdCopytoNames = fdCopytoNames.replace(new RegExp(";",'g'),"、");
                            //}
                            result['copytounit'] = fdCopytoNames;

                            //抄报
                            var fdReporttoNamesE = document.getElementsByName("fdReporttoNames");
                            var fdReporttoNames = "";
                            if (fdReporttoNamesE.length > 0 && fdReporttoNamesE[0].value != '') {
                                fdReporttoNames = fdReporttoNamesE[0].value;
                            } else {
                                fdReporttoNames = json['reporttounit'];
                                if (fdReporttoNames) {
                                    fdReporttoNames = fdReporttoNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            //if(fdReporttoNames != ""){
                            //	fdReporttoNames = fdReporttoNames.replace(new RegExp(";",'g'),"、");
                            //}
                            result['reporttounit'] = fdReporttoNames;

                            //主送个人
                            var fdMissiveMpersonNamesE = document.getElementsByName("fdMissiveMpersonNames");
                            var fdMissiveMpersonNames = "";
                            if (fdMissiveMpersonNamesE.length > 0 && fdMissiveMpersonNamesE[0].value != '') {
                                fdMissiveMpersonNames = fdMissiveMpersonNamesE[0].value;
                            } else {
                                fdMissiveMpersonNames = json['maintoperson'];
                                if (fdMissiveMpersonNames) {
                                    fdMissiveMpersonNames = fdMissiveMpersonNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            //if(fdMissiveMpersonNames != ""){
                            //	fdMissiveMpersonNames = fdMissiveMpersonNames.replace(new RegExp(";",'g'),"、");
                            //}
                            result['maintoperson'] = fdMissiveMpersonNames;

                            //抄送个人
                            var fdMissiveCpersonNamesE = document.getElementsByName("fdMissiveCpersonNames");
                            var fdMissiveCpersonNames = "";
                            if (fdMissiveCpersonNamesE.length > 0 && fdMissiveCpersonNamesE[0].value != '') {
                                fdMissiveCpersonNames = fdMissiveCpersonNamesE[0].value;
                            } else {
                                fdMissiveCpersonNames = json['copytoperson'];
                                if (fdMissiveCpersonNames) {
                                    fdMissiveCpersonNames = fdMissiveCpersonNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            //if(fdMissiveCpersonNames != ""){
                            //	fdMissiveCpersonNames = fdMissiveCpersonNames.replace(new RegExp(";",'g'),"、");
                            //}
                            result['copytoperson'] = fdMissiveCpersonNames;

                            //抄报个人
                            var fdMissiveRpersonNamesE = document.getElementsByName("fdMissiveRpersonNames");
                            var fdMissiveRpersonNames = "";
                            if (fdMissiveRpersonNamesE.length > 0 && fdMissiveRpersonNamesE[0].value != '') {
                                fdMissiveRpersonNames = fdMissiveRpersonNamesE[0].value;
                            } else {
                                fdMissiveRpersonNames = json['reporttoperson'];
                                if (fdMissiveRpersonNames) {
                                    fdMissiveRpersonNames = fdMissiveRpersonNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            //if(fdMissiveRpersonNames != ""){
                            //	fdMissiveRpersonNames = fdMissiveRpersonNames.replace(new RegExp(";",'g'),"、");
                            //}
                            result['reporttoperson'] = fdMissiveRpersonNames;

                            //签发日期（大写）
                            var docPublishTimeUpperE = document.getElementsByName("docPublishTimeUpper");
                            var docPublishTimeUpper = "";
                            if (docPublishTimeUpperE.length > 0 && docPublishTimeUpperE[0].value != '') {
                                docPublishTimeUpper = docPublishTimeUpperE[0].value;
                            } else {
                                docPublishTimeUpper = "<c:out value='${kmImissiveSendMainForm.docPublishTimeUpper}'/>";
                            }
                            result['signdatecn'] = docPublishTimeUpper;

                            //签发日期
                            var docPublishTimeNumE = document.getElementsByName("docPublishTimeNum");
                            var docPublishTimeNum = "";
                            if (docPublishTimeNumE.length > 0 && docPublishTimeNumE[0].value != '') {
                                docPublishTimeNum = docPublishTimeNumE[0].value;
                            } else {
                                docPublishTimeNum = "<c:out value='${kmImissiveSendMainForm.docPublishTimeNum}'/>";
                            }
                            result['signdate'] = docPublishTimeNum;

                            //签发日期
                            var docPublishTimeE = document.getElementsByName("docPublishTime");
                            var docPublishTime = "";
                            if (docPublishTimeE.length > 0 && docPublishTimeE[0].value != '') {
                                docPublishTime = docPublishTimeE[0].value;
                                //异步更新签发日期大写书签
                                var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=transferTime";
                                $.ajax({
                                    type: "post",
                                    dataType: "json",
                                    url: url,
                                    data: {filed: 'docPublishTime', docPublishTime: docPublishTime},
                                    async: false,    //用同步方式
                                    success: function (rtn) {
                                        if (rtn['docPublishTimeUpper']) {
                                            result['signdatecn'] = rtn['docPublishTimeUpper'];
                                        }
                                        if (rtn['docPublishTimeNum']) {
                                            result['signdate'] = rtn['docPublishTimeNum'];
                                        }
                                    }
                                });
                            } else {
                                docPublishTime = "<c:out value='${kmImissiveSendMainForm.docPublishTime}'/>";
                            }
                            result['signdaten'] = docPublishTime;

                            //打印份数
                            var fdPrintNumE = document.getElementsByName("fdPrintNum");
                            var fdPrintNum = "";
                            if (fdPrintNumE.length > 0 && fdPrintNumE[0].value != '') {
                                fdPrintNum = fdPrintNumE[0].value;
                            } else {
                                fdPrintNum = "<c:out value='${kmImissiveSendMainForm.fdPrintNum}'/>";
                            }
                            result['printnum'] = fdPrintNum;

                            //打印页数
                            var fdPrintPageNumE = document.getElementsByName("fdPrintPageNum");
                            var fdPrintPageNum = "";
                            if (fdPrintPageNumE.length > 0 && fdPrintPageNumE[0].value != '') {
                                fdPrintPageNum = fdPrintPageNumE[0].value;
                            } else {
                                fdPrintPageNum = "<c:out value='${kmImissiveSendMainForm.fdPrintPageNum}'/>";
                            }
                            result['printpagenum'] = fdPrintPageNum;

                            //印发单位
                            var fdPrintUnitNameE = document.getElementsByName("fdPrintUnitName");
                            var fdPrintUnitName = "";
                            if (fdPrintUnitNameE.length > 0 && fdPrintUnitNameE[0].value != '') {
                                fdPrintUnitName = fdPrintUnitNameE[0].value;
                            } else {
                                fdPrintUnitName = json['printunit'];
                                if (fdPrintUnitName) {
                                    fdPrintUnitName = fdPrintUnitName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['printunit'] = fdPrintUnitName;

                            //印发时间
                            var fdPrintTimeNumE = document.getElementsByName("fdPrintTimeNum");
                            var fdPrintTimeNum = "";
                            if (fdPrintTimeNumE.length > 0 && fdPrintTimeNumE[0].value != '') {
                                fdPrintTimeNum = fdPrintTimeNumE[0].value;
                            } else {
                                fdPrintTimeNum = "<c:out value='${kmImissiveSendMainForm.fdPrintTimeNum}'/>";
                            }
                            result['printtime'] = fdPrintTimeNum;

                            //印发时间大写
                            var fdPrintTimeUpperE = document.getElementsByName("fdPrintTimeUpper");
                            var fdPrintTimeUpper = "";
                            if (fdPrintTimeUpperE.length > 0 && fdPrintTimeUpperE[0].value != '') {
                                fdPrintTimeUpper = fdPrintTimeUpperE[0].value;
                            } else {
                                fdPrintTimeUpper = "<c:out value='${kmImissiveSendMainForm.fdPrintTimeUpper}'/>";
                            }
                            result['printtimecn'] = fdPrintTimeUpper;

                            //印发时间
                            var fdPrintTimeE = document.getElementsByName("fdPrintTime");
                            var fdPrintTime = "";
                            if (fdPrintTimeE.length > 0 && fdPrintTimeE[0].value != '') {
                                fdPrintTime = fdPrintTimeE[0].value;
                                //异步更新签发日期大写书签
                                var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=transferTime";
                                $.ajax({
                                    type: "post",
                                    dataType: "json",
                                    url: url,
                                    data: {filed: 'fdPrintTime', fdPrintTime: fdPrintTime},
                                    async: false,    //用同步方式
                                    success: function (rtn) {
                                        if (rtn['fdPrintTimeUpper']) {
                                            result['fdPrintTimeUpper'] = rtn['fdPrintTimeUpper'];
                                        }
                                        if (rtn['fdPrintTimeNum']) {
                                            result['printtime'] = rtn['fdPrintTimeNum'];
                                        }
                                    }
                                });
                            } else {
                                fdPrintTime = "<c:out value='${kmImissiveSendMainForm.fdPrintTime}'/>";
                            }
                            result['printtimen'] = fdPrintTime;

                            //发布层次
                            var fdLevelE = document.getElementsByName("fdLevel");
                            var fdLevel = "";
                            if (fdLevelE.length > 0 && fdLevelE[0].value != '') {
                                fdLevel = fdLevelE[0].value;
                            } else {
                                fdLevel = json['level'];
                                if (fdLevel) {
                                    fdLevel = fdLevel.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['level'] = fdLevel;

                            //版本
                            var fdVersionE = document.getElementsByName("fdVersion");
                            var fdVersion = "";
                            if (fdVersionE.length > 0 && fdVersionE[0].value != '') {
                                fdVersion = fdVersionE[0].value;
                            } else {
                                fdVersion = json['version'];
                                if (fdVersion) {
                                    fdVersion = fdVersion.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['version'] = fdVersion;

                            //保密期限
                            var fdSecretYearE = document.getElementsByName("fdSecretYear");
                            var fdSecretYear = "";
                            if (fdSecretYearE.length > 0 && fdSecretYearE[0].value != '') {
                                fdSecretYear = fdSecretYearE[0].value;
                            } else {
                                fdSecretYear = json['secretyear'];
                                if (fdSecretYear) {
                                    fdSecretYear = fdSecretYear.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['secretyear'] = fdSecretYear;

                            //备用1
                            var fdReserveOneE = document.getElementsByName("fdReserveOne");
                            var fdReserveOne = "";
                            if (fdReserveOneE.length > 0 && fdReserveOneE[0].value != '') {
                                fdReserveOne = fdReserveOneE[0].value;
                            } else {
                                fdReserveOne = json['reserveone'];
                                if (fdReserveOne) {
                                    fdReserveOne = fdReserveOne.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['reserveone'] = fdReserveOne;

                            //备用2
                            var fdReserveTwoE = document.getElementsByName("fdReserveTwo");
                            var fdReserveTwo = "";
                            if (fdReserveTwoE.length > 0 && fdReserveTwoE[0].value != '') {
                                fdReserveTwo = fdReserveTwoE[0].value;
                            } else {
                                fdReserveTwo = json['reservetwo'];
                                if (fdReserveTwo) {
                                    fdReserveTwo = fdReserveTwo.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['reservetwo'] = fdReserveTwo;

                            //备用3
                            var fdReserveThreeE = document.getElementsByName("fdReserveThree");
                            var fdReserveThree = "";
                            if (fdReserveThreeE.length > 0 && fdReserveThreeE[0].value != '') {
                                fdReserveThree = fdReserveThreeE[0].value;
                            } else {
                                fdReserveThree = json['reservethree'];
                                if (fdReserveThree) {
                                    fdReserveThree = fdReserveThree.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['reservethree'] = fdReserveThree;

                            //备用4
                            var fdReserveFourE = document.getElementsByName("fdReserveFour");
                            var fdReserveFour = "";
                            if (fdReserveFourE.length > 0 && fdReserveFourE[0].value != '') {
                                fdReserveFour = fdReserveFourE[0].value;
                            } else {
                                fdReserveFour = json['reservefour'];
                                if (fdReserveFour) {
                                    fdReserveFour = fdReserveFour.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['reservefour'] = fdReserveFour;

                            //备用5
                            var fdReserveFiveE = document.getElementsByName("fdReserveFive");
                            var fdReserveFive = "";
                            if (fdReserveFiveE.length > 0 && fdReserveFiveE[0].value != '') {
                                fdReserveFive = fdReserveFiveE[0].value;
                            } else {
                                fdReserveFive = json['reservefive'];
                                if (fdReserveFive) {
                                    fdReserveFive = fdReserveFive.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['reservefive'] = fdReserveFive;
                            //return result;
                            return JSON.stringify(result);
                        }

                        var books = addBookMarksByWpsCloud();
                        console.log(books);

                        var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=loadWpsHeadWordList";
                        $.ajax({
                        	url:url,
                        	type:"post",
                        	data:{books:books,fdKey:attKey,fdId:"${param.fdId}",nodeName:"${nodevalue}",fdTemplateModelId:selAttId},
                        	async:false,    //用同步方式
                        	success:function(data){
                        		if(data){
                        			seajs.use(['lui/jquery','lui/dialog'], function($, dialog){
                        				var loading=dialog.loading("正在套红中,请稍候...");
                        				setTimeout(wpsSetRedResult, 10*1000);
                        				function wpsSetRedResult(){
                        					var ajaxUrl = Com_Parameter.ContextPath+"km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getSetRedResult&fdId=${JsParam.fdId}&fdKey="+attKey;
                        					$.ajax({
                        						url : ajaxUrl,
                        						type : 'post',
                        						data : {},
                        						dataType : 'text',
                        						async : true,
                        						error : function(){
                        							dialog.alert('请求出错');
                        						} ,
                        						success : function(data) {
                        							if(data == "true"){
                        								loading.hide();
                        								dialog.alert("套红成功",function(){
                        									if(LUI("tabpanelDiv")){
                        										var contents = LUI("tabpanelDiv").contents;
                        								  	   	for(var i = 0;i< contents.length;i++){
                        								  	   		if(contents[i].id == "attContent"){
                        								  	   			LUI("tabpanelDiv").setSelectedIndex(i);
                        								  	   		}
                        								  	   	}
                        									 }
                        									if(attKey == 'editonline'){
                        										wps_cloud_editonline.load();
                        									}else if (attKey == 'mainonline'){
                        										wps_cloud_mainonline.load();
                        									}
                        									redheadFlag = true;
                                                            // 创建撤销套红的摁扭
                                                            createRevokeRedHeadBtn();
                        								});
                        							}else if(data == "false"){
                        								loading.hide();
                        								dialog.alert("套红失败");
                        							}else{
                        								setTimeout(wpsSetRedResult, 2000);
                        							}
                        						}
                        					});
                        				}
                        			});
                        		}
                        	}
                        });
                    } else {//取消
                        return
                    }
                } catch (err) {
                    console.log(err);
                }
            }, true, '<bean:message bundle="km-imissive" key="kmImissiveRedheadset.select"/>');
        }
    }

    function DoLoadWpsCenterHeadWordList(fdModelName, attKey) {
        var flag = true;
        if (flag) {
            var lock = true;//#169596防止多次点击
            Dialog_SimpleCategoryForNewFile("com.landray.kmss.km.imissive.model.KmImissiveRedHeadTemplate", "createUrl?&fdTemplateId=!{id}&fdTemplateName=!{name}", false, true, "02", function (rtnVal) {
                var selAttId = rtnVal[0].id;
                try {
                    if (selAttId != null) {
                        if(!lock){
                            console.log("请勿重复提交");
                            return;
                        }
                        lock = false;
                        function addBookMarksByWpsCenter() {
                            var result = {};
                            var json = {};
                            var jsonStr = "<c:out value='${bookmarkJson}'/>"
                            var fdContent = "";
                            if (jsonStr != "") {
                                var theString = '${bookmarkJson}';
                                var bookmarksStr = 'docsubject,doctype,secretgrade,emergency,content,docnum,checker,signature,drafter,drafttime,deadtime,sendunit,draftunit,draftdept,maintounit,copytounit,reporttounit,maintoperson,copytoperson,reporttoperson,signdatecn,signdaten,signdate,printnum,printpagenum,printunit,printtimen,printtime,printtimecn,level,version,secretyear,reserveone,reservetwo,reservethree,reservefour,reservefive';
                                //var json = JSON.parse(theString);
                                theString = theString.replace(/[\n\r]/g, "");
                                json = (new Function("return (" + theString + ");"))();

                                for (var o in json) {
                                    var objVal = json[o];
                                    if (objVal) {
                                        objVal = objVal.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                    }
                                    if (bookmarksStr.indexOf(o) == -1) {
                                        var _fdObjE = document.getElementsByName("_extendDataFormInfo.value(" + o + ")");
                                        var fdObjE = document.getElementsByName("extendDataFormInfo.value(" + o + ")");
                                        var fdObjNameE = document.getElementsByName("extendDataFormInfo.value(" + o + ".name)");
                                        if (_fdObjE.length > 0) {
                                            objVal = '';
                                            for (var i = 0; i < _fdObjE.length; i++) {
                                                if (_fdObjE[i].type == 'checkbox' && _fdObjE[i].checked) {
                                                    objVal += _fdObjE[i].nextSibling.innerText + ";"
                                                }
                                            }
                                        } else if (fdObjE.length > 0) {
                                            objVal = '';
                                            if (fdObjE[0].nodeName.toLowerCase() == 'select') {
                                                var index = fdObjE[0].selectedIndex;
                                                objVal = fdObjE[0].options[index].text;
                                            } else if (fdObjE[0].type == 'radio') {
                                                for (var i = 0; i < fdObjE.length; i++) {
                                                    if (fdObjE[i].type == 'radio' && fdObjE[i].checked) {
                                                        objVal = fdObjE[i].nextSibling.nodeValue ? fdObjE[i].nextSibling.nodeValue : fdObjE[i].nextSibling.innerText;
                                                    }
                                                }
                                            } else {
                                                objVal = fdObjE[0].value;
                                            }
                                        } else if (fdObjNameE.length > 0) {
                                            objVal = fdObjNameE[0].value;

                                        }
                                        result[o] = objVal;
                                    } else {
                                        if (o == 'content') {
                                            fdContent = objVal;
                                        }
                                    }
                                }
                            }

                            //文种
                            var fdDocTypeNameE = document.getElementsByName("fdDocTypeId");
                            var fdDocTypeName = ""
                            if (fdDocTypeNameE.length > 0) {
                                var index = fdDocTypeNameE[0].selectedIndex;
                                fdDocTypeName = fdDocTypeNameE[0].options[index].text;
                            } else {
                                fdDocTypeName = json['doctype'];
                                if (fdDocTypeName) {
                                    fdDocTypeName = fdDocTypeName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['doctype'] = fdDocTypeName;

                            //密级
                            var fdSecretGradeNameE = document.getElementsByName("fdSecretGradeId");
                            var fdSecretGradeName = "";
                            if (fdSecretGradeNameE.length > 0) {
                                var index = fdSecretGradeNameE[0].selectedIndex
                                fdSecretGradeName = fdSecretGradeNameE[0].options[index].text;
                            } else {
                                fdSecretGradeName = json['secretgrade'];
                                if (fdSecretGradeName) {
                                    fdSecretGradeName = fdSecretGradeName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['secretgrade'] = fdSecretGradeName;

                            //缓急
                            var fdEmergencyGradeNameE = document.getElementsByName("fdEmergencyGradeId");
                            var fdEmergencyGradeName = "";
                            if (fdEmergencyGradeNameE.length > 0) {
                                var index = fdEmergencyGradeNameE[0].selectedIndex
                                fdEmergencyGradeName = fdEmergencyGradeNameE[0].options[index].text;
                            } else {
                                fdEmergencyGradeName = json['emergency'];
                                if (fdEmergencyGradeName) {
                                    fdEmergencyGradeName = fdEmergencyGradeName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['emergency'] = fdEmergencyGradeName;

                            //标题
                            var docSubjectE = document.getElementsByName("docSubject");
                            var docSubject = "";
                            if (docSubjectE.length > 0 && docSubjectE[0].value != '') {
                                docSubject = docSubjectE[0].value;
                            } else {
                                docSubject = json['docsubject'];
                                if (docSubject) {
                                    docSubject = docSubject.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['docsubject'] = docSubject;

                            //备注
                            var fdContentE = document.getElementsByName("fdContent");
                            if (fdContentE.length > 0 && fdContentE[0].value != '') {
                                fdContent = fdContentE[0].value;
                            }
                            result['content'] = fdContent;

                            // 发文文号
                            var fdDocNumE = document.getElementsByName("fdDocNum");
                            var fdDocNum = "";
                            if (fdDocNumE.length > 0 && fdDocNumE[0].value != '') {
                                fdDocNum = fdDocNumE[0].value;
                            } else {
                                fdDocNum = json['docnum'];
                                if (fdDocNum) {
                                    fdDocNum = fdDocNum.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['docnum'] = fdDocNum;

                            var fdDocFlow = json['docflow'];
                            if (fdDocFlow) {
                                fdDocFlow = fdDocFlow.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                            }
                            result['docflow'] = fdDocFlow;

                            var fdCheckerNameE = document.getElementsByName("fdCheckerName");
                            var fdCheckerName = "";
                            if (fdCheckerNameE.length > 0 && fdCheckerNameE[0].value != '') {
                                fdCheckerName = fdCheckerNameE[0].value;
                            } else {
                                fdCheckerName = json['checker'];
                                if (fdCheckerName) {
                                    fdCheckerName = fdCheckerName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['checker'] = fdCheckerName;

                            var fdSignatureNameE = document.getElementsByName("fdSignatureName");
                            var fdSignatureName = "";
                            if (fdSignatureNameE.length > 0 && fdSignatureNameE[0].value != '') {
                                fdSignatureName = fdSignatureNameE[0].value;
                            } else {
                                fdSignatureName = json['signature'];
                                if (fdSignatureName) {
                                    fdSignatureName = fdSignatureName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['signature'] = fdSignatureName;

                            var fdDrafterNameE = document.getElementsByName("fdDrafterName");
                            var fdDrafterName = "";
                            if (fdDrafterNameE.length > 0 && fdDrafterNameE[0].value != '') {
                                fdDrafterName = fdDrafterNameE[0].value;
                            } else {
                                fdDrafterName = json['drafter'];
                                if (fdDrafterName) {
                                    fdDrafterName = fdDrafterName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['drafter'] = fdDrafterName;

                            // 起草时间
                            var fdDraftTimeE = document.getElementsByName("fdDraftTime");
                            var fdDraftTime = "";
                            if (fdDraftTimeE.length > 0 && fdDraftTimeE[0].value != '') {
                                fdDraftTime = fdDraftTimeE[0].value;
                            } else {
                                fdDraftTime = "<c:out value='${kmImissiveSendMainForm.fdDraftTime}'/>";
                            }
                            result['drafttime'] = fdDraftTime;

                            // 限办时间
                            var fdDeadTimeE = document.getElementsByName("fdDeadTime");
                            var fdDeadTime = "";
                            if (fdDeadTimeE.length > 0 && fdDeadTimeE[0].value != '') {
                                fdDeadTime = fdDeadTimeE[0].value;
                            } else {
                                fdDeadTime = "<c:out value='${kmImissiveSendMainForm.fdDeadTime}'/>";
                            }
                            result['deadtime'] = fdDeadTime;

                            //发文单位
                            var fdSendtoUnitNameE = document.getElementsByName("fdSendtoUnitName");
                            var fdSendtoUnitName = "";
                            if (fdSendtoUnitNameE.length > 0 && fdSendtoUnitNameE[0].value != '') {
                                fdSendtoUnitName = fdSendtoUnitNameE[0].value;
                            }
                            var unitName = fdSendtoUnitName;
                            var fdOtherSendUnitNamesE = document.getElementsByName("fdOtherSendUnitNames");
                            var fdOtherSendUnitNames = "";
                            if (fdOtherSendUnitNamesE.length > 0 && fdOtherSendUnitNamesE[0].value != '') {
                                fdOtherSendUnitNames = fdOtherSendUnitNamesE[0].value;
                            }
                            if (fdOtherSendUnitNames != '' && '${kmImissiveSendMainForm.fdIsJoint}' == '2') {
                                unitName += ";" + fdOtherSendUnitNames;
                            } else {
                                unitName = json['sendunit'];
                                if (unitName) {
                                    unitName = unitName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['sendunit'] = unitName;

                            //拟文单位
                            var fdDraftUnitNameE = document.getElementsByName("fdDraftUnitName");
                            var fdDraftUnitName = "";
                            if (fdDraftUnitNameE.length > 0 && fdDraftUnitNameE[0].value != '') {
                                fdDraftUnitName = fdDraftUnitNameE[0].value;
                            } else {
                                fdDraftUnitName = json['draftunit'];
                                if (fdDraftUnitName) {
                                    fdDraftUnitName = fdDraftUnitName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['draftunit'] = fdDraftUnitName;

                            //拟稿部门
                            var fdDraftDeptNameE = document.getElementsByName("fdDraftDeptName");
                            var fdDraftDeptName = "";
                            if (fdDraftDeptNameE.length > 0 && fdDraftDeptNameE[0].value != '') {
                                fdDraftDeptName = fdDraftDeptNameE[0].value;
                            } else {
                                fdDraftDeptName = json['draftdept'];
                                if (fdDraftDeptName) {
                                    fdDraftDeptName = fdDraftDeptName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['draftdept'] = fdDraftDeptName;

                            //主送
                            var fdMaintoNamesE = document.getElementsByName("fdMaintoNames");
                            var fdMaintoNames = "";
                            if (fdMaintoNamesE.length > 0 && fdMaintoNamesE[0].value != '') {
                                fdMaintoNames = fdMaintoNamesE[0].value;
                            } else {
                                fdMaintoNames = json['maintounit'];
                                if (fdMaintoNames) {
                                    fdMaintoNames = fdMaintoNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            //if(fdMaintoNames != ""){
                            //	fdMaintoNames = fdMaintoNames.replace(new RegExp(";",'g'),"、");
                            //}
                            result['maintounit'] = fdMaintoNames;

                            //抄送
                            var fdCopytoNamesE = document.getElementsByName("fdCopytoNames");
                            var fdMaintoNames = "";
                            if (fdCopytoNamesE.length > 0 && fdCopytoNamesE[0].value != '') {
                                fdCopytoNames = fdCopytoNamesE[0].value;
                            } else {
                                fdCopytoNames = json['copytounit'];
                                if (fdCopytoNames) {
                                    fdCopytoNames = fdCopytoNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            //if(fdCopytoNames != ""){
                            //	fdCopytoNames = fdCopytoNames.replace(new RegExp(";",'g'),"、");
                            //}
                            result['copytounit'] = fdCopytoNames;

                            //抄报
                            var fdReporttoNamesE = document.getElementsByName("fdReporttoNames");
                            var fdReporttoNames = "";
                            if (fdReporttoNamesE.length > 0 && fdReporttoNamesE[0].value != '') {
                                fdReporttoNames = fdReporttoNamesE[0].value;
                            } else {
                                fdReporttoNames = json['reporttounit'];
                                if (fdReporttoNames) {
                                    fdReporttoNames = fdReporttoNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            //if(fdReporttoNames != ""){
                            //	fdReporttoNames = fdReporttoNames.replace(new RegExp(";",'g'),"、");
                            //}
                            result['reporttounit'] = fdReporttoNames;

                            //主送个人
                            var fdMissiveMpersonNamesE = document.getElementsByName("fdMissiveMpersonNames");
                            var fdMissiveMpersonNames = "";
                            if (fdMissiveMpersonNamesE.length > 0 && fdMissiveMpersonNamesE[0].value != '') {
                                fdMissiveMpersonNames = fdMissiveMpersonNamesE[0].value;
                            } else {
                                fdMissiveMpersonNames = json['maintoperson'];
                                if (fdMissiveMpersonNames) {
                                    fdMissiveMpersonNames = fdMissiveMpersonNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            //if(fdMissiveMpersonNames != ""){
                            //	fdMissiveMpersonNames = fdMissiveMpersonNames.replace(new RegExp(";",'g'),"、");
                            //}
                            result['maintoperson'] = fdMissiveMpersonNames;

                            //抄送个人
                            var fdMissiveCpersonNamesE = document.getElementsByName("fdMissiveCpersonNames");
                            var fdMissiveCpersonNames = "";
                            if (fdMissiveCpersonNamesE.length > 0 && fdMissiveCpersonNamesE[0].value != '') {
                                fdMissiveCpersonNames = fdMissiveCpersonNamesE[0].value;
                            } else {
                                fdMissiveCpersonNames = json['copytoperson'];
                                if (fdMissiveCpersonNames) {
                                    fdMissiveCpersonNames = fdMissiveCpersonNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            //if(fdMissiveCpersonNames != ""){
                            //	fdMissiveCpersonNames = fdMissiveCpersonNames.replace(new RegExp(";",'g'),"、");
                            //}
                            result['copytoperson'] = fdMissiveCpersonNames;

                            //抄报个人
                            var fdMissiveRpersonNamesE = document.getElementsByName("fdMissiveRpersonNames");
                            var fdMissiveRpersonNames = "";
                            if (fdMissiveRpersonNamesE.length > 0 && fdMissiveRpersonNamesE[0].value != '') {
                                fdMissiveRpersonNames = fdMissiveRpersonNamesE[0].value;
                            } else {
                                fdMissiveRpersonNames = json['reporttoperson'];
                                if (fdMissiveRpersonNames) {
                                    fdMissiveRpersonNames = fdMissiveRpersonNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            //if(fdMissiveRpersonNames != ""){
                            //	fdMissiveRpersonNames = fdMissiveRpersonNames.replace(new RegExp(";",'g'),"、");
                            //}
                            result['reporttoperson'] = fdMissiveRpersonNames;

                            //签发日期（大写）
                            var docPublishTimeUpperE = document.getElementsByName("docPublishTimeUpper");
                            var docPublishTimeUpper = "";
                            if (docPublishTimeUpperE.length > 0 && docPublishTimeUpperE[0].value != '') {
                                docPublishTimeUpper = docPublishTimeUpperE[0].value;
                            } else {
                                docPublishTimeUpper = "<c:out value='${kmImissiveSendMainForm.docPublishTimeUpper}'/>";
                            }
                            result['signdatecn'] = docPublishTimeUpper;

                            //签发日期
                            var docPublishTimeNumE = document.getElementsByName("docPublishTimeNum");
                            var docPublishTimeNum = "";
                            if (docPublishTimeNumE.length > 0 && docPublishTimeNumE[0].value != '') {
                                docPublishTimeNum = docPublishTimeNumE[0].value;
                            } else {
                                docPublishTimeNum = "<c:out value='${kmImissiveSendMainForm.docPublishTimeNum}'/>";
                            }
                            result['signdate'] = docPublishTimeNum;

                            //签发日期
                            var docPublishTimeE = document.getElementsByName("docPublishTime");
                            var docPublishTime = "";
                            if (docPublishTimeE.length > 0 && docPublishTimeE[0].value != '') {
                                docPublishTime = docPublishTimeE[0].value;
                                //异步更新签发日期大写书签
                                var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=transferTime";
                                $.ajax({
                                    type: "post",
                                    dataType: "json",
                                    url: url,
                                    data: {filed: 'docPublishTime', docPublishTime: docPublishTime},
                                    async: false,    //用同步方式
                                    success: function (rtn) {
                                        if (rtn['docPublishTimeUpper']) {
                                            result['signdatecn'] = rtn['docPublishTimeUpper'];
                                        }
                                        if (rtn['docPublishTimeNum']) {
                                            result['signdate'] = rtn['docPublishTimeNum'];
                                        }
                                    }
                                });
                            } else {
                                docPublishTime = "<c:out value='${kmImissiveSendMainForm.docPublishTime}'/>";
                            }
                            result['signdaten'] = docPublishTime;

                            //打印份数
                            var fdPrintNumE = document.getElementsByName("fdPrintNum");
                            var fdPrintNum = "";
                            if (fdPrintNumE.length > 0 && fdPrintNumE[0].value != '') {
                                fdPrintNum = fdPrintNumE[0].value;
                            } else {
                                fdPrintNum = "<c:out value='${kmImissiveSendMainForm.fdPrintNum}'/>";
                            }
                            result['printnum'] = fdPrintNum;

                            //打印页数
                            var fdPrintPageNumE = document.getElementsByName("fdPrintPageNum");
                            var fdPrintPageNum = "";
                            if (fdPrintPageNumE.length > 0 && fdPrintPageNumE[0].value != '') {
                                fdPrintPageNum = fdPrintPageNumE[0].value;
                            } else {
                                fdPrintPageNum = "<c:out value='${kmImissiveSendMainForm.fdPrintPageNum}'/>";
                            }
                            result['printpagenum'] = fdPrintPageNum;

                            //印发单位
                            var fdPrintUnitNameE = document.getElementsByName("fdPrintUnitName");
                            var fdPrintUnitName = "";
                            if (fdPrintUnitNameE.length > 0 && fdPrintUnitNameE[0].value != '') {
                                fdPrintUnitName = fdPrintUnitNameE[0].value;
                            } else {
                                fdPrintUnitName = json['printunit'];
                                if (fdPrintUnitName) {
                                    fdPrintUnitName = fdPrintUnitName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['printunit'] = fdPrintUnitName;

                            //印发时间
                            var fdPrintTimeNumE = document.getElementsByName("fdPrintTimeNum");
                            var fdPrintTimeNum = "";
                            if (fdPrintTimeNumE.length > 0 && fdPrintTimeNumE[0].value != '') {
                                fdPrintTimeNum = fdPrintTimeNumE[0].value;
                            } else {
                                fdPrintTimeNum = "<c:out value='${kmImissiveSendMainForm.fdPrintTimeNum}'/>";
                            }
                            result['printtime'] = fdPrintTimeNum;

                            //印发时间大写
                            var fdPrintTimeUpperE = document.getElementsByName("fdPrintTimeUpper");
                            var fdPrintTimeUpper = "";
                            if (fdPrintTimeUpperE.length > 0 && fdPrintTimeUpperE[0].value != '') {
                                fdPrintTimeUpper = fdPrintTimeUpperE[0].value;
                            } else {
                                fdPrintTimeUpper = "<c:out value='${kmImissiveSendMainForm.fdPrintTimeUpper}'/>";
                            }
                            result['printtimecn'] = fdPrintTimeUpper;

                            //印发时间
                            var fdPrintTimeE = document.getElementsByName("fdPrintTime");
                            var fdPrintTime = "";
                            if (fdPrintTimeE.length > 0 && fdPrintTimeE[0].value != '') {
                                fdPrintTime = fdPrintTimeE[0].value;
                                //异步更新签发日期大写书签
                                var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=transferTime";
                                $.ajax({
                                    type: "post",
                                    dataType: "json",
                                    url: url,
                                    data: {filed: 'fdPrintTime', fdPrintTime: fdPrintTime},
                                    async: false,    //用同步方式
                                    success: function (rtn) {
                                        if (rtn['fdPrintTimeUpper']) {
                                            result['fdPrintTimeUpper'] = rtn['fdPrintTimeUpper'];
                                        }
                                        if (rtn['fdPrintTimeNum']) {
                                            result['printtime'] = rtn['fdPrintTimeNum'];
                                        }
                                    }
                                });
                            } else {
                                fdPrintTime = "<c:out value='${kmImissiveSendMainForm.fdPrintTime}'/>";
                            }
                            result['printtimen'] = fdPrintTime;

                            //发布层次
                            var fdLevelE = document.getElementsByName("fdLevel");
                            var fdLevel = "";
                            if (fdLevelE.length > 0 && fdLevelE[0].value != '') {
                                fdLevel = fdLevelE[0].value;
                            } else {
                                fdLevel = json['level'];
                                if (fdLevel) {
                                    fdLevel = fdLevel.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['level'] = fdLevel;

                            //版本
                            var fdVersionE = document.getElementsByName("fdVersion");
                            var fdVersion = "";
                            if (fdVersionE.length > 0 && fdVersionE[0].value != '') {
                                fdVersion = fdVersionE[0].value;
                            } else {
                                fdVersion = json['version'];
                                if (fdVersion) {
                                    fdVersion = fdVersion.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['version'] = fdVersion;

                            //保密期限
                            var fdSecretYearE = document.getElementsByName("fdSecretYear");
                            var fdSecretYear = "";
                            if (fdSecretYearE.length > 0 && fdSecretYearE[0].value != '') {
                                fdSecretYear = fdSecretYearE[0].value;
                            } else {
                                fdSecretYear = json['secretyear'];
                                if (fdSecretYear) {
                                    fdSecretYear = fdSecretYear.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['secretyear'] = fdSecretYear;

                            //备用1
                            var fdReserveOneE = document.getElementsByName("fdReserveOne");
                            var fdReserveOne = "";
                            if (fdReserveOneE.length > 0 && fdReserveOneE[0].value != '') {
                                fdReserveOne = fdReserveOneE[0].value;
                            } else {
                                fdReserveOne = json['reserveone'];
                                if (fdReserveOne) {
                                    fdReserveOne = fdReserveOne.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['reserveone'] = fdReserveOne;

                            //备用2
                            var fdReserveTwoE = document.getElementsByName("fdReserveTwo");
                            var fdReserveTwo = "";
                            if (fdReserveTwoE.length > 0 && fdReserveTwoE[0].value != '') {
                                fdReserveTwo = fdReserveTwoE[0].value;
                            } else {
                                fdReserveTwo = json['reservetwo'];
                                if (fdReserveTwo) {
                                    fdReserveTwo = fdReserveTwo.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['reservetwo'] = fdReserveTwo;

                            //备用3
                            var fdReserveThreeE = document.getElementsByName("fdReserveThree");
                            var fdReserveThree = "";
                            if (fdReserveThreeE.length > 0 && fdReserveThreeE[0].value != '') {
                                fdReserveThree = fdReserveThreeE[0].value;
                            } else {
                                fdReserveThree = json['reservethree'];
                                if (fdReserveThree) {
                                    fdReserveThree = fdReserveThree.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['reservethree'] = fdReserveThree;

                            //备用4
                            var fdReserveFourE = document.getElementsByName("fdReserveFour");
                            var fdReserveFour = "";
                            if (fdReserveFourE.length > 0 && fdReserveFourE[0].value != '') {
                                fdReserveFour = fdReserveFourE[0].value;
                            } else {
                                fdReserveFour = json['reservefour'];
                                if (fdReserveFour) {
                                    fdReserveFour = fdReserveFour.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['reservefour'] = fdReserveFour;

                            //备用5
                            var fdReserveFiveE = document.getElementsByName("fdReserveFive");
                            var fdReserveFive = "";
                            if (fdReserveFiveE.length > 0 && fdReserveFiveE[0].value != '') {
                                fdReserveFive = fdReserveFiveE[0].value;
                            } else {
                                fdReserveFive = json['reservefive'];
                                if (fdReserveFive) {
                                    fdReserveFive = fdReserveFive.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
                                }
                            }
                            result['reservefive'] = fdReserveFive;
                            //return result;
                            return JSON.stringify(result);
                        }

                        var books = addBookMarksByWpsCenter();
                        console.log(books);

                        var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=loadWpsHeadWordList";
                        $.ajax({
                            url:url,
                            type:"post",
                            data:{books:books,fdKey:attKey,fdId:"${param.fdId}",nodeName:"${nodevalue}",fdTemplateModelId:selAttId},
                            async:false,    //用同步方式
                            success:function(data){
                            	var results = eval("(" + data + ")");
                                var fdTaskId = "";
                                if (results['wpsId'] != "") {
                                    fdTaskId = results['wpsId'];
                                }
                                if(results.wpsId){
                                    seajs.use(['lui/jquery','lui/dialog'], function($, dialog){
                                        var loading=dialog.loading("正在套红中,请稍候...");
                                        setTimeout(function(){
                                        	wpsCenterSetRedResult(60);
                                        }, 2000);
                                        function wpsCenterSetRedResult(count){
                                            var ajaxUrl = Com_Parameter.ContextPath+"km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getSetRedResult&fdId=${JsParam.fdId}&fdKey="+attKey;
                                            $.ajax({
                                                url : ajaxUrl,
                                                type : 'post',
                                                data : {fdTaskId:fdTaskId},
                                                dataType : 'text',
                                                async : true,
                                                error : function(){
                                                    dialog.alert('请求出错');
                                                } ,
                                                success : function(data) {
                                                    if(data == "true"){
                                                        loading.hide();
                                                        dialog.alert("套红成功",function(){
                                                            if(LUI("tabpanelDiv")){
                                                                var contents = LUI("tabpanelDiv").contents;
                                                                for(var i = 0;i< contents.length;i++){
                                                                    if(contents[i].id == "attContent"){
                                                                        LUI("tabpanelDiv").setSelectedIndex(i);
                                                                    }
                                                                }
                                                            }
                                                            if(attKey == 'editonline'){
                                                                wps_center_editonline.forceLoad = true;
                                                                wps_center_editonline.load();
                                                            }else if (attKey == 'mainonline'){
                                                                wps_center_mainonline.forceLoad = true;
                                                                wps_center_mainonline.load();
                                                            }
                                                            redheadFlag = true;
                                                            // 创建撤销套红的摁扭
                                                            createRevokeRedHeadBtn();
                                                        });
                                                    }else{
                                                        if(count<0){
                                                        	loading.hide();
                                                            dialog.alert("套红失败");
                                                        }else{
                                                        	setTimeout(function(){
                                                            	wpsCenterSetRedResult(count-1);
                                                            }, 2000);
                                                        }
                                                    	
                                                    }
                                                }
                                            });
                                        }
                                    });
                                }else{
                                	alert(results.error)
                                }
                            }

                        });
                    } else {//取消
                        return
                    }
                } catch (err) {
                }
            }, true, '<bean:message bundle="km-imissive" key="kmImissiveRedheadset.select"/>');
        }
    }


    //选择发文红头模板
    function LoadHeadWordList(fdModelName, attKey) {
        var JGWebOffice;
        var flag = true;
        if (flag) {
            var lock = true;//#169596防止多次点击
            Dialog_SimpleCategoryForNewFile("com.landray.kmss.km.imissive.model.KmImissiveRedHeadTemplate", "createUrl?&fdTemplateId=!{id}&fdTemplateName=!{name}", false, true, "02", function (rtnVal) {
                var selAttId = rtnVal[0].id;
                if (Attachment_ObjectInfo[attKey]) {
                    JGWebOffice = Attachment_ObjectInfo[attKey].ocxObj;
                }
                try {
                    if (selAttId != null) {
                        if(!lock){
                            console.log("请勿重复提交");
                            return;
                        }
                        lock = false;
                        var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=generate2Id";
                        $.ajax({
                            url: url,
                            async: false,    //用同步方式
                            success: function (data) {
                                results = eval("(" + data + ")");
                                if (results['id1'] != "" && results['id2'] != "") {
                                    var rFlag = false;
                                    if (JGWebOffice) {
                                        //信创环境下需要先进行一下暂存操作，金格的问题，暂时查不出什么原因
                                        var saveA = document.getElementsByName(attKey+"_saveDraft")[0];
                                        if(saveA != null && saveA != undefined){
                                            saveA.click();
                                        }
                                        JGWebOffice.WebSetMsgByName("COMMAND", "REVISIONDRAFT");
                                        JGWebOffice.WebSetMsgByName("_modelName", "com.landray.kmss.km.imissive.model.KmImissiveAttTrack");
                                        JGWebOffice.WebSetMsgByName("_key", "redheadAtt");
                                        JGWebOffice.WebSetMsgByName("_fdId", results['id1']);
                                        JGWebOffice.AllowEmpty = true;//内容为空默认不校验
                                        //保存痕迹稿
                                        rFlag = JGWebOffice.WebSave();
                                        if (rFlag) {
                                            if (saveAttTrack(JGWebOffice.WebGetMsgByName("fd_fileId"), JGWebOffice.WebGetMsgByName("fd_fileName"), "4", "${nodevalue}")) {
                                                JGWebOffice.WebSetMsgByName("COMMAND", "NODRAFT");
                                                JG_UseTemplate(JGWebOffice, selAttId, fdModelName, attKey); //确定套红
                                            }
                                        }
                                    }
                                }
                            }
                        });
                    } else {//取消
                        return
                    }
                } catch (err) {
                    JGWebOffice.WebOpen();//恢复主文档的正文
                }
            }, true, '<bean:message bundle="km-imissive" key="kmImissiveRedheadset.select"/>');

        }
    }

    //调用数据库中的发文红头模板。
    function JG_UseTemplate(JGWebOffice, selAttId, fdModelName, attKey) {
        JGWebOffice.WebSetMsgByName("_fdTemplateModelId", selAttId);
        JGWebOffice.WebSetMsgByName("_fdTemplateModelName", "com.landray.kmss.km.imissive.model.KmImissiveRedHeadTemplate");
        JGWebOffice.WebSetMsgByName("_fdTemplateKey", "editonline");
        if (JGWebOffice.WebLoadTemplate()) {   //交互OfficeServer的OPTION="LOADTEMPLATE"
            window.setTimeout(function () {
                JG_insertFile(JGWebOffice, fdModelName, attKey);
            }, 1000); //暂停下否则加载报错
        } else {
            alert("<bean:message bundle='km-imissive' key='kmImissiveRedheadset.open.error'/>");//打开模板失败
            return false;
        }
    }

    //②把正文文档插入到模板的书签位置。
    function JG_insertFile(JGWebOffice, fdModelName, attKey) {
        //JGWebOffice.WebShow(true);
        JGWebOffice.WebSetMsgByName("_fdId", '${JsParam.fdId}');
        JGWebOffice.WebSetMsgByName("_fdModelName", fdModelName);
        JGWebOffice.WebSetMsgByName("_fdKey", attKey);
        redheadFlag = "true";
        JGWebOffice.WebInsertFile();   //填充公文正文 交互OfficeServer的OPTION="INSERTFILE"
        window.setTimeout(function () {
            addRedHeadBookMarks(attKey);
            if ("${forceRevisions}" == 'false') {
                JGWebOffice.WebSetRevision(false, true, true, true);
            } else {
                JGWebOffice.ClearRevisions();
                JGWebOffice.WebSetRevision(Attachment_ObjectInfo[attKey].showRevisions, true, true, true);
            }
        }, 500); //暂停下否则加载报错,替换书签内容
        //设置是否显示留痕
    }

    /**
     * 创建撤回套红的摁扭
     */
    function createRevokeRedHeadBtn() {
        if ($('a#revokeRedHead').length == 0) {
            let btnText = '<a href="javascript:void(0);" class="revertOfficialSmart"' +
                ' id="revokeRedHead" onclick="revokeContentChange' +
                '(&quot;4&quot;,&quot;send&quot;)">撤销套红</a>';
            $('div#missiveButtonDiv').prepend(btnText);
        }
    }
</script>
