<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- 附件预览区域 --%>
<script>
    Com_IncludeFile("jquery.js");
</script>
<script>
    $(document).ready(function () {
        if ("${kmImeetingSchemeForm.docStatus}" == "20"
            && "${kmImeetingSchemeForm.method_GET}" === "view") {
            initContentAtt();
        }
    });

    function initContentAtt() {
        let previewAttFrameHeight = $(window).height() * 0.82;
        if ($('#previewAttFrame')) {
            $('#previewAttFrame').height((previewAttFrameHeight) + "px");
        }
        var methodGet = "${kmImeetingSchemeForm.method_GET}";
        let scheme = "kmImeetingScheme";
        if (methodGet === "view") {
            scheme += "_${kmImeetingSchemeForm.fdId}";
        }
        if (Attachment_ObjectInfo[scheme]) {
            // 附件列表
            var fileList = Attachment_ObjectInfo[scheme].fileList;
            console.log(fileList);
            // 最新上传的附件索引
            let index = fileList.length - 1;
            // fileList[index].fileStatus: 最新上传的附件状态 -1是删除状态
            if (index >= 0 && fileList[index].fileStatus != -1) {
                // 最新附件ID
                let attMainId = fileList[index].fdId;
                // imeetingScheme_sysAttMainId记录的最新附件mainId;更换了附件才重新加载
                if (window.imeetingScheme_sysAttMainId != attMainId) {
                    window.imeetingScheme_sysAttMainId = attMainId;
                    var path = "${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain.do?method=view&inner=yes&fdId=" + attMainId;
                    $('#previewAttFrame').attr("src", path);
                }
            } else {
                $('#previewAttFrame').attr("src", "${LUI_ContextPath}/km/imeeting/km_imeeting_scheme/import/preview_noDataM.jsp");
            }
        }
    }

    function attachmentPreview(swfObj, attId) {
        console.log("ewrwerqwe")
        var methodGet = "${kmImeetingSchemeForm.method_GET}";
        var fdKey = '';
        if (methodGet == "view" || methodGet == "edit") {
            var objKey = swfObj.fdKey;
            fdKey = objKey.startsWith("kmImeetingScheme");
        } else {
            fdKey = swfObj.fdKey == 'kmImeetingScheme';
        }
        if (fdKey) {
            var panel = LUI('tabpanelDiv');
            for (var i = 0; i < panel.contents.length; i++) {
                if (panel.contents[i].id == "attPreview") {
                    panel.setSelectedIndex(i);
                }
            }
            var contentH = $('.content').height();
            //新上传的附件，如果已经未生成attMain，则给出预览提示
            if (attId.indexOf("WU_FILE") >= 0) {
                var url = "${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain_preview_noDataS.jsp"
                $('#attachment_preview iframe').attr('src', url).load(function () {
                    $('#attachment_preview iframe').css('height', (800) + 'px');
                });

            } else {
                $('#attachment_preview').css('height', (800) + 'px').show();
                var url = swfObj.getUrl("view", attId);
                var jg_height = 800; //金格的高度
                if (url) {
                    url += "&inner=yes&showBar=false&attHeight=" + jg_height;
                    $('#attachment_preview iframe').attr('src', url).load(function () {
                        $('#attachment_preview iframe').css('height', 800 + 'px');
                    });
                }
            }
        } else {
            var doc = swfObj.getDoc(attId);
            var url = swfObj.getUrl("view", attId);
            if (swfObj.fdForceUseJG) {
                url += "&fdForceUseJG=true"
            }
            Com_OpenWindow(url, "_blank");
        }

    }

    <c:if test="${param.approveModel ne 'right'}">
        if (typeof window.previewEvn == "undefined") {
            top.window.previewEvn = {
                previewEventsCache: {},
                on: function (event, callback) {
                    if (!callback) return this;
                    var list = this.previewEventsCache[event] || (this.previewEventsCache[event] = []);
                    list.push(callback);
                    return this;
                },
                off: function (event, callback) {
                    if (!(event || callback)) {
                        this.previewEventsCache = {};
                        return this;
                    }
                    var list = this.previewEventsCache[event];
                    if (list) {
                        if (callback) {
                            for (var i = list.length - 1; i >= 0; i--) {
                                if (list[i] === callback) {
                                    list.splice(i, 1);
                                }
                            }
                        } else {
                            delete this.previewEventsCache[event];
                        }
                    }
                    return this;
                },
                emit: function (event, data) {
                    var list = this.previewEventsCache[event];
                    var fn;
                    if (list) {
                        for (var i = 0; i < list.length; i++) {
                            list[i](data);
                        }
                    }
                    return this;
                }
            };
        }

        window.previewEvn.on("uploadSuccess", function (data) {
            initAttContentOnEvent();
        });

        window.previewEvn.on("editDelete", function (data) {
            initAttContentOnEvent();
        });

        function initAttContentOnEvent() {
            let attPreviewUiObj = LUI('attPreview');
            if (attPreviewUiObj.isShow) {
                initContentAtt();
            }
        }
    </c:if>

</script>

