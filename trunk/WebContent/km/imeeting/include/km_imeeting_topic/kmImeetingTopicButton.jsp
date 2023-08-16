<%@page import="com.landray.kmss.util.UserUtil" %>
<%@ page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil" %>
<%@ page import="com.landray.kmss.km.imeeting.util.KmImeetingTopicUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/resource/jsp/common.jsp" %>
<%
    request.setAttribute("fdCurUserId", UserUtil.getKMSSUser().getUserId());
    if (SysAttWpsCenterUtil.isEnable()) {
        pageContext.setAttribute("wpsType", "center");
    } else if (KmImeetingTopicUtil.isEnableWpsCloud()) {
        pageContext.setAttribute("wpsType", "cloud");
    }
%>
<c:set var="imissiveFormObj" value="${requestScope[param.formName]}"/>
<!-- 纳入议题 -->
<ui:button order="4" text="纳入议题" onclick="incorporateTopic('${param.fdId}', '${param.fdModelName}');"/>

<script>
    seajs.use(['lui/dialog', 'lui/jquery'], function (dialog, $) {

        window.incorporateTopic = function (fdModelId, fdModelName) {

            if (!fdModelId || !fdModelName) {
                return;
            }

            var topicInfo = getTopicInfo(fdModelId, fdModelName);
            // 该公文已纳入过议题则打开第一次纳入保存对的议题草稿，否则新建议题
            if (topicInfo.topicId) {
                var fdTopicUrl = '${LUI_ContextPath}/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=editIncorporate&fdId=' + topicInfo.topicId;
                window.open(fdTopicUrl);
            } else {
                var wpsObject = getWpsObj();
                if (wpsObject != null) {
                    if (!wpsObject.hasLoad) {
                        dialog.alert("当前正文内容未加载，请切换到正文页签加载正文后操作！");
                        return;
                    }
                    // 编辑模式才需要保存一下
                    if (wpsObject.fdMode === 'write') {
                        var savePromise = wpsObject.wpsObj.save();
                        savePromise.then(function (rtn) {
                            createTopic('是否纳入议题');
                        });
                    } else {
                        createTopic('是否纳入议题');
                    }

                } else {
                    createTopic("若系统附件预览使用WPS，当前正文内容未加载，请切换到正文页签加载正文后操作。" +
                        "若使用金格控件预览，则当前在线编辑之后的内容无法实时保存，纳入议题之后的正文附件内容可能与当前正文有所差异。" +
                        "请确认是否继续纳入议题操作？");
                }
            }

            // 新增议题弹出框
            function createTopic(text) {
                dialog.confirm(text, function (value) {
                    if (value) {
                        dialog.simpleCategoryForNewFile(
                            'com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory',
                            '/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=add&fdTemplateId=!{id}&fdModelId='
                            + fdModelId + '&fdModelName=' + fdModelName, false, null, null, null
                        );
                    }
                });
            }
        };

        function getTopicInfo(fdModelId, fdModelName) {
            var topicInfo = {};
            var url = '${LUI_ContextPath}/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=getTopicInfoForOther';
            if (fdModelId && fdModelName) {
                $.ajax({
                    url: url,
                    type: 'POST',
                    data: {
                        fdModelId: fdModelId,
                        fdModelName: fdModelName
                    },
                    async: false,
                    success: function (result) {
                        result = eval('(' + result + ')');
                        if (result != null) {
                            topicInfo.topicId = result.topicId;
                            topicInfo.docCreatorId = result.docCreatorId;
                        }
                    }
                });
            }
            return topicInfo;
        }

        /**
         * 获取WPS对象
         */
        function getWpsObj() {
            let fdKey = "${imissiveFormObj.fdNeedContent}" == "0" ? "mainonline" : "editonline";
            let wpsType = "${wpsType}"
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
    });
</script>